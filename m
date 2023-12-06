Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96508C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M9/Oyle9CfbuXa6DFmnOWnRMbGsT+NSzmFrrsRTerok=; b=RopAEkAkmqQBh38CidMPMjFnR2
	nOXoN/6QEeCbUR21qt5h9xy6MBNG1i7iX1E5KT9ddcpnL0A/nLijKPzx+b+PBlqm+v9gSb+DFd4/h
	2El63kWSHpbQ6S/t8wdf9lip+xSsAT18f2TXjYwOS+EBUQYFmhKxamDzQLHX6ZNYpq3xOKQE9DFWZ
	wOij2BOwAO9uWQXx323fhlk9Z7xvos6dE78vvlojTiGym3+8Yn27vKKhMKfGgC5hVLV+2FiSanxZL
	YwVbn/fPnCkAuKWUI06Mt/Kep2TjLc5NY9grCanZajYE1mn7invVtij5vtObHFycCRQrlv5KSsA7P
	OwTvD77g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAncR-009TTf-0g;
	Wed, 06 Dec 2023 08:50:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAncO-009TRv-1J
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 08:50:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE058227A8E; Wed,  6 Dec 2023 09:50:44 +0100 (CET)
Date: Wed, 6 Dec 2023 09:50:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 2/4] nvme: initialize head before namespace
Message-ID: <20231206085044.GA24484@lst.de>
References: <20231206081244.32733-1-dwagner@suse.de> <20231206081244.32733-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_005056_588085_02DEB38B 
X-CRM114-Status: GOOD (  19.85  )
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

On Wed, Dec 06, 2023 at 09:12:42AM +0100, Daniel Wagner wrote:
> In preparation to use struct nvme_ns_head pointers instead of a struct
> nvme_ns pointers, initialize the head pointer before we create the disk.
> This allows us to attach the head as private data to the disk object.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/core.c | 46 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 900c045fcae0..1fabe1b81de0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3474,10 +3474,11 @@ static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
>  	return ret;
>  }
>  
> -static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
> +static int nvme_init_ns_head(struct nvme_ctrl *ctrl,
> +			     struct nvme_ns_info *info,
> +			     struct nvme_ns_head **head)

Can we just return the head or an ERR_PTR here instead of an additional 
argument?  That would also remove the need for the variable renaming
below.

I'd also rename the function to nvme_find_or_alloc_ns_head if you're at
it.

> +	mutex_lock(&ctrl->subsys->lock);
> +	list_add_tail_rcu(&ns->siblings, &ns->head->list);
> +	mutex_unlock(&ctrl->subsys->lock);

This can't race with someone else adding the ns as all scanning is
from the scan work item.  Maybe ad da comment on why this pattern is
safe?  Because I think it wasn't when the code was originally added..

Otherwise this looks good to me.

