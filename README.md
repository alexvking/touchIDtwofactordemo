# Alex King
# COMP 116 Final Project

### Supporting Material

For my supporting material, I wrote a simple iOS application that uses Touch ID
to support two-factor authentication. Though it is a simple example, it demonstrates
how easy it is for existing apps to add two-factor authentication to their code.

I provide a short video to demonstrate the app functionality. In the video, the user
first authenticates using a fingerprint registered with Touch ID. Then, they are prompted for a password. The app is designed so that access will not be granted until
the correct password is entered. The first password attemped, "mchow", does not work, so the user is once more prompted for a password. The second password, "secret!", works successfully, and the user becomes authenticated.