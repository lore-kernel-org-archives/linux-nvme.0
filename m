Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F4BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 08:53:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE3064E28
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 08:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE3064E28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l8wV3DNWTlUOhfJZ6UF1/Fqjy/83NYkS+6icyogclYk=; b=plVvUSrQa8Cm0pQEhfq2Uls+C
	5iuoZBgNspofa1nCnPJRpbj0BQKDueY8+yDSrOQtalXaQGQdmWMmbFNZdtBw79of3KNl54kiR/2pY
	YfuqeDUEmNILpqeQq7kD4JUdphHVMAT3e0Yh7ZareUwo5Lj2a8WxZCbLFht6QQbCNNq5AamW5HnAI
	iCcnEBD+pisjuoZgr/2vvmvaNl5AcN+pvtWf3rd+4uikXr3BCkj9rfYR2helIprGxx2xyyRdmmmnl
	ihXD+ipMhR8qGgXHx8uYffPUiaCAlA4EeCxKlNUhMIO9cbTkuluYR+Nsf6iBKt+Ee7WY07e61pNp9
	rQjAOxO+g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMRvT-002nan-RW; Wed, 17 Mar 2021 08:53:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMRvO-002nZR-Cq
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 08:53:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 95AA468BEB; Wed, 17 Mar 2021 09:52:58 +0100 (CET)
Date: Wed, 17 Mar 2021 09:52:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 chaitanya.kulkarni@wdc.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
 javier.gonz@samsung.com, nj.shetty@samsung.com, selvakuma.s1@samsung.com
Subject: Re: [RFC PATCH v3 3/3] nvme: wire up support for async passthrough
Message-ID: <20210317085258.GA19580@lst.de>
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140240epcas5p3e71bfe2afecd728c5af60056f21cc9b7@epcas5p3.samsung.com>
 <20210316140126.24900-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316140126.24900-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_085306_640451_C18EF319 
X-CRM114-Status: GOOD (  25.87  )
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

> +/*
> + * This is carved within the block_uring_cmd, to avoid dynamic allocation.
> + * Care should be taken not to grow this beyond what is available.
> + */
> +struct uring_cmd_data {
> +	union {
> +		struct bio *bio;
> +		u64 result; /* nvme cmd result */
> +	};
> +	void *meta; /* kernel-resident buffer */
> +	int status; /* nvme cmd status */
> +};
> +
> +inline u64 *ucmd_data_addr(struct io_uring_cmd *ioucmd)
> +{
> +	return &(((struct block_uring_cmd *)&ioucmd->pdu)->unused[0]);
> +}

The whole typing is a mess, but this mostly goes back to the series
you're basing this on.  Jens, can you send out the series so that
we can do a proper review?

IMHO struct io_uring_cmd needs to stay private in io-uring.c, and
the method needs to get the file and the untyped payload in form
of a void * separately.  and block_uring_cmd should be private to
the example ioctl, not exposed to drivers implementing their own
schemes.

> +void ioucmd_task_cb(struct io_uring_cmd *ioucmd)

This should be mark static and have a much more descriptive name
including a nvme_ prefix.

> +	/* handle meta update */
> +	if (ucd->meta) {
> +		void __user *umeta = nvme_to_user_ptr(ptcmd->metadata);
> +
> +		if (!ucd->status)
> +			if (copy_to_user(umeta, ucd->meta, ptcmd->metadata_len))
> +				ucd->status = -EFAULT;
> +		kfree(ucd->meta);
> +	}
> +	/* handle result update */
> +	if (put_user(ucd->result, (u32 __user *)&ptcmd->result))

The comments aren't very useful, and the cast here is a warning sign.
Why do you need it?

> +		ucd->status = -EFAULT;
> +	io_uring_cmd_done(ioucmd, ucd->status);

Shouldn't the io-uring core take care of this io_uring_cmd_done
call?

> +void nvme_end_async_pt(struct request *req, blk_status_t err)

static?

> +{
> +	struct io_uring_cmd *ioucmd;
> +	struct uring_cmd_data *ucd;
> +	struct bio *bio;
> +	int ret;
> +
> +	ioucmd = req->end_io_data;
> +	ucd = (struct uring_cmd_data *) ucmd_data_addr(ioucmd);
> +	/* extract bio before reusing the same field for status */
> +	bio = ucd->bio;
> +
> +	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> +		ucd->status = -EINTR;
> +	else
> +		ucd->status = nvme_req(req)->status;
> +	ucd->result = le64_to_cpu(nvme_req(req)->result.u64);
> +
> +	/* this takes care of setting up task-work */
> +	ret = uring_cmd_complete_in_task(ioucmd, ioucmd_task_cb);
> +	if (ret < 0)
> +		kfree(ucd->meta);
> +
> +	/* unmap pages, free bio, nvme command and request */
> +	blk_rq_unmap_user(bio);
> +	blk_mq_free_request(req);

How can we free the request here if the data is only copied out in
a task_work?

>  static int nvme_submit_user_cmd(struct request_queue *q,
>  		struct nvme_command *cmd, void __user *ubuffer,
>  		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
> -		u32 meta_seed, u64 *result, unsigned timeout)
> +		u32 meta_seed, u64 *result, unsigned int timeout,
> +		struct io_uring_cmd *ioucmd)
>  {
>  	bool write = nvme_is_write(cmd);
>  	struct nvme_ns *ns = q->queuedata;
> @@ -1179,6 +1278,20 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>  			req->cmd_flags |= REQ_INTEGRITY;
>  		}
>  	}
> +	if (ioucmd) { /* async handling */

nvme_submit_user_cmd already is a mess.  Please split this out into
a separate function.  Maybe the logic to map the user buffers can be
split into a little shared helper.

> +int nvme_uring_cmd(struct request_queue *q, struct io_uring_cmd *ioucmd,
> +		enum io_uring_cmd_flags flags)

Another comment on the original infrastructure:  this really needs to
be a block_device_operations method taking a struct block_device instead
of being tied into blk-mq.

> +EXPORT_SYMBOL_GPL(nvme_uring_cmd);

I don't think this shoud be exported.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
