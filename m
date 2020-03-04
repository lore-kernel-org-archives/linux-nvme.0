Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D105C3F2CE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:09:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594C221739
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QRgFChra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594C221739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ckTg/19Zhcr5wWe5zNG31pR7uJb//LtaX5JSJfROZG0=; b=QRgFChraZ0XZWI
	0vgD0EQ/k6IRK1bCRny8Uj7EoBJAAcY1tn7kcxF5DP+erCL5HgaWRBU4qhzIYHixj3ptrX+C/F4cx
	AvLZJNrFkfNsmlVTtJ/+EQEa7MwQBCgfVg3rTeTIuMs8sWAqOxqWRtvQsqi753vf9nBYLre4d4ga8
	fIDI4+VByQAJPB2hW6iitr7lBsn0IJG7mO36ORwiK8w+Ex7wR+pcBf27fLCo7MqR3Hr8vmMSRgzz7
	NyPKWh6IMS0Lc60ry55E0jIO0hExW5V/bS/Ujuh8buYF60QNYDJWXEJ9jNUrykeHHBSBWASGcK9Hr
	B8MabnXGjbdFp8biVcNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9Wa2-0000U2-Q8; Wed, 04 Mar 2020 16:09:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9WZx-0000OE-NT
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 16:09:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 404CB68B20; Wed,  4 Mar 2020 17:08:59 +0100 (CET)
Date: Wed, 4 Mar 2020 17:08:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: Remove two-pass completions
Message-ID: <20200304160859.GB11029@lst.de>
References: <20200302194616.2432-1-kbusch@kernel.org>
 <20200302194616.2432-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200302194616.2432-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_080901_940464_F1B2981F 
X-CRM114-Status: GOOD (  12.38  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: bijan.mottahedeh@oracle.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +static inline int nvme_process_cq(struct nvme_queue *nvmeq)
>  {
>  	int found = 0;
>  
>  	while (nvme_cqe_pending(nvmeq)) {
>  		++found;
> +		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
>  		nvme_update_cq_head(nvmeq);
>  	}
>  
> +	if (found)
>  		nvme_ring_cq_doorbell(nvmeq);
>  	return found;
>  }
> @@ -1011,21 +1000,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
>  {
>  	struct nvme_queue *nvmeq = data;
>  	irqreturn_t ret = IRQ_NONE;
> -	u16 start, end;
>  
>  	/*
>  	 * The rmb/wmb pair ensures we see all updates from a previous run of
>  	 * the irq handler, even if that was on another CPU.
>  	 */
>  	rmb();
> -	nvme_process_cq(nvmeq, &start, &end);
> +	if (nvme_process_cq(nvmeq))
> +		ret = IRQ_HANDLED;
>  	wmb();
>  
> -	if (start != end) {
> -		nvme_complete_cqes(nvmeq, start, end);
> -		return IRQ_HANDLED;
> -	}
> -
>  	return ret;
>  }
>  
> @@ -1044,7 +1028,6 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
>  static int nvme_poll_irqdisable(struct nvme_queue *nvmeq)
>  {
>  	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
> -	u16 start, end;
>  	int found;
>  
>  	/*
> @@ -1054,32 +1037,29 @@ static int nvme_poll_irqdisable(struct nvme_queue *nvmeq)
>  	 */
>  	if (test_bit(NVMEQ_POLLED, &nvmeq->flags)) {
>  		spin_lock(&nvmeq->cq_poll_lock);
> -		found = nvme_process_cq(nvmeq, &start, &end);
> +		found = nvme_process_cq(nvmeq);
>  		spin_unlock(&nvmeq->cq_poll_lock);
>  	} else {
>  		disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> -		found = nvme_process_cq(nvmeq, &start, &end);
> +		found = nvme_process_cq(nvmeq);
>  		enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
>  	}
>  
> -	nvme_complete_cqes(nvmeq, start, end);
>  	return found;

I think we can just make nvme_timeout call nvme_poll for the
polled case, and just handle the irq driven case in this function
(should probably be another patch on top of this one).

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
