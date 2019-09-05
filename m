Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1771C3A5A5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 09:06:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C732082E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 09:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WVnk/2tN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C732082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Qk2xYcC01ZbYCbCZnFsnof2zU0AqqPKejrxioMG7yg=; b=WVnk/2tNeugSJs
	WufGqOodywSqnwL6moBQ7THqR4FgVXrQ/oyjCu1ebfjRwM5zC6tszVqfmMX91YsM0gaB1DM0lcO8z
	dObB1Xc0GHf60p7G+OenM/EJqZ9XgNxIw2P1KHXeyuhx2oT1mVUxnfyA3CBeQYLZYkMdJGDzV+q0p
	epVDGyKl6p5Mzac3A6LY0esbVWhpPWODonqyRsxWITfmRPodjAvtU53iUOK+NA/+qVQerWbWs0COP
	QL+EdEJmHzWlLvucNEAweXn0fyhGiVeDvgCOOrfj/T7lVnFkqzqr+xWTU/gPHkTimzTcurW0qQxlr
	+e96nkYTGjpGXIHoEF8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5niz-0004nT-Mu; Thu, 05 Sep 2019 09:06:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5niw-0004mU-FJ
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 09:06:40 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80E5E8A1C9D;
 Thu,  5 Sep 2019 09:06:34 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4053E5D9CA;
 Thu,  5 Sep 2019 09:06:23 +0000 (UTC)
Date: Thu, 5 Sep 2019 17:06:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190905090617.GB4432@ming.t460p>
References: <20190828135054.GA23861@ming.t460p>
 <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 05 Sep 2019 09:06:34 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_020638_529920_9FC4491B 
X-CRM114-Status: GOOD (  20.49  )
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 John Garry <john.garry@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 07:31:48PM +0200, Daniel Lezcano wrote:
> Hi,
> 
> On 04/09/2019 19:07, Bart Van Assche wrote:
> > On 9/3/19 12:50 AM, Daniel Lezcano wrote:
> >> On 03/09/2019 09:28, Ming Lei wrote:
> >>> On Tue, Sep 03, 2019 at 08:40:35AM +0200, Daniel Lezcano wrote:
> >>>> It is a scheduler problem then ?
> >>>
> >>> Scheduler can do nothing if the CPU is taken completely by handling
> >>> interrupt & softirq, so seems not a scheduler problem, IMO.
> >>
> >> Why? If there is a irq pressure on one CPU reducing its capacity, the
> >> scheduler will balance the tasks on another CPU, no?
> > 
> > Only if CONFIG_IRQ_TIME_ACCOUNTING has been enabled. However, I don't
> > know any Linux distro that enables that option. That's probably because
> > that option introduces two rdtsc() calls in each interrupt. Given the
> > overhead introduced by this option, I don't think this is the solution
> > Ming is looking for.
> 
> Was this overhead reported somewhere ?

The syscall of gettimeofday() calls ktime_get_real_ts64() which finally
calls tk_clock_read() which calls rdtsc too.

But gettimeofday() is often used in fast path, and block IO_STAT needs to
read it too.

> 
> > See also irqtime_account_irq() in kernel/sched/cputime.c.
> 
> From my POV, this framework could be interesting to detect this situation.

Now we are talking about IRQ_TIME_ACCOUNTING instead of IRQ_TIMINGS, and the
former one could be used to implement the detection. And the only sharing
should be the read of timestamp.

Thanks,
Ming

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
