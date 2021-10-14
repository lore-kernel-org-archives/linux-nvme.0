Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89D0C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 21:21:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9C761040
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 21:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B9C761040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=movementarian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s4ImZUtcPh/jVOgn32osK1ldqaGjqOQlXs/pRkTl3uU=; b=UCQBWwv3Z97i5bO1VfV9dEgWch
	P+9L453Bjtso19ICfjejkfjjH6u2CXubxwUnfWLghF3RXy2HQb8pDO8ipeIQAD15j2CwiCQpETJlX
	ibUCyLeOWyDrTbw+43izUSrYuwDIaSWU+oxT/PVl7XzmARm6jTA7b1IGa3vxgCVhjhkvC2GP43Hz3
	3g44prSyTKLc/vQqB0hzsOCtwBTxAhRBoy7tNUwFjXPLNNMJ7lkBib5bV2E0voSjS64XSN9Er/mb3
	jowbpLSuUYBIUwNESqJ3iByv6c+izYGxSyGF9idHGNTvcm3mM7ODCjDez6DC7dWdBAeCl2Yi+TDBh
	TGa792wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb8AL-004Pp4-P2; Thu, 14 Oct 2021 21:21:29 +0000
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb8AJ-004PoT-Bn
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 21:21:28 +0000
Received: from movement by movementarian.org with local (Exim 4.94)
 (envelope-from <movement@movementarian.org>)
 id 1mb8AH-003lCV-R6; Thu, 14 Oct 2021 22:21:25 +0100
Date: Thu, 14 Oct 2021 22:21:25 +0100
From: John Levon <levon@movementarian.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 1/2] nvme-pci: clear shadow doorbell memory on resets
Message-ID: <YWifVXN5cP3JpQ0A@movementarian.org>
References: <20211014164543.1821327-1-kbusch@kernel.org>
 <20211014164543.1821327-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014164543.1821327-2-kbusch@kernel.org>
X-Url: http://www.movementarian.org/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_142127_425559_0F678408 
X-CRM114-Status: GOOD (  18.57  )
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

On Thu, Oct 14, 2021 at 09:45:42AM -0700, Keith Busch wrote:

> The host memory doorbell and event buffers need to be initialized on
> each reset so the driver doesn't observe stale values from the previous
> instantiation.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I reverted our workaround and tried this patch with my simple test case:

mkfs /dev/nvme0n1
echo 1 >/sys/devices/pci0000:00/0000:00:06.0/reset
mkfs /dev/nvme0n1

Works fine where previously it would essentially permanently hang the
controller.

Tested-by: John Levon <john.levon@nutanix.com>

thanks
john

> ---
>  drivers/nvme/host/pci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0dd4b44b59cd..9dd173bfa57b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -245,8 +245,15 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
>  {
>  	unsigned int mem_size = nvme_dbbuf_size(dev);
>  
> -	if (dev->dbbuf_dbs)
> +	if (dev->dbbuf_dbs) {
> +		/*
> +		 * Clear the dbbuf memory so the driver doesn't observe stale
> +		 * values from the previous instantiation.
> +		 */
> +		memset(dev->dbbuf_dbs, 0, mem_size);
> +		memset(dev->dbbuf_eis, 0, mem_size);
>  		return 0;
> +	}
>  
>  	dev->dbbuf_dbs = dma_alloc_coherent(dev->dev, mem_size,
>  					    &dev->dbbuf_dbs_dma_addr,

