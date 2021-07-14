Return-Path: <SRS0=VC/k=MG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6910C12002
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jul 2021 23:39:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A694A610C7
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jul 2021 23:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A694A610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LaI+XB9Ks4sVg8znG9L4vpSMxrJvocfoAbH4N7teSdo=; b=J7C04C9eAc+iwy
	2jTxaZHd2eMnTiMqLr8PGIg75dlyiMp8BlG7Y+s6IoHN0gN75ZYmLWqQo1HLccmjyZjbsNxhzScV6
	sKeGJofqtYr9KOLcCYImAEkCTfNMEnAh5xfHR/sC5vHyhL3VB174MqYBsDy08nxmLGp5EmZA6h8/g
	wNrYAVwhDcjRdX0FA+yZTMx7lOAqvmZrEakZJ+8q6zAJ88Y7G+vSeHck6AUxhHGeCO8bJTIRaonTU
	jqc/rBbmukjv4y8DeQCP6s8tk3EM9hdRxt4nlPUVyMVkaO+Qy5gpsz6y7UiqSUuykVa/ymQsVgKDm
	+Wk1+TwMrtnvV3JkudBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m3oTN-00GMeJ-5r; Wed, 14 Jul 2021 23:39:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3m1i-00FF1z-Mc
 for linux-nvme@lists.infradead.org; Wed, 14 Jul 2021 21:02:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9358A613D0;
 Wed, 14 Jul 2021 21:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626296562;
 bh=uySaRA8JWK3ZAdJcb6FxOvS/FYNVTRoO1NbrNnLnQ8E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u5yVfutn4LrQv8ST3UQPz+aHe9+8Bf+w5B8swpzjn88xUBIvijI96uw/GQqKRPcRh
 /04dq00BSaUAv1asdCSWh3pzvxLIlMZ/ZswBJa52TZqbZqvmU2ps67cNZBmjN/S2mh
 en1t1R/OifDnndQTK8DukFx+mbEpD90VHXVgyZS+mRcTokzjDEHj1YeVZyn2MiCuh5
 G1tE9A/72+abl0Bqnuvquq9C8Mms4qcrA7CrULZgT8fb7uF7puk+aRXV+9TK4iiNpt
 w8I/Kmfgi+LRJTfvbzFVoSEhSzx1RZrQ2R9mDYC4zdUno3kq4UNjI2aEkTLTahunkJ
 /K/TSXWi4W1ZQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme-pci: cmb sysf one file, one value
Date: Wed, 14 Jul 2021 14:02:38 -0700
Message-Id: <20210714210238.1837729-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210714210238.1837729-1-kbusch@kernel.org>
References: <20210714210238.1837729-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210714_140242_837410_62BB55DD 
X-CRM114-Status: GOOD (  11.24  )
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

An attribute should only be exporting one value as recommended in
Documentation/filesystems/sysfs.rst. Implement CMB attributes this way.
The old attribute will remain for backward compatibility.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7e816aa8407a..5f955771ccba 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2041,13 +2041,36 @@ static ssize_t cmb_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(cmb);
 
+static ssize_t cmbloc_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%u\n", ndev->cmbloc);
+}
+static DEVICE_ATTR_RO(cmbloc);
+
+static ssize_t cmbsz_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%u\n", ndev->cmbsz);
+}
+static DEVICE_ATTR_RO(cmbsz);
+
 static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
 	struct nvme_dev *dev;
 
 	dev = to_nvme_dev(dev_get_drvdata(container_of(kobj, struct device, kobj)));
-	if (a == &dev_attr_cmb.attr && !dev->cmbsz)
+	if ((a == &dev_attr_cmb.attr ||
+	     a == &dev_attr_cmbloc.attr ||
+	     a == &dev_attr_cmbsz.attr) &&
+	     !dev->cmbsz)
 		return 0;
 
 	return a->mode;
@@ -2055,6 +2078,8 @@ static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 
 static struct attribute *nvme_pci_attrs[] = {
 	&dev_attr_cmb.attr,
+	&dev_attr_cmbloc.attr,
+	&dev_attr_cmbsz.attr,
 	NULL,
 };
 
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
