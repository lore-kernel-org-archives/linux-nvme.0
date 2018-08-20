From: hare@suse.de (Hannes Reinecke)
Date: Mon, 20 Aug 2018 12:34:07 +0200
Subject: [PATCH 2/2] nvme-connect: parse 'nvme_info' sysfs attribute for fc
 transport
In-Reply-To: <20180820103407.92783-1-hare@suse.de>
References: <20180820103407.92783-1-hare@suse.de>
Message-ID: <20180820103407.92783-3-hare@suse.de>

The 'nvme_info' sysfs attribute for the SCSI host already contains
all relevant information to issue a NVMe discovery. So for those
cases we could use that information to format a discovery command
and don't have to specify a discovery.conf file.

This patch adds the infrastructure for parsing the information in
the 'nvme_info' sysfs attribute and uses that information to attempt
to connect to the discovery controller on that transport address.

The user can select this feature by using 'nvme discover -t fc'.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 Documentation/nvme-discover.txt |   5 ++
 fabrics.c                       | 193 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/Documentation/nvme-discover.txt b/Documentation/nvme-discover.txt
index b4ae2fc..7a9fad2 100644
--- a/Documentation/nvme-discover.txt
+++ b/Documentation/nvme-discover.txt
@@ -28,6 +28,11 @@ find a /etc/nvme/discovery.conf file to use to supply a list of
 Discovery commands to run.  If no /etc/nvme/discovery.conf file
 exists, the command will quit with an error.
 
+If just --transport=fc is specified, then 'nvme discover' will attempt
+to read the sysfs attribute 'nvme_info' from the SCSI Host sysfs
+directory, and send the Discovery request to the Discovery Controllers
+specified by the transport addresses found in that file.
+
 Otherwise, a specific Discovery Controller should be specified using the
 --transport, --traddr, and if necessary the --trsvcid flags. A Discovery
 request will then be sent to the specified Discovery Controller.
diff --git a/fabrics.c b/fabrics.c
index 9bf2594..190991a 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -34,6 +34,7 @@
 #include <libgen.h>
 #include <sys/stat.h>
 #include <stddef.h>
+#include <limits.h>
 
 #include "parser.h"
 #include "nvme-ioctl.h"
@@ -756,6 +757,193 @@ static int do_discover(char *argstr, bool connect)
 	return ret;
 }
 
+static int parse_nvme_traddr(char *buf, char *portstr,
+			     uint64_t *wwnn, uint64_t *wwpn)
+{
+	char *str = buf, *eptr;
+	char *port;
+
+	port = strstr(str, portstr);
+	if (!port)
+		return 0;
+
+	str = strstr(port, "WWPN");
+	if (!str) {
+		fprintf(stderr, "failed to find WWPN\n");
+		return port - buf;
+	}
+	str += 5;
+	if (*str != 'x') {
+		fprintf(stderr, "parse error looking for WWPN %s\n",
+			str);
+		return str - buf;
+	}
+	str++;
+	*wwpn = strtoul(str, &eptr, 16);
+	if (str == eptr || *wwpn == ULONG_MAX) {
+		fprintf(stderr, "WWPN parse error for %s\n", str);
+		return str - buf;
+	}
+	str = strstr(eptr, "WWNN");
+	if (!str) {
+		fprintf(stderr, "failed to find lport WWNN\n");
+		return eptr - buf;
+	}
+	str += 5;
+	if (*str != 'x') {
+		fprintf(stderr, "parse error looking for WWNN %s\n",
+			str);
+		return str - buf;
+	}
+	str++;
+	*wwnn = strtoul(str, &eptr, 16);
+	if (str == eptr || *wwnn == ULONG_MAX) {
+		fprintf(stderr, "WWNN parse error for %s\n", str);
+		return str - buf;
+	}
+	return eptr - buf;
+}
+
+static int parse_nvme_info(char *nvme_info_path, char *argstr, int max_len,
+			   bool connect)
+{
+	int fd, ret, len;
+	struct stat stat;
+	char *buf, *str, *traddr, *host_traddr;
+	off_t buf_len;
+	uint64_t lpwwpn, lpwwnn, wwpn, wwnn;
+
+	fd = open(nvme_info_path, O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	if (fstat(fd, &stat) < 0) {
+		perror("stat");
+		return -1;
+	}
+	buf = malloc(stat.st_size);
+	if (!buf) {
+		perror("malloc");
+		return -ENOMEM;
+	}
+	buf_len = read(fd, buf, stat.st_size);
+	if (buf_len < 0) {
+		perror("read");
+		return -EIO;
+	}
+	close(fd);
+
+	ret = parse_nvme_traddr(buf, "LPORT", &lpwwnn, &lpwwpn);
+	if (ret <= 0)
+		return -EINVAL;
+
+	ret = asprintf(&host_traddr, "nn-0x%"PRIx64":pn-0x%"PRIx64"",
+		       lpwwnn, lpwwpn);
+	if (ret < 0)
+		return ret;
+
+	cfg.host_traddr = host_traddr;
+
+	str = buf + ret;
+
+	while (str < buf + buf_len) {
+		int err;
+
+		len = parse_nvme_traddr(str, "RPORT", &wwnn, &wwpn);
+		if (len <= 0)
+			break;
+
+		if (asprintf(&traddr, "nn-0x%"PRIx64":pn-0x%"PRIx64"",
+			     wwnn, wwpn) < 0)
+			break;
+
+		cfg.traddr = traddr;
+
+		err = build_options(argstr, BUF_SIZE);
+		if (!err)
+			err = do_discover(argstr, connect);
+
+		if (err)
+			ret = err;
+		free(traddr);
+		cfg.traddr = NULL;
+
+		str += len;
+	}
+	free(buf);
+
+	free(host_traddr);
+	cfg.host_traddr = NULL;
+
+	return ret;
+}
+
+static int scan_sys_nvme_info_filter(const struct dirent *d)
+{
+	if (!strcmp(d->d_name, "nvme_info"))
+		return 1;
+	return 0;
+}
+
+static int discover_scsi_hosts(const char *shost, char *argstr, bool connect)
+{
+	char *path, nvme_path[257];
+	struct dirent **nvme_info;
+	int i, n, ret, max_len = BUF_SIZE;
+
+	ret = asprintf(&path, "/sys/class/scsi_host/%s", shost);
+	if (ret < 0)
+		return -ENOMEM;
+
+	n = scandir(path, &nvme_info, scan_sys_nvme_info_filter, alphasort);
+	if (n < 0)
+		return n;
+
+	for (i = 0; i < n; i++) {
+		strcpy(nvme_path, path);
+		strcat(nvme_path, "/");
+		strncat(nvme_path, nvme_info[i]->d_name, 256);
+		ret += parse_nvme_info(nvme_path, argstr, max_len, connect);
+	}
+
+	for (i = 0; i < n; i++)
+		free(nvme_info[i]);
+
+	free(nvme_info);
+	return ret;
+}
+
+static int scan_sys_scsi_filter(const struct dirent *d)
+{
+	if (!strcmp(d->d_name, "."))
+		return 0;
+	if (!strcmp(d->d_name, ".."))
+		return 0;
+	return 1;
+}
+
+static int discover_from_nvme_info(const char *desc, char *argstr,
+		const struct argconfig_commandline_options *opts, bool connect)
+{
+	struct dirent **scsi_hosts = NULL;
+	int i, n, ret = 0;
+
+	n = scandir("/sys/class/scsi_host", &scsi_hosts, scan_sys_scsi_filter,
+		    alphasort);
+	if (n < 0)
+		return n;
+
+	for (i = 0; i < n; i++)
+		ret += discover_scsi_hosts(scsi_hosts[i]->d_name,
+					   argstr, connect);
+
+	for (i = 0; i < n; i++)
+		free(scsi_hosts[i]);
+
+	free(scsi_hosts);
+	return ret;
+}
+
 static int discover_from_conf_file(const char *desc, char *argstr,
 		const struct argconfig_commandline_options *opts, bool connect)
 {
@@ -844,7 +1032,10 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
-	if (!cfg.transport && !cfg.traddr) {
+	if (cfg.transport && !cfg.traddr && !strncmp(cfg.transport, "fc", 2)) {
+		return discover_from_nvme_info(desc, argstr,
+				command_line_options, connect);
+	} else if (!cfg.transport && !cfg.traddr) {
 		return discover_from_conf_file(desc, argstr,
 				command_line_options, connect);
 	} else {
-- 
2.16.4
