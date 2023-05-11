Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBACC7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 13:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7p6xqpdFYGvRMIKszU9SATHQgJM6cs1NZJ5evMX/cGI=; b=th5ntIiQ4kcnuos7GddWyTWd2v
	i1qlt9ess/1w1RJ9jg/FqZYknnCh0BROLSbAfGq0eiZ42cdWi1dd3j/hsGSAo3WHVWtqBlCfS1o4O
	VUDSgeF5B4FPrkb6Mw4nBmL0pzlb5UwvkK9ih44fq9+dUds/6Efc+lh7pKhVMAMvY8s9XJzwlGjK9
	iPb2NZdsquQk7RMOq2cQYfMHMeBkJ5CuDy6bHYE3Hxq7A2DxzMwNHQAX2AydUD5Ck9+AZTDGvQ9wW
	aR0T5GdrCOVQtZLLz2V4KqOJ29KTDgXNAgBWqUYljPIDxpwjXnu4ovdRR5IBgHWTSeq8qOKT1qHe+
	6F5uKAkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px673-008pZo-3A;
	Thu, 11 May 2023 13:13:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px671-008pZK-1k
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 13:13:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1454E68D08; Thu, 11 May 2023 15:13:36 +0200 (CEST)
Date: Thu, 11 May 2023 15:13:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, hare@suse.de, axboe@kernel.dk,
	oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 2/3] nvme-fabrics: check hostid using uuid_equal
Message-ID: <20230511131335.GB29790@lst.de>
References: <20230510180231.18865-1-mgurtovoy@nvidia.com> <20230510180231.18865-3-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510180231.18865-3-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_061339_722829_37C9A2D4 
X-CRM114-Status: GOOD (  11.77  )
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

On Wed, May 10, 2023 at 09:02:30PM +0300, Max Gurtovoy wrote:
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index dcac3df8a5f7..0f3763283222 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -181,8 +181,9 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
>  	    ctrl->state == NVME_CTRL_DEAD ||
>  	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
>  	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
> -	    memcmp(&opts->host->id, &ctrl->opts->host->id, sizeof(uuid_t)))
> +	    !uuid_equal(&opts->host->id, &ctrl->opts->host->id)) {
>  		return false;
> +	}

Please don't add the pointless braces.  The actual change looks fine to
me, though.

