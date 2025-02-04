Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A90DC02194
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WANx9O2MqxxPgH7NFbnRWmJ+E0+Q02JDckfqFnbdozU=; b=Y2tU9x7xqIYJ0AJV9wqGk0+Jxc
	HRJLmJfceCXCWaEH5z8WW8k3qeisi4IzmczXPQfhZE3oQra/YMDQDiz7WA7CErhyMtQflCUjzX6oq
	PK+7+9ViTz6Vtb4PBLXIW/OlCQP6EEF8LIyypS08SFtV4VWxRMROr4eT3Ub7N6utzXDIQS0kqmkyI
	MiBFQissu33cMJU9UXD0jebR784mNb/tjAlWzCkGOG+BecvgshlbGaAaDjVag+Gsb7IbB8lxtUtUy
	QiSHCZ6NokpX+YvSlFdqEexFdIQ3NltiyEpSIgp1Kfu5PDcMQzoUiuD16JbPejfUGXmBeUnZfUhUX
	qut1UW/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfLPJ-00000000urz-1dB2;
	Tue, 04 Feb 2025 16:04:13 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfLPG-00000000urK-1mu0
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 16:04:11 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-e5ae3fc15acso3278812276.0
        for <linux-nvme@lists.infradead.org>; Tue, 04 Feb 2025 08:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738685049; x=1739289849; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WANx9O2MqxxPgH7NFbnRWmJ+E0+Q02JDckfqFnbdozU=;
        b=iW5RQ8X0JU3x3OKj/xN/oDfrEoAyvbggzn1trxXC5VA5PvbGrCtGPdOFEnYI8Rl4la
         31emEeU2hifo1saxN96mnlektNIFnbxnhAxx1T52Nd0E1ee0Fzr7+YKxXVbi08guZL0F
         pqGZAGTj048xeJQWXDLGlQefoWcQzFlL1l1GArPwqK50LyfGlxIg+8HGQozOvU8XKw88
         UL1af4lqfLfKluGw5/38B+bN2qTaWoxeA0Avw9ioKyaJyN5JXliRfhvXK5zGmP0aJijm
         pCT16EUlWbX1asZKX9OB9dpRqEaqrejni/gzyO3qBbwC/L9SMfbdOI/RrR2/5DBummNg
         Wt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738685049; x=1739289849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WANx9O2MqxxPgH7NFbnRWmJ+E0+Q02JDckfqFnbdozU=;
        b=OEcm6LK9t/Bu89rS0WYhQIYxoCjcxokmc7tpVf0AV6C/fN4vThUsd66iwIHNAlXKbx
         V/kcwtaUxSNhE2kXkiHGhMEvL610DI/aD/CRcR1Z6Zf2MDljllSUuuVEC795jVZMRe6P
         t6F5sAba2I5cW2kFFPp6HCO9obj0FWm7t0cfrnGYDo3XlxfW57WwPnUw6meMDZM5sz5d
         3JGghvmhmNzT0Ti9LaqmEGio6XsVzzvLvMemk36bEQQAgBooyXCKQBLfoOQ09+ESR7W/
         R2WsGE7Lg1fyGlUEGjifKmLdu1H53sxLQ/XuvlrUjcOp6hXj8p3MXO0vFT2xgGSx1cDS
         x37A==
X-Forwarded-Encrypted: i=1; AJvYcCV9dvhJOY+x6TfXrx3nQvMMrCEz9OAvJkTX2+f/UZFp/vdrLUeDBh4aFJKNyaT78LzpgQzR1ayO3o6T@lists.infradead.org
X-Gm-Message-State: AOJu0YzR97GSVYNk3QZg09uA3VK5mnnuipSgwJftO2PXzvhVukHGlZRS
	oPxv2+NJtyoLKz5uRpLt+1wtq2mHP0bLcxHCg6ZMgfen3FW961nf3hXF/cs/Hamf7MyZEtpT6UT
	Fw4Ka16DymJoNCCG7d/zXBLCav3WLbm7G0h3g4g==
X-Gm-Gg: ASbGncsXhtwrE0m4Ihh2fOb6TJfggDgWg0eQimU4c2wlGuppiekF1dofV1l5azGGcZu
	vfzrgWk8waZeHPY3gHFXuOEL1Oxt0YST/RcjfjRXscy1XWzLZa3g322DZrPXLrQXJldiXp95B3Q
	==
X-Google-Smtp-Source: AGHT+IE4idesVJbfBpDU0f7s2AN3M6p3s6pKSMPlvXAD9e1BxdSCSWbd9pa0w12jqplFp2SmbkOk0RlJN0wo/OSTDWs=
X-Received: by 2002:a05:6902:2804:b0:e5a:e8e8:b1c3 with SMTP id
 3f1490d57ef6-e5ae8e8b2f3mr10122299276.9.1738685049136; Tue, 04 Feb 2025
 08:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Feb 2025 17:03:33 +0100
X-Gm-Features: AWEUYZmE6knt90eWxfiurrcN4EWivox7DsLcZz8vXGHj-AjGXDsgLjGwDSxuXJc
Message-ID: <CAPDyKFqfJmpFvNgjj3P3+vmiSooiU4sr=dnVuBfXOijPdcbt-A@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Use NVME_QUIRK_SIMPLE_SUSPEND for Qualcomm
 Snapdragon 8cx Gen 3 platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, rafael@kernel.org, 
	helgaas@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_080410_474195_36297B3F 
X-CRM114-Status: GOOD (  36.25  )
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

On Sun, 26 Jan 2025 at 06:03, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On these platforms, power to the PCIe bus is not retained if the SoC enters
> its own deep low power state called, CX power collapse state during system
> suspend. Once the SoC resumes after going through CX power collapse, all
> the PCIe bus state will be lost. So the NVMe devices on these platforms
> won't resume properly, rendering the machines useless until forcefully
> restarted by the users.
>
> To workaround this issue, the PCIe controller driver is keeping a minimal
> vote on the PCIe-MEM interconnect path in its system suspend callback
> current currently. While this gives a working system suspend, it also
> results in increased power consumption during suspend as the SoC never
> enters its low power state. So with this change, the workaround can finally
> be removed.
>
> Also it should be noted that the actual fix to this issue lies in the
> PCI/PM core. But currently there is no such fix exist as of now and the
> consensus to reach it is also taking a lot of time.
>
> So use this quirk to allow users to save battery life on these platforms
> until the PCI/PM core comes up with an API that tells the PCI client
> drivers when to turn off the devices.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

FWIW, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>
> Hi,
>
> I'm sending this patch as there seems to be no consensus so far (as been
> discussed in this thread [1]) in coming up with a PCI/PM API that tells the
> client drivers when to safely turn off the devices. Since coming up with these
> kind of generic APIs are bound to take time (I do intend to pursue), it makes
> sense to allow these platforms to make use of the existing

In whatever form you intend to continue to try to move this forward,
feel free to keep me in the loop. I am interested and will try to
provide as much feedback as I possibly can.

I can also keep an eye for a conference where we can bring this up
again, last time we discussed this was in LPC in Richmond 2023, I
think. It looks like we have some more data for discussion now, but
let's see how far we can get on LKML.

> NVME_QUIRK_SIMPLE_SUSPEND quirk in the meantime. Once such API is upstreamed and
> used in this driver, this quirk can be reverted.
>
> It should be noted that this CX power collapse issue only exist on the platforms
> based on the Qcom Snapdragon 8cx Gen 3 SoC. On other platforms, it is a more of
> a policy decision to decide whether to shutdown the devices or not. And these
> other platforms can wait for the generic API to be made available by the PCI/PM
> core.
>
> [1] https://lore.kernel.org/linux-pci/20241118082344.8146-1-manivannan.sadhasivam@linaro.org
>
>  drivers/nvme/host/pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e2634f437f33..c52dced952a1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3162,6 +3162,16 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>         if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
>                 return NVME_QUIRK_NO_APST;
>
> +       /*
> +        * Qualcomm Snapdragon 8cx Gen 3 (SC8280XP) platforms doesn't retain
> +        * power to the PCIe bus after entering low power CX power collapse
> +        * state during system suspend. So shutdown the NVMe devices to have a
> +        * working system suspend on these platforms.
> +        */
> +       if (dmi_match(DMI_PRODUCT_FAMILY, "SCP_MAKENA") ||
> +           dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X13s Gen 1"))
> +               return NVME_QUIRK_SIMPLE_SUSPEND;
> +
>         return 0;
>  }
>
> --
> 2.25.1
>

Kind regards
Uffe

