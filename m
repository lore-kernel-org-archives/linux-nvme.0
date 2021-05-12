Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B490AC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:33:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3563613B5
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3563613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wbmO7mnyA7r1IlEa/r8DmcmyST9d/Z2cL8tVMd+0jrk=; b=UFMBF2simJdr08+Gy8mRFjL7J
	ARU2hlvyNcDs3BeKBJZu2FUgo/rCcYxV1sFk8goSu6MTRTM836ZQMc25NZA2/EHnf42yJbqTamKKN
	7yx05FzXGXRC89emq0sOMiIayjH46gKRihVSM5xf6GCrnc8R/uACka12aEF5QtWNCO2FoIZtAGCbx
	4kvxTimiBLVnAukwYb2K8vmDfOY1Zp8s2UgoBp2VjBzsiMca27N76m8I8fliKbdhrm8whP7SET2Vm
	S79hS2atoMgkAEOS4LtaSaitNH5G1tz61slfxLX/7rl+9f7zTHQdl++CK/6aoaVf6k7CA7DN7rhUM
	uHExA03lw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgwTB-004486-RZ; Wed, 12 May 2021 21:32:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwT8-00446z-E1
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 21:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Oa4MHUZESZvD55q5DUblchF1jitny5pzMDc1Ed/souA=; b=ZqPQKqDIGF5Ypa7A0J7wAJjJcI
 eIBdt7uM9bqTNPRnlfiEgglKlFazTaHdvmwGVUdXSFYgAVOxZuUt4TRvfv8U66/utD12UbLC7pUmJ
 Jp7o2VMHNXy0iELmp4XfOrdXkf+vGtLmHZdbPeg3PmKkrl2dlfk/7CWd9IcuBZzAPMnzCteEkpR3V
 hlvvbc+0UxcdO6FDpyinCPS2oUM7iJOvUGlvE1eVFE6opdIESCjtFuzHOFU4bfZmI1i7Pu8eZbM2C
 Afp9lbe6sYt/UswZgnlIIQPPU69c5L2UFFLwBoF0UIjJdkBFszXO5R2lvPTtSHS7Sh3eYtKNP6QiI
 xqNFVqTw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwT5-00AqGn-QY
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 21:32:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 539DD61352;
 Wed, 12 May 2021 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620855154;
 bh=m4zYFt9qsjR5CpKrONf2H7NpIJ88zehjuQ/jbBnlStY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KxzzzZr3Di3w/5k8P8MV+P16/Tzk+8Mr8iJOrCqrTIWPf9DmRLy/oSYb7/yLO7Dfs
 MIsLsylIYciGF1QUZZON5L5QjgLj1FJZ8L3LgmFW5vHdqJxHSJWF7x0orrHNOcX5t8
 tgm9YcMUwc4WwyfotuRigZ9eWt1jokOv9K8NjKkVYv/+jja6ddVTRgGnenRW++g01u
 dUeuamRTr+xRCKLKxHXUCNVGi7OnItKqLuVTeGZkhfYdiVQxnVbBiGKp5WZKxsUfJV
 8A2hfF2u2T7JQyM6wslxE4X8ilYdUYLv9SrL/PLv0LzsNUKXIxTAYT4/bDQPjXUPiI
 1wXF5j59KO8ow==
Date: Wed, 12 May 2021 14:32:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Ming Lei <ming.lei@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 03/15] iomap: don't try to poll multi-bio I/Os in
 __iomap_dio_rw
Message-ID: <20210512213230.GB8543@magnolia>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512131545.495160-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_143235_954635_81B956E4 
X-CRM114-Status: GOOD (  24.15  )
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

On Wed, May 12, 2021 at 03:15:33PM +0200, Christoph Hellwig wrote:
> If an iocb is split into multiple bios we can't poll for both.  So don't
> bother to even try to poll in that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ahh the fun of reviewing things like iopoll that I'm not all /that/
familiar with...

> ---
>  fs/iomap/direct-io.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..d5637f467109 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -282,6 +282,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	if (!iov_iter_count(dio->submit.iter))
>  		goto out;
>  
> +	/*
> +	 * We can only poll for single bio I/Os.
> +	 */
> +	if (need_zeroout ||
> +	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))

Hm, is this logic here to catch the second iomap_dio_zero below the
zero_tail: label?  What happens if we have an unaligned direct write
that starts below EOF but (for whatever reason) ends the loop with pos
now above EOF but not on a block boundary?

> +		dio->iocb->ki_flags &= ~IOCB_HIPRI;
> +
>  	if (need_zeroout) {
>  		/* zero out from the start of the block to the write offset */
>  		pad = pos & (fs_block_size - 1);
> @@ -339,6 +346,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
>  						 BIO_MAX_VECS);
> +		/*
> +		 * We can only poll for single bio I/Os.
> +		 */
> +		if (nr_pages)
> +			dio->iocb->ki_flags &= ~IOCB_HIPRI;
>  		iomap_dio_submit_bio(dio, iomap, bio, pos);
>  		pos += n;
>  	} while (nr_pages);
> @@ -579,6 +591,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			iov_iter_revert(iter, pos - dio->i_size);
>  			break;
>  		}
> +
> +		/*
> +		 * We can only poll for single bio I/Os.
> +		 */
> +		iocb->ki_flags &= ~IOCB_HIPRI;

Hmm, why is this here?  Won't this clear IOCB_HIPRI even if the first
iomap_apply call successfully creates a polled bio for the entire iovec
such that we exit the loop one line later because count becomes zero?
How does the upper layer (io_uring, I surmise?) know that there's
a bio that it should poll for?

<shrug> Unless the only effect that this has is making it so that the
subsequent calls to iomap_apply don't have the polling mode set?  I see
enough places in io_uring.c that check (iocb->ki_flags & IOCB_HIPRI) to
make me wonder if the lifetime of that flag ends as soon as we get to
->{read,write}_iter?

--D

>  	} while ((count = iov_iter_count(iter)) > 0);
>  	blk_finish_plug(&plug);
>  
> -- 
> 2.30.2
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
