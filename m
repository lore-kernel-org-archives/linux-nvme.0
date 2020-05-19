Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1136FC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:07:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09B020709
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pu1910rp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C2LGdRV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09B020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=43MZ2Y1OR4JLh9lcT/EuiqRqQr91b2GN1HGGnqtvdTY=; b=Pu1910rpU12hBk
	oSh6mR35koG0H28p+H/J1jn6q3rGnPk9lEKL6tAzPm6rZNJQ+JDEhZWn8BDKdxFp1BZGFRCiDM8bE
	5g5rucgLkMQLbXVJb4ysBLOYlSCLiLMc1TpQenjHvzBN6FomNQzE0gdapIThM+TfOhqCGC8sDtBnT
	0OJXdpsj3MNLazAKjPf1JLIat0+UMPNwdA13umQtv/MJ90XA8YJClwMGY4FIb7I0qTgW6O8T/wBTZ
	5RGVis3ldlzQ/zRSUCNBIP0bJBm4mtdcIk6kPWnA69AxymUOI+fcc2pAyo04rjscHW+5zoSV8pIuR
	ajfRlCtH0Ysyc8Uaa29g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaxHD-0006cg-AJ; Tue, 19 May 2020 08:07:03 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaxGs-0006AD-GB
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 08:06:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589875603; x=1621411603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vIExB/HMigWx7mO5+DfP8CKFzKBd55F8JyF0BxOKOFs=;
 b=C2LGdRV4/JpE72b6S03jmEod3N7xSN+0KnnkjVFo266RDeVDYoaLcW39
 3XXzR1S9GTVpQu3rjIUBZwvZ3fLgJDIHLB7aV+kdZZzngk1IqS2oW0A/3
 1ox+BWeeIDE2QuNoEm5RIz7iGZwqiRETIk6QGCKqzjDpG+Rc286QsrR3A
 YPAw9B9WH5R0qBWB38VvjMHZQ+S+k4iI8o61fd0eCOJPy7IEZEMx/dxhG
 sgdbDk+A3ouCETZ3XbhXlbslEPWwSJCebxRC4REmvhjTTIGoagjdIvV8x
 3+DTwDX3pw2Ap3g2yELHIeWsj2evpgyQqwLIpMWLHpO3HWft7Pjfe1HQr g==;
IronPort-SDR: dgLrE79L5h4+8wrEfLxo4ulnMlhBgsIyT54FRH2q7ACMPW7YE/ymStRqtzwwDKeXA7q34ylLow
 kCeavoegPnHh6imYR3qH6+3x1XedXhIYgt6oVJOBVfiqLjNJ8Vkp5/3d7B07i4Xd67suD8PW5Q
 Tph0+cPBa82l9snsl1Nfy2bZPESFElJCTRAFX/ycrjD7ArCBemfgFvOmas4LyUtkj9kULMxMxb
 CpvWnDq4QpTle9crXJTJlYfLbbhUX5ettWPT3zK+yG8Ce6Y3pubsKSzzjDFSuHO6/Nad0TPi0o
 a6Y=
X-IronPort-AV: E=Sophos;i="5.73,409,1583164800"; d="scan'208";a="240756810"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 16:06:44 +0800
IronPort-SDR: qi+/wYnsQ51zav9IYTl5spozu9fdWEnRk/OY+YBhqr5mtgkSeytlABL3cc7zrtT16IFImD2S9w
 eGyK7lawVGa+VYnhXfzS53dl8lT1uyTYU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 00:56:46 -0700
IronPort-SDR: wIWGAI8zd4mgE/SJRn4zimz06PBUPuNvNZbxHgJ74IG+cOlawe9Q38/1FhD8+pVYxT9TlqkY/n
 090BLK+x+wOw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2020 01:06:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 3/4] nvmet: revalidate-ns & generate AEN from configfs
Date: Tue, 19 May 2020 01:06:29 -0700
Message-Id: <20200519080630.3500-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200519080630.3500-1-chaitanya.kulkarni@wdc.com>
References: <20200519080630.3500-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_010642_627699_A5148D54 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a new attribute "revalidate_size" for the namespace which allows
user to revalidate and generate the AEN if needed. This attribute is
needed so that we can install userspace rules with systemd service based
on inotify/fsnotify/uevent. The registered callback for such a service
will end up writing to this attribute to generate AEN if needed.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 24eb4cf53b4f..17c529260e12 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -540,6 +540,31 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, buffered_io);
 
+static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	if (!val)
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (!ns->enabled) {
+		pr_err("enable ns before revalidate.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+	nvmet_ns_revalidate(ns);
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -547,6 +572,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_revalidate_size,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
