Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C6BC3DA58
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEW1X+U5BoNEleUE5hv+X/J4NG4T3egXeAoPK2sKhcw=; b=tOScdzOIxvq69d6WLiLwne12qH
	ngNOBYXE74oOrC3wBNJ1+88ar2q/M28OOOwMZqaymMSyPBQkIpndHqaUmZQNq1eT/Ui3Id7RGUMO1
	APzLQfFVQAgziN/knBRncvKuv/N+nCbWcNRDnt7CsbhDxPDEeY5pIGRNa1JtyQ7BZ4rDfyGvspQPF
	X3AZJTPgDpCVX4rVamITH38NihdcVDe/nndcRxqM9Ao2mjWUXaorgX7T/yLV5UvYLr/ISDJw02VIg
	3dggPkn8Bqrs5riA8NBoqNjORx2oIzBXREylbSwma1p4lmPAcq8l7vOatSRtOxfws2CfizTB6RQKu
	rH2xZdyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWgn8-006swI-2A;
	Thu, 17 Aug 2023 17:28:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWgn5-006sv8-2y
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 17:28:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 69D5361BC2;
	Thu, 17 Aug 2023 17:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D26BC433C8;
	Thu, 17 Aug 2023 17:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692293290;
	bh=LnZjsJz7EZXeWbPKrmBF1pX9XMVjg1pxfryeZzTteec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RozV1TsWvToEi3lx/ro/Xe9DZER9Qw9kzYusKskWHrURFvw7TdfrMVCw2IDvZPl25
	 wshQrwsWuIxdz+vKdRlhBQHhbaEjL6xh9AnirlGII7tVFOLk+xfwlvscnHlM+hWfUe
	 80EM2BwjZ4ynBVGWA4ogzRHujEf1EeOGGunLLXfi95CzHLtli6KU8+a8nvmqnzlNqv
	 2quhoPb9n7Bc4rfZHaJjOjr+Td0kacwvq0qku6D0/Bs9ncmlfkBSCIts0e2pSqxjpC
	 IeWO/KbuT5Zes/2qYer9IJ5g5uAz04QZZvmLqSuJt/xInTkCDAtbgQ31pK/Z5E9yJJ
	 nHEvSGhQngNlw==
Date: Thu, 17 Aug 2023 11:28:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, hch@lst.de, arnd@arndb.de,
	ricky_wu@realtek.com, gregkh@linuxfoundation.org
Subject: Re: Possible nvme regression in 6.4.11
Message-ID: <ZN5YqPuT0+j8kP3l@kbusch-mbp.dhcp.thefacebook.com>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_102812_047149_54FE53CB 
X-CRM114-Status: GOOD (  27.28  )
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

On Thu, Aug 17, 2023 at 05:16:01AM -0400, Genes Lists wrote:
> On 8/16/23 21:30, Genes Lists wrote:
> > On 8/16/23 17:04, Keith Busch wrote:
> > ...
> > > It sounds like you can recreate this. Since .10 worked and .11 doesn't,
> > > could you bisect the git commits? It looks like it will take 7 steps
> > > between those two versions.
> > > 
> > > I don't think there are any nvme specific patches that could contribute
> > > to what you're seeing, it's more likely some lower level platform patch
> > > if a kernel change really did cause the regression. None of the recent
> > > commits really stood out to me, so bisect is what I'd recommend.
> > 
> > Thank you
> > 
> > Bisect done - This is result:

Sounds like the driver's ASPM suspicion was justified, however the
recommended work-around doesn't appear to apply to this hardware.
Thanks for running the bisect!

> > ----------------------------------------------------------------
> > 69304c8d285b77c9a56d68f5ddb2558f27abf406 is the first bad commit
> > commit 69304c8d285b77c9a56d68f5ddb2558f27abf406
> > Author: Ricky WU <ricky_wu@realtek.com>
> > Date:   Tue Jul 25 09:10:54 2023 +0000
> > 
> >      misc: rtsx: judge ASPM Mode to set PETXCFG Reg
> > 
> >      commit 101bd907b4244a726980ee67f95ed9cafab6ff7a upstream.
> > 
> >      ASPM Mode is ASPM_MODE_CFG need to judge the value of clkreq_0
> >      to set HIGH or LOW, if the ASPM Mode is ASPM_MODE_REG
> >      always set to HIGH during the initialization.
> > 
> >      Cc: stable@vger.kernel.org
> >      Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> >      Link:
> > https://lore.kernel.org/r/52906c6836374c8cb068225954c5543a@realtek.com
> >      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> >   drivers/misc/cardreader/rts5227.c  |  2 +-
> >   drivers/misc/cardreader/rts5228.c  | 18 ------------------
> >   drivers/misc/cardreader/rts5249.c  |  3 +--
> >   drivers/misc/cardreader/rts5260.c  | 18 ------------------
> >   drivers/misc/cardreader/rts5261.c  | 18 ------------------
> >   drivers/misc/cardreader/rtsx_pcr.c |  5 ++++-
> >   6 files changed, 6 insertions(+), 58 deletions(-)
> > 
> > ------------------------------------------------------
> > 
> > And the machine does have this hardware:
> > 
> > 03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A
> > PCI Express Card Reader (rev 01)
> >          Subsystem: Dell RTS525A PCI Express Card Reader
> >          Physical Slot: 1
> >          Flags: bus master, fast devsel, latency 0, IRQ 141
> >          Memory at ed100000 (32-bit, non-prefetchable) [size=4K]
> >          Capabilities: [80] Power Management version 3
> >          Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >          Capabilities: [b0] Express Endpoint, MSI 00
> >          Kernel driver in use: rtsx_pci
> >          Kernel modules: rtsx_pci

