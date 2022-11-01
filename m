Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146F9FA373D
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MOlQlfLOaC/hY2IVG67kvA9KM9HOfovDEW3eMXw7Ps=; b=VPixKnjWupJoRg4CH8KoDoK2fu
	NKLNdXEbkblbaPgUuEYTlIc9xBl05OvVp0nwN7m8QeWCV5fxKyNSZk/F8JP3GldqFxDfDyx81TGnz
	qqibyhWXRe/UFvEkcIkaXWIhTDjO/2fxYgT6/pnNV6kRH8ZpxHVefswO+z6tFiO7uVNyOFGxNWZW+
	ymmbSUfbyttOP9otR2bxZF68qqKIpojAfOBOZ0HY1CwAB9NgF6jf6uEaKFqZ5KpkFKC1B568wquPD
	jcRcIrnmDU2svlPTrzL/zo9UXt3s+GL9rWRL26MFEF2RW+o859Fp4OcMljA9rNS68Y3AMQvn3Io4y
	N3Q2pqpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opoIm-003zt7-Rg; Tue, 01 Nov 2022 10:15:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opoIe-003zp6-Ky
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 10:15:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B77FD68AA6; Tue,  1 Nov 2022 11:15:11 +0100 (CET)
Date: Tue, 1 Nov 2022 11:15:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, bvanassche@acm.org,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
	kbusch@kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 12/19] block,nvme,scsi,dm: Add blk_status to pr_ops
 callouts
Message-ID: <20221101101511.GA13304@lst.de>
References: <20221026231945.6609-1-michael.christie@oracle.com> <20221026231945.6609-13-michael.christie@oracle.com> <20221030082020.GC4774@lst.de> <a7e447b5-b26e-7aa0-ab6a-3463b8497d26@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7e447b5-b26e-7aa0-ab6a-3463b8497d26@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_031516_877586_626F56BC 
X-CRM114-Status: GOOD (  21.88  )
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

On Sun, Oct 30, 2022 at 06:05:35PM -0500, Mike Christie wrote:
> The problem I hit is that in the ioctl code I then have to do:
> 
> @@ -269,7 +270,14 @@ static int blkdev_pr_register(struct block_device *bdev,
>  
>  	if (reg.flags & ~PR_FL_IGNORE_KEY)
>  		return -EOPNOTSUPP;
> -	return ops->pr_register(bdev, reg.old_key, reg.new_key, reg.flags);
> +	ret = ops->pr_register(bdev, reg.old_key, reg.new_key, reg.flags);
> +	if (ret == -EBADE) {
> +		if (bdev_is_nvme(bdev))
> +			ret = NVME_SC_RESERVATION_CONFLICT;
> +		else if (bdev_is_scsi(bdev)
> +			ret = SAM_STAT_RESERVATION_CONFLICT;
> +	}
> +	return ret;

Eww.  We should have never leaked protocol specific values out to
userspace.  This is an original bug I introduceѕ, so all blame is on me.

I suspect the right way to fix is is to keep the numeric value of
SAM_STAT_RESERVATION_CONFLICT and give it a new constant exposed in
the uapi header, assuming that SCSI is the thing people actually
used the PR API for, and nvme was just an nice little add-on.

Now if an errno value or blk_status_t is returned from the method
should not matter for this fix, but in the long run I think the
blk_status_t would be cleaner than the int used for errno, and
that will also prevent us from returning accidental non-intended
values.

Btw, I also thing we should rename BLK_STS_NEXUS to
BLK_STS_RESERVATION_CONFLICT (assuming s390 is ok with that), as that
has much better documentary value.

> +	case BLK_STS_TRANSPORT:
> +		if (bdev_is_nvme(bdev))
> +			ret = NVME_SC_HOST_PATH_ERROR;
> +		else if (bdev_is_scsi(bdev)
> +			ret = DID_TRANSPORT_FAILFAST or DID_TRANSPORT_MARGINAL;
> +		break;

And we'll need an uapi value for this as well.

> +	case BLK_STS_NOTSUPP:

and maybe this unless we can just get away with the negative errno
value.

