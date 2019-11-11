Return-Path: <SRS0=nCXg=ZD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB8DC43331
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 22:07:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEB42173B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 22:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EXDVGWQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEB42173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hasenleithner.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yaAAea0XIfSB2Iwv35g9CIgS4Rm8fGChvAOBMTsETWc=; b=EXDVGWQvGEuBdF
	3Gy5dJEYTwwnwfKDVutT0tMphQAat3centNIltTydyoDwjzbZYDUZrq/5Ur0kpxVcK43diTVnMCSa
	62wg4ymaCaQKGLv8b/XKn8V8d75buCm/2i/3UWFo585bkvk+3pftGGwwem0J3ogV8UjTV22HCD390
	Jt1urnUOPtM2v5XOfvu9wvWvyK7O4AEaKCuTVcNNIL0INZelPoMUFd7OokEp+K7YmO4V1ScWeSWAv
	ylFDUg0dDYc6oBObkVAFoASWq3UTk9uC8mSwCZTmzAagGLDBYFrJWtVkToEg/Zg2VrwvtNANxCV9K
	f3HvgO4ZoeSwq9RM3hJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUHqg-0003hX-6Y; Mon, 11 Nov 2019 22:07:50 +0000
Received: from hodge.hasenleithner.at ([2a01:4f8:c17:651d::2])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUHqd-0003gz-8I
 for linux-nvme@lists.infradead.org; Mon, 11 Nov 2019 22:07:49 +0000
Received: from [IPv6:2001:470:584d::10] (unknown [IPv6:2001:470:584d::10])
 by hodge.hasenleithner.at (Postfix) with ESMTPSA id 0BBE7760095
 for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2019 23:07:43 +0100 (CET)
From: Eduard Hasenleithner <eduard@hasenleithner.at>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v3] Workaround for discard on non-conformant nvme devices
Message-ID: <aa716b06-6e9a-f668-49b4-4007bd3bffae@hasenleithner.at>
Date: Mon, 11 Nov 2019 23:07:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_140747_607851_E1AFE034 
X-CRM114-Status: GOOD (  12.59  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Some devices seem not to strictly adhere to the DSM 'Number of Ranges' 
field when determining how much data to DMA. This behavior causes 
affected devices to incur read access violations with IO-MMU employed in 
modern setups. Logs of such read access violations were reported by 
several users in https://bugzilla.kernel.org/show_bug.cgi?id=202665

This patch
* introduces a new NVME_QUIRK_DSM_PAGEALIGN,
* makes the nvme_setup_discard function always return the
     (page aligned) discard_page for devices with the quirk, and
* adds a list of known to be affected devices gathered
     from said bugzilla.kernel.org entry

List of affected devices was gathered by Vladimir Smirnov. I can only 
confirm Intel 660p (always reads multiple of 512b) and Phison E12 
(always reads 4KB) to be affected.

Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>

--- linux-5.3.7/drivers/nvme/host/core.c.orig	2019-11-04 
21:53:20.758837001 +0100
+++ linux-5.3.7/drivers/nvme/host/core.c	2019-11-11 22:10:15.096817458 +0100
@@ -559,11 +559,13 @@ static blk_status_t nvme_setup_discard(s
  		struct nvme_command *cmnd)
  {
  	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
-	struct nvme_dsm_range *range;
+	struct nvme_dsm_range *range = NULL;
  	struct bio *bio;

-	range = kmalloc_array(segments, sizeof(*range),
-				GFP_ATOMIC | __GFP_NOWARN);
+	if (!(ns->ctrl->quirks & NVME_QUIRK_DSM_PAGEALIGN)) {
+		range = kmalloc_array(segments, sizeof(*range),
+					GFP_ATOMIC | __GFP_NOWARN);
+	}
  	if (!range) {
  		/*
  		 * If we fail allocation our range, fallback to the controller
--- linux-5.3.7/drivers/nvme/host/nvme.h.orig	2019-11-10 
18:16:39.097549037 +0100
+++ linux-5.3.7/drivers/nvme/host/nvme.h	2019-11-11 22:12:39.415402403 +0100
@@ -97,6 +97,14 @@ enum nvme_quirks {
  	 * Force simple suspend/resume path.
  	 */
  	NVME_QUIRK_SIMPLE_SUSPEND		= (1 << 10),
+
+	/*
+	 * For devices that do not consider the DSM 'Number of Ranges'
+	 * field when determining how much data to DMA. Page aligned and
+	 * sized is always sufficient as that is the largest a DSM range
+	 * list can be.
+	 */
+	NVME_QUIRK_DSM_PAGEALIGN		= (1 << 11),
  };

  /*
--- linux-5.3.7/drivers/nvme/host/pci.c.orig	2019-11-10 
18:31:23.685680418 +0100
+++ linux-5.3.7/drivers/nvme/host/pci.c	2019-11-11 22:30:47.248248362 +0100
@@ -3012,12 +3012,28 @@ static const struct pci_device_id nvme_i
  				NVME_QUIRK_DEALLOCATE_ZEROES, },
  	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
-				NVME_QUIRK_MEDIUM_PRIO_SQ },
+				NVME_QUIRK_MEDIUM_PRIO_SQ |
+				NVME_QUIRK_DSM_PAGEALIGN, },
  	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
-		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_DSM_PAGEALIGN, },
+	{ PCI_VDEVICE(INTEL, 0xf1a8),	/* Intel 660p */
+		.driver_data = NVME_QUIRK_DSM_PAGEALIGN, },
  	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
  		.driver_data = NVME_QUIRK_IDENTIFY_CNS |
  				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x126f, 0x2260),   /* Silicon Motion SM2260 */
+		.driver_data = NVME_QUIRK_DSM_PAGEALIGN, },
+	{ PCI_DEVICE(0x126f, 0x2262),   /* Silicon Motion SM2262 */
+		.driver_data = NVME_QUIRK_DSM_PAGEALIGN, },
+	{ PCI_DEVICE(0x126f, 0x2263),   /* Silicon Motion SM2263 */
+		.driver_data = NVME_QUIRK_DSM_PAGEALIGN, },
+	{ PCI_DEVICE(0x126f, 0x2265),   /* Silicon Motion SM2265 */
+		.driver_data = NVME_QUIRK_DSM_PAGEALIGN, },
+	{ PCI_DEVICE(0x1987, 0x5012),   /* Phison E12 */
+		.driver_data = NVME_QUIRK_DSM_PAGEALIGN, },
+	{ PCI_DEVICE(0x1987, 0x5016),   /* Phison E16 */
+		.driver_data = NVME_QUIRK_DSM_PAGEALIGN, },
  	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
  		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
  	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
@@ -3038,6 +3054,8 @@ static const struct pci_device_id nvme_i
  		.driver_data = NVME_QUIRK_LIGHTNVM, },
  	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
  		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0xc0a9, 0x2263),   /* Crucial P1 (SM2263) */
+		.driver_data = NVME_QUIRK_DSM_PAGEALIGN, },
  	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
