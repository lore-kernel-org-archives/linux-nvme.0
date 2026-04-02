Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD1D39439
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwrBn0MM36ml3NMuCzWd/m89P37wcag8vmF/9UbXMcQ=; b=W0l2d7lULxGAC8Yokuj6codium
	3O27vL4DpN+k/S6YUAI9zfd/pe0TlCIDrKMjkfV8DXbq6YuwXFkCP49HIp+ZOHJRgPzCHSWAqoTCp
	jdVVpXPXXGi7CGvVDN/22lJCVBvO3PFpFi6bzcCDohyW/MTz+HI4861o7SWMVtaZ+LVyVbLmNfXbn
	cquRA2Fq8/GWtiBQcRmhsu4bDg1l7c1M2OKF/bgrdr+naKYQAr9OZRVamWzqe6OldF8Nm6J6YMn45
	R4vqIjM1ItqmAgmBQcJgirnokJvQe+d2KZxLWFbKlS+vEEjm4NC8+6YX25stSXf7XleR3WYg9hauu
	kQK8nx8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Iot-00000000GV6-28hi;
	Thu, 02 Apr 2026 14:14:51 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8E3e-0000000HE5N-1mG2
	for linux-nvme@lists.infradead.org;
	Thu, 02 Apr 2026 09:09:47 +0000
Date: Thu, 2 Apr 2026 11:09:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775120983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fwrBn0MM36ml3NMuCzWd/m89P37wcag8vmF/9UbXMcQ=;
	b=odde0n62hjn9LZuq2B/dNwt9vUJZXCyajd+XWvOnXWmMaFGfXUE69bDf4leWPam241E+Uo
	+t41Oorwn99laL8GawIlMBvyPAbCTIGh0H2AUKz00FIWozPRG019it7jkX8/Ire+WLTsc+
	MGkmMskasKYO/5jh4zdm0Wc6bePiqfI/eNq2qyPIjv8eEvy984XIYnxDEKDs9rnmXk1o0w
	pa2PYrA1InqHqmCkp/yzbOh8y1YPrIPL9sWcgxzyrS4uoVYs81UxfG3u+yPmEHirc/pDRo
	jHZqmkz992BIVJYTKebOathyOPxUjscWc4RX4+zhXMHAcUsxLoHvYJo8zu+hMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775120983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fwrBn0MM36ml3NMuCzWd/m89P37wcag8vmF/9UbXMcQ=;
	b=jWPcQeevqgP+QitjhXQzSifCfojusGMWduLoSkX24XZKzhrOV1MXsOOvAlCQ9Xy22O+9/K
	7W5PFVNeWP3iKtBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org,
	longman@redhat.com, chenridong@huawei.com, hare@suse.de,
	kch@nvidia.com, ming.lei@redhat.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v9 09/13] isolation: Introduce io_queue isolcpus type
Message-ID: <20260402090940.5j0WmVX_@linutronix.de>
References: <20260330221047.630206-1-atomlin@atomlin.com>
 <20260330221047.630206-10-atomlin@atomlin.com>
 <20260401124947.-d4D5Cr-@linutronix.de>
 <c7phvlvohdn2ksc2jymxk5foolwlqaqq2jzcdv7oic4uzomh3j@yjimbwcnnst3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7phvlvohdn2ksc2jymxk5foolwlqaqq2jzcdv7oic4uzomh3j@yjimbwcnnst3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_020946_629977_AB0BCB66 
X-CRM114-Status: GOOD (  25.28  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 07:14:40 -0700
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

On 2026-04-01 16:58:22 [-0400], Aaron Tomlin wrote:
> Hi Sebastian,
Hi,

> Thank you for taking the time to document the "managed_irq" behaviour; it
> is immensely helpful. You raise a highly pertinent point regarding the
> potential proliferation of "isolcpus=" flags. It is certainly a situation
> that must be managed carefully to prevent every subsystem from demanding
> its own bit.
> 
> To clarify the reasoning behind introducing "io_queue" rather than strictly
> relying on managed_irq:
> 
> The managed_irq flag belongs firmly to the interrupt subsystem. It dictates
> whether a CPU is eligible to receive hardware interrupts whose affinity is
> managed by the kernel. Whilst many modern block drivers use managed IRQs,
> the block layer multi-queue mapping encompasses far more than just
> interrupt routing. It maps logical queues to CPUs to handle I/O submission,
> software queues, and crucially, poll queues, which do not utilise
> interrupts at all. Furthermore, there are specific drivers that do not use
> the managed IRQ infrastructure but still rely on the block layer for queue
> distribution.

Could you tell block which queue maps to which CPU at /sys/block/$$/mq/
level? Then you have one queue going to one CPU.
Then the drive could request one or more interrupts managed or not. For
managed you could specify a CPU mask which you desire to occupy.
You have the case where
- you have more queues than CPUs
  - use all of them
  - use less
- less queues than CPUs
  - mapped a queue to more than once CPU in case it goes down or becomes
    not available
  - mapped to one CPU

Ideally you solve this at one level so that the device(s) can request
less queues than CPUs if told so without patching each and every driver.

This should give you the freedom to isolate CPUs, decide at boot time
which CPUs get I/O queues assigned. At run time you can tell which
queues go to which CPUs. If you shutdown a queue, the interrupt remains
but does not get any I/O requests assigned so no problem. If the CPU
goes down, same thing.

I am trying to come up with a design here which I haven't found so far.
But I might be late to the party and everyone else is fully aware.

> If managed_irq were solely relied upon, the IRQ subsystem would
> successfully keep hardware interrupts off the isolated CPUs, but the block

The managed_irqs can't be influence by userland. The CPUs are auto
distributed.

> layer would still blindly map polling queues or non-managed queues to those
> same isolated CPUs. This would force isolated CPUs to process I/O
> submissions or handle polling tasks, thereby breaking the strict isolation.
> 
> Regarding the point about the networking subsystem, it is a very valid
> comparison. If the networking layer wishes to respect isolcpus in the
> future, adding a net flag would indeed exacerbate the bit proliferation.

Networking could also have different cases like adding a RX filter and
having HW putting packet based on it in a dedicated queue. But also in
this case I would like to have the freedome to decide which isolated
CPUs should receive interrupts/ traffic and which don't.

> For the present time, retaining io_queue seems the most prudent approach to
> ensure that block queue mapping remains semantically distinct from
> interrupt delivery. This provides an immediate and clean architectural
> boundary. However, if the consensus amongst the maintainers suggests that
> this is too granular, alternative approaches could certainly be considered
> for the future. For instance, a broader, more generic flag could be
> introduced to encompass both block and future networking queue mappings.
> Alternatively, if semantic conflation is deemed acceptable, the existing
> managed_irq housekeeping mask could simply be overloaded within the block
> layer to restrict all queue mappings.
> 
> Keeping the current separation appears to be the cleanest solution for this
> series, but your thoughts, and those of the wider community, on potentially
> migrating to a consolidated generic flag in the future would be very much
> welcomed.

I just don't like introducing yet another boot argument, making it a
boot constraint while in my naive view this could be managed at some
degree via sysfs as suggested above.

> 
> Kind regards,

Sebastian

