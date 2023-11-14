part of 'swim_course_bloc.dart';

class SwimCourseService {
  Future<List<String>> _fetchSwimSeason() async {
    return <String>['Laufender Sommer', 'Kommender Sommer'];
  }

  Future<List<Course>> getCoursesByBirthDate(DateTime? birthDate) async {
    try {
      String birthDay = DateFormat("yyyy-MM-dd").format(birthDate!);
      final response = await http.get(
        Uri.parse(
            'https://localhost:7226/course/byBirthdate/$birthDay?apiKey=IhrEchterApiKey'),
        //?apiKey=IhrEchterApiKey
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'apiKey': 'IhrEchterApiKey',
        },
      ); //.timeout(const Duration(seconds: 1)); // Hinzufügen eines Timeouts

      if (response.statusCode == 200) {
        List<Course> courses = (json.decode(response.body) as List)
            .map((data) => Course.fromJson(data))
            .toList();
        return courses;
      } else {
        if (kDebugMode) {
          print('Failed with status code: ${response.statusCode}');
        }
        throw Exception(
            'Failed to load courses. Status code: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('No Internet connection: $e');
      }
      throw Exception('No Internet connection');
    } on HttpException catch (e) {
      if (kDebugMode) {
        print('Couldn\'t find the post: $e');
      }
      throw Exception('Couldn\'t find the post');
    } on FormatException catch (e) {
      if (kDebugMode) {
        print('Bad response format: $e');
      }
      throw Exception('Bad response format');
    } catch (e) {
      if (kDebugMode) {
        print('Unknown error: $e');
      }
      throw Exception('Unknown error');
    }
  }
}

class Course {
  final int id;
  final String name;
  final double minAge;
  final double maxAge;
  final String price;
  final String description;
  final int hasFixedDates;
  final String duration;
  final int isCourseVisible;

  const Course({
    required this.id,
    required this.name,
    required this.minAge,
    required this.maxAge,
    required this.price,
    required this.description,
    required this.hasFixedDates,
    required this.duration,
    required this.isCourseVisible});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['courseID'],
        name: json['courseName'],
        minAge: json['courseMinimumAge'].toDouble(),
        maxAge: json['courseMaximumAge'].toDouble(),
        price: json['coursePrice'],
        description: json['courseDescription'],
        hasFixedDates: json['courseHasFixedDates'],
        duration: json['courseDuration'],
        isCourseVisible: json['isCourseVisible']);
  }

  const Course.empty()
      : id = 0,
        name = '',
        minAge = 0,
        maxAge = 0,
        price = '',
        description = '',
        hasFixedDates = 0,
        duration = '',
        isCourseVisible = 0;
}
