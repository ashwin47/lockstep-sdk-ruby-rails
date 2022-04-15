class Schema::Invoice < Lockstep::ApiRecord

  # ApiRecord will crash unless `id_ref` is defined
  def self.id_ref
    nil
  end

  # The GroupKey uniquely identifies a single Lockstep Platform account.  All records for this
  # account will share the same GroupKey value.  GroupKey values cannot be changed once created.
  #
  # For more information, see [Accounts and GroupKeys](https://developer.lockstep.io/docs/accounts-and-groupkeys).
  # @type: string
  # @format: uuid
  field :group_key

  # The unique ID of this record, automatically assigned by Lockstep when this record is
  # added to the Lockstep platform.
  #
  # For the ID of this record in its originating financial system, see `ErpKey`.
  # @type: string
  # @format: uuid
  field :invoice_id

  # The ID number of the company that created this invoice.
  # @type: string
  # @format: uuid
  field :company_id

  # The ID number of the counterparty for the invoice, for example, a customer or vendor.
  # @type: string
  # @format: uuid
  field :customer_id

  # The unique ID of this record as it was known in its originating financial system.
  #
  # If this company record was imported from a financial system, it will have the value `ErpKey`
  # set to the original primary key number of the record as it was known in the originating financial
  # system.  If this record was not imported, this value will be `null`.
  #
  # For more information, see [Identity Columns](https://developer.lockstep.io/docs/identity-columns).
  # @type: string
  field :erp_key

  # The "Purchase Order Code" is a code that is sometimes used by companies to refer to the original PO
  # that was sent that caused this invoice to be written.  If a customer sends a purchase order to a vendor,
  # the vendor can then create an invoice and refer back to the originating purchase order using this field.
  # @type: string
  field :purchase_order_code

  # An additional reference code that is sometimes used to identify this invoice.
  # The meaning of this field is specific to the ERP or accounting system used by the user.
  # @type: string
  field :reference_code

  # A code identifying the salesperson responsible for writing this quote, invoice, or order.
  # @type: string
  field :salesperson_code

  # A name identifying the salesperson responsible for writing this quote, invoice, or order.
  # @type: string
  field :salesperson_name

  # A code identifying the type of this invoice.
  #
  # Recognized Invoice types are:
  # * `Invoice` - Represents an invoice sent by Company to the Customer
  # * `AP Invoice` - Represents an invoice sent by Customer to the Company
  # * `Credit Memo` - Represents a credit memo generated by Customer given to Company
  # @type: string
  field :invoice_type_code

  # A code identifying the status of this invoice.
  #
  # Recognized Invoice status codes are:
  # * `Open` - Represents an invoice that is considered open and needs more work to complete
  # * `Closed` - Represents an invoice that is considered closed and resolved
  # @type: string
  field :invoice_status_code

  # A code identifying the terms given to the purchaser.  This field is imported directly from the originating
  # financial system and does not follow a specified format.
  # @type: string
  field :terms_code

  # If the customer negotiated any special terms different from the standard terms above, describe them here.
  # @type: string
  field :special_terms

  # The three-character ISO 4217 currency code used for this invoice.
  # @type: string
  field :currency_code

  # The total value of this invoice, inclusive of all taxes and line items.
  # @type: number
  # @format: double
  field :total_amount

  # The total sales (or transactional) tax calculated for this invoice.
  # @type: number
  # @format: double
  field :sales_tax_amount

  # The total discounts given by the seller to the buyer on this invoice.
  # @type: number
  # @format: double
  field :discount_amount

  # The remaining balance value of this invoice.
  # @type: number
  # @format: double
  field :outstanding_balance_amount

  # The reporting date for this invoice.
  # @type: string
  # @format: date
  field :invoice_date

  # The date when discounts were adjusted for this invoice.
  # @type: string
  # @format: date
  field :discount_date

  # The date when this invoice posted to the company's general ledger.
  # @type: string
  # @format: date
  field :posted_date

  # The date when the invoice was closed and finalized after completion of all payments and delivery of all products and
  # services.
  # @type: string
  # @format: date
  field :invoice_closed_date

  # The date when the remaining outstanding balance is due.
  # @type: string
  # @format: date
  field :payment_due_date

  # The date and time when this record was imported from the user's ERP or accounting system.
  # @type: string
  # @format: date-time
  field :imported_date, Types::Params::DateTime

  # The ID number of the invoice's origination address
  # @type: string
  # @format: uuid
  field :primary_origin_address_id

  # The ID number of the invoice's bill-to address
  # @type: string
  # @format: uuid
  field :primary_bill_to_address_id

  # The ID number of the invoice's ship-to address
  # @type: string
  # @format: uuid
  field :primary_ship_to_address_id

  # The date on which this invoice record was created.
  # @type: string
  # @format: date-time
  field :created, Types::Params::DateTime

  # The ID number of the user who created this invoice.
  # @type: string
  # @format: uuid
  field :created_user_id

  # The date on which this invoice record was last modified.
  # @type: string
  # @format: date-time
  field :modified, Types::Params::DateTime

  # The ID number of the user who most recently modified this invoice.
  # @type: string
  # @format: uuid
  field :modified_user_id

  # The AppEnrollmentId of the application that imported this record.  For accounts
  # with more than one financial system connected, this field identifies the originating
  # financial system that produced this record.  This value is null if this record
  # was not loaded from an external ERP or financial system.
  # @type: string
  # @format: uuid
  field :app_enrollment_id

  # Is the invoice voided?
  # @type: boolean
  field :is_voided

  # Is the invoice in dispute?
  # @type: boolean
  field :in_dispute

  # Should the invoice be excluded from aging calculations?
  # @type: boolean
  field :exclude_from_aging

  # The Company associated to this invoice.
  # To retrieve this item, specify `Company` in the "Include" parameter for your query.
  field :company

  # The Customer associated to the invoice customer
  # To retrieve this item, specify `Customer` in the "Include" parameter for your query.
  field :customer

  # The Contact associated to the invoice customer
  # To retrieve this item, specify `Customer` in the "Include" parameter for your query.
  field :customer_primary_contact

  belongs_to :company, { :class_name => "Lockstep::Account", :primary_key => :company_id, :foreign_key => "company_id" }
  belongs_to :account, { :class_name => "Lockstep::Account", :primary_key => :company_id, :foreign_key => "company_id" }
  belongs_to :customer, { :class_name => "Lockstep::Connection", :primary_key => :company_id, :foreign_key => "customer_id" }
  belongs_to :connection, { :class_name => "Lockstep::Connection", :primary_key => :company_id, :foreign_key => "customer_id" }
  belongs_to :created_user, { :class_name => "Lockstep::User", :primary_key => :user_id, :foreign_key => "created_user_id" }
  belongs_to :modified_user, { :class_name => "Lockstep::User", :primary_key => :user_id, :foreign_key => "modified_user_id" }

  has_many :addresses, { :class_name => "Schema::InvoiceAddress", :included => true }
  has_many :lines, { :class_name => "Schema::InvoiceLine", :included => true }
  has_many :payments, { :class_name => "Schema::InvoicePaymentDetail", :included => true }
  has_many :notes, { :class_name => "Lockstep::Note", :included => true, :foreign_key => :object_key, :polymorphic => { :table_key => "Invoice" } }
  has_many :attachments, { :class_name => "Schema::Attachment", :included => true }
  has_many :credit_memos, { :class_name => "Schema::CreditMemoInvoice", :included => true }
  has_many :custom_field_values, { :class_name => "Schema::CustomFieldValue", :included => true }
  has_many :custom_field_definitions, { :class_name => "Schema::CustomFieldDefinition", :included => true }
end
