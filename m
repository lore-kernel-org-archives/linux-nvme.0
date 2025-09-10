Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68D8CA101F
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Sep 2025 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CP7a9wws54uQZjmYM4sfmOi5aU+3bjgiGZVeJJmASM=; b=GiDC65378FMGw0R/c5+3kfGq/O
	nDijDmdDxVy3wcmt1OvN0fNYN7OF9vQfO1Xj/mmXYSZA+TudADjDe0E0nRvW8ZkjplaU3zRRaiktB
	wN/JxfGtNgi/wqINyMTy6Kbr0xkf6fKBs24BJiXjo+YZGPmgRdU4F0/KSoVw3gsYVBxnRPo8UayM7
	qwAvnsA9ZKqaNIG7+3hSwvCfuMN3thsrM1wr5m9afDhgSp1zjZIYQb1RUtgGThbBzB7Cicbcwv37X
	4Wv17vRnbmnmKCDMH4xu1mEK6NRZi6tqqXbGS+hixzQrodGDySXKY5bxgPrrPVtgbCKKiwVsWJvay
	fhkLg/Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwG48-0000000Cs8T-3kPr;
	Wed, 10 Sep 2025 08:20:32 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwG46-0000000Cs5p-2tAR
	for linux-nvme@lists.infradead.org;
	Wed, 10 Sep 2025 08:20:31 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757492427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CP7a9wws54uQZjmYM4sfmOi5aU+3bjgiGZVeJJmASM=;
	b=mNNqA8pxV739WOsKJHgEtTJOMzX94iX97K4Ca48VKToBLBDsOAuPRpnAviQ4cvMU6C0Bk7
	A5mfIda9JkS3gxSPqX4A+hpyJFgpGHWTOOfmtQ1HAe/wSFGkeSscPc9fAM+Jfxb59IH/1I
	0k0n5GyOhU6D34bkPuFoMEaCL7l9A95WcVb0RR++NMWymRaP241u2PPYxunvC6aJm4vHUH
	43q626KUuKnVAHYivEM6NNaQuk/ZUwrMjLOg4MQTbqZIE8CpvaFQ6G6f6wB1RBE188f9vN
	aeFANjWsi6tymtcat1kCVAgA1TyopPhL3jM96rdJctbl2DdhndatVkQKFYxAMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757492427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CP7a9wws54uQZjmYM4sfmOi5aU+3bjgiGZVeJJmASM=;
	b=UOasHq1uYa5lt0uQ97FDdS3UHchNqSx7ZJpnsh0V4afb/TZLgNqSAON8pWEePxp1gYSODg
	Qy/0se5U0TRUFnCw==
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>, Aaron Tomlin
 <atomlin@atomlin.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, Frederic
 Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, virtualization@lists.linux.dev,
 GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v8 10/12] blk-mq: use hk cpus only when
 isolcpus=io_queue is enabled
In-Reply-To: <d11a0c60-1b75-49ec-a2f8-7df402c4adf2@flourine.local>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20250905-isolcpus-io-queues-v8-10-885984c5daca@kernel.org>
 <ff66801c-f261-411d-bbbf-b386e013d096@suse.de>
 <d11a0c60-1b75-49ec-a2f8-7df402c4adf2@flourine.local>
Date: Wed, 10 Sep 2025 10:20:26 +0200
Message-ID: <87ms72u3at.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_012030_869421_F151BDDD 
X-CRM114-Status: GOOD (  17.76  )
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

On Mon, Sep 08 2025 at 09:26, Daniel Wagner wrote:
> On Mon, Sep 08, 2025 at 08:13:31AM +0200, Hannes Reinecke wrote:
>> >   const struct cpumask *blk_mq_online_queue_affinity(void)
>> >   {
>> > +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
>> > +		cpumask_and(&blk_hk_online_mask, cpu_online_mask,
>> > +			    housekeeping_cpumask(HK_TYPE_IO_QUEUE));
>> > +		return &blk_hk_online_mask;
>> 
>> Can you explain the use of 'blk_hk_online_mask'?
>> Why is a static variable?
>
> The blk_mq_*_queue_affinity helpers return a const struct cpumask *, the
> caller doesn't need to free the return value. Because cpumask_and needs
> store its result somewhere, I opted for the global static variable.
>
>> To my untrained eye it's being recalculated every time one calls
>> this function. And only the first invocation run on an empty mask,
>> all subsequent ones see a populated mask.
>
> The cpu_online_mask might change over time, it's not a static bitmap.
> Thus it's necessary to update the blk_hk_online_mask. Doing some sort of
> caching is certainly possible. Given that we have plenty of cpumask
> logic operation in the cpu_group_evenly code path later, I am not so
> sure this really makes a huge difference.

Sure,  but none of this is serialized against CPU hotplug operations. So
the resulting mask, which is handed into the spreading code can be
concurrently modified. IOW it's not as const as the code claims.

How is this even remotely correct?

Thanks,

        tglx

