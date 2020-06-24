Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5365BC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 05:47:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD1320768
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 05:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iuLCo/qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD1320768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YFsZfUhcoPgmNzs2cvg8iOinZZoV3RWzK3LUL32+S1g=; b=iuLCo/qxio/um4eiofAMJUvyU
	+G2KXeZK+Df+DaFgD0Smj7J/ehmgg0UAb4K7kuMuedvHeeZAMUwScmIUOq9tznVOClyjRiKXkROLf
	w7lUQ2mRTNgcdVrqbch3E0TRnbaYZy6i1KNPMxHarCrv4vudO/IyDo3rpLfLE6Jo2At1erXQKxoUI
	+q0WdxzfYqnJs3csjplbEVEGwmsYKg62hAEDN2wt3Ufto/D6/g/RoUDfjPJcLRu4cfGFfQ7J5su0I
	7zgJSs3oYB0oP3vbQKhGvpl6fl7bsLD+TjmQOiiMZN6rBaRRoE2V7kxMeXD2CccT8lLaPy2w053Eh
	RqqLZ+IIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnyFi-0003BX-C0; Wed, 24 Jun 2020 05:47:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnyFd-00039p-UI
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 05:47:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7C6FF68AEF; Wed, 24 Jun 2020 07:47:08 +0200 (CEST)
Date: Wed, 24 Jun 2020 07:47:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme-pci: Add controller memory buffer supported macro
Message-ID: <20200624054708.GA17008@lst.de>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623162751.GA4846@lst.de>
 <20200624025817.GC1291930@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624025817.GC1291930@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Baolin Wang <baolin.wang@linux.alibaba.com>, baolin.wang7@gmail.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 07:58:17PM -0700, Keith Busch wrote:
> On Tue, Jun 23, 2020 at 06:27:51PM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 23, 2020 at 09:24:33PM +0800, Baolin Wang wrote:
> > > Introduce a new capability macro to indicate if the controller
> > > supports the memory buffer or not, instead of reading the
> > > NVME_REG_CMBSZ register.
> > 
> > This is a complex issue.  The CMBS bit was only added in NVMe 1.4 as
> > a backwards incompatible change, as the CMB addressing scheme can lead
> > to data corruption.  The CMBS was added as part of the horribe hack
> > that also involves the CBA field, which we'll need to see before
> > using it to work around the addressing issue.  At the same time we
> > should also continue supporting the legacy pre-1.4 CMB with a warning
> > (and may reject it if we know we run in a VM).
> 
> Well, a CMB from an emulated controller (like qemu's) can be used within
> a VM. It's only if you direct assign a PCI function that CMB usage
> breaks.

But we have no idea if a controller is assigned or emulated.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
