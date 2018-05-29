From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 29 May 2018 11:32:33 +0200
Subject: [PATCH nvme-cli] fabrics: add ctrl-loss-tmo to connect-all
Message-ID: <20180529093233.10286-1-jthumshirn@suse.de>

Similarly to "keep-alive-tmo" a user might want to specify the
"ctrl-loss-tmo" on connect-all as well.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 Documentation/nvme-connect-all.txt | 1 +
 fabrics.c                          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/nvme-connect-all.txt b/Documentation/nvme-connect-all.txt
index 217268f97559..0fa7cda211d4 100644
--- a/Documentation/nvme-connect-all.txt
+++ b/Documentation/nvme-connect-all.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 		[--host-traddr=<traddr>   | -w <traddr>]
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
 		[--keep-alive-tmo=<#>     | -k <#>]
+		[--ctrl-loss-tmo=<#>	  | -l <#>]
 		[--raw=<filename>         | -r <filename>]
 
 DESCRIPTION
diff --git a/fabrics.c b/fabrics.c
index 408afb0d453b..4ae83fd5de02 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -850,6 +850,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"nr-io-queues",'i', "LIST", CFG_STRING, &cfg.nr_io_queues,required_argument, "number of io queues to use (default is core count)" },
 		{"raw",         'r', "LIST", CFG_STRING, &cfg.raw,         required_argument, "raw output file" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
+		{"ctrl-loss-tmo",   'l', "LIST", CFG_STRING, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
+
 		{NULL},
 	};
 
-- 
2.16.3
