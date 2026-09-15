Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97608C88E73
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A6PSyg9cjlaHHKsP3sCSmUHegqhSL8UE4MIQiB++MOE=; b=dV06SwemZNfvlco4HA2zHHEHjd
	meeKtlRBeS4zBOjpT5iXOfePyWOl9aARnhHEeQ7HJu07CxIR8WMuvqLaOBrMhjekqoOPXd6r7LyRx
	EVeB9Z5JKYgOvCEgq7lyceRWEJeTkyFsqgdVv9v0924nVjTcWyqyw51jlIULPs8l0ZKZDJ4cIzWl3
	+4eUy1CLBLxOb/Rn8LOUJ3HEtPXi3Cj6UF4A1ouiohdte49VXxWRdufzH2GOA5UoBKtRa5U48YSpM
	OOLcH182QCaenNzeASSwqRcckNpL19aqMve6kZomzXO3ZOZWSuSzFI+BdsmAJ+V6K4asaleOaBuC3
	Je+JDqCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Otd-00000005hOo-0zeV;
	Tue, 15 Sep 2026 08:52:09 +0000
Received: from out199-7.us.a.mail.aliyun.com ([47.90.199.7])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Ota-00000005hOG-0xUz
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 08:52:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789462321; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A6PSyg9cjlaHHKsP3sCSmUHegqhSL8UE4MIQiB++MOE=;
	b=pwKZ5fV5I4uHg0eUMTuyDrHIZFSmyZk0T0N5rAWzRbpGFYI6Fle+o6Kwk1MRgD90x+yRb/WbGQVKiQ8JB5TQ/816XqhowsM+GF+bzZl473dAeJLBckTQgHTM/70FuXrGVxObxwpNuBnZ/5poTZ1rOL31uy3afTWJcDKCRiXrdog=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB0vw60_1789462319;
Received: from 30.178.84.235(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB0vw60_1789462319 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 16:52:00 +0800
Message-ID: <709f43ca-b93f-407b-8d64-fe78f6090488@linux.alibaba.com>
Date: Tue, 15 Sep 2026 16:51:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: set BLK_FEAT_ZONED only after the zone
 info is known
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, John Garry <john.g.garry@oracle.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
References: <20260914105713.155704-1-kanie@linux.alibaba.com>
 <20260915063651.GA13293@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260915063651.GA13293@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_015206_926692_24E929EB 
X-CRM114-Status: GOOD (  10.68  )
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



在 2026/9/15 14:36, Christoph Hellwig 写道:
> On Mon, Sep 14, 2026 at 06:57:13PM +0800, Guixin Liu wrote:
>> The namespace head is marked zoned at allocation time based only on
>> the command set identifier, before any zone information has been
>> queried.  If the zone info query fails on the first scan, the path
>> namespace is registered without zoned limits while the head still
>> advertises the zoned capability with a zone size of zero.  Reporting
>> zones or writing to the head then shifts by ilog2(0), triggering the
>> UBSAN shift-out-of-bounds report in the report-zones and write paths.
>>
>> Drop the zoned feature from the head allocation and inherit it from
>> the path namespace: the head limits refresh already stacks the zoned
>> feature, the zone size and the zone resource limits from the path
>> queue, so the head matches the path namespace and becomes zoned once a
>> revalidation succeeds.  This also stops marking the head zoned when
>> CONFIG_BLK_DEV_ZONED is off, which used to fail the head allocation
>> with a WARN.
> Where do we actually stack it right now?
The head stacks it in nvme_update_ns_info(): after the path namespace
update it's own limits, queue_limits_stack_bdev() stacks the path
queue into the head, and blk_stack_limits() inherits the BLK_FEAT_ZONED
through BLK_FEAT_INHERIT_MASK, along with chunk_sectors and the zone
resource limits. That happens before the head is registered, so
blk_revalidate_disk_zones() see the zoned feature in place.

Best Regards,
Guixin Liu


