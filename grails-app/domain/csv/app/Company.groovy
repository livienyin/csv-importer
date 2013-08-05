package csv.app

class Company {

    static hasMany = [contacts:Contact]

    String name

    String toString(){
        return "${name}"
    }

    static constraints = {

    }
}
