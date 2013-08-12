package csv.app

class Contact {

    static belongsTo = [company:Company]

    String email
    String firstName
    String lastName
    String prefix
    String phone
    String fax
    String title

    static constraints = {
        email blank: false, unique: true
        firstName blank: false
        lastName nullable: true
        prefix nullable: true
        phone nullable: true
        fax nullable: true
        title nullable: true
    }
}
