Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DC5C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:50:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C195610C8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C195610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=VA1EqO3CbFyq6AoU65UXZsEGT9aNoERkxBagNdKb8XQ=; b=T9B0xFZRxQXtzgrdXvIdEMwt8
	DK0kg2T9uZnKfZ58HwGosNEWDedVl9WXOU/x5w1nRCesIYedi3orvQ6QsclwWZuOSn0HCO++HAVle
	064LrqhcGYVHO9b26KowphZLytqSBPlTus5dF5t1z00VNFTlCaE0xQKXlGD9jqncMs+i4yfD2l87E
	I2WefQ7Eo+mTaEUP+3J67u6ebZgWJSzULX7Ro+dt/7/kz8pFJZJEtVscYNuU/doG5knsV9RO73LVz
	+3On8k3X0e3QKUjqePXfsKM0hTwD2+Y2BKmhWktf5MD7mo1W0T05UBdHDYqKkWIeNnV728xg4OX7N
	FlDExb6IQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldaq3-00EIYa-SV; Mon, 03 May 2021 15:50:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaq0-00EIYL-TW
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 15:50:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:References;
 bh=ON68OWvJ6ZUQ2JbnSawfbcLEauW7vNC+SBjEwtxAfu0=; b=JtBYFJt1/TNn2rXAxOMGkiQoRD
 DYfIYUsOgIUD5QgjUoHfgFaL8jUW3L7fMreUhoPiQj7QDwSOS5SbSGQKrofMMFuFTojQ7nM6ws+Xs
 tz683K5eLBNe9s9W/Eu72vfk/OBn2qVP0vwkmFXjSPt7PybOF4Z7zskTp7iMP5PFKL74cs6dSIM+F
 HRJNPtZvN6at30pstQqFksCQtmibg/snpjxuobSTWwqn6HRSvRSdy5wW7A0UKYrFsA00orywXs9yx
 ru5J97YZLwwfU5oX48/jRKxpOb048iiossWg++WiNXElVKtMWCWe0VbMFfH/XvYHnMh20BLHVsCmT
 v4yGV40Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldapy-003CRJ-Ab
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 15:50:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DAF2610C8;
 Mon,  3 May 2021 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620057020;
 bh=BMJrILOMBNPtSPtdylpuDTW4a8a4Um/NZx8UjOidZsY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=fGpmG54cqQxDYjdTM4gMFA2C8/nqtmc6LNjSnoTyLcMsf8s9WJAzMAulU0xqVoLmV
 wPsS6P+ac0Yhy2hJ6zQe3zO8xRWRqTOpdUJelTM5bXTKZbMzM2hgUBFfJSFIGLT8vq
 KBQushaeP/LcdkOal0PB0z3GHhEJziTewTYZwBwWdiA2Wmj/gOZjhWf1uMKRRXMqWy
 l0H6BoBt8bqOgXfqiXPd6IlE7q7kqrZ2hMMmQvAxLeY17JQf2MaEdtmAbMSgnda9cs
 85h0P10mh3Bx3TM3wfLChaCl39q+K+62/UH4R5R7VPr9HcnCDFg2AOwHleJlB58vIu
 x+aiUzyIVWy1w==
Date: Mon, 3 May 2021 10:50:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 Prike Liang <Prike.Liang@amd.com>, linux-nvme@lists.infradead.org,
 Chaitanya.Kulkarni@wdc.com, gregkh@linuxfoundation.org,
 stable@vger.kernel.org, Alexander.Deucher@amd.com,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210503155018.GA910672@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210503145702.GC910137@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_085022_423354_F2C2A268 
X-CRM114-Status: GOOD (  19.93  )
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

On Mon, May 03, 2021 at 07:57:02AM -0700, Keith Busch wrote:
> On Mon, May 03, 2021 at 08:14:07AM +0100, Christoph Hellwig wrote:
> > On Fri, Apr 30, 2021 at 12:50:49PM -0500, Bjorn Helgaas wrote:
> > > Patch 2/2 only uses PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND in the nvme
> > > driver, so AFAICT there is no reason for the PCI core to keep track of
> > > the flag for you.
> > > 
> > > I see below that Christoph suggests it needs to be in the PCI core,
> > > but the reason needs to be explained in the commit log.
> > 
> > As far as I can tell this has nothing to do with NVMe except for the
> > fact that right now it mostly hits NVMe as the nvme drivers is one of
> > the few drivers not always doing a full device shutdown when the
> > system goes into the S3 power state.  But various x86 platforms now
> > randomly power done the link in that case.
> 
> Right, and the v5 of this series uses a generic name for the PCI quirk
> without mentioning "NVME".

It'd be nice if somebody would figure out how to cc: linux-pci on
these patches.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
