Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6612C6FD1C
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Mar 2023 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whyKBrw59YGFPnyfYEyh0woJuoDYKEZNmx2AN2Ezbuc=; b=V4tUaIXVHyK8CA1Ouiaot/SACu
	RL8wWJDlJiGpwOsVY7rCEai3bZXnsyD7eEeB8dhN3SwHC78g/YaU5JhPASTNAkodhk+bMLGJIXE8C
	Tk78BrGnB1tX7kq6k04OL+2cEgkzJ72zalZVsu034jaCf1zrTbyfJxH9RXCqVGbQ/FeIALmGLFjO+
	G8ZjE23OvJI7V7Fpx9g3VApSNY1o9znvqQtU4gNjgrKRcKsPdaMRnej5qAUtV1AkCTVk4UPHmDUlq
	7+GpKTNa8tr+yiDQGvbt4jhoTbXHMy6YZQG7c36nzqj0g2v1kZ4VvGNneuMzq0odyvW+grGVWsdXa
	lqFh9zXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pb2MK-000uF4-3b; Sat, 11 Mar 2023 16:46:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pb2MG-000uEU-UM
	for linux-nvme@lists.infradead.org; Sat, 11 Mar 2023 16:46:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF4760C83;
	Sat, 11 Mar 2023 16:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3592FC433D2;
	Sat, 11 Mar 2023 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678553166;
	bh=6u411eM681dURzAqkgbsuc60q6pBsWl+2a9dkuzX0Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmFf5FXysXFGo+K79Qy+X9lKSNEKwNn0BER3/Yb46ROgsqKaHLG13LODcqLqM6J64
	 CKvsggKyMJB0mtVuJfR31ofb400VIShc24osnRgzqKKiUiEbOrUOEFbbOYZx8YbnRn
	 Hh96mm1++q+9b2wYOQjVnGSaXe+BXAJXwVqMUXtd6XMnbeUxMVywR5T2WRA98cTj/Z
	 1H9FgHlc1AxayTqvjq0cQxctP0p1IQadAKlxsuEHkTYlHMI933YPvLY9zYbyej6F1Y
	 lrsZXZDd1Bgv7ok+JVPWKG9mRFcj87VfyjEH6ctUajh1BEQn9SvA0Yxf57iqsiqE/1
	 vCmADlMW6ZJsQ==
Date: Sat, 11 Mar 2023 09:46:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Tushar Dave <tdave@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Message-ID: <ZAywS5Y3wrNNT0Pf@kbusch-mbp.dhcp.thefacebook.com>
References: <20230309175321.GA1151233@bhelgaas>
 <843e2392-9ff0-2286-5f97-659831013c2e@nvidia.com>
 <20230310235306.GA1290793@bhelgaas>
 <4922cec7-ecc1-4971-75af-cdbaeaa6434f@nvidia.com>
 <20230311082220.GA3649@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311082220.GA3649@wunner.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230311_084613_038328_B79CC1D7 
X-CRM114-Status: GOOD (  11.73  )
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

On Sat, Mar 11, 2023 at 09:22:20AM +0100, Lukas Wunner wrote:
> >   - Switch and NVMe MPS are 512B
> >   - NVMe config space saved (including MPS=512B)
> >   - You change Switch MPS to 128B
> >   - NVMe does DMA with payload > 128B
> >   - Switch reports Malformed TLP because TLP is larger than its MPS
> >   - Recovery resets NVMe, which sets MPS to the default of 128B
> >   - nvme_slot_reset() restores NVMe config space (MPS is now 512B)
> >   - Subsequent NVMe DMA with payload > 128B repeats cycle
> 
> Forgive my ignorance, but if MPS is restored to 512B by nvme_slot_reset(),
> shouldn't the communication with the device just work again from that
> point on?

The upstream port was tuned down 128 without coordinating with the kernel, so
restoring the nvme to 512 creates the mismatch.

