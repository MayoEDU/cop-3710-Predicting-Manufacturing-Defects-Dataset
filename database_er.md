### <u>Database Application</u>

This project uses a vast amount of data, thus oracle and datagrip will be used to manage it all and use the large dataset provided by Kaggle.
Oracle will be acting as the backend while DataGrip will be used for the design, execution, and exploration of the data.

<img width="2431" height="1218" alt="PartB" src="https://github.com/user-attachments/assets/b8accc3e-4554-46fb-a961-7a93360bac05" />

### <u>Relational Schema</u>

Plant(PlantID PK, PlantName, City, State)
ProductionLine(LineID PK, PlantID FK, LineName, LineType)
Machine(MachineID PK, LineID FK, SerialNumber, Model)
MachineSpec(MachineID PK/FK, MaxThroughput, PowerRating)
Supplier(SupplierID PK, SupplierName, ContactEmail)
SupplierPhone(SupplierID PK/FK, PhoneNumber PK)
ProductionRun(RunID PK, LineID FK, RunTimestamp, ProductionVolume, ProductionCost, SupplierQuality, DeliveryDelay, DefectRate, QualityScore, MaintenanceHours, DowntimePercentage, InventoryTurnover, StockoutRate, WorkerProductivity, SafetyIncidents, EnergyConsumption, EnergyEfficiency, AdditiveProcessTime, AdditiveMaterialCost, DefectStatus)
RunSupplier(RunID PK/FK, SupplierID PK/FK, MaterialLot, MaterialCost, OnTimeDelivery)
DefectType(DefectTypeID PK, TypeName, Description)
DefectInstance(RunID PK/FK, DefectSeq PK, DefectTypeID FK, Severity, DetectedAt)
Employee(EmployeeID PK, FullName, Role)
Inspection(InspectionID PK, RunID FK, EmployeeID FK, InspectedAt, Notes)
