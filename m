From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 02:49:36 -0800
Subject: [PATCH nvme-cli 6/5] fabrics: pass in nr_write_queues
In-Reply-To: <20181211104936.25333-1-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
Message-ID: <20181211104936.25333-7-sagi@grimberg.me>

nr_write_queues specifies the number of queues additional to nr_io_queues
will be connected. These queues will host write I/O (host to target
payload) while nr_io_queues will host read I/O (target to host payload).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 93f3410a1c72..55ce2ba79c4f 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -53,6 +53,7 @@ static struct config {
 	char *hostnqn;
 	char *hostid;
 	int  nr_io_queues;
+	int  nr_write_queues;
 	int  queue_size;
 	int  keep_alive_tmo;
 	int  reconnect_delay;
@@ -621,6 +622,8 @@ static int build_options(char *argstr, int max_len)
 		    add_argument(&argstr, &max_len, "hostid", cfg.hostid)) ||
 	    add_int_argument(&argstr, &max_len, "nr_io_queues",
 				cfg.nr_io_queues) ||
+	    add_int_argument(&argstr, &max_len, "nr_write_queues",
+				cfg.nr_write_queues) ||
 	    add_int_argument(&argstr, &max_len, "queue_size", cfg.queue_size) ||
 	    add_int_argument(&argstr, &max_len, "keep_alive_tmo",
 				cfg.keep_alive_tmo) ||
@@ -694,6 +697,13 @@ retry:
 		p += len;
 	}
 
+	if (cfg.nr_write_queues) {
+		len = sprintf(p, ",nr_write_queues=%d", cfg.nr_write_queues);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	if (cfg.host_traddr) {
 		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
 		if (len < 0)
@@ -1009,6 +1019,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"hostnqn",         'q', "LIST", CFG_STRING, &cfg.hostnqn,         required_argument, "user-defined hostnqn" },
 		{"hostid",          'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
 		{"nr-io-queues",    'i', "LIST", CFG_INT, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
+		{"nr_write_queues",  'W', "LIST", CFG_INT, &cfg.nr_write_queues,    required_argument, "number of write queues to use (default 0)" },
 		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
-- 
2.17.1
