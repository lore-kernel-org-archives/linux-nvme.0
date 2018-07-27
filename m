From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Jul 2018 12:26:27 +0200
Subject: [PATCH 1/6] nvme-discover: sanitize options
In-Reply-To: <20180727102632.32455-1-hare@suse.de>
References: <20180727102632.32455-1-hare@suse.de>
Message-ID: <20180727102632.32455-2-hare@suse.de>

The discovery controller doesn't accept any KATO or number of I/O
queue changes, but we do want to change the reconnect delay and
the controller loss timeout.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 Documentation/nvme-discover.txt | 13 ++++++++++++-
 fabrics.c                       |  4 +---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/nvme-discover.txt b/Documentation/nvme-discover.txt
index 4fcf1ca..51d63e4 100644
--- a/Documentation/nvme-discover.txt
+++ b/Documentation/nvme-discover.txt
@@ -14,7 +14,9 @@ SYNOPSIS
 		[--trsvcid=<trsvcid>      | -s <trsvcid>]
 		[--host-traddr=<traddr>   | -w <traddr>]
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
-		[--raw=<filename>         | -r <filename>]
+		[--raw=<filename>	  | -r <filename>]
+		[--reconnect-delay=<#>	  | -c <#>]
+		[--ctrl-loss-tmo=<#>	  | -l <#>]
 
 DESCRIPTION
 -----------
@@ -99,6 +101,15 @@ OPTIONS
 	and dump it to a raw binary file. By default 'nvme discover' will
 	dump the output to stdout.
 
+-c <#>::
+--reconnect-delay=<#>::
+	Overrides the default delay (in seconds) before reconnect is attempted
+	after a connect loss.
+
+-l <#>::
+--ctrl-loss-tmo=<#>::
+	Overrides the default controller loss timeout period (in seconds).
+
 EXAMPLES
 --------
 * Query the Discover Controller with IP4 address 192.168.1.3 for all
diff --git a/fabrics.c b/fabrics.c
index 9aee8f8..ca8aaf7 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -820,12 +820,10 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"host-traddr", 'w', "LIST", CFG_STRING, &cfg.host_traddr, required_argument, "host traddr (e.g. FC WWN's)" },
 		{"hostnqn",     'q', "LIST", CFG_STRING, &cfg.hostnqn,     required_argument, "user-defined hostnqn (if default not used)" },
 		{"hostid",      'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
-		{"queue-size",  'Q', "LIST", CFG_STRING, &cfg.queue_size,  required_argument, "number of io queue elements to use (default 128)" },
-		{"nr-io-queues",'i', "LIST", CFG_STRING, &cfg.nr_io_queues,required_argument, "number of io queues to use (default is core count)" },
 		{"raw",         'r', "LIST", CFG_STRING, &cfg.raw,         required_argument, "raw output file" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
+		{"reconnect-delay", 'c', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_STRING, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
-
 		{NULL},
 	};
 
-- 
2.13.7
