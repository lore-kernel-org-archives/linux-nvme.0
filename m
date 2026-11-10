Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9F606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=awSMEb1d;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G31UKzFt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m/I3u2DIcuWXKQ1Qo8rwF6DEUqXpIQH/9/2v0i4WFaw=; b=awSMEb1dTn+P7lEAJKB8RizVPT
	dPZsWMyi8WCkZd01pjA2hLBn2bGrPqRzPVLk+LM8RjTPaNzkgVm9KEuio1FBq5VrTwuira5UAbJEv
	tsa7hAAcBRQHfsirMD1vDktQ/B8tgievS0+gKuqMeJuFw3yg5dViDEo0YJfY5qDzNujS98Ow5h6lL
	4VeQy1gQvgUV5ayqi8umQ8v3+HJgCW/XUMwLmfSWBCVgBalVssvJmb28NlL4wZTUAb8EhOVvcAihz
	eBUwfruKpC2HdSJE7Cac5buBUhKnrqqilNEHbPOdl7KGypepHwAJKRFwM+xP/eTbrMB6+2fydy/jx
	qLgVIO1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQvTE-00000005FtG-1OOq;
	Tue, 10 Nov 2026 23:41:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQvTC-00000005Ft1-1tPI
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 23:41:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 75E9360CF9;
	Tue, 10 Nov 2026 23:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6165C1F0093C;
	Tue, 10 Nov 2026 23:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354101;
	bh=m/I3u2DIcuWXKQ1Qo8rwF6DEUqXpIQH/9/2v0i4WFaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=G31UKzFtI/faUuneUGXzHgUw1C7od2JUH+tqw/0q4HOplmgemS2fyuwH3RUv5WgpR
	 59tPNWKH7j7zrD2mpHu+Hlp1k/r5q0/+7eamwyoC3QKUAmrAJEckQ8tFT91Zhst9R6
	 96LGFfzbWOfZ+2ZQEEXkKEjWmZUYDEL+TS2p02nm+6tLK892S6LKCJnU9QFsGxnhSr
	 n6B6oJ+B6BTWuBppDyEhUvyGTKU7mBj3uhg9YGaDP05t3aYflVQ8WZcVhJdZHBcS/i
	 smF5X6ZNBcrN676lC9VznuJ8XKqnnujfiRr9lIqzQIqd+a4rl88fPg6Qp8BYhFEnjX
	 QKg7vNSKwCVYA==
From: Thomas Gleixner <tglx@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, maz@kernel.org,
 lrizzo@google.com, hch@lst.de, changfengnan@bytedance.com,
 namjain@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, Vidya Sagar
 <vidyas@nvidia.com>
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
In-Reply-To: <avHxSog2_rsJKGUy@kbusch-mbp>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com> <87wlqpwukt.ffs@fw13>
 <au-DcqwAz2wmmOne@kbusch-mbp> <87o6c0wbo4.ffs@fw13>
 <avHxSog2_rsJKGUy@kbusch-mbp>
Date: Wed, 11 Nov 2026 00:41:37 +0100
Message-ID: <87o6bwtfta.ffs@fw13>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09 2026 at 09:14, Keith Busch wrote:

> On Sat, Nov 07, 2026 at 10:53:47PM +0100, Thomas Gleixner wrote:
>> On Sat, Nov 07 2026 at 13:00, Keith Busch wrote:
>> > This is done on purpose: pci_msix_write_vector_ctrl() already has the
>> > same offline check, so nothing actually gets written, same as before.
>> >
>> > And regardless of whether it's offline or not, we have to set the
>> > PCI_MSIX_ENTRY_CTRL_MASKBIT in the cached msxi_ctrl. That's common to
>> > both paths, so it lives in the noflush helper to avoid duplicating it.
>> 
>> Indeed, but that's an unreadable mess TBH.
>
> No disagreement there! I was just going for a minimal diff, but we can
> refactor a bit on the way. I'll take a stab at it.

Yes, please. The minimal diff approch is what creates the most problems
down the road.

> I also don't really get the rationale for putting the check in
> write_vector. The commit message says the checks are to avoid having to
> deal with errors, but posted writes don't produce errors, so not sure
> what it's actually guarding against.

To me the explaination made sense and there were no objections within
month from any of the people involved. I'm not a DPC (or whatever is
involved) expert. I just work here.

I've Cc'ed the author of the patch for you as that might be a better way
to answer your question, no?

Thanks,

        tglx


