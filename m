Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFB0C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:15:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D356125F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34D356125F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ka920EGe5R6FDFkYgQnrcer9VMKvc+XmXjCNy2P62Dk=; b=gFxA255tf2SgL+
	3bCIVKAH9kTIO6huL6wTxyDo6JBKC0papcDBt54p9bRTyPxVIlDVnJkPXlXbRTBFxnl7hbsgzleMp
	yR1DLq4ChGCzIQR/sU7HN0a8L5HLnqvslJsaSQax0BZ4nFqHPcLAAUh7XANHiAe+nUnAJPCw+yMX5
	fyzbj/ZoE8Nh0fGXTQiiCAvXOEIuXiNGhst3mgt9JiX6h790AoMTkophlcsWNZE4XdD7tl9V5B0Ol
	NQEIug3Ft5bpGxJnTyg1/mRZOfgw3w0bBj/XEZbsqXC5vq39gqc9fqdfgLshCxpBTyGXGMVmCIUKK
	Qjf4pgunczZ1JzNePmrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIPi4-001oNK-LW; Tue, 24 Aug 2021 06:14:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIPi2-001oN9-E9
 for linux-nvme@bombadil.infradead.org; Tue, 24 Aug 2021 06:14:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dQds9cSHSeE6kGx5MS02raO6iayqk63xe1w2A7iEq1M=; b=NAFLIm8m4aCi9SqoT2xstelsQt
 vDDY5oULL6Gmc1ZtN/gXrqKm8aT4pyL1HMdd/l2rqnGgXcV9wI4JDOqTNN4B9TBQDOR+FgwwGB+hC
 fVN/KSCGFY0auXuQHe7JihRBzo4EtOoqe2ZdAM3mAMsZk+1zS6mxXQtz21pklOJ9cM9Gq4EjMh2dC
 VNji9HAUzIQdgAkjytgO5wKENF8c6yy+BfZYUHRc1wJwRmWaSWdd5JxzsX07oeG29ZP7H46rvTk6j
 mURnUDtSYtcFQhIZ3HmOwQ46s6R9rtWUkAiy5MKh90yI8kvp0Wmvu5n28MAsamto4HyofHAZc1EFv
 5HJ8ucjg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mIPgP-00Adf8-0Q; Tue, 24 Aug 2021 06:13:28 +0000
Date: Tue, 24 Aug 2021 07:13:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
 bvanassche@acm.org, ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] mmc/core/block: add error handling support for
 add_disk()
Message-ID: <YSSN+eac2aCFXTAA@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210823202930.137278-7-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Mon, Aug 23, 2021 at 01:29:26PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> The caller cleanups the disk already so all we need to do
> is just pass along the return value.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/mmc/core/block.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4c11f171e56d..4f12c6d1e1b5 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2432,7 +2432,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	/* used in ->open, must be set before add_disk: */
>  	if (area_type == MMC_BLK_DATA_AREA_MAIN)
>  		dev_set_drvdata(&card->dev, md);
> -	device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> +	ret = device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
> +	if (ret)
> +		goto out;

This needs to do a blk_cleanup_queue and also te kfree of md.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
