Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727FAC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 21:38:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CE0207E8
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 21:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eH3+Mz+g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba9s7rmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CE0207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:To:From:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=suZnv3S5ZF/h0b3quUDWfh0lKEqUZFhPBUJzDu+MeDE=; b=eH3+Mz+gJaKEMkBjXcNuhrJ59
	cbG5JIjcA+QtrGD31f3wMINczryV8yMP7kRRIN01ES37R7rv4eumPv9eDCmEV55k8b7EjavXy0k8+
	dDVuERn5t0cfztynfdVybKejeJZ53sz+A1+jK7aNlPqsDdmOjjZFGy6wjWSicdfv5DjeIrFL1BoZ1
	ZuRVHtgx3GKKUcf77fGI6IPTrowpd5rjpCC1goDyx4d8D85rI7t3GzmpVrzcwIHWhYvcvQEry/zvZ
	aGLi1u+t85bYHMVH3MWhhTxLHzWPQPh1KVzFbuu4cXWi1zl/hHXw4GKyVrQGC813vfoLpx4PoRdAQ
	YUJtYsO8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joD5m-0001pm-IM; Wed, 24 Jun 2020 21:38:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joD5j-0001pB-QN
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 21:38:00 +0000
Received: from localhost (mobile-166-170-222-206.mycingular.net
 [166.170.222.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B668D207E8;
 Wed, 24 Jun 2020 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593034679;
 bh=DwNy4a1dTP0cML/NqcYH/mc0n8ghiF4jwJVglyBIYl0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=ba9s7rmGgoLzByJn2FUikabBHUIk7ZVOD7zfHBPMMZBzqYC2iWKiTfku4gKCdXAEk
 Ep15zWtBl7na1pM4n1ksy6It7Sw2shsTNoYfL+d9riHKVqXlk0wTot4m0V5e/fZV3K
 FrYi8MBZSK0nSIUKaclGUgr+R5RV4kMYQxfQa9cg=
Date: Wed, 24 Jun 2020 16:37:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
Message-ID: <20200624213757.GA2591059@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200612204820.20111-2-david.e.box@linux.intel.com>
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, shyjumon.n@intel.com, kbusch@kernel.org,
 bhelgaas@google.com, dan.j.williams@intel.com, hch@lst.de, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 12, 2020 at 01:48:19PM -0700, David E. Box wrote:
> StorageD3Enable is a boolean property that indicates that the platform
> wants to use D3 for PCIe storage drives during suspend-to-idle. 

Is this something that should apply to plug-in drives, or does this
only apply to soldered-in things?

> It is a
> BIOS work around that is currently in use on shipping systems like some
> Intel Comet Lake platforms. 

What is this BIOS work around?  Is there a defect here that's being
worked around?  What's the defect?

> It is meant to change default driver policy for
> suspend that may cause higher power consumption.

I guess this means that by changing the driver policy from the
default, we can save some power?

> Add the DSD property for recognition by fwnode calls and provide an
> exported symbol for device drivers to use to read the property as needed.
> 
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro

There is surprisingly little information in this intro.  The whole
paragraph under "Modern Standby Power Management" is duplicated
immediately below in "D3 Support".  Maybe that's a copyediting error
that displaced useful information.

It says "drivers should go to the deepest appropriate state" so
"function drivers don't have to manage implementation details".  No
doubt "drivers" and "function drivers" is a meaningful distinction to
Windows cognoscenti, but it's not to me.

It talks about "enabling D3" without specifying D3hot or D3cold.

It talks about "D3 support for storage devices."  All PCI devices are
required to support both D3hot and D3cold, so this must be talking
about some other sort of support; I suppose maybe it's a hint about
whether a driver should *use* D3hot (or D3cold, I can't tell).

It says nothing about where to look for the _DSD: on a Root Port or on
the NVMe endpoint.

Bjorn

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
