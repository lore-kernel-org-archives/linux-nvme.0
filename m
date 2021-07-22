Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EACC6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 07:46:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13D06023B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 07:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13D06023B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A0e5D+FM5FfGO6CmGkUbx16v+kbYB+HWFxJKF2gnBD4=; b=SBrQkSNr195kKf
	GQVI0xJOhdAv5D+eGKiE6Xof91XANfed09AcyJnf8/OCcls3lyFAWTZbyqcCpsIZB5tj0jT+XPtOE
	7Ex3n6PBdkVGpBKx7WldjpdhfK+mAwtML1cqhN9XGJJkbWsXD4T/NQzLg5+KPSaM8HKEhICMH0uZo
	anrOOs0hjYk0yvIhWSAo0rad2HKrR8e+UoAE8qQHKwl4HFkV4cJ/HT2s4kp+BZbjfizTNzc0UKa1L
	myEkEeUmDMJays72dDNIBx/mrQU7rPNUlN3cI/MAvRDLkWoFn5i4x3EbYehed6SheHwu2/35uOS8k
	gNQmhN+2oiHsLMW3vVgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6TPU-000ZyH-9V; Thu, 22 Jul 2021 07:46:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6TPR-000Zwy-BD
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 07:46:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DFF7167373; Thu, 22 Jul 2021 09:46:15 +0200 (CEST)
Date: Thu, 22 Jul 2021 09:46:15 +0200
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
Message-ID: <20210722074615.GA2292@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de>
 <20210721072445.GA11257@lst.de> <871r7rqva6.ffs@nanos.tec.linutronix.de>
 <20210721203259.GA18960@lst.de> <878s1zpa28.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878s1zpa28.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_004621_593561_FAED116B 
X-CRM114-Status: GOOD (  15.71  )
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

On Thu, Jul 22, 2021 at 12:38:07AM +0200, Thomas Gleixner wrote:
> That's fine because that's controlled by the driver consistently and it
> (hopefully) makes sure that the admin queue is quiesced before
> everything is torn down after the initial query.

Yes, it is.

> The above can be fixed by adding an 'append' mode to the MSI code.

So IFF we get that append mode I think it would help to simplify
drivers that have unmanaged pre and post vectors, and/or do the above
proving.

So instead of currently requesting a single unmanaged vector, do
basic setup, tear it down, request N managed vectors with an unmanaged
pre-vector we could just keep the unmanaged vector, never tear it down
and just append the post vectors.  In the long run this could remove
the need to do the pre and post vectors entirely.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
