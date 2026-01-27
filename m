Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284D7D3409B
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZXrpZKQXaU/1Ckne42Oll7rDq0/j0IQ56gVhjard9XQ=; b=rrT+NAoITPs5FvaPpM1qx1tsjo
	ZiziUkSmBwSieKn1LkyO4yRtSxFWVyW5RYM5sXV7BIKnlA1c8c3U4xIQi2EBJcDeDChqDLB/PitWF
	2t//QK493/dbwmlT9mGQ0ks7kCKOiRnbWPc4GreFTpN5/pqW9J9a1J55c0+PZBY4pQ4oedsPMVEiX
	W7mxK0NbaAAp1lkLY0GROk/FSAX7jVd9bbpKkuwWnpaAKRbCp34dTfeMhEqYCrw+fIP7C51iey4Fe
	AqrWCw+wsmL9NsrtCNYHYrBuCWKah5T4khOPfPZSVdJj7YQUXXm6PhWFs3qj3+2Uq+82rvHhfSKNL
	UeGWV5Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vklan-0000000EbnY-0L4r;
	Tue, 27 Jan 2026 16:07:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vklak-0000000Ebmt-3RHa
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 16:06:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A655B43DE4;
	Tue, 27 Jan 2026 16:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B927C116C6;
	Tue, 27 Jan 2026 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530017;
	bh=Ed38Dl8CI/Hm8sRCM7qr4Vg5xUwP5AbrQhaovrDFylE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrC9EgHFRgNeLJwoXqJYl3fSEv7QwOiam/ZDzDPjoaDSpqzrVSQRDKMtnOm6V2dJ6
	 SIDTE3zprhQCOXpDfjsfht41dAiXH86lfC9SgIgak4ZnJYvexPrSEqqGwpSzldxNNN
	 qHd9lmE97ln+Ln/l6MXxq39CDaANhmOlwgfhzW0i31NHisRMTZz3NQI8Uy35PkHz8h
	 QcgHcXf5Nu5AW9OHcgVMpsWi8IAE4O5Xoc8KR0boFbtIgJdbEuYz5gzbHyY7DIW8qZ
	 ehbkdlOUEiohFIojUR/67qdlC+xZWuxxRInNsObdmU8aTmhaCEfyFUftVTA+2y05nr
	 tIiy4wMHC/iFQ==
Date: Tue, 27 Jan 2026 09:06:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Qinyun Tan <qinyuntan@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <aXjin6e18UxcTpQz@kbusch-mbp>
References: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
 <20260127084807.GA342@lst.de>
 <20260127143143.GW13967@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127143143.GW13967@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_080658_874919_54F31C65 
X-CRM114-Status: GOOD (  14.67  )
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

On Tue, Jan 27, 2026 at 04:31:43PM +0200, Leon Romanovsky wrote:
> On Tue, Jan 27, 2026 at 09:48:07AM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
> > > The NVMe PCI driver exports the sriov_configure callback via
> > > pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
> > > VFs through sysfs. However, when the PF driver is unbound, the driver
> > > does not disable SR-IOV, leaving VFs orphaned in the system.
> > 
> > That sounds dangerous.
> 
> It is not. In a real SR-IOV device, VFs are created by the hardware and
> are independent of their PF. There are several use cases where an
> operator unbinds the PF and reuses it to improve overall device
> utilization.

If this is expected, should the warn message "driver left SR-IOV enabled
after remove" be downgraded to 'info' level?

