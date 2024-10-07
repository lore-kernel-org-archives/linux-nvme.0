Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A29CFB451
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DRrlOk6E1Hl5oHdAOsPFpjFP0qJ/kkvTaXrTz7nOEDE=; b=GTAEkWY8F6ieGszn07w0g0GY90
	dLes8NVRmWfH8/zR7jYnwMIpzKsDFIaoocnOhEW41Tz0s7dCi/R6NIhntTSgcgcwJ38anXB9sNnxp
	ULsG/ERHjcgUn38NcFvuV3nc68UdsO5bm5DJOFTsZxuioQL8ATn9jmXOhchV65Konb7IzCTTVWxdf
	4Vj4+2YMx6uHVUGdRR6pPFbAgwz8FnjfqfKRuNGq/Uhgz3Z4oXbvK+L/G+hoQFzg1sVR82I7nIS7a
	SiiTpgx1f15zUfzuFa58R0IXmY/sNR3CtnovscrpzEjjtP/wFg+UsUIG7L0cxWfaAzMh3iheUkYkO
	dnwz3rBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxsKQ-00000003SG7-1laV;
	Mon, 07 Oct 2024 18:19:30 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxsKN-00000003SEE-18JJ
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 18:19:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CB1FBA41FB3;
	Mon,  7 Oct 2024 18:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB8FC4CEC7;
	Mon,  7 Oct 2024 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325165;
	bh=igm7Bsx6+fZcX44W/YCzn+o4Dw98CbfqMaZS0DxtiFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzKJyjPPeJ7iiklG6K9SXEeS0LfupRmlErt4FVH1uJP6bNndXEiZV33FTQaJWtt8Z
	 7Q/nsbxweiTj+FEqYmfw0dz7mVBnIPOP1Jyi/d/eaMz+jaHBYdBh4FJFmDXIeHasTq
	 f26JI2TrO2E40OPTMvrLwS1HfU8kZJV04HOQS8c/APanCcAIViPaaw3KXFJcH86HDy
	 RkcaNSBYBNfJ5F5twVAGsVYzdrxyQlzGCxSa9Ae+GQJYUl89gzXF9iOsUGWH9iIjqX
	 TwhvOo66QTSTTBgUVZGejGl+6EQ/Ptdpg5vpFF2MwNa7BND/Ahwf8iMdMX6QRR9Onn
	 pnXIHRqUb8/lQ==
Date: Mon, 7 Oct 2024 12:19:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on
 stuck partition scan
Message-ID: <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007100134.21104-3-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_111927_394724_45BEBF23 
X-CRM114-Status: GOOD (  14.22  )
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

On Mon, Oct 07, 2024 at 12:01:33PM +0200, Hannes Reinecke wrote:
> @@ -239,6 +239,13 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
>  {
>  	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
>  
> +	/*
> +	 * Skip deleted controllers for I/O from partition scan
> +	 */
> +	if (state == NVME_CTRL_DELETING &&
> +	    mutex_is_locked(&ns->ctrl->scan_lock))
> +		return true;

This feels off to me, using these seemingly unrelated dependencies to
make these kinds of decisions.

We talked a couple weeks ago about suppressing the parition scanning
during nvme scan_work. I know you said there was some reason it wouldn't
work, but could you check the below? It seems okay to me.

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 48e7a8906d012..82cb1eb3a773b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -586,6 +586,12 @@ static void nvme_requeue_work(struct work_struct *work)
 		container_of(work, struct nvme_ns_head, requeue_work);
 	struct bio *bio, *next;
 
+	if (test_and_clear_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state)) {
+		mutex_lock(&head->disk->open_mutex);
+		bdev_disk_changed(head->disk, false);
+		mutex_unlock(&head->disk->open_mutex);
+	}
+
 	spin_lock_irq(&head->requeue_lock);
 	next = bio_list_get(&head->requeue_list);
 	spin_unlock_irq(&head->requeue_lock);
@@ -629,6 +635,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		return PTR_ERR(head->disk);
 	head->disk->fops = &nvme_ns_head_ops;
 	head->disk->private_data = head;
+	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
 	return 0;
--

