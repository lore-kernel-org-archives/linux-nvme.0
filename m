Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE41C3064D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 06:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7tZXFY05GCOT0iGm2ZB1vl7yQMTSknlRX/Zg2mKjRg8=; b=cNOQKvTY27PGsobg9cGh+8KoZ5
	x4vvLKk0WONKv1WrW+U0mXGy8wT0oL8Nx52XVOM5Dy+pgZJv4Y2l9qZJdZi7yG6XNIeEpp8tEPVrv
	9yxiXWul3WYLeWNITZOixal2Oo9tdxlkrXX8JIW8nGy1umgSLUJSDj5wMEraVdHuT11GG2cS6Nlg+
	MnyYHSUBgolVn+JYUafBTgIBEfVCxjeOn99Nje06WhuHju4YR9pWNE3Ff/Z0dJUR/riJoylbGKlB4
	J165O/4mbKjk2f2g+uC0uIQH7vilGdlWJ7yyJRqa8qWAiWTPmtD2nPJutIl051wBV3K6KG0GPViCR
	VlVnbsIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMidU-00000009ODZ-0nRI;
	Thu, 27 Jun 2024 06:29:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMidP-00000009OCX-1qNd
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 06:29:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC3A768AFE; Thu, 27 Jun 2024 08:29:27 +0200 (CEST)
Date: Thu, 27 Jun 2024 08:29:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 10/10] nvme: add handling for user integrity buffer
Message-ID: <20240627062927.GF16047@lst.de>
References: <20240626100700.3629-1-anuj20.g@samsung.com> <CGME20240626101529epcas5p49976c46701337830c400cefd8f074b40@epcas5p4.samsung.com> <20240626100700.3629-11-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626100700.3629-11-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_232932_527307_4329A355 
X-CRM114-Status: GOOD (  22.71  )
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

On Wed, Jun 26, 2024 at 03:37:00PM +0530, Anuj Gupta wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> Create a new helper that contains the handling for both kernel and user
> generated integrity buffer.
> For user provided integrity buffer, convert bip flags
> (guard/reftag/apptag checks) to protocol specific flags. Also pass
> apptag and reftag down.

The driver should not have to know about the source.

> +static void nvme_set_app_tag(struct nvme_command *cmnd, u16 apptag)
> +{
> +	cmnd->rw.apptag = cpu_to_le16(apptag);
> +	/* use 0xfff as mask so that apptag is used in entirety*/

missing space before the closing comment.   But I think this also make
sense as:

	/* use the entire application tag */

> +	if (!bip || !(bip->bip_flags & BIP_INTEGRITY_USER)) {
> +		/*
> +		 * If formated with metadata, the block layer always provides a
> +		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
> +		 * we enable the PRACT bit for protection information or set the
> +		 * namespace capacity to zero to prevent any I/O.
> +		 */
> +		if (!blk_integrity_rq(req)) {
> +			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
> +				return BLK_STS_NOTSUPP;
> +			*control |= NVME_RW_PRINFO_PRACT;
> +		}

This feels like the wrong level of conditionals.  !bip implies
!blk_integrity_rq(req) already.

> +	} else {
> +		unsigned short bip_flags = bip->bip_flags;
> +
> +		if (bip_flags & BIP_USER_CHK_GUARD)
> +			*control |= NVME_RW_PRINFO_PRCHK_GUARD;
> +		if (bip_flags & BIP_USER_CHK_REFTAG) {
> +			*control |= NVME_RW_PRINFO_PRCHK_REF;
> +			nvme_set_ref_tag(ns, cmnd, req);
> +		}
> +		if (bip_flags & BIP_USER_CHK_APPTAG) {
> +			*control |= NVME_RW_PRINFO_PRCHK_APP;
> +			nvme_set_app_tag(cmnd, bip->apptag);
> +		}

But excpept for that the driver should always rely on the actual
flags passed by the block layer instead of having to see if it
is user passthrough data.  Also it seems like this series fails
to update the SCSI code to account for these new flags.


