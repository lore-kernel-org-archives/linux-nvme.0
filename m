Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C020C982F1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M4muqY0lW02uu5uA32TB1lWiOPsktWg393qYiGy7Diw=; b=mQBPy1pWJwfGdrVseAJ/g5epie
	kuEdQnsP44NecuG09uy4bhrdCKomawKeEUV+teSFu6ZqZ/zcksCaEY8mOAv7c0sJUyrnguGxzfn0n
	t5bKUDsEo67/piwTa7lgulTtcB278jjmchk7Gq+gk/QWyag2kDxM0YvYadLRqpyr9LecLK8Al4PGK
	OF7sFC7lGn5WX1Kq5TIbmg9RkSNaYaMChG/GKkkafRC4am1hcTXr6ewErstEzzhIbQGjvatTiIDFO
	FohJNTDcU8dde18+ed+GCe7AukZmVow4IIrnYgllkIantzMLx7Odz0jqTqKSVVVP278ruBH4P3ndO
	BA6bmFxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8vgh-00000004dwj-0z2X;
	Tue, 22 Sep 2026 08:17:15 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8vge-00000004dv3-0rcm
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 08:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790065026; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=M4muqY0lW02uu5uA32TB1lWiOPsktWg393qYiGy7Diw=;
	b=jltFraQMVg/+Us/gS94NhyTMEbue9+Z93lwoT6ITx4wLdGX/YWtdZkIUb1DVVo0g/ih1+Pn1XPdHVoNVcnk9ajqzfKsPepRL5F0BjEzzx8VfSpggOyG8YShe87MaytV0aMVNUNcPIJpxNKqFUiLRd4JT5V+kX4kt+GRxAesRhCo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBT73GO_1790065024;
Received: from 30.178.81.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBT73GO_1790065024 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 16:17:05 +0800
Message-ID: <42c7c2a5-2bf6-48e9-92e8-a8514bd40c1f@linux.alibaba.com>
Date: Tue, 22 Sep 2026 16:17:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: set BLK_FEAT_ZONED only after the zone
 info is known
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, John Garry <john.g.garry@oracle.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
References: <20260914105713.155704-1-kanie@linux.alibaba.com>
 <20260915063651.GA13293@lst.de>
 <709f43ca-b93f-407b-8d64-fe78f6090488@linux.alibaba.com>
In-Reply-To: <709f43ca-b93f-407b-8d64-fe78f6090488@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_011712_935699_F07BACEB 
X-CRM114-Status: GOOD (  10.14  )
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



在 2026/9/15 16:51, Guixin Liu 写道:
>
>
> 在 2026/9/15 14:36, Christoph Hellwig 写道:
>> On Mon, Sep 14, 2026 at 06:57:13PM +0800, Guixin Liu wrote:
>>> The namespace head is marked zoned at allocation time based only on
>>> the command set identifier, before any zone information has been
>>> queried.  If the zone info query fails on the first scan, the path
>>> namespace is registered without zoned limits while the head still
>>> advertises the zoned capability with a zone size of zero.  Reporting
>>> zones or writing to the head then shifts by ilog2(0), triggering the
>>> UBSAN shift-out-of-bounds report in the report-zones and write paths.
>>>
>>> Drop the zoned feature from the head allocation and inherit it from
>>> the path namespace: the head limits refresh already stacks the zoned
>>> feature, the zone size and the zone resource limits from the path
>>> queue, so the head matches the path namespace and becomes zoned once a
>>> revalidation succeeds.  This also stops marking the head zoned when
>>> CONFIG_BLK_DEV_ZONED is off, which used to fail the head allocation
>>> with a WARN.
>> Where do we actually stack it right now?
> The head stacks it in nvme_update_ns_info(): after the path namespace
> update it's own limits, queue_limits_stack_bdev() stacks the path
> queue into the head, and blk_stack_limits() inherits the BLK_FEAT_ZONED
> through BLK_FEAT_INHERIT_MASK, along with chunk_sectors and the zone
> resource limits. That happens before the head is registered, so
> blk_revalidate_disk_zones() see the zoned feature in place.
>
Hi Christoph, any feedback?

Best Regards,
Guixin Liu
> Best Regards,
> Guixin Liu



