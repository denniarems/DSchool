pragma solidity 0.5.12;

contract DSchool {
    struct Student {
        uint stdId;
        string name;
        uint age;
    }
    struct Approver{
        uint approverId;
        string name;
        string skill;
        uint skillRank;
    }
    struct Task{
        string name;
        string tech;
        uint stdId;
        address student;
        uint[] approvers;
        uint approvedTime;
        bool valid;
    }
    mapping (address => Student) Std;
    mapping (address => Approver) Evaluator ;
    Task[] public Assignments ;
    uint public CurrentStdId = 0;
    uint public CurrentEvaId = 0;
    modifier userRegister(uint number) {
        if(number == 0){
            require(Evaluator[msg.sender].approverId == 0,"Evaluator Can't be Student");
            require(Std[msg.sender].stdId == 0,"Already Registerd");
        }else{
            require(Std[msg.sender].stdId == 0,"Student Can't be Evaluator");
            require(Evaluator[msg.sender].approverId == 0,"Already Registerd");
        }
        _;
    }
    modifier onlyStudent() {
        require(Evaluator[msg.sender].approverId == 0,"Must be Student");
        require(Std[msg.sender].stdId > 0,"Student Must Registerd");
        _;
    }
    modifier onlyapprover() {
        require(Std[msg.sender].stdId == 0,"Must be Evaluator");
        require(Evaluator[msg.sender].approverId > 0,"Evaluato Must Registerd");
        _;
    }
    modifier eligibility(uint _position) {
        require( keccak256(abi.encodePacked(Assignments[_position].tech)) ==  keccak256(abi.encodePacked(Evaluator[msg.sender].skill)),"You Don't Know , What Tech it is ");
        require( Evaluator[msg.sender].skillRank > 1000,"Need credibility Score More than 1000 ");
        _;
    }
    function setStudent( string memory _name, uint _age) public userRegister(0)  {
        CurrentStdId++;
        Std[msg.sender] = Student(CurrentStdId,_name, _age);
    }
    function getStudent() public view returns (uint _stdId,string memory _name, uint _age){
        _stdId =Std[msg.sender].stdId;
        _name = Std[msg.sender].name;
        _age = Std[msg.sender].age;
    }
    function setApprover(string memory _name,string memory _skill, uint _skillRank) public userRegister(1) {
        CurrentEvaId++;
        Evaluator[msg.sender] = Approver(CurrentEvaId,_name, _skill,_skillRank);
    }
    function getApprover(uint evaId) public view returns (string memory _name,string memory _skill, uint _skillRank){
        _name = Evaluator[msg.sender].name;
        _skill = Evaluator[msg.sender].skill;
        _skillRank = Evaluator[msg.sender].skillRank;
    }
    function taskSubmission(string memory _name,string memory _tech) public onlyStudent{
        Task memory task;
        task.name = _name;
        task.tech = _tech;
        task.stdId = Std[msg.sender].stdId;
        task.student = msg.sender;
        task.approvers;
        task.approvedTime = 0;
        task.valid = false;
        Assignments.push(task);
    }
    function Upvoting(uint _position) public onlyapprover eligibility(_position) {
        Assignments[_position].approvers.push(Evaluator[msg.sender].approverId);
        if (!Assignments[_position].valid) {
            if(Assignments[_position].approvers.length == 5){
                Assignments[_position].valid = true;
            }
        } 
    }
}