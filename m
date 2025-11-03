Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0F8CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HnnZgAPAgJrK4pb5dGDR1MuEmQZFMeB1v9SVf6KhEpY=; b=XgkpR965oq+2JUQwc/XepclDBb
	nHuKXOwHPGiJ3ul69kjcYAANKZPKErgU4n9flhpGb2R8+BUr+RkKdpNEzBbjC8IQv3ZmjMVu0sGqx
	fJyJJg7HTcZvUu/sC2ArEJnQkraTyR/RSWxwmfdSOedPIE3eLEwRoDYueebwjS59Irdws9bickwX7
	bYAGBDx4KbVFME9UYTEupxYrWepfu13qZLF6OFItySuH0u+GNZIed+rjJeDNvzMXL0KhwHJZcU604
	7NvWh14WSYy2Bs1jafUqOncCAqdl3bsUFP1oCzlIi+G+6ZdYlf1XRfPRWuZqiN1obENXF6Ix85nWJ
	DcmIooOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG2n5-0000000AhG5-3yOY;
	Mon, 03 Nov 2025 22:12:43 +0000
Received: from 003.mia.mailroute.net ([199.89.3.6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG2n3-0000000AhFd-0XKN
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 22:12:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d0m6b1dVxzlvX7g;
	Mon,  3 Nov 2025 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762207956; x=1764799957; bh=HnnZgAPAgJrK4pb5dGDR1MuE
	mQZFMeB1v9SVf6KhEpY=; b=yAjIwPpj9bZJsEd6nCLsn1vFmOuUd8C6N1+X0HuR
	SVOl+Ku+ZGox/IsWKujTc9h5km3d3m9xM1E91QdHuC12HOyAaZerg9NMH3/lTUGJ
	MzY0AaV8C/BCYSVIKe6bWe/tSejrXxFaVi3iicynvKOglHP1sCOodEAgL/XiwJr0
	f4AGqOaEZni7XcL6O3kkJfVQHxd2zRnsADzluIKmDeXE11zHq4BWtc2vjzBOzxKj
	otqETyxe0ET5Z1j5pFXMMrhzC7cjut8xzfojZgRudNFu3tloBLQ5FcHPKeT+zmfp
	QFu2yABRl4/r1PVMawmPdrqmEXmW5dlZapd17eZHkLpVog==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4bFOvLTEpaKB; Mon,  3 Nov 2025 22:12:36 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d0m676MgFzlvPx7;
	Mon,  3 Nov 2025 22:12:13 +0000 (UTC)
Message-ID: <3c634060-494b-4319-8298-caa940e92f48@acm.org>
Date: Mon, 3 Nov 2025 14:12:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_141241_296204_A2A6FDA5 
X-CRM114-Status: GOOD (  16.46  )
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

On 11/3/25 7:17 AM, Johannes Thumshirn wrote:
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
> Is there a downside to always do the caching? A.k.a do we need the new
> ioctl or can we keep using the old one and cache the report zones reply?

Hi Damien and Johannes,

I have a different proposal, namely not to introduce BLKREPORTZONEV2 at
all. If we keep the BLKREPORTZONE ioctl and do not introduce the
BLKREPORTZONEV2 ioctl then in the kernel we only have to cache zone
information that will be used by filesystems. Information that won't be
used by filesystems doesn't have to be cached. With this approach the
existing data structures are sufficient (struct blk_zone_wplug and
conv_zones_bitmap) and we don't need to introduce new data structures
for tracking zone information.

Thanks,

Bart.

