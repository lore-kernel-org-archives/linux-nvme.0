Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D0C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 07:15:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69A5611C0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 07:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69A5611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G4ftmWgL7zOdk27++f64g1oi6E8bagSqOowegSdI9iM=; b=RasDdn9K1/JE4R2TSJnQ2QgXh
	jk7p3uYU3KUXQX94DYSl5WnfS/8psnzabK8CBHUVAegf8AwbgrFiVGOIrVy6KUv3wJNx3lmm7b3Zn
	AMkwwDv7xOhonfJDZGm7SuaiCM3J2sgz6Bvqk1ZzXccsUIU3umtX8Na8WkloeR7AWB1CTho+/Mnvq
	VrORKumDBSpo3/PPfdH3A59fVaKmtJFz5nZjajAVGEuRx16Uqu/ARfKa3LQJ3K9SJ7kx/3pQMRmFK
	0hDpUJNNIPGGnjyddV5uwYn/8FvcOwBYWrOdyLrLTK/nqfUMpVhr8XMtW/f3uzR520AoqCk2/T/4t
	0xAFuUa/w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldSn3-00DMGK-SX; Mon, 03 May 2021 07:14:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldSn1-00DMGC-Sd
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 07:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=r3+bWFuh6BpobiX0nzWuylFbflLXDf37EtMjaGp93GE=; b=TLNC+76DerQfr/NL+2m7X/GSER
 uNvBpEDWThVt7XndOm7XxJHHjrELSCVyxrDDCIgHtY+U44JkKEk6s1/hX9mc0GO85CncaylbYfapK
 PzncFH7m2X8m+rx4bGhLefPDykOQM35bXTwQh0AXYIhBS74AUF9okmR29HxdR+imqnFU5+NV0wJXb
 dGYX6LzrgT67gSMyVQvtZid7xH5nv9H4w4WTkpWbV/aDxJ603s74JY3P52KKyMf5Gh1u7LlBmXtRy
 YyrXFXEe54aCiIlMAtU0H+974rld9xfgr4oUGdPN/dh37bb3RLrb7bV8CZ3AMMIEHATJOOdls386r
 Tu1bP3Jg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1ldSmN-00EmJz-7Q; Mon, 03 May 2021 07:14:14 +0000
Date: Mon, 3 May 2021 08:14:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Prike Liang <Prike.Liang@amd.com>, linux-nvme@lists.infradead.org,
 Chaitanya.Kulkarni@wdc.com, gregkh@linuxfoundation.org,
 hch@infradead.org, stable@vger.kernel.org, Alexander.Deucher@amd.com,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210503071407.GA3521294@infradead.org>
References: <1618458725-17164-1-git-send-email-Prike.Liang@amd.com>
 <20210430175049.GA664888@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210430175049.GA664888@bjorn-Precision-5520>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Fri, Apr 30, 2021 at 12:50:49PM -0500, Bjorn Helgaas wrote:
> This needs to be cc'd to linux-pci (I did it for you this time).

I did ask for that before.

> Sorry, I can't make any sense out of the commit log.  Is this a Root
> Port defect or an NVMe device defect?

It is a root port quirk, although it appears to be intentional as Intel
is doing the same thing on some platforms.

> Patch 2/2 only uses PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND in the nvme
> driver, so AFAICT there is no reason for the PCI core to keep track of
> the flag for you.
> 
> I see below that Christoph suggests it needs to be in the PCI core,
> but the reason needs to be explained in the commit log.

As far as I can tell this has nothing to do with NVMe except for the
fact that right now it mostly hits NVMe as the nvme drivers is one of
the few drivers not always doing a full device shutdown when the
system goes into the S3 power state.  But various x86 platforms now
randomly power done the link in that case.

> 
> I have not acked this patch.  Please don't merge it before clearing
> these things up.

I would never merge PCI core changes that haven't been reviewd by the
maintainer.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
