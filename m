Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A5CC531F9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HeLi3cYbc3bVGppW4plLifn1UQG3PWFSk8cImbFB1Pg=; b=0oOjpZStFVgqxS
	/v2LPO4rJHcIXMmO1lMUUsLPWfX8hqgiPhWGZgxCw+QsTI21iMN8Ywblrh4Vbl6ayPkwEPkhlqy02
	Kkcwi5u1rPb6hk7VdFhd3cKatoixQziiFaRcEnpukcaV3izW6hyKis2SaLpwivn3IXpc81l+XqGyS
	TeiROw5K2t6ZldnuuE+4PZ8zckLAzoIax7AMHaF0Wc4Q5Qv5HNXPCN1P/0R0I4uzZQERS7CYfCpWZ
	JxrZpiQGaaLpBjgZPGmkqNHjnOwa7Yq9rdMlwo6shS507KVb4E/vSs4INNPliDkN7hOHcLhnLBkZj
	49vZZke+ecuYiORKCpcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnKzY-0000000H5z0-2GUb;
	Fri, 24 Jul 2026 18:51:28 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnKzW-0000000H5yg-3NBv
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 18:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=HeLi3cYbc3bVGppW4plLifn1UQG3PWFSk8cImbFB1Pg=; b=jjg68SQ2itQQU+efSypVQfQV2J
	lbOB4CouCbkRF2sBRX6sYzLPn9f3kq0kv0gWydzWQ+3s1s+gTW07PARHqOoSPrPFBEDkD5iIVCRpI
	GPnwepRfWEnaZozV+hzEq+uDhFTVTsFr4TfoSnHyc529MF+F94O4beKkwFj1KSFSqiRRe2c5VnKjB
	42eUHlf0kWy8GMassW93ZTVDDULkoG72VvEB/ZlQqteSejvffLwHqVFyErhseTvUKObOlSKjqMPPm
	FOIBs2Dd5ER0ZPltO9t4SOGmI1kGz4y7xtSGI+5mq8Z34i29DeCsZqxINkGrLCVRxiOBO3GqXcXyW
	veCk0MJw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.8])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wnKzT-0000000E1Q5-0fGd;
	Fri, 24 Jul 2026 12:51:23 -0600
Message-ID: <15a1fc13-f70d-4403-8084-2836fb05cd0e@deltatee.com>
Date: Fri, 24 Jul 2026 12:50:18 -0600
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
 <20260723204206.76930-11-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260723204206.76930-11-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 10/10] nvme-rdma: return BLK_STS_P2PDMA for unsupported
 P2P transfers
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_115126_874966_8C79D5B8 
X-CRM114-Status: GOOD (  16.77  )
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
> A P2P transfer the PCIe topology cannot route fails DMA mapping
> with -EREMOTEIO.  nvme-rdma folds every mapping error into -EIO, a
> retryable host-path error: multipath requeues the I/O forever, a
> single path burns its whole retry budget.
> 
> Propagate the real error code and return the unroutable case as the
> non-retryable BLK_STS_P2PDMA.  As in nvme-pci, -ENOMEM now requeues
> (BLK_STS_RESOURCE) and -EINVAL fails (BLK_STS_IOERR); -EIO stays a
> retryable host-path error.  While at it, start the request only
> after mapping succeeds -- nvme-pci's order -- and ratelimit the
> map-failure message.
> 
> Fixes: 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA transport")
> Cc: stable@vger.kernel.org # v7.1: requires "nvme-rdma: use ib_dma_map_sgtable_attrs()"
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

This is much more understandable now. Thanks. I have one nit below,
other than that:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/nvme/host/rdma.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 63830334c73e..2f50509a7a61 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1486,10 +1486,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
>  		.orig_nents	= req->data_sgl.nents,
>  	};
>  	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
> -	if (unlikely(ret)) {
> -		ret = -EIO;
> +	if (unlikely(ret))
>  		goto out_free_table;
> -	}
>  	*count = sgt.nents;
>  
>  	if (blk_integrity_rq(rq)) {
> @@ -1511,10 +1509,8 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
>  			.orig_nents	= req->metadata_sgl->nents,
>  		};
>  		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
> -		if (unlikely(ret)) {
> -			ret = -EIO;
> +		if (unlikely(ret))
>  			goto out_free_pi_table;
> -		}
>  		*pi_count = sgt.nents;
>  	}
>  
> @@ -2033,8 +2029,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (ret)
>  		goto unmap_qe;
>  
> -	nvme_start_request(rq);
> -
>  	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>  	    queue->pi_support &&
>  	    (c->common.opcode == nvme_cmd_write ||
> @@ -2046,11 +2040,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	err = nvme_rdma_map_data(queue, rq, c);
>  	if (unlikely(err < 0)) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			     "Failed to map data (%d)\n", err);
> +		dev_err_ratelimited(queue->ctrl->ctrl.device,
> +				    "Failed to map data (%d)\n", err);

This rate limit change probably doesn't belong in this patch. It's
pretty clear in the commit message with the "while at it" message. Worth
moving to another patch.

Logan

