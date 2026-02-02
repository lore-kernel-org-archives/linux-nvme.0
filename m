Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DB1D73E86
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qX/qjuTyhjmqNh3J89hPMD49PtKKwYwAz+Wl5iCuu5U=; b=a8wXJHUHHHP5GeQBdZj9XloxKy
	55sch7lPCXhgadNE5vh2ndEzvzGRcuPbLB4ia/VJbJgu/JQpiooC5Jo4GDON+DQWsI8bttoieZgzg
	7s8t4G8IZkl9ue+ij8EglcwmPtwuuN1zO84WiTy6TelaqfK2+lrCHhsA6WCJK7R24qsAVSiW5B+7Z
	fvvxhS6H26RhC6Emx0WFQ8zEivF7DRDmIuxPwSsZ/L8xpCGO8hfR5mk6foG2C+bVUFhLovk57ZrHD
	CHEK1uXddNDsMugsrdajNhJgur3biInyOeJXwXRntgdAf73vBFGr7OKQ+eM5CshMo7+8xf/SNRf3F
	2K+iZusA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmnt4-00000004ZFj-1K0o;
	Mon, 02 Feb 2026 06:58:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmnsw-00000004ZFL-2ge6
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 06:58:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1DB568B05; Mon,  2 Feb 2026 07:58:02 +0100 (CET)
Date: Mon, 2 Feb 2026 07:58:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme: fix admin queue leak on controller reset
Message-ID: <20260202065802.GA930@lst.de>
References: <20260131144808.4173338-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131144808.4173338-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260201_225810_823245_6259BCD0 
X-CRM114-Status: GOOD (  23.24  )
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

On Sat, Jan 31, 2026 at 10:48:08PM +0800, Ming Lei wrote:
> When nvme_alloc_admin_tag_set() is called during a controller reset,
> a previous admin queue may still exist. Release it properly before
> allocating a new one to avoid orphaning the old queue.
> 
> This fixes a regression introduced by commit 03b3bcd319b3 ("nvme: fix
> admin request_queue lifetime").
> 
> Cc: Keith Busch <kbusch@kernel.org>
> Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime").
> Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-block/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 19b67cf5d550..4f1f460a6c11 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4865,6 +4865,15 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * If a previous admin queue exists (e.g., from before a reset),
> +	 * put it now before allocating a new one to avoid orphaning it.
> +	 */
> +	if (ctrl->admin_q) {
> +		blk_put_queue(ctrl->admin_q);
> +		ctrl->admin_q = NULL;
> +	}
> +
>  	ctrl->admin_q = blk_mq_alloc_queue(set, &lim, NULL);

Clearing the admin_q to zero above is pointless given that it instantly
gets overriden here.  Otherwise this looks good.


