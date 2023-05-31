## AdvancedMedicalRecordsContract

The Health Record contract allows the creation, sharing, and transfer of ownership of medical records.

### Contract Structure

The contract is defined as `HealthRecord` in Solidity version 0.8.0 or higher.

### Record Structure

The contract includes a `Record` struct with the following properties:

- `id`: A unique identifier for the record.
- `patientName`: A string representing the name of the patient.
- `medicalCondition`: A string describing the medical condition.
- `doctorName`: A string representing the name of the doctor.
- `date`: A string indicating the date of the record.
- `dataHash`: A string storing the hash of the record data.
- `owner`: The address of the record owner.
- `isShared`: A boolean indicating whether the record is shared with others.

### State Variables

- `records`: An array of `Record` structs to store all created records.
- `recordToApprover`: A mapping that associates record IDs with the address of the record approver (the owner who shared the record).
- `approvedRecords`: A mapping that tracks approved records for each sharee.
- `event RecordCreated`: An event emitted when a new record is created.
- `event RecordShared`: An event emitted when a record is shared with a specific sharee.
- `event RecordOwnershipTransferred`: An event emitted when the ownership of a record is transferred.

### Functions

The contract provides the following functions:

1. `createRecord(string memory _patientName, string memory _medicalCondition, string memory _doctorName, string memory _date, string memory _dataHash)`: Creates a new record by providing the necessary details. The function emits a `RecordCreated` event.
2. `shareRecord(uint256 _id, address _sharee)`: Allows the owner of a record to share it with a specific address. The function emits a `RecordShared` event.
3. `transferRecordOwnership(uint256 _id, address _newOwner)`: Allows the current owner of a record to transfer ownership to a new address. The function emits a `RecordOwnershipTransferred` event.
4. `getRecordsCount()`: Returns the total count of records created.
5. `getRecord(uint256 _id)`: Retrieves the details of a specific record identified by its ID.

### Modifiers

The contract includes no modifiers.

### License

The contract is licensed under the MIT License. Refer to the SPDX-License-Identifier at the top of the code for more details.
