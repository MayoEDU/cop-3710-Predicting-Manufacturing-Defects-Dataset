BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Inspection CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE DefectInstance CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RunSupplier CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE MachineSpec CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE ProductionRun CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Machine CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE ProductionLine CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE SupplierPhone CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Supplier CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE DefectType CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Employee CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Plant CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE Plant (
    PlantID        NUMBER(10)    PRIMARY KEY,
    PlantName      VARCHAR2(100) NOT NULL,
    City           VARCHAR2(60),
    State          VARCHAR2(30)
);

CREATE TABLE ProductionLine (
    LineID         NUMBER(10)    PRIMARY KEY,
    PlantID        NUMBER(10)    NOT NULL,
    LineName       VARCHAR2(100) NOT NULL,
    LineType       VARCHAR2(50),
    CONSTRAINT fk_line_plant
        FOREIGN KEY (PlantID) REFERENCES Plant(PlantID)
);

CREATE TABLE Machine (
    MachineID      NUMBER(10)    PRIMARY KEY,
    LineID         NUMBER(10)    NOT NULL,
    SerialNumber   VARCHAR2(80)  NOT NULL,
    Model          VARCHAR2(80)  NOT NULL,
    CONSTRAINT uq_machine_serial UNIQUE (SerialNumber),
    CONSTRAINT fk_machine_line
        FOREIGN KEY (LineID) REFERENCES ProductionLine(LineID)
);

CREATE TABLE MachineSpec (
    MachineID       NUMBER(10)   PRIMARY KEY,
    MaxThroughput   NUMBER(10)   NOT NULL,
    PowerRating     VARCHAR2(40),
    CONSTRAINT fk_mspec_machine
        FOREIGN KEY (MachineID) REFERENCES Machine(MachineID)
);

CREATE TABLE Supplier (
    SupplierID      NUMBER(10)    PRIMARY KEY,
    SupplierName    VARCHAR2(100) NOT NULL,
    ContactEmail    VARCHAR2(120)
);

CREATE TABLE SupplierPhone (
    SupplierID      NUMBER(10)   NOT NULL,
    PhoneNumber     VARCHAR2(25) NOT NULL,
    CONSTRAINT pk_supplier_phone PRIMARY KEY (SupplierID, PhoneNumber),
    CONSTRAINT fk_sphone_supplier
        FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE DefectType (
    DefectTypeID    NUMBER(10)    PRIMARY KEY,
    TypeName        VARCHAR2(60)  NOT NULL,
    Description     VARCHAR2(200)
);

CREATE TABLE Employee (
    EmployeeID      NUMBER(10)    PRIMARY KEY,
    FullName        VARCHAR2(100) NOT NULL,
    Role            VARCHAR2(60)  NOT NULL
);

CREATE TABLE ProductionRun (
    RunID                    NUMBER(10)    PRIMARY KEY,
    LineID                   NUMBER(10)    NOT NULL,
    RunTimestamp             TIMESTAMP     NOT NULL,
    ProductionVolume         NUMBER(12,2),
    ProductionCost           NUMBER(12,2),
    SupplierQuality          NUMBER(5,2),
    DeliveryDelay            NUMBER(8,2),
    DefectRate               NUMBER(8,4),
    QualityScore             NUMBER(5,2),
    MaintenanceHours         NUMBER(8,2),
    DowntimePercentage       NUMBER(8,2),
    InventoryTurnover        NUMBER(8,2),
    StockoutRate             NUMBER(8,2),
    WorkerProductivity       NUMBER(8,2),
    SafetyIncidents          NUMBER(6),
    EnergyConsumption        NUMBER(12,2),
    EnergyEfficiency         NUMBER(8,2),
    AdditiveProcessTime      NUMBER(8,2),
    AdditiveMaterialCost     NUMBER(12,2),
    DefectStatus             VARCHAR2(30),
    CONSTRAINT fk_prun_line
        FOREIGN KEY (LineID) REFERENCES ProductionLine(LineID),
    CONSTRAINT ck_prun_defectstatus
        CHECK (DefectStatus IN ('Low', 'Medium', 'High', 'Critical', 'No Defect', 'Defect'))
);

CREATE TABLE RunSupplier (
    RunID            NUMBER(10)    NOT NULL,
    SupplierID       NUMBER(10)    NOT NULL,
    MaterialLot      VARCHAR2(60)  NOT NULL,
    MaterialCost     NUMBER(12,2)  NOT NULL,
    OnTimeDelivery   NUMBER(1)     NOT NULL,
    CONSTRAINT pk_runsupplier PRIMARY KEY (RunID, SupplierID),
    CONSTRAINT fk_rs_run
        FOREIGN KEY (RunID) REFERENCES ProductionRun(RunID),
    CONSTRAINT fk_rs_supplier
        FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    CONSTRAINT ck_rs_ontime CHECK (OnTimeDelivery IN (0,1))
);

CREATE TABLE DefectInstance (
    RunID            NUMBER(10)    NOT NULL,
    DefectSeq        NUMBER(10)    NOT NULL,
    DefectTypeID     NUMBER(10)    NOT NULL,
    Severity         VARCHAR2(30)  NOT NULL,
    DetectedAt       TIMESTAMP,
    CONSTRAINT pk_defectinstance PRIMARY KEY (RunID, DefectSeq),
    CONSTRAINT fk_di_run
        FOREIGN KEY (RunID) REFERENCES ProductionRun(RunID),
    CONSTRAINT fk_di_dtype
        FOREIGN KEY (DefectTypeID) REFERENCES DefectType(DefectTypeID),
    CONSTRAINT ck_di_severity
        CHECK (Severity IN ('Low', 'Medium', 'High', 'Critical'))
);

CREATE TABLE Inspection (
    InspectionID     NUMBER(10)    PRIMARY KEY,
    RunID            NUMBER(10)    NOT NULL,
    EmployeeID       NUMBER(10)    NOT NULL,
    InspectedAt      TIMESTAMP     NOT NULL,
    Notes            VARCHAR2(250),
    CONSTRAINT fk_insp_run
        FOREIGN KEY (RunID) REFERENCES ProductionRun(RunID),
    CONSTRAINT fk_insp_emp
        FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
