Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D7DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfzy/+YaLGjYVsu4j9UKN33jzuaaWPeyvHUUPpmHGK0=; b=44aQlj0xQP82WVvQmOST4fJcYU
	7J5NSdxA8G6G/NG/fE2rxEUZGvbsROLK6OlakbUSGZ5jhHa9+FLWyKJc9FvuZVAWzrIXC+wR+s9UF
	SNHu0J9e+qVVS6Iz+XEny4B9XcKe05CCkum+keVLNBRpnn6ij3bhsvHQOwU5oe+mxLX0rqNV4rIDv
	mj+wNa4RvYU3n3v8NiE9lrAe1MRuXWIEtkhM3RNxSY4d7b5ZLzKxYyoM0BVREebhomAeo4RBuBWtD
	3foUXoMETA5pceU9AuROOI3t5UNSrYXXQqW50ewgYB5sHWiYxNTg/r0hrf+9KsSMO78jNi4l72WsD
	/ajTMpEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWeL4-00B2OM-Lk; Tue, 22 Mar 2022 13:14:18 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWeL1-00B2Nn-TE; Tue, 22 Mar 2022 13:14:17 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MD9Kp-1nNbmP2BOr-00970J; Tue, 22 Mar 2022 14:14:12 +0100
Received: by mail-wm1-f49.google.com with SMTP id
 p12-20020a05600c430c00b0038cbdf52227so837511wme.2; 
 Tue, 22 Mar 2022 06:14:09 -0700 (PDT)
X-Gm-Message-State: AOAM532fjWDRjwUPCEzivzr2PS0LLwsp0RvwGtjvZTBaR22C8hjpwbeN
 MbRuZUNON9zH1JnabgZurFXUzVNmKc7i4pwPt4k=
X-Google-Smtp-Source: ABdhPJyHDWv/mDC8WwrAR2wIUWCLvYl74QCY8Bcoo4lV+G5Q4bMm4glI5YH/lSfsRyVIlxl4wVhx+pOkDz4xDrytxAc=
X-Received: by 2002:a05:600c:4e11:b0:38c:bd19:e72c with SMTP id
 b17-20020a05600c4e1100b0038cbd19e72cmr1599974wmq.174.1647954849655; Tue, 22
 Mar 2022 06:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
In-Reply-To: <20220321165049.35985-6-sven@svenpeter.dev>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 22 Mar 2022 14:13:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
Message-ID: <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
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
X-Provags-ID: V03:K1:pod3bt9j5g3uWnj8UMfhyvaQiCycy5Eibik5to3g4wbfD62Ibdc
 O2a7NBxBmyQXjuhnXzkyqObStpVnj6TTh/oFJzo51j0GfYgXtyuCP6dQ0/BLEz94IrVgLS1
 umW2QGPuwiuBjYsn0cx/M4mlUdRQJR0pdsY/V5EOt9Lw9tsW/5dDx1h+hNqzDE3NcZW1yXv
 VkwXi7RegZy4pQ6B/J6dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zgd6k2pC7Kg=:XMg7x4qvZTC7zHvdy+8u7y
 us/xbk2+9EtaC7I4zwKgeaSe1oTNe0wx63aPYV9G9TxWdqhzVPVMeqyIbnfUjSxndSl2wc4e2
 k8S0MqDipDotCT2C1aZTK43xdHLzuHyIeeH1XiQGyCKgmW/iZaGRP+9RrTTrpexCXsfyyAw8d
 B/rQzRUtL2NQrZ0AJyJelJJ92r255d5SEjPjuCVM5vmYvjZoAOn6WmPW2Bbt1GIDxX0h1/kqg
 Vuri+6OUoW1oA20+N7MARJ/O4DsKssGC3KaBEtcZ2NbOOoKlQTutbIE81p5goK36KZjXZaCfG
 UbtGKTIOBzlRioFsz5FeHfWTFodWoTorUlJfo/UpHrwbrBFc8KYItXA6NICEIrEMmVbZRsH5A
 2AL/ncWpGH40Kdip+HLM3ZW3LfnmMNScuJyGZBG0XqPaheoZOpnSVq/GjV9wNDlQWBrabwH6w
 17bSgNuoAFvb+PjWmmyplqVUMbDFEMptW1clEjN66Ez9IISZVkEi07ny7NRUZvyhThFOHGQsQ
 hVGQU19S6xgHUZX52xcA9DUc/s6QUuYCilOUtZ/fcD2rK/Ew/YWG5GRKVgiluaGJIzcfsWBO9
 xxr3wogWGxqX2mV+qJMQpqlawsFSl7HuEjVNs6yPlpc5h1lvdThKYkEA7yX5fK6d1wyeR+/nL
 ubjpOxteyTt3HmP0Py5s1DfyESclmdkrV+CGAWQFhHfBtJrVJ+Ug7M2oBNvDEp7UeDa8ho05y
 AMRbW8hrkxEUGPmbSyu9hQwWKx+qwwWqPdUr4biGnvbU6Br0jWpxOs7iXK/YwWqh4tFDo1wTU
 uAS0e9b/w3u2IMf60QYTA+ub5hRYU8dkz0ZM9y6WMZEfNqGaiM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_061416_260798_405287ED 
X-CRM114-Status: GOOD (  27.20  )
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
> Apple SoCs such as the M1 come with multiple embedded co-processors
> running proprietary firmware. Communication with those is established
> over a simple mailbox using the RTKit IPC protocol.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

> +
> +#define rtk_err(format, arg...) dev_err(rtk->dev, "RTKit: " format, ##arg)
> +#define rtk_warn(format, arg...) dev_warn(rtk->dev, "RTKit: " format, ##arg)
> +#define rtk_info(format, arg...) dev_info(rtk->dev, "RTKit: " format, ##arg)
> +#define rtk_dbg(format, arg...) dev_dbg(rtk->dev, "RTKit: " format, ##arg)

I generally don't like the custom printing macros, please just open-code
the prints where they are used, that makes it easier for other kernel
developers to see exactly what is being printed.

> +enum { APPLE_RTKIT_WORK_MSG,
> +       APPLE_RTKIT_WORK_REINIT,
> +};
> +
> +enum { APPLE_RTKIT_PWR_STATE_OFF = 0x00,
> +       APPLE_RTKIT_PWR_STATE_SLEEP = 0x01,
> +       APPLE_RTKIT_PWR_STATE_GATED = 0x02,
> +       APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10,
> +       APPLE_RTKIT_PWR_STATE_ON = 0x20,
> +};

This is an odd indentation style, I would insert a newline after the 'enum {'

> +static int apple_rtkit_worker(void *data)
> +{
> +       struct apple_rtkit *rtk = data;
> +       struct apple_rtkit_work work;
> +
> +       while (!kthread_should_stop()) {
> +               wait_event_interruptible(rtk->wq,
> +                                        kfifo_len(&rtk->work_fifo) > 0 ||
> +                                                kthread_should_stop());
> +
> +               if (kthread_should_stop())
> +                       break;
> +
> +               while (kfifo_out_spinlocked(&rtk->work_fifo, &work, 1,
> +                                           &rtk->work_lock) == 1) {
> +                       switch (work.type) {
> +                       case APPLE_RTKIT_WORK_MSG:
> +                               apple_rtkit_rx(rtk, &work.msg);
> +                               break;
> +                       case APPLE_RTKIT_WORK_REINIT:
> +                               apple_rtkit_do_reinit(rtk);
> +                               break;
> +                       }
> +               }

It looks like you add quite a bit of complexity by using a custom
worker thread implementation. Can you explain what this is
needed for? Isn't this roughly the same thing that one would
get more easily with create_singlethread_workqueue()?

> +#if IS_ENABLED(CONFIG_APPLE_RTKIT)

Instead of allowing the interface to be used without CONFIG_APPLE_RTKIT,
I think it is sufficient to allow the driver itself to be built with
CONFIG_COMPILE_TEST (as you already do), and then have
drivers using it marked as 'depends on APPLE_RTKIT'
unconditionally.

> +/*
> + * Initializes the internal state required to handle RTKit. This
> + * should usually be called within _probe.
> + *
> + * @dev: Pointer to the device node this coprocessor is assocated with
> + * @cookie: opaque cookie passed to all functions defined in rtkit_ops
> + * @mbox_name: mailbox name used to communicate with the co-processor
> + * @mbox_idx: mailbox index to be used if mbox_name is NULL
> + * @ops: pointer to rtkit_ops to be used for this co-processor
> + */
> +struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
> +                                    const char *mbox_name, int mbox_idx,
> +                                    const struct apple_rtkit_ops *ops);
> +
> +/*
> + * Dev-res managed version of apple_rtkit_init.
> + */
> +struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
> +                                         const char *mbox_name, int mbox_idx,
> +                                         const struct apple_rtkit_ops *ops);

Do we need to export both of these?

         Arnd

