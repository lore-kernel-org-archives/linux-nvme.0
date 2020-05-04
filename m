Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E1C47257
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 08:57:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0E320735
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 08:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gQxxZ6cv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OdziSOBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0E320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L7RFsqa6pMvrbsTsQI4R9QAtHmSEH+9s9ck2rMLsSCY=; b=gQxxZ6cvCc1tBU
	UcROR3KsfwG9JbhnKouc3BwwTWSWylreiVkJFxcYVB4zgeRl6cDA3tYOm/XEPlFYyNj1kT9JbWAAP
	t6BcHPyOW4Wgg97oxhDpQu2z370ydVVDX7E4Qk7A/mGG58BKTeufKzJ5KrywLztKRYOZ9y4rDNfA+
	o0c541cr1PaJ2BRmR4CJswLUSHa3xBDqMwRLM8hMZCh/aVsNiv3ttrf86a8IESS7I+0BPK1jRHNXs
	Jy2ZoloemnRLXe1Czd52noHcrmsTr9NEzSvfdi7SCmNjjcJDyV2+vxBMC6qMD8v8FCOyKL8jCHKMp
	w4W4He/oA6dCOHMWjxdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVWuO-0004R3-Ic; Mon, 04 May 2020 08:57:04 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVWuJ-0004Ld-SQ
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 08:57:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588582619; x=1620118619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4XSNKKqlDraVuK5Jy7k/yC830A+mTXbMN4wWP9VmkPo=;
 b=OdziSOBV0ZecVRT7JxuAR1M2P+7bOEvh3KDfuvovQz3/sty++Au7iUbY
 kDUXYPwV8YcBnW8iyC2lpy1DTdroqRU21wOXnGi+SsXh89aCKNZhNyceX
 YIAX7aR47a2JPsJpK0Zd/A64/uKMyxwt/8xmnFCn1+Fd4krf/HuPToFsD
 hKcJ1xtycQo6sH/G4Jf2XUriBFCDzqnzcE4YLk0/TkpEMHAMCdQ9LZGBX
 zg3nbOyPe35ngMD9S0ow/nzrw7Eb5D/WQ/yWDsFi34hb24aaiQyVS07tE
 UqD5DRx8HEqZoHUM4Py/8OI+pD1SFRebg5dc0zdlN5dvsrB10bwigsrtf w==;
IronPort-SDR: ul6K6Bkf9DS7qo1gDbW6ycdhEDNf15kiTJx9mXbZjKMkhW7Th+UJC9COc2Nkq9Dd8LdhHJin4r
 2072Yf1ioDq78FS8YdQz/qBe8EzPDRf7ki8Be6NPvrqfaJaFLNwZZY0w9miU1MkieE8O1iek5K
 WtE0w3JdJ1ZIjt/cEsBDBXqSy42ip4jfipJWuGOIW/FEQJivkv9KJeDHa87LNS+ifLJZ4TyU+Q
 eQqqGHxk7uBqguf48Zfxpwbgq2G53f+ii4TBIRJlwYDu0K307fy2TbtnW27wOYtwz5Y/negoco
 GcQ=
X-IronPort-AV: E=Sophos;i="5.73,351,1583164800"; d="scan'208";a="245696693"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 May 2020 16:56:59 +0800
IronPort-SDR: kpzVZUfFv5kNRUE6Ig0XmAIwqVbI3lngRj7A6c8NATNvjQMHR91JQMm+4V4kwwOr8F4QZds/MA
 /stTYylz+odbwg/tmmy+Ncwtdwe9sT88g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2020 01:46:56 -0700
IronPort-SDR: HAzvw482vTwhIK5HjCbg8IyxOOExuk++xHHTcduVM0MnFsf7vyAGL8aj4IXxciL/siheXjnVgM
 LeHwLh9vtgww==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2020 01:56:59 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/6] nvmet: add generic type-name mapping
Date: Mon,  4 May 2020 01:56:43 -0700
Message-Id: <20200504085648.15549-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200504085648.15549-1-chaitanya.kulkarni@wdc.com>
References: <20200504085648.15549-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200504_015701_375109_3F5BF299 
X-CRM114-Status: GOOD (  12.27  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds a new type to name mapping generic structure. It
replaces nvmet_transport_name with new generic mapping structure
nvmet_transport.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 58cabd7b6fc5..143f3d02f334 100644
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
@@ -282,8 +283,8 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		return -EACCES;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(nvmet_transport_names); i++) {
-		if (sysfs_streq(page, nvmet_transport_names[i].name))
+	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
+		if (sysfs_streq(page, nvmet_transport[i].name))
 			goto found;
 	}
 
@@ -291,7 +292,7 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	return -EINVAL;
 found:
 	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
-	port->disc_addr.trtype = nvmet_transport_names[i].type;
+	port->disc_addr.trtype = nvmet_transport[i].type;
 	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
 		nvmet_port_init_tsas_rdma(port);
 	return count;
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
