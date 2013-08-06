package csv.app

import org.springframework.dao.DataIntegrityViolationException
import java.io.File
import org.apache.commons.io.FileUtils
import grails.converters.JSON

class ContactController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def getJSON = {
        def contacts = Contact.all
        render contacts as JSON
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [contactInstanceList: Contact.list(params), contactInstanceTotal: Contact.count()]
    }

    def create() {
        [contactInstance: new Contact(params)]
    }

    def save() {
        def contactInstance = new Contact(params)
        if (!contactInstance.save(flush: true)) {
            render(view: "create", model: [contactInstance: contactInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'contact.label', default: 'Contact'), contactInstance.id])
        redirect(action: "show", id: contactInstance.id)
    }

    def ajaxSave() {
        def contactInstance = new Contact(params)
        if (!contactInstance.save(flush: true)) {
            render(view: "create", model: [contactInstance: contactInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'contact.label', default: 'Contact'), contactInstance.id])
        render(view: "list", model: [contactInstanceList: Contact.list(params), contactInstanceTotal: Contact.count()])
    }

    def show(Long id) {
        def contactInstance = Contact.get(id)
        if (!contactInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'contact.label', default: 'Contact'), id])
            redirect(action: "list")
            return
        }

        [contactInstance: contactInstance]
    }

    def edit(Long id) {
        def contactInstance = Contact.get(id)
        if (!contactInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'contact.label', default: 'Contact'), id])
            redirect(action: "list")
            return
        }

        [contactInstance: contactInstance]
    }

    def update(Long id, Long version) {
        def contactInstance = Contact.get(id)
        if (!contactInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'contact.label', default: 'Contact'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (contactInstance.version > version) {
                contactInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'contact.label', default: 'Contact')] as Object[],
                          "Another user has updated this Contact while you were editing")
                render(view: "edit", model: [contactInstance: contactInstance])
                return
            }
        }

        contactInstance.properties = params

        if (!contactInstance.save(flush: true)) {
            render(view: "edit", model: [contactInstance: contactInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'contact.label', default: 'Contact'), contactInstance.id])
        redirect(action: "show", id: contactInstance.id)
    }

    def delete(Long id) {
        def contactInstance = Contact.get(id) ?: Contact.get(params.id)
        if (!contactInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'contact.label', default: 'Contact'), id])
            redirect(action: "list")
            return
        }

        try {
            contactInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'contact.label', default: 'Contact'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'contact.label', default: 'Contact'), id])
            redirect(action: "show", id: id)
        }
    }

    def ajaxDelete() {
        def contactInstance = Contact.get(params.id)
        contactInstance.delete(flush: true)
        flash.message = message(code: 'default.deleted.message', args: [message(code: 'contact.label', default: 'Contact'), params.id])
        render(view: "list", model: [contactInstanceList: Contact.list(params), contactInstanceTotal: Contact.count()])
    }

    def upload() {

        def tempFile = request.getFile('file')
        tempFile.transferTo(new File('/Users/livienyin/Desktop/temp/tempFile.csv'))

        File csvFile = new File('/Users/livienyin/Desktop/temp/tempFile.csv')
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

        render(view: "list", model: [contactInstanceList: Contact.list(params), contactInstanceTotal: Contact.count()])

    }
}
