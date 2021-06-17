Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA031C48BE5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 01:37:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769C4610CA
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 01:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769C4610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I2cq11EGWRtx4UOGyKCEtSLjFAIpCBbHFx7X5Yog1uM=; b=4vJBOCxeUbeiuo
	i2hrh82L3Ffqg2Nd+ZuX/cfArd84Ni9Z4BCFMog9/m9wB8TWcuNhX7Yr73qmjNC7aqGKNu8/TzBNb
	cZ7U2t8STD7SGls3X/tj7AzILJpgouhmpDTVLzQfclZSPjxU6XBxD2fFUwIvlQ7GWh6+Hr/QdVuyx
	D3UYpBxflId4oQiyisCdY2M1bWnfF1OygupHU0LBVFx2BKIOG5zN+8K++2QLQ9pC1m/fnUGbyp1qm
	xQS2Qle3EuaaBUxGhT99Ux5Dx02kZUVCsw5utEa4k1ATdwKJFkq2wWPdOdIB0hy+YkjkuoVzy1U88
	wbJB3MqlCbXXrESQ0Tqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltgxa-008QV9-UE; Thu, 17 Jun 2021 01:36:46 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltgxY-008QUR-Km
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 01:36:45 +0000
Received: by mail-wr1-x433.google.com with SMTP id c9so4724212wrt.5
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 18:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mEyR7HezlyO95TWMXVub0pTm/hUKMlS1gPbc5CQ/hBg=;
 b=JAcosV0nnyj5fCbNUEWaiZN90HNAcAPYGpTiXA+9vNgZQ21XacPHsDTA7hZmUeMra5
 10LeSjKrTkfud5Aa5gVNl2i2OKaVu60LKA96eYVadN6qT0fJxDtF6FfoWSYQJUAoOCeE
 9/mEcwE3usrhmlmbqGTrfT63CCjHFTcL8NscJpw2/+mQSj636/sJoSJHJhRZu564LkPO
 19yMgno2t3WxbZ0XfzgyUEdLW6mm/riBaWpsvGTg/m1sbfLEOlvW7Uh34yi0OJETA6AG
 xgOUqx1aJul1AcEdSHH6XrAY6gyzqXmnG+I+D7qgYjId/gKcFRA3ebt8GPQcCT/rR3ve
 ZVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mEyR7HezlyO95TWMXVub0pTm/hUKMlS1gPbc5CQ/hBg=;
 b=B4linr8uYBRqRz8su9JSnAdmR1iZtkLwqGQ9aS2V7GCm6AQN1zcON4zvT9AI6PwPI9
 bxM2FxlGyQZlDjuVuzNWbWgHfVDBVWoQ3F/XS/24QEmKvaGBDrKRyD4E1Is9PdmVMqDH
 4qGbrZ6YQ4crYGXvNsIytminNg28gHg/WVxHhTHJLUXWjNP5W+j8VabUakklVSXxsxG6
 aws0/9z4M33pZx5ZIrfLRrcHzzp5LwAnt2Zte6Ce7Ke5kC0Ftk7ybHpJJbvPXlXmkRLS
 lC//SxArt5vG1k9E/rWkGwXKJzXyPpY2zrsA8e/iD+IZPgN1ymAXzd/zitfc7qthawbz
 hjzw==
X-Gm-Message-State: AOAM532pi4qvAyjKkOFakj9z3IfBNCfv4qztQA1Gk9v1A90KSVRrgFo0
 w+VSV4v/is3gCf9gktKzeLEcOxaaa8ddDSkbL1s=
X-Google-Smtp-Source: ABdhPJwphgBvs0GhEWRuBCRf+0EbnGAJaIPhSWRPmImd5Dm+JNZ3YY3q+ba4QvZTMYmymoflh4bX3rTM3rrCwx4enuU=
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr2430859wrp.252.1623893802336; 
 Wed, 16 Jun 2021 18:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
 <20210610012826.53398-5-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20210610012826.53398-5-chaitanya.kulkarni@wdc.com>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Thu, 17 Jun 2021 07:06:06 +0530
Message-ID: <CAJ2QiJLSfoZ0qXJoJ_n_1Z=7JzL_TZp0ZY2Wb0EgB-bQNzatjw@mail.gmail.com>
Subject: Re: [PATCH 4/4] nvme-tcp: use ctrl sgl check helper
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, 
 Sagi Grimberg <sagi@grimberg.me>, Prabhakar Kushwaha <pkushwaha@marvell.com>, 
 Shai Malin <smalin@marvell.com>, Omkar Kulkarni <okulkarni@marvell.com>,
 malin1024@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_183644_723546_CDC5B644 
X-CRM114-Status: GOOD (  17.93  )
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

Hi Chaitanya,

On Thu, Jun 10, 2021 at 7:04 AM Chaitanya Kulkarni
<chaitanya.kulkarni@wdc.com> wrote:
>
> Use the helper to check NVMe controller's SGL support.
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 6a65b0516180..c7bd37103cf4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1993,7 +1993,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>                 goto destroy_admin;
>         }
>
> -       if (!(ctrl->sgls & ((1 << 0) | (1 << 1)))) {
> +       if (!nvme_ctrl_sgl_supported(ctrl)) {
>                 ret = -EOPNOTSUPP;
>                 dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
>                 goto destroy_admin;
> --
> 2.22.1
>
>

base patch defines nvme_ctrl_sgl_supported as below
 +static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 +{
 +    if (!(ctrl->sgls & ((1 << 0) | (1 << 1))))
 +        return true;
 +
 +    return false;
 +}

The "!" is already part of nvme_ctrl_sgl_supported(). There is no
point in keeping "!" at other places.
So, either remove "!" from other places or from nvme_ctrl_sgl_supported().

I request you to check the logic again.
In case you are planning to fix, the best place would be
nvme_ctrl_sgl_supported() to have minimal changes.

 -pk

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
