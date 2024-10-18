# Instagram Login Checker

This project contains a Dart application that attempts to log in to an Instagram account using a username and password. The application checks whether the provided username and password are valid.

## Requirements

To run this application, you need to install the following libraries:

- [Dart](https://dart.dev/get-dart)
- [http](https://pub.dev/packages/http)

## Installation

1. Install the **Dart SDK** on your computer by following the [Dart installation guide](https://dart.dev/get-dart).
2. Clone this repository or download it as a ZIP:
   ```bash
   git clone https://github.com/username/repository-name.git
   ```
3. Navigate to the project directory:
   ```bash
   cd repository-name
   ```
4. Install the necessary packages:
   ```bash
   dart pub get
   ```

## Usage

1. Fill in the `user` and `password` variables in the `main` function:
   ```dart
   String user = "username"; // Your username
   String password = "password"; // Your password
   ```
2. Run the application:
   ```bash
   dart run
   ```

3. The application will check if the username and password are correct and print a message based on the outcome:
   - If the username and password match: "User and password matching"
   - Otherwise: "No password or user are correct"

## Project Structure

- The `isExists` function attempts to log in to Instagram using the provided username and password.
- The `_getCookieValue` function retrieves the value of a specific cookie from the incoming cookies.
- The `main` function is the entry point of the application and performs the login check.

## Contributing

If you would like to contribute, please create a pull request. All contributions and feedback are welcome.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
