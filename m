Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7160CCFA00
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/OEKut8Bh5NEjnT73fa64w+0NdKfKaDZ37ZcX9yBBE=; b=0swqMhYiU+KOm5ckrhIcLZ/B7r
	SLvAAmDsuqDVXmfYDofTP3Zs7CxUaJz8Gam3xsnEh0aksx11WMfth2r6a9bV7RbjRHfPPGQQz/ecM
	g/5Zc7iihzWp4FSUd9covfNMfVmUizRGunagKeET4F7q9AKN+0XKwKZIiE2Kl0lkyuwy1YtwRUiUd
	AuoHvQmdaQGriDbYLx7/NSh/RqN3zaB3y1sPyRT4IfugoQWGBdH9iGRHy2cUTLUyJeKrSigf8MmcM
	CXc0a/j89+t2BMr/JHRJRLN4ehQFDv85/FjtlGAFfJRi9Nxk7HnNOnn02c+SYelNA8ZfBi+dSNSsl
	G5VzqOFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEsMc-00000006RGj-0gwX;
	Fri, 31 Oct 2025 16:52:34 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEsMZ-00000006RGI-0QEr
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 16:52:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cyn8V5C4lzm0pKc;
	Fri, 31 Oct 2025 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761929544; x=1764521545; bh=R/OEKut8Bh5NEjnT73fa64w+
	0NdKfKaDZ37ZcX9yBBE=; b=Qxm8g8rbfACqduG6mzsKiZcY5peLYhA5r68hfeuF
	npeC2F7MrPHfRCE2dgdI/VpN9Z6Hg0odL8mTXTU6q/aItJVUsc2yuLcoSKChIa3J
	CYZK7JejpVEKTgh6SS/QaCBg90QG8UIrv50QzRgeI+pEkrppligx7C1qjj2QKFH2
	9azdHnrqY2mKi3qwnrbyTRK8MiFp0837mT7ieCSNzn0Rb7Y4xkf0350AH8m56CC8
	mNCZM/Quc8W0QsSqNcGubULzysAB7Hpc5bSnTIbMmsQJ7auKE5fPqVUNu+QzToI4
	CCBV+h74m5k7iF9/sRnUJO02LHBBzHdocpCu7aVdgsG0Lw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Wp5YOSWbUGra; Fri, 31 Oct 2025 16:52:24 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cyn8F2n2rzm0pK1;
	Fri, 31 Oct 2025 16:52:11 +0000 (UTC)
Message-ID: <5ca96ffd-9e60-49d3-a136-c7a9eb7bce10@acm.org>
Date: Fri, 31 Oct 2025 09:52:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] block: introduce BLKREPORTZONESV2 ioctl
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-11-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-11-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_095231_232598_A426D2F7 
X-CRM114-Status: GOOD (  16.44  )
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

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
> field of struct blk_zone_report also as an inpiut. If as an input, the

inpiut -> input

>   /*
> - * BLKREPORTZONE ioctl processing.
> + * Mask of valid input flags for BLKREPORTZONEV2 ioctl.
> + */
> +#define BLK_ZONE_REPV2_INPUT_FLAGS	(BLK_ZONE_REP_CACHED)

Parentheses are not needed here - the definition of BLK_ZONE_REP_CACHED
should include parentheses if necessary.

> +	case BLKREPORTZONEV2:
> +		if (rep.flags & ~BLK_ZONE_REPV2_INPUT_FLAGS)
> +			return -EINVAL;

-EINVAL probably should be changed into something that indicates "not
supported" rather than "invalid argument"?

> index dab5d9700898..1441d79a6173 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -82,10 +82,20 @@ enum blk_zone_cond {
>   /**
>    * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
>    *
> - * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
> + * @BLK_ZONE_REP_CAPACITY: Output only. Indicates that zone descriptors in a
> + *			   zone report have a valid capacity field.
> + * @BLK_ZONE_REP_CACHED: Input only. Indicates that the zone report should be
> + *			 generated using cached zone information. In this case,
> + *			 the implicit open, explicit open and closed zone
> + *			 conditions are all reported with the
> + *			 BLK_ZONE_COND_ACTIVE condition.
>    */
>   enum blk_zone_report_flags {
> +	/* Output flags */
>   	BLK_ZONE_REP_CAPACITY	= (1 << 0),
> +
> +	/* Input flags */
> +	BLK_ZONE_REP_CACHED	= (1 << 31),
>   };

Why 1 << 31 instead of 1 << 1?

Otherwise this patch looks good to me.

Thanks,

Bart.

