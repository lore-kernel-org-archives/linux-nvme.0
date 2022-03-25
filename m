Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71ECC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Mar 2022 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIHbiBPyCuGUIT0x+gbnTeJYnh90Jjb1WQ3sHw6her0=; b=RYf+96yk+r+ngzRaA2+nr97nkQ
	caKDLBkTvYC8KwNiVDhuMY5xJr3XCNT3nH7TDSA5jYxC+ZxzJr7bfH3ojT7ixiZ6/rQCzouGR7zgi
	PPMMAeayukP58MFMxbHx9dxD4m2VAYqbesnkf3Ls0CbrrGNPRyDcuP473F1C0Sk8pfzv+2o4OQeE3
	Is67Cw8/7ibKjB95XqpSE4rlpa52Myqf3LAEk0g46HWp58kdFRk7ySvCyr5HzGMav3lyi3AUhJWMm
	xo/C3OT0gGQI4FcGF4e3iuHrjEWlo1iKfc3EDGfl2u5kp82vOQwbGIwoDGOOzuAookYcL+H92vS6b
	XGwQqGHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXmga-002b2S-8C; Fri, 25 Mar 2022 16:21:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXmgS-002b1n-8n
 for linux-nvme@lists.infradead.org; Fri, 25 Mar 2022 16:21:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C71BE68B05; Fri, 25 Mar 2022 17:20:58 +0100 (CET)
Date: Fri, 25 Mar 2022 17:20:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org,
 k.jensen@samsung.com, javier@javigon.com, j.granados@samsung.com
Subject: Re: [PATCH] nvme: enable generic interface (/dev/ngX) for unknown
 command sets
Message-ID: <20220325162058.GA16275@lst.de>
References: <CGME20220325111952epcas5p4800055294fe473b923713d4b9c006026@epcas5p4.samsung.com>
 <20220325111444.5675-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325111444.5675-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220325_092104_479912_DDC7F607 
X-CRM114-Status: GOOD (  18.22  )
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

On Fri, Mar 25, 2022 at 04:44:44PM +0530, Kanchan Joshi wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 677fa4bf76d3..3e5d9a3f4167 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1875,7 +1875,7 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
>  static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
>  	unsigned lbaf = nvme_lbaf_index(id->flbas);
> -	int ret;
> +	int ret = 0;
>  
>  	blk_mq_freeze_queue(ns->disk->queue);
>  	ns->lba_shift = id->lbaf[lbaf].ds;

nvme_update_ns_info can't really work for arbitrary command sets as
the concept of LBA sizes and format doesn't apply there.  So we'll
need a different stubbed out version that doesn't deal with the
block interface at all.

> @@ -4098,6 +4100,14 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	default:
>  		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
>  			ids.csi, nsid);
> +		if (!nvme_multi_css(ctrl)) {
> +			dev_warn(ctrl->device,
> +				"command set not reported for nsid: %d\n",
> +				nsid);
> +			break;
> +		}

Given that the NVM command set has a CSI of 0 getting random garbage
here sounds unlikely.  That being said if we want to support passthrough
for unknown command sets the warning above should probably go
away above as well.

> +		/* required to enable char-interface for unknown command sets*/
> +		nvme_alloc_ns(ctrl, nsid, &ids);

And this can't really work as nvme_alloc_ns looks at the Identify
Namespace structure for the NVM command set which can't really
work for arbitrary command sets.  We'll need a nvme_alloc_ns_generic
instead that looks at the Command Set Independent Identify Namespace
structure for a few things like namespace sharing capability and
does just the basic work to get the passthrough interface up.


