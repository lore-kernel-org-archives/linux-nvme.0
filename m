Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E5FC432C3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 17:12:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA0220833
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 17:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="THIB072R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA0220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FpJ2o3KK00L0VnKsthQ3R57/WDfuIhg1+2meIK4PrsU=; b=THIB072RZU9fH7
	U0CBy9oZ1KDZlIr7FS71gB2vnFYJAj2lHHl91G4rFO4AuMCJ8rJduqfk+BkNamSkBTrB3wmtQmnz1
	A9mOxshzJJszJIPCvnf7RYSASY0T4GHD5Z7Y7C2QpHU2lYG/CVbZCXjQjqBW22kwVGdwETjEsruai
	HSH/tgX8Cq4DaoU96p5Finz40y0c0J97aSQEThmbyShyXbm4kcNm2/x+yYP+vrwGxbkq0ko3Jslgq
	5e8BpoIRDbBv1DGwgFVoRPnoTYVn7We89RfFrPF2w8Kmfw06gt4TDt10/fAlqgNeSGmtkzxPEX4m+
	U8BaR+NrRWbOsTnXL4pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibpFd-00054N-TO; Mon, 02 Dec 2019 17:12:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibpFb-00053u-Ql
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 17:12:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 14CBE68BE1; Mon,  2 Dec 2019 18:12:40 +0100 (CET)
Date: Mon, 2 Dec 2019 18:12:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4] nvme: Threaded interrupt handling improvements
Message-ID: <20191202171239.GA8547@lst.de>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191129094640.6fq6wcxmfi4fwnlw@linutronix.de>
 <20191129162719.GA47681@C02WT3WMHTD6.lpcnextlight.net>
 <20191129170545.axnykbrabigzcghs@linutronix.de>
 <20191130170222.GA5273@redsun51.ssa.fujisawa.hgst.com>
 <20191202170538.juq745vddzsouufb@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202170538.juq745vddzsouufb@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_091244_017443_F10B7A2E 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, ming.lei@redhat.com,
 helgaas@kernel.org, Keith Busch <kbusch@kernel.org>, tglx@linutronix.de,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 02, 2019 at 06:05:38PM +0100, Sebastian Andrzej Siewior wrote:
> That might be a misunderstanding. I think if your threaded-IRQ handler
> is running legitimately for longer period of time (and making progress)
> and IRQ core's "nobody-care" detector shuts it down then the detector
> might need a tweak.
> The worst thing that could happen, is that the RT tasks run for too long
> and the scheduler punishes them to protect against run-away-tasks (the
> default limit is at 950ms RT task time within 1 second,
> sched_rt_runtime_us).

The problem is that by doing the agressive polling we can keep one
CPU busy just running the irq handler and starve processes on that
CPU if an NVMe queue servers multiple CPUs.

That's why I had the previous idea of one irq thread per cpu that
is assigned to the irq.  We'd have to encode a relative index into
the hardirq handler return value which we get from bits encoded in
the NVMe command ID, but that should be doable.  At that point we
shouldn't need the cond_resched.  I can try to hack that up, but
I'm not an expert on the irq thread code.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
