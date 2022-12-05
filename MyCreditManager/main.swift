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
func getScore(score: String?) -> Double {
    switch score {
    case "A+":
        return 4.5
    case "A":
        return 4.0
    case "B+":
        return 3.5
    case "B":
        return 3.0
    case "C+":
        return 2.5
    case "C":
        return 2.0
    case "D+":
        return 1.5
    case "D":
        return 1.0
    case "F":
        return 0
    default:
        break
    }
    return 0.0
}
var students = [Student]()

while creditMangerExistence {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    let input = readLine()
    
    switch input {
    case "1":
        addStudent()
    case "2":
        deleteStudent()
    case "3":
        addSubject()
    case "4":
        deleteSubject()
    case "5":
        getAverage()
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
        guard let studentIndex = students.firstIndex(where:{$0.name == name}) else { return }
        
        guard false == students[studentIndex].subject?.isEmpty else {
            students[studentIndex].subject = [:]
            students[studentIndex].subject?.updateValue(subjectScore, forKey: subjectName)
            return
        }
        students[studentIndex].subject?.updateValue(subjectScore, forKey: subjectName)
    } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요")
    }
}

func deleteSubject() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    
    guard let input = readLine()?.components(separatedBy: " "), input.count == 2 else {
        return print(" 입력이 잘못되었습니다. 다시 확인해주세요") }
    let studentName = input[0]
    let subjectName = input[1]
    
    guard let studentIndex = students.firstIndex(where:{$0.name == studentName}) else { return print("\(studentName) 학생을 찾지 못했습니다.") }
    
    guard false == students.filter({$0.subject?[subjectName] != nil}).isEmpty else { return
        print("\(studentName) 학생의 \(subjectName) 과목 성적이 등록되지 않았습니다.")
    }
    students[studentIndex].subject?[subjectName] = nil
}

func getAverage() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요.")
    guard let studentName = readLine() else { return print("입력이 잘못되었습니다. 다시 확인해 주세요.") }
    guard let studentIndex = students.firstIndex(where:{$0.name == studentName}) else { return print("\(studentName) 학생을 찾지 못했습니다.") }
    var average = 0.0
    var count = 0.0
    students[studentIndex].subject?.forEach({
        print("\($0.key): \($0.value)")
        average += getScore(score: $0.value)
        count += 1.0
    })
    print(average / count)
}
