 contract Letterofcredit{
	

	address public importerUser;
	address public exporterUser;

	address public importerBankerDetailsDetails;
	address public exporterBankerDetilsDetils;

	address public BAInvestor;

	uint public shippingDate;
	uint public price;
	string public item;
	uint public amountOfItem;
	uint public discountDivisor;

	bool public importersBanksLetterOfCredit;
	bool public exporterAcceptedIBankDraft;
	
 	bool public tradeDealRequested;
	bool public tradeDealConfirmed;

	bool public bankersAcceptanceOfDeal;

	uint public importersBanksDraftMaturityDate;

    bool public productsExported;


	uint public discountedDealAmount;
	uint public dealAmount; 

	string public trackingNo;
	string public shippingService;


	uint public gasPrice;
	uint public minimumDealAmount;
	uint public BASalesPrice;

	bool public exporterReceivedPayment;
    bool public productsShipped; 
	address public creatorAddress;


	modifier onlyExporter { if(msg.sender == exporterUser ) _ }
	modifier onlyImporter { if(msg.sender == importerUser ) _ }
	modifier onlyExportsBank { if(msg.sender == exporterBankerDetilsDetils ) _ }
	modifier onlyImportersBank { if(msg.sender == importerBankerDetailsDetails ) _ }
	
		function TradeFinancing(){

		productsExported = false;
		tradeDealRequested = false;
		tradeDealConfirmed= false;
		productsShipped = false;
		bankersAcceptanceOfDeal = false;
		discountedDealAmount = 0;
		exporterAcceptedIBankDraft= false;
		exporterReceivedPayment = false;
		gasPrice = 1000;
		minimumDealAmount = 100;
		creatorAddress = 0x05eAE1b08ec620D162BbdF81d91CDDb40D8C1EDC;

	}	

	function setImporter(){
		importerUser = msg.sender;
	}

function setExporter(){
		exporterUser = msg.sender;
	}

	function setImporterBank(){
		importerBankerDetailsDetails = msg.sender;
	}

	function setExporterBank(){
		exporterBankerDetilsDetils = msg.sender;
	}

	function requestTradeDeal(uint productsrequestedPrice, uint productsrequestedAmount, string productsrequestedItem)  onlyImporter constant returns (bool){
	
	if(exporterAcceptedIBankDraft  == true){
			return false;
		}

		price = productsrequestedPrice;
		amountOfItem = productsrequestedAmount;
		item = productsrequestedItem;
		dealAmount = price * amountOfItem;
		
		if(dealAmount <minimumDealAmount){
			return false;
		}

		tradeDealRequested = true;
	}	
function acceptedTradeDeal()  onlyExporter constant returns (bool) {
		if(tradeDealRequested ==false){
			return false;
		}
		else{
			tradeDealConfirmed = true;
			return true;
		}
		
	}

    	function issueofLetterOfCredit(uint desiredDiscounedDealAmount) onlyImportersBank constant returns (bool) {
		if(tradeDealConfirmed != true){
			return false;
		}

		if(msg.value < discountedDealAmount){

			return false;
		}
		else{
			importersBanksLetterOfCredit = true;
			return true;
		}
		
	}

	function acceptBankDraft() onlyExporter{
		exporterAcceptedIBankDraft = true;

	}

	function shipProducts(string trackingNo, string shippingService)  onlyExporter returns (bool){
		if(exporterAcceptedIBankDraft == false){
			return false;
		}
		if(importersBanksLetterOfCredit != true){
			return false;
			
		}
		else{
			productsExported = true;
			return true;
		}
		

	}

    
    
}
