Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1578BCD6E55
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kmrEda0bQxPGtPcIxUwwakVA5hY4aI6ssTkbuwIHRjo=; b=yma8F5ntyo4omwOrHV65AXbWPR
	U3DXKoYUbmXiqSrgDryPbf1nIzp7ho89bu8CSTR8zKLR0zdTsX0E96LFRcXuTgwpmGSEKU+xmdDX6
	afQ0P8kAiX4iEFF8V7bqWI1MPKRXo50Cccop7PCemKSaTBDFy5CJEmorE6Jv7YYk04uuYqMzsOhc7
	Ajd5YrOG8+mJYsDSl9laDocUg75NBtSBcZy1Tnq18eGZ3daVqHen1vWyCv/l4OZVvqbP8jT6NVrqw
	QVXW4oxwT6LGjP7GsVQfQoYi2bYmTE8Rv/tLgrfS+sU+XvGjFr5XPIhoD8XhRChs2HwAjHSaWArWK
	x08jHgUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4x9-0000000BPue-2pF5;
	Mon, 01 Jun 2026 15:53:23 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4wC-0000000BPfS-3eOF
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 15:52:26 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gTdkt27pcz1XM0nw;
	Mon,  1 Jun 2026 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780329115; x=1782921116; bh=kmrEda0bQxPGtPcIxUwwakVA
	5hY4aI6ssTkbuwIHRjo=; b=K0M9gfpq3CIN5YDfH5BQ0f3gYo4/sVMeyTKg81B9
	mLmdrbPK3Tj5TCtTvZoQMvL2DZ3APPzvnShvE8CQXd5OSWuUaYb2SfXChPv+rqQc
	+Hxhglx9jn3YoSUEqEjbiXM0W/9JmmUvUcnA1XDNmT56eSK6lvjEC/yj0z0ui0I2
	g6YPc+WVhelP56EuEG3OxRFZC0g/mApe2NhLUaRSPG51BTzvd2MDMKWtMjakcUN1
	E2zW0GctQn4QgYIpkp5Dqd9kaHGD0GXxJzdokj+yxuK3UFMUO8S3L0XXuJHv7VhY
	rp7CVNgWS/23k2Zrm0ZHq4a4s/ELf6qJVQ4mU/3KQH+rsw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cIA1VVg0MIXx; Mon,  1 Jun 2026 15:51:55 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gTdk61Xt2z1XM2FV;
	Mon,  1 Jun 2026 15:51:41 +0000 (UTC)
Message-ID: <5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
Date: Mon, 1 Jun 2026 08:51:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com, sagi@grimberg.me,
 mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
 kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
 linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
 anna@kernel.org, achender@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, andriy.shevchenko@linux.intel.com, ebadger@purestorage.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@nvidia.com>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260601092534.1764560-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_085225_032037_7CB84B53 
X-CRM114-Status: GOOD (  13.86  )
X-Mailman-Approved-At: Mon, 01 Jun 2026 08:53:22 -0700
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

On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index b58868e1cf11..dc30d069ab3d 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -557,7 +557,7 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
>   	init_attr->cap.max_send_wr     = m * target->queue_size;
>   	init_attr->cap.max_recv_wr     = target->queue_size + 1;
>   	init_attr->cap.max_recv_sge    = 1;
> -	init_attr->cap.max_send_sge    = min(SRP_MAX_SGE, attr->max_send_sge);
> +	init_attr->cap.max_send_sge    = min_t(u32, SRP_MAX_SGE, attr->max_send_sge);
>   	init_attr->sq_sig_type         = IB_SIGNAL_REQ_WR;
>   	init_attr->qp_type             = IB_QPT_RC;
>   	init_attr->send_cq             = send_cq;
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9aec5d80117f..2ffa4f54cd4e 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -1884,7 +1884,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>   	 * both both, as RDMA contexts will also post completions for the
>   	 * RDMA READ case.
>   	 */
> -	qp_init->cap.max_send_wr = min(sq_size / 2, attrs->max_qp_wr);
> +	qp_init->cap.max_send_wr = min_t(u32, sq_size / 2, attrs->max_qp_wr);
>   	qp_init->cap.max_rdma_ctxs = sq_size / 2;
>   	qp_init->cap.max_send_sge = attrs->max_send_sge;
>   	qp_init->cap.max_recv_sge = 1;
> @@ -2298,7 +2298,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   	 * depth to avoid that the initiator driver has to report QUEUE_FULL
>   	 * to the SCSI mid-layer.
>   	 */
> -	ch->rq_size = min(MAX_SRPT_RQ_SIZE, sdev->device->attrs.max_qp_wr);
> +	ch->rq_size = min_t(u32, MAX_SRPT_RQ_SIZE, sdev->device->attrs.max_qp_wr);
>   	spin_lock_init(&ch->spinlock);
>   	ch->state = CH_CONNECTING;
>   	INIT_LIST_HEAD(&ch->cmd_wait_list);
> @@ -3225,7 +3225,7 @@ static int srpt_add_one(struct ib_device *device)
>   
>   	sdev->lkey = sdev->pd->local_dma_lkey;
>   
> -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);
>   
>   	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);

min_t() shouldn't be used if there is an alternative available. For the
SRP drivers, please make sure that both arguments of min() are unsigned
instead of using min_t().

Thanks,

Bart.

