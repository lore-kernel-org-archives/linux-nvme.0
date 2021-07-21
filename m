Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA26DC6377A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 20:15:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7709460FE7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 20:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7709460FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ngMPPARN8xKUb81+YXD7rKobeLZ3s9MkXkNOf1llKDo=; b=1desLzifEI1L0p
	AXasItkRSKrYl44qSh24vfyRBw076JPiQwX3NSFfIMVG5WPTMA1dSWrncIwN1aWKaZBo8ls5AKFFq
	PMxVvQq1iCfw7PzJmxRaRiJIg3UkeAB8X52CwqzQwiCcXJOvGAmNP8YqAwRXHGsoeClfby9GgubRP
	0hxv1WdWijSiquqmO3c/PF9hDam0zd2gC9GgplqgFr9ei5DWjrmTPbhUr2IwEnnb6L51Pksa267Ix
	Xu/JH/xrde6Qxa48tiGN+XVpszBN3pwlR1dIhavgkfX+C+elB1wwHRPhzsvwC/kf6ubtPsUn0DLF2
	xma/FJPq4v03Oy71JGaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Ic9-00H5b8-AU; Wed, 21 Jul 2021 20:14:45 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Ibu-00H5Yt-4k
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 20:14:32 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1626898465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ak+Uz43ZCaKXyDfbDB4j2Tp/dhk7l2jrFbDe0ZeXqe8=;
 b=vVaCphZ/jjIrDSH1QTS7rs6NyR5B0Ujii1SubrsFPHXLn+QIQzFjgkzYTpOIXa+px6gD/n
 4nI5KvVtN36fMSJAm+55kRDNNseodmKhGi2jyj4qb/7p5CyJeQqfZ8DSeYuKpaChbe5MS2
 S+mIohlnzf7AwnCGGQwMc+M3Y1mkxx6Jh6obdSjb4Y39FdoY7FMySyeLefpXzkJrkhv/nL
 me7MkFb1iPhqRFQoEJ7PjKtJ7rIFY2c18bJuIQJbgyMMjwX2ObgzAZZkxdD5sASUgvrWL+
 iTMJqAT7yZXGZion8cRVyfbb0j4219BMrVbN3U18XWyvpISwDTFtJMBIOFN81A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1626898465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ak+Uz43ZCaKXyDfbDB4j2Tp/dhk7l2jrFbDe0ZeXqe8=;
 b=XCIdlprRE3sr0wL5gMBZtUbRE+wbS41wXwE+yCmyf3noZk6JUIUaUb0jMMrOyCc00BmY10
 NFogrSbcr1D42gAw==
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
In-Reply-To: <20210721072445.GA11257@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de>
 <20210721072445.GA11257@lst.de>
Date: Wed, 21 Jul 2021 22:14:25 +0200
Message-ID: <871r7rqva6.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_131430_374976_52B56B81 
X-CRM114-Status: GOOD (  16.94  )
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

On Wed, Jul 21 2021 at 09:24, Christoph Hellwig wrote:

> On Wed, Jul 21, 2021 at 09:20:00AM +0200, Thomas Gleixner wrote:
>> > Just walking the list seems fine to me given that this is not a
>> > performance criticial path.  But what are the locking implications?
>> 
>> At the moment there are none because the list is initialized in the
>> setup path and never modified afterwards. Though that might change
>> sooner than later to fix the virtio wreckage vs. MSI-X.
>
> What is the issue there?  Either way, if we keep the helper in the
> IRQ code it should be easy to spot for anyone adding the locking.

  https://lore.kernel.org/r/87o8bxcuxv.ffs@nanos.tec.linutronix.de

TLDR: virtio allocates ONE irq on msix_enable() and then when the guest
actually unmasks another entry (e.g. request_irq()), it tears down the
allocated one and set's up two. On the third one this repeats ....

There are only two options:

  1) allocate everything upfront, which is undesired
  2) append entries, which might need locking, but I'm still trying to
     avoid that

There is another problem vs. vector exhaustion which can't be fixed that
way, but that's a different story.

Thanks,

        tglx

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
