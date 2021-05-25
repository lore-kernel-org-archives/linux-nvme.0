Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E16C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 06:22:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76149610FC
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 06:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76149610FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TCCb5rEarLWbvSDqIZVhpP7rRQ063PJXemX3Vl/rAo8=; b=cOqICxJp59d5RI
	33+f8RBbqQ8Q58Ugi1vaBc5JZrrgIivAxOfBGfrwVswPGV9st9lE9W64PZJVf6sU+BRSyhIyUt6HA
	/VOOOz/dqtXAsCA06RGyW77eiB1Jw6+VYEY2RirYXpoi7SoF9an+JvuZtZRx0+RxvWtGEtMz04YGD
	sO8w1fRuBlw/Psjc8C+0s0pnuLR2qwBHWpM57uN3rrI5bfQDWpJSA2mqspHuSagYWqgtWzJlUsIBG
	enYzwvqI1zXVlYVdVg4Dn8ooZQGBgfSXAy3zpTlNdA4q+y2Y+Dh85T8x86T/kvTnHC8k44uQZL+rT
	9/hKSMcxOucr4PHnBIcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llQRU-003b7Y-GP; Tue, 25 May 2021 06:21:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1llQRR-003b5x-Ma
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 06:21:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 12C0A67373; Tue, 25 May 2021 08:21:20 +0200 (CEST)
Date: Tue, 25 May 2021 08:21:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prike Liang <Prike.Liang@amd.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, Alexander.Deucher@amd.com,
 Shyam-sundar.S-k@amd.com, Mario.Limonciello@amd.com
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device
 to D3 for s2idle
Message-ID: <20210525062119.GA12561@lst.de>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_232125_909064_3F9FAA65 
X-CRM114-Status: GOOD (  13.21  )
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

On Tue, May 25, 2021 at 10:48:59AM +0800, Prike Liang wrote:
> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
> +#endif
>  
>  #include "trace.h"
>  #include "nvme.h"
> @@ -2828,6 +2831,16 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  }
>  
>  #ifdef CONFIG_ACPI
> +
> +#ifdef CONFIG_X86
> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL), /*Cezanne*/
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL), /*Renoir*/
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),/*Lucienne*/
> +	{}
> +};
> +#endif

This is completely unacceptable.  The NVMe driver could not care less
what CPU we on.  We need information from the PCI or power managment core
on how broken the power management of the root port is, not this kind of
crap in a low-level driver, with potentially many more needing the same
kind of quirk in the future.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
