Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADD7C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Dtzcrxn5jOivNyHLQiYwICC0lcE7wTqhstPP12GX+o=; b=4NeidgZYZRU5E0zHEIF5/PyKpC
	sYQ2AcgHHYsLztWDkmUt+tfsQ+CLAXxJg+DDEqzM0mmOG7Z8XVzzdBE94o8WbghxA5EEhIRTi+sk/
	7MfpnKhjpA6elmBULXaW7pjLvjRrDTcZzGdWd88UXdbjLPEJx02ysd+sPK2+b2occkPi2KdNiS5DX
	VloQHYGRt/A6sVwiEuhdfztikcmPqAph5p5OA0VGe3aTniYucjz4tLE2Ey8Gi/z+c+LjYA0SNfaHt
	O2sBd5iu6IxAqLw6k7iweLF3vaeVvMBqJ/wbzsTHFt8ArBPQnkGSqGrlYfukWrOatQbMzPyKoUuJm
	Vr9HFWXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsmA4-0000000Bzcj-27ye;
	Thu, 13 Mar 2025 17:16:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsmA2-0000000BzZb-3mFt
	for linux-nvme@bombadil.infradead.org;
	Thu, 13 Mar 2025 17:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Dtzcrxn5jOivNyHLQiYwICC0lcE7wTqhstPP12GX+o=; b=G2LsBsOeWobR8wWvByuabNnji4
	9lgsOuZtGaNoTUYlxY4XmMhAZcftmZS7u7V/KiVjAPSzjzOgBIqm2Y53zKeO544dnlqQYQK250kFt
	AwGQrlB2ZzqDnZ6LBb7utx5DR7jn/u91Rh6Ic3zey73lGLwZ3G/LBSy26C9YNMU+CqrZ0n3RkZ+/W
	06Yu31sQyzdfRez39KZz5y+NqHO0r/0gKrRxxB9WRSmmAb7GsLOayCdQlsvcGd6aYqa57pLbVGCwy
	B1DEdPl6vwWtrS4DtQiRZsdeMIUSHesSiOHA+3dXfW0lgYiCxi1iNN7Mz+uV1EEDDfDDI77E7vowN
	uwyn6y0A==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsm9z-00000002lkq-41en
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 17:15:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F3FE95C5B6D;
	Thu, 13 Mar 2025 17:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25420C4CEEB;
	Thu, 13 Mar 2025 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886150;
	bh=TNKImy+lsoBFdWGR2qsLkPHWXOol0Q5bKVmcV9ASoiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NyPO7Zh9sa8ww9r2bHYUuwcYEojUYK4dF1aq0kxvSNLnSBm9gyPnmZqQ029rHPFf/
	 dZ1PPPd0/mf/yMl4onqdPrj5R1iLtDGXxAKJABP4No5fWDCFPXQhgb67roFRP0tFLO
	 KOOoXp3qsmowzimyroBOcnLLNJSuIW/4b3YToAJeW2w8S9X4Z7+43nIIt7k7UKsxyt
	 yGq9LEhc+ccUPvrMIqpywsIfsATeHEKSTI3sH9hbGOygKDvHCMEKrpMzZHb5UNw6TJ
	 /9lb40JyLhau7QNwjesaixz7Hn6xzg+JGChSeZUtEf7remnzNljdrMwFe9mHGSc8dm
	 r+Y0v7/qijOGw==
Date: Thu, 13 Mar 2025 11:15:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvmet: pci-epf: Keep completion queues mapped
Message-ID: <Z9MSw53Bq2hvvMYD@kbusch-mbp.dhcp.thefacebook.com>
References: <20250313082218.1444073-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313082218.1444073-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_171556_185828_56DC28CF 
X-CRM114-Status: GOOD (  10.76  )
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

On Thu, Mar 13, 2025 at 05:22:18PM +0900, Damien Le Moal wrote:
> Instead of mapping and unmapping the completion queues memory to the
> host PCI address space whenever nvmet_pci_epf_cq_work() is called, map
> a completion queue to the host PCI address space when the completion
> queue is created with nvmet_pci_epf_create_cq() and unmap it when the
> completion queue is deleted with nvmet_pci_epf_delete_cq().
> 
> This removes the completion queue mapping/unmapping from
> nvmet_pci_epf_cq_work() and significantly increases performance. For
> a single job 4K random read QD=1 workload, the IOPS is increased from
> 23 KIOPS to 25 KIOPS. Some significant throughput increasde for high
> queue depth and large IOs workloads can also be seen.
> 
> Since the functions nvmet_pci_epf_map_queue() and
> nvmet_pci_epf_unmap_queue() are called respectively only from
> nvmet_pci_epf_create_cq() and nvmet_pci_epf_delete_cq(), these functions
> are removed and open-coded in their respective call sites.

Thanks, applied to nvme-6.15.

