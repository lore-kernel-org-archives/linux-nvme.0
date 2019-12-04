Return-Path: <SRS0=IJIS=Z2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B62AC43603
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 10:10:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EEA2077B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 10:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L3zj5hg8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="omyvp8X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EEA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UCz3JqL5j1j5ChYfH7V1CeIKfxWoX7lLegWVoBVZzBs=; b=L3zj5hg8iGr5i8
	HvrekrOtgFm8BfcPnpsHSBHKAFg9avMZRuA4R99JVEbhMprBFlr/zr2MyMTquSvtMtsP6Vzwse7aG
	zTZi3Q+nzeLKllfVLwAFhJRpNLJjcVuKm5W9etoyDkLI6V4TyeLyUMqZRBM7+8mYvjheARl/THtob
	PEtleIjoBvietw/hqlUTGrcwJ8xtD9qWiK6vk7g12yMUZDdzm4hMe98uTZUMQsVM/10tG6V6P29f3
	BSxIH/tQX4JdS7vqKkEOS5uQIz2fhv3eUtcT9VDDDlwu85StuYEtbYEVe9bYkk/ood7PPLivGz3IG
	aB+yJHcqGZRmrINnirFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icRbz-0005yq-9C; Wed, 04 Dec 2019 10:10:23 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icRbt-0005qA-Er
 for linux-nvme@lists.infradead.org; Wed, 04 Dec 2019 10:10:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1575454218; x=1606990218;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=fQcLV/9TxY4vRmBx4wKOVzImS4+ssTrQWoceGlrA4+M=;
 b=omyvp8X4W64UV2bkbgJ2tFi9pxn+0Il77Q+hmlLD03+X+Wy1PXQFttZx
 KeAT5xbCNQ8d1pjJUGyg1Eu71G5LGvoBAmgDWoaz0IzfUPob0lgGG7Bg8
 3wsPLXDEkoone9quPncQvjUOPVdrE+OQkicON/N1B2wcItvAgBQTkIKWI A=;
IronPort-SDR: sioRnTsKW2Q002NZvQpp3/ylNi0/vaXJP+993D/ivSsFMoht/lNCJBNWco+cieKgsYT+9kEtqZ
 JfA069Tip9Fw==
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="7055100"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.124.125.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 04 Dec 2019 10:10:09 +0000
Received: from EX13MTAUEA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (Postfix) with ESMTPS
 id 0E3D8A1F0B; Wed,  4 Dec 2019 10:10:08 +0000 (UTC)
Received: from EX13D02EUC003.ant.amazon.com (10.43.164.10) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 10:10:07 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D02EUC003.ant.amazon.com (10.43.164.10) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 10:10:06 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1367.000;
 Wed, 4 Dec 2019 10:10:06 +0000
From: "Sironi, Filippo" <sironi@amazon.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme/pci: Mask device interrupts for threaded
 handlers
Thread-Topic: [PATCHv2 2/2] nvme/pci: Mask device interrupts for threaded
 handlers
Thread-Index: AQHVqV8ShGY41+2Kok2clw5A6JZfgKepw0GA
Date: Wed, 4 Dec 2019 10:10:05 +0000
Message-ID: <1646A1C5-C2E3-46CD-9269-115601132C4B@amazon.de>
References: <20191202222058.2096-1-kbusch@kernel.org>
 <20191202222058.2096-3-kbusch@kernel.org>
In-Reply-To: <20191202222058.2096-3-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.133]
Content-ID: <98B3B4CE439E704FAEDF67C1096C2A74@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191204_021017_634710_165D76E0 
X-CRM114-Status: GOOD (  16.81  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On 2. Dec 2019, at 23:20, Keith Busch <kbusch@kernel.org> wrote:
> 
> Local interrupts are reenabled when the nvme irq thread is woken, so
> subsequent MSI or a level triggered interrupts may restart the nvme irq
> check while the thread handler is running. This unnecessarily spends CPU
> cycles and potentially triggers spurious interrupt detection, disabling
> our nvme irq.
> 
> Prevent the controller from sending future messages. For legacy and MSI,
> use the nvme interrupt mask/clear registers. For MSIx, use the quick
> control mask function.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> drivers/nvme/host/pci.c | 28 ++++++++++++++++++++++++----
> 1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0590640ba62c..4022a872d29c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -13,8 +13,10 @@
> #include <linux/init.h>
> #include <linux/interrupt.h>
> #include <linux/io.h>
> +#include <linux/irq.h>
> #include <linux/mm.h>
> #include <linux/module.h>
> +#include <linux/msi.h>
> #include <linux/mutex.h>
> #include <linux/once.h>
> #include <linux/pci.h>
> @@ -1036,12 +1038,29 @@ static irqreturn_t nvme_irq(int irq, void *data)
> 	return ret;
> }
> 
> +static irqreturn_t nvme_irq_thread(int irq, void *data)
> +{
> +	struct nvme_queue *nvmeq = data;
> +
> +	nvme_irq(irq, data);
> +	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
> +		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
> +	else
> +		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMC);
> +	return IRQ_HANDLED;
> +}
> +
> static irqreturn_t nvme_irq_check(int irq, void *data)
> {
> 	struct nvme_queue *nvmeq = data;
> -	if (nvme_cqe_pending(nvmeq))
> -		return IRQ_WAKE_THREAD;
> -	return IRQ_NONE;
> +
> +	if (!nvme_cqe_pending(nvmeq))
> +		return IRQ_NONE;
> +	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
> +		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 1);

Have you considered that __pci_msix_desc_mask_irq will cause
a trap from guest to hypervisor mode when running virtualized?

> +	else
> +		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMS);

What's stopping us from always using this method?

> +	return IRQ_WAKE_THREAD;
> }
> 
> /*
> @@ -1499,7 +1518,8 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
> 
> 	if (use_threaded_interrupts) {
> 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
> -				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> +				nvme_irq_thread, nvmeq, "nvme%dq%d", nr,
> +				nvmeq->qid);
> 	} else {
> 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
> 				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> -- 
> 2.21.0
> 
> 
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
