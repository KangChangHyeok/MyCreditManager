//
//  main.swift
//  MyCreditManager
//
//  Created by 강창혁 on 2022/12/01.
//

import Foundation

var creditMangerExistence = true

struct Student: Equatable {
    var name: String
    var subject: [String: String]?
}
var students = [Student]()

while creditMangerExistence {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    let input = readLine()
    
    switch input {
    case "1":
        addStudent()
        break
    case "2":
        deleteStudent()
        break
    case "3":
        addSubject()
        break
    case "4":
        // 성적 삭제 기능 실행
        break
    case "X":
        // 종료
        creditMangerExistence = false
    default:
        break
    }
}

func addStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    if let input = readLine() {
        if students.filter({ $0.name == input }).isEmpty {
            students.append(Student(name: input))
            print("\(input) 학생을 추가하였습니다.")
        } else {
            print("\(input)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        }
    } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요")
    }
}

func deleteStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    if let input = readLine() {
        if students.filter({$0.name == input}).isEmpty {
            print("\(input) 학생을 찾지 못했습니다.")
        } else {
            if let deleteStudentIndex = students.firstIndex(of: Student(name: input)) {
                students.remove(at: deleteStudentIndex)
            }
        }
    } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요")
    }
}
func addSubject() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    if let input = readLine()?.components(separatedBy: " "), input.count == 3 {
        let name = input[0]
        let subjectName = input[1]
        let subjectScore = input[2]
        
        guard false == students.filter({ $0.name == name }).isEmpty else {
            print("입력이 잘못되었습니다. 학생이 없음")
            return
        }
        guard let addSubjectStudentIndex = students.firstIndex(where:{$0.name == name}) else { return }
        
        guard false == students[addSubjectStudentIndex].subject?.isEmpty else {
            students[addSubjectStudentIndex].subject = [:]
            students[addSubjectStudentIndex].subject?.updateValue(subjectScore, forKey: subjectName)
            return
        }
        students[addSubjectStudentIndex].subject?.updateValue(subjectScore, forKey: subjectName)
    } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요")
    }
}
