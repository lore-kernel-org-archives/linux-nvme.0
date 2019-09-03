Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC69EC3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 07:29:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B91F23402
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 07:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rI+LcKgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B91F23402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=peCqm+MAtuEJy+7qG4/4LiIN1YmXEK4obPCBaP9a7IA=; b=rI+LcKgoU3Yus9
	PmDTqMkxtnuoIpZTAhwTFQ9Xc+KMRDsh7x0qAOpv5+k718kNRsDPHu7HxCAr7acCA310i8Hvnwc6U
	wOQRgBgm3kqxFAyCYz7ZnVIhYgleXDUuD3P1BGS574qFenSAw/NuWxdieMhCHODz79kU0Rg1aDNDa
	Iw/TjEthZt9o3JRPRM66FA0OVnWJZX7zc7hxRfVU9Nw2FjC3z9VGNZTr2xHnP0B2BYV6+OLgZ3Ipr
	hJQMe6wsA+00ratpBayaRs5zosaLcXdDkRxvPDVyDGCci539CRGwj0IYV0D1X8KUWSxaSOgYl/ZEZ
	G5siKxL7FM2Dg9CeDonw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i53FT-0006EV-Hb; Tue, 03 Sep 2019 07:29:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i53FQ-0006DX-NT
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 07:29:06 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A9EA106E28C;
 Tue,  3 Sep 2019 07:29:04 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D14055D9E1;
 Tue,  3 Sep 2019 07:28:54 +0000 (UTC)
Date: Tue, 3 Sep 2019 15:28:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190903072848.GA22170@ming.t460p>
References: <20190827225827.GA5263@ming.t460p>
 <alpine.DEB.2.21.1908280104330.1939@nanos.tec.linutronix.de>
 <20190828110633.GC15524@ming.t460p>
 <alpine.DEB.2.21.1908281316230.1869@nanos.tec.linutronix.de>
 <20190828135054.GA23861@ming.t460p>
 <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 03 Sep 2019 07:29:04 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_002904_787278_A9A8D014 
X-CRM114-Status: GOOD (  19.63  )
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
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 John Garry <john.garry@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 08:40:35AM +0200, Daniel Lezcano wrote:
> On 03/09/2019 08:31, Ming Lei wrote:
> > Hi Daniel,
> > 
> > On Tue, Sep 03, 2019 at 07:59:39AM +0200, Daniel Lezcano wrote:
> >>
> >> Hi Ming Lei,
> >>
> >> On 03/09/2019 05:30, Ming Lei wrote:
> >>
> >> [ ... ]
> >>
> >>
> >>>>> 2) irq/timing doesn't cover softirq
> >>>>
> >>>> That's solvable, right?
> >>>
> >>> Yeah, we can extend irq/timing, but ugly for irq/timing, since irq/timing
> >>> focuses on hardirq predication, and softirq isn't involved in that
> >>> purpose.
> >>>
> >>>>  
> >>>>> Daniel, could you take a look and see if irq flood detection can be
> >>>>> implemented easily by irq/timing.c?
> >>>>
> >>>> I assume you can take a look as well, right?
> >>>
> >>> Yeah, I have looked at the code for a while, but I think that irq/timing
> >>> could become complicated unnecessarily for covering irq flood detection,
> >>> meantime it is much less efficient for detecting IRQ flood.
> >>
> >> In the series, there is nothing describing rigorously the problem (I can
> >> only guess) and why the proposed solution solves it.
> >>
> >> What is your definition of an 'irq flood'? A high irq load? An irq
> >> arriving while we are processing the previous one in the bottom halves?
> > 
> > So far, it means that handling interrupt & softirq takes all utilization
> > of one CPU, then processes can't be run on this CPU basically, usually
> > sort of CPU lockup warning will be triggered.
> 
> It is a scheduler problem then ?

Scheduler can do nothing if the CPU is taken completely by handling
interrupt & softirq, so seems not a scheduler problem, IMO.


Thanks,
Ming

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
