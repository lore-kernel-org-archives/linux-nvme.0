Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D376C0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 19:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:In-Reply-To:Date:References:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PdsSRu7tlZBA3gNrHuPdzW7N3hmmobQp+k8jhBUmFHA=; b=FKDOTWaTfDuk9jPpDcwkFTdZ/d
	SrvHk7ryoxQtCi48xlyQKBiK62fL1xHGppjvYIJrQb09XPBUrVximgsGX5netmbdscVba9FjhHOLt
	v5G3FWPmWEMZArNtBJwbV8IwTo72lqFhlF6G1sk1gPs7Fmgome82oPrQH9YmON4Djaxv9Zw7BdNsK
	H2HhflVZnN0EU+MrSr3ufSVbgyMVNE2uBmVFWnA98Zo7mK1gQFxMv0sLndVQ+AlU6jxcSMAPcCG5D
	M6/2R/WOMq9w7ELhnTu+RadYYkVai0xstpAhxYNVmX+0ryt626a53VZ9Z+K+WAMeYGtMEqTdBLZCI
	UuhnRlHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOkFZ-00BOoq-19;
	Wed, 26 Jul 2023 19:32:45 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOkFU-00BOnm-1W
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 19:32:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1690399960; x=1721935960;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=PdsSRu7tlZBA3gNrHuPdzW7N3hmmobQp+k8jhBUmFHA=;
  b=Ef8fCo9NZnxaJs03/iLQFkKyyxprxaPwz2LaJlqJpDtXxI2FU01p7gQW
   wHLZbeDL+U7+FwSdLqlowh5+QeaoZtN9WLxD25pXP/Ksto+LfYO96herO
   hXb9vx4yJzpk1NEFePxTbW6fYJFtEVhAYtvyXu/mITa/iZeP7qiFnqzqj
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="228901664"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 19:32:35 +0000
Received: from EX19MTAUEC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id 2DFAA46E5E;
	Wed, 26 Jul 2023 19:32:34 +0000 (UTC)
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 19:32:33 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 26 Jul 2023 19:32:33 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 3672C20E1D; Wed, 26 Jul 2023 21:32:33 +0200 (CEST)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "Jens
 Axboe" <axboe@kernel.dk>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
References: <20230725110622.129361-1-ptyadav@amazon.de>
	<ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
	<50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
	<20230726131408.GA15909@lst.de> <mafs0cz0e8zc6.fsf_-_@amazon.de>
	<ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
Date: Wed, 26 Jul 2023 21:32:33 +0200
In-Reply-To: <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com> (Keith Busch's
	message of "Wed, 26 Jul 2023 10:17:20 -0600")
Message-ID: <mafs08rb28o4u.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_123240_583698_B018DCF9 
X-CRM114-Status: GOOD (  22.36  )
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

On Wed, Jul 26 2023, Keith Busch wrote:

> On Wed, Jul 26, 2023 at 05:30:33PM +0200, Pratyush Yadav wrote:
>> On Wed, Jul 26 2023, Christoph Hellwig wrote:
>> > On Wed, Jul 26, 2023 at 10:58:36AM +0300, Sagi Grimberg wrote:
>> >>>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
>> >>>> information for the NVMe devices. This means all NVMe devices have
>> >>>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
>> >>>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
>> >>>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
>> >>>> both nodes get similar performance (around 315k IOPS).
>> >>>
>> >>> irqbalance doesn't work with this driver though: the interrupts are
>> >>> managed by the kernel. Is there some other reason to explain the perf
>> >>> difference?
>>
>> Hmm, I did not know that. I have not gone and looked at the code but I
>> think the same reasoning should hold, just with s/irqbalance/kernel. If
>> the kernel IRQ balancer sees the device is on node 0, it would deliver
>> its interrupts to CPUs on node 0.
>>
>> In my tests I can see that the interrupts for NVME queues are sent only
>> to CPUs from node 0 without this patch. With this patch CPUs from both
>> nodes get the interrupts.
>
> Could you send the output of:
>
>   numactl --hardware

$ numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
node 0 size: 245847 MB
node 0 free: 245211 MB
node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
node 1 size: 245932 MB
node 1 free: 245328 MB
node distances:
node   0   1
  0:  10  21
  1:  21  10

>
> and then with and without your patch:
>
>   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>   done

Without my patch:

    $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
    >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
    >   done
    40
    40
    33
    33
    44
    44
    9
    9
    32
    32
    2
    2
    6
    6
    11
    11
    1
    1
    35
    35
    39
    39
    13
    13
    42
    42
    46
    46
    41
    41
    46
    46
    15
    15
    5
    5
    43
    43
    0
    0
    14
    14
    8
    8
    12
    12
    7
    7
    10
    10
    47
    47
    38
    38
    36
    36
    3
    3
    34
    34
    45
    45
    5
    5

With my patch:

    $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
    >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
    >   done
    9
    9
    15
    15
    5
    5
    23
    23
    38
    38
    52
    52
    21
    21
    36
    36
    13
    13
    56
    56
    44
    44
    42
    42
    31
    31
    48
    48
    5
    5
    3
    3
    1
    1
    11
    11
    28
    28
    18
    18
    34
    34
    29
    29
    58
    58
    46
    46
    54
    54
    59
    59
    32
    32
    7
    7
    56
    56
    62
    62
    49
    49
    57
    57

-- 
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




