Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7289BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 02:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AtTr1AIg2fX5MAGAguqHpar1HIdpAfeTlW/Zsbtatqo=; b=ALeZNf1zrTQryTXPRLozeNN1uU
	+lCOIeYPuThXJBKyyOQcs7xazmXzYpz9ZSCAubUCvX/MD65c6YV7N9wZLlrjWh5DAcEGWyk12K2xJ
	jM83a1ohs4yK12k2SM8UyocCHCvx5e1IDTkSlBv9Tli01b/zXoYqOhP9iUQ3CHWszYD/3rFu9BExO
	Btp4MZJ/B/cXmQ1GnxzV7VHulwScuouKIVBajIJnK5gk7/7G8ddzsjtRFcU3Q/Ad4QKzNG+Xx7uQX
	Tr6As8sBUluM+jAp4PZho71rLfwyda33xhFTeo3XBqe0iNw4ytslmljdU1Vf0xOSZlRJLT56CT3B0
	JCA0dH2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKWIM-008jYM-SO; Thu, 17 Feb 2022 02:13:22 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nKWIJ-008jY5-RC; Thu, 17 Feb 2022 02:13:19 +0000
Date: Wed, 16 Feb 2022 18:13:19 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, javier@javigon.com, anuj20.g@samsung.com,
 joshiiitr@gmail.com, pankydev8@gmail.com
Subject: Re: [RFC 01/13] io_uring: add infra for uring_cmd completion in
 submitter-task
Message-ID: <Yg2vP7lo3hGLGakx@bombadil.infradead.org>
References: <20211220141734.12206-1-joshi.k@samsung.com>
 <CGME20211220142228epcas5p2978d92d38f2015148d5f72913d6dbc3e@epcas5p2.samsung.com>
 <20211220141734.12206-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220141734.12206-2-joshi.k@samsung.com>
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

On Mon, Dec 20, 2021 at 07:47:22PM +0530, Kanchan Joshi wrote:
> Completion of a uring_cmd ioctl may involve referencing certain
> ioctl-specific fields, requiring original submitter context.
> Export an API that driver can use for this purpose.
> The API facilitates reusing task-work infra of io_uring, while driver
> gets to implement cmd-specific handling in a callback.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/io_uring.c            | 16 ++++++++++++++++
>  include/linux/io_uring.h |  8 ++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index e96ed3d0385e..246f1085404d 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2450,6 +2450,22 @@ static void io_req_task_submit(struct io_kiocb *req, bool *locked)
>  		io_req_complete_failed(req, -EFAULT);
>  }
>  
> +static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
> +{
> +	req->uring_cmd.driver_cb(&req->uring_cmd);

If the callback memory area is gone, boom.

> +}
> +
> +void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
> +			void (*driver_cb)(struct io_uring_cmd *))

Adding kdoc style comment for this would be nice. Please document
the context that is allowed.

> +{
> +	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
> +
> +	req->uring_cmd.driver_cb = driver_cb;
> +	req->io_task_work.func = io_uring_cmd_work;
> +	io_req_task_work_add(req, !!(req->ctx->flags & IORING_SETUP_SQPOLL));

This can schedules, and so the callback may go fishing in the meantime.

> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);
> +
>  static void io_req_task_queue_fail(struct io_kiocb *req, int ret)
>  {
>  	req->result = ret;
> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
> index 64e788b39a86..f4b4990a3b62 100644
> --- a/include/linux/io_uring.h
> +++ b/include/linux/io_uring.h
> @@ -14,11 +14,15 @@ struct io_uring_cmd {
>  	__u16		op;
>  	__u16		unused;
>  	__u32		len;
> +	/* used if driver requires update in task context*/

By using kdoc above youcan remove this comment.

> +	void (*driver_cb)(struct io_uring_cmd *cmd);

So we'd need a struct module here I think if we're going to
defer this into memory which can be removed.

  Luis

