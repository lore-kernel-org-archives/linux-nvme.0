Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5C5C38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:53:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8037206F4
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L8ZiO5g3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OIG491Bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8037206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K4dhavQWrQ0ZDTOpTY7MHoFGjGzhLEDmswsZgSuhDdw=; b=L8ZiO5g33c8vTx
	Tqsben1TeQuBGlGlfP5/Dp6PoatPvanUjdN3g8CZeKhcPEZJjxuKzxc8vyKqk6qAk3WdAujGJRLET
	32IJDGz4sa6B5CMMeJjrlpfu7yDdFQ5z8hKm3GwJAecwFbwqvHIebgYMu/QwKjPqPBPGmR7lnSKfJ
	348kxYbBBdOPp9Wf8D33rZ49NGYYR7+QyPhVa39M/ZwL3KrLmWVn7A4VsjMgeXrXhPf4yZgXy45D4
	/GkIKFKhHsqCZJAaQedtl7WUJKfqZUHFEzZphpX02thl4k2mxe0WhAFVb98+me5a2uQCGheypuaMm
	n1fnIoeKeWEu0lF63p9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJkS-0000yz-H5; Sun, 19 Apr 2020 23:53:16 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJkJ-0000tI-Gz
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:53:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340388; x=1618876388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TFwI2VWG/UT8xAq+2z2LElTB9/XINWv00cid/hjoauY=;
 b=OIG491Bie3D9ddDvWb5rJW+ZaNqUAp2Yj+Ekeqb3KrOGWhFOllHZKtEf
 vY9QBJOSCy521aqpjvRQAqWGeFwWb1iDDFg9MEIoY67wfBZIWBWri5mum
 dDY00XCIFHaH0KX8vk9Bu83rV1j10kk4PkyDh2t9b5dqCLC8ZXwPnOEWe
 zWb7e1k/IBbd/FbahepRVwWWNnUh84pZAzX2SxuJ9flGgpPKi++pYohL6
 eFgqEiLVmbbhxjdpDuX/6LteOXG6J3NYNag4lqtmjYAYQN62fsGKkut97
 54fMuhTepufuckMSCK6qmG1JMgzwYnh2sP0aQdesPW73qCew2fNWNDUa0 Q==;
IronPort-SDR: eR0WbG8cy7XiQGKZMyrRJl0ceui/J7AserfsCPk9aieMORvS7qpaDyQnHdosadMVypajr6CJc3
 Vztv2QAoocA/hVUYEoRZSSIAg1DbtOtvDYPdtQxikSctPP2/SptrpghP02+ybZPJe46uoZ16wX
 7eQSA4BMqgvQjxKE2POHijF+biA7HezDSfQsLjBRwx/L4iEgLElYEdWpP7dyHPegOZHDnKMh+T
 zjNp/1LqeS6io039+LgZ8mLq4R8x8rW0j4rojASipKegFZdo+McCUYAKFBue+sj2aQE1qsTbU1
 ChU=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="140022585"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:53:07 +0800
IronPort-SDR: 9aeYYyskOirMbe0UwPrJiukUgXg/cKQcA96SU+GiQpxjvWKF/4He+bXDBLdhgyXNMiisnKFdZh
 9HSeTt0H/cHv04G/Er44v5qkeBUgWK7aw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:43:27 -0700
IronPort-SDR: n9ZkAgVkotJnUTxjAz4dP5EqnSvhjPnAlACcbvY0aDVyGVNd9AaENNOCUvdzjJwK//qCPS5ODM
 sCSdkGN/yXnA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:53:05 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/6] nvmet: use type-name map for address family
Date: Sun, 19 Apr 2020 16:52:38 -0700
Message-Id: <20200419235242.60355-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
References: <20200419235242.60355-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_165307_571785_267B2A27 
X-CRM114-Status: GOOD (  13.23  )
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

Currently nvmet_addr_adrfam_[store|show]() uses switch and if else
ladder for address family to string and reverse mapping which also
repeats the strings in show and store function.

With addtion of generic nvmet_type_name_map structure we can now
get rid of the switch and if else ladder and use ans string duplication
and use for-loop-compare-success-return pattern similar to previous
patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 50 +++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index cbe3d7568860..67e8d53c714d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -32,31 +32,36 @@ static struct nvmet_type_name_map nvmet_transport[] = {
 	{ NVMF_TRTYPE_LOOP,	"loop" },
 };
 
+static const struct nvmet_type_name_map nvmet_addr_family[] = {
+	{ NVMF_ADDR_FAMILY_PCI,	"pcie" },
+	{ NVMF_ADDR_FAMILY_IP4,	"ipv4" },
+	{ NVMF_ADDR_FAMILY_IP6,	"ipv6" },
+	{ NVMF_ADDR_FAMILY_IB,	"ib" },
+	{ NVMF_ADDR_FAMILY_FC,	"fc" },
+};
+
 /*
  * nvmet_port Generic ConfigFS definitions.
  * Used in any place in the ConfigFS tree that refers to an address.
  */
-static ssize_t nvmet_addr_adrfam_show(struct config_item *item,
-		char *page)
+static ssize_t nvmet_addr_adrfam_show(struct config_item *item, char *page)
 {
-	switch (to_nvmet_port(item)->disc_addr.adrfam) {
-	case NVMF_ADDR_FAMILY_IP4:
-		return sprintf(page, "ipv4\n");
-	case NVMF_ADDR_FAMILY_IP6:
-		return sprintf(page, "ipv6\n");
-	case NVMF_ADDR_FAMILY_IB:
-		return sprintf(page, "ib\n");
-	case NVMF_ADDR_FAMILY_FC:
-		return sprintf(page, "fc\n");
-	default:
-		return sprintf(page, "\n");
+	u8 adrfam = to_nvmet_port(item)->disc_addr.adrfam;
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
+		if (nvmet_addr_family[i].type == adrfam)
+			return sprintf(page, "%s\n", nvmet_addr_family[i].name);
 	}
+
+	return sprintf(page, "\n");
 }
 
 static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	int i;
 
 	if (port->enabled) {
 		pr_err("Cannot modify address while enabled\n");
@@ -64,20 +69,15 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 		return -EACCES;
 	}
 
-	if (sysfs_streq(page, "ipv4")) {
-		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_IP4;
-	} else if (sysfs_streq(page, "ipv6")) {
-		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_IP6;
-	} else if (sysfs_streq(page, "ib")) {
-		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_IB;
-	} else if (sysfs_streq(page, "fc")) {
-		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_FC;
-	} else {
-		pr_err("Invalid value '%s' for adrfam\n", page);
-		return -EINVAL;
+	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
+		if (sysfs_streq(page, nvmet_addr_family[i].name)) {
+			port->disc_addr.adrfam = i;
+			return count;
+		}
 	}
 
-	return count;
+	pr_err("Invalid value '%s' for adrfam\n", page);
+	return -EINVAL;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_adrfam);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
