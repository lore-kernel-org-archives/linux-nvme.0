Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E551C4CEC9
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 14:37:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8D720665
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 14:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ipffoYUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8D720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HQJgMNK3Hy6VbodL9MJfY967gy5PN+5KaB5rJqtHuLY=; b=ipffoYUMCXqFXe
	NUExeQmUNz5oEqBUItBeuKi2S1q0smjwDNpKczPnmdC8nHbU77brTXNAXrFOhAWNU7m8k7AyQqiZ2
	wdOqQaGc1S4coiOM5NbbrsH3rTNX41ceZhcM7HmlyJSNzGoebAgJZM/YfsRpHAYPkHRDyMs7882WV
	ifJhcD3p9khjYRKDyHcp7KA8hGDyzdk4Cl3UkMbv2trYsVpfmLEjq4Fw3KrG0VkLUk3tAG9FsdUET
	zQetGt+l9lhGkDNIkEeUTKq8p59zPCn3T/ARgmJTQH+csMDUMgSQ4idex8M4LlSPb7ommbgB1jK4p
	9KyxKzzZu27UZa8Y5foQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAb5d-0006Dn-DZ; Wed, 18 Sep 2019 14:37:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAb5Z-0006C9-Ap
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 14:37:51 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB26AA3D38D;
 Wed, 18 Sep 2019 14:37:47 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FA5A1001B36;
 Wed, 18 Sep 2019 14:37:37 +0000 (UTC)
Date: Wed, 18 Sep 2019 22:37:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190918143732.GA19364@ming.t460p>
References: <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <20190905090617.GB4432@ming.t460p>
 <6a36ccc7-24cd-1d92-fef1-2c5e0f798c36@linaro.org>
 <20190906014819.GB27116@ming.t460p>
 <ffefcfa0-09b6-9af5-f94e-8e7ddd2eef16@linaro.org>
 <6eb2a745-7b92-73ce-46f5-cc6a5ef08abc@grimberg.me>
 <20190907000100.GC12290@ming.t460p>
 <f5685543-8cd5-6c6a-5b80-c77ef09c6b3b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5685543-8cd5-6c6a-5b80-c77ef09c6b3b@grimberg.me>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 18 Sep 2019 14:37:48 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_073749_412606_C3FEEFFC 
X-CRM114-Status: GOOD (  23.18  )
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
 John Garry <john.garry@huawei.com>, Bart Van Assche <bvanassche@acm.org>,
 linux-scsi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Long Li <longli@microsoft.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 09, 2019 at 08:10:07PM -0700, Sagi Grimberg wrote:
> Hey Ming,
> 
> > > > Ok, so the real problem is per-cpu bounded tasks.
> > > > 
> > > > I share Thomas opinion about a NAPI like approach.
> > > 
> > > We already have that, its irq_poll, but it seems that for this
> > > use-case, we get lower performance for some reason. I'm not
> > > entirely sure why that is, maybe its because we need to mask interrupts
> > > because we don't have an "arm" register in nvme like network devices
> > > have?
> > 
> > Long observed that IOPS drops much too by switching to threaded irq. If
> > softirqd is waken up for handing softirq, the performance shouldn't
> > be better than threaded irq.
> 
> Its true that it shouldn't be any faster, but what irqpoll already has
> and we don't need to reinvent is a proper budgeting mechanism that
> needs to occur when multiple devices map irq vectors to the same cpu
> core.
> 
> irqpoll already maintains a percpu list and dispatch the ->poll with
> a budget that the backend enforces and irqpoll multiplexes between them.
> Having this mechanism in irq (hard or threaded) context sounds
> unnecessary a bit.
> 
> It seems like we're attempting to stay in irq context for as long as we
> can instead of scheduling to softirq/thread context if we have more than
> a minimal amount of work to do. Without at least understanding why
> softirq/thread degrades us so much this code seems like the wrong
> approach to me. Interrupt context will always be faster, but it is
> not a sufficient reason to spend as much time as possible there, is it?

If extra latency is added in IO completion path, this latency will be
introduced in the submission path, because the hw queue depth is fixed,
which is often small. Especially in case of multiple submission vs.
single(shared) completion, the whole hw queue tags can be exhausted
easily. 

I guess no such effect for networking IO.

> 
> We should also keep in mind, that the networking stack has been doing
> this for years, I would try to understand why this cannot work for nvme
> before dismissing.

The above may be one reason.

Thanks,
Ming

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
