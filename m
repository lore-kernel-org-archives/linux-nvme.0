Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B1CC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 05:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vfngxOT/xJplBWatfddMouP4HgjjMcGiyxJ06vB9gKs=; b=rNkEPWEXkGb5fqTczmitzRV1dx
	Tjas5itp+D2Pi69IwjxQ6u6rj5TzwWv6fdsi9V0UamjrIA1Bkie7ohueinIzmkKWVmFKGR8MX4Ib1
	/Gwpxez1qjZ0hjg9PaI9f14eSQcskuSn0WJCShK1+1Vweur+2cMFCDh0+4N1Iu89FfgUxkCYW908h
	jkJZH9shTgIi+OsrSgo75qaxB1EkrE7iNupM8LNDu61wSKgqjB4MeGedFly83WBpLze9o7+BA/Mmz
	IfXT1vm4sQy536/wEGJcpOmS7xxXMh4teB0wNyF9cPrm9qrNJZONj+MmgKetI3CfcraSswqXwBtGC
	yZnRdW/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtdh-0000000HM2n-1ROy;
	Thu, 08 May 2025 05:17:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtYj-0000000HLTy-40f9
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 05:12:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B679D68B05; Thu,  8 May 2025 07:12:33 +0200 (CEST)
Date: Thu, 8 May 2025 07:12:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always allocate integrity buffer
Message-ID: <20250508051233.GA27118@lst.de>
References: <20250507191424.2436350-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507191424.2436350-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_221238_134063_20FFE87D 
X-CRM114-Status: GOOD (  22.72  )
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

On Wed, May 07, 2025 at 12:14:24PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The integrity buffer, whether or not you want it generated or verified, is
> mandatory for nvme formats that have metadata. The block integrity attributes
> read_verify and write_generate had been stopping the metadata buffer from being

This commit log exceeds the 73 characters allocated to it, please reformat
it.

> allocated and attached to the bio entirely. We only want to suppress the
> protection checks on the device and host, but we still need the buffer.
> 
> Otherwise, reads and writes will just get IO errors and this nvme warning:

But to a point - the metadata buffer is only required for non-PI
metadata.  I think from looking at the code that is exactly what
this patch does, but the commit log sounds different.

Also this should probably have a fixes tag.

> -	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status && bi->csum_type) {
> +	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status &&
> +	    bip->bip_flags & BIP_CHECK_GUARD) {

While Martin correctly points out we currently always do both guard
and reftag checking, we really should check for either, especially as
some code below is written in a way to allow for formats that only
have one of them.

> +static inline void bio_set_bip_flags(struct blk_integrity *bi, u16 *bip_flags)
> +{
> +	if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
> +		*bip_flags |= BIP_IP_CHECKSUM;
> +	if (bi->csum_type)
> +		*bip_flags |= BIP_CHECK_GUARD;
> +	if (bi->flags & BLK_INTEGRITY_REF_TAG)
> +		*bip_flags |= BIP_CHECK_REFTAG;
> +

Just return the flags here instead of the somewhat odd output by
pointer return?

> +			break;
> +		bio_set_bip_flags(bi, &bip_flags);
>  		break;
>  	case REQ_OP_WRITE:

...

> +		bio_set_bip_flags(bi, &bip_flags);
>  		break;
>  	default:
>  		return true;
> @@ -134,22 +148,15 @@ bool bio_integrity_prep(struct bio *bio)

Just move this after the switch to have a single callsite.  And maybe
don't even bother with the helper then?


