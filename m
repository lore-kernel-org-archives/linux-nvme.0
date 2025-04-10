Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06850C3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iK2YpokfQ25M3zECHJa5LCXIjyB+wISDq1J4O/4T5LM=; b=N7HLg25oT2ebxLkBBzFWHp7bNw
	31Xlu3iErtNBO+7ZBvEoIVPel55L4i5xIcoichkp44l26GzaJcy6XhTAPp1SP13TXn7CfKMSgZ1Ma
	sYgvXhiEidEjeIiHccbnkPdSTGZjty7i20Mxq+Q+RcM+sM4pexVtHzexJsRT5ZtVzGlU82G3DPJ1Q
	u+Q1wJ82S7VTs3WFY+KlvF9sssua1Sev1w1RmTkOcD6cOgbNm2w9U2b652dtbFKZw73R1qDzHlcJF
	nJk1U0a/4WutqxYBtKOr2+R8Hf4dOBZnlN5EPAFGxGcEjsdL/qSvDrdVrDOTHVqoKjom+6F0OKl3G
	Bc4PJ6UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qWw-0000000AOjd-1E6T;
	Thu, 10 Apr 2025 11:57:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qWX-0000000AOcP-2CFA
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 11:56:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 067705C5569;
	Thu, 10 Apr 2025 11:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FAEC4CEE7;
	Thu, 10 Apr 2025 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744286208;
	bh=wrYpAlKp1wTMujNQXue+jQyMP5F0D2PIaQXqoY/Gt2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoMRrpdJP6FgxC4PkPRMREFGXDdr8vFe+90ojxG/I6mKuibMo+DW85QFmNKIf1uup
	 vL8wFomOlVHeSQHG/bflVFVtxxd+VKV4+jL8m7B6uh4xrj6a6vgy330imglZC4QSYH
	 4qu6+YWKKXZUQxrBl/1f92yBlnZdMwX8y7I3P6N+Aq0+yxkZrLG4BRHXIMTBaOVMvW
	 sTUeI+K/3LyhAk+uv36mI1AxMhEhi4fUwZDSKccOU1qN2nW/EZSSoagRyq+YpWcx3z
	 yttvVs2tD61yxWpzyM35VXAhAZSBgXGqznUsSQFjSp0O9/DtbXXT37BAXjZybcAz4k
	 FycQ29Kj8AH/g==
Date: Thu, 10 Apr 2025 13:56:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] nvmet: pci-epf: Cleanup link state management
Message-ID: <Z_ex_Lzbh1fezxDx@ryzen>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-4-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408024733.690966-4-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_045649_602528_61F1413A 
X-CRM114-Status: GOOD (  10.58  )
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
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

