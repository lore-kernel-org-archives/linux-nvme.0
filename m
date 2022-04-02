Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25DFC433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zq87PVKSIAHO6m6STCCI/a2Mxm4HQsBM/bwW1PQ63NI=; b=BvQzDPGqGFb3StspMT2frcjmHJ
	GB1vd+SiqBzKIAR91xoY7P6xwUDWNcCrjj2G7GoOS3n5heGigffqg57cCJ0ZWXP7fG7nrdxUEqPj3
	jnYaSesqSZd3StbfbC6KCH0wT7hQmFLqdzmAL1+5ms7EtCaGc8NY2dloh8WvKRPAiaOyjP9xU7Cb9
	AkNhd5I5HrxIGQIejZsGAQDAqD1JGfbh9K8ZriPTCV0JzUJzAgU19jCcTeDCU0SypPbqFjblsCHZv
	vyC1864XBuRn3zCo3J/JmRA832cIh7DbzhtfCHAMjlIPOn39/3km3cTYjsUvst4Hq2j96DqJzTCx/
	a4B+8YIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naebf-009Edj-Se; Sat, 02 Apr 2022 14:19:59 +0000
Received: from soltyk.jannau.net ([144.76.91.90])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naeH1-00950K-N9; Sat, 02 Apr 2022 13:58:41 +0000
Received: by soltyk.jannau.net (Postfix, from userid 1000)
 id B92FB26E7A7; Sat,  2 Apr 2022 15:58:34 +0200 (CEST)
Date: Sat, 2 Apr 2022 15:58:34 +0200
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@svenpeter.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 DTML <devicetree@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220402135834.GC10474@jannau.net>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev>
 <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com>
 <7876eb84-9803-48dc-ab6b-27d49858e27a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7876eb84-9803-48dc-ab6b-27d49858e27a@www.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_065839_946938_D54027D4 
X-CRM114-Status: GOOD (  14.75  )
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

On 2022-04-02 15:34:55 +0200, Sven Peter wrote:
> 
> 
> On Tue, Mar 22, 2022, at 14:38, Arnd Bergmann wrote:
> > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
> >
> >> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,
> >> +                                    dma_addr_t iova, size_t size)
> >> +{
> >> +       struct apple_nvme *anv = cookie;
> >> +       int ret;
> >> +
> >> +       if (iova)
> >> +               return -EINVAL;
> >> +
> >> +       bfr->buffer = dma_alloc_coherent(anv->dev, size, &iova, GFP_KERNEL);
> >> +       if (!bfr->buffer)
> >> +               return -ENOMEM;
> >
> > You pass 'iova' as an argument, but then replace it with the address
> > returned by dma_alloc_coherent(). Can you remove the function
> > argument?
> 
> Yup, will remove it.

You can remove it but we will have to add it back once we submit the dcp 
driver (display co-processor). dcp is initialized during boot and uses a 
single pre-allocated buffer which needs to be mapped instead of 
allocated. It seemed easier to make apple_rtkit_ops.shmem_setup() 
omnipotent than adding a different function pointer for this case.

Janne

