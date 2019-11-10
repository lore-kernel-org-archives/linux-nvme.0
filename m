Return-Path: <SRS0=U9tF=ZC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32C0C43331
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 18:27:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F9820818
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 18:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dl4hAfAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F9820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hasenleithner.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=va+gQ1JWt9BJTCcD7vvfxhXpYv3iewoNfmfALYwYn0g=; b=dl4hAfAy3jTYqRzbPoMNpBR6u9
	uLwanLVL27umaH3jW2vGRXYpihE06zEY1OB9ht5c7bgDi+zlMT7/mGzeIUvZ86H4LxJqA47jVXo3O
	n+JKF8hp/GVtJTYTWiExKGXLbeyIxrUb8VIuuLfENyEbOUM1ME5LgzscF5mVySPUEJZArP7GyjGQ+
	zqBHdFJ5Ji66jGSKAr5SZyoN7pYBd7RPyHxkA+OfGmRrZ1zCy5x48/0FIGz0VyuusXWa+U2g6SH31
	xNyUl0lDTZLGx+ayN0Ded1VIvTsblqQGmudy04IsTZlhXKuUPSBHI/W+eVO01ttByU4YgT/Py3Kix
	g0MjiHAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iTrvj-0004RQ-3V; Sun, 10 Nov 2019 18:27:19 +0000
Received: from hodge.hasenleithner.at ([88.99.36.100])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTrvf-0004Qi-5H
 for linux-nvme@lists.infradead.org; Sun, 10 Nov 2019 18:27:17 +0000
Received: from [IPv6:2001:470:584d::10] (unknown [IPv6:2001:470:584d::10])
 by hodge.hasenleithner.at (Postfix) with ESMTPSA id C0D767600D1;
 Sun, 10 Nov 2019 19:27:08 +0100 (CET)
From: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: [RFC PATCH v2] Workaround for discard on non-conformant nvme devices
To: linux-nvme@lists.infradead.org
Message-ID: <216cfad5-b724-f69d-9a8c-c5ee2ec13212@hasenleithner.at>
Date: Sun, 10 Nov 2019 19:27:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191110_102715_347866_7899AA17 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

As documented in https://bugzilla.kernel.org/show_bug.cgi?id=202665 
there are lots of Linux nvme users which get IO-MMU related errors when 
performing discard on nvme. So far analysis suggests that the errors are 
caused by non-conformant nvme devices which are reading beyond the end 
of the buffer containing the segments to be discarded.

Until now two different variants of this behavior have been observed: 
The controller found on an Intel 660p always reads a multiple of 512 
bytes. If the last chunk exceeds a page it continues with the subsequent 
page. For a Corsair MP510 the situation is even worse: The controller 
always reads a full page (4096) bytes. Then when the address is not 
aligned to 4096 it will continue reading at the address given in PRP2 
(which is most of the time 0).

This patch
* introduces a new NVME_QUIRK_DSM_PAGEALIGN
* makes the nvme_setup_discard function always return the
	(page aligned) discard_page for devices with the quirk

Since this patch is only RFC a list of affected devices is not included yet.

Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>

--- linux-5.3.7/drivers/nvme/host/core.c.orig	2019-11-04 
21:53:20.758837001 +0100
+++ linux-5.3.7/drivers/nvme/host/core.c	2019-11-10 19:11:49.419372363 +0100
@@ -562,8 +562,13 @@ static blk_status_t nvme_setup_discard(s
  	struct nvme_dsm_range *range;
  	struct bio *bio;

-	range = kmalloc_array(segments, sizeof(*range),
-				GFP_ATOMIC | __GFP_NOWARN);
+	if (!(ns->ctrl->quirks & NVME_QUIRK_DSM_PAGEALIGN)) {
+		range = kmalloc_array(segments, sizeof(*range),
+					GFP_ATOMIC | __GFP_NOWARN);
+	} else {
+		/* Device with quirk: use (page aligned) discard_page */
+		range = NULL;
+	}
  	if (!range) {
  		/*
  		 * If we fail allocation our range, fallback to the controller
--- linux-5.3.7/drivers/nvme/host/nvme.h.orig	2019-11-10 
18:16:39.097549037 +0100
+++ linux-5.3.7/drivers/nvme/host/nvme.h	2019-11-10 18:19:26.084893558 +0100
@@ -97,6 +97,11 @@ enum nvme_quirks {
  	 * Force simple suspend/resume path.
  	 */
  	NVME_QUIRK_SIMPLE_SUSPEND		= (1 << 10),
+
+	/*
+	 * Workaround for devices reading DSM beyond end of page.
+	 */
+	NVME_QUIRK_DSM_PAGEALIGN		= (1 << 11),
  };

  /*

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
