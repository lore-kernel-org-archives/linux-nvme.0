Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C161C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:44:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5953D6128B
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5953D6128B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OslpIA33w4fd8SEqbgYygw+lsFvMXCgufYROkfa+cWI=; b=kwU8GFgq0cJ1bf
	wRxVqB2bpGTkg1NHZcnFi6LX3LDijiodyl3dp1HIYPkl//tQVsKfffJw4HB0Rue0U1t38RZWkwFsI
	62FvSU1vMdFT2mBwzSpmlK3wRawj5DCWU3Y9c4Bkqv7qIwooaiWHQFCydO+ifZWtcFi0gZdqPw7nY
	ggVwIw7V1lFukhLMKHw0eq6DMviyCBTPexpXlzqyjzgVX+LuQ/plHbns5O/Q6w0uyVZS/a7xWbzwR
	w159UQsWeCSP9wXqMvki302WtGUxYOR8eU20YzKYbDjZPpH16eTO00l1E/Sn+Ap81zEAnMNHpIBY7
	qy5/11nXCKQvI35sBrCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llRjt-003xdM-7T; Tue, 25 May 2021 07:44:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llRjq-003xch-4R
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 07:44:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E209367357; Tue, 25 May 2021 09:44:26 +0200 (CEST)
Date: Tue, 25 May 2021 09:44:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Koba Ko <koba.ko@canonical.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Henrik Juul Hansen <hjhansen2020@gmail.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210525074426.GA14916@lst.de>
References: <20210520033315.490584-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210520033315.490584-1-koba.ko@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_004430_343690_B152070F 
X-CRM114-Status: GOOD (  15.65  )
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

On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> After resume, host can't change power state of the closed controller
> from D3cold to D0.

Why?

> For these devices, just avoid to go deeper than d3hot.

What are "these devices"?

> @@ -2958,6 +2959,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
>  
> +	if (pm_suspend_via_firmware() || !dev->ctrl.npss ||
> +	    !pcie_aspm_enabled(pdev) ||
> +	    dev->nr_host_mem_descs ||
> +	    (dev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {

Before we start open coding this in even more places we really want a
little helper function for these checks, which should be accomodated with
the comment near the existing copy of the checks.

> +		pdev->d3cold_allowed = false;
> +		pci_d3cold_disable(pdev);
> +		pm_runtime_resume(&pdev->dev);

Why do we need to both set d3cold_allowed and call pci_d3cold_disable?

What is the pm_runtime_resume doing here?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
