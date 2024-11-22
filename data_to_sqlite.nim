# (c) 2024 Kimberly Wilber. All code written is my own, with no AI assistance.

import sugar
import strutils
import db_connector/db_sqlite
import sequtils
import fusion/matching
{.experimental: "caseStmtMacros".}


let dbConn = open("test.sqlite", "", "", "")
dbConn.exec sql"""
    create table sessions(
        session_id int primary key,
        type_of_record,
        day int,
        user_id int
    );
"""
dbConn.exec sql"""
    create table queries(
        session_id int,
        time_passed int,
        type_of_record,
        serp_id int,
        query_id int
    );
"""
dbConn.exec sql"""
    create table terms(
        term_id int primary key,
        query_id int
    );
"""
dbConn.exec sql"""
create table clicks(
    query_id int,
    time_passed int,
    serp_id int,
    domain_id int
);
"""
dbConn.exec sql"""
create table domains(
    query_id int,
    url_id int,
    domain_id int
);
"""

dbConn.exec sql"""begin;"""

for line in stdin.lines:
    case line.split "\t":
        of [@sesid, @tor, @day, @uid]:
            dbConn.exec(
                sql"""insert into sessions(session_id, day, user_id) values (?,?,?)""",
                sesid, day, uid)
        of [@sesid, @time, @tor, @serpid, @urlid]:
            session_id = sesid
dbConn.exec sql"""commit;"""


