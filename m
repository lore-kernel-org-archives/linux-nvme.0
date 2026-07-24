Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46674C531C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 18:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lyf4LTVkA3IdyxZk0dAuQutxNJYdqXOmUsPg3x/bmR8=; b=jFwh0DDmIl0IwM
	D5qEf/aMJP3qECi7NxbgfoaHyCSz0HNNAatH+w3scsWOIU1jSExUUWHaHuTUMTdZ5nxyYhcBm24hg
	sol64f+QmKe4Vcc0cJtvVp+vFmnUb4Dqy6Kj1fXkm8Tk+fxXime5bW11oJUuOeNzfJUqZyjTHjuLs
	zvPODtQPoOLuriMSAp8Q4ehYbi2KcDO6QcYsoBapLTQEKW5MohA/dHWKz6NCoxgXgtrWdF8ru3qi8
	K1REkUs2iyQS89JF/ijbqlzYbUxZVMDjpPMidn/0W71EI6jC1MDcDjHpTsoJ6c0YCqueQBTFsHw9P
	7gz9S5w3GNuznPRfdcyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnKwv-0000000H5rb-0X0Q;
	Fri, 24 Jul 2026 18:48:45 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnKws-0000000H5rH-2R5f
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 18:48:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=lyf4LTVkA3IdyxZk0dAuQutxNJYdqXOmUsPg3x/bmR8=; b=CrMKD2tfE0Krvs8mmKJfzJXDz0
	LF0h/ra2V9nlz87cZyJ86J3H6ImabZnYnPsYqIiEpBXoO9RUv/7g5Dq9VijqQDiKbGYhGn8g+ZhJt
	S4khpU6MaDXMK0mQFi2TPFxSYU/MgpoDxf7ijmhAmiC19FBztWb3kr8mV+7F/MDKiDNXvZ9+xEPp8
	jlFGycdN2IBoBaAq+xYUvS5zjX1ceFxqI075ggPHxB+oTofG2w1BvSeVI0o8Z+Cc+EeBhC312JzBD
	gP5CAE3fmuPoZAI2ruN94yLDmTtp80pO81vOECjgJvynWK3MfrFy1XhpHc5RFpKvGakw1pbEvQwzP
	oBIqCHaw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.8])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wnKwj-0000000E1PL-2AOY;
	Fri, 24 Jul 2026 12:48:34 -0600
Message-ID: <23b0a3ae-7f11-4ae9-8c1b-0401db0fd299@deltatee.com>
Date: Fri, 24 Jul 2026 12:47:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260723204206.76930-1-mykola@meshstor.io>
 <20260723204206.76930-10-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260723204206.76930-10-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 09/10] nvme-rdma: use ib_dma_map_sgtable_attrs()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_114842_625874_B4626982 
X-CRM114-Status: GOOD (  22.92  )
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



On 2026-07-23 2:42 p.m., Mykola Marzhan wrote:
> ib_dma_map_sg() folds every mapping error into a zero return, losing
> the DMA layer's error code.  Switch both scatterlist mappings to
> ib_dma_map_sgtable_attrs(), which preserves it for the next patch to
> act on.  No behavior change: failures are still reported as -EIO.
> 
> A local sg_table is needed: dma_map_sgtable() maps orig_nents
> entries, and the embedded table's orig_nents is the allocated count,
> not the count blk_rq_map_sg() produced.  rdma_rw_ctx_init() does the
> same.
> 
> Assisted-by: Claude:claude-fable-5
> Cc: stable@vger.kernel.org # v7.1
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

I don't know. I think this could still use a bit more cleanup (see
thoughts below). But the cleanup is probably too much to ask for this
series. See my thoughts below.

Reviewd-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/nvme/host/rdma.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 6909e3542794..63830334c73e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
>  		int *count, int *pi_count)
>  {
>  	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
> +	struct sg_table sgt;
>  	int ret;
>  
>  	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
> @@ -1480,12 +1481,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
>  
>  	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
>  
> -	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
> -			       req->data_sgl.nents, rq_dma_dir(rq));
> -	if (unlikely(*count <= 0)) {
> +	sgt = (struct sg_table) {
> +		.sgl		= req->data_sgl.sg_table.sgl,
> +		.orig_nents	= req->data_sgl.nents,
> +	};
> +	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
> +	if (unlikely(ret)) {
>  		ret = -EIO;
>  		goto out_free_table;
>  	}
> +	*count = sgt.nents;

This really makes these calls really complicated and harder to reason
about just to get an appropriate return code in the next patch. Though I
see the complexity here and I feel like I'm confused by the semantics of
nents and orig_nents all the time. It seems like some cases really need
to track three counts: the number of valid DMA addresses (nents), the
number of valid segments and the number actually allocated. sg_table
only has two fields, and orig_nents ends up doing double duty — the DMA
API reads it as the valid-segment count, while
sg_alloc/free_table_chained() treat it as the allocation size. When
those two differ, as they do here, it creates this complexity.

One cheap thought that might clean up this patch series is to create a
helper that can be used for both the data and the metadata, but that's
only slightly better and I don't know if it is worth the effort.

A better long term option might be to introduce a dma_map_sgtable like
helper that also takes the number of valid segments which would clean
this up pretty nicley. But that would be much more work.

Thanks,

Logan


