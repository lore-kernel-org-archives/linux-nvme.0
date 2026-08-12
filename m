Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D906C5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L5XuO0SxWQCuVEotu2uDK5cOSWsw8Y7hYzHJ1M2MOSs=; b=gD6UGofHrpjXSUPH3fr7k9GrIz
	M5CtEg/XGJC+tjsrLdyM+gnWzSd6hJ2/pW+TDljzxfC38UE1HYaQ8pLZGzhAJgQlQJ1gFzJvTte+O
	smI5koruVSW/eM3M/9MoryghOQuKggQTV03e+MpuOxxjKmoAwDNrwsoVAAiqOoPYgyjAMs+0s99DT
	ryEGhqmNHM2w2pGTaKkneStKWIwPcr4QmwoH6cAtajLSYAfG7dNE20r4EWuB2TG50DEqPm2CdjYtk
	dhdIMaVvmIEx1Bos0Hqdt+VE6q47spOQPa2e/hTEnM7b7/m0rmCkWir0CNlSMJBtMTW41c41wqf7X
	XQuzIO4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuD6A-0000000Gj3c-1EFk;
	Wed, 12 Aug 2026 17:50:42 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuD67-0000000Gj3H-2rgZ
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 17:50:40 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2ceb096e675so16957885ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 12 Aug 2026 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786557038; x=1787161838; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L5XuO0SxWQCuVEotu2uDK5cOSWsw8Y7hYzHJ1M2MOSs=;
        b=sngQLuK5yHwe5uXbEXiNCF+vWMyLslhuS2Dp2gkEbBVsCC4sIsGmWdSdzEbYkkytSY
         79vJoUBowCI99QIXywBzErHfCsjALXdjx0hygViTnuThAzWcBYpMnY6nLIPkpNt6pN4C
         wxQuC/WtNU9BxzUrZL0xixBps0DVN2Wk6bk7C7Ww5Zm176NdtUmDVpZosFPHBeA94ZsT
         nLFdRXO52qdPkAIH9NaRVmhkwM2p6lIJDXcSDfJPKD+kg3iy00+1O7c61eSxPRUBNDxn
         NrtdfuwrdNNyQ2BlWFdTwW9QYtCPODhrfRJ6bQWgofqR1YKl0oDHnfALvv9WTtkfmCkQ
         1olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786557038; x=1787161838;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L5XuO0SxWQCuVEotu2uDK5cOSWsw8Y7hYzHJ1M2MOSs=;
        b=COophTnCHR0avbMfEM+smi8Mf+Nqgg4+HI3fEWfiXAW/4oPKNyQ/9xsDl/nmbfJi0P
         yPhr/T3H9wPugED4WhKe/sQNoNDxoLxVP+cuTKJ1ERDzQALkOKFUQkRfkOhjY7es6qEY
         cig3XVLELBJ+V7PxMLsdbnERw27UXdMXszi/LOkcLkWnYrNr0jaz27pAdtxu03IKBRr/
         vfldwiYTytnIieL2wJOOWJdIbNWD8FieqLwZpsfLSsYkt7yhoBdq6lmWmKT7CN6C4l3I
         3bb3/ffU45/nzGJ4/e4byBOPcur1Zm6MXsq1GL2Xbdlhar3h9ndLgTn9dT3cmPBSUM01
         uXXA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6O79C0KcBdezVZcN/72gMAXjxh83/448IU6hA8pH5OPkl/y8bjKljnoNCeEplgy+Mph+CTI1SJOUv@lists.infradead.org
X-Gm-Message-State: AOJu0YyuZ2B/NigSzuGdUF36zXl+9E6ZbdUEj4gOjQi7hjCt0IB+3o6a
	7Wc23NZ3Z3s2D0toElNf8rf21vbld4LO+HCTm55lnwQHGIxi4YHww8A=
X-Gm-Gg: AR+sD11EezyJcvMsTHTFewwNtMBYpz7Xt7IK1xKQNPi7OhFeYWRjbU7qafH2Evk6204
	I+Ceya7sa5ZA7GStEDobpv8enA3LlcILOaSHtFMO2ceTl8nsGXj2fFnlxykPtaU9874LP2RlrOy
	lc648LX/ThqThvCygRDbhjV79y2cmQQbBDzE/kMblGxuHkb5QXIxw77sFDqIOgF0UggJfq4V5T1
	/ZLOC1R5WGIbvNr0u6ZE9weSVK4qV2cqhY9dtBTm3WubAtAd3WscSRH2ixdhwrcTt/8ZPowNdvp
	RV/O/Fah+1ucUUw2XLFkT0urW/lEIzA0l1gyz0QCBHbP+qBEWpMg3N+JTGg3kBbsishZB8+8f+o
	IEjFXbpQdiLpp/WYGNvQxz6UQkaOlQPX5hhdi8uoDmzBJgwNqGqDZON3KOQo5stCySC1xDBfM2+
	qBm5BF2YLGDJmBo8EcrYfxiPB/FL0QIUhySPNOjPxgZj+dEJdQ8obp98iI6P2MvVSFG1wgYPEkK
	7SLb52PVbQb1pU0kaEN61At5AOl
X-Received: by 2002:a17:90a:d610:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-393014be1eamr7983056a91.10.1786557038282;
        Wed, 12 Aug 2026 10:50:38 -0700 (PDT)
Received: from anuj-MacBookPro ([2406:7400:63:2611:121a:e03f:10e3:a8f3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6291c84sm13623986eec.19.2026.08.12.10.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 10:50:37 -0700 (PDT)
Date: Wed, 12 Aug 2026 23:20:30 +0530
From: Anuj Gupta <anuj1072538@gmail.com>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Guzebing <guzebing@bytedance.com>
Subject: Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt polling
Message-ID: <zn4sxqomlnqkegok3lg4zut5xvgbydkmg57xc66y4shyup25jo@t246msdeokl5>
References: <20260806031058.40176-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806031058.40176-1-changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_105039_729479_2660F26A 
X-CRM114-Status: GOOD (  32.06  )
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

On Thu, Aug 06, 2026 at 11:10:58AM +0800, Fengnan Chang wrote:
> Each Solidigm SB5PH27X038T device used for testing can deliver about 3.2M
> 4 KiB random-read IOPS.  Four of them should be good for about 12.8M IOPS,
> but interrupt-driven completion tops out at 5.59M, only about 44% of that.
> 
> Polling gets rid of that cost, but polling every queue all the time burns
> CPU and hurts the sparse or bursty queues that interrupts handle just fine.
> So instead of a global switch, let each queue make the call on its own,
> from how fast it has been completing lately, and re-check often enough that
> the decision tracks the workload rather than a fixed tunable.
> 
> Each queue runs a small loop with three stages.  First it samples its
> completion rate while still on interrupts.  Only if that rate is high
> enough to fill a small batch inside a bounded latency window does it mask
> its own IRQ and start draining the CQ from a high-resolution timer, with
> each wait sized to collect roughly one batch.  It keeps polling as long as
> it keeps up with that rate; the moment it stalls or slows down it turns the
> IRQ back on and backs off, waiting longer the further behind it fell.
> A queue that doesn't benefit drops back quickly and only gets retried once
> in a while, so polling stays on the queues that are actually
> interrupt-bound and everything else keeps running on the untouched IRQ
> path.
> 
> Measured with 4 KiB random reads on Solidigm SB5PH27X038T, adaptive on
> versus off:
> 
>                                    QD32      QD64      QD128
>   one device, one job             +18.44%   +24.35%   +26.38%
>   four devices, eight jobs        +83.76%   +99.02%   +96.26%
>

Did a quick test on single NVMe with QD64, one job, 4K random reads via
io_uring, I see ~23% improvement: 569K -> 701K IOPS.

Do you expect the fixed batch size, sample size, maximum delay, episode
length, and backoff multiplier to work across devices with different
latency profiles and across different workloads, or should these values
somehow adapt to observed queue behavior?

> +/*
> + * Stop polling and turn the queue's IRQ back on.  @elapsed is how long the
> + * episode ran after it started falling behind, or 0 if it ended cleanly.
> + * The bigger @elapsed is, the more completions we missed, and the longer we
> + * wait before sampling this queue again, so a queue that polling doesn't
> + * help is left alone most of the time.
> + */

@elapsed is the total polling-episode duration, not the time since the
queue fell behind. It is then used with the total completion count to
estimate cumulative deficit. Could the comment be reworded accordingly?

> +/*
> + * Called from the IRQ handler after a reap that found something.  If we're
> + * still in backoff, just count it down.  Otherwise time how long
> + * NVME_ADAPTIVE_SAMPLE_CQES completions take to get the average gap between
> + * them.  If that looks worth polling (see the filter below) mask the IRQ and
> + * switch to poll mode; if not, leave the queue on interrupts.
> + */
> +static void nvme_adaptive_sample(struct nvme_queue *nvmeq,
> +				 unsigned int completions)
> +{
> +	struct nvme_adaptive_poll *adaptive = nvmeq->adaptive;
> +	unsigned int sample;
> +	unsigned long flags;
> +	u64 delta, interval, now;
> +
> +	if (adaptive->retry_completions) {
> +		if (adaptive->retry_completions != U64_MAX)
> +			adaptive->retry_completions -= min_t(u64, completions,
> +							 adaptive->retry_completions);
> +		return;
> +	}
> +	if (!adaptive->start_ns) {
> +		adaptive->start_ns = ktime_get_ns();
> +		return;
> +	}
> +	adaptive->completions += completions;
> +	if (adaptive->completions < NVME_ADAPTIVE_SAMPLE_CQES)
> +		return;
> +
> +	now = ktime_get_ns();
> +	delta = now - adaptive->start_ns;
> +	sample = adaptive->completions;
> +	adaptive->start_ns = now;
> +	adaptive->completions = 0;
> +	if (!delta || delta > (u64)NVME_ADAPTIVE_SAMPLE_CQES *
> +			       NVME_ADAPTIVE_MAX_DELAY_NS)
> +		return;
> +	/*
> +	 * Is this rate worth polling?  The 100/99 factor trims 1% off the gap so
> +	 * a queue sitting right on the threshold isn't pulled in.  Skip it if
> +	 * it's too slow to fill a batch within MAX_DELAY, and also skip it if
> +	 * it's already fast enough to batch by itself.  The hardware's own
> +	 * coalescing already handles that case, so leave it on interrupts.
> +	 */
> +	interval = div64_u64(delta * 100, sample * 99);
> +	if (!interval || interval > NVME_ADAPTIVE_MAX_DELAY_NS ||

The comment says this rejects queues that cannot fill a target batch
within MAX_DELAY, but this condition only checks whether one completion
interval exceeds MAX_DELAY. Should this instead account for TARGET_BATCH
or this comment is describing a different policy?

> +	    (delta > NSEC_PER_MSEC &&
> +	     interval <= NVME_ADAPTIVE_MAX_DELAY_NS /
> +			 NVME_ADAPTIVE_TARGET_BATCH))
> +		return;
> +

For a normal 256-CQE sample with an interval of 2us or less, delta will
be about 512us or less, so the 1ms condition prevents this exclusion
from firing. Is this intended to detect only samples that substantially
overshoot 256 CQEs? If so, could the comment make that narrower intent
explicit?

