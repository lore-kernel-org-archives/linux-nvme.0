Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D37FCAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 10:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aexeb5sRM1cvvxNR0xvqhG1GWWBe17JmED9KvSqtRuQ=; b=YqtoudYDA5lSaPo4FHv8F4HQ8i
	LLA68QBvqHC7XZ9i1XdO3K17xhQWvjdXBtyRgu/aEB49HXqmz5URhlIWdFQwpM5FWxazdeRGb4baw
	/wbSEByPu/waIKc8Ysh/1SjhbV9dpWDlvyAZbkDw+nzbfMELJNWwIlYpyC7m9EUr1k5dSglC9YoVs
	lJNTdoXG33QsYgvy0c7J7VcblCTP/hft1lZ8TJZBCixFR+s/nTzdAiRAlOZXXx531H6DZlhybDEVT
	Pwd+ZB4EgRGHmuWAZnvuZCcNbALJAO/Z2ZrcuHdz9OnZlJJ9lxAmUD6OLiSjLi3iAKrMe7VZK9Wzu
	VtnP7lpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cna-0000000C1DI-0GGh;
	Fri, 03 Oct 2025 10:14:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cnX-0000000C1Cw-1IVi
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 10:14:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E6FF227AAC; Fri,  3 Oct 2025 12:13:54 +0200 (CEST)
Date: Fri, 3 Oct 2025 12:13:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexandr Sapozhnkiov <alsp705@gmail.com>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH] nvme: target: fix error checking in
 nvmet_fc_schedule_delete_assoc()
Message-ID: <20251003101354.GA15826@lst.de>
References: <20251002092202.11-1-alsp705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002092202.11-1-alsp705@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_031359_494622_B4041EEC 
X-CRM114-Status: GOOD (  19.75  )
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

Adding Daniel who has been touching this area recently.

On Thu, Oct 02, 2025 at 12:22:01PM +0300, Alexandr Sapozhnkiov wrote:
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
> 
> The nvmet_fc_tgtport_get() function may return an error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> ---
>  drivers/nvme/target/fc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 337ee1cb09ae..68a416a92bfc 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1110,8 +1110,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
>  static void
>  nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
>  {
> -	nvmet_fc_tgtport_get(assoc->tgtport);
> -	queue_work(nvmet_wq, &assoc->del_work);
> +	if (nvmet_fc_tgtport_get(assoc->tgtport))
> +		queue_work(nvmet_wq, &assoc->del_work);
>  }
>  
>  static bool
> -- 
> 2.43.0
---end quoted text---

