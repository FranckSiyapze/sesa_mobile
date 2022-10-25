import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sesa/core/services/http_service.dart';

class ApiService {
  late HttpService _http;
  final Dio dio = Dio();

  ApiService() {
    _http = GetIt.instance.get<HttpService>();
  }

  Future login({required String email, required String pwd}) async {
    Map dataFinal;
    //User data;
    try {
      Response _response = await _http.post(
        '/auth/sign-in',
        body: {
          "username": email,
          "password": pwd,
          'appProvider': 'mobile',
        },
      );
      print("Login response : ${_response}");
      if (_response.statusCode == 200) {
        Map _data = _response.data;

        //print(_data);
        if (_response.statusCode == 200) {
          dataFinal = {
            "status": 200,
            "data": _data,
            "message": "Congratulation the operation was made successfully",
          };
          print("connexion reussi");
          return dataFinal;
        } else {
          dataFinal = {
            "status": _data["status"],
            "message": "Sorry we had an issue with our server",
          };
          print("connexion ECHEC");
          return dataFinal;
        }
      } else {
        dataFinal = {
          "status": 500,
          "message": "Une erreur est survenue",
        };
        print("connexion erreur est survenue");
        return dataFinal;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        //return e.message;
        dataFinal = {
          "status": 500,
          "message": "Connection Timeout please restart the process",
        };
        print("Connection Timeout please restart the process");
        return dataFinal;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        dataFinal = {
          "status": 500,
          "message": "Server ERROR : RECEIVE TIMEOUT Contact the administrator",
        };
        print("Server ERROR : RECEIVE TIMEOUT Contact the administrator");
        return dataFinal;
      }
      if (e.type == DioErrorType.other) {
        dataFinal = {
          "status": 500,
          "message":
              "Server ERROR : Could not send request, Contact the administrator",
        };
        print(
            "Server ERROR : Could not send request, Contact the administrator");
        return dataFinal;
      } else {
        dataFinal = {
          "status": 500,
          "message":
              "Server ERROR : Could not send request, Contact the administrator",
        };
        print(e.message);
        print(
            "Server ERROR : Could not send request, Contact the administrator1");
        return dataFinal;
      }
    } catch (e) {
      print(e);
      dataFinal = {
        "status": 500,
        "message": "Une erreur est survenue",
      };
      print("Une erreur est survenue");
      return dataFinal;
    }
  }


  Future getDoctors() async {
    Map dataFinal;
    //String email = await readStorage(value: "email");
    try {
      Response response =
          await _http.getRequest("/user/doctor?sortBy=userId");
      //print("the response is $response");
      if (response.statusCode == 200) {
        Map _data = response.data;
        //print(_data);
        if (response.statusCode == 200) {
          dataFinal = {
            "status": 200,
            "message": "Get Data sucessfully",
            "data": _data["content"]
          };
          //print("connexion reussi");
          return dataFinal;
        }
      } else {
        dataFinal = {
          "status": response.statusCode,
          "message": "Une erreur est survenue",
        };
        print("connexion erreur est survenue");
        return dataFinal;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        //return e.message;
        dataFinal = {
          "status": 500,
          "message": "Connection Timeout please restart the process",
        };
        print("Connection Timeout please restart the process");
        return dataFinal;
      }
      if (e.type == DioErrorType.receiveTimeout) {
        dataFinal = {
          "status": 500,
          "message": "Server ERROR : RECEIVE TIMEOUT Contact the administrator",
        };
        print("Server ERROR : RECEIVE TIMEOUT Contact the administrator");
        return dataFinal;
      }
      if (e.type == DioErrorType.other) {
        dataFinal = {
          "status": 500,
          "message":
              "Server ERROR : Could not send request, Contact the administrator",
        };
        print(
            "Server ERROR : Could not send request, Contact the administrator");
        return dataFinal;
      } else {
        dataFinal = {
          "status": 500,
          "message":
              "Server ERROR : Could not send request, Contact the administrator",
        };
        print(
            "Server ERROR : Could not send request, Contact the administrator");
        return dataFinal;
      }
    } catch (e) {
      print(e);
      dataFinal = {
        "status": 500,
        "message": "Une erreur est survenue",
      };
      print("Une erreur est survenue");
      return dataFinal;
    }
  }

}
