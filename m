Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B5C3A5A9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 10:00:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F7020752
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 10:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AmC8yIHx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MNQ63TWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F7020752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D272DOPy0qjitEFlr+dPBS6LywUDmEyXukTdsaFDMlc=; b=AmC8yIHx9Umk8L
	wNw6M5WX5p8EcKXSIm/EW5K5pX+GFQdn4K0VkAZAKXj/xRsqHll5uSqartMMTC2etU8KpYgyMiLVQ
	10i3uOfUl0GPl2MoBClniVTKM4ZIRKWlcE2wTzp9m6HKkk0swalfL66tiIxQ2AyzCHlMdUfG+yWsF
	BoOAcr1k1lWS1kEaumUgMYO/V6GbvyFJieg42OS25INte18UYSKUfeddpzxqFi1nWJXDm7nB+TMnH
	st0KTJ0eWGva7ZnP4/5UMZw03VJFLSZHy65eeqf/tLT/avI6FP7plPPbHQ+YBHEJuk7crH8RaAePA
	NTTI3HuKZKQ9R3vNXe/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVXtb-0002Ex-2m; Mon, 04 May 2020 10:00:19 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVWuT-0004UZ-OP
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 08:57:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588582630; x=1620118630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9XZjt1QTsW5skaTyy6YwL+GPhLPXy8vwmTVLIZPxpVk=;
 b=MNQ63TWkz9jJbCgTk+WSRZ06KIDWPjONON1+JZl3puumnWseeWq7alII
 caml7NuryCiIsyE7x8hLDwJBAtX2+aiXuTcap5TsnpXZgZvFzdpG79rHu
 Z7b4qjONc3F3yom6A1F4hIBqTUUdvtDozOnA/M3bIBTUuke7yaCCiM4Pi
 JkKD2qcJ3qd/093nDv83BJvzEU5rLkBoOESmeq4NSiSXtpgb1QVeD2FRy
 YLOb2GnVqSpkkxyOzqCRbXr1fwYmBsxh1sCGC8dWxSSu/Qut+Ikummz8C
 2Pxei5YLsQ024O+qOM+qN62dLz3osG8k0w8w69AkAG9yhJfADn7JZT22h w==;
IronPort-SDR: zK5ybr3fshS4dxrz9FeCVky+K1o3+IraIL8gUIoR2sISi7aDRCRC9KgEwtKbQXxI0awxFJ2SI5
 /Sujx+Mb+I/nm5dSc7RV2wXsNnfOHr92yipJ0cd2P1Od+0LNAngvHs5tfpjknljcEvVVdn7LQY
 BJ6Ze/EgXtdIZ8vBTwxgHdlscmgfT1djJxyJDUHgv8M5JIXtrc13q+CfSdMH3Ed/Rjp+lBaW0Q
 zH0S+jvqgBVREUcsto4lXucGn2Z61MK/HMQH1QA+6nIJdmrjveI5PJnWdFt1RcuIF6TfBfeMzW
 20Y=
X-IronPort-AV: E=Sophos;i="5.73,351,1583164800"; d="scan'208";a="137189815"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 May 2020 16:57:07 +0800
IronPort-SDR: lDzZdbnEp/XNB5ebPSmzjHKC41scIYrXvw+Zj+zTcatE59GQWqr72fzrrq2bXI3ZAMQ88cPvZK
 2MW+S9hX5Sp7gEA9c2ppVeKjV+dUcQZDY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2020 01:47:36 -0700
IronPort-SDR: 1ALY75LhmJbctqF6xD/aNP61L5FUFv3g9s9HU9WgGAFhRT8fJkR/f9UbPpgYogp+Aa3OwVRF7X
 zcBo7DPZY13Q==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2020 01:57:06 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/6] nvmet: use type-name map for address family
Date: Mon,  4 May 2020 01:56:44 -0700
Message-Id: <20200504085648.15549-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200504085648.15549-1-chaitanya.kulkarni@wdc.com>
References: <20200504085648.15549-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200504_015709_822970_658E3A37 
X-CRM114-Status: GOOD (  13.46  )
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

Right now nvmet_addr_adrfam_[store|show]() uses switch and if else
ladder for address family to string and reverse mapping which also
repeats the strings in show and store function.

With addition of generic nvmet_type_name_map structure we can now get rid
of the switch and if else ladder and string duplication.

Also, we add a newline in before found label in nvmet_addr_trtype_store()
which keeps goto label code consistent with
nvmet_allowed_hosts_drop_link(), nvmet_port_subsys_drop_link() and
nvmet_ana_group_ana_state_store().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 51 ++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 143f3d02f334..8a5d99e25192 100644
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
@@ -64,19 +69,16 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
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
+		if (sysfs_streq(page, nvmet_addr_family[i].name))
+			goto found;
 	}
 
+	pr_err("Invalid value '%s' for adrfam\n", page);
+	return -EINVAL;
+
+found:
+	port->disc_addr.adrfam = i;
 	return count;
 }
 
@@ -290,6 +292,7 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 
 	pr_err("Invalid value '%s' for trtype\n", page);
 	return -EINVAL;
+
 found:
 	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
 	port->disc_addr.trtype = nvmet_transport[i].type;
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
