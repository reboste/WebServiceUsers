namespace ALPrjWebService.ALPrjWebService;


// 1. HttpClient: This object is used to send HTTP requests.
// 2. HttpResponseMessage: This stores the response from the web service call.
// 3. JsonObject: This is used to parse JSON objects.
// 4. JsonArray: This is used to parse JSON arrays.
// 5. Get(): This method retrieves data from the JSON response. In this case, it is used to get the list of users as a Json Array. 

codeunit 50100 "WebServiceWCaller"
{
    procedure CallWebService()
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        TextResponse: Text;           // Variabile per contenere la risposta convertita in Text
        JsonResponseArray: JsonArray; // Cambiamo JsonResponse in JsonArray
        JsonTokenItem: JsonToken;
        JsonObject: JsonObject;
        TmpNestedJsonObject: JsonObject;
        i: Integer;
        NumElementsFoundMsg: Label 'Found %1 record', Comment = '%1=num of record imported from web services';

    //UserName: Text;
    begin
        // Creiamo una richiesta HTTP GET
        if not HttpClient.Get('https://jsonplaceholder.typicode.com/users', HttpResponseMessage) then
            Error('Impossibile chiamare il web service con HttpClient.Get.')
        else begin
            // Verifica se la risposta è OK (codice 200)
            if not HttpResponseMessage.IsSuccessStatusCode() then
                Error('Errore nella chiamata al web service. Codice di stato: %1', HttpResponseMessage.HttpStatusCode())
            else
                // Ora, convertiamo la risposta in un array JSON
                //NO:
                // Leggere subito il corpo della risposta come un array JSON nonè  possibile
                // HttpResponseMessage.Content().ReadAs(JsonResponseText);
                // NO Leggi il corpo della risposta come SecretText (contenuto in formato testo)
                //HttpResponseMessage.Content().ReadAs(JsonResponseText);
                // Convertiamo il SecretText in Text
                // TextResponse := JsonResponseText.ToString(); //non funziona

                //leggo come Text
                HttpResponseMessage.Content().ReadAs(TextResponse); //testare con IF todo

            //restituisce un ARRAY di oggetti Json

            // Ora, convertiamo il testo della risposta in un array JSON
            //parsing:-------
            if JsonResponseArray.ReadFrom(TextResponse) then begin

                Message(NumElementsFoundMsg, JsonResponseArray.Count());

                // Itera su ogni elemento dell'array JSON (che rappresenta un utente)
                for i := 0 to JsonResponseArray.Count() - 1 do begin

                    JsonResponseArray.Get(i, JsonTokenItem);
                    //if (JsonTokenItem.IsObject()) then begin
                    JsonObject := JsonTokenItem.AsObject();
                    TabWeb.Init(); //pulisco 1 record
                    // Estrai il campi dell'utente dall'oggetto JSON
                    Evaluate(TabWeb.ID, GetValueByToken(JsonObject, 'id').AsValue().AsText());
                    Evaluate(TabWeb.Name, GetValueByToken(JsonObject, 'name').AsValue().AsText());
                    Evaluate(TabWeb.Phone, GetValueByToken(JsonObject, 'phone').AsValue().AsText());
                    Evaluate(TabWeb.Website, GetValueByToken(JsonObject, 'website').AsValue().AsText());
                    Evaluate(TabWeb.Email, GetValueByToken(JsonObject, 'email').AsValue().AsText());
                    Evaluate(TabWeb.Username, GetValueByToken(JsonObject, 'username').AsValue().AsText());
                    //this is a nested JsonObject
                    TmpNestedJsonObject := GetValueByToken(JsonObject, 'address').AsObject(); //nested object
                    Evaluate(TabWeb.Suite, GetValueByToken(TmpNestedJsonObject, 'suite').AsValue().AsText());
                    Evaluate(TabWeb.City, GetValueByToken(TmpNestedJsonObject, 'city').AsValue().AsText());
                    Evaluate(TabWeb.Zipcode, GetValueByToken(TmpNestedJsonObject, 'zipcode').AsValue().AsText());
                    Evaluate(TabWeb.Street, GetValueByToken(TmpNestedJsonObject, 'street').AsValue().AsText());

                    //no
                    //Evaluate(TabWeb.City, GetValueByToken(JsonObject, 'city').AsValue().AsText());

                    //end;


                    if not TabWeb.Insert(true) then //aggiungi/aggiorno
                        TabWeb.Modify(true);

                end;

            end


        end
    end;

    var
        TabWeb: Record "WebTableUsers";


    local procedure GetValueByToken(Contect: JsonObject; KeyNameToSearch: Text) Result: JsonToken
    var
        TokenNotFoundErr: Label 'Token named %1 not found', Comment = '%1=Key Name to search';
    begin
        if not Contect.SelectToken(KeyNameToSearch, result) then
            Error(TokenNotFoundErr, KeyNameToSearch);
    end;

    // local procedure GetValueByJsonObject(Contect: JsonObject; KeyNameToSearch: Text) Result: JsonObject
    // var
    //     TokenNotFoundErr: Label 'JasonObject named %1 not found', Comment = '%1=Key Name to search';
    //     TmpObject: JsonObject;

    // begin
    //     if not Contect.SelectToken(KeyNameToSearch, result) then
    //         Error(TokenNotFoundErr, KeyNameToSearch);
    // end;
}