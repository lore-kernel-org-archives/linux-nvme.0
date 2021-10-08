Return-Path: <SRS0=1aKD=O4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8915C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 12:26:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8440A60F44
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 12:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8440A60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ngWlUMQ4+A7XIDakUsi4T3NN228aR9GqjUzkMeCwSA=; b=GlNlLYP4+Oz6Hu
	UjZg6Tm9BkUO2uDGhomkpkkL36hI231jiSyB5gnIWYiql0uwYL15hfBQwc5Y5BjC5sBoIYrjN1LIu
	yX2oQk0Rjj8rx0cHOuofMEqFf5gzzF3OTLs4lU7Mr5AUTQyIpkEBk7fKZ4txLxYMflt9OXr3fXWBL
	itvTIBQSVn+jkl4aSp8koIl9WxTyjd2RahWdl9xn57xf1uKYI3hvGHBb1r7CCB3bs3LH0gEpKnCbP
	DbWHcSZ7s18GX4VSG/7xk2bTk83akb8Y8sphiETtzNSpvgcH5MHmcI0tnL9fwzeAfxPBmrRQoVNYV
	d0wRitMcaqbRvsDM4JzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mYoxO-002hBH-60; Fri, 08 Oct 2021 12:26:34 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYowo-002gvW-3o
 for linux-nvme@lists.infradead.org; Fri, 08 Oct 2021 12:26:01 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HQnNr0bNBzYfND;
 Fri,  8 Oct 2021 20:21:32 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 20:25:56 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 20:25:55 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, 
 <chaitanyak@nvidia.com>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH V4 nvme-cli 3/3] add "Path Access" field in command "nvme list"
Date: Fri, 8 Oct 2021 20:25:53 +0800
Message-ID: <20211008122553.1779-4-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20211008122553.1779-1-chengjike.cheng@huawei.com>
References: <20211008122553.1779-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211008_052558_581886_51371C66 
X-CRM114-Status: GOOD (  11.19  )
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

When users run commands such as nvme list, nvme list -o json, nvme list -v -o json,
"Path Access" entry of each disk is printed if NVMe MultiPath is
configured(Non-multipath disk does not display "Path Access").
The value of /sys/module/nvme_core/parameters/multipath is used to determine
whether the disk is nvme native multipath device.

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 nvme-print.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 6c330d8..faf8e7c 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -5734,22 +5734,71 @@ void nvme_show_list_item(nvme_ns_t n)
 		nvme_ns_get_firmware(n));
 }
 
+void nvme_show_mpath_list_item(nvme_ns_t n)
+{
+	char usage[128] = { 0 }, format[128] = { 0 };
+
+	long long lba = nvme_ns_get_lba_size(n);
+	double nsze = nvme_ns_get_lba_count(n) * lba;
+	double nuse = nvme_ns_get_lba_util(n) * lba;
+
+	const char *s_suffix = suffix_si_get(&nsze);
+	const char *u_suffix = suffix_si_get(&nuse);
+	const char *l_suffix = suffix_binary_get(&lba);
+
+	snprintf(usage, sizeof(usage), "%6.2f %2sB / %6.2f %2sB", nuse,
+		u_suffix, nsze, s_suffix);
+	snprintf(format, sizeof(format), "%3.0f %2sB + %2d B", (double)lba,
+		l_suffix, nvme_ns_get_meta_size(n));
+
+	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s %-12s\n",
+		nvme_ns_get_name(n), nvme_ns_get_serial(n),
+		nvme_ns_get_model(n), nvme_ns_get_nsid(n), usage, format,
+		nvme_ns_get_firmware(n), nvme_ns_get_access(n));
+}
+
+
+static bool nvme_check_mpath()
+{
+	char *mpath = NULL;
+
+	mpath = nvme_get_attr("/sys/module/nvme_core/parameters", "multipath");  
+	if (!mpath)
+		return false;
+
+	if (!strcmp(mpath, "Y")) {
+		free(mpath);
+		return true;
+	}
+
+	free(mpath);
+	return false;
+}
+
 static void nvme_show_simple_list(nvme_root_t r)
 {
 	nvme_host_t h;
 	nvme_subsystem_t s;
 	nvme_ctrl_t c;
 	nvme_ns_t n;
+	bool flag = nvme_check_mpath();
 
-	printf("%-21s %-20s %-40s %-9s %-26s %-16s %-8s\n",
-	    "Node", "SN", "Model", "Namespace", "Usage", "Format", "FW Rev");
-	printf("%-.21s %-.20s %-.40s %-.9s %-.26s %-.16s %-.8s\n", dash, dash,
-		dash, dash, dash, dash, dash);
+	if (flag) {
+		printf("%-21s %-20s %-40s %-9s %-26s %-16s %-8s %-12s\n",
+			"Node", "SN", "Model", "Namespace", "Usage", "Format", "FW Rev", "Path Access");
+		printf("%-.21s %-.20s %-.40s %-.9s %-.26s %-.16s %-.8s %-.12s\n", dash, dash,
+			dash, dash, dash, dash, dash, dash);
+	} else {
+		printf("%-21s %-20s %-40s %-9s %-26s %-16s %-8s\n",
+			"Node", "SN", "Model", "Namespace", "Usage", "Format", "FW Rev");
+		printf("%-.21s %-.20s %-.40s %-.9s %-.26s %-.16s %-.8s\n", dash, dash,
+			dash, dash, dash, dash, dash);
+	}
 
 	nvme_for_each_host(r, h) {
 		nvme_for_each_subsystem(h, s) {
 			nvme_subsystem_for_each_ns(s, n)
-				nvme_show_list_item(n);
+				nvme_show_mpath_list_item(n);
 
 			nvme_subsystem_for_each_ctrl(s, c)
 				nvme_ctrl_for_each_ns(c, n)
@@ -5952,6 +6001,7 @@ static void json_detail_list(nvme_root_t r)
 				json_object_add_value_int(jns, "maxlba", nvme_ns_get_lba_count(n));
 				json_object_add_value_int(jns, "capacity", nsze);
 				json_object_add_value_int(jns, "sector", lba);
+				json_object_add_value_string(jns, "path access", nvme_ns_get_access(n));
 
 				json_array_add_value_object(jnss, jns);
 			}
@@ -5971,6 +6021,7 @@ static void json_detail_list(nvme_root_t r)
 
 static struct json_object *json_list_item(nvme_ns_t n)
 {
+	bool flag = nvme_check_mpath();
 	struct json_object *jdevice = json_create_object();
 
 	long long lba = nvme_ns_get_lba_size(n);
@@ -5986,6 +6037,8 @@ static struct json_object *json_list_item(nvme_ns_t n)
 	json_object_add_value_int(jdevice, "maxlba", nvme_ns_get_lba_count(n));
 	json_object_add_value_int(jdevice, "capacity", nsze);
 	json_object_add_value_int(jdevice, "sector", lba);
+	if (flag)
+		json_object_add_value_string(jdevice, "path access", nvme_ns_get_access(n));
 
 	return jdevice;
 }
-- 
2.21.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
