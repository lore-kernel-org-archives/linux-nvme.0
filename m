Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAF4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 22:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=AhcIX6U4JcTV0pwzQmC8puPVjTlgCtD1hN78zoTQEW0=; b=GTpgxZwa2JEmnp
	t9yp2EbIrGO2ml3cW3tTsAgRUxETML3nJdH0bHh1DTwu0Te0wF0LHm+iERGfO7m0gQcCOD3otEXpq
	5oZAO5OwEvMqK5ZHk6rkp7scmDX6mzCI+gtPt+FJsqaow8O4fIJ9RQfc807cTAILCmkiY0gr3KoWc
	EJpt87C545af/MqSkeHliESizUmCPXlClos4OCMkK2gKDxNg9EFOs9GcjbX4GGw16ylqlxw3ym723
	s/lgZmhtBYbuparOOtDVIIVP7VMij5IqollRedkiVRysBygobT/bVW6kMrmUtV9PbarjwIqIRLGPb
	vIrJ4bOcS7jbY89hPEQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDvkd-00DnQ4-7w; Tue, 19 Jul 2022 22:31:35 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDvka-00DnNL-2X
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 22:31:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B629DB81D99;
	Tue, 19 Jul 2022 22:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2EFC341C6;
	Tue, 19 Jul 2022 22:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658269889;
	bh=xBsNiIMMI61ZsRhK57QPnpQXFAF/uUru2IBPm5xDOok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GbLLdxnBasZ3J/VmbW+T8dRYdw9CQMZkQYGqgazvzzSFoSto0ODn6h90z31OnWSgE
	 IYFjNcrZtInWYCrGCb4dupQxh4o93Vo9XI7Deoi4eVAzVjFX2eYR/D9FPaIT8IpXMY
	 WA5y4i0cyPtbyvQEv4cma09lCLZppj2WiWn7u9DM7csbuDCBxSWBt6ypmiU11VHU0A
	 l41argqGFJ1/+1oC/xX9HDvKLBFd12G5/TRW/9A/ZLwKTXezANSisqTJgFx/JLWxUu
	 0jEisI4+5ths/C8bOTQ4Kt8NrGWWr7qR9IMMDZ105T4slXJrWtw2jJGJrA8eYKPsOC
	 kHskSWaoqzN+g==
Date: Tue, 19 Jul 2022 17:31:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"mstowe@redhat.com" <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Xiao Yang <yangx.jy@fujitsu.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <20220719223127.GA1585747@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719045036.h273puvs3cibafix@shindev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_153132_294463_708AC7A6 
X-CRM114-Status: GOOD (  27.60  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 19, 2022 at 04:50:36AM +0000, Shinichiro Kawasaki wrote:
> On Jun 15, 2022 / 17:16, Keith Busch wrote:
> > On Wed, Jun 15, 2022 at 02:47:27PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> > > > 
> > > > Yeah, this WARN is confusing for us then it would be valuable to
> > > > test by blktests not to repeat it. One point I wonder is: which test
> > > > group the test case will it fall in? The nvme group could be the
> > > > group to add, probably.
> > > > 
> > > > Another point I wonder is other kernel test suite than blktests.
> > > > Don't we have more appropriate test suite to check PCI device
> > > > rescan/remove race ? Such a test sounds more like a PCI bus
> > > > sub-system test than block/storage test.
> > > 
> > > I'm not aware of such a test, but it would be nice to have one.
> > > 
> > > Can you share your qemu config so I can reproduce this locally?
> > > 
> > > Thanks for finding and reporting this!
> > 
> > This ought to be reproducible with any pci device that can be
> > removed. Since we initially observed with nvme, you can try with
> > such a device. A quick way to get one appearing in qemu is to add
> > parameters:
> > 
> >         -drive id=n,if=none,file=null-co://,format=raw \
> > 	-device nvme,serial=foobar,drive=n
> 
> Did you have chance to reproduce the WARN? Recently, it was reported
> again [1] and getting attention.

I have not paid any attention to this yet.  From what I can tell, the
problem was discovered by a test case (i.e., not reported by a
real-world user), it is not a recent regression, we haven't identified
a commit that introduced the problem, and we do not have a potential
fix for it.  Obviously it needs to be fixed and I'm not trying to
minimize the problem; I just want to calibrate it against everything
else.

> [1] https://lore.kernel.org/linux-block/4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com/
> 
> -- 
> Shin'ichiro Kawasaki

