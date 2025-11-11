Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31511CCFA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4i9gAbKSz3SyIVo03JvQ7d9thevi3d3A6g2Fu/hKrNA=; b=OKONkloPU7S9oBO+fbjr4MOezh
	1VwKTiN1KFkVl1y+JwLcfmo64niX1WhDGLjNYDc5X5nqvmBdWwJIRKCVtCDZ6TcrmsCuuNfqSQuEj
	cdXIvnrAtG3+DTxX+BXXKBuTTVAvItHWArGouzoyN/AUtPgsQdFqPdUMfd12RfDn7X+xEDxrD4I3j
	K8TNlIuACEouJbjpNF/hFE2KZkWvIdUziOlVhh+rpdAR8lVR/GRoD8oqgNbx0ztAiN2nQFg49DlqK
	HBtjx+FvsqTiP4s/kw8gZBt5GB6zVkoftVMjtCHXmNX+nzPG5KZP2YqGszwxNJpH9XSHCodAjtY44
	mZR3cYwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoNV-00000007Eu4-0yl8;
	Tue, 11 Nov 2025 13:25:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoNT-00000007Etd-3B1X
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 13:25:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 85A5443C3E;
	Tue, 11 Nov 2025 13:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932E9C19421;
	Tue, 11 Nov 2025 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762867541;
	bh=pCCfLAd+jgtFe99TpuN79KMHvJQ3KhJwNnbu3i0DEQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XStIr7KEPP6lsJ/X20MeRdxMRZBEFVNwaZARKWvlQtCOPoPRKLcHrH6NLQAV2v07/
	 4fIfceZuxnn9B2sL5dPnf9GWrmoIbf9rjVTjd+F3AVK0FQYrNDTx2ugHx8JHTSiY3+
	 fsBywk1tIHHffVtoK/ex4cnbbmPCIhBj9t4tMfbX/63moCK0nWyXRjFcf+yqJOLxXJ
	 DGVcSrDdb0JR2GbynBsTPDpI6Ft9Hx7wl9njOZdkAj23oa3gmr6t+Y9+JS/kpjmz8w
	 hyqygSpSxf0etucQWAouS/+hu7YqPAEj1unljxkuWEOGDf49pWiVUbGXQgyhMNLaPo
	 1z/ntfJjdDPeQ==
Date: Tue, 11 Nov 2025 08:25:38 -0500
From: Keith Busch <kbusch@kernel.org>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aRM5UoApKZ9_V7PV@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <aRK67ahJn15u5OGC@casper.infradead.org>
 <aRLAqyRBY6k4pT2M@kbusch-mbp>
 <20251111071439.GA4240@lst.de>
 <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com>
 <20251111093903.GB14438@lst.de>
 <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_052543_817079_C0FAC92C 
X-CRM114-Status: GOOD (  14.79  )
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

On Tue, Nov 11, 2025 at 06:14:24PM +0800, Yu Kuai wrote:
> >
> At least from blk_try_merge(), blk_discard_mergable() do return false,
> however, following checking passed and we end up to the back merge patch.
> 
> blk_try_merge
>   if (blk_discard_mergable())
>     // false due to max_discard_segments is 1
>   else if (...)
>    return ELEVATOR_BACK_MERGE
> 
> Perhaps are you suggesting to change this to:
> 
>   enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
>   {
> -       if (blk_discard_mergable(rq))
> -               return ELEVATOR_DISCARD_MERGE;
> -       else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
> +       if (req_op(rq) == REQ_OP_DISCARD) {
> +               if (blk_discard_mergable((rq)))
> +                       return ELEVATOR_DISCARD_MERGE;
> +               return ELEVATOR_NO_MERGE;
> +       }
> +
> +       if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
>                  return ELEVATOR_BACK_MERGE;
> -       else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
> +       if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
>                  return ELEVATOR_FRONT_MERGE;
>          return ELEVATOR_NO_MERGE;
>   }
> 
> And the same for other callers for blk_discard_mergable().

Ah, so we're merging a discard for a device that doesn't support
vectored discard. I think we still want to be able to front/back merge
such requests, though.

