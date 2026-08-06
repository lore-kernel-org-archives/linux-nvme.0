Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D59C56208
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rEVLX+dD9pSW4h8SbXdVl5Bj+9c6JBlmAAihMNayCeo=; b=BPuQHXy7PZyUOieJd/Jqre03gY
	+tXxe7E9UIwIj6Sxtf2MsbGzWSQgOCMZghC9BoypnfMipeMvO7Z1O9t+w/PNYPPhoVdEtGETYUYn+
	fUk6tic2AzgvCk0br3afqBe/HmMLumB42hqUkV5aJb6BW1BFsPbw8o2D8jwyaEaTau7Alt9mnOnnf
	gOc7qFOy/t8a6qPgr2KmLbkau5BECRVaFGq6lO1T/q9JF+0biBcjM2lDqjy9/C4c8Z3RpFgybunsZ
	O2f/cXC02lJ+Cvw4ZMVKRljMa7WKtZl+IwY1GbIwzqjZI1FmSzkcLRptwHqm17accYrqL8t3bwTzY
	4uIuzgAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws5Tv-00000006iDb-129H;
	Thu, 06 Aug 2026 21:18:27 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws5Ts-00000006iCz-1xz3
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 21:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786051105; x=1817587105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B+3CZsZUdtppbI5i1SbA+c8iZ3CR4rp2wPMwmZUxf/4=;
  b=jLTTJYl8ASRxg/U5fgzzzpmUNNC3swAUqJjBTQlmKLXlJKTutRQqo2m3
   Ui+WhNjYbHGAQ0tJeOO33HnGmJVdn8FdMEDMligDr99IVlVvLqyeyIhP/
   VquzwdzmILGaho5LF4k0FWchJeCFzuhBlmwGR4cOlznZNU2d5c7mAlITG
   blIUoRn+I3FvqYxI1I2AVqo96fY+bkHByY8CYrwprs9sl/oPlyPtCnk5U
   NQwzUXZ+VSCPLczUwPmo0dERrFFmO8uGJR8fJ0ISUGrkGdVrdWIKCy4sQ
   RqEWRckImNSbC1RRC9Njz1LwTF9SIIXVundAa4B58/q+Sa/m5PS3KDj3n
   w==;
X-CSE-ConnectionGUID: vqBAqX1kSLKX1XiQys+OMg==
X-CSE-MsgGUID: xlqNWaXeSzWmaNcYQex1Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86425327"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86425327"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:18:22 -0700
X-CSE-ConnectionGUID: EQQ1tZQaRjOGm1+ipb2BEA==
X-CSE-MsgGUID: EAhyCzXqQv+Tl6JaEY0Q6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="261697084"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:18:19 -0700
Date: Fri, 7 Aug 2026 00:18:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Thomas Gleixner <tglx@kernel.org>, Jun Zeng <jun1.zeng@intel.com>,
	Gang Cao <gang.cao@intel.com>, Jun I Jin <jun.i.jin@intel.com>,
	Liang A Fang <liang.a.fang@intel.com>, Yong Hu <yong.hu@intel.com>,
	linux-kernel@vger.kernel.org, Guzebing <guzebing@bytedance.com>
Subject: Re: [RFC PATCH] nvme-pci: adaptively poll completions on busy queues
Message-ID: <anT6GLUy_o12Fiz4@ashevche-desk.local>
References: <20260723120556.58670-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260723120556.58670-1-changfengnan@bytedance.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_141824_551658_C0361C79 
X-CRM114-Status: GOOD (  22.98  )
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

On Thu, Jul 23, 2026 at 08:05:56PM +0800, Fengnan Chang wrote:
> In high-IOPS scenarios, relying on interrupts to handle I/O operations
> can limit performance. This issue becomes particularly pronounced in
> multi-disk environments, where performance is constrained by the CPU’s
> interrupt-handling capacity.
> 
> Each Solidigm SB5PH27X038T device used for testing can deliver about 3.2M
> 4 KiB random-read IOPS.  Four devices therefore have about 12.8M IOPS of
> aggregate capability, but interrupt-driven completion topped out at 7.81M
> IOPS, or about 61% of that capability.
> 
> Add optional adaptive polling for busy interrupt-driven I/O queues.  After
> an interrupt drains the CQ, use the ring distance between last_sq_tail and
> cq_head as an approximate host-side inflight count.  If the count reaches
> a per-controller high watermark, let the threaded handler keep draining
> completions instead of returning to interrupt-driven completion right away.
> 
> The thread always checks for pending CQEs first.  When the CQ is empty, it
> compares the inflight count with a per-controller low watermark and sleeps
> for a configurable interval before checking again.  It returns to
> interrupt-driven completion after three consecutive empty-CQ checks below
> the low watermark or when the loop limit is reached.
> 
> The mode is disabled by default. It can be enabled at module load time.
> The high and low watermarks, empty-CQ interval, and loop limit are
> available through sysfs.  The defaults are 32 commands, 3 commands,
> 30 us, and 1000 iterations.
> 
> Tested with the default settings and 4 KiB random reads on four Solidigm
> SB5PH27X038T devices.  With adaptive polling off and on:
> 
>   - t/io_uring, depth 1024 and four workers per device:
>     7.810M and 12.780M aggregate IOPS (+63.64%).
>   - fio/libaio, iodepth 1024, numjobs 4 and completion batches of 32:
>     7.699M and 12.785M aggregate IOPS (+66.05%).
> 
> In a paired libaio and io_uring boundary sweep, QD8, QD16, QD32, and
> QD16/numjobs=4 changed by -0.15% to +0.48%.  QD64 improved by 28.61% to
> 59.75%.

...

> +What:		/sys/class/nvme/nvmeX/adaptive_poll_inflight_high
> +Date:		July 2026

Can't be July for v7.3. See crystal ball predictor for the dates (rc1 or release).

> +KernelVersion:	7.3

...

> +static void nvme_adaptive_unmask_irq(struct nvme_queue *nvmeq, int irq)
> +{
> +	struct nvme_dev *dev = nvmeq->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +
> +	clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);


> +	if (pdev->msi_enabled) {

Wondering if MSI-X also should be considered here.
With that in mind, can we use pci_dev_msi_enabled()?

> +		writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMC);
> +		readl(dev->bar + NVME_REG_INTMS);
> +	} else {
> +		enable_irq(irq);
> +	}
> +}

...

> +static ssize_t adaptive_poll_interval_us_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
> +	unsigned int value;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +	if (!value)
> +		return -EINVAL;

ERANGE? EDOM?

Ditto for other similar cases.

> +	WRITE_ONCE(ndev->adaptive_poll_interval_us, value);
> +	return count;
> +}

-- 
With Best Regards,
Andy Shevchenko



