ActiveAdmin.register Invoice do
  permit_params :csv_file

  actions :all, :except => [:destroy, :edit]

  filter :team
  filter :freelancer
  filter :amount

  index do
    id_column
    column :date
    column :refference_id
    column :freelancer
    column :team
    column :amount
    column :created_at

    actions
  end

  form do |f|
    f.inputs "Invoice" do
      f.input :csv_file, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :date
      row :refference_id
      row :type_of_calculation
      row :description
      row :agency
      row :freelancer
      row :team
      row :account_name
      row :amount
      row :amount_in_local
      row :currency
    end
  end

  controller do

    def create
      @redirect_url = admin_invoices_path

      if permitted_params[:invoice].present?
        csv_file = permitted_params[:invoice][:csv_file].read
        csv = CSV.parse(csv_file, :headers => true)
        if csv.headers.include?('Team') && csv.headers.include?('Amount') && csv.headers.include?('Freelancer')
          csv.each do |row|
            invoice = Invoice.new(
                date: row['Date'],
                refference_id: row['Ref ID'],
                type_of_calculation: row['Type'],
                description: row['Description'],
                agency: row['Agency'],
                freelancer: row['Freelancer'],
                team: row['Team'],
                account_name: row['Account Name'],
                amount: row['Amount'],
                amount_in_local: row['Amount in local currency'],
                currency: row['Currency']
            )

            invoice.save
          end
        else
          flash[:warning] = 'Please, select the correct file.'
          @redirect_url = :back
        end
      end
      redirect_to @redirect_url
    end

  end
end