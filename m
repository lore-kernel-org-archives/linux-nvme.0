Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E8FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:55:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BB620644
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iGimwIm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BB620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UzpeMc85skcTf+NFfC2r4elCB3h7cifuRArdpmBtwfg=; b=iGimwIm7SgyhecxY202mYlfgC9
	3lzokAFaFNxIUYLNcdpFlFQMkaeXoUQDOBPM1/k6h8xYq2Ngrx4bqtbfswLyER49hLzaZNnCXNssI
	rVQFfWImQa0CM5HRAuEdg4/a0LSCXqNVYspFU+ybC5eUTZgNgbSeo9sWESD0O/sAQgAlkNrdZgwbl
	g7o5e3uxqAGccxmq28O/IYCreTd2QNWBrfWReeSYQS+OkK61pVYkQzJS4XtwBy7+tlMiQGTxH3NiU
	RrgyJqeVnID4KGSiXN39SfE+KS2smD76JNRaRek4OiTN/3K5O+PudBLUasxvWK4OaHKM561ZIMIWg
	FhYFbp5w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joAYA-0006Qs-FF; Wed, 24 Jun 2020 18:55:10 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joAY7-0006Ox-1A
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 18:55:07 +0000
IronPort-SDR: Ct1Tx1OXB7W/wPZZtEbh3iA5q/DXPzppjGxB16oAV4rqZKNVs5x30NoZ5QRiz/rTMSQt3wn8PS
 0OUrlCfJn+8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="206124111"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; d="scan'208";a="206124111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 11:55:04 -0700
IronPort-SDR: aANov6vjSZGZtORqh4D03erAF1CDI6QmLcOFKgsk2+UG6alKTWdnmcBssRFT9bmvXPZYPwMFTs
 UiQr4ybHUO5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; d="scan'208";a="385254827"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2020 11:55:04 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.7.201.137])
 by linux.intel.com (Postfix) with ESMTP id D77E65804D6;
 Wed, 24 Jun 2020 11:55:03 -0700 (PDT)
Message-ID: <12d36fdcdbcf438dd3aac7769e8366afd9d5aa1a.camel@linux.intel.com>
Subject: Re: [PATCH V2 0/2] nvme: Add support for ACPI StorageD3Enable property
From: "David E. Box" <david.e.box@linux.intel.com>
To: shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
 bhelgaas@google.com,  dan.j.williams@intel.com, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de,  sagi@grimberg.me
Date: Wed, 24 Jun 2020 11:55:03 -0700
In-Reply-To: <20200612204820.20111-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200612204820.20111-1-david.e.box@linux.intel.com>
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
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Friendly reminder. Thanks.

David

On Fri, 2020-06-12 at 13:48 -0700, David E. Box wrote:
> This patch set implements a solution for a BIOS hack used on some
> currently
> shipping Intel systems to address issues with power management policy
> decisions concerning PCIe NVMe drives. Some newer Intel platforms,
> like
> some Comet Lake systems, require that PCIe devices use D3 when doing
> suspend-to-idle in order to allow the platform to realize maximum
> power
> savings. This is particularly needed to support ATX power supply
> shutdown
> on desktop systems. In order to ensure this happens for root ports
> with
> storage devices, Microsoft apparently created this ACPI _DSD property
> as a
> way to override their driver policy. To my knowledge this property
> has not
> been discussed with the NVME specification body.
> 
> Though the solution is not ideal, it addresses a problem that also
> affects
> Linux since the NVMe driver's default policy of using NVMe APST
> during
> suspend-to-idle would lead to higher power consumption for these
> platforms.
> 
> Patch 1 provides a symbol in the PCI/ACPI layer to read the property.
> Patch 2 uses the symbol in the NVMe driver to select D3 as a quirk if
> set.
> 
> Changes from V2:
> 	- Export the pci_acpi_storage_d3 function for use by drivers as
> 	  needed instead of modifying the pci header.
> 	- Add missing put on acpi device handle.
> 	- Add 'noacpi' module parameter to allow undoing this change.
> 	- Add info message that this is a platform quirk.
> 
> David E. Box (2):
>   PCI: Add ACPI StorageD3Enable _DSD support
>   drivers/nvme: Add support for ACPI StorageD3Enable property
> 
>  drivers/acpi/property.c |  3 +++
>  drivers/nvme/host/pci.c | 14 ++++++++++
>  drivers/pci/pci-acpi.c  | 59
> +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h     |  2 ++
>  4 files changed, 78 insertions(+)
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
