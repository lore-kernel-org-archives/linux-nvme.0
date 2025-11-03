Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A944FCCFA05
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0+22x1ltEwsK8ObZYtVjfsj/+LdFoRLac0A0wfwiIFU=; b=L1iiP3F8Z3JO2JGwY5EWDP9gnM
	1gKHqiTOBkmGr8ZGFVdLCw3cLOxOU5RQmY5YvWuNfRlVl1HZRGjvf/58TkzKwKn3LgV6/apOYX412
	qiAzHaBCu5DaHH9czOCP1mW5h0foH4cZMUBinGbU4wZmx39MUTTIjh1w5rQXXJiUdcqJNAsXOUtJL
	rZQvLD7LCrHbCYLBwM2cG/rLUf15lBXVidoQ83gGyTrK4RZDG2bFm20tKTtGv1aAK23rVqq3cMpTM
	SkahMcrhSqWLiaObLH/zHLHzFMhdlEs5L6jEOdqtsNxw+NQy8No8+IZT1ukSPWyK31iG0WwZTEZkF
	NxwsZ4qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvna-0000000A2T0-0Jvj;
	Mon, 03 Nov 2025 14:44:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvnY-0000000A2St-1G4M
	for linux-nvme@bombadil.infradead.org;
	Mon, 03 Nov 2025 14:44:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0+22x1ltEwsK8ObZYtVjfsj/+LdFoRLac0A0wfwiIFU=; b=ZO2zuOh6eAZziMH/aD4uw+VaLO
	kKv2heKzuwzBcebsqHnisi3QGIDgXQCgnsYxC5LgfdCqstu6EAfo1WD4ODWhmXHsmXhfP7qwKNNQo
	AzEoqnA62xWuC8hiBdw1HixqAjDHUMH7p4xI3OW9ycSU4fEbIrw5JQ/mRcdPSNVgReV2+Gr1V8xmG
	AmGCNSDqXPKQ5OoYU8m91Ts4SUD04MFik9+42RIvzFly2gXklE1fNONOVnimqwXOPEa7qrECp+bcl
	2HFhAwlXIm7xt2hFlxkZ1fACf/d4d+qW5t6qSQipIpFRWTbLvhrpmXDO6KMolO4JZwRR1yPIMXXg/
	t92/6jxg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuvn-0000000FbGy-2nRd
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:49:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762181065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0+22x1ltEwsK8ObZYtVjfsj/+LdFoRLac0A0wfwiIFU=;
	b=U5Y1NOaoVRYGyHNFyT96l0sZItt3D2Bv88IwTgrcR/pp8uHqdaQrfPURSDcuF+gNj77RCT
	W/7/aOmxlUZ2hxXbBH4zo7rz3XH2JG+th09RrXIvb6rbFkncsQ0deuJVE3gQAn6mtghJnv
	76UGLuTi1KIicAPM3XyDDDfSEAOuL2E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762181076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0+22x1ltEwsK8ObZYtVjfsj/+LdFoRLac0A0wfwiIFU=;
	b=FJbV3rWCeeq3WL+RDaJO7UBD9DKNazlIiPgFxpEe+9oPxP72LiZCUFAYq0WjsaSlkWATAl
	Iq+3m0TyYOjOZsyRG/1b5HSQGaCGtNahPplWuDYCqKPLRU66tmUq2JJacVkcZ2CG8u2s8Z
	NHqNwKMzja0Y+gBhpWIPFouLDyRf874=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442--Y8ou-eaNNWZQU-lxbI0Rw-1; Mon,
 03 Nov 2025 09:44:18 -0500
X-MC-Unique: -Y8ou-eaNNWZQU-lxbI0Rw-1
X-Mimecast-MFC-AGG-ID: -Y8ou-eaNNWZQU-lxbI0Rw_1762181051
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4A921954B05;
	Mon,  3 Nov 2025 14:44:10 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.44.32.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA8B51800451;
	Mon,  3 Nov 2025 14:44:07 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mlombard@bsdbackstore.eu,
	bgurney@redhat.com,
	bvanassche@acm.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2] nvme: expose active quirks in sysfs
Date: Mon,  3 Nov 2025 15:44:06 +0100
Message-ID: <20251103144406.1148401-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lvsfU-moNxwgHd7-mO5Pu1V8d6cfZARt84nxqHrcYA8_1762181051
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_134911_861512_F8EE50ED 
X-CRM114-Status: GOOD (  13.36  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently, there is no straightforward way for a user to inspect
which quirks are active for a given device from userspace.

Add a new "quirks" sysfs attribute to the nvme controller device.

Reading this file will display a human-readable list
of all active quirks, with each quirk name on a new line.
If no quirks are active, it will display "none".

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

V2: Do not expose kernel-internal constants to userspace.
    Move the quirks attribute to the controller device, where it belongs.

 drivers/nvme/host/nvme.h  | 54 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 102fae6a231c..647f19dd57e9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -180,6 +180,60 @@ enum nvme_quirks {
 	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
 };
 
+static inline char *nvme_quirk_name(enum nvme_quirks q)
+{
+	switch (q) {
+	case NVME_QUIRK_STRIPE_SIZE:
+		return "stripe_size";
+	case NVME_QUIRK_IDENTIFY_CNS:
+		return "identify_cns";
+	case NVME_QUIRK_DEALLOCATE_ZEROES:
+		return "deallocate_zeroes";
+	case NVME_QUIRK_DELAY_BEFORE_CHK_RDY:
+		return "delay_before_chk_rdy";
+	case NVME_QUIRK_NO_APST:
+		return "no_apst";
+	case NVME_QUIRK_NO_DEEPEST_PS:
+		return "no_deepest_ps";
+	case NVME_QUIRK_QDEPTH_ONE:
+		return "qdepth_one";
+	case NVME_QUIRK_MEDIUM_PRIO_SQ:
+		return "medium_prio_sq";
+	case NVME_QUIRK_IGNORE_DEV_SUBNQN:
+		return "ignore_dev_subnqn";
+	case NVME_QUIRK_DISABLE_WRITE_ZEROES:
+		return "disable_write_zeroes";
+	case NVME_QUIRK_SIMPLE_SUSPEND:
+		return "simple_suspend";
+	case NVME_QUIRK_SINGLE_VECTOR:
+		return "single_vector";
+	case NVME_QUIRK_128_BYTES_SQES:
+		return "128_bytes_sqes";
+	case NVME_QUIRK_SHARED_TAGS:
+		return "shared_tags";
+	case NVME_QUIRK_NO_TEMP_THRESH_CHANGE:
+		return "no_temp_thresh_change";
+	case NVME_QUIRK_NO_NS_DESC_LIST:
+		return "no_ns_desc_list";
+	case NVME_QUIRK_DMA_ADDRESS_BITS_48:
+		return "dma_address_bits_48";
+	case NVME_QUIRK_SKIP_CID_GEN:
+		return "skip_cid_gen";
+	case NVME_QUIRK_BOGUS_NID:
+		return "bogus_nid";
+	case NVME_QUIRK_NO_SECONDARY_TEMP_THRESH:
+		return "no_secondary_temp_thresh";
+	case NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND:
+		return "force_no_simple_suspend";
+	case NVME_QUIRK_BROKEN_MSI:
+		return "broken_msi";
+	case NVME_QUIRK_DMAPOOL_ALIGN_512:
+		return "dmapool_align_512";
+	}
+
+	return "unknown";
+}
+
 /*
  * Common request structure for NVMe passthrough.  All drivers must have
  * this structure as the first member of their request-private data.
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..16c6fea4b2db 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -601,6 +601,28 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+static ssize_t quirks_show(struct device *dev, struct device_attribute *attr,
+                char *buf)
+{
+	int count = 0, i;
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned long quirks = ctrl->quirks;
+
+	if (!quirks)
+		return sysfs_emit(buf, "none\n");
+
+	for (i = 0; quirks; ++i) {
+		if (quirks & 1) {
+			count += sysfs_emit_at(buf, count, "%s\n",
+					nvme_quirk_name(BIT(i)));
+		}
+		quirks >>= 1;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RO(quirks);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -742,6 +764,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+	&dev_attr_quirks.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
-- 
2.47.3


