Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D7DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:30:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4C661263
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD4C661263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hOuQJO1RLO4vI7M2d28hK4OB9v3ZpUZSMkd1j/L5qFg=; b=drI6XObQme7RXF
	QcDiT4GWAGr8hypGN3urud66AvOCBhP273YuMVyWbDyGaINHFniNGkJnrJ51WeZyJsyPvIWQQSVHg
	39f17jVD+trXIVftwvfEtVaFjEJzgWZQajkAf5E4q7Xbc6lCSFAcLtdH7WM1j2xCAS4SNN0Vho/+C
	B9AQRgDdC9ec+aK7Xj7JcxHzNPZEFmIBscIGcICac094eATjcwWYmMeoY34/oSV99+hEWd6bY2heF
	C8ZDFtO6Z5MYY8LYrCG1gLjMaZ9+Rnr5H+HIpiww7euRcd2GalkMt6ljzJQj6OG76HDtUUc33mIBS
	7h8+mZ/MOdC/fPEx0YJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQUz0-009C2R-V9; Wed, 15 Sep 2021 13:29:50 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQUyb-009Bvm-1V
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 13:29:27 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8gtr1s9LzRB2r;
 Wed, 15 Sep 2021 21:25:08 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 21:29:14 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 15 Sep
 2021 21:29:14 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <chengjike.cheng@huawei.com>,
 <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli 1/2] add "State" entry
Date: Wed, 15 Sep 2021 21:29:11 +0800
Message-ID: <20210915132912.3004-2-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20210915132912.3004-1-chengjike.cheng@huawei.com>
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_062925_646949_5B7FA792 
X-CRM114-Status: UNSURE (   7.61  )
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

From: chengjike <jiangtao62@huawei.com>

Add "State" entry in nvme-print.c

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 nvme-print.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index d321ec0..f2b12c0 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -5647,10 +5647,10 @@ static void nvme_show_list_item(nvme_ns_t n)
 	snprintf(format, sizeof(format), "%3.0f %2sB + %2d B", (double)lba,
 		l_suffix, nvme_ns_get_meta_size(n));
 
-	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s\n",
+	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s %-8s\n",
 		nvme_ns_get_name(n), nvme_ns_get_serial(n),
 		nvme_ns_get_model(n), nvme_ns_get_nsid(n), usage, format,
-		nvme_ns_get_firmware(n));
+		nvme_ns_get_firmware(n), nvme_ns_get_state(n));
 }
 
 static void nvme_show_simple_list(nvme_root_t r)
@@ -5660,10 +5660,10 @@ static void nvme_show_simple_list(nvme_root_t r)
 	nvme_ctrl_t c;
 	nvme_ns_t n;
 
-	printf("%-21s %-20s %-40s %-9s %-26s %-16s %-8s\n",
-	    "Node", "SN", "Model", "Namespace", "Usage", "Format", "FW Rev");
-	printf("%-.21s %-.20s %-.40s %-.9s %-.26s %-.16s %-.8s\n", dash, dash,
-		dash, dash, dash, dash, dash);
+	printf("%-21s %-20s %-40s %-9s %-26s %-16s %-8s %-8s\n",
+	    "Node", "SN", "Model", "Namespace", "Usage", "Format", "FW Rev", "State");
+	printf("%-.21s %-.20s %-.40s %-.9s %-.26s %-.16s %-.8s %-.8s\n", dash, dash,
+		dash, dash, dash, dash, dash, dash);
 
 	nvme_for_each_host(r, h) {
 		nvme_for_each_subsystem(h, s) {
@@ -5839,6 +5839,7 @@ static void json_detail_list(nvme_root_t r)
 					json_object_add_value_int(jns, "maxlba", nvme_ns_get_lba_count(n));
 					json_object_add_value_int(jns, "capacity", nsze);
 					json_object_add_value_int(jns, "sector", lba);
+					json_object_add_value_string(jns, "state", nvme_ns_get_state(n));
 
 					json_array_add_value_object(jnss, jns);
 				}
@@ -5871,6 +5872,7 @@ static void json_detail_list(nvme_root_t r)
 				json_object_add_value_int(jns, "maxlba", nvme_ns_get_lba_count(n));
 				json_object_add_value_int(jns, "capacity", nsze);
 				json_object_add_value_int(jns, "sector", lba);
+				json_object_add_value_string(jns, "state", nvme_ns_get_state(n));
 
 				json_array_add_value_object(jnss, jns);
 			}
@@ -5905,6 +5907,7 @@ static struct json_object *json_list_item(nvme_ns_t n)
 	json_object_add_value_int(jdevice, "maxlba", nvme_ns_get_lba_count(n));
 	json_object_add_value_int(jdevice, "capacity", nsze);
 	json_object_add_value_int(jdevice, "sector", lba);
+	json_object_add_value_string(jdevice, "state", nvme_ns_get_state(n));
 
 	return jdevice;
 }
-- 
2.21.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
