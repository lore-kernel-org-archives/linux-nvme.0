Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73915C369A6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NSug0TcHWrdDZTbtTQbZJyR/dNrIGv9DyuwK9XvoeBg=; b=wlQQlIUaPYcW+qe0PHrrXSDdTQ
	+EPxuM1QyUDdIPV515t2lewRl0JM8mrzpsWfxcldK+82lR9QeKeIJZJ1vcWg17pezd8gIiwOR4mm7
	I9FgtmsOviGDeUqL8b7UiKA/3YlldpQqDXJMlbHJrSdMecPd+CQmSiUVsP+q1nsimH7RvFnsn1PbN
	yvGvuC+ARkxvkbIhsPNjniGDS6/Xre7eJ6nuY4qqTxMLuHhWSWr53c9iWVsW53FfeBGgvrcpynx8a
	fIdYSqn3AKPEZYaWEfT6jbMaDBXDQZOo6HypHzxCeyaaozeQ3jtRv77kDM3FFytIWJr42iFWNf3EH
	2O/43brA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2njE-00000009pyM-3yrO;
	Thu, 10 Apr 2025 08:57:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nNg-00000009len-3SKV
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 08:35:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 218E668441;
	Thu, 10 Apr 2025 08:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCDDC4CEDD;
	Thu, 10 Apr 2025 08:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744274127;
	bh=tO6uYCbKfVUhn5Sla9TxgVC0u2rsQmt4MRWROEXVrWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAGygLf9FqNTd/XNg/9adBM0hFo2t48vLMHjY1BGo+Xa1D/h3KWGkapbkNjo04eOH
	 LT2HYMlmRKMeHkjt9bHiZH0acr2kJRwfUbe20G3PoEWhDOtNEh09yFY7abP1ywIQXy
	 0T3D/0SAsgncrPl0in52Rwm80unH+44VRPsbxoGCeS4f6USlMTWjzr4lS8PO/xJg/f
	 nxThO0iUGLq+6Gh7jK/RdmPPV9an/zudfO0i1log7I9W2lJ6znxT/QVDZ3y3qPgnbV
	 i3o9ARPESl7DnwZsIhLzG1ehpYagCk4UmNiWbspc28YGdTJALHPoqJRODXTwQzkyBk
	 KaqCFwbpKTCUw==
Date: Thu, 10 Apr 2025 09:35:24 +0100
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] nvmet: pci-epf: Cleanup link state management
Message-ID: <Z_eCzEon-d4bN2GS@kbusch-mbp>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-4-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408024733.690966-4-dlemoal@kernel.org>
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

On Tue, Apr 08, 2025 at 11:47:33AM +0900, Damien Le Moal wrote:
> Since the link_up boolean field of struct nvmet_pci_epf_ctrl is always
> set to true when nvmet_pci_epf_start_ctrl() is called, assign true to
> this field in nvmet_pci_epf_start_ctrl(). Conversely, since this field
> is set to false when nvmet_pci_epf_stop_ctrl() is called, set this field
> to false directly inside that function.
> 
> While at it, also add information messages to notify the user of the PCI
> link state changes to help troubleshoot any link stability issues
> without needing to enable debug messages.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

