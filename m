Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC72C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pj/dmHcbNdOaQjFiAiGSGRFiwjgMUbBiXiRXVRIe0p0=; b=plbnir5MKBCItKUBd25nnW4NOh
	rLxF8SKFxdfTylx3dM92GHnJuEkECJ6FrKVa4RG/fCrwHIpFWLQW89q5WuyhZSCHGAUqpzAmpX8G5
	RjN+CQP1W1Ept7G5SWvn/sjCsgW7ZA3hPsL6IlPtrt++aY5Pz1/7rHnCGpMVvB7V+8unWbioxDZxG
	nhO+69cxfesKQzDwOIOqUh6tqvK0enP5ZITgK4N4AbIarcgztUGYI0LK2R6f2Fj1Nv62sVeuOgjla
	5G5GiXnPxb7ZQktJioIqzvdBzZQVxSMmkqVxWPFvcTd/L6oF4nIXy0VyllNnnaK537t8bTmO5G3Ly
	6PetxFfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHPvj-0056ys-U5; Fri, 29 Jul 2022 13:21:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHPvh-0056wl-3f
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 13:21:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A96868AA6; Fri, 29 Jul 2022 15:21:21 +0200 (CEST)
Date: Fri, 29 Jul 2022 15:21:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/5] nvme-pci: iod nents fits in s8
Message-ID: <20220729132121.GB28052@lst.de>
References: <20220728221152.538648-1-kbusch@fb.com> <20220728221152.538648-5-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728221152.538648-5-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_062125_317088_88DE0276 
X-CRM114-Status: GOOD (  19.82  )
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

On Thu, Jul 28, 2022 at 03:11:50PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The maximum number of 'nents' allowed by the queue limit is 127, which
> fits in an 's8'.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9e5bbf4e3e07..546de3c2000b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -229,7 +229,7 @@ struct nvme_iod {
>  	bool use_sgl;
>  	bool aborted;
>  	s8 npages;		/* In the PRP list. 0 means small pool in use */
> -	int nents;		/* Used in scatterlist */
> +	s8 nents;		/* Used in scatterlist */

Can we please have a BUILD_BUG_ON to protect us from an increased
max_segments?  As I can totally see us incrementing that at some point,
and the limit is somewhat close.

