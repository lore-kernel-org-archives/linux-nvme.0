Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C36BC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 02:58:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C75320874
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 02:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1xUT/1p6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2wQWPkcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C75320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F7ULbeTbX0mjayAbZP1CWdCh96Nk0ifMF+IZJQJBHtM=; b=1xUT/1p6aDBw15Q8Uuv4zbU/e
	5qfNMNJAkTDXNGYzrN7BaR7b9/2Aqi1Y/PWROyPTNwb5EIGkqqbU6eoZG4M90rVRigKGUM14JapDJ
	elpL/Pkv0Ypf0/qMI0ayWoW2pyrOUfwAB58OyDiOraSzJOoIL9p5bfX6ih9hIMlHtlqbXyvyGMvZR
	UfHZCXTTFLePSR+M2ITsdneKOm8SOQxLlerp7G/RkZ9y1E/dqJ42TtePflwG8PKUL26cmA4TFMLlD
	5ztkb9R+f37ahWQgzk4g724poITksQkxfxUY5/wct4eKlb82cPDsCKqbuFJhUCyVIe9GInDVT3Rdk
	IHuG7OF8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnvcZ-0004z4-Fh; Wed, 24 Jun 2020 02:58:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnvcD-0004xX-DE
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 02:58:22 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 45DC320874;
 Wed, 24 Jun 2020 02:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592967499;
 bh=mCGxMz5JRutifyW8eb22QKPlYT5lYUCRi0U6QOFPEo8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2wQWPkcjjQnenLVYjOK70XdZ/+IoYk9ARNizFA0WZrpofzP+mwQyrS/9CAM4kUc7H
 /wT3DwcPFHr84HhyLjAsRV6Ji2p9LVirxsNMvXNAXTkspK1+cG5STeu/SIFVPFrXer
 IubGHumJLVBBNe0fhjOJoLUYW/9wVuO4FJT4Nm9E=
Date: Tue, 23 Jun 2020 19:58:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] nvme-pci: Add controller memory buffer supported macro
Message-ID: <20200624025817.GC1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623162751.GA4846@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200623162751.GA4846@lst.de>
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
 Baolin Wang <baolin.wang@linux.alibaba.com>, baolin.wang7@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 06:27:51PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 23, 2020 at 09:24:33PM +0800, Baolin Wang wrote:
> > Introduce a new capability macro to indicate if the controller
> > supports the memory buffer or not, instead of reading the
> > NVME_REG_CMBSZ register.
> 
> This is a complex issue.  The CMBS bit was only added in NVMe 1.4 as
> a backwards incompatible change, as the CMB addressing scheme can lead
> to data corruption.  The CMBS was added as part of the horribe hack
> that also involves the CBA field, which we'll need to see before
> using it to work around the addressing issue.  At the same time we
> should also continue supporting the legacy pre-1.4 CMB with a warning
> (and may reject it if we know we run in a VM).

Well, a CMB from an emulated controller (like qemu's) can be used within
a VM. It's only if you direct assign a PCI function that CMB usage
breaks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
