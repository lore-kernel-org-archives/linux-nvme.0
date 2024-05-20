Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6416C04FFE
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rkcYB2yDyCXZS4tMxgyOmp2EUputq8XIzcVKH3+3STQ=; b=XmIpG2cZeW4JQfwSyWvxRXXXT2
	H/o6cN9GNCjvC11EbCr1JmXZwZZmgwv7X4cQbrGxSVW6/MIWTenD1XpJUcaFgDVc4NMdEZ1k0/Thy
	tMC0z53qNHbpWewF5hO/O1Xg+pseSEdyYKis2xwLONmWg3OSV27YnMprvF1iCb3ZM55ssdy6Rz9cJ
	nG6UvvMkgK9HwM7DCE5zdMAm5QxV4aY+/pK8vsBDRyCbLYELW4m0Qlb/3jUmkfm1AjxCkhCtWc001
	v3muQwAKozGVuP+6GfqsM/l7pqKsl9rvzk5038OvIcME1QyPl+jv4l34khf4vcMg2sSiapLdqgsGk
	9P3e3Esg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s95Gp-0000000Eu46-0W1T;
	Mon, 20 May 2024 15:49:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s95Gl-0000000Eu39-3uI3
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 15:49:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96C5E68AFE; Mon, 20 May 2024 17:49:43 +0200 (CEST)
Date: Mon, 20 May 2024 17:49:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2] block: unmap and free user mapped integrity via
 submitter
Message-ID: <20240520154943.GA1327@lst.de>
References: <CGME20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19@epcas5p4.samsung.com> <20240513084222.8577-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513084222.8577-1-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_084948_133582_D18688B4 
X-CRM114-Status: GOOD (  14.94  )
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

> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 2e3e8e04961e..8b528e12136f 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -144,16 +144,38 @@ void bio_integrity_free(struct bio *bio)
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
>  	struct bio_set *bs = bio->bi_pool;
>  
> +	if (bip->bip_flags & BIP_INTEGRITY_USER)
> +		return;
>  	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
>  		kfree(bvec_virt(bip->bip_vec));
> -	else if (bip->bip_flags & BIP_INTEGRITY_USER)
> -		bio_integrity_unmap_user(bip);
>  
>  	__bio_integrity_free(bs, bip);
>  	bio->bi_integrity = NULL;
>  	bio->bi_opf &= ~REQ_INTEGRITY;

This looks correct.  I wish we could go one step further (maybe
in a separate patch/series) to also move freeing the bio integrity
data to the callers.  In fact I wonder if there is any point in
doing this early separate free vs just doing it as part of the
final bio put.  With that we could also entirely remove the
BIP_INTEGRITY_USER flag.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

