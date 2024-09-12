Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF43EE57F8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5EXSZtRkQCw4Qi3kR+Uic0HAaSvYUloQ1763G4sdtoQ=; b=dzP0M4ib0QN6JyCRvn6lNegwNP
	edaTFX4jgaVqxkpmjlqbfyUlUT8n8/QTftDTAcB+Vvzf7tMLAmrSgtztmGWcGWfo9ITopcLe01iUV
	QBRZYsN3BjHsciadQiBe7SSDUDmtclllqZRw+uAji5Q7tElxwnDeUYiD9jo2bsUsxnc1ZyDaPWhHo
	lKbCJoIPq1XivUG+3Qq92MaoV13JV8UJfLFAGTHNlb4Y3mBCvIn2VIzccamc3KI3mPbgwFrreNBAW
	MiYAIXizMnpat+ehYmIxNyohj3wEzsUK5nZr1xtLLHqyulzVz9/8CKpGFudMneqP03pIANvelg0zO
	ZnfRoMnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojUI-0000000D8PV-43vh;
	Thu, 12 Sep 2024 13:03:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojT5-0000000D890-3WYv
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 13:03:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61F9A227AB7; Thu, 12 Sep 2024 15:02:36 +0200 (CEST)
Date: Thu, 12 Sep 2024 15:02:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240912130235.GB28535@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910150200.6589-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_060240_209947_709852D4 
X-CRM114-Status: GOOD (  17.59  )
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

On Tue, Sep 10, 2024 at 08:31:59PM +0530, Kanchan Joshi wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> The incoming hint value maybe either lifetime hint or placement hint.

.. may either be .. ?

> Make SCSI interpret only temperature-based write lifetime hints.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/scsi/sd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index dad3991397cf..82bd4b07314e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1191,8 +1191,8 @@ static u8 sd_group_number(struct scsi_cmnd *cmd)
>  	if (!sdkp->rscs)
>  		return 0;
>  
> -	return min3((u32)rq->write_hint, (u32)sdkp->permanent_stream_count,
> -		    0x3fu);
> +	return min3((u32)WRITE_LIFETIME_HINT(rq->write_hint),

No fan of the screaming WRITE_LIFETIME_HINT.    Or the fact that multiple
things are multiplexed into the single rq->write_hint field to
start with.

This code could also use a bit of documentation already in the existing
version, but even more so now.


