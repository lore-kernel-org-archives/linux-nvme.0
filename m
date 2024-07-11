Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B12DC3DA45
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uiPq7m02mjPluCaEwTIkmhKrXv+SK6TWNTz82SwD5CY=; b=lg9x1BF/i9XapvW2E4wIZJBI1f
	IiQNlN6JKQLgAKsW/im6LInN2+YGBO3ChtA1Rd8sjfuPn9gECLfzl2GgUboewSHHYCTmQV5ds9ej7
	axG/861RWXBb5oXTfwzzNRBtOvRQhHx5racSibCWFZvb8pV0UuyZ/aJkLjc9Aa01vBQ8tCsXSrscU
	jJZHnscnDToGP9Q9O6KEd33+NE5sA9GFxhdICvhQC+n0bbjTukUVzu+QBhG5f+SJ5EdiJFAacL5IL
	CXbiIYhY5TSkNJqA97jhdBY21WZCPT3m/m1X0SSemdWw5ke7JOMOZMyAVV4IVyKlHaagFnDewBi4G
	RFiDSZBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRz2b-0000000F8VH-2Zjm;
	Thu, 11 Jul 2024 19:01:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRz2Y-0000000F8TW-33DC
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 19:01:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8ADDDCE18BB;
	Thu, 11 Jul 2024 19:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7450AC116B1;
	Thu, 11 Jul 2024 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720724470;
	bh=qcFPOJM+DBTB2vrWraDzE8ICBBd0WeOlnpHBi0Ddias=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKLoaEM9Hec0IvL3DM8BeJc/oXf3+kKpCvxaVcyZT+VlEj8rIeOU7rh3DYPWd0KDf
	 oY4t3c5uTYsarv3ph16LpZm1XdGXWeOxjs5+3rt7QZ/Q7RVbTs5SxQYswgdDRUmYoR
	 IuGJ+lFX7WvCkhQhgk3ODT9jMpiDZwUrIkmHxo8Ruc2AFr+4dYwW+wy0R9QWAT5/fn
	 blWhsvuTBVZr5raICAdbq+YC3TTyxAnbXE8o9UjASVGvy6SA1ElZ588+F4ViD2FbZH
	 CPXvt9C66t8AxqvyppFRZNR+iYLPU3PRZU2xhK2zVeyxCrLKyUu4Xr2Avl0nEBVFLQ
	 DA0J5DUG/3xsw==
Date: Thu, 11 Jul 2024 13:01:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvme-pci: Fix the instructions for disabling power
 management
Message-ID: <ZpAr89uectd_fTzV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240710231805.10481-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710231805.10481-1-bvanassche@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_120114_959318_376B8B62 
X-CRM114-Status: GOOD (  10.68  )
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

On Wed, Jul 10, 2024 at 04:18:05PM -0700, Bart Van Assche wrote:
> pcie_aspm=off tells the kernel not to modify the ASPM configuration. This
> setting does not guarantee that ASPM (Active State Power Management) is
> disabled. pcie_port_pm=off disables power management for all PCIe ports.
> 
> This patch has been tested on a workstation with a Samsung SSD 970 EVO Plus
> NVMe SSD.

Interesting, didn't know about that parameter. Does this actually aspm
too, though? It looks like we want aspm policy to be performance for
that to happen.

