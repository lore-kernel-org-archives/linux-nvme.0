Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4701EF433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 05:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TnA1Qja1GSe3tOufi2WYVFQ3GontqNdMtljCzbNqGa4=; b=3wfv1+wPfxPSr9Zm2DohCOsQTN
	TzpP41r4Sum1M0fiuBqcMce2nmWR0O9Fd7iKikjDnaZpk40Nlv9td6yPvGrCWGXWh8c6VGaXvw0jO
	tbiAZ7WSZctX+9thOKj+fg9q5cjar+CoWnA/GKdCJw5f0NjYO6Zy0cIAHEiWefhO0VZ7GECkNc80o
	+kth8k0iF7w34DpKyxQyJ5UrpIGyZqF+1QomVfryyc+6BWLUHq2NIhtPZAVLEZ++pitIACdGB6gXV
	av3QgDy1G5mpRS2sU72QK/89ElCqITwSmfpw+Bp8/Iv3siKSw2Ytzlyw00gOAJ8jakxQ3VmAMLodL
	GjwDinRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDFAD-00000001zRY-3jMD;
	Thu, 16 Apr 2026 05:21:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDFAB-00000001zRE-1QzM
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 05:21:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 916966732A; Thu, 16 Apr 2026 07:21:12 +0200 (CEST)
Date: Thu, 16 Apr 2026 07:21:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] bio-integrity-fs: pass data iter to
 bio_integrity_verify()
Message-ID: <20260416052111.GB14950@lst.de>
References: <20260416002214.2048150-1-csander@purestorage.com> <20260416002214.2048150-3-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416002214.2048150-3-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_222115_522309_36A31B32 
X-CRM114-Status: GOOD (  20.46  )
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

On Wed, Apr 15, 2026 at 06:22:10PM -0600, Caleb Sander Mateos wrote:
> bio_integrity_verify() expects the passed struct bvec_iter to be an
> iterator over bio data, not integrity. So construct a separate data
> bvec_iter without the bio_integrity_bytes() conversion and pass it to
> bio_integrity_verify() instead of bip_iter.
> 
> Fixes: 0bde8a12b554 ("block: add fs_bio_integrity helpers")
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity-fs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
> index acb1e5f270d2..389372803b38 100644
> --- a/block/bio-integrity-fs.c
> +++ b/block/bio-integrity-fs.c
> @@ -53,21 +53,22 @@ EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
>  
>  int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
> +	struct bvec_iter data_iter = {.bi_sector = sector, .bi_size = size};

Missing spaces and too condensed.  We normally use one line per field in
struct initializers:

	struct bvec_iter data_iter = {
		.bi_sector	= sector,
		.bi_size	= size,
	};

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

