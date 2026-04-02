import pandas as pd
import os
import random

random.seed(7)

df = pd.read_csv("manufacturing_defect_dataset.csv")
df.columns = [c.strip() for c in df.columns]

if not os.path.exists("data"):
    os.makedirs("data")


plant = pd.DataFrame([
    [1, "Lakeland Plant", "Lakeland", "FL"],
    [2, "Orlando Plant", "Orlando", "FL"],
    [3, "Tampa Plant", "Tampa", "FL"]
], columns=["PlantID","PlantName","City","State"])

line = pd.DataFrame([
    [1,1,"Line A","Assembly"],
    [2,1,"Line B","Packaging"],
    [3,2,"Line C","Assembly"],
    [4,2,"Line D","Casting"],
    [5,3,"Line E","Finishing"],
    [6,3,"Line F","Packaging"]
], columns=["LineID","PlantID","LineName","LineType"])

machine = []
machinespec = []

mid = 1
for l in line["LineID"]:
    for i in range(2):
        machine.append([mid, l, "SN"+str(mid), "Model"+str(mid)])
        machinespec.append([mid, 200+mid*5, "30kW"])
        mid += 1

machine = pd.DataFrame(machine, columns=["MachineID","LineID","SerialNumber","Model"])
machinespec = pd.DataFrame(machinespec, columns=["MachineID","MaxThroughput","PowerRating"])

supplier = pd.DataFrame([
    [1,"Alpha","a@a.com"],
    [2,"Beta","b@b.com"],
    [3,"Core","c@c.com"],
    [4,"Delta","d@d.com"],
    [5,"Ever","e@e.com"]
], columns=["SupplierID","SupplierName","ContactEmail"])

supplierphone = pd.DataFrame([
    [1,"111"],[2,"222"],[3,"333"],[4,"444"],[5,"555"]
], columns=["SupplierID","PhoneNumber"])

employee = pd.DataFrame([
    [1,"A","Inspector"],
    [2,"B","Inspector"],
    [3,"C","Analyst"],
    [4,"D","Inspector"],
    [5,"E","Supervisor"]
], columns=["EmployeeID","FullName","Role"])

defecttype = pd.DataFrame([
    [1,"Surface","defect"],
    [2,"Scratch","defect"],
    [3,"Crack","defect"],
    [4,"Misalignment","defect"]
], columns=["DefectTypeID","TypeName","Description"])

runs = []
runsupplier = []
defect = []
inspect = []

base = pd.Timestamp("2026-01-01 01:00:00")

for i,row in df.iterrows():
    rid = i+1
    lid = (i % 6) + 1
    t = base + pd.Timedelta(hours=i*6)

    status = str(row.get("DefectStatus","Defect"))

    runs.append([
        rid,
        lid,
        t.strftime("%Y-%m-%d %H:%M:%S"),
        float(row.get("ProductionVolume",0)),
        float(row.get("ProductionCost",0)),
        float(row.get("SupplierQuality",0)),
        float(row.get("DeliveryDelay",0)),
        float(row.get("DefectRate",0)),
        float(row.get("QualityScore",0)),
        float(row.get("MaintenanceHours",0)),
        float(row.get("DowntimePercentage",0)),
        float(row.get("InventoryTurnover",0)),
        float(row.get("StockoutRate",0)),
        float(row.get("WorkerProductivity",0)),
        int(row.get("SafetyIncidents",0)),
        float(row.get("EnergyConsumption",0)),
        float(row.get("EnergyEfficiency",0)),
        float(row.get("AdditiveProcessTime",0)),
        float(row.get("AdditiveMaterialCost",0)),
        status
    ])

    sid = (i % 5) + 1
    runsupplier.append([rid, sid, "LOT"+str(rid), 10.0, 1])

    if float(row.get("DefectRate",0)) > 0:
        defect.append([rid,1,1,"Low",(t + pd.Timedelta(minutes=45)).strftime("%Y-%m-%d %H:%M:%S")])

    inspect.append([rid,rid,(i%5)+1,(t+pd.Timedelta(hours=1)).strftime("%Y-%m-%d %H:%M:%S"),"ok"])

# conv
runs = pd.DataFrame(runs, columns=[
    "RunID","LineID","RunTimestamp","ProductionVolume","ProductionCost",
    "SupplierQuality","DeliveryDelay","DefectRate","QualityScore",
    "MaintenanceHours","DowntimePercentage","InventoryTurnover","StockoutRate",
    "WorkerProductivity","SafetyIncidents","EnergyConsumption","EnergyEfficiency",
    "AdditiveProcessTime","AdditiveMaterialCost","DefectStatus"
])

runsupplier = pd.DataFrame(runsupplier, columns=[
    "RunID","SupplierID","MaterialLot","MaterialCost","OnTimeDelivery"
])

defect = pd.DataFrame(defect, columns=[
    "RunID","DefectSeq","DefectTypeID","Severity","DetectedAt"
])

inspect = pd.DataFrame(inspect, columns=[
    "InspectionID","RunID","EmployeeID","InspectedAt","Notes"
])

# sav
plant.to_csv("data/Plant.csv",index=False)
line.to_csv("data/ProductionLine.csv",index=False)
machine.to_csv("data/Machine.csv",index=False)
machinespec.to_csv("data/MachineSpec.csv",index=False)
supplier.to_csv("data/Supplier.csv",index=False)
supplierphone.to_csv("data/SupplierPhone.csv",index=False)
employee.to_csv("data/Employee.csv",index=False)
defecttype.to_csv("data/DefectType.csv",index=False)
runs.to_csv("data/ProductionRun.csv",index=False)
runsupplier.to_csv("data/RunSupplier.csv",index=False)
defect.to_csv("data/DefectInstance.csv",index=False)
inspect.to_csv("data/Inspection.csv",index=False)
