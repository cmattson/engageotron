json.array!(@contacts) do |contact|
  json.extract! contact,
                :id,
                :first_name,
                :last_name,
                :company_name,
                :address1,
                :address2,
                :city,
                :state,
                :zip_code,
                :phone,
                :member,
                :member_type,
                :member_since,
                :full_name
  json.url contact_url(contact, format: :json)
end
