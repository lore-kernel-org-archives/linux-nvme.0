Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141E0C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgqi8LleL6ouLo6kMK/Jqstf0Znjkz30hN1mn6uOHHI=; b=QlXP2B3NQ2evWC+3AstDMO8KJL
	iClOJaU9PiLuJaFwSKghL9EFO1DV12RL6diQvLFTxuRcTgcNTEV2efGEYK+1uSo1jCHR1Km454FR7
	n4u/nzNTVjb66clgVKo227OXEW3VPww9XLqqHof4+HtysCn2rClrQrD9vMPiTTHjJXqvdtXU47J4u
	CYwzPVlBgCo0ET6L6nCYIWmvVL9DEze+L3UmQjzkzsCO14mI/Q8QMPC9hiAWk/EPhvuQVqN6itW/o
	n3AAbwCMxMrmMgVEOpNY7tGiJW9uS+D15WD/l2BLK5+hmgrXlpx3gU2sM6LsOdsynwgTlKbE6ny9G
	JZFtwPiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obU5A-000PcC-Kh; Thu, 22 Sep 2022 21:50:08 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obU56-000Pau-VA
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 21:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663883404; x=1695419404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=er09uNXC0UOU0KonSbZPN8xSrNWI41anaBAXb0hrDDA=;
  b=jWCAmzzfG8B25F+FYN4gjXMqzfrLYAcL9Zo7zVU63ruG6+nHys7cKFPo
   PBZZaiuQR4J4cyuWzP8NEMfvctS3Ca2MuO2UlOLDZX2lsm7lc61TaSVOj
   bVefvdi3XQU9PSBK3IEMqYqsiQoWQ05boFyFwBnSo9ng78BtmozBfwO/6
   aR3SX2o/91xcH7dQa/2mb7T4+TR83fb3U6ZBget6O+mvZ+4bzTk0gcdNT
   ZGLsYRK6+k8tJwQp5jgoT2qBVkgDbDumrucx6finra9oDdIobRusxHmcy
   w6Z/WdPYkqZwKJPaoJP2nXWilafHE8IHqMuP4jk3qGOke1wlMIBOgNepV
   A==;
X-IronPort-AV: E=Sophos;i="5.93,337,1654531200"; 
   d="scan'208";a="210437257"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2022 05:50:01 +0800
IronPort-SDR: ObkkItSaJV8e5qB/p9VcZbql4jIEnZwzx3CisP/PRuxKaSaNVTMPt5Ei6s6wqMFB0q58yvbdMv
 A1Z52OdUr/Mldq5OrkLpuD8tfwuKfNXEbUkJkoZHWl6NZuWB4Dm5EM+eioCHCh3fXcy2AevQAH
 cjUn8X7mY+hPbN18W6G1ndCkOcYVrCeq2b11vgCeIJSCeack+i7B453NrlVCE2q6r58YEjBwi/
 POxQGgF9q0VpKcBMTuAEbhCDIyDtt8V5tjTFd679C2Uu/mDdbGgsH/am33GOeNf96cSGbmqR/3
 4xitqKSFFAyF7JfaqYzo0izZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2022 14:04:33 -0700
IronPort-SDR: dH5ZFSwO8nuLDPD73DfskUQqSMELVBza1h7CThexYu0ZziicByaNInUndXNp2pR1FLpGiFRvG4
 031TXm8SNerG10qWoJNKBx1WLihm1DDN1qQb6XYybC6VcFOTDr6L6S+WbyAL8zDxVhhIDgHkSX
 R+QmUbzB3j4abI/Mr6S4r/UjBTHO2hwqSVaOtHuXf3mWCiJKYri93QhYzIffhPD1b1oZmI6/pe
 epiCtUnfF32fNLP5QhUG/ftGSIFXT1LC60FldH2S0k8PVVF0RPpl/Ts3ejtbIow8vVvn7vhIhF
 do4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2022 14:50:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MYTTh6CWgz1Rx15
	for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 14:50:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:content-language:references:to
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1663883398; x=1666475399; bh=er09uNXC0UOU0KonSbZPN8xSrNWI41anaBA
	Xb0hrDDA=; b=rz2GcA7s2bJgUXchSnXZVFCNcJUGWCPkCS3MbwuKvU08r9AyzdQ
	IpGIMiLbX6cxjTb09M/N1cgll93w2/oxxj8/Ud2zKTDugZwtwfGgvodFSAFnAP+h
	62Ec4kZjXy0vn47e0KvweHBK/Jg4lBdwKCoeeOkaftRCW9lC5M2VMiD1oZFMLgMQ
	R6y9bS2apjeadQVN64Xdven2aaTMIAzLRcuKtgSc5DRcxyEUmEv9fxeSWDq2PM8V
	rzTvnW5v5pJwHL0oyi8nYgTn/qml0MCDAJ2MD6dnMUpFwLH8FuYX7WrvKbk+tSw2
	3pxsjnL/649ooLjlse7rgUFrG7Ow7Q5t1JA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 67sImvwKzlq9 for <linux-nvme@lists.infradead.org>;
	Thu, 22 Sep 2022 14:49:58 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MYTTX6yjsz1RvLy;
	Thu, 22 Sep 2022 14:49:52 -0700 (PDT)
Message-ID: <860fb643-8a1a-225e-13e7-e68a4b6f3842@opensource.wdc.com>
Date: Fri, 23 Sep 2022 06:49:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone sizes]
To: Mike Snitzer <snitzer@redhat.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com, snitzer@kernel.org,
 axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, pankydev8@gmail.com,
 gost.dev@samsung.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
 matias.bjorling@wdc.com
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com> <YytJhEywBhqcr7MX@redhat.com>
 <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
 <Yyy5XUUWGkU8B3IP@redhat.com>
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yyy5XUUWGkU8B3IP@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_145005_161142_775307BD 
X-CRM114-Status: GOOD (  40.57  )
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

On 9/23/22 04:37, Mike Snitzer wrote:
> On Wed, Sep 21 2022 at  7:55P -0400,
> Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
> 
>> On 9/22/22 02:27, Mike Snitzer wrote:
>>> On Tue, Sep 20 2022 at  5:11P -0400,
>>> Pankaj Raghav <p.raghav@samsung.com> wrote:
>>>
>>>> - Background and Motivation:
>>>>
>>>> The zone storage implementation in Linux, introduced since v4.10, first
>>>> targetted SMR drives which have a power of 2 (po2) zone size alignment
>>>> requirement. The po2 zone size was further imposed implicitly by the
>>>> block layer's blk_queue_chunk_sectors(), used to prevent IO merging
>>>> across chunks beyond the specified size, since v3.16 through commit
>>>> 762380ad9322 ("block: add notion of a chunk size for request merging").
>>>> But this same general block layer po2 requirement for blk_queue_chunk_sectors()
>>>> was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
>>>> to be non-power-of-2").
>>>>
>>>> NAND, which is the media used in newer zoned storage devices, does not
>>>> naturally align to po2. In these devices, zone capacity(cap) is not the
>>>> same as the po2 zone size. When the zone cap != zone size, then unmapped
>>>> LBAs are introduced to cover the space between the zone cap and zone size.
>>>> po2 requirement does not make sense for these type of zone storage devices.
>>>> This patch series aims to remove these unmapped LBAs for zoned devices when
>>>> zone cap is npo2. This is done by relaxing the po2 zone size constraint
>>>> in the kernel and allowing zoned device with npo2 zone sizes if zone cap
>>>> == zone size.
>>>>
>>>> Removing the po2 requirement from zone storage should be possible
>>>> now provided that no userspace regression and no performance regressions are
>>>> introduced. Stop-gap patches have been already merged into f2fs-tools to
>>>> proactively not allow npo2 zone sizes until proper support is added [1].
>>>>
>>>> There were two efforts previously to add support to npo2 devices: 1) via
>>>> device level emulation [2] but that was rejected with a final conclusion
>>>> to add support for non po2 zoned device in the complete stack[3] 2)
>>>> adding support to the complete stack by removing the constraint in the
>>>> block layer and NVMe layer with support to btrfs, zonefs, etc which was
>>>> rejected with a conclusion to add a dm target for FS support [0]
>>>> to reduce the regression impact.
>>>>
>>>> This series adds support to npo2 zoned devices in the block and nvme
>>>> layer and a new **dm target** is added: dm-po2zoned-target. This new
>>>> target will be initially used for filesystems such as btrfs and
>>>> f2fs until native npo2 zone support is added.
>>>
>>> As this patchset nears the point of being "ready for merge" and DM's
>>> "zoned" oriented targets are multiplying, I need to understand: where
>>> are we collectively going?  How long are we expecting to support the
>>> "stop-gap zoned storage" layers we've constructed?
>>>
>>> I know https://zonedstorage.io/docs/introduction exists... but it
>>> _seems_ stale given the emergence of ZNS and new permutations of zoned
>>> hardware. Maybe that isn't quite fair (it does cover A LOT!) but I'm
>>> still left wanting (e.g. "bring it all home for me!")...
>>>
>>> Damien, as the most "zoned storage" oriented engineer I know, can you
>>> please kick things off by shedding light on where Linux is now, and
>>> where it's going, for "zoned storage"?
>>
>> Let me first start with what we have seen so far with deployments in the
>> field.
> 
> <snip>
> 
> Thanks for all your insights on zoned storage, very appreciated!
> 
>>> In addition, it was my understanding that WDC had yet another zoned DM
>>> target called "dm-zap" that is for ZNS based devices... It's all a bit
>>> messy in my head (that's on me for not keeping up, but I think we need
>>> a recap!)
>>
>> Since the ZNS specification does not define conventional zones, dm-zoned
>> cannot be used as a standalone DM target (read: single block device) with
>> NVMe zoned block devices. Furthermore, due to its block mapping scheme,
>> dm-zoned does not support devices with zones that have a capacity lower
>> than the zone size. So ZNS is really a big *no* for dm-zoned. dm-zap is a
>> prototype and in a nutshell is the equivalent of dm-zoned for ZNS. dm-zap
>> can deal with the smaller zone capacity and does not require conventional
>> zones. We are not trying to push for dm-zap to be merged for now as we are
>> still evaluating its potential use cases. We also have a different but
>> functionally equivalent approach implemented as a block device driver that
>> we are evaluating internally.
>>
>> Given the above mentioned usage pattern we have seen so far for zoned
>> storage, it is not yet clear if something like dm-zap for ZNS is needed
>> beside some niche use cases.
> 
> OK, good to know.  I do think dm-zoned should be trained to _not_
> allow use with ZNS NVMe devices (maybe that is in place and I just
> missed it?).  Because there is some confusion with at least one
> customer that is asserting dm-zoned is somehow enabling them to use
> ZNS NVMe devices!

dm-zoned checks for conventional zones and also that all zones have a zone
capacity that is equal to the zone size. The first point puts ZNS out but
a second regular drive can be used to emulate conventional zones. However,
the second point (zone cap < zone size) is pretty much a given with ZNS
and so rules it out.

If anything, we should also add a check on the max number of active zones,
which is also a limitation that ZNS drives have, unlike SMR drives. Since
dm-zoned does not handle active zones at all, any drive with a limit
should be excluded. I will send patches for that.
> 
> Maybe they somehow don't _need_ conventional zones (writes are handled
> by some other layer? and dm-zoned access is confined to read only)!?
> And might they also be using ZNS NVMe devices to do _not_ have a
> zone capacity lower than the zone size?

It is a possibility. Indeed, if the ZNS drive has:
1) zone capacity equal to zone size
2) a second regular drive is used to emulate conventional zones
3) no limit on the max number of active zones

Then dm-zoned will work just fine. But again, I seriously doubt that point
(3) holds. And we should check that upfront in dm-zoned ctr.

> Or maybe they are mistaken and we should ask more specific questions
> of them?

Getting the exact drive characteristics (zone size, capacity and zone
resource limits) will tell you if dm-zoned can work or not.

-- 
Damien Le Moal
Western Digital Research


