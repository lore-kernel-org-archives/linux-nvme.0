Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7B2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jan 2022 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GEgHs9/XshsmCw6ypDFwhGu5V1z7c2kPPrleEC+clkQ=; b=OR7vyENvM5tZStUbXkSvWTG2I1
	lLFh2Mk3MRf/qWF3frBayhINKNeMvz9ljhLKUkIISkBrgUkgqVH42x83YwB7bcrzjI6VcXoy+J8rL
	x/racA4DwEiA0NdSioXmBGkncBv7BVvrVufnaeT/ODmVbuTbirvkXsz+yCPw1JiMAhGtCzccZTzc/
	tolEnLPGrMOkdiSFq9bua7j2p5dkKXy/zk4y3xuIbDxB4vZVIOux6kbPbfiaI06dZ5OQRbrWM0RkI
	xIKd6I/Joci4tRvhmXYvBTedgglx4BByKEh4C4o7nb7rUSCAuXsXSvbccEukYZGBMZ6G+/zVoBZtf
	RPEhqdIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n4pdO-00CcmC-K6; Tue, 04 Jan 2022 19:38:14 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4pdM-00CclX-3Y
 for linux-nvme@lists.infradead.org; Tue, 04 Jan 2022 19:38:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C54CBB817DB;
 Tue,  4 Jan 2022 19:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39842C36AEB;
 Tue,  4 Jan 2022 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641325089;
 bh=GNO4q4NOMMXmg1I/+DnzUx7VR3DII6+mf0X90mMaZLg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cNADZbtAFEPXQ6kzRzbu3/fEV0tuIO43S86Brcpgt3AZTSeyeiS4wekBH//eIyFQr
 65w1V//5Aw8mqlvh2M3OzdWf4MmjXfLDEfCgidPvVQMPs+45l0cSjd5IkmtAFnBlwh
 tbKVvX62b3ihJ6/LyXrjoD+DK1O/GnOts38EQ++JO4//3cjK6SPWEsKU0/RwVZmuuk
 MTMXPX5YbRrHOqX6w3H3NtRi/BSEy+Ju5DCKTsw8WOuJEVexNK3A02dm3Sq1pkM1eK
 i5dBmfjH5FT+vAjqqETRF5OALz0SE7rzUk7R74744B3XL1k1WSr923fj+lV4yuzjku
 I8g5o4G5S0qqw==
Date: Tue, 4 Jan 2022 11:38:07 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Message-ID: <20220104193807.GB2666557@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211227164138.2488066-3-kbusch@kernel.org>
 <20211229174602.GC28058@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229174602.GC28058@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220104_113812_314851_A526C0E5 
X-CRM114-Status: GOOD (  18.89  )
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

On Wed, Dec 29, 2021 at 06:46:02PM +0100, Christoph Hellwig wrote:
> I wonder if a restart label here would be a little cleaner, something
> like:

On second thought, this requires another check that the *rqlist is not
NULL before 'goto restart' since the safe iterator dereferences it. I'm
not sure this is cleaner than the original anymore.
 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 992ee314e91ba..29b433fd12bdd 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -999,9 +999,11 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
>  
>  static void nvme_queue_rqs(struct request **rqlist)
>  {
> -	struct request *req, *next, *prev = NULL;
> +	struct request *req, *next, *prev;
>  	struct request *requeue_list = NULL;
>  
> +restart:
> +	prev = NULL;
>  	rq_list_for_each_safe(rqlist, req, next) {
>  		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>  
> @@ -1009,9 +1011,9 @@ static void nvme_queue_rqs(struct request **rqlist)
>  			/* detach 'req' and add to remainder list */
>  			rq_list_move(rqlist, &requeue_list, req, prev, next);
>  
> +			if (!prev)
> +				break;
>  			req = prev;
> -			if (!req)
> -				continue;
>  		}
>  
>  		if (!next || req->mq_hctx != next->mq_hctx) {
> @@ -1019,9 +1021,9 @@ static void nvme_queue_rqs(struct request **rqlist)
>  			req->rq_next = NULL;
>  			nvme_submit_cmds(nvmeq, rqlist);
>  			*rqlist = next;
> -			prev = NULL;
> -		} else
> -			prev = req;
> +			goto restart;
> +		}
> +		prev = req;
>  	}
>  
>  	*rqlist = requeue_list;

