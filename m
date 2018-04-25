From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 25 Apr 2018 11:49:23 -0600
Subject: [PATCH nvme-cli] fabrics: add option to supply keep-alive-timeout for
 connect-all
Message-ID: <20180425174923.9387-1-jthumshirn@suse.de>

Currently we can't supply a keep-alive-timeout when doing a nvme
connect-all, but we can supply it when doing nvme connect.

Bring connect-all in line with connect.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 Documentation/nvme-connect-all.txt | 5 +++++
 fabrics.c                          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/Documentation/nvme-connect-all.txt b/Documentation/nvme-connect-all.txt
index 03adac56f9aa..217268f97559 100644
--- a/Documentation/nvme-connect-all.txt
+++ b/Documentation/nvme-connect-all.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 		[--trsvcid=<trsvcid>      | -s <trsvcid>]
 		[--host-traddr=<traddr>   | -w <traddr>]
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
+		[--keep-alive-tmo=<#>     | -k <#>]
 		[--raw=<filename>         | -r <filename>]
 
 DESCRIPTION
@@ -86,6 +87,10 @@ OPTIONS
 	Overrides the default number of elements in the I/O queues created
 	by the driver.
 
+-k <#>::
+--keep-alive-tmo=<#>::
+	Overrides the default keep alive timeout (in seconds).
+
 EXAMPLES
 --------
 * Connect to all records returned by the Discover Controller with IP4 address
diff --git a/fabrics.c b/fabrics.c
index 62bd3be1636d..7e9d56c61c45 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -821,6 +821,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"queue-size",  'Q', "LIST", CFG_STRING, &cfg.queue_size,  required_argument, "number of io queue elements to use (default 128)" },
 		{"nr-io-queues",'i', "LIST", CFG_STRING, &cfg.nr_io_queues,required_argument, "number of io queues to use (default is core count)" },
 		{"raw",         'r', "LIST", CFG_STRING, &cfg.raw,         required_argument, "raw output file" },
+		{"keep-alive-tmo",  'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{NULL},
 	};
 
-- 
2.16.3
