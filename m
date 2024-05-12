Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EAAC10F1A
	for <linux-nvme@archiver.kernel.org>; Sun, 12 May 2024 06:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJak6izOLdXcT5b2TZaAlyg3uKMUWQPMlJ+3t6Ownik=; b=Ke4QWtGh1HLhS38RzKN31SqoLz
	Y65h7xnV5BwJBXSAONZ46f63WTXnAi3Um3af91QkA/fTy/5I/5yhGqXzaIQTIhmlmMaSjx4xBNTfs
	FNnNcNDDTamvjeg5yzy0NdPlS3lgWGjl6y2e3Tm5n7bXdaJboKGhgXnbwbW+A+w2AzJgvGcBmf5PL
	8ei6PbKtOLrEiqH+zkyrEKHctOtcwRhepzqFQeWRuWeSjw243qAa7W24pDh6rrCrhRkaz17RtLYY9
	yGBPUNG1slR4QzKpmM/bBPONUj3dLF6NJs2HjYH7ba9x4lYpbUkYoW+zQnQiRK6x1wv0eK++yj7oZ
	A/1TK8gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s62oY-00000009QSl-3egf;
	Sun, 12 May 2024 06:36:06 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s62oU-00000009QRa-1JUZ
	for linux-nvme@lists.infradead.org;
	Sun, 12 May 2024 06:36:04 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715495756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJak6izOLdXcT5b2TZaAlyg3uKMUWQPMlJ+3t6Ownik=;
	b=gOcJeskN/2y0z/zGSs1nmmCHx1/0DqBNDcf97/2kgXfnb2qnRUtv/jKClMYVJ4CLHQIQ6w
	NDbGdHDbiYDAPft3fzwe1tS9RVC6/25qoIF3b80vsxHD1Vtmj3Lq2p1ZiDkyzg4anCftJP
	QilpQgDSqctPPrOdgE3MFA6b5iB3Q3jICaYzLHrXM4szdzJ4kBnIbZtAvfzmj5xUuL78n0
	Td+coWZRwtqCEzwv7/Wz0C0A5HW/b/SLTgfY2PmQDqwZyiKMFEZG6C+pCMcAsjF0ShocpD
	jg0DBGik3J2PWbqw8VVKrORSamjUna9CL54lAzLvh9785m7glEYh1vpda+YnFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715495756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJak6izOLdXcT5b2TZaAlyg3uKMUWQPMlJ+3t6Ownik=;
	b=24AKP5h2uBsPJidtVpL1o9LyJp+cc2J4nSHdY+ggiissoreeUu6SAxuSlPUGl8nI0cD3aM
	1NE3YuiWVgmRIyBg==
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
In-Reply-To: <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com> <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
Date: Sun, 12 May 2024 08:35:55 +0200
Message-ID: <87r0e7mt9w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240511_233602_528976_2F07D39D 
X-CRM114-Status: GOOD (  13.32  )
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

On Fri, May 10 2024 at 18:41, Keith Busch wrote:
> On Sat, May 11, 2024 at 07:50:21AM +0800, Ming Lei wrote:
>> Can you explain a bit why it is a no-op? If only isolated CPUs are
>> spread on one queue, there will be no IO originated from these isolated
>> CPUs, that is exactly what the isolation needs.
>
> The "isolcpus=managed_irq," option doesn't limit the dispatching CPUs.
> It only limits where the managed irq will assign the effective_cpus as a
> best effort.
>
> Example, I boot with a system with 4 threads, one nvme device, and
> kernel parameter:
>
>   isolcpus=managed_irq,2-3
>
> Run this:
>
>   for i in $(seq 0 3); do taskset -c $i dd if=/dev/nvme0n1 of=/dev/null bs=4k count=1000 iflag=direct; done
>
> Check /proc/interrupts | grep nvme0:
>
>            CPU0       CPU1       CPU2       CPU3
> ..
>  26:       1000          0          0          0  PCI-MSIX-0000:00:05.0   1-edge      nvme0q1
>  27:          0       1004          0          0  PCI-MSIX-0000:00:05.0   2-edge      nvme0q2
>  28:          0          0       1000          0  PCI-MSIX-0000:00:05.0   3-edge      nvme0q3
>  29:          0          0          0       1043  PCI-MSIX-0000:00:05.0   4-edge      nvme0q4
>
> The isolcpus did nothing becuase the each vector's mask had just one
> cpu; there was no where else that the managed irq could send it. The
> documentation seems to indicate that was by design as a "best effort".

That's expected as you pin the I/O operation on the isolated CPUs which
in turn makes them use the per CPU queue.

The isolated CPUs are only excluded for device management interrupts,
but not for the affinity spread of the queues.

Thanks,

        tglx

