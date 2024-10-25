Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2ABD0C602
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iyPEnjk/+Id3YXK0Fu1giew6Cpa4UbwP8VKwFmttOmk=; b=F3aT3okn/IjA6wA+PSiCKvbRMr
	yRRLP7UKQE0Z4SfGzK1NPGcAps+KOldr4d3+meaLKvLH0b5b84hmQh5O1XEfOOd1qpi4KsjpBbALW
	21CqWPAEGU3KInb6f8XFevtVGOYaKssuYDOTAGNd7REZ2of06JLeuAAA8vEVWXGlPMl/2G36+e80v
	lSFUufs9PtLofdhotByrOwDsFBhH5DSEhJjaAYRtF06awzTAVDHQCyqlsAwT1eYSw3pqDmdq3EzNd
	ICBXlQS9ztqPg8MnfoTQkBxHIUBpPbbqT4b4vanndyvVwhK5f7BZ2jfJGfZMXmpGCbQ4dXj0pkH3G
	tyTewMtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4IyB-00000003aeJ-3yb0;
	Fri, 25 Oct 2024 11:59:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4IbJ-00000003Wnh-3isB
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 11:35:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FE37227A88; Fri, 25 Oct 2024 13:35:20 +0200 (CEST)
Date: Fri, 25 Oct 2024 13:35:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
Message-ID: <20241025113520.GA19521@lst.de>
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_043530_105172_62B31437 
X-CRM114-Status: GOOD (  18.32  )
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

On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
> before the platform can reach S3-like sleep states. This is very much
> similar in nature to the issue described in [1].
> 
> Other Qualcomm platforms we support upstream require more complex code
> additions across both the PCIe RC driver and other platform-specific
> ones, before the link can be sustained in suspend. Hence, they
> effectively need the same treatment for now.
> 
> Force NVME_QUIRK_SIMPLE_SUSPEND on all Qualcomm platforms (as
> identified by the upstream bridge having a Qualcomm VID) to address
> that. Once the aforementioned issues on non-SC8280XP platforms are
> addressed, the condition will be made more specific, with a PID check
> limiting it to only the platform(s) that require it due to HW design.

The NVMe driver is the wrong place for this, it needs to happen in the
core by making acpi_storage_d3() evaluate to true.  Preferably by
actually setting the right ACPI attributes because a check for 
PCI vendor ID absolutely will never do the right thing in the long run.


