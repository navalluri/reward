pragma solidity ^0.4.2;

contract LetterofCredit {	
    address importer;
    address exporter;
    address bank;
    string sales_contract;
    string document;
    
	enum LOCStatus { APPLIED, FOUNDED, REVEWING, DOC_OK, DOC_DEFECT, DONE_SUCCESS, DONE_FAILURE }

	LOCStatus status;
	uint total_price;
	uint defect_fee;

	function LOC(address _importer, address _exporter, address _bank, uint _total_price, string _sales_contract) public payable {

		if(msg.sender != _bank) throw;

		importer = _importer;

		exporter = _exporter;

		bank = _bank;
		sales_contract = _sales_contract;

		total_price = _total_price;

		// setting initial status
		status = LOCStatus.APPLIED;
	}

	function getImporter() constant returns (address) {
	    return importer;
	}
	
	function getExporter() constant returns (address) {
	    return exporter;
	}

	function getStatus() returns (LOCStatus) {
	    return status;
	}

	function signFound() public payable {
		// check bank signature
 		if(msg.sender != bank || msg.value < total_price || status != LOCStatus.APPLIED) {
 			throw;
 		}

		// set status
		status = LOCStatus.FOUNDED;
	}

	function sendDocuments(string _document) public payable {
		// check exporter signature 
		// check the status is FOUNDED
		if(msg.sender != exporter || status != LOCStatus.FOUNDED) {
 			throw;
 		}

		// set document
		document = _document;

		status = LOCStatus.REVEWING;
	}

	function sendReviewResult(bool result, uint fee) public payable {
		// check bank signature
		if(msg.sender != bank || status != LOCStatus.REVEWING) {
 			throw;
 		}

		// set status
		status = result ? LOCStatus.DOC_OK : LOCStatus.DOC_DEFECT;

		if(!result) {
			defect_fee = fee;
		}
	}

	function acceptOrNot(bool accept) public payable {
		// prevent duplicate operation
		if(msg.sender != importer || status == LOCStatus.DONE_SUCCESS) throw;

		// check
		if(!accept) {
			status = LOCStatus.DONE_FAILURE;
			// money back to bank
			bank.send(total_price);
			return;
		}

		// send the money to exporter and bank
		status = LOCStatus.DONE_SUCCESS;
		bank.send(defect_fee);
		exporter.send(total_price - defect_fee);
	}
}
