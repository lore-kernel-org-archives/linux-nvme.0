Return-Path: <SRS0=0xMB=YH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425E8ECE587
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2019 15:33:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1118F20873
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2019 15:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aL04ub1L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihQfAaha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1118F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6O2zxjrC65+kF9mc2OVRglOCTC+l5KKeJ6fVrr3euX4=; b=aL04ub1LpIrS7E
	hrVNjWyEdaLn81fRyg2/TtmVtVNeThLfF1STXgk5dENbo++hiNmhZViUpzSVtfYvFrMXqMFfPwJ6m
	oeFZQyWFq8jRcLqjgz3QKPQl8aWwSvJgEcMLqeUVWXZ3JiVER663Dii7OZb++xL1zEYXEptVJL6IN
	NN1l07Ra3UeW/dUBWGK2n1nStGq8fDOXKJY5rgKApNdKPk4ZlgrTkOsvg7FpV6/noTxLLGBwClS8W
	jBmVkHW0rRZ2R0F2Ck7gCIj3nz2AwUwBHjteAUizvX1KSSGiqVlyvACSpqMPf7ZCstQE+rBYTkCCA
	MzBCCeqOy3gy8TMBPT/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iK2LH-0001xB-Ml; Mon, 14 Oct 2019 15:33:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iK2LA-0001qQ-NH
 for linux-nvme@lists.infradead.org; Mon, 14 Oct 2019 15:32:58 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3590F20873;
 Mon, 14 Oct 2019 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571067176;
 bh=ER27JrVVJoSFfPMLj9zlaq16kU1T7cePD8ACwQk37Ko=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ihQfAahaWTFzOe7A0CC5X5Y06N87TF/u8YW+n2jzqIf7EUTKytCdoEZVn2uIGAYyz
 wkpZX8g9jzT4G1BeaDfV25jeb0jtejJxSubXxbcSujkTsOCJahazWM21f1LUzAAgtu
 iZJNR9Htsm2MmycmSNjEKmh7u68EjIZShxxCZTVI=
Date: Tue, 15 Oct 2019 00:32:50 +0900
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 7/8] nvmet-loop: fix possible leakage during error flow
Message-ID: <20191014153250.GD6142@redsun51.ssa.fujisawa.hgst.com>
References: <1570985858-26805-1-git-send-email-maxg@mellanox.com>
 <1570985858-26805-8-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1570985858-26805-8-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191014_083256_791763_529C0889 
X-CRM114-Status: GOOD (  14.21  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, israelr@mellanox.com, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Oct 13, 2019 at 07:57:37PM +0300, Max Gurtovoy wrote:
> During nvme_loop_queue_rq error flow, one must call nvme_cleanup_cmd since
> it's symmetric to nvme_setup_cmd.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Actualy this and patch 8 look like they should go in nvme-5.4 rather
than wait for 5.5. I'll push tomorrow if no one objects.

> ---
>  drivers/nvme/target/loop.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 5b7b197..74a61262 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -156,8 +156,10 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		iod->sg_table.sgl = iod->first_sgl;
>  		if (sg_alloc_table_chained(&iod->sg_table,
>  				blk_rq_nr_phys_segments(req),
> -				iod->sg_table.sgl, SG_CHUNK_SIZE))
> +				iod->sg_table.sgl, SG_CHUNK_SIZE)) {
> +			nvme_cleanup_cmd(req);
>  			return BLK_STS_RESOURCE;
> +		}
>  
>  		iod->req.sg = iod->sg_table.sgl;
>  		iod->req.sg_cnt = blk_rq_map_sg(req->q, req, iod->sg_table.sgl);
> -- 
> 1.8.3.1
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
