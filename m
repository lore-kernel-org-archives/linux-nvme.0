Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62302C07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 07:25:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADC060230
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 07:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADC060230
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tkw6x7l9C4xTy9uIVPNC2PwFmIn74Dt0ROt3n/rgo0o=; b=cv8rOmO8Pfra0m
	phXVZR+L04KWZnSitlkhzwJYlaWhLxxwk36gjvGEM0mnBS+oQwZf2ULGyzKHKgZetCIY88lfFecUC
	MUESbDCWcGDiGBL497Y6ss5jmWMn0aRZhYsgNtZLMOhHAWflQaDBd2b8U+dUUWrPf1T6rF9jDEt17
	JxtGF1lRE6hW2wJLVnQXoZ82Zo02ibEZhysdQ+WRBs53VLljFVRo7E3RkTzGB9gLGJjcRUBKy3jqo
	/+zX46HqPiZbIuMLTsQzKqo9b3RnrCZnKVnpNyVL4dsDt6g/ZRYtduQEWMh0Z7yk8oq1NihTA9eH5
	GB1NNE9jvzh9+LWOOzmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m66b8-00Efy3-JP; Wed, 21 Jul 2021 07:24:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m66b4-00EfxC-QG
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 07:24:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B573767373; Wed, 21 Jul 2021 09:24:45 +0200 (CEST)
Date: Wed, 21 Jul 2021 09:24:45 +0200
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
Message-ID: <20210721072445.GA11257@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lf60cevz.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_002451_051626_E3B1533F 
X-CRM114-Status: GOOD (  18.10  )
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

On Wed, Jul 21, 2021 at 09:20:00AM +0200, Thomas Gleixner wrote:
> > Just walking the list seems fine to me given that this is not a
> > performance criticial path.  But what are the locking implications?
> 
> At the moment there are none because the list is initialized in the
> setup path and never modified afterwards. Though that might change
> sooner than later to fix the virtio wreckage vs. MSI-X.

What is the issue there?  Either way, if we keep the helper in the
IRQ code it should be easy to spot for anyone adding the locking.

> > Also does the above imply this won't work for your platform MSI case?
> 
> The msi descriptors are attached to struct device and independent of
> platform/PCI/whatever.

That's what I assumed, but this text from John suggested there is
something odd about the platform case:

"Did you consider that for PCI .."

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
