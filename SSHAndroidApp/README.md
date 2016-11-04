Download JSch (http://sourceforge.net/projects/jsch/files/jsch.jar/0.1.54/jsch-0.1.54.jar/download) and JZlib (https://github.com/ymnk/jzlib/archive/1.1.3.zip)


Add Internet permissions on manifest:

    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        ...
        <uses-permission android:name="android.permission.INTERNET" />
    </manifest>

Add a new module and import jsch.jar (on your root project, right click --> new module)

Create new package on Java folder for JZlib, and copy inside all .java files from JZlib (on /com folder).

Go to Project Structure --> Dependencies tab, and add new dependencie to jsch

Use this code for a first and simple connection:

    public class MainActivity extends AppCompatActivity {

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            new AsyncTask<Integer, Void, Void>(){
                @Override
                protected Void doInBackground(Integer... params) {
                    try {
                        executeRemoteCommand("user", "pass","IP/HOST", PORT);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    return null;
                }
            }.execute(1);
            /*try {
                executeRemoteCommand("user", "pass","IP/HOST", PORT);
            } catch (Exception e) {
                e.printStackTrace();
            }*/
        }

        /*public static String executeRemoteCommand(String username,String password,String hostname,int port)
                throws Exception {
            JSch jsch = new JSch();
            Session session = jsch.getSession(username, hostname, port);
            session.setPassword(password);
            // Avoid asking for key confirmation
            Properties prop = new Properties();
            prop.put("StrictHostKeyChecking", "no");
            session.setConfig(prop);
            session.connect();
            // SSH Channel
            ChannelExec channelssh = (ChannelExec)
                    session.openChannel("exec");
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            channelssh.setOutputStream(baos);
            // Execute command
            channelssh.setCommand("ls > /home/pi/test.txt");
            channelssh.connect();
            channelssh.disconnect();
            return baos.toString();
        }*/

        public static String executeRemoteCommand(
                String username,
                String password,
                String hostname,
                int port) throws Exception {

            JSch jsch = new JSch();
            Session session = jsch.getSession(username, hostname, port);
            session.setPassword(password);

            // Avoid asking for key confirmation
            Properties prop = new Properties();
            prop.put("StrictHostKeyChecking", "no");
            session.setConfig(prop);

            session.connect();

            // SSH Channel
            ChannelExec channelssh = (ChannelExec)
                    session.openChannel("exec");
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            channelssh.setOutputStream(baos);

            // Execute command
            channelssh.setCommand("ls > /home/pi/test.txt");
            channelssh.connect();
            channelssh.disconnect();

            return baos.toString();
        }
    }

If you have a problem like

    Execution failed for task app:transformClassesWithInstantRunForDebug'.JSR/RET are not supported with computeFrames option

Try to desable Instant Run from Preferences --> Build, Execution, Deployment --> Unchek Instant Run
sources:

http://eridem.net/android-tip-021-ssh-execute-remote-commands-with-android/

http://stackoverflow.com/questions/15019936/android-import-library

http://stackoverflow.com/questions/14323661/simple-ssh-connect-with-jsch

http://stackoverflow.com/questions/38239607/error-jsr-ret-are-not-supported-with-computeframes-option
