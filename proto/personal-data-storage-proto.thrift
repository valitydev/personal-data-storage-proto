namespace java com.empayre.transfer
namespace erlang personal_data_storage.personal_data_storage

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
    8: required string residence_address
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

struct PersonalName {
   1: required string family_name
   2: required string given_name
   3: string middle_name
}

struct BankCredentials {
   1: required string login
   2: required string pasword
}

struct BankAccountPersonalData {
   1: required string bank_name
   2: required string bank_bic
   3: optional string account_number
   4: required PersonalName personal_name
   5: required BankCredentials bank_credentials
}

struct PhonePersonalData {
   1: required string bank_name
   2: required string phone_number
   3: required PersonalName personal_name
   4: required BankCredentials bank_credentials
}

struct BankCardPersonalData {
   1: required string bank_name
   2: required string card_token
   3: required PersonalName personal_name
   4: required BankCredentials bank_credentials
}

union P2PReceiverPersonalData {
   1: BankAccountPersonalData account_personal_data
   2: PhonePersonalData phone_personal_data
   3: BankCardPersonalData card_personal_data
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
    4: P2PReceiverPersonalData p2p_receiver_personal_data
}

exception PersonalDataNotFound {}

exception InvalidRequest {}

service PersonalDataStorageService {
    SavePersonalDataResponse SavePersonalData(1: SavePersonalDataRequest save_personal_data_request)
        throws (1: InvalidRequest ex)
    GetPersonalDataResponse GetPersonalData(1: PersonalDataToken token)
        throws (1: PersonalDataNotFound ex1, 2: InvalidRequest ex2)
}
