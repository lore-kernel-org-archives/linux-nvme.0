Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6BCC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 13:41:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE79664FDC
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 13:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE79664FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rcX5BvnFmQ78DELr0aR3ywPhsG8R+JaCQ1iJw3Ispts=; b=KqLPTA9mXBuqOTYsokR4nVcV4
	YP4bYAU9/yaVlyTM9CRS97Zj8Y7/dGxtQC8d/vyqT/VRPyZ+B5FF1B+lmdutQemc7vUuYxsTo8RJ1
	2O/TyIoFdH0ZGtKnvzxtdmkhbjJOTx8o4n9EFMLnNZS6pPzAHOcfzNrI/KQ6H9J1DF9+WgadOqdTO
	4YSkRFmwBw8ornM7Uqx+cCzU0y7UvEax/EKKJhQfFqxMP/qiTHBku1Lq7bX63wv4Pc1B52Z9941+1
	BvfXthcN99ab1ADVUfOOqy+bHAO7L/FCV/EX28IzhfFeiRc3b0nwvtmJvHBJX+O4zO6/BsiBsA3IK
	JK3hemhzQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJz5T-006xho-0N; Wed, 10 Mar 2021 13:41:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJz5O-006xhA-Il
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 13:41:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 68A8D68D15; Wed, 10 Mar 2021 14:41:11 +0100 (CET)
Date: Wed, 10 Mar 2021 14:41:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210310134110.GA13063@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <20210310132156.GA12145@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310132156.GA12145@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_134114_795978_7953744A 
X-CRM114-Status: GOOD (  20.10  )
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

On Wed, Mar 10, 2021 at 02:21:56PM +0100, Christoph Hellwig wrote:
> Can you try this patch instead?
> 
> http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html

Actually, please try the patch below instead, it looks like our existing
logic messes up the units:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6ea..1867fdf2205bd7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1963,30 +1963,18 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
-static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
+/*
+ * Even though NVMe spec explicitly states that MDTS is not applicable to the
+ * write-zeroes, we are cautious and limit the size to the controllers
+ * max_hw_sectors value, which is based on the MDTS field and possibly other
+ * limiting factors.
+ */
+static void nvme_config_write_zeroes(struct request_queue *q,
+		struct nvme_ctrl *ctrl)
 {
-	u64 max_blocks;
-
-	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
-	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
-		return;
-	/*
-	 * Even though NVMe spec explicitly states that MDTS is not
-	 * applicable to the write-zeroes:- "The restriction does not apply to
-	 * commands that do not transfer data between the host and the
-	 * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
-	 * In order to be more cautious use controller's max_hw_sectors value
-	 * to configure the maximum sectors for the write-zeroes which is
-	 * configured based on the controller's MDTS field in the
-	 * nvme_init_identify() if available.
-	 */
-	if (ns->ctrl->max_hw_sectors == UINT_MAX)
-		max_blocks = (u64)USHRT_MAX + 1;
-	else
-		max_blocks = ns->ctrl->max_hw_sectors + 1;
-
-	blk_queue_max_write_zeroes_sectors(disk->queue,
-					   nvme_lba_to_sect(ns, max_blocks));
+	if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
+	    !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
+		blk_queue_max_write_zeroes_sectors(q, ctrl->max_hw_sectors);
 }
 
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
@@ -2158,7 +2146,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
-	nvme_config_write_zeroes(disk, ns);
+	nvme_config_write_zeroes(disk->queue, ns->ctrl);
 
 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
 		test_bit(NVME_NS_FORCE_RO, &ns->flags));

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
