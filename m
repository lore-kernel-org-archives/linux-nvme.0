From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 10 May 2017 11:04:12 +0200
Subject: [PATCH nvme-cli] fabrics: add option to override drivers queue depth
Message-ID: <20170510090412.14132-1-jthumshirn@suse.de>

Currently it is not possible to override the fabrics drivers default queue
depth with the nvme userspace utility, but only when manually writing the
parameters to the /dev/nvme-fabrics character device.

Add an option to override the drivers default queue depth for NVMe over
fabrics.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 Documentation/nvme-connect.txt |  6 ++++++
 fabrics.c                      | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
index 38fae39..a746a3a 100644
--- a/Documentation/nvme-connect.txt
+++ b/Documentation/nvme-connect.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 		[--host-traddr=<traddr>   | -w <traddr>]
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
 		[--nr-io-queues=<#>       | -i <#>]
+		[--queue-size=<#>         | -Q <#>]
 		[--keep-alive-tmo=<#>     | -k <#>]
 		[--reconnect-delay=<#>    | -c <#>]
 
@@ -73,6 +74,11 @@ OPTIONS
 --nr-io-queues=<#>::
 	Overrides the default number of I/O queues create by the driver.
 
+-Q <#>::
+--queue-size=<#>::
+	Overrides the default number of elements in the I/O queues created
+	by the driver.
+
 -k <#>::
 --keep-alive-tmo=<#>::
 	Overrides the default keep alive timeout (in seconds).
diff --git a/fabrics.c b/fabrics.c
index 6648bae..a826ecc 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -52,6 +52,7 @@ static struct config {
 	char *host_traddr;
 	char *hostnqn;
 	char *nr_io_queues;
+	char *queue_size;
 	char *keep_alive_tmo;
 	char *reconnect_delay;
 	char *raw;
@@ -524,6 +525,15 @@ static int build_options(char *argstr, int max_len)
 		max_len -= len;
 	}
 
+	if (cfg.queue_size) {
+		len = snprintf(argstr, max_len, ",queue_size=%s",
+				cfg.queue_size);
+		if (len < 0)
+			return -EINVAL;
+		argstr += len;
+		max_len -= len;
+	}
+
 	if (cfg.keep_alive_tmo) {
 		len = snprintf(argstr, max_len, ",keep_alive_tmo=%s", cfg.keep_alive_tmo);
 		if (len < 0)
@@ -805,6 +815,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"host-traddr",     'w', "LIST", CFG_STRING, &cfg.host_traddr,     required_argument, "host traddr (e.g. FC WWN's)" },
 		{"hostnqn",         'q', "LIST", CFG_STRING, &cfg.hostnqn,         required_argument, "user-defined hostnqn" },
 		{"nr-io-queues",    'i', "LIST", CFG_STRING, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
+		{"queue-size",      'Q', "LIST", CFG_STRING, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{NULL},
-- 
1.8.5.6
