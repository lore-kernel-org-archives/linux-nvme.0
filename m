Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E43C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:CC:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sLlTjQcr0Op/6Zcx8OCFNh8EO9JbDZcvu4VpyKatzLc=; b=Kco2dhlxZ+UAoyHjuM0n9/rtGu
	q9x6UIpF0NjIp6vNzn3K0btZhXSCnEV1erd/J7zPacTgWdE08s4nr8PgsXrIJJZeTdzzyQIyNzXuU
	l2s+n3KggmodhngC/N91b1H+d9TOh7hfopmKSinxAmXL2KszqdKTEMorTybRAmERu7OkSDeCfdb17
	fgPJfSO4pJg1DzwkE+SOiyKE2BwQCG+j0KAuxMXIcooG+yk257OmpptOuAkI+pdwrfbAUDkomB94F
	GLZKBtKWZxkdiF1Hiiz3h03HxRK8vtHRne0+LyMPSa2eR2pefUd7NSN/vBgnPTviOZylzFz0iFtC0
	qR0kV2aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohx0N-001iYW-Uu; Mon, 10 Oct 2022 17:55:56 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohx0L-001iWT-4e
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 17:55:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1665424553; x=1696960553;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=sLlTjQcr0Op/6Zcx8OCFNh8EO9JbDZcvu4VpyKatzLc=;
  b=rQMwrqBYTOQDBZveY0Lel3/yssp1GC3vpA4bwurygrznCES2qO185Wwx
   xJq0JdEB9EHiPGcHu3Vy3PUh4mNcYNGlTDF70PPb19QKLU7ypNHlZ7LWU
   VJ7YNDWSpSKHAZfTEjb/g5JeY7vCbPMC81WJL9PegKe7nonvhrfLUaTHx
   8=;
X-IronPort-AV: E=Sophos;i="5.95,173,1661817600"; 
   d="scan'208";a="250379094"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-6fd66c4a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:55:45 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-6fd66c4a.us-west-2.amazon.com (Postfix) with ESMTPS id BBF55A25CF;
	Mon, 10 Oct 2022 17:55:44 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 10 Oct 2022 17:55:44 +0000
Received: from [192.168.25.29] (10.43.162.230) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Mon, 10 Oct 2022 17:55:43 +0000
Message-ID: <b73250f3-2dd6-36da-4d69-3149959f2e67@amazon.com>
Date: Mon, 10 Oct 2022 10:55:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH v2] nvme-pci: Set min align mask before calculating
 max_hw_sectors
Content-Language: en-US
From: "Bhatnagar, Rishabh" <risbhat@amazon.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"Bacco, Mike" <mbacco@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Park, SeongJae" <sjpark@amazon.com>
References: <20220929182259.22523-1-risbhat@amazon.com>
 <EB43F4D1-BFD0-408B-93E7-10643B59F766@amazon.com>
In-Reply-To: <EB43F4D1-BFD0-408B-93E7-10643B59F766@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.230]
X-ClientProxiedBy: EX13D38UWB003.ant.amazon.com (10.43.161.178) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_105553_368512_267B5B18 
X-CRM114-Status: GOOD (  19.78  )
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


On 10/4/22 9:27 AM, Bhatnagar, Rishabh wrote:
> On 9/29/22, 11:23 AM, "Rishabh Bhatnagar" <risbhat@amazon.com> wrote:
>
>      In cases where swiotlb is enabled dma_max_mapping_size takes into
>      account the min align mask for the device. Right now the mask is
>      set after the max hw sectors are calculated which might result in
>      a request size that overflows the swiotlb buffer.
>      Set the min align mask for nvme driver before calling
>      dma_max_mapping_size while calculating max hw sectors.
>      
>      Fixes: 7637de311bd2 ("nvme-pci: limit max_hw_sectors based on the DMA max mapping size")
>      Cc: stable@vger.kernel.org
>      Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
>      ---
>       Changes in V2:
>       - Add Cc: <stable@vger.kernel.org> tag
>       - Improve the commit text
>       - Add patch version
>      
>       Changes in V1:
>       - Add fixes tag
>      
>       drivers/nvme/host/pci.c | 3 ++-
>       1 file changed, 2 insertions(+), 1 deletion(-)
>      
>      diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>      index 98864b853eef..30e71e41a0a2 100644
>      --- a/drivers/nvme/host/pci.c
>      +++ b/drivers/nvme/host/pci.c
>      @@ -2834,6 +2834,8 @@ static void nvme_reset_work(struct work_struct *work)
>       		nvme_start_admin_queue(&dev->ctrl);
>       	}
>       
>      +	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
>      +
>       	/*
>       	 * Limit the max command size to prevent iod->sg allocations going
>       	 * over a single page.
>      @@ -2846,7 +2848,6 @@ static void nvme_reset_work(struct work_struct *work)
>       	 * Don't limit the IOMMU merged segment size.
>       	 */
>       	dma_set_max_seg_size(dev->dev, 0xffffffff);
>      -	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
>       
>       	mutex_unlock(&dev->shutdown_lock);
>       
>      --
>      2.37.1
>      
>      

Hi. Any review on this patch would be much appreciated!

Thanks
Rishabh


