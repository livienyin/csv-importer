package csvParse

import csv.app.Company
import csv.app.Contact

class UploadService {

    def parseCsvFile(File csvFile) {
        def rowNum = 0
        csvFile.splitEachLine(',') { row ->
            if (rowNum > 0) {
                def contact = Contact.findByEmail(row[0]) ?: new Contact(
                        email: row[0],
                        firstName: row[1],
                        lastName: row[2],
                        prefix: row[3],
                        phone: row[4],
                        fax: row[5],
                        title: row[6])
                def company = Company.findByName(row[7]) ?: new Company(name: row[7])
                company.save(flush: true)
                company.addToContacts(contact)
                contact.save(flush: true)
            }
            rowNum++
        }
    }


}
