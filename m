Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5269BC44529
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OFPAmAtbrl67rHByhOFAoZtvrL1ChOoVdMkFYbtDgWg=; b=Tb09xKpvAjXGkj9P81pE4vJDL6
	8rmQsJN5+dE+KbkxG7nWJciy1Zca9ts62R1Cxn4lLBhqgdLehhtxYYLzSSMvHz41A+XjY4DWW2lUs
	0ks6pzhQfjfXMABwDry7Ve7qSN+UeTAZjrnJ0/8YRPTGG06RKjQgMgA7REh00Q8SArK96kcBCre1O
	PHal0zdlQDIZPoX/nGY1wf35nBqZYmJP3CDgaOnUxrOb9fJJ4U6d4crAMNKb9KkJ42fhgSMl5y+4q
	pJg7EvzuEK+7Mav8EMlJ4L2JbGXaDmQkp7ISnVDh/PmleCvcPEfglajWMyD6BEXe9+s+qTWSocoEz
	Z6uHHGvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm7Ne-000000093jI-0R0k;
	Tue, 21 Jul 2026 10:07:18 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm7Na-000000093hz-33Vz
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 10:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784628435; x=1816164435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ul25+FSRUq9Z+4quIcfxdE6StN81pOFokn8RGkQEvj0=;
  b=n0SI0ZWW3gOoonN/YIEnY7kFD+YKkN4mZF6FhktYFgdksWkp5Q1N/H0A
   hu7gJYSaUucU+0eSb64pTwL1rePtpZ/EdVG2KgDSaxPhBUuNkXBZeBjzf
   Xd+0WBbljy0DnhshX26PkpwoCykRNMUJGAgq3qJpIm4SFhI0ntzDkQoRy
   YJKYnQ9BiIx+GX/SEcHGsmBn9tXkGnhv56UeL5JeI+AYcASjLyRBsQOBi
   Z+zsG9IXzJ2eynWhdvXOGhTydzCI+G0LchJXT3fDLpzYI7bXXLfiKobm5
   g8GfJHqdjnjR8ovrPJQkVBYwyLVSRJdd6wfeuLpc6/RAWJn9RbvpUPNmq
   Q==;
X-CSE-ConnectionGUID: f3F/kmwIQz20jtfe0cjJnQ==
X-CSE-MsgGUID: XL0/liorTYGHDF1BT4ZWUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95584667"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95584667"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:07:14 -0700
X-CSE-ConnectionGUID: BBMgAyePSqKuV+oxnQ220w==
X-CSE-MsgGUID: IbhtkuNEQ1qfvobN7cyJOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="261274823"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:07:09 -0700
Date: Tue, 21 Jul 2026 13:07:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: hch@lst.de, axboe@kernel.dk, gang.cao@intel.com, jun.i.jin@intel.com,
	jun1.zeng@intel.com, kbusch@kernel.org, liang.a.fang@intel.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tglx@kernel.org, yong.hu@intel.com,
	guzebing@bytedance.com
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Message-ID: <al9Ey6RfuJXYtqm-@ashevche-desk.local>
References: <20260715075703.15578-1-jun1.zeng@intel.com>
 <20260715075703.15578-2-jun1.zeng@intel.com>
 <allEmTmXCFosxIOr@kbusch-mbp>
 <20260720150539.GB17986@lst.de>
 <20260721083739.69676-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721083739.69676-1-changfengnan@bytedance.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_030714_863130_30EB513C 
X-CRM114-Status: GOOD (  20.18  )
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

On Tue, Jul 21, 2026 at 04:37:39PM +0800, Fengnan Chang wrote:

> The patch is included below. 

The above in this case can be moved to cover letter, in this form it's harder
for maintainers to apply this.

...

> From 1c84b5afc906e780e1dbd2ee186251f9de2716b5 Mon Sep 17 00:00:00 2001
> From: Fengnan Chang <changfengnan@bytedance.com>
> Date: Tue, 21 Jul 2026 12:31:46 +0800
> Subject: [PATCH] nvme-pci: adaptively poll busy queues from threaded
>  interrupts
> 
> On systems with multiple fast NVMe devices, hard IRQ completion
> processing can become CPU-bound and cap 4K random-read throughput
> before the devices are saturated.
> 
> Add adaptive polling for busy interrupt-driven queues. Track the SQ head
> reported by completions while the CQE is still owned by the host. After
> the hard IRQ reaps pending CQEs, wake the IRQ thread and mask the queue
> interrupt when the number of SQ entries not yet consumed reaches a high
> watermark. Poll in the IRQ thread until the queue drops below a low
> watermark or a bounded loop count is reached, then reenable the
> interrupt.
> 
> Only enable adaptive polling when the controller has independent
> vectors, as masking a shared single vector could suppress unrelated
> queues. Expose the enable switch, watermarks, loop bound, and sleep
> interval as module parameters.

...

> +static irqreturn_t nvme_adaptive_poll(int irq, void *data)
>  {
>  	struct nvme_queue *nvmeq = data;
> +	unsigned int loops = 0;

Unneeded. See below how.

> +	unsigned int max_loops = READ_ONCE(adaptive_poll_max_loops);
> +	unsigned int sleep_min = READ_ONCE(adaptive_poll_sleep_min_us);
> +	unsigned int sleep_max = READ_ONCE(adaptive_poll_sleep_max_us);
>  
> -	if (nvme_cqe_pending(nvmeq))
> -		return IRQ_WAKE_THREAD;
> -	return IRQ_NONE;
> +	do {
> +		if (nvme_cqe_pending(nvmeq))
> +			nvme_irq(irq, data);
> +		if (nvme_adaptive_poll_should_stop(nvmeq))
> +			break;

> +		usleep_range(sleep_min, sleep_max);

fsleep() ? This automatically makes the upper bound ~25% of the requested value.
Supplying max in this situation makes not much sense.


> +	} while (++loops < max_loops);

	} while (--max_loops);

> +	enable_irq(irq);
> +	return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko



