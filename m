Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF6C6377A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 20:33:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC0061003
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 20:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC0061003
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j7R6gz5lsgnB6jv1yxJO50d+4imHLFJHuDaNt1UBpao=; b=bZJCi4hS6/ESz/
	yRQIUcIQEay89MtQSFM5qJYACzOHC6TgXT0seNaDwlVvziU11SPDCwKXUmXfM2F3HxLdgvTkXZCSF
	dcwFNvWD33fCM71OlBrYPuI7ciN9DFt81p6/wexys5Iev2BqwWwSS+26SaNm19pQ0SFFW5+X61xlS
	LkUfTMEfpDwEIUvJA+m0ojpaLpLvEg/ApZveHRXY42CwTrHJRROp+4/nqCjOYUjOAkZ2MdnptRzVL
	z3fB7BOAOahWRSNu2ozyWd+J+MY3we4VF9FCV5fLlbKDxyDKZz4q69d+881v7taJgofj7udw5Q+FJ
	zCPJwyRCM45qLXzTV5hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Ity-00H80w-7a; Wed, 21 Jul 2021 20:33:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Itt-00H7zY-8l
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 20:33:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 691A967373; Wed, 21 Jul 2021 22:32:59 +0200 (CEST)
Date: Wed, 21 Jul 2021 22:32:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity
 managed if any irq is managed
Message-ID: <20210721203259.GA18960@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de>
 <20210721072445.GA11257@lst.de> <871r7rqva6.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871r7rqva6.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_133305_504307_91C146B1 
X-CRM114-Status: GOOD (  17.96  )
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

On Wed, Jul 21, 2021 at 10:14:25PM +0200, Thomas Gleixner wrote:
>   https://lore.kernel.org/r/87o8bxcuxv.ffs@nanos.tec.linutronix.de
> 
> TLDR: virtio allocates ONE irq on msix_enable() and then when the guest
> actually unmasks another entry (e.g. request_irq()), it tears down the
> allocated one and set's up two. On the third one this repeats ....
> 
> There are only two options:
> 
>   1) allocate everything upfront, which is undesired
>   2) append entries, which might need locking, but I'm still trying to
>      avoid that
> 
> There is another problem vs. vector exhaustion which can't be fixed that
> way, but that's a different story.

FTI, NVMe is similar.  We need one IRQ to setup the admin queue,
which is used to query/set how many I/O queues are supported.  Just
two steps though and not unbound.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
