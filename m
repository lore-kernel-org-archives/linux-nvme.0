Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C20CCCD1AB
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Oct 2025 03:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3AdkHWGdY7Rb4p5SryOE9tkFRoKJcY1LS6rAaEq9CZ8=; b=md15+9qErNLSZxayJ8jdDWdCVP
	HzR36VlbEQjpJQjnPmbZWyc/rUKCtV6lExPlCEZUSIFS3wIvLNDssRWRDeD5ntGbS4LaSgHCAQB63
	HiTSM7WFHhuAI5Bqq/WAexM2Z8iiLwbZ7T7Plz6/B5JcizN6eiXxtbNxyp2C1YujQFz1L8KdueCpl
	Zp5wXO3ABc3tVimtDkHXVYv3u+Pj6gYGzgpaVCCYhxVyap3FZFEDLZm+KXJaa5uJy2zy2lR/5u4Jw
	eQkta0Gt+M4kYhDEQBnFeq3gZnWj2fXGacEpkcqmculxo+Nj3iNwUTmXhcyLCLlArWxk3gv3AeoFO
	q/LeuIWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8h9-00000008AP3-42Ue;
	Fri, 24 Oct 2025 03:42:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC8h7-00000008AOf-2SqE
	for linux-nvme@lists.infradead.org;
	Fri, 24 Oct 2025 03:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761277344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3AdkHWGdY7Rb4p5SryOE9tkFRoKJcY1LS6rAaEq9CZ8=;
	b=ViXr8bvZVZJi0r8zy2JsUAhI3P7p6YR9fe/T4mi1oebq9TfBNmVxWhgCS4ycCDidr/lx4T
	BTTgKzFCXh1lRgeVBA/lya+FDOM9JVG5r0Qjgmwvyv9XluITGw3n2iMwqBDCezD7qEpwJg
	9Au5D7u40Bqsp1HjI+8YkkVTUVEEI80=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-NCN4550xPhe31AiS85h0cg-1; Thu,
 23 Oct 2025 23:42:20 -0400
X-MC-Unique: NCN4550xPhe31AiS85h0cg-1
X-Mimecast-MFC-AGG-ID: NCN4550xPhe31AiS85h0cg_1761277338
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 243E518002EC;
	Fri, 24 Oct 2025 03:42:18 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 485F830002D7;
	Fri, 24 Oct 2025 03:42:08 +0000 (UTC)
Date: Fri, 24 Oct 2025 11:42:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
Message-ID: <aPr1i-k0byzYjv8G@fedora>
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023201830.3109805-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_204225_719181_A5A8405F 
X-CRM114-Status: GOOD (  22.36  )
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

On Thu, Oct 23, 2025 at 02:18:30PM -0600, Caleb Sander Mateos wrote:
> io_uring task work dispatch makes an indirect call to struct io_kiocb's
> io_task_work.func field to allow running arbitrary task work functions.
> In the uring_cmd case, this calls io_uring_cmd_work(), which immediately
> makes another indirect call to struct io_uring_cmd's task_work_cb field.
> Define the uring_cmd task work callbacks as functions whose signatures
> match io_req_tw_func_t. Define a IO_URING_CMD_TASK_WORK_ISSUE_FLAGS
> constant in io_uring/cmd.h to avoid manufacturing issue_flags in the
> uring_cmd task work callbacks. Now uring_cmd task work dispatch makes a
> single indirect call to the uring_cmd implementation's callback. This
> also allows removing the task_work_cb field from struct io_uring_cmd,
> freeing up some additional storage space.

The idea looks good.

> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  block/ioctl.c                |  4 +++-
>  drivers/block/ublk_drv.c     | 15 +++++++++------
>  drivers/nvme/host/ioctl.c    |  5 +++--
>  fs/btrfs/ioctl.c             |  4 +++-
>  fs/fuse/dev_uring.c          |  5 +++--
>  include/linux/io_uring/cmd.h | 16 +++++++---------
>  io_uring/uring_cmd.c         | 13 ++-----------
>  7 files changed, 30 insertions(+), 32 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index d7489a56b33c..5c10d48fab27 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -767,13 +767,15 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>  struct blk_iou_cmd {
>  	int res;
>  	bool nowait;
>  };
>  
> -static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int issue_flags)
> +static void blk_cmd_complete(struct io_kiocb *req, io_tw_token_t tw)
>  {
> +	struct io_uring_cmd *cmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
>  	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
> +	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;

Now `io_kiocb` is exposed to driver, it could be perfect if 'io_uring_cmd'
is kept in kernel API interface, IMO.

...

> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index b84b97c21b43..3efad93404f9 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -9,18 +9,13 @@
>  /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
>  #define IORING_URING_CMD_CANCELABLE	(1U << 30)
>  /* io_uring_cmd is being issued again */
>  #define IORING_URING_CMD_REISSUE	(1U << 31)
>  
> -typedef void (*io_uring_cmd_tw_t)(struct io_uring_cmd *cmd,
> -				  unsigned issue_flags);
> -
>  struct io_uring_cmd {
>  	struct file	*file;
>  	const struct io_uring_sqe *sqe;
> -	/* callback to defer completions to task context */
> -	io_uring_cmd_tw_t task_work_cb;
>  	u32		cmd_op;
>  	u32		flags;
>  	u8		pdu[32]; /* available inline for free use */

pdu[40]



Thanks,
Ming


