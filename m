Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA332C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 22:09:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE032084D
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 22:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TNpdlixz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE032084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0WrJTZrJ/jap/t4gyIMGNCjqavvjgKxiXGrCAJRSgk=; b=TNpdlixzpDsAPPL1PpjQ48UKJf
	nlQ5MimEnXkbFxRNLTK5RZhPMNyidn+E1K8ch/EDdc+G48bCTb/CpALurIc0oP1jAz/SfYWXhdgo3
	TaMkHUiLJaVBNQvjrTRFXjikKTeRY4n9HcA498nSp+OX6OkpuKay2PCrzEcMBQztvtwV/APE1++tW
	KCR2Fc/C57dp2+NDrNATERuTSGaqrNKBpO6BjkcwqC59ig9Yb8lMhOIb0vFY939weCHcPGwTUJ9NJ
	Jqw0U4uXTykbTYjTwXGNRc2uCpmgBI1kyN5bgbrNOz/q96i/qJU4fgnu2T1hs8Z1A9666onahrsLX
	R/IN5zEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joDaN-0002rO-PV; Wed, 24 Jun 2020 22:09:39 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joDaJ-0002pC-NL
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 22:09:36 +0000
IronPort-SDR: p7PA9WZWA+JWFJ/whq6oHo9uiJhbJyztMR9fgb7KhfDl7bcHyzqxCUh9B4A7giN7crKw0K/bj7
 7FjmmQoJYMQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="209788106"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; d="scan'208";a="209788106"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 15:09:33 -0700
IronPort-SDR: 2SVh1mImTky8qw5v7uYe5jrIaRPakYHkCi8Im1bR39HTfEeR3VgDSbz4g1c+CN5zo5qWIASHQL
 HnQ1YZlUUXvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; d="scan'208";a="275836573"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga003.jf.intel.com with ESMTP; 24 Jun 2020 15:09:33 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.7.201.137])
 by linux.intel.com (Postfix) with ESMTP id 8C58C5804D6;
 Wed, 24 Jun 2020 15:09:33 -0700 (PDT)
Message-ID: <e980bc2959b5a959bddfa63adb35aeae8261ab06.camel@linux.intel.com>
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
From: "David E. Box" <david.e.box@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 24 Jun 2020 15:09:33 -0700
In-Reply-To: <20200624213757.GA2591059@bjorn-Precision-5520>
References: <20200624213757.GA2591059@bjorn-Precision-5520>
Organization: David E. Box
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
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
Reply-To: david.e.box@linux.intel.com
Cc: axboe@fb.com, sagi@grimberg.me, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, shyjumon.n@intel.com, kbusch@kernel.org,
 bhelgaas@google.com, dan.j.williams@intel.com, hch@lst.de, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2020-06-24 at 16:37 -0500, Bjorn Helgaas wrote:
> On Fri, Jun 12, 2020 at 01:48:19PM -0700, David E. Box wrote:
> > StorageD3Enable is a boolean property that indicates that the
> > platform
> > wants to use D3 for PCIe storage drives during suspend-to-idle. 
> 
> Is this something that should apply to plug-in drives, or does this
> only apply to soldered-in things?
> 
> > It is a
> > BIOS work around that is currently in use on shipping systems like
> > some
> > Intel Comet Lake platforms. 
> 
> What is this BIOS work around?  Is there a defect here that's being
> worked around?  What's the defect?

> 
> > It is meant to change default driver policy for
> > suspend that may cause higher power consumption.
> 
> I guess this means that by changing the driver policy from the
> default, we can save some power?

Yes. Maybe 'work around' was a poor choice of words. 'Getting around
default driver policy' is the issue. There is no hardware defect. One
of the uses of the suspend-to-idle flow is to support compliance with
increasingly tighter energy regulations. One of the ways to do this on
desktop systems is to power off the ATX power supply during s2idle and
use the 5V standby rail for self refresh and other low power needs. But
the platforms that support this can't shutdown the PS unless PCI ports
are placed in D3. On Linux this won't happen with NVMe drives because
the default driver policy is to use ASPM (NVMe APST) during s2idle.
Windows has a related concern. So to 'get around' the driver choosing a
policy that will result in higher power consumption, they implemented
this _DSD to inform the OS of its preference for D3 on the PCI port.

David


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
