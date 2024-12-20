namespace ALPrjWebService.ALPrjWebService;

page 50100 WebTablwUsers
{
    ApplicationArea = All;
    Caption = 'WebTablwUsers';
    PageType = List;
    SourceTable = WebTableUsers;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Phone; Rec.Phone)
                {
                    ToolTip = 'Specifies the value of the Phone field.', Comment = '%';
                }
                field(Username; Rec.Username)
                {
                    ToolTip = 'Specifies the value of the Username field.', Comment = '%';
                }
                field(Website; Rec.Website)
                {
                    ToolTip = 'Specifies the value of the Website field.', Comment = '%';
                }
                field(Street; Rec.Street)
                {
                    ToolTip = 'Specifies the value of the Street field.', Comment = '%';
                }
                field(Suite; Rec.Suite)
                {
                    ToolTip = 'Specifies the value of the Suite field.', Comment = '%';
                }
                field(Zipcode; Rec.Zipcode)
                {
                    ToolTip = 'Specifies the value of the Zipcode field.', Comment = '%';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
            }
        }
    }


    //

    actions
    {
        area(processing)
        {
            action(ExecProcedure)
            {
                ApplicationArea = All;
                Caption = 'Execute Import from WebServices';
                ToolTip = 'Import data from Web Sercice';

                trigger OnAction()
                var
                    MyCodeunit: Codeunit "WebServiceWCaller";

                begin
                    MyCodeunit.CallWebService();
                end;
            }
        }
    }


    //

}
