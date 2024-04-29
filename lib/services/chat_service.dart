import 'package:http/http.dart' as http;
import 'key1.dart';
import 'key2.dart';
import 'chat_request.dart';
import 'chat_response.dart';

class ChatService {
  static final Uri chatUri = Uri.parse('https://api.openai.com/v1/chat/completions');
  
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${ApiKey1.openAIApiKey.replaceAll("_","") + ApiKey2.openAIApiKey.replaceAll("_","")}',
  };

  Future<String?> request(List prompt) async {
    try {
      if (prompt.isEmpty || prompt.length < 3) {
        return null;
      }
      String body = "Strictly follow the format and do not create any additional new line; create a multiple choices quiz with " + prompt[2] + " questions for " + prompt[0] + ", in particularly, " + prompt[1] + " also provide answer with explanation for that answer at bottom:\n\"Quiz:\n\nQuestion1: *content here*\nOption1: *content here*\nOption2: *content here*\nOption3: *content here*\nOption4: *content here*\n\nQuestion2\nOption1\nOption2\nOption3\nOption4\n\nAnswer:\n\nQuestion1:Option*: *answer here*\nExplanation: *explain here*";
      ChatRequest request = ChatRequest(model: "gpt-3.5-turbo", messages: [Message(role: "system", content: body)]);
      http.Response response = await http.post(
        chatUri,
        headers: headers,
        body: request.toJson(),
      );
      ChatResponse chatResponse = ChatResponse.fromResponse(response);
      print(chatResponse.choices?[0].message?.content);
      return chatResponse.choices?[0].message?.content;
    } catch (e) {
      print("error $e");
    }
    return null;
  }
}