Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A80BC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 07:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jHxXvcLvDrXrlno5uynUDXlmvHIaxBbjdXFmjP0Vz18=; b=JAu5Qw1szPHOY0a4StjjaD5kYG
	j5zW93VmBBDcb4dAU/JNCQouoMdfg492+je2ZCcO4hytxg6w1PLbgU3Pd3+y0LFvYaV3f15HVAlt0
	zyzqTwqNXErAjwP9nsuR372BPXXOAJVRvph9imED6fLEzXM40nA7OGcdCZX/eBqELPGWrIt207dnu
	LziM/219EiAvD3KwEECoHHgh5VrDpbV5Qnqs2TDkJjNLy91EPdPsFsnt2NXwQ5pBkq3/QB5Lpg6c0
	JNp8Nt3cHPiC+wkSkuiNdRiN9UDJ2Vd9OcSp2oZWicaqzxwj0q1XS+6+zJ/qVE3yNb8MzKN7U7l38
	QiAtALig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSZHh-00FIRd-Ji; Fri, 11 Mar 2022 07:01:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSZHe-00FIQq-FS
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 07:01:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1BBA868BEB; Fri, 11 Mar 2022 08:01:49 +0100 (CET)
Date: Fri, 11 Mar 2022 08:01:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Message-ID: <20220311070148.GA17881@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-6-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_230154_691702_4A9C18BE 
X-CRM114-Status: GOOD (  24.49  )
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

On Tue, Mar 08, 2022 at 08:50:53PM +0530, Kanchan Joshi wrote:
> +/*
> + * This overlays struct io_uring_cmd pdu.
> + * Expect build errors if this grows larger than that.
> + */
> +struct nvme_uring_cmd_pdu {
> +	u32 meta_len;
> +	union {
> +		struct bio *bio;
> +		struct request *req;
> +	};
> +	void *meta; /* kernel-resident buffer */
> +	void __user *meta_buffer;
> +} __packed;

Why is this marked __packed?

In general I'd be much more happy if the meta elelements were a
io_uring-level feature handled outside the driver and typesafe in
struct io_uring_cmd, with just a normal private data pointer for the
actual user, which would remove all the crazy casting.

> +static void nvme_end_async_pt(struct request *req, blk_status_t err)
> +{
> +	struct io_uring_cmd *ioucmd = req->end_io_data;
> +	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> +	/* extract bio before reusing the same field for request */
> +	struct bio *bio = pdu->bio;
> +
> +	pdu->req = req;
> +	req->bio = bio;
> +	/* this takes care of setting up task-work */
> +	io_uring_cmd_complete_in_task(ioucmd, nvme_pt_task_cb);

This is a bit silly.  First we defer the actual request I/O completion
from the block layer to a different CPU or softirq and then we have
another callback here.  I think it would be much more useful if we
could find a way to enhance blk_mq_complete_request so that it could
directly complet in a given task.  That would also be really nice for
say normal synchronous direct I/O.

> +	if (ioucmd) { /* async dispatch */
> +		if (cmd->common.opcode == nvme_cmd_write ||
> +				cmd->common.opcode == nvme_cmd_read) {

No we can't just check for specific commands in the passthrough handler.

> +			nvme_setup_uring_cmd_data(req, ioucmd, meta, meta_buffer,
> +					meta_len);
> +			blk_execute_rq_nowait(req, 0, nvme_end_async_pt);
> +			return 0;
> +		} else {
> +			/* support only read and write for now. */
> +			ret = -EINVAL;
> +			goto out_meta;
> +		}

Pleae always handle error in the first branch and don't bother with an
else after a goto or return.

> +static int nvme_ns_async_ioctl(struct nvme_ns *ns, struct io_uring_cmd *ioucmd)
> +{
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
> +
> +	switch (ioucmd->cmd_op) {
> +	case NVME_IOCTL_IO64_CMD:
> +		ret = nvme_user_cmd64(ns->ctrl, ns, NULL, ioucmd);
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +	}
> +
> +	if (ret >= 0)
> +		ret = -EIOCBQUEUED;

That's a weird way to handle the returns.  Just return -EIOCBQUEUED
directly from the handler (which as said before should be split from
the ioctl handler anyway).

