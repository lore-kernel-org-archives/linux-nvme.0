Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA952C369C9
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 19:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2rcakngKZkuxgAbImCH5Q6X7O2GpYMQmJfxlxzA876M=; b=mqS1n89Cd3aGgHzai8VMkx8nGh
	lt5X+iJnbRheQPNh+1r4wQUjU9wJNBXdTfyWMvjHnVug9cwppeAU2+Bon7dhc7bKWMULraRsgRESj
	HlFGw5yuazXnDyGMd9Qg0cK7O448BIRKKInwW5VjCF2sKxXI5GWTIGEIm0Gzwi812akQAvGwtmlq3
	vKrfeeulpDbyza7OUzxWS+yGF1HDGAq786miJnb8LaShchX9orm4yXjqz0nydqKsfOJYxooqixJ5W
	/OILS7WDErG6YZLGe0IN1uq0Vgb4KXnq0TyR4nv6CWJCzehm00MPrJMS9Lt1/gM1RZvcssi9vHRZF
	wJQSvgOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5VAK-0000000EDQV-2Iar;
	Thu, 17 Apr 2025 19:44:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5VAI-0000000EDPU-1Hp8
	for linux-nvme@bombadil.infradead.org;
	Thu, 17 Apr 2025 19:44:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2rcakngKZkuxgAbImCH5Q6X7O2GpYMQmJfxlxzA876M=; b=H6HLro1DzhxXxg+yMCkGvWsFmk
	yoeB0JnT0k+Vgqv4jX05RHhkUHHLaGEBFw+NyceGNOFj2VbCW93BCK3KfoYf4CBlusp3qt4plbBdf
	eA7LcCjmHDJ09CZ7ElJ6YWPme+E4mII4+4GnizylxG+qHiNiglMjRCogyREK5yeAQGsGEjlgZFz3W
	9JnLLvUol6KHRaybQo9xpXwC+YdOfzl8EeeF3gZ5NU7nHgDaPb0ULY/1NMpp4xlqdFr8nSxn56/at
	k+xObl7ZkrIvMBa5hn/g056A0JaG1CmvKLVfiaalazX2I91e5U1M6Mi3lL9VDe9zudLqIQRodH79H
	Lv9etAtQ==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u5VAF-0000000AORn-1AKE
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 19:44:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9AC4E5C548A;
	Thu, 17 Apr 2025 19:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A59C4CEE4;
	Thu, 17 Apr 2025 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744919083;
	bh=jlZjNYB5FpKHo4zQL72q+4Rlor5HBrA2MfEQbAHgw5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGq6+Hozuqdri7npQnUJzef0Wo/IQYBfcaffXKVicCWXuSpdJ1FxIA6Iem32hSXCu
	 ZdbAnHjFqC37MWcQPBSQrcZIntuFht7UAc4Z6SaqE+2cl3wIGVeEayFnjf0OMeL4K4
	 4pdvTYKvUqQnwyhQJFmAO5Q15XPLTWnYNbfEojhAYVKeN3PqJj/OvYrWUbB6WtfFIJ
	 uR7FLprPiXN+Y+AE5lMI1UFg2RUpTYxA+pYUzZGVBGG9hJun3dA2h9fDpe4W/UCCLn
	 dPGyznr8nEPDNgC7BKkv2RzzSgcvDYkqdLKJ4+VFphng82SlM75lQ3fg6Ab5FVvkS0
	 y13dO+W6rD64A==
Date: Thu, 17 Apr 2025 13:44:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: DMA pool lock contention
Message-ID: <aAFaKM4cQrsgMz4K@kbusch-mbp.dhcp.thefacebook.com>
References: <CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com>
 <aAFF1b6Zld-Jln8j@kbusch-mbp.dhcp.thefacebook.com>
 <CADUfDZoYtDWyhXsN8C26OzAaU-RzzBW5+mGNf=sHWbYTFoTeoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoYtDWyhXsN8C26OzAaU-RzzBW5+mGNf=sHWbYTFoTeoA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_204447_566871_096FE4B4 
X-CRM114-Status: GOOD (  12.41  )
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

On Thu, Apr 17, 2025 at 12:27:43PM -0700, Caleb Sander Mateos wrote:
> On Thu, Apr 17, 2025 at 11:18 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Thu, Apr 17, 2025 at 10:06:11AM -0700, Caleb Sander Mateos wrote:
> > > Hi Linux NVMe folks,
> > > On a 32 KB NVMe passthru read workload, we see 2.4% of CPU time is
> > > spent in _raw_spin_lock_irqsave called from dma_pool_alloc and
> > > dma_pool_free.
> >
> > Just curious, do you have multiple cpu NUMA nodes here? Or do these CPUs
> > share a last-level-cache?
> 
> CPUs from 2 NUMA nodes. Half of them are hypertwins of the others, so
> the contention isn't quite as bad as it otherwise would be. Just
> making the DMA pools per-NUMA-node would help considerably.

Cool, I was hoping that was the case. I measure some contention, but
it's not as bad as what you're showing. I only have a single socket for
my test machine, so same L3 cache for all CPUs. Let's try a dmapool for
every compute NUMA node for each device.

