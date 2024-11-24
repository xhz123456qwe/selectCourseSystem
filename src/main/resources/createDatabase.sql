create database scs;

create table course(
    cId INT primary key,
    cNumber VARCHAR(20),
    cName VARCHAR(20),
    teacher VARCHAR(20),
    department VARCHAR(20),
    maxNumber INT,
    cStart VARCHAR(20),
    cEnd VARCHAR(20),
    cDay VARCHAR(20),
    cTime VARCHAR(20),
    description VARCHAR(20),
    location VARCHAR(20),
    credit FLOAT,
    nowNum INT
);

create table manager(
    mId INT primary key,
    mName VARCHAR(20),
    mNumber VARCHAR(20),
    password VARCHAR(20),
    email VARCHAR(20),
    state VARCHAR(20)
);

create table student(
    sId INT primary key,
    sName VARCHAR(20),
    sNumber VARCHAR(20),
    password VARCHAR(20),
    email VARCHAR(20),
    grade VARCHAR(20),
    department VARCHAR(20)
);

create table stu_course(
    stUid INT,
    cId INT,
    state VARCHAR(20),
    FOREIGN KEY (stUid) references student(sId),
    FOREIGN KEY (cId) references course(cId)
);
