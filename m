Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9CBCCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 23:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xR/X+fGTjuxHLK6ZDR63x3nFeG/cT8mOti9LvJ19Gys=; b=r/gG0x+8kDz/eKuuKnu3proFf4
	CaegjGBYxu4feinkVMy735e+SClN1KCOYYrf4Fm6LCpQb0lFNcZsdjPiRv2c2Iu6Ho+7UaCPXgS9Z
	YFKyAwtp3FdakOC3Tv7v0/k+oTN/6hOcti1lYWiTczkl4CSZt3JmemhOajaMpH34oNsGwFCoKHQyq
	NNghglg1NI1g97k/iEBIDcPY4qkM5pmPK52w5i5hq5rjVzMfQGJLDPFeYD2z2w6AEq+IP5horL9Zq
	TZX32qna/CTiI0RWGnC1PSEj2kgk6r/MvA0iXFvQm/dFpKcirJItFHW8tGZWrxsRvl7ugdNAwDxft
	owCspn7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG3YO-0000000Al2L-1wIs;
	Mon, 03 Nov 2025 23:01:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG3YL-0000000Al1h-1SqN
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 23:01:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AD2E7406BA;
	Mon,  3 Nov 2025 23:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A414C116C6;
	Mon,  3 Nov 2025 23:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762210892;
	bh=6O2ngqEIH1rvuzv3mpBrfCb9R60Mx/pJq5EQc4OPBnA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qIT/BTp1oRYAPPF8exJTOJqgAd4ZMryvWOoPil83FhJrymfnAELwHJZf8Ufo5m0o5
	 avOn3dacEd+8E3yBoYUc8sqiAdR3hFLd2Imd0NztctI9RV/1ZWL12m7yiYGPOiVHzY
	 RrBV8yMLiJgrSqtFWt5ALlYLYo26CUN1hus6WeyLQJoJ+jDOkJgy1pLmGquRcdbMuJ
	 V//DXYi9T3AJK1dBXWnPKr5JfCL9Qy9Ome6iS/IOrioWC8Gh218+OOncy+cS1/NfIJ
	 X5rrCRnBMOCfk82xTmFbkJ8uCsU9b8P3oCLLVP2OsGW+NtWgI3gx0wBn1D2zqvaqHy
	 bkt4TcrfSSCoA==
Message-ID: <35effd01-0158-4381-9803-d71b79ca775f@kernel.org>
Date: Tue, 4 Nov 2025 08:01:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Jens Axboe
 <axboe@kernel.dk>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
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
 <3c634060-494b-4319-8298-caa940e92f48@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3c634060-494b-4319-8298-caa940e92f48@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_150133_456234_8B996BAB 
X-CRM114-Status: GOOD (  19.81  )
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

On 11/4/25 07:12, Bart Van Assche wrote:
> On 11/3/25 7:17 AM, Johannes Thumshirn wrote:
>> On 11/3/25 2:38 PM, Damien Le Moal wrote:
>>> Introduce the new BLKREPORTZONESV2 ioctl command to allow user
>>> applications access to the fast zone report implemented by
>>> blkdev_report_zones_cached(). This new ioctl is defined as number 142
>>> and is documented in include/uapi/linux/fs.h.
>>>
>>> Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
>>> field of struct blk_zone_report also as an input. If the user sets the
>>> BLK_ZONE_REP_CACHED flag as an input, then blkdev_report_zones_cached()
>>> is used to generate the zone report using cached zone information. If
>>> this flag is not set, then BLKREPORTZONESV2 behaves in the same manner
>>> as BLKREPORTZONES and the zone report is generated by accessing the
>>> zoned device. 
>>
>> Is there a downside to always do the caching? A.k.a do we need the new
>> ioctl or can we keep using the old one and cache the report zones reply?
> 
> Hi Damien and Johannes,
> 
> I have a different proposal, namely not to introduce BLKREPORTZONEV2 at
> all. If we keep the BLKREPORTZONE ioctl and do not introduce the
> BLKREPORTZONEV2 ioctl then in the kernel we only have to cache zone
> information that will be used by filesystems. Information that won't be
> used by filesystems doesn't have to be cached. With this approach the
> existing data structures are sufficient (struct blk_zone_wplug and
> conv_zones_bitmap) and we don't need to introduce new data structures
> for tracking zone information.

See XFS and BTFS mount code.

E.g., for XFS, xfs_mount_zones() -> xfs_get_zone_info_cb() -> xfs_init_zone().
Zone type, condition and write pointer are used. That's about everything in the
zone report and to generate that we need: (1) zone condition and (2) zone write
pointer offset. Both are available from zone write plugs and when we do not have
a zone write plug, we need the zone condition (1), and that allows us to infer
(2). For the zone type, that can always be inferred from the zone condition so
that is not cached.

So we already are caching the *minimum* amount of data needed, and that data
allows us to generate a near perfect zone report without needing to interrogate
the drive. We are not doing any "Information that won't be used by filesystems
doesn't have to be cached.". This is already optimal.

BLKREPORTZONEV2 is for users to also get the benefits of a faster zone report
for things like mkfs (formatting a large RAID volume takes a long time because
of zone reports on all drives). Removing it would be counter productive.

-- 
Damien Le Moal
Western Digital Research

