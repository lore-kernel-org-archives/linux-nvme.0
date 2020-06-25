Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4F5C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:16:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422DB206C3
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GhKQv6rH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422DB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qsDkgLajxIBdufdmIq7cXsi4pc/xRZXq6T3SgHuMr58=; b=GhKQv6rHA4kLsgyUkCWQ+53L5
	mdL46XP/NuXBv7fi89BYwA2DXsYPxQCAyoL28XcEcSmonrBqXDPdxWN2yNbspFAJq90WyEEEswlre
	+FYP8KOiOIgsnEETVhoR+aiVvQqVxcqVsUS8DsjXXed7I/MjmKOchOXqS4EzLHp4hRKPeZuuR0wKR
	xQTBd1T7s7V1JfpQtt3bTQTe0DNdW/pDVPMbDJPkj4ywVvEpadSY2yF+buMjg0rLvmELlybfsDhP/
	KxkLfnTjHlBIwg4jBYvjRlNUwtNHxgQwTJ+UFfddG3s4S5fyA8gfdm4mGD1s8m1Adtm2nF5DbmuFs
	f/HrXTgrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joQnu-0000Z9-Pm; Thu, 25 Jun 2020 12:16:30 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joQnr-0000Yc-T9
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 12:16:28 +0000
IronPort-SDR: 8LzpMH18P45iBo3MaUXxjWWdVSxgQCbz7cXBvbIdZViCjv9RDyAjm+oN1cHQAW4cqE+Aquhbr8
 PRnO4RuAHclA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143095113"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="143095113"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 05:16:25 -0700
IronPort-SDR: fWaSgBUWhlXYLDYK3rRqkXWDv/WZioOftV7rDKySVRLs+7vXiUofUwqy5+GSwYHmgPmjB0m7gt
 3ooekk1Ktfcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="479455359"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
 by fmsmga006.fm.intel.com with SMTP; 25 Jun 2020 05:16:20 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 25 Jun 2020 15:16:19 +0300
Date: Thu, 25 Jun 2020 15:16:19 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
Message-ID: <20200625121619.GG2795@lahna.fi.intel.com>
References: <20200612204820.20111-2-david.e.box@linux.intel.com>
 <20200624211549.GA2586552@bjorn-Precision-5520>
 <CAJZ5v0i8dCN=HMFk_+ZX-Wr73P6kdQBtV0i3FtrZrO9cegXsvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i8dCN=HMFk_+ZX-Wr73P6kdQBtV0i3FtrZrO9cegXsvQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, shyjumon.n@intel.com,
 Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 25, 2020 at 01:30:53PM +0200, Rafael J. Wysocki wrote:
> It is not necessary to call acpi_pci_find_companion() from
> pci_acpi_storage_d3() as long as that function is required to be
> called by the target device's driver probe or later.
> 
> Ths acpi_pci_bridge_d3() case is different, though, AFAICS, because it
> is invoked in the pci_pm_init() path, via pci_bridge_d3_possible(),
> and that gets called from pci_device_add() *before* calling
> device_add().
> 
> Mika, is that why acpi_pci_find_companion() gets callled from
> acpi_pci_bridge_d3()?

Yes, that's correct.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
