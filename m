Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83BAC3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 09:25:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4EA22CF8
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 09:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T20JZ59a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4EA22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ljcXxRHSmM8ntAdAurMCyPu3U/ZUME6IdN+Hl2ILNXQ=; b=T20JZ59a3BT1/c
	xFzjll62TewKEC1ZRkq9oBGecUgYMEVMpgpyYqrrsy09sGUcWXjnitqIR6hfylkc+ZEwX+Q89DW2B
	gwEFk8K72zs50ACv/3bIEJbXnVABqmP1Zyv0+cukJdkJPwBQvt+HA0C8yzJg1sZ3iG3895AJerwjl
	QEwWa2ac6QwZ7DZ86SgvrAbc0KrO/tTtMJqAQpvWG65wjRy2mYpB1KM2jG6+LWog5lWUT1VRYCJwS
	D4pqb9L9G9mCCZkpXk8D/ZOb6TIfcmPBcnLkI6GjhndS3HNg4rUV7LsQf1gmR26fyYdGxbEGM74j2
	ZTY3zraL8AXMuOqCCvfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i553s-000183-Ir; Tue, 03 Sep 2019 09:25:16 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i553n-00017J-61
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 09:25:12 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7DBAE85360;
 Tue,  3 Sep 2019 09:25:10 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DC94100197A;
 Tue,  3 Sep 2019 09:25:00 +0000 (UTC)
Date: Tue, 3 Sep 2019 17:24:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190903092453.GA22399@ming.t460p>
References: <20190828110633.GC15524@ming.t460p>
 <alpine.DEB.2.21.1908281316230.1869@nanos.tec.linutronix.de>
 <20190828135054.GA23861@ming.t460p>
 <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <alpine.DEB.2.21.1909031000460.1880@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909031000460.1880@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 03 Sep 2019 09:25:10 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_022511_304516_ED02811D 
X-CRM114-Status: GOOD (  23.33  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 John Garry <john.garry@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-scsi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Long Li <longli@microsoft.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 10:09:57AM +0200, Thomas Gleixner wrote:
> On Tue, 3 Sep 2019, Ming Lei wrote:
> > Scheduler can do nothing if the CPU is taken completely by handling
> > interrupt & softirq, so seems not a scheduler problem, IMO.
> 
> Well, but thinking more about it, the solution you are proposing is more a
> bandaid than anything else.
> 
> If you look at the networking NAPI mechanism. It handles that situation
> gracefully by:
> 
>   - Disabling the interrupt at the device level

I guess you mean we disable the interrupt in the softirq context.

IO performance could be affected by the extra action of disabling/enabling
interrupt every time.

IOPS for the discussed device is several millions.

> 
>   - Polling the device in softirq context until empty and then reenabling
>     interrupts

blk-mq switches to complete req in interrupt context for avoiding extra
performance loss, so switching back to softirq context every time may
cause performance regression.

> 
>   - In case the softirq handles more packets than a defined budget it
>     forces the softirq into the softirqd thread context which also
>     allows rescheduling once the budget is completed.


It can be hard to figure out one perfect defined budget.

In the patchset of V2[1], IRQF_ONESHOT is applied on the irq thread,
and interrupt isn't enabled until the interrupt has been handled in
the irq thread context.

[1] https://github.com/ming1/linux/commits/v5.3-genirq-for-5.4

The approach in this patchset is actually very similar with the above
NAPI based way. The difference is that softirq is avoided, and interrupt
is always handled in interrupt context in case that CPU won't be stalled,
so performance won't be affected. And we only switch to handle interrupt
in thread context if CPU stall is going to happen.

> 
> With your adhoc workaround you handle one specific case. But it does not
> work at all when an overload situation occurs in a case where the queues
> are truly per cpu simply.

There isn't such CPU stall issue in case of single submission vs. single
completion, because submission side and completion side share same single
CPU, and the submission side will slow down if completion side takes all
the CPU. 

> Because then the interrupt and the thread
> affinity are the same and single CPU targets and you replace the interrupt
> with a threaded handler which runs by default with RT priority.

Even though the threaded handler is RT priority and the thread is run
on same CPU with the interrupt, CPU/rcu stall still can be avoided.

Also we can switch to use irq affinity for the irq thread instead of effective
affinity.

> 
> So instead of hacking something half baken into the hard/softirq code, why
> can't block do a budget limitation and once that is reached switch to
> something NAPI like as a general solution?

Another big reason is that multiple submission vs. single completion isn't
common case, I knew that there are only small number of such device,
so re-inventing NAPI based approach may takes lots of effort, meantime
only small number of devices can get the benefit, not sure if block
community would like to consider that.

IMO, it might be the simplest generic way to solve the problem from genirq.


Thanks,
Ming

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
