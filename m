Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6442FC433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 14:57:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4C9611BF
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 14:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4C9611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OB7GDDK55YdI3GfEs2yyU4zFZ79+bwaydiv/91fslPA=; b=d15H+trFk4rQChK+t7s5vSMJM
	FoMuf/R4650HccEMS85jOR2y7Qsxc2pANuacUkzrfVAaB3kp8tlK3Oao/jjtmzLYt37b0Rolqvi7C
	BDW1cFd4RAVR/1VVbpPg7HNZ2tMoHWGJt/dfoTFqBGtWm96z6otD0hNWp3WfVZM6J8wCGMLzzsm4z
	cT6jbm7XC19FRL0ik/trpOnmwIcI5eHshLvceRipMkbE/XyzTCyfzescm24Ury34qLHrrK78MYPbM
	Zc3KkvsTOiycT72quDdkmZAWuyJ27y/dJaEdM9xUBcG8pKlFbCVsh0xbTipwgaID7apGKfHBe9nEy
	MVO439xgA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lda0f-00E8kM-9I; Mon, 03 May 2021 14:57:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lda0S-00E8ia-9a
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 14:57:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=bijCbrqi7N0ef71S/YWP2l5zAPN3wQpbHr1Ty+8pD2Y=; b=bQ0l3rSJuwuDl66KvRRvgYg7XZ
 qkmJ1M8g6Mc8BBP3ZFyDjbS9hRXO3Znk78WkL4LL0zd+KjEuXuEXqhuS47CqmsUCUprT9uhClbBLX
 JtSkoJ9VQFwNrZksumTSjX43FU5weCSK5Eoc2PEJwAGXdN3rTrXTousPceHwafC5N14t9sZ+wRJEp
 VKpVwUvvdO559RsYocJX9K5ivid4/SbU3TjQNpVz+s/SjLJHjMYN+2KnmXMfLcs/mhhDFhJKtspuR
 gJNNMNpn74VAq8SB1BkKn+iyem8i1oy2y+lab9iXo4nJbuslRjnHFVKJhtq6qL7EZnfEHsYYX6Hn8
 rRXbvbNg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lda0P-0039Cx-Jy
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 14:57:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4286361166;
 Mon,  3 May 2021 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620053825;
 bh=p0BJIJlzuPFaUslj6JNmj+oFyieoiT8v0bTQp2hvdN0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L/UA0eyb+02UVZvNL8dDB23AVLWxGfiIjVubVS91qQzH6+tajahryxunpFMfhIbui
 Acspei0n4phlFOCUnWGJw3q1INAIl4/P4IQWDhRo2J41PQdKqD+2apsUZL3GA4/XbV
 IZWmL91YTlF9BdOD5TNihSEoqUZMhEWxlTR/FD99x+rKQakfFQpKDvkB6a0oijZV3m
 2RgDy1te17WFVO1HDGtnX29ULWu2truKh3T19Lo2iH/XxInRtNwr1cIUsCgTjDymNA
 8Xba/zT3COeJssiYrYXNII3loceZHWT1ptbZ/ztCbP6pLVdRGnsN/TFViHuu0ISRb+
 ww02CEda5Nbpg==
Date: Mon, 3 May 2021 07:57:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Prike Liang <Prike.Liang@amd.com>,
 linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com,
 gregkh@linuxfoundation.org, stable@vger.kernel.org,
 Alexander.Deucher@amd.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210503145702.GC910137@dhcp-10-100-145-180.wdc.com>
References: <1618458725-17164-1-git-send-email-Prike.Liang@amd.com>
 <20210430175049.GA664888@bjorn-Precision-5520>
 <20210503071407.GA3521294@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210503071407.GA3521294@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_075705_699275_F173DA24 
X-CRM114-Status: GOOD (  17.66  )
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

On Mon, May 03, 2021 at 08:14:07AM +0100, Christoph Hellwig wrote:
> On Fri, Apr 30, 2021 at 12:50:49PM -0500, Bjorn Helgaas wrote:
> > Patch 2/2 only uses PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND in the nvme
> > driver, so AFAICT there is no reason for the PCI core to keep track of
> > the flag for you.
> > 
> > I see below that Christoph suggests it needs to be in the PCI core,
> > but the reason needs to be explained in the commit log.
> 
> As far as I can tell this has nothing to do with NVMe except for the
> fact that right now it mostly hits NVMe as the nvme drivers is one of
> the few drivers not always doing a full device shutdown when the
> system goes into the S3 power state.  But various x86 platforms now
> randomly power done the link in that case.

Right, and the v5 of this series uses a generic name for the PCI quirk
without mentioning "NVME".

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
