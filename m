Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6534AC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 12:41:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218FF61250
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 12:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 218FF61250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Kro8sHSTFC/GVWXxcWWiSPNUvnGE1qWWCob5cfwrk48=; b=2gV2inPtG1ww0H
	fibpeGlZMVNdNQJamakxvpvGMabvjdonk9+L+XOxPLBa+pTJsG0mBAGsw1bZMCU7K/UV0odMRiXKu
	b1od5/smjSB/k/0E5EM7s3Gk2mrO+JKrCkAP7phsTnRqD66aXWXiMEDJfgBUz+Jbn6hg+AgHyoXXO
	3DYZ2S5qKlwSvnjNagaeyii6YtCDwPCz9OV+p40IWjMoXuQ0fvBmkKvL+9FeraTvFAXC05RNUeJBS
	/XX2sUeU2X024+st5YOSavnAhB1n2Y8jmlXwFGe+bwMfX+w7mmoghbLp+lXvLYun2ApDoSDth5dLP
	/quWl2xDOANGT3zxMP/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI9G5-00GoQI-OB; Mon, 23 Aug 2021 12:40:57 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI9G2-00GoNP-Iq
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 12:40:56 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GtWvY5vsVz8tQV;
 Mon, 23 Aug 2021 20:36:41 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 20:40:49 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 23 Aug
 2021 20:40:48 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli] fix list command bugs
Date: Mon, 23 Aug 2021 20:40:47 +0800
Message-ID: <20210823124047.4593-1-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_054055_016961_979E0BF7 
X-CRM114-Status: GOOD (  13.18  )
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

When execute the "nvme list" command in a multipath environment, it generate a core dump. Such as:
[root@localhost ~]# nvme list
Node                  SN                   Model                                    Namespace Usage                      Format           FW Rev
--------------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
Segmentation fault (core dumped)
[root@localhost ~]#

The reason is that when a device is a multipath disk, the value of "nvme_ns_t->c" is NULL.
This also happens when you execute "nvme list -o json" and "nvme list -v -o json" commands.

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 nvme-print.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 9ef3ab2..d321ec0 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -5642,17 +5642,15 @@ static void nvme_show_list_item(nvme_ns_t n)
 	const char *u_suffix = suffix_si_get(&nuse);
 	const char *l_suffix = suffix_binary_get(&lba);
 
-	nvme_ctrl_t c = nvme_ns_get_ctrl(n);
-
 	snprintf(usage, sizeof(usage), "%6.2f %2sB / %6.2f %2sB", nuse,
 		u_suffix, nsze, s_suffix);
 	snprintf(format, sizeof(format), "%3.0f %2sB + %2d B", (double)lba,
 		l_suffix, nvme_ns_get_meta_size(n));
 
 	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s\n",
-		nvme_ns_get_name(n), nvme_ctrl_get_serial(c),
-		nvme_ctrl_get_model(c), nvme_ns_get_nsid(n), usage, format,
-		nvme_ctrl_get_firmware(c));
+		nvme_ns_get_name(n), nvme_ns_get_serial(n),
+		nvme_ns_get_model(n), nvme_ns_get_nsid(n), usage, format,
+		nvme_ns_get_firmware(n));
 }
 
 static void nvme_show_simple_list(nvme_root_t r)
@@ -5794,6 +5792,7 @@ static void nvme_show_detailed_list(nvme_root_t r)
 static void json_detail_list(nvme_root_t r)
 {
 	struct json_object *jroot = json_create_object();
+	struct json_object *jdev = json_create_array();
 	struct json_object *jsslist = json_create_array();
 
 	nvme_host_t h;
@@ -5881,8 +5880,9 @@ static void json_detail_list(nvme_root_t r)
 		}
 
 		json_object_add_value_object(hss, "subsystems", jsslist);
-		json_array_add_value_object(jroot, hss);
+		json_array_add_value_object(jdev, hss);
 	}
+	json_object_add_value_array(jroot, "Devices", jdev);
 	json_print_object(jroot, NULL);
 	printf("\n");
 	json_free_object(jroot);
@@ -5891,7 +5891,6 @@ static void json_detail_list(nvme_root_t r)
 static struct json_object *json_list_item(nvme_ns_t n)
 {
 	struct json_object *jdevice = json_create_object();
-	nvme_ctrl_t c = nvme_ns_get_ctrl(n);
 
 	long long lba = nvme_ns_get_lba_size(n);
 	double nsze = nvme_ns_get_lba_count(n) * lba;
@@ -5899,9 +5898,9 @@ static struct json_object *json_list_item(nvme_ns_t n)
 
 	json_object_add_value_int(jdevice, "namespace", nvme_ns_get_nsid(n));
 	json_object_add_value_string(jdevice, "device", nvme_ns_get_name(n));
-	json_object_add_value_string(jdevice, "firmware", nvme_ctrl_get_firmware(c));
-	json_object_add_value_string(jdevice, "model", nvme_ctrl_get_model(c));
-	json_object_add_value_string(jdevice, "serial", nvme_ctrl_get_serial(c));
+	json_object_add_value_string(jdevice, "firmware", nvme_ns_get_firmware(n));
+	json_object_add_value_string(jdevice, "model", nvme_ns_get_model(n));
+	json_object_add_value_string(jdevice, "serial", nvme_ns_get_serial(n));
 	json_object_add_value_int(jdevice, "util", nuse);
 	json_object_add_value_int(jdevice, "maxlba", nvme_ns_get_lba_count(n));
 	json_object_add_value_int(jdevice, "capacity", nsze);
-- 
2.24.0.windows.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
