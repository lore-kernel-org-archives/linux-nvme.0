Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135EDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Alc7swFel3WD8GOa0GGRajMrBzu9k/Oa9Qxx7K+bKs=; b=sIeX2eH9+TeeeUXn5jskTqiXEd
	iLP+kWSSmqU0v7kMBV93Vj3T82i81VkGHJQX3gfYzkf/OikFSEY1LdF/srH00NKPbwffx/cnsEPNb
	ysw52isPfHMQ7ZiXpBBoj5CvkNjGh6dq7t2/GWVxicxqQnh7LuNEd9Mtx2OLJuUHn8aDB8LLzJ6v3
	oLRpjhRcOsA47YDEcdbecuHTNgvcFFB/LCdU0Wgno4pJ2z51Hco/R8zdSLbGg4ydda1vUXywU5OlH
	tPuQl4yN1bsnj9dUrBX5vn8jq+SqsZxZWjHuUpRS20u9Np47OMUkc1ywir9w7JK3oObi8bqcuJ1+n
	vIQ9ipuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWLb9-008YQw-LR; Mon, 21 Mar 2022 17:13:39 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWLVe-008Wjc-BU; Mon, 21 Mar 2022 17:08:00 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3sZy-1oEEsl3dxI-00zpyj; Mon, 21 Mar 2022 18:07:55 +0100
Received: by mail-wr1-f51.google.com with SMTP id h23so20996723wrb.8;
 Mon, 21 Mar 2022 10:07:55 -0700 (PDT)
X-Gm-Message-State: AOAM531QCEct8lBbgV0Z1zgNUW/bNEwHYj1JVvZQ6N37IsZSftlaWRxq
 xDouG88OL5MoQ0Nx/Ni3CxJqUAAEM0ApJ9CPN0A=
X-Google-Smtp-Source: ABdhPJx6MHhqkAvOy0JZEms7/OkO2Fr4RTDieOC7Br0m0C9w79kl+lSWh1wtvyZJHGHM/grNNQMAlhnKIL9hf8+TURs=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr19427005wrh.407.1647882475232; Mon, 21
 Mar 2022 10:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
In-Reply-To: <20220321165049.35985-5-sven@svenpeter.dev>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Mar 2022 18:07:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
Message-ID: <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, 
 Marc Zyngier <maz@kernel.org>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0cVVKYqW/wuhD+kfRuaG0dXN9krD2Jb0txJSCXIVXMRi/EeK4qs
 CVAVwmwop5RVOVCG1/WDym2mEA4S6XyVPvqutUs5uvmv0Y0mjDELWqeq7B3qaC6WJHbjuWF
 KeeeigOuPlFwcmR5WoJNbLOnDGQHbl66xZYDIonQPDecd7bk4hHfOrRj1mmh1D/gig7wfbG
 U/vx8NWphPrhJQ3vtGrCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R4s9LA5vw0g=:wRF+CZPZ2b63lv0hPC4WeA
 xkJbfBpgT9F5OsFQYa4FO5KBK4LgjZIric56pgE8Wz1qkEx8JIiLPF4QgWpOo/J82lim9YcI4
 zovUkCs63kwzyCiYf3pjq6JDUHDz1iG1k+RC+aRueoTz7NbHgwSypiafr0Pqnxe8+uw/DNFTG
 Ko2t4j4rHxhvUQjTaUFg/5MpeazfIdD8rzJet5Ew9tvHazjpzEBGpfu0uhNDBwWBNXRpvpE89
 nCQeJcxNH0oRyW46ezxNXNhCm8TJcpfPUblpD39spT7KrHsusPJCYKTq6u0kJe8tgyxXMSQLh
 bOXHsW2+YLbxmdROsdw7hSpBXgCkhjDCk/MBeLTfmrSm2C9FYfjeHsSOHU7c5CdATEIP9V88v
 uB2kHVVawAHf7D7MSXwzEkK+X9N0FvJvgsT6FHmmtJWGA7T5OF4n+7QTUjIwOMDM7bUkIHg/Q
 dps5KnDxij+8MOSJGLGUb5flHhOxBnZsVbwafFWZUTlrEe0dS9OOf9BF0AygfbbRCJ5YnpGKB
 Jwc7+Fhu50E/ojOpZnzAjJ/UNUCf9IloZtXYG3n4BRFVTpzslfzOyfS9s3Oc2SYkS76QCKeR3
 msudyMI2H8tWQtUpleqPs2V140v1vHyNUJje8ZP7Bpgbf9pv9deoDSUSg3M1wssaxUvuzTfh8
 gZcYXj7AN1sIf6dTD/BYP0qxJCi7UAcuvZLjHOyUGD0UWtbua9kry+WQoILPVcabpXoY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_100758_726142_3F5F007D 
X-CRM114-Status: GOOD (  15.81  )
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

On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> The NVMe co-processor on the Apple M1 uses a DMA address filter called
> SART for some DMA transactions. This adds a simple driver used to
> configure the memory regions from which DMA transactions are allowed.
>
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Can you add some explanation about why this uses a custom interface
instead of hooking into the dma_map_ops?

> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
> +                           phys_addr_t *paddr, size_t *size)
> +{
> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));

Why do you use the _relaxed() accessors here and elsewhere in the driver?

> +struct apple_sart *apple_sart_get(struct device *dev)
> +{
> +       struct device_node *sart_node;
> +       struct platform_device *sart_pdev;
> +       struct apple_sart *sart;
> +
> +       sart_node = of_parse_phandle(dev->of_node, "apple,sart", 0);
> +       if (!sart_node)
> +               return ERR_PTR(ENODEV);

The error pointers need to take negative values, like 'ERR_PTR(-ENODEV)',
here and everywhere else in the driver.

       Arnd

