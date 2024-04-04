Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50365CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDsKL1QiwoPnb3DPPSNAnwv8B0WMDvDvSC95Kd32o4U=; b=wafjILyPPysxug8i6RSReGzuJF
	AqNDVjJh4OMTJ9YRVIP+Q91NuBwUWDS0kLvEcbnA5vtzfkMcFvMA3MDCVGrdRKrIP0ooIJPUfTfZN
	CoX8BIBFHKvYpd2kiQX8Dp7SXHXhtDZBbUyzxTBunlXeYPnNrIS8PTVCNEJG71oUk8FVMNO1GYq8Y
	zFaGIIm3+s2cRpZmij16rS2ixvfugEdI+rKBxzyKVFWaqkG9TrbwkR2FpjlScEMTq0ZQai4G50VhY
	4e9BU/3AOepYGAyTZXEeGzOB758L7F1IksVQfMKYRBy4GP24KMnmoFJre54Uykj+JtsgiiHjsqo+D
	Lsb+JO0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsSd8-000000040uH-2cqP;
	Thu, 04 Apr 2024 19:20:10 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsScg-000000040bk-1B97
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 19:19:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V9Wdn6BKKzlgTGW;
	Thu,  4 Apr 2024 19:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712258379; x=1714850380; bh=uDsKL1QiwoPnb3DPPSNAnwv8
	B0WMDvDvSC95Kd32o4U=; b=jZzO5f1a9M+32mbS1Kc6amuQDPz0acn5nyNP0vm9
	F/9aEF2pN/RL/bnrWn2hjuoexlMoumRnYP8Rti6p7VfBs9ScfV2aq3jPSFIsWp3u
	KaXdpBHj52V/83hsRBdJ3uHEUAQKHqKsmsG4Ghq/kSttMQyVoi1Up2sDcM7bxVg9
	s+lJybNWmfl/pU9xuLqKuLw5N1iIHUslq1mNK56huwhyYawdnqoDOFNgUF+BkjgR
	kH2dqaz4AsPlE17LLCC6QiV7F7gT74AZ1xsCdt60vuOVExlJUYq5Y1m+Hai1xSUb
	Q8dyIO3Ya4/uZmJr8HNxKs4F9fGkhUiaX+N2UJwpInpRQw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 25_BboewrjHv; Thu,  4 Apr 2024 19:19:39 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V9Wdh65BVzlgTHp;
	Thu,  4 Apr 2024 19:19:36 +0000 (UTC)
Message-ID: <5c00c902-8ed7-430b-8be8-ca4d7e3730ac@acm.org>
Date: Thu, 4 Apr 2024 12:19:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/28] null_blk: Introduce zone_append_max_sectors
 attribute
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240403084247.856481-1-dlemoal@kernel.org>
 <20240403084247.856481-17-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240403084247.856481-17-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_121942_407645_E1D3768C 
X-CRM114-Status: UNSURE (   7.37  )
X-CRM114-Notice: Please train this message.
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

On 4/3/24 01:42, Damien Le Moal wrote:
> +	zone_append_max_bytes =
> +		ALIGN_DOWN(dev->zone_append_max_sectors << SECTOR_SHIFT,
> +			   dev->blocksize);
> +	dev->zone_append_max_sectors =
> +		min(zone_append_max_bytes >> SECTOR_SHIFT, zone_capacity_sects);

I think the above code can be simplified to the following:

dev->zone_append_max_sectors =
         min(ALIGN_DOWN(dev->zone_append_max_sectors,
                        dev->blocksize >> SECTOR_SHIFT),
             zone_capacity_sects);

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

