Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB6FC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 15:08:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C7961073
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 15:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15C7961073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+h/M/cjHQB+B/VOQK92DXHQ5/K2JFkfxcxeMJjId2pc=; b=2CXybvlsnm56DI
	4wdB167PK9bjQe4o1nqohmtLDrycmtR6B+Tverz7DuBIXdJkHbzhNhKqNZCqwbgGx/ieK7Q7S5uZn
	cuB9VtclrGGTXHT3E/5Sn+57nkkt878tjGUnv3iG5Yo/PniIk3PKGOHOC4JoRKtbodZqanAA7bbDZ
	f+iTYfCzr9f9KhKn9lT6wSJMt6kelT+12pVGQNDrj/3GkE56+dNTDUO3MTRe2cdtGRDnREPKqRxMa
	0x48Z9nKh/bJLbE3m+D9cutD7knDN61ppoEydqBFC89sqe1xd39nNcdBViAvlDOTIn7FbUhfU2fky
	hViazn7apCtr2qTkYaFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG0h8-002lDo-P9; Tue, 17 Aug 2021 15:08:02 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG0ga-002l3H-N7
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 15:07:31 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GpvWz07xTz82G3;
 Tue, 17 Aug 2021 23:07:11 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 23:07:17 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 17 Aug
 2021 23:07:17 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <chengjike.cheng@huawei.com>,
 <liuzhouhua@huawei.com>, <lengchao@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli 2/3] show fault devices in command "nvme huawei list"
Date: Tue, 17 Aug 2021 23:07:14 +0800
Message-ID: <20210817150715.1173-3-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20210817150715.1173-1-chengjike.cheng@huawei.com>
References: <20210817150715.1173-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_080729_380026_39163281 
X-CRM114-Status: GOOD (  17.56  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If there are some fault nvme devices, when execute the "nvme huawei list" command, it doesn't show nvme devices
(the program will exit when the context of fault device can not be obtained from NVMe Subsystem).
In this situation, the displaying content of fault devices can be obtained from
the device attribute files(such as "nsid" can be obtained from the file "/sys/block/nvme0n1/nsid").

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 plugins/huawei/huawei-nvme.c | 132 +++++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 36 deletions(-)

diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c
index f36c7a5..40aab5d 100644
--- a/plugins/huawei/huawei-nvme.c
+++ b/plugins/huawei/huawei-nvme.c
@@ -43,6 +43,7 @@
 #define HW_SSD_PCI_VENDOR_ID 0x19E5
 #define ARRAY_NAME_LEN 80
 #define NS_NAME_LEN    40
+#define NS_EGUID_LEN   33
 
 #define MIN_ARRAY_NAME_LEN 16
 #define MIN_NS_NAME_LEN 16
@@ -55,6 +56,7 @@ struct huawei_list_item {
 	unsigned            block;
 	char                ns_name[NS_NAME_LEN];
 	char                array_name[ARRAY_NAME_LEN];
+	char                eguid[NS_EGUID_LEN];
 	bool                huawei_device;
 };
 
@@ -67,56 +69,114 @@ struct huawei_list_element_len {
 	unsigned int array_name;
 };
 
-static int huawei_get_nvme_info(int fd, struct huawei_list_item *item, const char *node)
+void huawei_get_attr_data(const char *name, struct huawei_list_item *item)
 {
+	char *wwid = NULL;
+	char *nsid = NULL;
+	char *eguid = NULL;
+	char path[280];
+
+	sprintf(path, "/sys/block/%s", name);
+	wwid = nvme_get_ctrl_attr(path, "wwid");
+	if (wwid == NULL) 
+		return;
+
+	eguid = strrchr(wwid, '.');
+	if (eguid)
+		sprintf(item->eguid, "%s", &eguid[1]);;
+	free(wwid);
+
+	nsid = nvme_get_ctrl_attr(path, "nsid");
+	if (nsid == NULL) 
+		return;
+	item->nsid = atoi(nsid);
+	free(nsid);
+	return;
+}
+
+int huawei_get_device_data(const char *name, struct huawei_list_item *item)
+{
+	int fd;
 	int err;
-	int len;
+	char path[280];
 	struct stat nvme_stat_info;
 
-	memset(item, 0, sizeof(*item));
-
+	sprintf(path, "/dev/%s", name);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		goto out_get_attr;
+	
 	err = nvme_identify_ctrl(fd, &item->ctrl);
 	if (err)
-		return err;
+		goto out_close;
 
-	/*identify huawei device*/
-	if (strstr(item->ctrl.mn, "Huawei") == NULL &&
-	    le16_to_cpu(item->ctrl.vid) != HW_SSD_PCI_VENDOR_ID) {
-		item->huawei_device = false;
-		return 0;
-	}
+	err = fstat(fd, &nvme_stat_info);
+	if (err < 0)
+		goto out_close;
 
-	item->huawei_device = true;
 	item->nsid = nvme_get_nsid(fd);
+	item->block = S_ISBLK(nvme_stat_info.st_mode);
 	err = nvme_identify_ns(fd, item->nsid, 0, &item->ns);
 	if (err)
-		return err;
+		goto out_close;
+	close(fd);
+	return 0;
+out_close:
+	close(fd);
+out_get_attr:
+ 	huawei_get_attr_data(name, item);
+	return 0;
+}
 
-	err = fstat(fd, &nvme_stat_info);
-	if (err < 0)
-		return err;
+bool huawei_check_device(const char *name, struct huawei_list_item *item)
+{	 
+	char path[280];
+	char *model = NULL;
+	bool flag = false;
 
-	strcpy(item->node, node);
-	item->block = S_ISBLK(nvme_stat_info.st_mode);
-
-	if (item->ns.vs[0] == 0) {
+	/*identify huawei device*/
+	if (strstr(item->ctrl.mn, "Huawei") != NULL ||
+		le16_to_cpu(item->ctrl.vid) == HW_SSD_PCI_VENDOR_ID) {
+		return true;
+	}
 
-		len = snprintf(item->ns_name, NS_NAME_LEN, "%s", "----");
-		if (len < 0)
-			return -EINVAL;
+	sprintf(path, "/sys/block/%s/device", name);
+	model = nvme_get_ctrl_attr(path, "model");
+	if (model != NULL) {
+		if(strstr(model, "Huawei") != NULL)
+			flag = true;
+		free(model);
 	}
-	else {
+	return flag;
+}
+
+void huawei_init_item(struct huawei_list_item *item)
+{
+	memset(item, 0, sizeof(*item));
+	item->huawei_device = false;
+	sprintf(item->ns_name, "%s", "----");
+	sprintf(item->array_name, "%s", "----");	 
+}
+
+static int huawei_get_nvme_info(const char *name, struct huawei_list_item *item, const char *node)
+{
+	bool flag;
+	
+	huawei_init_item(item);
+	huawei_get_device_data(name, item);
+	flag = huawei_check_device(name, item);
+	if (flag == false)
+		return -EINVAL;
+
+	item->huawei_device = true;
+	sprintf(item->node, "/dev/%s", name);
+	
+	if (item->ns.vs[0] != 0) {
 		memcpy(item->ns_name, item->ns.vs, NS_NAME_LEN);
 		item->ns_name[NS_NAME_LEN - 1] = '\0';
 	}
 
-	if (item->ctrl.vs[0] == 0) {
-
-		len = snprintf(item->array_name, ARRAY_NAME_LEN, "%s", "----");
-	if (len < 0)
-			return -EINVAL;
-	}
-	else {
+	if (item->ctrl.vs[0] != 0) {
 		memcpy(item->array_name, item->ctrl.vs, ARRAY_NAME_LEN);
 		item->array_name[ARRAY_NAME_LEN - 1] = '\0';
 	}
@@ -230,6 +290,8 @@ static void huawei_print_list_item(struct huawei_list_item list_item,
 	for (i = 0; i < sizeof(list_item.ns.nguid); i++)
 		nguid += sprintf(nguid, "%02x", list_item.ns.nguid[i]);
 
+	if (!strlen((char *)list_item.ns.nguid))
+		sprintf(nguid_buf, "%s", list_item.eguid);
 	printf("%-*.*s %-*.*s %-*.*s %-*d %-*.*s %-*.*s\n",
 		element_len.node, element_len.node, list_item.node,
 		element_len.ns_name, element_len.ns_name, list_item.ns_name,
@@ -298,7 +360,7 @@ static int huawei_list(int argc, char **argv, struct command *command,
 	char path[264];
 	struct dirent **devices;
 	struct huawei_list_item *list_items;
-	unsigned int i, n, fd, ret;
+	unsigned int i, n, ret;
 	unsigned int huawei_num = 0;
 	int fmt;
 	int ctrl, ns, part;
@@ -334,11 +396,9 @@ static int huawei_list(int argc, char **argv, struct command *command,
 	for (i = 0; i < n; i++) {
 		if (sscanf(devices[i]->d_name, "nvme%dn%dp%d", &ctrl, &ns, &part) == 3) 
 			continue;
-		snprintf(path, sizeof(path), "/dev/%s", devices[i]->d_name);
-		fd = open(path, O_RDONLY);
-		ret = huawei_get_nvme_info(fd, &list_items[huawei_num], path);
+		ret = huawei_get_nvme_info(devices[i]->d_name, &list_items[huawei_num], path);
 		if (ret)
-			return ret;
+			continue;
 		if (list_items[huawei_num].huawei_device == true) {
 			huawei_num++;
 		}
-- 
2.24.0.windows.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
