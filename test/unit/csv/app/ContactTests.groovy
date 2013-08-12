package csv.app



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Contact)
@Mock([Contact, Company])
class ContactTests {

    void testFirstName() {
       Contact testcontact = new Contact(firstName: "Livien")
       assert "Livien" == testcontact.firstName
    }

    void testConstraints() {
        def existingContact = new Contact(
                firstName: "Livien",
                email: "livien.yin@taulia.com",
                company: new Company(name: "Taulia"))

        mockForConstraintsTests(Contact, [existingContact])

        def contact = new Contact(company: new Company(name: "Taulia"))
        assert !contact.validate()
        assert contact.errors.hasFieldErrors("firstName")
        assert "nullable" == contact.errors.getFieldError("firstName").code
        assert contact.errors.hasFieldErrors("email")
        assert "nullable" == contact.errors.getFieldError("email").code

        contact = new Contact(firstName: "Livien", email: "livien.yin@taulia.com", company: new Company(name: "Taulia"))
        assert !contact.validate()
        assert "unique" == contact.errors.getFieldError("email").code

        contact = new Contact(firstName: "Livien", email: "livienyin@gmail.com", company: new Company(name: "Taulia"))
        assert contact.validate()
    }
}
