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

    }
}
