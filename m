Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05A6C7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEc1nuA8wwNHcaPezx4OGjHPFwLxX0Z5BwaqLMJ+1Pg=; b=kMtIrIX8w+029AwiiAYhycazxx
	1RV8GM9c6s4QtDsKoZv3zoz+9Pztu7qZnzs9+au/SNA4AiOBlcW1UTECrNr5ShUITokmhdx9nwDDZ
	EG1z7TuaLv8oshtgiSMzlvoPAvwArs2+r08QX/8v1NVGaXH9P/u/06BV05h0iqjrtrRVE8KS62QWZ
	bxi0oCKoV26ZHhllwDeN8gIHk8YzzozDImfNdh2B5P7qHkFEWANgkFZPm2k142yys3i9JhJrtj5i6
	YZZDsO30Xnagos04AEmd3JdJ4S5AboPUsKjqltJhthWcsBbuhMtxnx1uB5UxtquKLlrOArjWw5g0S
	sD3AX4yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q43Pz-00En1U-0g;
	Tue, 30 May 2023 17:45:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q43Pv-00Emza-1n;
	Tue, 30 May 2023 17:45:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AFB6060DB4;
	Tue, 30 May 2023 17:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26DBC433EF;
	Tue, 30 May 2023 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685468753;
	bh=M2d8QfDnpbBofbpHBedx96eep1G2TGIo1MipTNzs2PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4PEQyK+Mb3z74hsjrsMPy/Evc1arWxzfqzw5cH2IvfHoHszeY/44cBnBqYAMJ+jP
	 xBGueyzWYa9U21olM5/VoQEq+1K0LVOMVFqH0/tKhXG5NgpXgY+oqcByD67g7R+1TH
	 QgZJETtDRtMqOoiIXXRKFQrci4R4JLPsf2mu1DYqVVJYpie6lNbKgynV+XlAgO+IT3
	 IBJSEfy/xuieAy7mkdMWFgMUDA8WND/LwP35qGMvo5L+/oK8tYqy5Z9KC0Ecn4XOTu
	 B3C20Rf4ygCQuBpZQUDWtpAzTq6G4LbfO0qERH5irkavwadEw/Ev/J0OQb+Jn1Tmaj
	 br4bRC0Dg2SGg==
Date: Tue, 30 May 2023 11:45:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Po-Wen Kao <powen.kao@mediatek.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	wsd_upstream@mediatek.com, peter.wang@mediatek.com,
	stanley.chu@mediatek.com, alice.chao@mediatek.com,
	naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
	cc.chou@mediatek.com, eddie.huang@mediatek.com,
	Ed Tsai <ed.tsai@mediatek.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/1] nvme: complete directly for hctx with only one
 ctx mapping
Message-ID: <ZHY2TUrKVBj2xGE2@kbusch-mbp.dhcp.thefacebook.com>
References: <20230530024120.17196-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530024120.17196-1-powen.kao@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_104555_673977_E087828A 
X-CRM114-Status: GOOD (  22.06  )
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

On Tue, May 30, 2023 at 10:41:19AM +0800, Po-Wen Kao wrote:
> ---
>  block/blk-mq.c           | 8 +++-----
>  drivers/nvme/host/nvme.h | 4 ++++
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1749f5890606..b60c78f5ad46 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1181,12 +1181,10 @@ bool blk_mq_complete_request_remote(struct request *rq)
>  	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>  
>  	/*
> -	 * For request which hctx has only one ctx mapping,
> -	 * or a polled request, always complete locally,
> -	 * it's pointless to redirect the completion.
> +	 * For a polled request, always complete locally, it's pointless
> +	 * to redirect the completion.
>  	 */
> -	if (rq->mq_hctx->nr_ctx == 1 ||
> -		rq->cmd_flags & REQ_POLLED)
> +	if (rq->cmd_flags & REQ_POLLED)
>  		return false;
>  
>  	if (blk_mq_complete_need_ipi(rq)) {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 7cf8e44d135e..acc9b1ce071d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -702,6 +702,10 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
>  	nvme_should_fail(req);
>  	if (unlikely(blk_should_fake_timeout(req->q)))
>  		return true;
> +	if (likely(req->mq_hctx->nr_ctx == 1)) {
> +		WRITE_ONCE(req->state, MQ_RQ_COMPLETE);
> +		return false;
> +	}

I don't think we want low level drivers directly messing with blk-mq
request state.

Is the early nr_ctx check optimisation really worth it? Would the
following work for your use case?

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2fa..a2d65bb127e29 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1176,7 +1176,8 @@ bool blk_mq_complete_request_remote(struct request *rq)
         * or a polled request, always complete locally,
         * it's pointless to redirect the completion.
         */
-       if (rq->mq_hctx->nr_ctx == 1 ||
+       if ((rq->mq_hctx->nr_ctx == 1 &&
+            rq->mq_ctx->cpu == raw_smp_processor_id()) ||
                rq->cmd_flags & REQ_POLLED)
                return false;
--

