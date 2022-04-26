Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C771C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 20:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPjTIsGFJhYfCT+9p2TnOYGlkP+eckEiHcGI8s0Ozv4=; b=fQcCxl4UhOol9M1TspFq2MEQMx
	7ONLaJFwzh+czMNFtoBg9nmjSo+2pj0DRdqQUxoMFp0S5jDefnYvr4NDGJQ5zX412zzVwtHBzYq+H
	BbnNvb4Asguq8zDeCopHIbX+w84u4AZrncIgpJdvCpgEVWiwr6LkHjvMHLAemQQtbwOK1LOfQrTZO
	kAYrSb96uV1mkDCrhY96KCy/dt1lDFASuY4y5pDVhcxoR4RCczZb23eepeh6PSabXzsOVv2dFS+h1
	AiZnnJz1FgqsgpqR182ViXrlsiK1/hUm89ys6hqX83+CjG+E+i1MUg/P1+NMQ0yvF6O1FMrm1zS93
	n8noNM4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njSEF-00GElp-E4; Tue, 26 Apr 2022 20:56:11 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njSE3-00GEiK-MQ; Tue, 26 Apr 2022 20:56:01 +0000
Received: from mail-yw1-f179.google.com ([209.85.128.179]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxUfh-1o3ZXI0xez-00xpQu; Tue, 26 Apr 2022 22:55:57 +0200
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-2ec42eae76bso195857707b3.10; 
 Tue, 26 Apr 2022 13:55:54 -0700 (PDT)
X-Gm-Message-State: AOAM532jmCxJSVjJlQIEquHbnWX5FGJDQLb5xEbsrTAft988LryGg52r
 jWQ+meyVBDWXPYBgQp/dbUt7zU/2IeJrwvb3LD8=
X-Google-Smtp-Source: ABdhPJykVbC51GHiNxSRF22iubyVclEPEIn++KiZqruq+/JC2nxl37pjEPmurLqJ7gUHZrZwTtprNFSeiezKdA6Gjr4=
X-Received: by 2002:a0d:d804:0:b0:2f4:e47d:1c2c with SMTP id
 a4-20020a0dd804000000b002f4e47d1c2cmr23664046ywe.320.1651006553470; Tue, 26
 Apr 2022 13:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <20220426201539.12829-5-sven@svenpeter.dev>
In-Reply-To: <20220426201539.12829-5-sven@svenpeter.dev>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 26 Apr 2022 22:55:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a39t-yyhtVKiEvD9_FvLiVxySnJRXaOv4E4q77t6mDesw@mail.gmail.com>
Message-ID: <CAK8P3a39t-yyhtVKiEvD9_FvLiVxySnJRXaOv4E4q77t6mDesw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] soc: apple: Add SART driver
To: Sven Peter <sven@svenpeter.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, 
 Janne Grunau <j@jannau.net>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:V1DNIZS9IgPej+RB6iJHBqxRcovTymyIEdkJiTPOOawQcPjzbL6
 oOv15iDJBWtCHlL74k/vSPcY1Idxi9ugOLdx+KCS5o5gZIPtFHzFFiG2fb/WNNy76MLy+Nw
 Xm8alCKXABg3wXucGtkcI9+D0KhyJ86uNRMRE9dLAS2ZH1wrsHCzpeaTI+Nv9hPFjXHK+/d
 Ucse91UO/BdsR/KJykEXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9r6ufvZCwCE=:nM60IuBKpIF4rczeVi8sXm
 HmOEFjJAja68W0ijXoAe4HbSGqzLXntYQl2XWxqRnSKkKUtc6YmPnih1ZdghTfQDQ0cQMvxdE
 BgGDtKQkdREUgB2QOHrWwDu3oV+9ihqBtbrCS0ZRu+W5uhpwh7pviG6LK5vn6gt9Hf5gAgKeT
 LLQt39vZQrhVprxTkmzmpwIXj/v3yogczRtzaK6u0x7EbMpJokejebgBkLBPJvUUvwKbQdBd9
 1ywCw9JNiaCqVw7pm8CodYYocp8tFvKOM0WWRqr5NfPM51OPnz+Li0VlG9Z9YW6+wiN2ZwFdx
 Cyfll4gR0TwHQa7ZY9rTTEEI2/Y4AmprGw/vXeb58zfsFMHbPGd4IGGtVUoICOjdhUeB38sGZ
 1ROuT6x7Raeqr2ic8YJwSROUZZciAZY+1Ajl7Nk/1AITyxdnuI2hF+K4WGGNynur9Rvw27NO/
 f5/mAegHuhR8peUUXHPVn3Hc/73m1a/3eLizQ6KUC9onURtkr7srO6vyMSDof/vJJSjDPY1AY
 283t3KGrvHmyo+oCgonvnmCQ2tEK7ZqSU5m8/uckP+C+kQJENjSmfEfDGHcDyk9kkv78NTO/D
 Bfkmi+sI0QLbAEE/nHsgY0aZepS/0tdDmyLUXxNTwa/VAOH2uZdwDMIzrr6sJvvRAolaWRQq6
 pq8JYf/PSOtakSq/ndmuxg5Lyx+0PQGAkFvC2rfV3cwrAwioRXjTay9qz8QbKJUXgXnsoqnnA
 J08iDldOWoYRW+SqecGOyshoAWIZ3R559zhpxYHCaxH4eiwiArAFudLAu+fbVpmTV1de2JRml
 bETKIBEp0KAspfic+3FzJBG5BOaqSyhQmT4yCFrYL6DoVlJtdg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_135600_067963_4A24CAA1 
X-CRM114-Status: GOOD (  24.37  )
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

On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> The NVMe co-processor on the Apple M1 uses a DMA address filter called
> SART for some DMA transactions. This adds a simple driver used to
> configure the memory regions from which DMA transactions are allowed.
>
> Unlike a real IOMMU, SART does not support any pagetables and can't be
> implemented inside the IOMMU subsystem using iommu_ops.
>
> It also can't be implemented using dma_map_ops since not all DMA
> transactions of the NVMe controller are filtered by SART.
> Instead, most buffers have to be registered using the integrated NVMe
> IOMMU and we can't have two separate dma_map_ops implementations for a
> single device.
>
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

One more detail I noticed:

> +#if IS_ENABLED(CONFIG_APPLE_SART)
> +
> +struct apple_sart;
> +
> +/*
> + * Get a reference to the SART attached to dev.
> + *
> + * Looks for the phandle reference in apple,sart and returns a pointer
> + * to the corresponding apple_sart struct to be used with
> + * apple_sart_add_allowed_region and apple_sart_remove_allowed_region.
> + */
> +struct apple_sart *devm_apple_sart_get(struct device *dev);
> +

In general, I don't like to hide declarations in a header behind an #if. Unless
there is a good reason for doing this, just make the declaration unconditional,
which avoids recompiling when the symbol changes.

The only other effect is that you get a link-time error instead of a
compile-time
error if you messed up the Kconfig dependencies, but as long as the dependencies
are correct it will be fine either way.

      Arnd

