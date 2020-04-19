Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0064C38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:53:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA23206F4
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HvsgEIBg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NcldZHLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA23206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UiKyM/lUiVzCeX2QQrDwvGZG70BRez1CVOmJu/WVHF4=; b=HvsgEIBgKrNxpL
	kFodxzITuyYu3+evFxoh3J3VDETrNKrhZkFxH54yYUhaQMJ0YNpydIxBX2Qbg1CZp0brgy+Aff5gR
	SnQLAUi+mNzc7s+6I8o0Rde68Wy21lZJh8dpf+cpVcGKHxo4fASyZDS4nJV+oD0a8/MjX8LI0+yc3
	f5kNYzT+lTiZUlTKMj8NpoTmdZdgOItMbGj0hsNjRsqG5DlUuKA3GxsAXtVMyqawYWsUpcMBpSbuP
	YsheD2ZoStmAZIIzbIgLUvEHeONcE1Xc6VmewfKcOBzNN29/fWtnxxUQXAHDxBtSjG5Twe6hzRWpG
	PTbUOLMci5fjOn2aaHPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJkC-0000o8-Dg; Sun, 19 Apr 2020 23:53:00 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJk9-0000mQ-6N
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340377; x=1618876377;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=McPLerFy9Uu6P3tLE9eMRgFeh4HprJiGEJG6Yk1/RDE=;
 b=NcldZHLPnHTmJ6Vo8Y9eLMfLjo9GcLcdQ0Bz0rJIbD888dNxDvXSO+D3
 PRLIVI5H+Md4ICOS2UHH4AdMjJeROhthxwvizGnHc/TXFd1QQOHbQVGLE
 FJDGLO/2MRTam2STyWqloOzrqv0fGWnCwoeI5Q0hI6MWdayxrP4z/Wm8+
 wNi628kWnMnRjXQsBqY/U9eR0BYP7famtnuVHLmxnGLPfZLBjaIGCJZty
 TPirCGJDRvGZCEf/PJaiSH7GJ1867Xqh4nlrWz84ayHDtyR/+x66isimr
 IUOnyjf0Avvm1zTi+K+eoLfafJOv/wWNRwjFMCRUwfFLXy2jQtefVC0Ih w==;
IronPort-SDR: JJcd/gIqxDfh3SzkDfHNsfIiPXbrLim//N143Bkh3Wq3t2arRR4WEfUUMpy3M0m3B39+cdFhjb
 23L7z6llyFn/DkpVqHVJ5Rv/mlcuuh49+aUSj1c5SSKiYL/HDvEet42gQDaOjApACCu27nqPa7
 n26OEmAs02cj8ufIYanZVIeHJ+5DWQVV09HCiWRDK8yGDDALMeJvcUi5uWnCE1k1k3CYzgGN23
 FnyoXbA07u8D7wXPQtYHnDyYzTDfBqF+98HFqAzNgZjvCtcI+qhFYP9OXMC7WFWO/mYO1SwD/A
 mdE=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="135976515"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:52:57 +0800
IronPort-SDR: Ynz79Vq9skmdqSqAPAoC2KOh05o/8NjCH56jbthFzhUVvwTIXcdNcmeZa4xx8xxFrWkwl4Xa+4
 3zhAzqle57G+4QWX5KCPKRVgJrMup817A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:43:51 -0700
IronPort-SDR: cVZy/UJsz1vIAr9lmFwJHaq/G3H7k+r+fTN6XslyK8/NWOybm1nqT6qhP70iBin04amIhixGII
 6VS7Z7kYwoVw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:52:56 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/6] nvmet: add generic type-name mapping
Date: Sun, 19 Apr 2020 16:52:37 -0700
Message-Id: <20200419235242.60355-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
References: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_165257_242209_ACEF89DC 
X-CRM114-Status: GOOD (  13.01  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds a new type to name mapping generic structure. It
replaces nvmet_transport_name with new generic mapping structure
nvmet_transport. This also removes the goto required for the found case
in nvmet_addr_trtype_store() and adds
for-loop-compare-success-return pattern.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 58cabd7b6fc5..cbe3d7568860 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -20,10 +20,12 @@ static const struct config_item_type nvmet_subsys_type;
 static LIST_HEAD(nvmet_ports_list);
 struct list_head *nvmet_ports = &nvmet_ports_list;
 
-static const struct nvmet_transport_name {
+struct nvmet_type_name_map {
 	u8		type;
 	const char	*name;
-} nvmet_transport_names[] = {
+};
+
+static struct nvmet_type_name_map nvmet_transport[] = {
 	{ NVMF_TRTYPE_RDMA,	"rdma" },
 	{ NVMF_TRTYPE_FC,	"fc" },
 	{ NVMF_TRTYPE_TCP,	"tcp" },
@@ -254,10 +256,9 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(nvmet_transport_names); i++) {
-		if (port->disc_addr.trtype != nvmet_transport_names[i].type)
-			continue;
-		return sprintf(page, "%s\n", nvmet_transport_names[i].name);
+	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
+		if (port->disc_addr.trtype == nvmet_transport[i].type)
+			return sprintf(page, "%s\n", nvmet_transport[i].name);
 	}
 
 	return sprintf(page, "\n");
@@ -282,19 +283,18 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		return -EACCES;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(nvmet_transport_names); i++) {
-		if (sysfs_streq(page, nvmet_transport_names[i].name))
-			goto found;
+	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
+		if (sysfs_streq(page, nvmet_transport[i].name)) {
+			memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
+			port->disc_addr.trtype = nvmet_transport[i].type;
+			if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
+				nvmet_port_init_tsas_rdma(port);
+			return count;
+		}
 	}
 
 	pr_err("Invalid value '%s' for trtype\n", page);
 	return -EINVAL;
-found:
-	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
-	port->disc_addr.trtype = nvmet_transport_names[i].type;
-	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
-		nvmet_port_init_tsas_rdma(port);
-	return count;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_trtype);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
