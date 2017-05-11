From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 11 May 2017 19:48:37 +0200
Subject: [PATCH nvme-cli] fabrics: add option to override drivers queue depth
 also for connect-all command
Message-ID: <20170511174837.17936-1-jthumshirn@suse.de>

Currently it is not possible to override the fabrics drivers default
queue depth with the nvme userspace utility's 'connect-all' command,
but only when using the 'connect' command.

Add an option to override the drivers default queue depth for NVMe
over fabrics with the 'connect-all' command as we did previouslt with the
'connect' command.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 Documentation/nvme-connect-all.txt | 5 +++++
 fabrics.c                          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/Documentation/nvme-connect-all.txt b/Documentation/nvme-connect-all.txt
index b4b3e40..03adac5 100644
--- a/Documentation/nvme-connect-all.txt
+++ b/Documentation/nvme-connect-all.txt
@@ -81,6 +81,11 @@ OPTIONS
 	and dump it to a raw binary file. By default 'nvme connect-all' will
 	dump the output to stdout.
 
+-Q <#>::
+--queue-size=<#>::
+	Overrides the default number of elements in the I/O queues created
+	by the driver.
+
 EXAMPLES
 --------
 * Connect to all records returned by the Discover Controller with IP4 address
diff --git a/fabrics.c b/fabrics.c
index a826ecc..bbcca47 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -782,6 +782,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"trsvcid",     's', "LIST", CFG_STRING, &cfg.trsvcid,     required_argument, "transport service id (e.g. IP port)" },
 		{"host-traddr", 'w', "LIST", CFG_STRING, &cfg.host_traddr, required_argument, "host traddr (e.g. FC WWN's)" },
 		{"hostnqn",     'q', "LIST", CFG_STRING, &cfg.hostnqn,     required_argument, "user-defined hostnqn (if default not used)" },
+		{"queue-size",  'Q', "LIST", CFG_STRING, &cfg.queue_size,  required_argument, "number of io queue elements to use (default 128)" },
 		{"raw",         'r', "LIST", CFG_STRING, &cfg.raw,         required_argument, "raw output file" },
 		{NULL},
 	};
-- 
2.12.0
