table 50100 "WebTableUsers"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
        }

        field(2; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }

        field(3; "Username"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Username';
        }

        field(4; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }

        field(5; "Street"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Street';
        }

        field(6; "Suite"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Suite';
        }

        field(7; "City"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'City';
        }

        field(8; "Zipcode"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Zipcode';
        }

        field(9; "Phone"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Phone';
        }

        field(10; "Website"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Website';
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
}