Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD7ACA101F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YT6lK9VThWO2VoDv4flXldsg/lGV+uGD6AwCarpxbiA=; b=Puun3gwN3aEemEOQWoUz4bFw4x
	lstsVGw7UvUjvsgSUASCATupBiRTpryJrk14F4LUeq8Es8BJKWvVZSnswNsOK1/LG3Huonr52QC90
	JNm98mYi9zZnyf0gtQ6d/gsBllKn9XQQe01EqC8v/B6e8met96x/+P6dVLJ0XKcyZFSiV75/vE5WJ
	EiXVuFfq2VNQHJh+m52hoUdlfIfQeOe6YVEN9pnRjvZBEhFpxA+VR50CnmJPFHi6/cr2RqXAqfYRD
	qdhpcl2hytY+DRxsekEOzMtqqksIvWoN8ghg3jREs6QTGcZzhiUt7PV77+F0v2QRyw9hUmyxIQpsn
	hb3NNokg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux4oi-00000009uwh-2XFj;
	Fri, 12 Sep 2025 14:32:00 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux4og-00000009uv7-1BvD
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 14:31:59 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757687516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YT6lK9VThWO2VoDv4flXldsg/lGV+uGD6AwCarpxbiA=;
	b=E81D9Xs6MJnJtYyDYfeabzgtnhu+RMcm8DE0KDo9tBNGZp5iHi5LpNIKp0XivU7YySkQPF
	3Md77jcnpzz2ktnuPXzcJxrAsxF6mzIwMzq7/PMk3PMS0uY1VFv6HJUHzlvcOd0psd09oj
	lr4x7RI8MBh48uDdfptw5f7lPiPscrmKDn/W2DZzIusTWwLgeTdBSJHYQmbsjBlwJhi06l
	CNp7Q2g4VO2A7sLlPAqoAtMvL5C6Gt6Kaeoy9lpdeu6E+g8ks9dmzGVzKaDHfGV321BAMk
	YanvmSBztaAu0jwyA+z8jrWMqaobVb6idrFkdqn44z+qeEiReWNuqTlDk+yrIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757687516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YT6lK9VThWO2VoDv4flXldsg/lGV+uGD6AwCarpxbiA=;
	b=k18nEKxcmY8iz/IYvo6R2LzsHnXZHqJa2ovPB8+4Z6Spdcm0Z6KyI4tDXGNnAuA/riu/pc
	1ypcbeflQ7j/hkDQ==
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <wagi@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "Michael S.
 Tsirkin" <mst@redhat.com>, Aaron Tomlin <atomlin@atomlin.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei
 <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Mel
 Gorman <mgorman@suse.de>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, virtualization@lists.linux.dev,
 GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v8 10/12] blk-mq: use hk cpus only when
 isolcpus=io_queue is enabled
In-Reply-To: <bc5ebdea-7091-4999-a021-ec2a65573aa0@flourine.local>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20250905-isolcpus-io-queues-v8-10-885984c5daca@kernel.org>
 <ff66801c-f261-411d-bbbf-b386e013d096@suse.de>
 <d11a0c60-1b75-49ec-a2f8-7df402c4adf2@flourine.local>
 <87ms72u3at.ffs@tglx>
 <bc5ebdea-7091-4999-a021-ec2a65573aa0@flourine.local>
Date: Fri, 12 Sep 2025 16:31:55 +0200
Message-ID: <87cy7vrbc4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_073158_465126_60083411 
X-CRM114-Status: GOOD (  23.00  )
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

On Fri, Sep 12 2025 at 10:32, Daniel Wagner wrote:
> On Wed, Sep 10, 2025 at 10:20:26AM +0200, Thomas Gleixner wrote:
>> > The cpu_online_mask might change over time, it's not a static bitmap.
>> > Thus it's necessary to update the blk_hk_online_mask. Doing some sort of
>> > caching is certainly possible. Given that we have plenty of cpumask
>> > logic operation in the cpu_group_evenly code path later, I am not so
>> > sure this really makes a huge difference.
>> 
>> Sure,  but none of this is serialized against CPU hotplug operations. So
>> the resulting mask, which is handed into the spreading code can be
>> concurrently modified. IOW it's not as const as the code claims.
>
> Thanks for explaining.
>
> In group_cpu_evenly:
>
> 	/*
> 	 * Make a local cache of 'cpu_present_mask', so the two stages
> 	 * spread can observe consistent 'cpu_present_mask' without holding
> 	 * cpu hotplug lock, then we can reduce deadlock risk with cpu
> 	 * hotplug code.
> 	 *
> 	 * Here CPU hotplug may happen when reading `cpu_present_mask`, and
> 	 * we can live with the case because it only affects that hotplug
> 	 * CPU is handled in the 1st or 2nd stage, and either way is correct
> 	 * from API user viewpoint since 2-stage spread is sort of
> 	 * optimization.
> 	 */
> 	cpumask_copy(npresmsk, data_race(cpu_present_mask));

The present mask is very different from the online mask. The present
mask only changes on physical hotplug when:

     - a offline CPU is removed from the present set of CPUs

     - a offline CPU is added to it.

In neither case the CPU can be involved in any operation related to the
actual offline/online operations.

Also contrary to your approach, this code takes the possibility of
a concurrently changing mask into account by taking a racy snapshot,
which is immutable for the following operation.

What you are doing with that static mask, makes it a target of
concurrent modification, which is obviously a recipe for subtle bugs.

>   Turns out the two stage spread just needs consistent 'cpu_present_mask',
>   and remove the CPU hotplug lock by storing it into one local cache.  This
>   way doesn't change correctness, because all CPUs are still covered.
>
> This sounds like I should do something similar with cpu_online_mask.

Indeed.

Thanks,

        tglx


