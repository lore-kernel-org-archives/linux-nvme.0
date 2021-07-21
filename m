Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034BDC07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 07:20:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3D860BD3
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 07:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3D860BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QJQ8ZMW+HwKimxNPhbSz/NBqel6NPqn88DOx0QhxuIw=; b=GTxyZgjmB+6B/X
	WG79wrWvM1Qc9/uWlofh/qdSdWjJH9q/6N06+GmPangirFaXlyJiUTc9My6A+CRYBpgtpoxq+3s/a
	N8o9TwPOZ73uizUa0Kc5pGtmspO8JGPl83qSfg6sBHsTt/Y7WIyxlX2Ls3037TwygKA9l5MSFbRJC
	edysurRN8auYhcVrMOB21iNHBtrHGcIDCbktbdXu5XlJm814TV/feyv8w1pUA6iIhhMND0iYi5ANP
	nhq649+ThZGvQtybN6ADs1MM/Ucd4L08nhQ48L7HQwvsHLGehIEJJBojhuZal5pw/kHoLrVnRznmw
	U9vRY2z7J0C5e6oY2ajA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m66WX-00EebS-OP; Wed, 21 Jul 2021 07:20:09 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m66WS-00EeXY-Et
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 07:20:06 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1626852001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14pa5e4ghKE3WxB0dYlBZl3aq8XwaNMqkiThF/hFm4o=;
 b=TALdyTTG2yvh5R1hfCjlcSNfrZ/1yg6DjzkqdboKop7dFX1cs52R0/Rk+PvbnWlnewH6IC
 mNSeecuwh65v1kq3dE7FpO9ZmD8OjbMNme79B+O8XkR9SSyosoUNG5HVd1Ylcyxvm+tJ9a
 5hmMmRKgW8LfKiiCujaWBsvSZDSiYmF4cN3mBbx3MfTCQ7TUt14bkh38sN1sahmSwfyTQg
 5tN+MOKkqwLcInndm8o5n7yMt4onBUstLGpHLX53D+CkNMDR5YMtPJyCh6+zc5yMAfGW4y
 Ag1pscvfxPsE2Scl9tHyxnpLTRt8rpfi87fG2UrwZ7zrOlmhZVM0zRvRl5J6wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1626852001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14pa5e4ghKE3WxB0dYlBZl3aq8XwaNMqkiThF/hFm4o=;
 b=6A5iwEz8jhu64Wy7GB9ySMY1c5O3BUSXx6OXfblT0Xk9RZkrB0/ArkhnHPnIoXHI/EjV+f
 wRs2+sHiArELXoBA==
To: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
In-Reply-To: <20210719094414.GC431@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de>
Date: Wed, 21 Jul 2021 09:20:00 +0200
Message-ID: <87lf60cevz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_002004_693388_D76B3371 
X-CRM114-Status: GOOD (  13.84  )
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

On Mon, Jul 19 2021 at 11:44, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 08:51:22AM +0100, John Garry wrote:
>>> Address this issue by adding one field of .irq_affinity_managed into
>>> 'struct device'.
>>>
>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>
>> Did you consider that for PCI device we effectively have this info already:
>>
>> bool dev_has_managed_msi_irq(struct device *dev)
>> {
>> 	struct msi_desc *desc;
>>
>> 	list_for_each_entry(desc, dev_to_msi_list(dev), list) {
>> 		if (desc->affinity && desc->affinity->is_managed)
>> 			return true;
>> 	}
>>
>> 	return false;
>
> Just walking the list seems fine to me given that this is not a
> performance criticial path.  But what are the locking implications?

At the moment there are none because the list is initialized in the
setup path and never modified afterwards. Though that might change
sooner than later to fix the virtio wreckage vs. MSI-X.

> Also does the above imply this won't work for your platform MSI case?

The msi descriptors are attached to struct device and independent of
platform/PCI/whatever.

Thanks,

        tglx

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
