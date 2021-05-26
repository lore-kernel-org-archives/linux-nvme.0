Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC06EC47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 14:48:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0AB613B4
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 14:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0AB613B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+isWiE+vla565AAVEWW0LeKcD6YnLS1MC0QewPd4yjE=; b=J5MWn/4zhJA5z/
	ktTBA7HSPDM9DoYdDEAjHm5IsMnfqSHcX0/3+7OG0kblyMViWnp1hGcWBPmof1Hzn5KY2wAnc3Jyd
	/AfchSTj3uCTxCRULYbRHwJpKAmtfyqqkZveTtfyjIttOoZl0nJdTqsySop4IDzNLpAvXTwq9okKS
	Nf8ODjj+81vlhlP8LTRokfERXQ8x7sZ/EqGqhl/+FHsc8bhTgwdPeTa+sx2IK6cjwu9NsgkVG21NS
	SZG7q6fySTo3VLhqbqUTNEj67tu09rjFQFJN2jgFeYPf7tMrR78O1tqfvNb7mo8vKLuJSMLZdwZBt
	GfcckFggTlsLuplVQifw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llupk-00F3SS-SK; Wed, 26 May 2021 14:48:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llt8b-00EE7M-2c
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 12:59:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0E26967373; Wed, 26 May 2021 14:59:43 +0200 (CEST)
Date: Wed, 26 May 2021 14:59:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Keith Busch <kbusch@kernel.org>, Koba Ko <koba.ko@canonical.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210526125942.GA25080@lst.de>
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de>
 <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
 <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
 <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_055953_326279_35865B58 
X-CRM114-Status: GOOD (  23.64  )
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

On Wed, May 26, 2021 at 08:11:41PM +0800, Kai-Heng Feng wrote:
> On Wed, May 26, 2021 at 10:49 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Wed, May 26, 2021 at 10:02:27AM +0800, Koba Ko wrote:
> > > On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > > > > After resume, host can't change power state of the closed controller
> > > > > from D3cold to D0.
> > > >
> > > > Why?
> > > As per Kai-Heng said, it's a regression introduced by commit
> > > b97120b15ebd ("nvme-pci:
> > > use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.
> >
> > That really doesn't add up. The mentioned commit restores the driver
> > behavior for HMB drives that existed prior to d916b1be94b6d from kernel
> > 5.3. Is that NVMe device broken in pre-5.3 kernels, too?
> 
> Quite likely. The system in question is a late 2020 Ice Lake laptop,
> so it was released after 5.3 kernel.

This is just a mess.  We had to disable the sensible power state based
suspend on these systems because Intel broke it by just cutting the power
off.  And now the shutdown based one doesn't work either because it can't
handle d3cold.  Someone we need to stop Intel and the integrators from
doing stupid things, and I'm not sure how.

But degrading all systems even more is just a bad idea, so I fear we'll
need a quirk again.  Can you figure out by switching the cards if this
is the fault of the platform or the nvme device?

> 
> Kai-Heng
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
