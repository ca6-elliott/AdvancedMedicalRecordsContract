// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthRecord {
    
    struct Record {
    uint256 id;
    string patientName;
    string medicalCondition;
    string doctorName;
    string date;
    string dataHash;
    address owner;
    bool isShared;
    bool isApproved;
    uint256 shareRequestCount;
    address[] sharedWith;
    address[] shareRequestSent;
}

    
    mapping(uint256 => Record) public records;
    uint256 public recordCount = 0;
    
    mapping(address => mapping(uint256 => bool)) public approvedRecords;
    mapping(address => uint256[]) public sharedRecords;
    mapping(address => uint256[]) public shareRequestRecords;
    
    event RecordCreated(uint256 id, string patientName, string medicalCondition, string doctorName, string date, string dataHash, address owner);
    event RecordShared(uint256 id, address sharee);
    event RecordOwnershipTransferred(uint256 id, address oldOwner, address newOwner);
    event ShareRequestSent(uint256 id, address sharee);
    event ShareRequestApproved(uint256 id, address sharee);
    event ShareRequestRejected(uint256 id, address sharee);

    function createRecord(string memory _patientName, string memory _medicalCondition, string memory _doctorName, string memory _date, string memory _dataHash) public {
    recordCount++;
    Record memory newRecord = Record(recordCount, _patientName, _medicalCondition, _doctorName, _date, _dataHash, msg.sender, false, false, 0, new address[](0), new address[](0));
    records[recordCount] = newRecord;
    emit RecordCreated(recordCount, _patientName, _medicalCondition, _doctorName, _date, _dataHash, msg.sender);
}


    function shareRecord(uint256 _id, address _sharee) public {
        require(_id <= recordCount && _id > 0, "Invalid record ID.");
        require(msg.sender == records[_id].owner, "Only the owner of the record can share it.");
        require(_sharee != address(0), "Invalid sharee address.");
        records[_id].isApproved = false;
        records[_id].shareRequestCount++;
        shareRequestRecords[_sharee].push(_id);
        emit ShareRequestSent(_id, _sharee);
    }

    function approveShareRequest(uint256 _id, address _sharee) public {
        require(_id <= recordCount && _id > 0, "Invalid record ID.");
        require(msg.sender == records[_id].owner, "Only the owner of the record can approve share requests.");
        records[_id].isApproved = true;
        records[_id].isShared = true;
        sharedRecords[_sharee].push(_id);
        approvedRecords[_sharee][_id] = true;
        emit RecordShared(_id, _sharee);
        emit ShareRequestApproved(_id, _sharee);
    }

   function rejectShareRequest(uint256 _id, address _sharee) public {
    require(_id <= recordCount && _id > 0, "Invalid record ID.");
    require(msg.sender == records[_id].owner, "Only the owner of the record can reject share requests.");
    records[_id].shareRequestCount--;
    emit ShareRequestRejected(_id, _sharee);
}
    }