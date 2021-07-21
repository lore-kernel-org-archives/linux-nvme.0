Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB6C6377A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 20:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81E161248
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 20:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81E161248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ieQpuE8o1eXZi+Kg7i3Vs8CtByJtWG0f7o20qLVk+Fg=; b=tslIuSjS3vWAuk
	17O93aFByaFKWuJxQ8uJIUHds9yMwPUIWt+odVGiT5dDQlqjnHCq+y6CyROBotKK6QQ+xY0+DrwBs
	GbyJphf3q7fMDRdLnVgHrOTg34sPr4QNLHnpj4qceimgsiiYSw6OiBeLJYxju0YSTwPQd9ABBvnG3
	GnUZJJYvxLo3gZ68lNJfhSZLNIXbnS49Pe/ZINAPrF66o7x+566+/S9KWte2kFUwz0RYLe5/3oT4G
	ybrwINY93VRFEscRVH2hrs97bzQq0FXLzYHZJEeAJQzsS8kQGjXADzM+4fNACDKdTg6OHBZx4Mc1R
	MgtmarTMf1vbfEy3vxMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6IjP-00H6jF-RX; Wed, 21 Jul 2021 20:22:15 +0000
Received: from galois.linutronix.de ([193.142.43.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6IjM-00H6i9-Ev
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 20:22:13 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1626898930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13AKBfJpRbWB/hAHCzyxNaRiYHnfqT7SMZklEKL2SbM=;
 b=IZ8vGcjKDv10xjNMxbvG9JXHQONzSs/4lNNhSqj1OtMgkdz3l7Lvm6Rpbiqp3SMOUR9tUI
 eeoitoqe7bYwxX2/g7W2/I41DeaDVbn8G34zxPOe47CwhVPb6SecWtntqacylntcIgYlcI
 Ujs0M4eAeBuegH0FeBSlmv8kqgv5Q9H2c9vRkV7ZsmzuMhcoBDK/jSUpYMFPp2SMq0bfWI
 J0Reg8glcWZEcqigQOTy/k5+A3io6AyYbyM0CRwS9C69XiXREz7EoDIE/kUo++N8+RcG4K
 gv4u8DeLuG5kHz8e7/aeju+0ZV+hc1Nyxh2XTdu9/+jpZzOOLMFNsCZskMORXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1626898930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13AKBfJpRbWB/hAHCzyxNaRiYHnfqT7SMZklEKL2SbM=;
 b=ghlz/kVNYaYUjvjhF4jkU+7xzhPV9t+wujENU+wbeyY5GDazP0D7JYCidPSx2gVdW+I7lL
 bkSzuKI8xSefxaBw==
To: John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
In-Reply-To: <fe34623e-1074-862d-e822-7359ae4def0f@huawei.com>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de>
 <20210721072445.GA11257@lst.de>
 <fe34623e-1074-862d-e822-7359ae4def0f@huawei.com>
Date: Wed, 21 Jul 2021 22:22:10 +0200
Message-ID: <87y29zpgct.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_132212_697847_22ED1CEE 
X-CRM114-Status: GOOD (  12.84  )
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

On Wed, Jul 21 2021 at 10:44, John Garry wrote:
> On 21/07/2021 08:24, Christoph Hellwig wrote:
>> On Wed, Jul 21, 2021 at 09:20:00AM +0200, Thomas Gleixner wrote:
>>>> Also does the above imply this won't work for your platform MSI case?
>>> The msi descriptors are attached to struct device and independent of
>>> platform/PCI/whatever.
>> That's what I assumed, but this text from John suggested there is
>> something odd about the platform case:
>> 
>> "Did you consider that for PCI .."
>> .
>
> For this special platform MSI case there is a secondary interrupt 
> controller (called mbigen) which generates the MSI on behalf of the 
> device, which I think the MSI belongs to (and not the device, itself).

MBIGEN is a different story because it converts wired interrupts into
MSI interrupts, IOW a MSI based interrupt pin extender.

I might be wrong, but I seriously doubt that any multiqueue device which
wants to use affinity managed interrupts is built on top of that.

Thanks,

        tglx

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
