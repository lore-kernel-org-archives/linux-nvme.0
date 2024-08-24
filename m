Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E058C52D6F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 08:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E0tPCKHRaggv445snVCGoNk6Bt7TCj8DAVILwh7mG7M=; b=XJyWGNNqMsRjRIC/I3cgcZ6ieM
	gPGCQ997dkjN3gWS7YhfOJ6L5Oq6zx42wThg+SsguoMLOpBzi0K1yHIFq2a6QChvhqBr0yuHeB4yn
	IC/UO1u7A8dyZPXJj9Sb/UsUOW7KzQzA8UVCx5JdkSA1GvwRiCma5KCKRp1il/ScMjB/0dc5OXqn/
	5gKJpAIe/qmf9qeyMk3PhdYv41py/Mf7BIJVRPoVDK1QlHF3396Z+C5cvUQkFpyYMkyYfargP7LhF
	OYbcWYtHp5ZP864NAhcZ5aDXmT1kA05VJLWdpm7vCu7aN+Ujg7ielfYCAWpj4/tuylaJ5dH461V53
	WX3iJoNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmVy-00000001tBR-2iGk;
	Sat, 24 Aug 2024 08:52:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmVv-00000001tAp-3GtW
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 08:52:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73C1D227A87; Sat, 24 Aug 2024 10:52:45 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:52:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 10/10] scsi: add support for user-meta interface
Message-ID: <20240824085245.GI8805@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104639epcas5p11dbab393122841419368a86b4bd5c04b@epcas5p1.samsung.com> <20240823103811.2421-12-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823103811.2421-12-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_015252_050426_B6A6AE88 
X-CRM114-Status: GOOD (  13.98  )
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

> Add support for sending user-meta buffer. Set tags to be checked
> using flags specified by user/block-layer user and underlying DIF/DIX
> configuration. Introduce BLK_INTEGRITY_APP_TAG to specify apptag.
> This provides a way for upper layers to specify apptag checking.

We'll also need that flag for nvme, don't we?  It should also be
added in a block layer patch and not as part of a driver patch.

> +/*
> + * Can't check reftag alone or apptag alone
> + */
> +static bool sd_prot_flags_valid(struct scsi_cmnd *scmd)
> +{
> +	struct request *rq = scsi_cmd_to_rq(scmd);
> +	struct bio *bio = rq->bio;
> +
> +	if (bio_integrity_flagged(bio, BIP_CHECK_REFTAG) &&
> +	    !bio_integrity_flagged(bio, BIP_CHECK_APPTAG))
> +		return false;
> +	if (!bio_integrity_flagged(bio, BIP_CHECK_REFTAG) &&
> +	    bio_integrity_flagged(bio, BIP_CHECK_APPTAG))
> +		return false;
> +	return true;
> +}

We'll need to advertise this limitations to the application or in-kernel
user somehow..

> +		if ((bio_integrity_flagged(bio, BIP_CTRL_NOCHECK) == false) &&
> +			(!dix || bio_integrity_flagged(bio, BIP_CHECK_REFTAG)))

Incorrect formatting.  This is better:

		if (!bio_integrity_flagged(bio, BIP_CTRL_NOCHECK) &&
		    (!dix || bio_integrity_flagged(bio, BIP_CHECK_REFTAG)))


