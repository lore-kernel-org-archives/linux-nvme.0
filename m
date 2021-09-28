Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058ADC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 09:08:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA5060F44
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 09:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAA5060F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C6DeGvoaWYUb9bwRVh4yeR7Ed8YYSrP8+o6aYs4RslU=; b=XCHWkfWPog5oVM
	lw+JD1vwtYrEv8rFThcMro2z5jYmehhkfzmAeNYUxYR8UAfO3Vr8s59FwXI99olU7e1fIFrN6rRtj
	dcUDaGwp+3Ssc9NOIrm3f8lhPr7x12chNyrwAruW5RVRnsaVY/+Z61r5xjr2hiOD6JC2a1IhnB3+2
	b4X3Q4u0bw9n2OTxPXAfy9b1eu/ET9R3NF6Uc+nWEc9JsE3nj1vm3gQXqpUlPl03XIrF6BNXJUjX0
	F2x9ZpOivoKJgVACu7LDfxKUDbnJovAWgtbmL2OHJRuH/qVMtuHNRrFZySACL/pGzNZBspZy3zkOc
	fvYKuBGbVejSuUu37ZYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV95y-006TC9-51; Tue, 28 Sep 2021 09:08:14 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV8pH-006LYt-So
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 08:51:01 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HJY8z1l2dz1DHNb;
 Tue, 28 Sep 2021 16:49:39 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 16:50:52 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 16:50:51 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, 
 <chaitanyak@nvidia.com>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH V3 nvme-cli 2/2] add "Path Access" entry in command output
Date: Tue, 28 Sep 2021 16:50:50 +0800
Message-ID: <20210928085050.4141-3-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20210928085050.4141-1-chengjike.cheng@huawei.com>
References: <20210928085050.4141-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_015100_321985_0487D4C3 
X-CRM114-Status: UNSURE (   7.57  )
X-CRM114-Notice: Please train this message.
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
the "Path Access" entry of each disk is displayed.

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 nvme-print.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 7bb34cd..47c2070 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -5649,10 +5649,10 @@ static void nvme_show_list_item(nvme_ns_t n)
 	snprintf(format, sizeof(format), "%3.0f %2sB + %2d B", (double)lba,
 		l_suffix, nvme_ns_get_meta_size(n));
 
-	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s\n",
+	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s %-12s\n",
 		nvme_ns_get_name(n), nvme_ns_get_serial(n),
 		nvme_ns_get_model(n), nvme_ns_get_nsid(n), usage, format,
-		nvme_ns_get_firmware(n));
+		nvme_ns_get_firmware(n), nvme_ns_get_access(n));
 }
 
 static void nvme_show_simple_list(nvme_root_t r)
@@ -5662,10 +5662,10 @@ static void nvme_show_simple_list(nvme_root_t r)
 	nvme_ctrl_t c;
 	nvme_ns_t n;
 
-	printf("%-21s %-20s %-40s %-9s %-26s %-16s %-8s\n",
-	    "Node", "SN", "Model", "Namespace", "Usage", "Format", "FW Rev");
-	printf("%-.21s %-.20s %-.40s %-.9s %-.26s %-.16s %-.8s\n", dash, dash,
-		dash, dash, dash, dash, dash);
+	printf("%-21s %-20s %-40s %-9s %-26s %-16s %-8s %-12s\n",
+	    "Node", "SN", "Model", "Namespace", "Usage", "Format", "FW Rev", "Path Access");
+	printf("%-.21s %-.20s %-.40s %-.9s %-.26s %-.16s %-.8s %-.12s\n", dash, dash,
+		dash, dash, dash, dash, dash, dash);
 
 	nvme_for_each_host(r, h) {
 		nvme_for_each_subsystem(h, s) {
@@ -5841,6 +5841,7 @@ static void json_detail_list(nvme_root_t r)
 					json_object_add_value_int(jns, "maxlba", nvme_ns_get_lba_count(n));
 					json_object_add_value_int(jns, "capacity", nsze);
 					json_object_add_value_int(jns, "sector", lba);
+					json_object_add_value_string(jns, "path access", nvme_ns_get_access(n));
 
 					json_array_add_value_object(jnss, jns);
 				}
@@ -5873,6 +5874,7 @@ static void json_detail_list(nvme_root_t r)
 				json_object_add_value_int(jns, "maxlba", nvme_ns_get_lba_count(n));
 				json_object_add_value_int(jns, "capacity", nsze);
 				json_object_add_value_int(jns, "sector", lba);
+				json_object_add_value_string(jns, "path access", nvme_ns_get_access(n));
 
 				json_array_add_value_object(jnss, jns);
 			}
@@ -5907,6 +5909,7 @@ static struct json_object *json_list_item(nvme_ns_t n)
 	json_object_add_value_int(jdevice, "maxlba", nvme_ns_get_lba_count(n));
 	json_object_add_value_int(jdevice, "capacity", nsze);
 	json_object_add_value_int(jdevice, "sector", lba);
+	json_object_add_value_string(jdevice, "path access", nvme_ns_get_access(n));
 
 	return jdevice;
 }
-- 
2.21.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
