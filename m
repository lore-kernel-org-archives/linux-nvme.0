Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2194C432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 10:17:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F70C2068E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 10:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JsTCHQsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F70C2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=whMBr9XbI2cdgog48RwQlOb3YxxZirRbcN5LuIuJ+q4=; b=JsTCHQsb1QOZeK
	YekIXOsuF57CrKJxNm3iXpKjkCwlcwKwh7unZ7pZdWJiR1AUElZKVTWT7/phlZjpS1Pkbam9PR3iA
	Zxan1L3OyxtVuq0YjGOJiLSeZRPiUMaAwA5PYwVBPa2FnYqEA4T3JcadNrLQ+GiXOPe/Fpl+Xn0C7
	NyVuYy53GgaMHFgOStiLNCFYnu1Q+2kZQ8dRVzZlmDnIIcmS5HkyLJZKYBcpw8pSarFEE+XlYr9Z+
	cMJwA9qkU+r7Wde/DO2f67gjOADdOUV7pZ2aahoFSgg9xNEgiWt1NVT4hJ93t5wSeiDBn6pV4sEfg
	FMgUPdUUzZDfetng93Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic5Ey-00013L-Dh; Tue, 03 Dec 2019 10:17:08 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic5Ev-00012u-DP
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 10:17:06 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1ic5Et-0008B6-Nz; Tue, 03 Dec 2019 11:17:03 +0100
Date: Tue, 3 Dec 2019 11:17:03 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH 3/3] nvme/pci: Poll for new completions in irq thread
Message-ID: <20191203101703.34vjkhvoz7og6rkg@linutronix.de>
References: <20191202222206.2225-1-kbusch@kernel.org>
 <20191202222206.2225-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202222206.2225-4-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_021705_604086_780785AA 
X-CRM114-Status: GOOD (  13.03  )
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
Cc: ming.lei@redhat.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2019-12-03 07:22:06 [+0900], Keith Busch wrote:
> A controller may post new completions while the irq thread is handling
> previously seen completions. Have the irq thread poll for these as long
> as new completions are available. This improves bandwidth and reduces
> CPU time spend in irq context.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 634c96bafb70..44d8f701dce8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1040,7 +1040,9 @@ static irqreturn_t nvme_irq_thread(int irq, void *data)
>  {
>  	struct nvme_queue *nvmeq = data;
>  
> -	nvme_irq(irq, data);
> +	while (nvme_irq(irq, data) != IRQ_NONE && !need_resched())

as explained earlier, the need_resched() usage here will not do what you
expect it to do.

> +		cpu_relax();

Why cpu_relax()?
If you need to acquire a lock and spin then cpu_relax() may give the
other hyper thread a higher priority (POWER) or remove all speculative
writes from the pipeline (X86). This is beneficial for the locking
process, none of this seems to be required here.

> +
>  	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
>  		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
>  	else

Sebastian

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
