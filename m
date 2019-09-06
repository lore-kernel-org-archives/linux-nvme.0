Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A860C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:13:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DF3207FC
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V/rbLDh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DF3207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/sWFOJnabsBs+0lFKlQ3AXlm/AnLpO7KQvFexLa/xuU=; b=V/rbLDh9Dx/WUx
	d75klO+Q5ibsOH9Pwc2d2hObNKf7x7UBY7+bz5je2n2dCh74KLvS/oY3FLMfm0YwL3rPVNDRXjBZ6
	yCa/GnsD13BjRGvbzHAa/4j9zk8sZWeli8N6xEMOH6GQ+/Z7CAVGoQ33Ue4jXOPmmuwmfzT4oU9RM
	5yWs/yLEnK7PGArEIYRGoAH2PKsnjnezksNd+kRmcb/7QngpwIh0UDjqiI5Xx7TpUs6aOfLpYjZs8
	kpqWhkG2lRqQwCGbcXIQNnXmsanUY7SvXMXc/i43ysTy0H4pLAvTx1trlk/iCDFazLyuoQ0Ffv3Y/
	E84i4ooxCqelLgBy6waw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6NQE-00067J-M1; Fri, 06 Sep 2019 23:13:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6NQB-00066c-It
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 23:13:41 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C1848E2B62;
 Fri,  6 Sep 2019 23:13:38 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE8935D721;
 Fri,  6 Sep 2019 23:13:27 +0000 (UTC)
Date: Sat, 7 Sep 2019 07:13:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190906231321.GB12290@ming.t460p>
References: <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <20190905090617.GB4432@ming.t460p>
 <6a36ccc7-24cd-1d92-fef1-2c5e0f798c36@linaro.org>
 <20190906014819.GB27116@ming.t460p>
 <20190906141858.GA3953@localhost.localdomain>
 <CY4PR21MB0741091795CEE3D4624977CFCEBA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20190906221920.GA12290@ming.t460p>
 <20190906222555.GB4260@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190906222555.GB4260@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 06 Sep 2019 23:13:38 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_161339_659982_248CC589 
X-CRM114-Status: GOOD (  17.37  )
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
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 06, 2019 at 04:25:55PM -0600, Keith Busch wrote:
> On Sat, Sep 07, 2019 at 06:19:21AM +0800, Ming Lei wrote:
> > On Fri, Sep 06, 2019 at 05:50:49PM +0000, Long Li wrote:
> > > >Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
> > > >
> > > >Why are all 8 nvmes sharing the same CPU for interrupt handling?
> > > >Shouldn't matrix_find_best_cpu_managed() handle selecting the least used
> > > >CPU from the cpumask for the effective interrupt handling?
> > > 
> > > The tests run on 10 NVMe disks on a system of 80 CPUs. Each NVMe disk has 32 hardware queues.
> > 
> > Then there are total 320 NVMe MSI/X vectors, and 80 CPUs, so irq matrix
> > can't avoid effective CPUs overlapping at all.
> 
> Sure, but it's at most half, meanwhile the CPU that's dispatching requests
> would naturally be throttled by the other half who's completions are
> interrupting that CPU, no?

The root cause is that multiple submission vs. single completion.

Let's see two cases:

1) 10 NVMe, each 8 queues, 80 CPU cores
- suppose genriq matrix can avoid effective cpu overlap, each cpu
  only handles one nvme interrupt
- there can be concurrent submissions from 10 CPUs, and all may be
  completed on one CPU
- IRQ flood couldn't happen for this case, given each CPU is only
  handling completion from one NVMe drive, which shouldn't be fast
  than CPU.

2) 10 NVMe, each 32 queues, 80 CPU cores
- one CPU may handle 4 NVMe interrupts, each from different NVMe drive
- then there may be 4*3 submissions aimed at single completion, then IRQ
  flood should be easy triggered on CPU for handing 4 NVMe interrupts.
  Because IO from 4 NVMe drive may be quicker than one CPU.

I can observe IRQ flood on the case #1, but there are still CPUs for
handling 2 NVMe interrupt, as the reason mentioned by Long. We could
improve for this case.

Thanks,
Ming

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
