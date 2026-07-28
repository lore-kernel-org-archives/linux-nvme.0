Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FAFC54F52
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 21:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+d4Y6SJStY6jWcuTPSBIguPkXtE6f0A1wQTLHqva7gc=; b=vuwpwce0KWP4SAtMyJh9Ykdlk3
	PsnNC1WkuRP4S1w0j+DtvQLItJM2f0cxf8YSh7aA7bVqqoI7vXYpRZZu8G32hLEa4vgugwuHnHQPL
	EptRsncVc0KzYUBh1Kno3y+fDUaGo/11XRFRiFdhQLwXH7oDrNLW2KnCDHDDM4aJXZbsDIrDHpYg0
	uTn7SFAmOehhRiCWCHW2O/4QN36HSfCAJQsgvWlAKSw2KG6BnFr7/S3sN2mfSfXufLHXg+bNcEJ7G
	EtS9hDbiXASrhX4YIR/RSWAMjB6UWsCfzWahDZN9I5YExfQGTQ2TxZ1ZLUFur6iKiXVmSirsLp3OL
	rcA/02UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wooz2-00000006Fu1-3UVm;
	Tue, 28 Jul 2026 21:05:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wooz1-00000006Ftv-2EG0
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:05:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D1C5543754;
	Tue, 28 Jul 2026 21:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642421F00A3A;
	Tue, 28 Jul 2026 21:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785272702;
	bh=+d4Y6SJStY6jWcuTPSBIguPkXtE6f0A1wQTLHqva7gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XBYuwqIjMeSO56ld0pjQL/GJJBq94mvY0Bja3PEgAaBvIHvxTdnPjaC1SN5cdC9SQ
	 ZYybgPAbSOROu0zjTZ0LXIStOwjST9AzGiBxLRgpiTiKi1+g9sBBIaamuHYV8NDeJa
	 A3IWbni+K4hxb0o2S1hEOpM0cIzld8zvCS00YJgA/oqL2v/VHf1gg8o582F3KMQN7j
	 I1EAxAzzg2SFrNKwgkN6TPNX15ENuvx52enmHmeEAlxYAn5EW/dOWc86iw2/RAPn4n
	 SNZgYeH+xXIXb5YDhIIqktW7RJUfUJBdR5lHSO5LfPMG/N4dIzn+dQofXaojcjPnNh
	 Oipzca8nEfTdQ==
Date: Tue, 28 Jul 2026 15:05:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] nvme-pci: disable controller on admin queue IRQ setup
 failure
Message-ID: <amkZfAmClmnzSCYV@kbusch-mbp>
References: <20260715074459.50760-1-mhun512@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715074459.50760-1-mhun512@gmail.com>
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

On Wed, Jul 15, 2026 at 04:44:59PM +0900, Myeonghun Pak wrote:
> nvme_pci_configure_admin_queue() enables the controller and then requests
> the admin queue interrupt. If queue_request_irq() fails it returns without
> disabling the controller, and no caller compensates: nvme_pci_enable() only
> frees the IRQ vectors and calls pci_disable_device(), after which
> nvme_dev_disable() treats the controller as dead and skips nvme_disable_ctrl().
> The controller is left enabled (CC.EN set) on this error path.
> 
> Disable it in the failure path, while the PCI device is still enabled so the
> CC.EN clear handshake completes.

Thanks, applied to nvme-7.3.

