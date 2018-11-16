From: hare@suse.de (Hannes Reinecke)
Date: Fri, 16 Nov 2018 08:34:59 +0100
Subject: [PATCH nvme-cli 1/3] nvme: introduce get_nvme_ctrl_attr()
In-Reply-To: <20181116073501.7867-1-hare@suse.de>
References: <20181116073501.7867-1-hare@suse.de>
Message-ID: <20181116073501.7867-2-hare@suse.de>

Use a generic function 'get_nvme_ctrl_attr()' instead of coding
the same function for each sysfs attribute.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 nvme.c | 98 ++++++++++++++++++------------------------------------------------
 1 file changed, 27 insertions(+), 71 deletions(-)

diff --git a/nvme.c b/nvme.c
index 1df3a10..f15d372 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1290,103 +1290,58 @@ close_fd:
 	return subsysnqn;
 }
 
-static char *get_nvme_ctrl_transport(char *path)
+static char *get_nvme_ctrl_attr(char *path, const char *attr)
 {
-	char *trpath;
-	char *transport;
-	int fd;
-	ssize_t ret;
-
-	ret = asprintf(&trpath, "%s/transport", path);
-	if (ret < 0)
-		return NULL;
-
-	transport = calloc(1, 1024);
-	if (!transport)
-		goto err_free_trpath;
-
-	fd = open(trpath, O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "Failed to open %s: %s\n",
-				trpath, strerror(errno));
-		goto err_free_tr;
-	}
-
-	ret = read(fd, transport, 1024);
-	if (ret < 0) {
-		fprintf(stderr, "read :%s :%s\n", trpath, strerror(errno));
-		goto err_close_fd;
-	}
-
-	if (transport[strlen(transport) - 1] == '\n')
-		transport[strlen(transport) - 1] = '\0';
-
-	close(fd);
-	free(trpath);
-
-	return transport;
-
-err_close_fd:
-	close(fd);
-err_free_tr:
-	free(transport);
-err_free_trpath:
-	free(trpath);
-
-	return NULL;
-}
-
-static char *get_nvme_ctrl_address(char *path)
-{
-	char *addrpath;
-	char *address;
+	char *attrpath;
+	char *value;
 	int fd;
 	ssize_t ret;
 	int i;
 
-	ret = asprintf(&addrpath, "%s/address", path);
+	ret = asprintf(&attrpath, "%s/%s", path, attr);
 	if (ret < 0)
 		return NULL;
 
-	address = calloc(1, 1024);
-	if (!address)
-		goto err_free_addrpath;
+	value = calloc(1, 1024);
+	if (!value)
+		goto err_free_path;
 
-	fd = open(addrpath, O_RDONLY);
+	fd = open(attrpath, O_RDONLY);
 	if (fd < 0) {
 		fprintf(stderr, "Failed to open %s: %s\n",
-				addrpath, strerror(errno));
-		goto err_free_addr;
+				attrpath, strerror(errno));
+		goto err_free_value;
 	}
 
-	ret = read(fd, address, 1024);
+	ret = read(fd, value, 1024);
 	if (ret < 0) {
-		fprintf(stderr, "read :%s :%s\n", addrpath, strerror(errno));
+		fprintf(stderr, "read :%s :%s\n", attrpath, strerror(errno));
 		goto err_close_fd;
 	}
 
-	if (address[strlen(address) - 1] == '\n')
-		address[strlen(address) - 1] = '\0';
+	if (value[strlen(value) - 1] == '\n')
+		value[strlen(value) - 1] = '\0';
 
-	for (i = 0; i < strlen(address); i++) {
-		if (address[i] == ',' )
-			address[i] = ' ';
+	for (i = 0; i < strlen(value); i++) {
+		if (value[i] == ',' )
+			value[i] = ' ';
 	}
 
 	close(fd);
-	free(addrpath);
+	free(attrpath);
 
-	return address;
+	return value;
 
 err_close_fd:
 	close(fd);
-err_free_addr:
-	free(address);
-err_free_addrpath:
-	free(addrpath);
+err_free_value:
+	free(value);
+err_free_path:
+	free(attrpath);
 
 	return NULL;
 }
+
 static int scan_ctrls_filter(const struct dirent *d)
 {
 	int id, nsid;
@@ -1445,7 +1400,8 @@ static int get_nvme_subsystem_info(char *name, char *path,
 		snprintf(ctrl_path, sizeof(ctrl_path), "%s/%s", path,
 			 item->ctrls[ccnt].name);
 
-		item->ctrls[ccnt].address = get_nvme_ctrl_address(ctrl_path);
+		item->ctrls[ccnt].address =
+				get_nvme_ctrl_attr(ctrl_path, "address");
 		if (!item->ctrls[ccnt].address) {
 			fprintf(stderr, "failed to get controller[%d] address.\n", i);
 			free_ctrl_list_item(&item->ctrls[ccnt]);
@@ -1453,7 +1409,7 @@ static int get_nvme_subsystem_info(char *name, char *path,
 		}
 
 		item->ctrls[ccnt].transport =
-				get_nvme_ctrl_transport(ctrl_path);
+				get_nvme_ctrl_attr(ctrl_path, "transport");
 		if (!item->ctrls[ccnt].transport) {
 			fprintf(stderr, "failed to get controller[%d] transport.\n", i);
 			free_ctrl_list_item(&item->ctrls[ccnt]);
-- 
2.13.7
