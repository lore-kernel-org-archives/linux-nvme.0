Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2D2C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6GFrKMql3ettTG0lY377Bp2UzgzkoFrG6SYu80MKheo=; b=c8blxDl4q0b+sa61QeixLLmVdl
	F3KE+bX2ugdYVLmrxFqLv7i3ur2gWd/wIB93jffvMF5nE36py76jERksvlCil2jI4WeRgys57vB5k
	bx2of6yOoi81M52IpJ1P7J628cdppE8gt9YIZt4XMF9NAOFrmjUOqEn7NpgoeOjqnWMPGMPq03QbC
	PJGc49Mo1CHfnBad0TqebFrE3cclRSFIwlMHYrA9stn/NEIHiCcouBUD1k5busFUf51Qn+IVTUokd
	+ld19OY4PzkJP2/074P5zM5pYQ4Cr3Fjjlt4vMQMdRdsRT/0GrBtOj3HLGMyXOAB5UWs8sftSuwpY
	wCQ0/pVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4GJH-00000001Iqt-0WIw;
	Mon, 14 Apr 2025 09:40:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4G3Z-00000001GXo-19Zv
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 09:24:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C003D4A557;
	Mon, 14 Apr 2025 09:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65373C4CEE2;
	Mon, 14 Apr 2025 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744622684;
	bh=v7ESlKkH0TnfuK80sSVJkstN11OFvk7FYcfDbhIH9ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXWdpmzpn2Y1IPZ0ddUp6xROU1eDxQUqh7pPdWExgX3YyOGgiHRpySuYHnyQxOtF4
	 h5MkT8Y++C3J9mYIJJaoEFyy9jYJN5dZk7IwmVgsxiIC+C+iTPz0Fy+HLTxO2p0pnN
	 YhV1AS+39hLEZyrJu2aVgF3VQySepr4jaFEsivFqVe9xTWrph1cFM99pOjcLBEXoRq
	 xR/u0AdMP99U1rStwcS8vlNvOplAE6+dFTRFI19j6P6+3Hg0zo1+Jskzttnlzh8IbO
	 EYZPSTIs/eGaEbCbomNVw6MNeCiCS/2bmpaULnCj3JZGKx2Xwgm1IwR2gaYjMD73pZ
	 od3Fc88GmzyUw==
Date: Mon, 14 Apr 2025 11:24:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/3] nvmet: pci-epf: Always fully initialize
 completion entries
Message-ID: <Z_zUWPAworAS61qy@ryzen>
References: <20250411014211.1070887-1-dlemoal@kernel.org>
 <20250411014211.1070887-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411014211.1070887-2-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_022445_331555_C349EE3B 
X-CRM114-Status: GOOD (  14.39  )
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

On Fri, Apr 11, 2025 at 10:42:09AM +0900, Damien Le Moal wrote:
> For a command that is normally processed through the command request
> execute() function, the completion entry for the command is initialized
> by __nvmet_req_complete() and nvmet_pci_epf_cq_work() only needs to set
> the status field and the phase of the completion entry before posting
> the entry to the completion queue.
> 
> However, for commands that are failed due to an internal error (e.g. the
> command data buffer allocation fails), the command request execute()
> function is not called and __nvmet_req_complete() is never executed for
> the command, leaving the command completion entry uninitialized. For
> such command failed before calling req->execute(), the host ends up
> seeing completion entries with an invalid submission queue ID and
> command ID.
> 
> Avoid such issue by always fully initilizing a command completion entry
> in nvmet_pci_epf_cq_work(), setting the entry submission queue head, ID
> and command ID.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

While it is obvious from looking at the code, the commit message probably
should have included something about the READ_ONCE()/WRITE_ONCE() change.

Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

