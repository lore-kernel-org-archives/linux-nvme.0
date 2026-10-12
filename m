Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E4FCA9ED2
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VUZVPJ0UdIOFS6vc0OC+Ybkfy7MnJx9+quD+Spo+mMI=; b=hINGadrNMeKkmdV3vKamZ0Z0b0
	zqvln7TwoI4R5HtHpnmwlmw+AmBqQaTJ6CCEjL8jC+4X0Je4zqeLCc2LTEP8ziuxPZkibRttGazha
	eoKmjk6OL6xhWt0FAcRjpAK0crumGkE1Zra/KZiB/7vZ62otJmFzjxsaIS//qkxsScuco6LJA9zg3
	2FHql9uoMi0hZSKO8Y5+uOtV//qmxbC2JQMDKPzCT3IGrxuhuEUTO+VgLmeHR2iIpVCXvqYYRx/ML
	fKNtPClO1tsZeP9v3oQ5QptSB35j4qg3EalGOiHabUESxQHmAcxZUhzItiRjIenmn4eELP7GwGQPp
	TYkX5xsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGBG5-00000009v9T-2nuy;
	Mon, 12 Oct 2026 08:19:45 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGBG2-00000009v8z-1cyz
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 08:19:43 +0000
Received: from [10.95.64.165] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF8DB20B7166;
	Mon, 12 Oct 2026 01:19:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF8DB20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791793178;
	bh=VUZVPJ0UdIOFS6vc0OC+Ybkfy7MnJx9+quD+Spo+mMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CwMzGL/13NGkEhXjsOKinbs1ElSPiR4S5DdiyGApYDuhels99yZBg6z+6WDJbFkJx
	 okWtJavFo7CBsXu+eFAQMWntrgGVGT7/1sEaEcO27PQhMU8IVZZh3W0cXIa3/cbgF4
	 tCdDKvBrbewabINGUTaMHoqOWYbE//DQVfriKBI4=
Message-ID: <53b199f9-56f6-4b44-93a5-be6437fd3fc4@linux.microsoft.com>
Date: Mon, 12 Oct 2026 13:49:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler
 pressure
To: Luigi Rizzo <lrizzo@google.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 changfengnan@bytedance.com
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
 <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
 <CAMOZA0Ljw-DueDP3WvmtYe4x9Y_fNaptAo+3Hv8xzYHOZi9vbQ@mail.gmail.com>
 <CAMOZA0KJoS4GFrKmaGa7+qMCNktTUg-YpkzX_EoA2KfAW3iN_g@mail.gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <CAMOZA0KJoS4GFrKmaGa7+qMCNktTUg-YpkzX_EoA2KfAW3iN_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_011942_463949_D614B792 
X-CRM114-Status: GOOD (  27.72  )
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



On 10/9/2026 8:28 PM, Luigi Rizzo wrote:
> On Fri, Oct 9, 2026 at 1:27 PM Luigi Rizzo <lrizzo@google.com> wrote:
>>
>> On Fri, Oct 9, 2026 at 12:17 PM Naman Jain <namjain@linux.microsoft.com> wrote:
>>>
>>>
>>>
>>> On 10/9/2026 12:21 PM, Naman Jain wrote:
>>>>
>>>>
>>>> On 10/9/2026 11:24 AM, Michael Kelley wrote:
>>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October
>>>>> 8, 2026 10:06 PM
>>>>>>
>>>>>> On systems with several fast NVMe controllers, completion interrupts can
>>>>>> keep returning to the same CPUs faster than scheduled work can run. Each
>>>>>> handler may drain only a small number of completions, but the combined
>>>>>> interrupt stream can still prevent scheduler and watchdog progress.
>>>>>
>>>>> See this recent proposal [1] that sounds like it is addressing the
>>>>> same or a
>>>>> similar issue. And there is this [2] more global approach. It's
>>>>> worthwhile to read
>>>>> through the discussion on both threads. I haven't done a detailed
>>>>> comparison
>>>>> of either vs. your proposal.
>>>>>
>>>>> Michael
>>>>>
>>>>> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-
>>>>> changfengnan@bytedance.com/
>>>>> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1-
>>>>> lrizzo@google.com/
>>>>>
>>>>
>>>>
>>>> Thanks for sharing these Michael. I'll check more on these, and try it out.
>>>>
>>>> Regards,
>>>> Naman
>>>
>>> ++ authors of these two series, for awareness and if there is some
>>> configuration in their patches I should be trying to fix these lockup
>>> issues.
>>

Hi Luigi,
Thanks for looking into it.

>> I see your thorough analysis below, thanks for the details.
>> Is there any reason why you used nvme.use_threaded_interrupts=0 ?
>>>> Setting to 1 moves the work to a kernel thread and seems to be the
>> best way to prevent too much work in the hardirq and the soft lockup.
>>

I used 0 because the goal was to preserve the existing hardirq fast path
and avoid the throughput cost we had observed with threaded interrupts.

I have both modes on the same kernel image. Threaded interrupts did
prevent the lockup, but at QD256 they reached 3.165M IOPS versus 4.986M
with the IRQ-poll fallback. At QD1 they reached 21.2K versus 25.0K IOPS.

So threaded interrupts are a valid workaround, but on this system they
cost about 15% at QD1 and 37% at QD256 compared with the fallback.

More details in my initial cover letter.
https://lore.kernel.org/all/20261009050556.2817978-1-namjain@linux.microsoft.com/

>> I am surprised that GSIM fails to prevent the soft lockup, though:
>> under high load the sequence of events (starting from unmoderated)
>> should be the following:
>>
>> 1. HW sends MSIx interrupt, not blocked by anything
>> 2. SW calls handle_fasteoi_irq() --> handle_irq_event() --> ... -->
>> action->handler() which starts processing
>> 3. HW possibly sends another MSIx interrupt
>> 4. SW handle_irq_event() completes
>> 5. SW irq_start_moderation() starts the timer, __disable_irq() and
>> sets IRQD_IRQ_INPROGRESS | IRQD_MODERATED
>> 6. if #3 happened, or another HW interrupt comes before the timer expires:
>>    SW handle_fasteoi_irq() finds IRQD_IRQ_INPROGRESS | IRQD_MODERATED both set,
>>    and does not call handle_irq_event(), postponing the call
>> 7. when the timer expires, the pending interrupt is reinjected.
>>
>> The above suggests that we should see some pauses between runs of
>> action->handler(),
>> at least for a single queue per CPU.
>>
>> Do you have any way to look with perf and bpftrace at the CPU
>> processing interrupts,
>> to see what keeps it busy (the pause between 6 and 7 should keep it
>> well below 100%)
>> and try to verify whether the calls to hndle_irq_event() are actually spaced
>> as the sequence above describes?
>>
>> Having multiple interrupts on the same CPU mean that the gap
>> between interrupts for one can be used by others, and that may
>> definitely make the CPU 100% busy in hardirq.
> 

GSIM was creating gaps for individual sources, but the other NVMe 
sources sharing that CPU were filling most of them.

I traced irq_handler_entry/irq_handler_exit with trace-cmd for the four 
NVMe queue vectors routed to CPU0. The test used GSIM fixed at 10 us 
with all 56 data-NVMe I/O vectors opted in.

Without timer push, I recorded 37,218 NVMe handler invocations in three 
seconds. The median handler duration was about 2 us, but the median gap 
between NVMe handlers was only 4 us. The p99 gap was 872 us.

With timer push enabled, the same three-second CPU0 trace contained only 
531 NVMe handler invocations, and the median gap increased from 4 us to 
517 us. This confirms your diagnosis, adding one delay per additional 
source restores a real CPU-wide gap.

The full QD256 workload then completed without a soft lockup or kernel 
taint. There was a significant cost, though. The delayed completions 
accumulated into much larger CQ batches:

   - median NVMe handler duration increased from 2 us to 3.1 ms
   - p99 handler duration increased from 106 us to 7.1 ms

For comparison on the same workload:

   fixed 10-us GSIM + timer push: 1.906M IOPS
   adaptive GSIM + timer push:    1.712M IOPS
   threaded NVMe IRQs:            3.165M IOPS
   NVMe IRQ-poll fallback:        4.986M IOPS

So the timer-push idea does prevent the lockup, and the trace confirms 
the multi-source gap issue. On this NVMe topology, however, delaying all 
sources creates very large completion batches, and the NVMe handler 
still drains each batch without a bound in hardirq context. That causes 
the large throughput and tail-latency cost above.

Regards,
Naman

