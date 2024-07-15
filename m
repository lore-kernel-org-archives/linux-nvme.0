Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A05DC3DA4B
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jul 2024 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G0m5kCgpJngDhmxB6aYnZHOXPZZBgds6U2C/st7JzfY=; b=04b6tUz40dgBUUkpNA4ddwIi9s
	tJGHYR/j8xGjnPDzuqJbQcsPCJNbOHNSKuc4biTxaUYAyt56Tl4/OD6JzWsS6McLMt/nkH4XHFgz9
	apcb+A2gpZYz3lAREY0D7vGBjQN75fenOENHbsbFBL/hzaJmPX3muZxiNswzpNBgoOrACHhzIe35J
	8bf2sXqq3ZFdB0GbL6RpPnvG3swm/5MMh5VA8a+BlqIQdChI8ePEzGY0dMvyESS7sZrb/L2QQIvLZ
	O5j2MAeFnnibTn/oDv1oLq6XYS+wUpU9U4an5ZGJBwh6/R/JWgKldM21+sid+BYVIzKtegPs8XuOK
	gmFQthtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSe5-00000008MPy-2Bom;
	Mon, 15 Jul 2024 20:50:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSe2-00000008MP6-0lNW
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jul 2024 20:50:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C7DAB61291;
	Mon, 15 Jul 2024 20:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08410C32782;
	Mon, 15 Jul 2024 20:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721076600;
	bh=we2Bw5OgyKt+jTrxEVJozkAoZpzgEj3CLc9eXAxshJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyTa4xPSc+2q73aWZJPOvWx3pFq5LRjqYnlrzxjzHoFhhyBV5M+DbqLKZy3wVrK/a
	 QSKqL65nuQbao84mGErDxiX1xgODM9sZ8XDyA7HrwoJYVmABbvJ6J9WkjMidME2mcJ
	 jUmZma85LS1u9ypOW5El0FhSrEazHDdQ3lYe9+1wZCpsTaEwAQsSMxyVEE1oBIO5tO
	 DGeg1OF0RP+4lMGbYQAIaFolb19Tm+LebTnJVTyDi/kIUcmhUWRpJciXsBXQ6ndJJ6
	 g9PnryByn9SzSUq/B3KHRKEhvlypWQo/EfJEqLJ6J0bp+WCcb3+y9wKzbQHTsk/YzJ
	 GYMxUKGD3ioJQ==
Date: Mon, 15 Jul 2024 14:49:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2] nvme-pci: Fix the instructions for disabling power
 management
Message-ID: <ZpWLdYi-aZkdDoYE@kbusch-mbp.dhcp.thefacebook.com>
References: <20240711225952.5445-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711225952.5445-1-bvanassche@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_135002_312552_656BAD07 
X-CRM114-Status: UNSURE (   9.74  )
X-CRM114-Notice: Please train this message.
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

On Thu, Jul 11, 2024 at 03:59:52PM -0700, Bart Van Assche wrote:
> pcie_aspm=off tells the kernel not to modify the ASPM configuration. This
> setting does not guarantee that ASPM (Active State Power Management) is
> disabled. Hence add pcie_port_pm=off. This disables power management for
> all PCIe ports.
> 
> This patch has been tested on a workstation with a Samsung SSD 970 EVO Plus
> NVMe SSD.

Thanks, applied to nvme-6.11.

