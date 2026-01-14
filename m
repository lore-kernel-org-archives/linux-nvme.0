Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5EBD37E43
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jan 2026 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fbszSLLY5UnebqkyaKutNKXhF+PeIAlVvvEwj4X46xk=; b=HIDvi57ngKFjcMW8EN6JyTWvk4
	JK4r4O8R08n+gYRrGycPuL81kmjbWbvgLoo7aYZQDu8R2HMNwvbxg0se34zti41xPdIMF7Q5lHnNG
	O04m5lel1WBYjnITn88GUReIqX8xmtbFinRIlT3tlQAXCEeCoKWnlekBZ+uTyLO8btlGtx1ngyNXH
	WPXhb+ACEJJqu7E0crFgAUOcYAkLmR8OJLmJWwqLMmGbUqHSa4XSF+jfQweAc7Ce3FQdKq1n0Vifr
	CRhoWqciVuMbHWYg3J59PKkvZEUmR1z6l1nlepCa24TE9vHUXYnoXDFjgg7nL9lx2IcBrNbTcAPOn
	+0e06C+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg2h1-00000009fKv-2ifE;
	Wed, 14 Jan 2026 15:21:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg2gz-00000009fK3-0hFH
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jan 2026 15:21:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7EC2141847;
	Wed, 14 Jan 2026 15:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C8DC4CEF7;
	Wed, 14 Jan 2026 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404112;
	bh=+61og6uMxgSmno3yVQ3OVIk7mMzk8d6px6uRQZkpJN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLY2zqftEqzdVvCtB/sv1ditE5JYzFYHeoy53VDmVh+GjeJVCM25UdiMB1K3qu8QU
	 +PFQxNpT0s/emuPwoHZ/7hrMY+icdCJirxtVmlh6i93mYCMozmMAW0o9/TJ8MiYUwS
	 DoLECHwOTay8j1ckSS8WkTBfIbYRU48Rm2PoU9mXkpt4AHXxWy6o5SaC6Mdd65qOTU
	 B2Be0GCNMCjyWpX0eeWwMdwhpOqWjFkm8irmrjUXXuRnJA0Mce/msAB6m3XS74bzB0
	 Z33GpIoHHL85NZhOEy0K8MtMMpparY3lgfxkcLUoAsM25eRQHffvxTwwbo87TmewgG
	 CuVv8x50uWSXQ==
Date: Wed, 14 Jan 2026 08:21:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, jmeneghi@redhat.com, wagi@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	james.smart@broadcom.com, hare@suse.de, shinichiro.kawasaki@wdc.com,
	wenxiong@linux.ibm.com, nnmlinux@linux.ibm.com, emilne@redhat.com,
	mlombard@redhat.com, gjoyce@ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: fix PCIe subsystem reset controller state
 transition
Message-ID: <aWe0ja2rCpRFQEke@kbusch-mbp>
References: <20260114072416.1901394-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260114072416.1901394-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_072153_227714_6FE0D63B 
X-CRM114-Status: GOOD (  11.18  )
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

On Wed, Jan 14, 2026 at 12:54:13PM +0530, Nilay Shroff wrote:
> The commit d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING
> state") disallows controller state transitions directly from RESETTING
> to LIVE. However, the NVMe PCIe subsystem reset path relies on this
> transition to recover the controller on PowerPC (PPC) systems.
> 
> On PPC systems, issuing a subsystem reset causes a temporary loss of
> communication with the NVMe adapter. A subsequent PCIe MMIO read then
> triggers EEH recovery, which restores the PCIe link and brings the
> controller back online. For EEH recovery to proceed correctly, the
> controller must transition back to the LIVE state.
> 
> Due to the changes introduced by commit d2fe192348f9 ("nvme: only allow
> entering LIVE from CONNECTING state"), the controller can no longer
> transition directly from RESETTING to LIVE. As a result, EEH recovery
> exits prematurely, leaving the controller stuck in the RESETTING state.
> 
> Fix this by explicitly transitioning the controller state from RESETTING
> to CONNECTING and then to LIVE. This satisfies the updated state
> transition rules and allows the controller to be successfully recovered
> on PPC systems following a PCIe subsystem reset.

Thanks, applied to nvme-6.19.

