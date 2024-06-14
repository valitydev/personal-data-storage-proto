namespace java com.empayre.transfer

typedef string PersonalDataToken

struct SenderBankAccount {
    1: string account_number
}

struct PersonPassport {
    1: required string family_name
    2: required string given_name
    3: string middle_name
    4: required string date_of_birth
    5: required string citizenship
    6: required string birth_place
    7: required string number
    8: required string residense_address
    9: required string issued_by
    10: required string issued_at
    // only for russian domestic passports
    11: string department_code
}

struct ResidentSenderPersonalData {
    1: PersonPassport person_passport
    2: SenderBankAccount sender_bank_account
    3: string inn
}

struct NonResidentSenderPersonalData {
    1: PersonPassport person_passport
    2: SenderBankAccount sender_bank_account
    3: string inn
    4: optional string migration_card_number
}

union TransferSenderPersonalData {
    1: ResidentSenderPersonalData resident_sender_personal_data
    2: NonResidentSenderPersonalData non_resident_sender_personal_data
}

struct TransferRecieverPersonalData {
    1: required string family_name
    2: required string given_name
    3: string middle_name
    // Date of birth according to format DD.MM.YYYY
    4: required string date_of_birth
    // ISO Alpha-3 country of citizenship
    5: required string citizenship
}

struct GenericPersonalData {
    1: PersonPassport person_passport
    2: optional string inn
}

struct SavePersonalDataRequest {
    1: required PersonalData personal_data
}

struct GetPersonalDataResponse {
    1: required PersonalData personal_data
}

struct SavePersonalDataResponse {
    1: required PersonalDataToken token
}

union PersonalData {
    1: TransferSenderPersonalData transfer_sender_personal_data
    2: TransferRecieverPersonalData transfer_reciever_personal_data
    3: GenericPersonalData generic_personal_data
}

service PersonalDataStorageService {
    SavePersonalDataResponse SavePersonalData(SavePersonalDataRequest save_personal_data_request)
    GetPersonalDataResponse GetPersonalData(PersonalDataToken token)
}
