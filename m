Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2A7C35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 06:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iq3TjPEK9+kTXTm6+sYKWMmrXm/DiYcnQsGwm8FgIz0=; b=ZIVZuxr+btjx29E0lI6AurBbBB
	x5xasyl5c42+0lg7BDO2zhXltwI0HHdXyZW642T9nGW4FtXnPbWOhHcLPNgz1hSh4yjw49Bt/SrV5
	6UX/k/qHgd8wf7QTiPqNEXm8LDN3VrcczlD4GEjlUFL2MH3rqWh+KGWqby7QWP/u17hJ2r19A9eWn
	qurwsPxLrMUz5BVGifey1VVziyWPwOHwIvwYt/m+MKvM3cDSr07TzBk1UBsSoXn24lLh1BteSdKA4
	C+rIqVjYCbqSZpgS7Gb1f+O2YqFy6jOFLNXbkQC4/FUActBg4KIMuPnXrPHo5/e+l4X5MZ3bn2oZO
	ov4vpfNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVhG-0000000Dyac-1ZTh;
	Fri, 21 Mar 2025 06:17:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVhE-0000000DyaF-00yw
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 06:17:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3C6768AA6; Fri, 21 Mar 2025 07:17:28 +0100 (CET)
Date: Fri, 21 Mar 2025 07:17:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/18] nvmet-fc: take tgtport reference only once
Message-ID: <20250321061728.GF3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-14-05fec0fc02f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-14-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_231732_184339_C47A42BB 
X-CRM114-Status: GOOD (  23.56  )
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

On Tue, Mar 18, 2025 at 11:40:08AM +0100, Daniel Wagner wrote:
> The reference counting code can be simplified. Instead taking a tgtport
> refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
> if not a new hostport object is allocated, only take it when a new
> hostport object is allocated.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  drivers/nvme/target/fc.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 8b14947906948c8b4914932837b4ec90921b419d..b2f5934209f9952679dc1235fb7c927818930688 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1030,33 +1030,26 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>  	struct nvmet_fc_hostport *newhost, *match = NULL;
>  	unsigned long flags;
>  
> +	/*
> +	 * A ref on tgtport is being held while executing this function,
> +	 * thus there is no need to take first one and give it back on
> +	 * exit.
> +	 */

I'd move this above the function and shorten it to:

	/*
	 * Caller hpolds a reference on tgtport.
	 */

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

