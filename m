From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 15:36:52 -0800
Subject: [PATCH RFC nvme-cli 5/4] fabrics: pass in number of polling queues
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Message-ID: <20181211233652.9705-6-sagi@grimberg.me>

nr_poll_queues specifies the number of additional queues that will
be connected for hosting polling latency critical I/O.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 Documentation/nvme-connect.txt |  5 +++++
 fabrics.c                      | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
index d4a0e6678475..5412472dbd35 100644
--- a/Documentation/nvme-connect.txt
+++ b/Documentation/nvme-connect.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
 		[--nr-io-queues=<#>       | -i <#>]
 		[--nr-write-queues=<#>    | -W <#>]
+		[--nr-poll-queues=<#>     | -P <#>]
 		[--queue-size=<#>         | -Q <#>]
 		[--keep-alive-tmo=<#>     | -k <#>]
 		[--reconnect-delay=<#>    | -c <#>]
@@ -80,6 +81,10 @@ OPTIONS
 --nr-write-queues=<#>::
 	Adds additional queues that will be used for write I/O.
 
+-P <#>::
+--nr-poll-queues=<#>::
+	Adds additional queues that will be used for polling latency sensitive I/O.
+
 -Q <#>::
 --queue-size=<#>::
 	Overrides the default number of elements in the I/O queues created
diff --git a/fabrics.c b/fabrics.c
index bc6a0b7e4e21..214fce4c1b51 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -54,6 +54,7 @@ static struct config {
 	char *hostid;
 	int  nr_io_queues;
 	int  nr_write_queues;
+	int  nr_poll_queues;
 	int  queue_size;
 	int  keep_alive_tmo;
 	int  reconnect_delay;
@@ -624,6 +625,8 @@ static int build_options(char *argstr, int max_len)
 				cfg.nr_io_queues) ||
 	    add_int_argument(&argstr, &max_len, "nr_write_queues",
 				cfg.nr_write_queues) ||
+	    add_int_argument(&argstr, &max_len, "nr_poll_queues",
+				cfg.nr_poll_queues) ||
 	    add_int_argument(&argstr, &max_len, "queue_size", cfg.queue_size) ||
 	    add_int_argument(&argstr, &max_len, "keep_alive_tmo",
 				cfg.keep_alive_tmo) ||
@@ -704,6 +707,13 @@ retry:
 		p += len;
 	}
 
+	if (cfg.nr_poll_queues) {
+		len = sprintf(p, ",nr_poll_queues=%d", cfg.nr_poll_queues);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	if (cfg.host_traddr) {
 		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
 		if (len < 0)
@@ -1020,6 +1030,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"hostid",          'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
 		{"nr-io-queues",    'i', "LIST", CFG_INT, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
 		{"nr-write-queues",  'W', "LIST", CFG_INT, &cfg.nr_write_queues,    required_argument, "number of write queues to use (default 0)" },
+		{"nr-poll-queues",  'W', "LIST", CFG_INT, &cfg.nr_poll_queues,    required_argument, "number of poll queues to use (default 0)" },
 		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
-- 
2.17.1
