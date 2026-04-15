Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60057F43821
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CMo+2H+6wDYEzrTJ7iItTKzAgY4rV9tVLhYt8KqXjo=; b=LEqMzXU45dOLykddnGwjSlekwX
	zvofkRGRievONW1UY8BL3rA6dvDjwQ75Sq1Ub/FY0ZCD6M1MgyWGYZN5egN+ZrIf2ypk59sfKYI2p
	Du3m7U0UpluTICz1konEBwVdS86jqfVD+P/sal4xtMEjpsSJdYYfeemV6lq569YClaYUNlG77+Co4
	gImNg3GaXEXKxjI8erHSxFQA5jMceOSwdK9xK+IRtsp08+aDvQFW+1HUxUipEAcLQwFYLJxO2Ofyv
	z3mYAQe27ZCrLssmVzmiLcolKNPbNpzmobbft/iu2I7O2Z0HFssRcxUStCB0aFtE8KOMNerjgQu5F
	YtTiDD5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD19Z-00000001ENV-3VWE;
	Wed, 15 Apr 2026 14:23:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD19X-00000001ENO-3ww3
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 14:23:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AAC9B600AD;
	Wed, 15 Apr 2026 14:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7E2C2BCB3;
	Wed, 15 Apr 2026 14:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776263018;
	bh=h1/XLPuNgsbgT/fA5dXF1oCGMz2gBmrDQW5ccIxFRio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHEAUMCgsfCi87a4Q/1LCHZNgVv5jwoeqUSJ4A0t2HG7KJseaxwHl5gnZRQk/zIDM
	 9x7oswoqk7awbvXf2i9RABTB84auoOGv4/VuYJ21Pq7Lx6BoijsNVsfHweHZuWuxvQ
	 pPeeA0nyk4R8ZkdH15FEh81e//OsroWfvUfgG8b9oBvkKeyf57FKsHEGRsKi/XoigN
	 VXtVlWY6Aq1KpWw/5sf5FobLZVZDs4fBR7XaupEcY9Ge8dAiKQRhdj3ZChE+Q9rQFH
	 OwNoT8ELoAIxY3gtWAivVlo4Q2XtYqW8Q3RnKf7W90PXVDeovcrZG4kGp5h41M1UZw
	 HJyi36CzzR62g==
Date: Wed, 15 Apr 2026 08:23:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, nilay@linux.ibm.com
Subject: Re: [PATCH 1/2] nvme-multipath: fix leak on try_module_get failure
Message-ID: <ad-faFB43WBycLSk@kbusch-mbp>
References: <20260225202109.447144-1-kbusch@meta.com>
 <8c068126-0b30-4d46-a07c-a4f975b7fa53@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c068126-0b30-4d46-a07c-a4f975b7fa53@oracle.com>
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

On Wed, Apr 15, 2026 at 10:26:00AM +0100, John Garry wrote:
> Are we also missing the module_put() for when we cancel the timer? AFAICS,
> we only put the module for after the disk is removed.

Yes, I believe you are correct.
 
> Maybe we need something like this:
> 
> Subject: [PATCH] nvme-multipath: put module reference when delayed removal
> timer is canceled
> 
> The delayed removal timer is canceled when a NS appears. However, we do not
> put the module reference grabbed in nvme_mpath_remove_disk(), so fix that.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1e33af94c24b..1b445830358e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4083,7 +4083,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns,
> struct nvme_ns_info *info)
>  	mutex_unlock(&ctrl->subsys->lock);
> 
>  #ifdef CONFIG_NVME_MULTIPATH
> -	cancel_delayed_work(&head->remove_work);
> +	if (cancel_delayed_work_sync(&head->remove_work))
> +		module_put(THIS_MODULE);
>  #endif

I don't think we need the _sync() variant here, but the check and
module_put() look good.

