Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD2BC4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 14:13:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370496113B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 14:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 370496113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=msL6g8+sVR9o2xqd7D0XNUF/ZsVL50ptURtBrd+jIFc=; b=yXt0ZJizrncwXK
	mFdSvHroul0iqIKhlnSQG7aTOuXVHEymVVtZg6CNws7HVBT4++IkYDIwPcyOZj8m1C0tfb3SaWvrt
	t5BhOq9+YePwfhBjAWeYTDXwvPMjn4Dy85ahY3eRK/+++ykco7fr3PbYdwKmVM2HS9ma9ezEEQtk4
	Vv+aIKLNHclG+gF5J+rQQ2LObEwz3swQ+YrW5ssgypQ7cfUfGzxZbfMLcvfeBBttsLfAkvMAu4tk3
	YThbKFTgTozDHvuqmrked93vjoHk+v+lYrYMITh6l4UIchN6os/2pxOWn3aYKyTfClGz66UOt/XHO
	Y2ORhPV70B++ncblyKtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBe7I-009oHV-O3; Thu, 05 Aug 2021 14:13:00 +0000
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBe7F-009oGy-Ic
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 14:12:59 +0000
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 627C93F347
 for <linux-nvme@lists.infradead.org>; Thu,  5 Aug 2021 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1628172769;
 bh=9r14o40zK4KuYmJEUVB8Z7KB4RmYoDQmrg57+yeBLro=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=kpyKkXNHvkpAf478RlNw/dcdhvVbCYmixGYcHnFRVHY4tapyuPzF+NE78Sp8GdemY
 OREEJEVX37PEIhPMEfxlSVzf5Yz3cv2ow7P0i3FYfrh6JO6onC8wdm5LmEshxq3ja6
 nCT7kJQoXHqVcInsiRTvW+i5Y7hHcCh06qdqnZ+odtYxOfYLzvilQuN3qeiZvVXm72
 /zigF80uniaIkQblx1ilrhAz+urx7/mftIbsB8rnXqI0gIH4wyG75gIM/rl+duP20K
 87TZWOw/C5PqSlPhJ56wBA6m53slx8GP8RtTveNESq/AdH7GP1IBJJTFZvLEy9joXI
 dYfkK2KB3+1nQ==
Received: by mail-ej1-f70.google.com with SMTP id
 x5-20020a1709064bc5b02905305454f5d1so2079674ejv.10
 for <linux-nvme@lists.infradead.org>; Thu, 05 Aug 2021 07:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9r14o40zK4KuYmJEUVB8Z7KB4RmYoDQmrg57+yeBLro=;
 b=nMjL3qqvFOquKm1GgXp+wStNgrO4dM02vPwhr4+yX6sReYNGk/NbAsKJhMvWHm+qNo
 Ahdi+U2LqUAzHofJ+Nu/VUZy7yBl2SAbIkDityB4p32mH9XEpRRNieB/M3JrPCjrbHS5
 5B1hejOM+3hYfxMI15xTHIY8JfSQvI3a1jJujV253k6qbkNWOP0Kxrfm7Lt35Cfd5bHe
 BpjQfCsFMzB7LeIbGxBEDkedDjiwRNi3qppb96TaaMrQsCf155p6iHDZ6Se/n+HLWUzB
 U5+dS2MD5QhXr/dU2rZ/W954ZBtxBtk6Ftv43+URs54iTY4J8Hug/QLcmM6ksdtmnMo7
 +ZFA==
X-Gm-Message-State: AOAM530AUPG2HUHCcqJvo3qv1PMFwlx0OM5HLXfRjPOeMuBW8kKBIANN
 /lW2sYxZJtA3EWuhvIYeVMgdPIz6/YVfrnMT16/MYYPB32BxsNTT8HVBr1Qjf/axcaIAjQ4xuzh
 cGA4m14h+uczHD/PjVl9DHGU3CvujKEzYV8Ie/MeS8qum222idghYwd1EghGk
X-Received: by 2002:a17:906:9246:: with SMTP id
 c6mr4935916ejx.78.1628172768974; 
 Thu, 05 Aug 2021 07:12:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvNW9eqTF2CHhitm2aXc7xUVRRWUsO/6ZtLAMqsAmPuEoZpOcxslisNMOEoF0C/CFnqt+ru8IrUfYjkW3LaLo=
X-Received: by 2002:a17:906:9246:: with SMTP id
 c6mr4935895ejx.78.1628172768764; 
 Thu, 05 Aug 2021 07:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210727164044.2285364-1-kbusch@kernel.org>
 <20210727164044.2285364-2-kbusch@kernel.org>
In-Reply-To: <20210727164044.2285364-2-kbusch@kernel.org>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 5 Aug 2021 22:12:33 +0800
Message-ID: <CAAd53p5+ShayKMe0hJivwLbUx60nVVg1FJg_k9uLk1p60==rLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: disable hmb on idle suspend
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_071257_866769_5B7AFFD6 
X-CRM114-Status: GOOD (  29.89  )
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

On Wed, Jul 28, 2021 at 12:40 AM Keith Busch <kbusch@kernel.org> wrote:
>
> An idle suspend may or may not disable host memory access from devices
> placed in low power mode. Either way, it should always be safe to
> disable the host memory buffer prior to entering the low power mode, and
> this should also always be faster than a full device shutdown.
>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Positive test result from user:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912057/comments/74

Kai-Heng


> ---
>  drivers/nvme/host/pci.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e8f3b32131d2..42d4cbe31a28 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3130,8 +3130,13 @@ static int nvme_resume(struct device *dev)
>
>         if (ndev->last_ps == U32_MAX ||
>             nvme_set_power_state(ctrl, ndev->last_ps) != 0)
> -               return nvme_try_sched_reset(&ndev->ctrl);
> +               goto reset;
> +       if (ctrl->hmpre && nvme_setup_host_mem(ndev))
> +               goto reset;
> +
>         return 0;
> +reset:
> +       return nvme_try_sched_reset(ctrl);
>  }
>
>  static int nvme_suspend(struct device *dev)
> @@ -3155,15 +3160,9 @@ static int nvme_suspend(struct device *dev)
>          * the PCI bus layer to put it into D3 in order to take the PCIe link
>          * down, so as to allow the platform to achieve its minimum low-power
>          * state (which may not be possible if the link is up).
> -        *
> -        * If a host memory buffer is enabled, shut down the device as the NVMe
> -        * specification allows the device to access the host memory buffer in
> -        * host DRAM from all power states, but hosts will fail access to DRAM
> -        * during S3.
>          */
>         if (pm_suspend_via_firmware() || !ctrl->npss ||
>             !pcie_aspm_enabled(pdev) ||
> -           ndev->nr_host_mem_descs ||
>             (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
>                 return nvme_disable_prepare_reset(ndev, true);
>
> @@ -3174,6 +3173,17 @@ static int nvme_suspend(struct device *dev)
>         if (ctrl->state != NVME_CTRL_LIVE)
>                 goto unfreeze;
>
> +       /*
> +        * Host memory access may not be successful in a system suspend state,
> +        * but the specification allows the controller to access memory in a
> +        * non-operational power state.
> +        */
> +       if (ndev->hmb) {
> +               ret = nvme_set_host_mem(ndev, 0);
> +               if (ret < 0)
> +                       goto unfreeze;
> +       }
> +
>         ret = nvme_get_power_state(ctrl, &ndev->last_ps);
>         if (ret < 0)
>                 goto unfreeze;
> --
> 2.25.4
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
