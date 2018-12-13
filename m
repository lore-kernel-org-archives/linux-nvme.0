From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 22:38:19 -0800
Subject: [PATCH v2 nvme-cli 7/6] fabrics: pass in number of polling queues
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Message-ID: <20181213063819.13614-8-sagi@grimberg.me>

nr_poll_queues specifies the number of additional queues that will
be connected for hosting polling latency critical I/O.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 Documentation/nvme-connect.txt |  5 +++++
 fabrics.c                      | 10 ++++++++++
 2 files changed, 15 insertions(+)

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
index 5cc1a795345a..efe2ce89cdca 100644
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
-- 
2.17.1
