Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19860C001B0
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:In-Reply-To:Date:References:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZjixsS62Rr6GJQ5wm3+wcP9Mfdcz39bR8AWo/tP3EXc=; b=2d4gn2qupv2yaHECs/lKE5rUgb
	siqgwx/kW/PP1HJAHnNv2HQB8lIvjQbbCjJRCkmPHvsw0DyhexmAHOBHcXd84rqnHisQL8gShm6uX
	HenwV8KQB/potYRZOm3C3iITEbMEGjKAwBXgFyhOg2S0S5bJ2kmNzSM71TAnmKepqFWm/ug2m5E7O
	JasHtwG1UzMKK9IbA8wdGGWx/+VUY4CnEECvdLkOLQAQ0TEHCRay9wk+a1pPdVDLDlWCroAFTZ141
	K5XDoTT5E16w4hchIMUaNOVveLSbFJ1wTdUMrvy7eeobBj9pbt5WtLsA3qJrbHCFlvU7SRvRxsL/n
	hkkZ0ytA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOgTM-00Ar2a-1Y;
	Wed, 26 Jul 2023 15:30:44 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOgTI-00Ar1z-3C
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 15:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1690385441; x=1721921441;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ZjixsS62Rr6GJQ5wm3+wcP9Mfdcz39bR8AWo/tP3EXc=;
  b=ZBvbNMGJRDaX7N/fC/PHTWxKAHwR7pJYUb+GUZ7Nl2G8ZwcoN5EDhC8J
   qS4Xe9SqW9IvCKMlVW1dAAuTlXVYEtvCLY6ymubMOytLTxXTDtRKuEw+H
   naVCyFa8MB0s2zZy81Tr+ze23+gmM016nNqsNI4z5tisLItjluSby5tFH
   4=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="341886389"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 15:30:36 +0000
Received: from EX19MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id CA6DB806F9;
	Wed, 26 Jul 2023 15:30:34 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 15:30:33 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 26 Jul 2023 15:30:33 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 9468420D52; Wed, 26 Jul 2023 17:30:33 +0200 (CEST)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
References: <20230725110622.129361-1-ptyadav@amazon.de>
	<ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
	<50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
	<20230726131408.GA15909@lst.de>
Date: Wed, 26 Jul 2023 17:30:33 +0200
In-Reply-To: <20230726131408.GA15909@lst.de> (Christoph Hellwig's message of
	"Wed, 26 Jul 2023 15:14:08 +0200")
Message-ID: <mafs0cz0e8zc6.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_083041_214583_739D2203 
X-CRM114-Status: GOOD (  27.94  )
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

On Wed, Jul 26 2023, Christoph Hellwig wrote:

Hi all,

> On Wed, Jul 26, 2023 at 10:58:36AM +0300, Sagi Grimberg wrote:
>>>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
>>>> information for the NVMe devices. This means all NVMe devices have
>>>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
>>>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
>>>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
>>>> both nodes get similar performance (around 315k IOPS).
>>>
>>> irqbalance doesn't work with this driver though: the interrupts are
>>> managed by the kernel. Is there some other reason to explain the perf
>>> difference?

Hmm, I did not know that. I have not gone and looked at the code but I
think the same reasoning should hold, just with s/irqbalance/kernel. If
the kernel IRQ balancer sees the device is on node 0, it would deliver
its interrupts to CPUs on node 0.

In my tests I can see that the interrupts for NVME queues are sent only
to CPUs from node 0 without this patch. With this patch CPUs from both
nodes get the interrupts.

>>
>> Maybe its because the numa_node goes to the tagset which allocates
>> stuff based on that numa-node ?
>
> Yeah, the only explanation I could come up with is that without this
> the allocations gets spread, and that somehow helps.  All of this
> is a little obscure, but so is the NVMe practice of setting the node id
> to first_memory_node, which no other driver does.  I'd really like to
> understand what's going on here first.  After that this patch probably
> is the right thing, I'd just like to understand why.

See above for my conjecture on why this happens.

More specifically, I discovered this when running an application pinned
to a node 1 CPU reading from an NVME device. I noticed it was performing
worse than when it was pinned to node 0.

If the process is free to move around it might not see such a large
performance difference since it could move to a node 0 CPU. But if it is
pinned to a CPU in node 1 then the interrupt will always hit a node 0
CPU and create higher latency for the reads.

I have a simple fio test that can reproduce this. Save this [1] as 
fio.txt and then run numactl --cpunodebind 1 fio ./fio.txt. You can run
it on any host with an NVME device that has no NUMA node. I have tested
this on AWS EC2's i3.16xlarge instance type.

[1]
    [global]
    ioengine=libaio
    filename=/dev/nvme0n1
    group_reporting=1
    direct=1
    verify=0
    norandommap=0
    size=10%
    time_based=1
    runtime=30
    ramp_time=0
    randrepeat=0
    log_max_value=1
    unified_rw_reporting=1
    percentile_list=50:99:99.9:99.99:99.999
    bwavgtime=10000

    [4k_randread_qd16_4w]
    stonewall
    bs=4k
    rw=randread
    iodepth=32
    numjobs=1

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




