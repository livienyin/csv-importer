package csvParse

import csv.app.Company
import csv.app.Contact
import grails.test.mixin.*
import csvParse.UploadService
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(UploadService)
@Mock([Contact, Company])
class UploadServiceTests {

    def uploadService = new UploadService()

    void testParserSavesContacts() {
        File csvFile = new File('/tmp/tempFile.csv')
        uploadService.parseCsvFile(csvFile)
        assert Contact.count() == 8
    }

    void testParserSavesCompanies() {
        File csvFile = new File('/tmp/tempFile.csv')
        uploadService.parseCsvFile(csvFile)
        assert Company.count() == 7
    }

    void testParserAssignsCorrectAttributes() {
        File csvFile = new File('/tmp/tempFile.csv')
        uploadService.parseCsvFile(csvFile)
        def firstContact = Contact.first()
        assert firstContact.firstName == "Jonas Sultani"
        assert firstContact.lastName == null
        assert firstContact.email == "jonas.sultani@flintstones.com"
        assert firstContact.prefix == "Mr"
        assert firstContact.phone == "+49 6245 99555"
        assert firstContact.fax == "+49 6245 95535"
        assert firstContact.title == "Consultant"
        assert firstContact.company == Company.first()
    }

}
