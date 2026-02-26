Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3CCFD8FF2
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tvVikujb5LBT7G0+3aCDOpQLlcsdzME8GMGhdw0HXjs=; b=yxfWfUiyp09xit+6uuv1qEE39A
	xQWrEMq+ctOlY4OCPip5xMt8JSkZPDnNBJJ3yg5e+hx3ToidFlVAT2XWdt63QXrBrk/iMihJCs/+m
	KMhh0Phdhi3WTM7Q+abjyjt9QGF09ZhRWO/1YZY5dpxGGqRK+1YICQ+wWf33cBxrVE3IfTJ5c/q+o
	UWwSTr7m/sR6aZ9viVlEQnI9O9WVthTjBn6qvJa+MwnI4OIAVlXiLAlE03c5OuyRG3cB+cZRQFu/H
	9rYs10L6O18V0+KngoODWh+xzAjJZlXkfN+b3wxJgnqbufiI2xC7b8BrmCYKL/wkAvBPk07mAXFNA
	AU3Tn6Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvftU-00000006wDj-2Hma;
	Thu, 26 Feb 2026 18:15:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvftS-00000006wDM-0r8g
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 18:15:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6401343A62;
	Thu, 26 Feb 2026 18:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C39C116C6;
	Thu, 26 Feb 2026 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772129721;
	bh=MEpTSyjNRJ1W/nhZpu80wpvFIoWLaZGQNhVRqRoIJIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQCJVlF56ElQbLw0Amw24fH3uaB/IhI++rV66xhuKkiNWed1UDzN4vhKbXeWVjpwU
	 S60EeAZBiZ1MhjUvr9CsS8m88MRnDwNtMkHQKANwWkiZtZDbCsC95qQ4WgVVekHtQv
	 URyKkwrvKDWZ9CZcyiVStalXpqVJIu6Ag5wuDuI8I3AXEsRfPzPTxu9AoKiRtArmyJ
	 pz1X8pxhj74a0LKnYNoJ3kPhtV3MQAavzuNggTfsjp3Iud+Ijn294gJDnsMBNcztDz
	 ckIn4VVDxVeJ9hQwaj57zghiPn/i9os9THVForBKs6vwkq26NEonlYYwXcT3GqpW5i
	 pZmROTL5AH0sw==
Date: Thu, 26 Feb 2026 11:15:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>,
	Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de, hare@suse.de,
	chaitanyak@nvidia.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	James.Bottomley@hansenpartnership.com, emilne@redhat.com,
	bgurney@redhat.com
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
Message-ID: <aaCNtpPzP9TIDNjE@kbusch-mbp>
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp>
 <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_101522_284833_6C7AB65A 
X-CRM114-Status: GOOD (  13.26  )
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

On Thu, Feb 26, 2026 at 11:35:15AM -0500, John Meneghini wrote:
> It's worse than this.  Yes, in RHEL we carry out of tree patches to tun off the async scanning with SCSI,
> and we reverted this async namespace scanning patch in NVMe.
> 
> We had to do this because, as soon as we turned these async scanning mechanisms on, we immediately
> received customer escalations. Customer were not able to upgrade their systems. We have customer issues
> and complaints open about this and we see this async namespace scanning as a barrier to adoption with NVMEe -
> especially with NVME-OF which tends to have many more Namespaces than PCIe.

Sounds like some people just don't know how to use labels or persistent
names. Relying on /dev/nvmeXnY or /dev/sdX to always be a handle to the
same device is a fragile solution.
 
> And yes, the PCIe async discovery stuff does cause some problems.  The difference is: the PCIe bus configuration does
> not change nearly as often as, e.g., the nvme namespace configuration in a fabric, so customers don't notice the changing pci ids.
> Unless some one is going lots of hot unplugging and plugging with their PCI bus, the PCI ids typically don't change at all.

It's not about the PCI topology changing. The async probe makes it
non-deterministic as to which PCI device is going to claim which
instance out of the nvme ida since they all try to run concurrently.

