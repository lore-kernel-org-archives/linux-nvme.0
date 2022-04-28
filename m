Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495CDC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vpMWdP31TgoWmZqa+jOJhasoe4hDfA+qtv3m7vg6nzg=; b=Erm06lif9Av7QbnYnmiDEZ157V
	aa3+mdi6cHZyGjXgf1lH6HiA4XwUhL687qTohcIXwuOcHd6hS5b7CHknAQO5L/+0ht6dhRgPWv/BO
	p9piz+39UrTxAC8+1o1zN8w3COo6mIvf6j0zEulD4PCeeivWO+F4t1Q86i44Ds04WefvUyuMhFsfS
	jNoZMwSQvPB6UZnuTG2WZXWJZWYVy3pd6zw/f/3uNjlLO6CWhObFcnTQb0MPfxFrHU8R2d018jQ5V
	y16dtGCAA1EW99UtsMtUcvu3dDR6aDcdZJ2rmKh988KzduR/zy4doJ0AZqG6dwdnarWXxnxpqbNG9
	JBFYjuHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk7mL-00817I-UM; Thu, 28 Apr 2022 17:18:09 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk7mI-00816R-MA
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 17:18:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4B75EB82ECE;
 Thu, 28 Apr 2022 17:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3008C385A9;
 Thu, 28 Apr 2022 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651166283;
 bh=HjC/BFgZSv89pVAaK4Jqs81WfEG/KAQCWX2WCW/Ht/0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QOE6ZKjneLRq7nIDn4JpGNq6EwWt7UfpXHtufuH8LYcCRFYwIeFsGFgOTU6IY2l7Z
 JgO/WPNik5cqlzqjDCJZb3F3AgVtAL2euX/cYFy+pKGgWYfHcF8F27tMVIqQEXgvBH
 7X5Q60HbBO6D++/Eu6/H0vwT1IDlpnBOWJBGAnht19+sglN5VNV6NpWwGSn+1Ip0Lf
 riVV2JYPN+5zLSdjqBtfgE6SahjB7HKqmBD8/gTO1keInqsjJp0u3VlVIX2z7TbSsP
 d6NdbVRbYitMlDhQmdy03AUUz2fh839B8d6jqEKvJ7tqhjJK2UnZfrzLQFuflP9U8T
 60/8V7Hmk7TRw==
Date: Thu, 28 Apr 2022 11:18:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tom Yan <tom.ty89@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@infradead.org, sagi@grimberg.me
Subject: Re: [PATCH v3] nvme: fix interpretation of dmrsl
Message-ID: <YmrMSGDDn3UMnJ8t@kbusch-mbp.dhcp.thefacebook.com>
References: <YmquYxXtGXlNB0PL@infradead.org>
 <20220428165051.4708-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428165051.4708-1-tom.ty89@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_101806_905780_F6A44077 
X-CRM114-Status: GOOD (  11.81  )
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

On Fri, Apr 29, 2022 at 12:50:51AM +0800, Tom Yan wrote:
> @@ -1606,6 +1606,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	struct request_queue *queue = disk->queue;
>  	u32 size = queue_logical_block_size(queue);
> +	int lts_shift = ilog2(size) - 9;
>  
>  	if (ctrl->max_discard_sectors == 0) {
>  		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
> @@ -1622,6 +1623,9 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
>  		return;
>  
> +	if (ctrl->dmrsl && ctrl->dmrsl <= UINT_MAX >> lts_shift)
> +		ctrl->max_discard_sectors = ctrl->dmrsl << lts_shift;
> +
>  	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);

I think the only change you really need is just changing the above line to:

  	blk_queue_max_discard_sectors(queue, nvme_lba_to_sect(ns, ctrl->max_discard_sectors));

