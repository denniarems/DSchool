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
        address[] approvers;
        uint approvedTime;
        bool valid;
    }
    mapping (address => Student) Std;
    mapping (address => Approver) Evaluator ;
    Task[] public Assignments ;
    uint public CurrentStdId = 0;
    uint public CurrentEvaId = 0;

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
    function setStudent( string memory _name, uint _age) public  {
        CurrentStdId++;
        Std[msg.sender] = Student(CurrentStdId,_name, _age);
    }
    function getStudent(uint _stdId) public view returns (string memory _name, uint _age){
        _name = Std[msg.sender].name;
        _age = Std[msg.sender].age;
    }
    function setApprover(string memory _name,string memory _skill, uint _skillRank) public  {
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
        task.valid = false;
        Assignments.push(task);
    }
    function Upvoting() public onlyapprover {
        
    }

}