Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E7AC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x24DqpnCau2DgCVLv8Veyc/ndJ3bl3U1k17s8qRBXMI=; b=lOhZ7qEM4WyAdWX0Cjkh6sRb36
	AZeRzIS+R1rEQ09NxHPXlhcRiVlMz6lDvnlqnKPo7DyVI8oL9NjvXtquWBvfJPLLhSC2W2SPI2Gp8
	nXMp9uUa3SMCtbW2x0SioZ8KEQLhYoiYVaPDueHRoaoOfLUcV6g8L3Xr+UEDdWETM31sHEnvVX+um
	y7qgQBvdl/IMfB1AP+qS3kN64NqBH3raIddJz6dg+ClTzSZkB83BjXOWkZ8mY4Nbqc7X7xQtWlRSb
	XLSVj+uvfeOTh3zk3xGwEci4qTxKTGuCahOl0Km8J846BWpKInJWjgKEDqIZvq2atBZJdgiIz6mfl
	Ci+rCUaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEuEk-00706x-Bh; Fri, 22 Jul 2022 15:06:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEuEh-007037-7W
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 15:06:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8CBB68AFE; Fri, 22 Jul 2022 17:06:35 +0200 (CEST)
Date: Fri, 22 Jul 2022 17:06:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: avoid unnecessary fsync and flush bio
Message-ID: <20220722150635.GA7327@lst.de>
References: <1658491944-34701-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658491944-34701-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_080639_448960_B672D523 
X-CRM114-Status: GOOD (  14.70  )
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

On Fri, Jul 22, 2022 at 08:12:24PM +0800, Guixin Liu wrote:
> @@ -333,10 +333,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>  static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>  {
>  	struct bio *bio = &req->b.inline_bio;
> +	struct request_queue *q = req->ns->bdev->bd_queue;
>  
>  	if (!nvmet_check_transfer_len(req, 0))
>  		return;
>  
> +	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {

This should be using a bdev_write_cache.

But more importantly:  if the backend does not have a volatile write
cache, and we should not even receive flushes from the remote side.

> +	if (req->ns->buffered_io)
> +		return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
> +	else
> +		return errno_to_nvme_status(req, 0);

No need for the else, and the simple success case can just use the
constant status and does not need a translation.

