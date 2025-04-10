Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44905C3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=brF19wpCA4+bBY4maNE06vyJvrBeeHZv3vgXemKJcHc=; b=VPvGaoZAO73GGfTGIOIFXXHcdF
	ffn3pkq1wWfyGa1/XUA7UbpfAi4FIIKRI54vro7HpQurrwmsbyTgDs+eCdu9P+VbJLRLEm5JGkZgd
	tW3f7gGvQHcMJq7cGh2fWIjIHVkbCZyaj7zEmgXC2I5RdwxneMTLKGWG2o/vKZgqg5XGeVpOAfkES
	gcGCih2Wra/v3Cp0yVIWbfQwRwvXGMmfwoh3FPqZ0c0B2NYlKaHI0K80K0er12aeWnoRsnfw3RTEo
	n8bNl5C/QYUuoJ+uW2qx73wbi612CpHJy3ISnfEqIrTMiVquXL7xp1CARGdBRzVzT3JA4mUGXk27w
	Upw2E5Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qWv-0000000AOjS-2rXS;
	Thu, 10 Apr 2025 11:57:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qTw-0000000AODB-1n80
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 11:54:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 767B96843D;
	Thu, 10 Apr 2025 11:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E14C4CEDD;
	Thu, 10 Apr 2025 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744286047;
	bh=rLKmwqU7Da3806wzBQrZrh0tpE6Znx6Kx1P2848VMeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOzd6joPFTviPgGyeVV81OAcKOjUh/uI0ZoJiwcc4DOlzeyN2njXdfL0x3vsIPDWN
	 veEpruX15X7fz/4XNPRYQLgYGMoFSKqfszvMj5OaR1PHxD1SDE8ai9Hh0Fb2yclmr3
	 fiu8BbjG+1d66oewvSsvPSeH6qbgkwzoEyZs/n7LE2U298BB/L7UAmvEiMthkp360j
	 nqMdVPfBToEdQ6KLbOwMDwUcCQCJMa/IhyL4XSSZvm0mVwHhTxs9jJCa9wzWFWMwyc
	 A/YfSJLI78oipEvlIl6cobtJdT7JLEGXU831MbZhsPBFkMqWBwf650K9k+sZick8J/
	 07r4I482IDImQ==
Date: Thu, 10 Apr 2025 13:54:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] nvmet: pci-epf: Clear CC and CSTS when disabling the
 controller
Message-ID: <Z_exWy7bMlkaLMb2@ryzen>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408024733.690966-3-dlemoal@kernel.org>
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

On Tue, Apr 08, 2025 at 11:47:32AM +0900, Damien Le Moal wrote:
> When a host shuts down the controller when shutting down but does so
> without first disabling the controller, the enable bit remains set in
> the controller configuration register. When the host restarts and
> attempts to enable the controller again, the
> nvmet_pci_epf_poll_cc_work() function is unable to detect the change
> from 0 to 1 of the enable bit, and thus the controller is not enabled
> again, which result in a device scan timeout on the host. This problem
> also occurs if the host shuts down uncleanly or if the PCIe link goes
> down: as the CC.EN value is not reset, the controller is not enabled
> again when the host restarts.
> 
> Fix this by introducing the function nvmet_pci_epf_clear_ctrl_config()
> to clear the CC and CSTS registers of the controller when the PCIe link
> is lost (nvmet_pci_epf_stop_ctrl() function), and when starting the

s/, and when/, or when/


> controller fails (nvmet_pci_epf_enable_ctrl() fails). Also use this
> function in nvmet_pci_epf_init_bar() to simplify the initialization of
> the CC and CSTS registers.
> 
> Furthermore, modify the function nvmet_pci_epf_disable_ctrl() to clear
> the CC.EN bit and write this updated value to the BAR register when the
> controller is shutdown by the host, to ensure that upon restart, we can
> detect the host setting CC.EN.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/nvme/target/pci-epf.c | 49 +++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index f6b22ef4c267..f18faf407eab 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1802,6 +1802,21 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
>  				   NVMET_PCI_EPF_CQ_RETRY_INTERVAL);
>  }
>  
> +static void nvmet_pci_epf_clear_ctrl_config(struct nvmet_pci_epf_ctrl *ctrl)
> +{
> +	struct nvmet_ctrl *tctrl = ctrl->tctrl;
> +
> +	/* Initialize controller status. */
> +	tctrl->csts = 0;
> +	ctrl->csts = 0;

This can be written on one line:
tctrl->csts = ctrl->csts = 0;


> +	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CSTS, ctrl->csts);
> +
> +	/* Initialize controller configuration and start polling. */
> +	tctrl->cc = 0;
> +	ctrl->cc = 0;

Same here.


Otherwise, this looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

