Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED119C6377A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 22:38:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD606120E
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 22:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD606120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GeIKLbQ0d5k988pCsB/87m/3lQ+8tNEre5sRvG2IIxU=; b=pstmb8UgXU0zOQ
	raGk+iKuu3/Cl42rhNGWBuix/Y7igKsB4RQ+tV1DLQ+1rLrzd4c/ngP3prHttZwrcvWs3kYBoIEOf
	UGdpQ8eRy/KyHO2n3Yv1mjG+j0G7b8IFxWLYJ+JLhdqs78pIva44jjc8XU60/3qjdu1D9mCD9QoGH
	l5sQhouEgcwrvnYonuwYyoQDusLqQqTwmsZnv1ayoOq5TUy3YzEDXpo/K+v1/rAWrZs3KiddNwyLi
	10IhmlaBzqo2+QeZqXP5viLd38LsuV8yn4odkkBUGxV6hNDKgIPMUIpnX1TojmbLLujFSqnxx5OcO
	/E6c+0g4+NApxr5Xkjzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Kr7-00HOTz-6V; Wed, 21 Jul 2021 22:38:21 +0000
Received: from galois.linutronix.de ([193.142.43.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Kr3-00HOT5-RG
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 22:38:19 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1626907093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TQLRh+7qGE3VP3wBrZZJmZAEZQxMZFNHuu8FDoGr7e4=;
 b=ppUhdihsnmeHgT0VRBl5aEdERmntnpUGzJB5+6r2tVwqko/N7pm3Q4GLvLTL0dNSfMRfsG
 oODtwJF4ieA/wnsOYYMJAs1mD+NFHv+avmmbGiYmNXY+viV5X3dNFczzCtVYSXR/kh82GH
 AyYg1e356trh5/VaETln7KcZeU4q2rtayTkCC6UK/1NEYgOZV4IKNIQw7h1ZBCjzSvIRDT
 Ue/Jxnvu31y/LXl7t6fQ0XVupJnZbF4BKwK8VgHatCNSt4Gm98IjULU77aBPaKcYbf7zT5
 N+F8RvXwKJX0ULXCIAIln6Sm8if1o3cRFQq8QfeoshKm5l7KioZgOwTKe11zRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1626907093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TQLRh+7qGE3VP3wBrZZJmZAEZQxMZFNHuu8FDoGr7e4=;
 b=FrFj5ZapdfSAF5URVUJzeKUnhZgI5j3n/xmpgAAZ7GRVpjqtPUXOHOvlzIzZ7pcohGxaMN
 bVobF87paNH7rSCg==
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
In-Reply-To: <20210721203259.GA18960@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de>
 <20210721072445.GA11257@lst.de> <871r7rqva6.ffs@nanos.tec.linutronix.de>
 <20210721203259.GA18960@lst.de>
Date: Thu, 22 Jul 2021 00:38:07 +0200
Message-ID: <878s1zpa28.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_153818_073045_5D673E96 
X-CRM114-Status: GOOD (  22.62  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 21 2021 at 22:32, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 10:14:25PM +0200, Thomas Gleixner wrote:
>>   https://lore.kernel.org/r/87o8bxcuxv.ffs@nanos.tec.linutronix.de
>> 
>> TLDR: virtio allocates ONE irq on msix_enable() and then when the
>> guest

OOps, sorry that should have been VFIO not virtio.

>> actually unmasks another entry (e.g. request_irq()), it tears down the
>> allocated one and set's up two. On the third one this repeats ....
>> 
>> There are only two options:
>> 
>>   1) allocate everything upfront, which is undesired
>>   2) append entries, which might need locking, but I'm still trying to
>>      avoid that
>> 
>> There is another problem vs. vector exhaustion which can't be fixed that
>> way, but that's a different story.
>
> FTI, NVMe is similar.  We need one IRQ to setup the admin queue,
> which is used to query/set how many I/O queues are supported.  Just
> two steps though and not unbound.

That's fine because that's controlled by the driver consistently and it
(hopefully) makes sure that the admin queue is quiesced before
everything is torn down after the initial query.

But that's not the case for VFIO. It tears down all in use interrupts
and the guest driver is completely oblivious of that.

Assume the following situation:

 1) VM boots with 8 present CPUs and 16 possible CPUs

 2) The passed through card (PF or VF) supports multiqueue and the
    driver uses managed interrupts which e.g. allocates one queue and
    one interrupt per possible CPU.

    Initial setup requests all the interrupts, but only the first 8
    queue interrupts are unmasked and therefore reallocated by the host
    which works by some definition of works because the device is quiet
    at that point.

 3) Host admin plugs the other 8 CPUs into the guest

    Onlining these CPUs in the guest will unmask the dormant managed
    queue interrupts and cause the host to allocate the remaining 8 per
    queue interrupts one by one thereby tearing down _all_ previously
    allocated ones and then allocating one more than before.

    Assume that while this goes on the guest has I/O running on the
    already online CPUs and their associated queues. Depending on the
    device this either will lose interrupts or reroute them to the
    legacy INTx which is not handled. This might in the best case result
    in a few "timedout" requests, but I managed it at least once to make
    the device go into lala land state, i.e. it did not recover.

The above can be fixed by adding an 'append' mode to the MSI code.

But that does not fix the overcommit issue where the host runs out of
vector space. The result is simply that the guest does not know and just
continues to work on device/queues which will never ever recieve an
interrupt (again).

I got educated that all of this is considered unlikely and my argument
that the concept of unlikely simply does not exist at cloud scale got
ignored. Sure, I know it's VIRT and therefore not subject to common
sense.

Thanks,

        tglx



    
    

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
