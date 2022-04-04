Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9346C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=taJV9E0J6mA8Mv/QKhJQE/xRegmD9wXNvtdlXb0azB0=; b=1F9RHvd0RJeKtPbfKqEqxn1hx5
	X9G6kRfTbBFj2pABSV2dTNDgfR/rslBJMCafuW1z8g5OEfy4dhgvY6W49VO2STllzwTPJ3nulMZRS
	jd+up3L0Z0RjXVsLc9mqT5tLeTF6SVPnzWCO23wqCueMCRTyN9y3oHOQzdDu+CvObXJdc6yBkPeDW
	tGvftSI2YUky8Km7kxq2pkVPoMI8ziPUyoqi490j+0ABlOzLqgihAd/SYWXNpTyrlnvBhQTX2LAFW
	VCXEYDP9W2lt1abG05ruC+gdU1UgDdP5n82L0doW05HeAZfc7kDHBmzLYDQMamhvnsS/rxBY+4yNL
	mtbllNDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbGxV-00DZvk-2c; Mon, 04 Apr 2022 07:17:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbGxR-00DZu4-Kg
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 07:17:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B569868AFE; Mon,  4 Apr 2022 09:16:56 +0200 (CEST)
Date: Mon, 4 Apr 2022 09:16:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, pankydev8@gmail.com,
 javier@javigon.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [RFC 3/5] io_uring: add infra and support for IORING_OP_URING_CMD
Message-ID: <20220404071656.GC444@lst.de>
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110834epcas5p4d1e5e8d1beb1a6205d670bbcb932bf77@epcas5p4.samsung.com>
 <20220401110310.611869-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220401110310.611869-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_001702_030962_9929724B 
X-CRM114-Status: GOOD (  25.31  )
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

Cann we plese spell out instastructure here?  Or did you mean
infraread anyway :)

> -enum io_uring_cmd_flags {
> -	IO_URING_F_COMPLETE_DEFER	= 1,
> -	IO_URING_F_UNLOCKED		= 2,
> -	/* int's last bit, sign checks are usually faster than a bit test */
> -	IO_URING_F_NONBLOCK		= INT_MIN,
> -};

This doesn't actually get used anywhere outside of io_uring.c, so why
move it?

> +static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
> +{
> +	req->uring_cmd.driver_cb(&req->uring_cmd);
> +}
> +
> +void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
> +			void (*driver_cb)(struct io_uring_cmd *))
> +{
> +	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
> +
> +	req->uring_cmd.driver_cb = driver_cb;
> +	req->io_task_work.func = io_uring_cmd_work;
> +	io_req_task_work_add(req, !!(req->ctx->flags & IORING_SETUP_SQPOLL));
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);

I'm still not a fund of the double indirect call here.  I don't really
have a good idea yet, but I plan to look into it.

>  static void io_req_task_queue_fail(struct io_kiocb *req, int ret)

Also it would be great to not add it between io_req_task_queue_fail and
the callback set by it.

> +void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret)
> +{
> +	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
> +
> +	if (ret < 0)
> +		req_set_fail(req);
> +	io_req_complete(req, ret);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_done);

It seems like all callers of io_req_complete actually call req_set_fail
on failure.  So maybe it would be nice pre-cleanup to handle the
req_set_fail call from ĩo_req_complete?

> +	/* queued async, consumer will call io_uring_cmd_done() when complete */
> +	if (ret == -EIOCBQUEUED)
> +		return 0;
> +	io_uring_cmd_done(ioucmd, ret);

Why not:
	if (ret != -EIOCBQUEUED)
		io_uring_cmd_done(ioucmd, ret);
	return 0;

That being said I wonder why not just remove the retun value from
->async_cmd entirely and just require the implementation to always call
io_uring_cmd_done?  That removes the confusion on who needs to call it
entirely, similarly to what we do in the block layer for ->submit_bio.

> +struct io_uring_cmd {
> +	struct file     *file;
> +	void            *cmd;
> +	/* for irq-completion - if driver requires doing stuff in task-context*/
> +	void (*driver_cb)(struct io_uring_cmd *cmd);
> +	u32             flags;
> +	u32             cmd_op;
> +	u16		cmd_len;

The cmd_len field does not seem to actually be used anywhere.

> +++ b/include/uapi/linux/io_uring.h
> @@ -22,10 +22,12 @@ struct io_uring_sqe {
>  	union {
>  		__u64	off;	/* offset into file */
>  		__u64	addr2;
> +		__u32	cmd_op;
>  	};
>  	union {
>  		__u64	addr;	/* pointer to buffer or iovecs */
>  		__u64	splice_off_in;
> +		__u16	cmd_len;
>  	};
>  	__u32	len;		/* buffer size or number of iovecs */
>  	union {
> @@ -60,7 +62,10 @@ struct io_uring_sqe {
>  		__s32	splice_fd_in;
>  		__u32	file_index;
>  	};
> -	__u64	__pad2[2];
> +	union {
> +		__u64	__pad2[2];
> +		__u64	cmd;
> +	};

Can someone explain these changes to me a little more?

