Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D8FC3DA78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vqe2awhsOiuy9AyNPpvJ0a+YmpPZRYtxmL79wj217Lg=; b=z4JwzZCf5I8Tk1jOYzrGOSU+d0
	9Wtv5hSyEWToyP/tCmn5K2zMGL2i3QFZiGPhURwVXdcLYFLaOkfNiCApG1TGvSZTLhCxzdT1ouK3y
	67UfpNoa5DCm0cXtAPOWUBOdygnktuJB5SA9Oi7tlaNUPKqIqaJ0x/hRT6+e030qxnOtrdz9Esh4h
	WhkoDGL0Bv7zgJhPhviAEh0mJYoInMkomC/VOOE2jh1CI1/mlE98Ne02UkuAFz338+Xf5Y+mx177D
	Wk5vB5g+fgG5OcNbIvh32LzfItTl4tKWhZgZ51XsJfhVrIq0fSe+gz61tAnMEKQpmBvcCuTmC0vlI
	5UsOyERQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHoUm-00F1mG-MA; Tue, 17 Jan 2023 16:07:33 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHoTD-00F0zh-R5
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 16:05:57 +0000
Received: by mail-oi1-x22b.google.com with SMTP id s124so9461889oif.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vqe2awhsOiuy9AyNPpvJ0a+YmpPZRYtxmL79wj217Lg=;
        b=LxA2fNAJzJqc2ZPC1iDNRKCva61BCwRKbIHv232B7K6OIIVHbOE9EumZRrF/ip0XHz
         CrpBq7shPgoiTzfChjRn+JhH1v+cgHBiwjSRa4lTavhe733sk3tI9dLA/yhAGPt0bpQk
         2rW+dSCcZ+vwg6vaE57bf/rdlDX8eZDjhL1x0l2rg2gk5u/cOZAphgndpteS0YUzMD00
         RTmjiL7Fi/5tMO4DvSBv2V91Xi4BSzE+2jbr5TbK1ByzC0GYUGkNzggRdvwwJqcQ39Mz
         Bpcov3vlpXn8LjHtv2HSSsPWhdW3x7ZgMA+gJgHhunBGKBIgOAtPodnvoPt2ohg0kolH
         dDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqe2awhsOiuy9AyNPpvJ0a+YmpPZRYtxmL79wj217Lg=;
        b=6PwFbuWISIAiujAlpNvDQPzVqUnaJVLn9veorEtIfvmMQF5FUsKIJ0TLADEYjhZkmB
         gkLjD5B5yh6v/ci07aRlqkH+OxXAHumMIUTLMimYCCmjpguplXWecHv1PWyXUWDHItfl
         Ql3QAGmQiczUOlTvNHOK1tsQZfAd7nuX+rq7Fso+HSQgOPHRodyF8WU9M12+LtcjgWXw
         glvAvLLeKZOocZ/plpCp/ffrOlhRvSvAhUCCwr2x8Ve1axj/krg8tLrj8hRXfA6cRnM5
         IOZzocQYQf91TrJvcJQ+diFOysv9suk7omz99ozcybUluh+K+lJtUDexJ5HASnsaBbyi
         z9sA==
X-Gm-Message-State: AFqh2koHP/wV8GPc5dc4yjr1Rwz4xU72befO7JSeK2+UJd8Uni6neCW/
	nxVKduqGKCvAuDPHXefJRmc=
X-Google-Smtp-Source: AMrXdXuu49pmZp5zzLMiRnctE9uqswGtnT222UhRv1DiISpkyaY1JiAHFqoxzALh0DjajIA3MFcwOA==
X-Received: by 2002:a54:4592:0:b0:364:b798:9ab3 with SMTP id z18-20020a544592000000b00364b7989ab3mr1570387oib.36.1673971552924;
        Tue, 17 Jan 2023 08:05:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808008400b0035028730c90sm14807814oic.1.2023.01.17.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:05:52 -0800 (PST)
Date: Tue, 17 Jan 2023 08:05:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <20230117160550.GA3091262@roeck-us.net>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8W+H6T9DOZ08SoF@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8W+H6T9DOZ08SoF@cormorant.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_080555_921865_2448382A 
X-CRM114-Status: GOOD (  24.72  )
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

On Mon, Jan 16, 2023 at 10:14:07PM +0100, Klaus Jensen wrote:
[ ... ]
> 
> I noticed that the Linux driver does not use the INTMS/INTMC registers
> to mask interrupts on the controller while processing CQEs. While not
> required by the spec, it is *recommended* in setups not using MSI-X to
> reduce the risk of spurious and/or missed interrupts.
> 
> With the patch below, running 100 boot iterations, no timeouts were
> observed on QEMU emulated riscv64 or mips64.
> 
> No changes are required in the QEMU hw/nvme interrupt logic.
> 

Yes, but isn't that technically similar to dropping the
interrupt request and raising it again, or in other words
pulsing the interrupt ?

I still don't understand why the (level triggered) interrupt
pin would require pulsing in the first place.

Thanks,
Guenter

> 
> diff --git i/drivers/nvme/host/pci.c w/drivers/nvme/host/pci.c
> index b13baccedb4a..75f6b87c4c3f 100644
> --- i/drivers/nvme/host/pci.c
> +++ w/drivers/nvme/host/pci.c
> @@ -1128,6 +1128,27 @@ static inline int nvme_poll_cq(struct nvme_queue *nvmeq,
>  }
> 
>  static irqreturn_t nvme_irq(int irq, void *data)
> +{
> +       struct nvme_queue *nvmeq = data;
> +       struct nvme_dev *dev = nvmeq->dev;
> +       u32 mask = 1 << nvmeq->cq_vector;
> +       irqreturn_t ret = IRQ_NONE;
> +       DEFINE_IO_COMP_BATCH(iob);
> +
> +       writel(mask, dev->bar + NVME_REG_INTMS);
> +
> +       if (nvme_poll_cq(nvmeq, &iob)) {
> +               if (!rq_list_empty(iob.req_list))
> +                       nvme_pci_complete_batch(&iob);
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       writel(mask, dev->bar + NVME_REG_INTMC);
> +
> +       return ret;
> +}
> +
> +static irqreturn_t nvme_irq_msix(int irq, void *data)
>  {
>         struct nvme_queue *nvmeq = data;
>         DEFINE_IO_COMP_BATCH(iob);
> @@ -1602,12 +1623,13 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
>  {
>         struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
>         int nr = nvmeq->dev->ctrl.instance;
> +       irq_handler_t handler = pdev->msix_enabled ? nvme_irq_msix : nvme_irq;
> 
>         if (use_threaded_interrupts) {
>                 return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
> -                               nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> +                               handler, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
>         } else {
> -               return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
> +               return pci_request_irq(pdev, nvmeq->cq_vector, handler,
>                                 NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
>         }
>  }
> 
> 



