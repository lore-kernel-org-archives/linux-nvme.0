Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CF606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MTf1ZFfs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/SQB0s9m3nMGtRyx/o5sNyvuyYNHFqW/HgtMVBQxlv8=; b=MTf1ZFfsn3heOD1YJ5kxtujyn8
	Dpw1l3by2ChMVPQ6FDbdFwVrtIhTm5zmlljFR8Az53H1+6hgvcdiggdIwuk8o3q/r5NklWUwcfeiu
	Mw/w++FTlSgjdM2suBlQf/A2mCi9blR/ckYv220RnhlxsrRFVwuQgakcUQQtsEGtQnzoVFN7w9EVp
	Z27E4Llc8nOyhehP736vRuxc4YZn8abgRaOKGptfwpZ1i9gXbCdf04mjeSwxomnwCZlncPE25z7fs
	ptNEteiHB1U1Wzn8XzVT7f8/nYCiNtkT5Z49dRCjNLkBJStM69t/+8J8NexV9xc+3ziOnp6R/Z4lo
	63d405KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqUe-00000001Ke4-0YEu;
	Mon, 16 Nov 2026 06:47:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqUa-00000001KdF-1yQj
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 06:47:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D40E68B05; Mon, 16 Nov 2026 07:46:55 +0100 (CET)
Date: Mon, 16 Nov 2026 07:46:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/12] zloop: take freeze protection for writes
Message-ID: <20261116064654.GA2964@lst.de>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org> <20261114-work-fs-frozen_writes-v1-2-f5ae61c898b1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-work-fs-frozen_writes-v1-2-f5ae61c898b1@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_224704_660132_F4A25822 
X-CRM114-Status: GOOD (  16.84  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 11:47:09AM +0100, Christian Brauner wrote:
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -514,6 +514,10 @@ static void zloop_rw_complete(struct kiocb *iocb, long ret)
>  {
>  	struct zloop_cmd *cmd = container_of(iocb, struct zloop_cmd, iocb);
>  
> +	/* A queued write still holds freeze protection. */
> +	if (req_op(blk_mq_rq_from_pdu(cmd)) != REQ_OP_READ)
> +		kiocb_end_write(iocb);

So io_uring, libario and cachefiles use the IOCB_WRITE flag on the
ioctl to make this somewhat generic.

> +	if (rw == ITER_DEST)
> +		return zone->file->f_op->read_iter(&cmd->iocb, &iter);
> +
> +	kiocb_start_write(&cmd->iocb);
> +	ret = zone->file->f_op->write_iter(&cmd->iocb, &iter);
> +	if (ret != -EIOCBQUEUED)
> +		kiocb_end_write(&cmd->iocb);
> +	return ret;

And then everyone duplicates this.  Do we want a little abstraction
for the above code + setting IOCB_WRITE, and then another one takes care
of the kiocb_end_write before or after calling into ->ki_complete?

Without that this is a lot of opencoding that feels a bit fragile.


