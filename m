Return-Path: <SRS0=itK/=OY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044A7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 09:35:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C8361222
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 09:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8C8361222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=movementarian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u20RE04cKPVsxRXn6EYjrsnpdamBFnQGMmNzR8aqa+k=; b=R9bCbGUlhUr1JB
	8uty+d6ob3To3lh1/abmKKxpJJ2/hytMzQ+DMbWpA977uX2ncFqytiiHMdkUMqBbIROZtksScQ2HC
	MQTS6gZfldcjy8MBeuXTxu6zGB3xk0gKn2Ec0DAj93sQxU1A7C6LyjeOzFw+Mn68XFG3bIP9VBHWa
	gzBsynfCFkvzNaTACopuYu6EiAsmfDUrasiDy4Wq2YdroaZ1Q/9aOMo+eoBLI+FWq8MqGUjaxlQEg
	BpJDdYLwwVcSbiYA+hMpadk8QKZs1pGqysN4bocAa6tchExORYK1va4nST1yaUFmCiYvRLqAlQrW1
	lm+MkaTTzikvmFHb8j/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXKNK-005mpD-KI; Mon, 04 Oct 2021 09:35:10 +0000
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXKNI-005moW-IN
 for linux-nvme@lists.infradead.org; Mon, 04 Oct 2021 09:35:09 +0000
Received: from movement by movementarian.org with local (Exim 4.94)
 (envelope-from <levon@movementarian.org>)
 id 1mXKNE-0001qX-QH; Mon, 04 Oct 2021 09:35:04 +0000
Date: Mon, 4 Oct 2021 09:35:04 +0000
From: John Levon <levon@movementarian.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/3] nvme-pci: clear shadow doorbell memory on resets
Message-ID: <YVrKyC9c20Gz4YSR@li1368-133.members.linode.com>
References: <20200427235243.2268765-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427235243.2268765-1-kbusch@kernel.org>
X-Url: http://www.movementarian.org/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_023508_626940_B64F5E1F 
X-CRM114-Status: GOOD (  18.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 27, 2020 at 04:52:41PM -0700, Keith Busch wrote:

> The host memory doorbell and event buffers need to be initialized on
> each reset so the driver doesn't observe stale values from the previous
> instantiation.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cf386c84588b..d388fff9c358 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -228,8 +228,11 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
>  {
>  	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
>  
> -	if (dev->dbbuf_dbs)
> +	if (dev->dbbuf_dbs) {
> +		memset(dev->dbbuf_dbs, 0, mem_size);
> +		memset(dev->dbbuf_eis, 0, mem_size);
>  		return 0;
> +	}
>  
>  	dev->dbbuf_dbs = dma_alloc_coherent(dev->dev, mem_size,
>  					    &dev->dbbuf_dbs_dma_addr,

Hi Keith, we came across this issue recently, and we just found this above
patch. Was there any specific reason it was never merged?

thanks
john

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
