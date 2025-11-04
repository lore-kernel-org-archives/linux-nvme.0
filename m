Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDDACCFA06
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 00:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M+VpMYNfwFrGzStsJ4Rm6cL8F3u2H6DwJGWFDVNUKxE=; b=aWXvIsHthCRO5TA3aajPddZI4S
	YypbkJAwWY59fHAG5waazURiftVkDsd3Db958QMd0LiEdJPWnhFrSEaa/YJXEpzY59wJTDckK2OPE
	Vf+4+bcCAeUS8momBN3rTsO00ZrcUQVN6JqDZYBtOyIdQB4WfjQg1XabYQTqhf/xUM6c7c2Kchdl+
	3ZOYf+hs3CaE1Dg5GEo2Ig8/0Lw9bEH3yyMZtZFREWO+7G3nU9M+rk8aFj5j9yBHf64C7YKuDAl4E
	JrmqkfG27ja3t1dETsDlFSGfyTMc9r4/8LxdVPmfyU6fsZwFOdO23J5ZyxaXy03X9PlDHsjVZRK4u
	sV3dMznw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG4hy-0000000Apa9-2U7r;
	Tue, 04 Nov 2025 00:15:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG4hw-0000000ApZw-3OVr
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 00:15:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DBEA601D7;
	Tue,  4 Nov 2025 00:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D53FC4CEFD;
	Tue,  4 Nov 2025 00:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215330;
	bh=q51FjAcV5ST/TNFAnYhXlTQwQa95eEqoUkjdhTLCezw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iCvxJbUp6IyviKFnxh4K07lx1ij/PwQCubwpGDa/AjJGi2K4oJ7bZcdvw8Klnl9lF
	 T2oDhBBvy/igyp9JfRzLTXW19/3HsOENGXGSDOQl025h4aByy20JpZTcMGHyX/CHWj
	 bvN3pJCFDOtcbzsqBS+daoZwJMZeY58rgoInPUsByGRqOhPj4dmp9IUrIOiSTAKi5+
	 OOoUNO/4JcRfZ8nuu37Pa1KdvtgCeOt9WMsoP4gibGoDhVvghyOGesMpHF3ACXukt1
	 me2eOvWaVKDC90CF/kfF5QtUjwtCqkwrpQPYva9aXotqnrR5bTj2ewj+6B19nTjd3M
	 hdDZNeslgVXog==
Message-ID: <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
Date: Tue, 4 Nov 2025 09:15:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, hch <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
 <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/4/25 00:17, Johannes Thumshirn wrote:
> On 11/3/25 2:38 PM, Damien Le Moal wrote:
>> Introduce the new BLKREPORTZONESV2 ioctl command to allow user
>> applications access to the fast zone report implemented by
>> blkdev_report_zones_cached(). This new ioctl is defined as number 142
>> and is documented in include/uapi/linux/fs.h.
>>
>> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
>> field of struct blk_zone_report also as an input. If the user sets the
>> BLK_ZONE_REP_CACHED flag as an input, then blkdev_report_zones_cached()
>> is used to generate the zone report using cached zone information. If
>> this flag is not set, then BLKREPORTZONESV2 behaves in the same manner
>> as BLKREPORTZONES and the zone report is generated by accessing the
>> zoned device.
> 
> 
> Is there a downside to always do the caching? A.k.a do we need the new 
> ioctl or can we keep using the old one and cache the report zones reply?

The old one is needed to allow getting the precise imp open, exp open, closed
conditions, if the user cares about these. E.g. Zonefs does because of the
(optional) explicit zone open done on file open.

And we cannot break existing user space anyway (e.g. sysutils blkzone), so we
must return the "legacy" report unless asked otherwise.


-- 
Damien Le Moal
Western Digital Research

