Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5D2C83F17
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Aug 2023 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5DqmEc/FX/P+lcCR70f8LkIeHEIRHTdDQ2F7hhsMmf0=; b=ebpvXfBE+ekS+g+h69povpG+NA
	32a2DOERzX4rt8DtBCiYG7O3Ht8HSTi7p1JgLIVT2Q6TRrZweFgCCZqQ0sncD3/uQGN5L5Zq677iD
	9QDTR3F+xLvP3sr87d8fyQqN+IZfjZuKOexw/A9RXsrB4jxC6DPcWYpT6+EFphcgl3XYjNldcL0Xt
	yy/K/AkrRDveUZ7JmRIMef+9ZT/I+maO4P6gIFJ0xOJKpq+bIF9uv+DgQKX0/vK2hu8bb4uYDaeUt
	zAwAqEtIFs5o7o/rsNs5zWy1US+X3moozepe2mNh8ZhST/uXjK47eaITA0A1pT3bPAVNQj3fdgGTm
	f5Y28WOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbdaR-00EvKT-0c;
	Thu, 31 Aug 2023 09:03:35 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbdaP-00EvIp-0l
	for linux-nvme@lists.infradead.org;
	Thu, 31 Aug 2023 09:03:34 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1693472609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DqmEc/FX/P+lcCR70f8LkIeHEIRHTdDQ2F7hhsMmf0=;
	b=hschOS8pFrS8BxfZyRmLmeNkCrKn61a6PjP7cP2iRhqW01gm2/ffKPnFc69zBB83B6dfyD
	p0B1cUzxOWAkMSLA+4pmRqW0lf4sILwDqMuEQOS5QiKYfZSVSLiGpSGczUPu8bCAJSfFOb
	L+JIeT2GcHxVZ0vmHiVqKykRT6wfQydr5Dar0LGTI5AxuFNBmDFccgiG02HXaR76X3HaN5
	6tAcfCFRjYwP323nMYWJnWKorRJpdrY/rbtFNNaCHrQ+VN+MgXotkKO5IJ92Yu/65YXe5O
	kweLhfsJqhdlLnfpbLDx4PByLcvVjHVVh1SD+kbcz+Y4ae4qfrhmFJFFSwHlZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1693472609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DqmEc/FX/P+lcCR70f8LkIeHEIRHTdDQ2F7hhsMmf0=;
	b=wGvNhW6kQAjCGvpRjzaPw3AFq5CZfF5xsWNZOKUeExtca5ekTeP+TyUFKUfku98vahY6+y
	+MrCDltFAqcmUgDw==
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Keith Busch
 <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang
 <guazhang@redhat.com>, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH V3] lib/group_cpus.c: avoid to acquire cpu hotplug lock
 in group_cpus_evenly
In-Reply-To: <ZPBLy41y0NQTJ6Bw@fedora>
References: <20230818140145.1229805-1-ming.lei@redhat.com>
 <87edjk5st8.ffs@tglx> <ZPBLy41y0NQTJ6Bw@fedora>
Date: Thu, 31 Aug 2023 11:03:29 +0200
Message-ID: <87zg274m8u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_020333_409592_C85D4DB8 
X-CRM114-Status: GOOD (  12.81  )
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

Ming!

On Thu, Aug 31 2023 at 16:15, Ming Lei wrote:
> On Wed, Aug 30, 2023 at 07:44:03PM +0200, Thomas Gleixner wrote:
> There isn't difference compared with holding cpu hotplug lock, because
> the cpu hp state is always changed even though cpu_present_mask isn't
> updated with the lock.

Updates to cpu_present_mask happen with the cpus lock write locked:

acpi_processor_hotadd_init()
  cpu_maps_update_begin()
  cpus_write_lock()
  acpi_map_cpu()
    generic_processor_info()
      set_cpu_present(cpu, true);

The only CPU mask which is lockless race free accessible is
cpus_possible_mask because that one is set up at boot once and never
modified afterwards.

> And all CPUs are always covered during the spread, the difference
> is just that it is done in 1st stage or 2nd stage.

I'm not objecting against the approach per se. It just needs proper
documentation why this is correct.

Thanks,

        tglx

