Download JSch (http://sourceforge.net/projects/jsch/files/jsch.jar/0.1.54/jsch-0.1.54.jar/download) and JZlib (https://github.com/ymnk/jzlib/archive/1.1.3.zip)

On your project, add a new dependency and import jsch.jar

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
