Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9120C3A5AB
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 09:11:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9262145D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 09:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MmjP2R2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9262145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nF0ahLF7FPxuaHAcPttLw4TjCFgY/oDD+pqCy2sblhE=; b=MmjP2R2znyIk/x
	hzUjsKuPmu9bYvhmmecWdW7L5mHVzHhJenv0ALhU8x4Csh3YaNofTof32JjtOoadUTJV2X93GuohD
	/keVgBj3zco9qCQ6ymVk9k3aLH3mWSGEkhnKY/EhkVhbD96gJJmCmWP6y+V0Yg21hYIwhdqjeK8Hr
	96/ixPCaMvNe8C4KSk3nckubBWIXfifdfImuMlQvkJyQ4mSrCdkCZKebaFKylj34WAER09METW9cV
	aL0t2w5LHae3DTmtWcr0c4PkgycUVEw8GvTIfy0/W3VL9bhWYqOeKNL4roLyDP0fBq0s+ZeZezkH6
	9aivXFb9m0W+s7iioL8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5nnW-0007Qd-Sm; Thu, 05 Sep 2019 09:11:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5nnT-0007Pv-PC
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 09:11:21 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60DC93007C23;
 Thu,  5 Sep 2019 09:11:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18A8D5D9CA;
 Thu,  5 Sep 2019 09:11:08 +0000 (UTC)
Date: Thu, 5 Sep 2019 17:11:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190905091103.GC4432@ming.t460p>
References: <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <de16de12-fa1a-666c-ea19-fea5d096c1ca@acm.org>
 <20190904180211.GX2332@hirez.programming.kicks-ass.net>
 <9b924e48-e217-9c11-c1fb-46c92a82ea2d@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9b924e48-e217-9c11-c1fb-46c92a82ea2d@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 05 Sep 2019 09:11:19 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_021120_112220_F066417A 
X-CRM114-Status: GOOD (  15.11  )
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
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 12:47:13PM -0700, Bart Van Assche wrote:
> On 9/4/19 11:02 AM, Peter Zijlstra wrote:
> > On Wed, Sep 04, 2019 at 10:38:59AM -0700, Bart Van Assche wrote:
> > > I think it is widely known that rdtsc is a relatively slow x86 instruction.
> > > So I expect that using that instruction will cause a measurable overhead if
> > > it is called frequently enough. I'm not aware of any publicly available
> > > measurement data however.
> > 
> > https://www.agner.org/optimize/instruction_tables.pdf
> > 
> > RDTSC, Ryzen: ~36
> > RDTSC, Skylake: ~20
> > 
> > Sadly those same tables don't list the cost of actual exceptions or even
> > IRET :/
> 
> Thanks Peter for having looked up these numbers. These numbers are much
> better than last time I checked. Ming, would CONFIG_IRQ_TIME_ACCOUNTING help
> your workload?

In my fio test on azure L80sv2, IRQ_TIME_ACCOUNTING isn't enabled.
However the irq flood detection introduces two RDTSC for each do_IRQ(),
not see obvious IOPS difference.

Thanks,
Ming

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
