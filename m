Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD797C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHfKAK7iNvC8zDpuOI6R3eFNe9nJ9jjIRuQwH+JNntk=; b=dTlLbhdpqplyyQ+UjnlWKJruPn
	ufl+1W0exv68MVzQBUkEfDXTVbBDlQduSXuQtX3WNCgGr8oRFSaaQyxbuui56rNhL27ysU8VGDD+U
	vW0bf9n4oFAn/cA+32060r8FxS8igOBbjzcoIPpCc9O2PPMW6Rjf9zPnByadddjnzCLY3VZqT5ks0
	OzCsJnwUcDqmL6Lr81RDdOoE1t/vAWmN0aK6vGshwzLH2UR/oFLZUl15Hh9tcGG/xPhlKE7eWEzQV
	tszlB2YUXqaq0hJ5QFty/FsU8F0efppiCEmPn33yOqOGxuW7nTcmiRo8scWoj0JK2SMV+hFsW+5X0
	cP/MoIKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWejB-00B5cc-Eh; Tue, 22 Mar 2022 13:39:13 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWeiz-00B5aW-F1; Tue, 22 Mar 2022 13:39:03 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1q8m-1nUSro1K36-002DFh; Tue, 22 Mar 2022 14:38:56 +0100
Received: by mail-wm1-f43.google.com with SMTP id
 k124-20020a1ca182000000b0038c9cf6e2a6so1776760wme.0; 
 Tue, 22 Mar 2022 06:38:56 -0700 (PDT)
X-Gm-Message-State: AOAM532uF1Sdi+rFlwcbP2IDQdaJrd6otAtoTkYzmFKMcWmj5Qg+GUJW
 cMnyIMu10I7HkJphqqFdntPbgUPXqU57WIRK+wE=
X-Google-Smtp-Source: ABdhPJzs3QeOlZNcBzENKO3A5fNgCdfHUg3y8+9tjOUu6Mb84GKwxwBSCBHL98AVKD2sOKEDH/Q+ERdYLiTXX/5v0oE=
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id
 e15-20020a5d6d0f000000b0020391571c48mr22098146wrq.192.1647956335843; Tue, 22
 Mar 2022 06:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev>
In-Reply-To: <20220321165049.35985-7-sven@svenpeter.dev>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 22 Mar 2022 14:38:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com>
Message-ID: <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com>
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
To: Sven Peter <sven@svenpeter.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, 
 Marc Zyngier <maz@kernel.org>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FXCdA91iBNQZbKoWTwuu+mBIXehbkHhIAErJo2JhccV/B+jEjdS
 OJfGBirdafBtdz4+WqMqE9Ua5Qb2wAxtar/5A9Id8uZ4pgjD8609/CuzBptMM2SD7lPqxih
 0B76gxJ2MK0K+6yTQILkDI7OxgTrKQeFEHe4uM6w+/ngEVn1rtVO4KQEfq4GXZ6C6QfyPPF
 OFbb2sjqvoLQh67fW7xfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ODrLw8T9tNc=:f7qtwbHHsWaOuBFp9xT+mB
 Z5UFDTxOyGfzvkgxaGlNFf1jz1a9zYCLo9qUsONhz5QoCBVkxzjuHSf1FyzUfUvjvNQgCsaUl
 rq0yGHwFmK4MnYfhk5B11EvopNcVFjIX51WKqDMVIuBHhXhQm260OpIMvxOtvibsh52r2W7zb
 GXdOInoyJw6qq10slvbiciMeT83nSeur3BR5Rjj3QeORwI+S19eAUMW0sSFkaf0XuJcCnKFle
 IsDoXTMzZ0hJPYLByNjfcXXjoD0BWi+YZ7xt1WsrmoW/Odt1khCuaw5UTV0Wf8Z+CPJdo66Re
 eEfaTwPOGFEa7Kp9O0bHkXgEE8tChhcT1g8TufveHhePCRyqDepJQlvAkZv7FM81l+sB1rq36
 AbHtV6+m1VZ1JfIIsbMocehGoTY6QX02anWCMIyjq3kIRqe19cBj7U4M+Y2dX8+SkGTbN/30E
 2tKvVxoBMvN9GsPSda5J9WRdJ9hrXR0qNloePJ9oVKD3lCG3RifhCWVkqCvWZdk6FKsofAaOC
 z9glROdhvrJUNAAJV5nb71bC8w0Dgsf7TXa0DjfMAVcJ4wXHN/Tzu85XVrix7Rb/OKXjTnRde
 +tAzIuJqhve1rbDaQ4HLvKZRGu2GtrHDxeRmTx8o1twFVSiaBons0OmA030hKgms2lh47UA1b
 lot1pc4AA3HrowVfTHKsz5qBSTagJtUq05RQlvwYdK3z/bZ1Sj0p++3zgAmxauY0rcyltis7z
 sN+qtLNPNoCpECLqxGXnKkFrqITsH1MO/AoTh6oyg4Ou+xx+9iYD/8Mo+Wb1O/JcPcubiYTkp
 WbDoR46cxjGY2LveT/PgwQctG9gDBudLXElGmieM5UiV4+VyAc=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_063901_805586_82AE06A6 
X-CRM114-Status: GOOD (  23.37  )
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

> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,
> +                                    dma_addr_t iova, size_t size)
> +{
> +       struct apple_nvme *anv = cookie;
> +       int ret;
> +
> +       if (iova)
> +               return -EINVAL;
> +
> +       bfr->buffer = dma_alloc_coherent(anv->dev, size, &iova, GFP_KERNEL);
> +       if (!bfr->buffer)
> +               return -ENOMEM;

You pass 'iova' as an argument, but then replace it with the address
returned by dma_alloc_coherent(). Can you remove the function
argument?

> +static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
> +{
> +       struct apple_nvme *anv = queue_to_apple_nvme(q);
> +
> +       writel(tag, anv->mmio_nvme + APPLE_NVMMU_TCB_INVAL);
> +       if (readl_relaxed(anv->mmio_nvme + APPLE_NVMMU_TCB_STAT))
> +               dev_warn(anv->dev, "NVMMU TCB invalidation failed\n");
> +}

I don't like to see the _relaxed() accessors used without an explanation
about why that helps. Please use the non-relaxed version, or make sure
it's obvious here why you use it.

> +bad_sgl:
> +       WARN(DO_ONCE(apple_nvme_print_sgl, iod->sg, iod->nents),
> +            "Invalid SGL for payload:%d nents:%d\n", blk_rq_payload_bytes(req),
> +            iod->nents);

I think you mean WARN_ONCE() here?

> +       writel_relaxed(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
> +       (void)readl_relaxed(anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);

What is the purpose of the readl_relaxed() here? It looks like you are
trying to flush
the write to the hardware, but then again

  a) on Apple hardware, the registers are mapped using PROT_DEVICE_nGnRnE,
      so MMIO writes are never posted

  b) the read is "_relaxed", so there is no barrier, and the result is
unused, so
      it would appear that the CPU can just keep executing code anyway.

Since this is all the initialization path, I can't imagine what the
relaxation of
the barriers helps with.

> +static int apple_nvme_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
> +{
> +       *val = readl_relaxed(ctrl_to_apple_nvme(ctrl)->mmio_nvme + off);
> +       return 0;
> +}
> +
> +static int apple_nvme_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
> +{
> +       writel_relaxed(val, ctrl_to_apple_nvme(ctrl)->mmio_nvme + off);
> +       return 0;
> +}

If you have generic register access functions, don't make them use
_relaxed internally. If there are instances that need to be _relaxed,
add another version of the accessor that spells this out in the caller.

       Arnd

