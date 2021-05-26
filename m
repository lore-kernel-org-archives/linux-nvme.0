Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB145C47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:34:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B0660FEB
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B0660FEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xoLULL10ptHRqLJUbz6eZNURWJgdZdz1wP4jM8LoR/c=; b=xAesCsnHgCOJSk
	isYcOa1ICNydXyDx0bJ49d+/lQ9/XjDr7P29Bx4vcL5a0/4fw5QrasSZpd/IFA8sXqdTOmgDkAPPk
	u/m/WYnRCOpZGV44ACchDQl5C/lMBohll1VvENQl3Xy5vUezJWu9pYpe7E/tO1jeWBk7bVqYzcXs6
	kjwCI/PJ4XD8IcIsDjSs4CrjRXt9gwMlB6TOU7HGijpwoukfQnHlHRR8d6ZDwptZWgU5PEPIGI0Hd
	ayhsBfd0kl7fKUucE+3EenTgue/LwMk6u39DA9pxvHDgIH4eVLDbDGQ9ug+GwlK3Upp5vaxC02p92
	rgsT+4yHpLk/9ok/1KQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llvYL-00FPT9-Ov; Wed, 26 May 2021 15:34:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lluW5-00EsZo-Hm
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 14:28:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6DCCA67373; Wed, 26 May 2021 16:28:09 +0200 (CEST)
Date: Wed, 26 May 2021 16:28:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Koba Ko <koba.ko@canonical.com>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210526142809.GA32077@lst.de>
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de>
 <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
 <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
 <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
 <20210526125942.GA25080@lst.de>
 <CAAd53p4f2ZFsVRv-Q9maPBSD_uGjj7FoYKYy9MGjBPc6chk_1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAd53p4f2ZFsVRv-Q9maPBSD_uGjj7FoYKYy9MGjBPc6chk_1Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_072813_786504_B1A24813 
X-CRM114-Status: GOOD (  17.86  )
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

On Wed, May 26, 2021 at 10:21:59PM +0800, Kai-Heng Feng wrote:
> To be fair, resuming the NVMe from D3hot is much slower than keep it
> at D0, which gives us a faster s2idle resume time. And now AMD also
> requires s2idle on their latest laptops.

We'd much prefer to use it, but due to the broken platforms we can't
unfortunately.

> And it's more like NVMe controllers don't respect PCI D3hot.

What do you mean with that?

> Because the NVMe continues to work after s2idle and the symbol is
> rather subtle, so I suspect this is not platform or vendor specific.
> Is it possible to disable DMA for HMB NVMe on suspend?

Not in shipping products.  The NVMe technical working group is working
on a way to do that, but it will take a while until that shows up in
products.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
