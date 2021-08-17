Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10FAC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 15:08:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC2560E78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 15:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EC2560E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wEMOVPp2P2kDKcEz0ckIgSrY7rOTetQZaUIijQg0dW8=; b=Sy+IHq6IbYjrQH
	hklyeAPPqfaW9xWwLn3/JV8ERw1ER4F9CgJ35x7kolXbzG2bzX6u1LTi0hylDwQQPVb6r4UIxBOLU
	SKOP7mt6+JlYzZ+gBhmT1ea0lxSEJ+7avMqSxLA63N5E0g8au7/lUOdPnVD+lEPbymJhbY4Y8zKXl
	ygvZrpGdoNHSwF90A5zHBz/RncyMDTJb3K1TeYu4UKGP7SEgACUN6zU9F1pYNRoc6XK5L40SKpnKU
	slZk6YvkwmcyHPBD2Oim/eTIn3yaY1HvnUba5HOTHaaIwvKPf1Y5Y6LZhxTBTWCK5gBy/bKExxhOR
	xuRqNcKv53NGtTnjzCOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG0gu-002l97-9N; Tue, 17 Aug 2021 15:07:48 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG0gY-002l3M-Su
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 15:07:29 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GpvWg0dGgzYlsK;
 Tue, 17 Aug 2021 23:06:55 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 23:07:18 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 17 Aug
 2021 23:07:17 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <chengjike.cheng@huawei.com>,
 <liuzhouhua@huawei.com>, <lengchao@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli 3/3] add "Status" field in command "nvme huawei list"
Date: Tue, 17 Aug 2021 23:07:15 +0800
Message-ID: <20210817150715.1173-4-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20210817150715.1173-1-chengjike.cheng@huawei.com>
References: <20210817150715.1173-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_080727_617202_18823C35 
X-CRM114-Status: GOOD (  16.04  )
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

When execute the "nvme huawei list" command, it is more intuitive and easy to understand displaying the status of each nvme device.
The "status" of each nvme device is derived from the belonging controller.
Specially, in a multipath environment, when all paths are not live, the device status is "fault". Otherwise, the device status is "live".

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 plugins/huawei/huawei-nvme.c | 100 ++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 6 deletions(-)

diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c
index 40aab5d..65d4c40 100644
--- a/plugins/huawei/huawei-nvme.c
+++ b/plugins/huawei/huawei-nvme.c
@@ -44,6 +44,7 @@
 #define ARRAY_NAME_LEN 80
 #define NS_NAME_LEN    40
 #define NS_EGUID_LEN   33
+#define NS_STATUS_LEN  10
 
 #define MIN_ARRAY_NAME_LEN 16
 #define MIN_NS_NAME_LEN 16
@@ -58,6 +59,7 @@ struct huawei_list_item {
 	char                array_name[ARRAY_NAME_LEN];
 	char                eguid[NS_EGUID_LEN];
 	bool                huawei_device;
+	char                status[NS_STATUS_LEN];
 };
 
 struct huawei_list_element_len {
@@ -67,6 +69,7 @@ struct huawei_list_element_len {
 	unsigned int ns_id;
 	unsigned int usage;
 	unsigned int array_name;
+	unsigned int status;
 };
 
 void huawei_get_attr_data(const char *name, struct huawei_list_item *item)
@@ -154,10 +157,82 @@ void huawei_init_item(struct huawei_list_item *item)
 {
 	memset(item, 0, sizeof(*item));
 	item->huawei_device = false;
+	sprintf(item->status, "%s", "failed");
 	sprintf(item->ns_name, "%s", "----");
 	sprintf(item->array_name, "%s", "----");	 
 }
 
+bool huawei_check_multipath_device(const char *name)
+{
+	int sub_instance , head_instance;
+	char path[280];
+
+	if (sscanf(name, "/dev/nvme%dn%d", &sub_instance, &head_instance) != 2)
+		return false;
+		
+	sprintf(path, "/sys/class/nvme-subsystem/nvme-subsys%d/nvme%dn%d", 
+		sub_instance, sub_instance, head_instance);
+	if (access(path, F_OK) != -1) 
+		return true;
+	return false;
+}
+
+void huawei_get_multipath_device_status(struct huawei_list_item *item)
+{
+	int i, nr_ctrls, subsys_num, ctrl_num, head_num;
+	char path[280];
+	struct dirent **ctrls = NULL;
+	char *temp = NULL;
+
+	sscanf(item->node, "/dev/nvme%dn%d", &subsys_num, &head_num);
+	sprintf(path, "/sys/class/nvme-subsystem/nvme-subsys%d", subsys_num);
+	nr_ctrls = scandir(path, &ctrls, scan_ctrls_filter, alphasort);
+	if (nr_ctrls < 0) 
+		return;
+  
+	for (i = 0; i < nr_ctrls; i++) {
+		sscanf(ctrls[i]->d_name, "nvme%d", &ctrl_num);
+		sprintf(path, "/sys/class/nvme-subsystem/nvme-subsys%d/nvme%d", 
+			subsys_num, ctrl_num);
+		temp = nvme_get_ctrl_attr(path, "state");
+		if (temp == NULL)
+			continue;
+		if (strcmp(temp, "live"))
+			continue;
+		sprintf(item->status, "%s", "active");
+		free(temp);
+	}
+	
+	while (i--)
+		free(ctrls[i]);
+	free(ctrls); 
+	return;
+}
+
+void huawei_get_device_status(struct huawei_list_item *item)
+{
+	bool flag;
+	int m, n;
+	char path[280];
+	char *temp = NULL;
+	
+	sscanf(item->node, "/dev/nvme%dn%d", &m, &n);
+	flag = huawei_check_multipath_device(item->node);
+	if (flag == true) {
+		huawei_get_multipath_device_status(item);
+		return;
+	}
+	
+	sprintf(path, "/sys/class/nvme/nvme%d", m);
+	temp = nvme_get_ctrl_attr(path, "state");
+	if (temp == NULL) 
+		return; 
+	if (!strcmp(temp, "live")) 
+		sprintf(item->status, "%s", "active");
+	free(temp);
+	return;
+}
+
 static int huawei_get_nvme_info(const char *name, struct huawei_list_item *item, const char *node)
 {
 	bool flag;
@@ -170,6 +245,7 @@ static int huawei_get_nvme_info(const char *name, struct huawei_list_item *item,
 
 	item->huawei_device = true;
 	sprintf(item->node, "/dev/%s", name);
+	huawei_get_device_status(item);
 	
 	if (item->ns.vs[0] != 0) {
 		memcpy(item->ns_name, item->ns.vs, NS_NAME_LEN);
@@ -237,6 +313,14 @@ static void huawei_json_print_list_items(struct huawei_list_item *list_items,
 					     "Array Name",
 					     formatter);
 
+		format(formatter, sizeof(formatter),
+			   list_items[i].status,
+			   sizeof(list_items[i].status));
+
+		json_object_add_value_string(device_attrs,
+						"Status",
+						formatter);
+
 		json_array_add_value_object(devices, device_attrs);
 	}
 	json_object_add_value_array(root, "Devices", devices);
@@ -254,18 +338,20 @@ static void huawei_print_list_head(struct huawei_list_element_len element_len)
 		dash[i] = '-';
 	dash[127] = '\0';
 
-	printf("%-*.*s %-*.*s %-*.*s %-*.*s %-*.*s %-*.*s\n",
+	printf("%-*.*s %-*.*s %-*.*s %-*.*s %-*.*s %-*.*s %-*.*s\n",
 		element_len.node, element_len.node, "Node",
 		element_len.ns_name, element_len.ns_name, "NS Name",
 		element_len.nguid, element_len.nguid, "Nguid",
 		element_len.ns_id, element_len.ns_id, "NS ID",
 		element_len.usage, element_len.usage, "Usage",
-		element_len.array_name, element_len.array_name, "Array Name");
+		element_len.array_name, element_len.array_name, "Array Name",
+		element_len.status, element_len.status, "Status");
 
-	printf("%-.*s %-.*s %-.*s %-.*s %-.*s %-.*s\n",
+	printf("%-.*s %-.*s %-.*s %-.*s %-.*s %-.*s %-.*s\n",
 		element_len.node, dash, element_len.ns_name, dash,
 		element_len.nguid, dash, element_len.ns_id, dash,
-		element_len.usage, dash, element_len.array_name, dash);
+		element_len.usage, dash, element_len.array_name, dash,
+		element_len.status, dash);
 }
 
 static void huawei_print_list_item(struct huawei_list_item list_item,
@@ -292,13 +378,14 @@ static void huawei_print_list_item(struct huawei_list_item list_item,
 
 	if (!strlen((char *)list_item.ns.nguid))
 		sprintf(nguid_buf, "%s", list_item.eguid);
-	printf("%-*.*s %-*.*s %-*.*s %-*d %-*.*s %-*.*s\n",
+	printf("%-*.*s %-*.*s %-*.*s %-*d %-*.*s %-*.*s %-*.*s\n",
 		element_len.node, element_len.node, list_item.node,
 		element_len.ns_name, element_len.ns_name, list_item.ns_name,
 		element_len.nguid, element_len.nguid, nguid_buf,
 		element_len.ns_id, list_item.nsid,
 		element_len.usage, element_len.usage, usage,
-		element_len.array_name, element_len.array_name, list_item.array_name);
+		element_len.array_name, element_len.array_name, list_item.array_name,
+		element_len.status, element_len.status, list_item.status);
 
 }
 
@@ -347,6 +434,7 @@ static void huawei_print_list_items(struct huawei_list_item *list_items, unsigne
 	element_len.usage = 26;
 	element_len.ns_name = huawei_get_ns_len(list_items, len, MIN_NS_NAME_LEN);
 	element_len.array_name = huawei_get_array_len(list_items, len, MIN_ARRAY_NAME_LEN);
+	element_len.status= NS_STATUS_LEN;
 
 	huawei_print_list_head(element_len);
 
-- 
2.24.0.windows.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
