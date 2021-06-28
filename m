Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2160AC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 07:11:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2A6613EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 07:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2A6613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3cPwgsKf62DBN52l0ELpaG1Lqc3dz9Q/8TwoplkgZg4=; b=PzUo37HCt+3+GS
	H/uql7Dhtt+oGw/SLHDCBz5eUBTzenUx0YQhuxQ5qY5TdiJSTD59/amA3J+huB+aM6CNRwKTfUzwy
	vXlNeTz9C3i70tBQ2Hyeiahw/2gi3OyYL+GU5sAx4SUJZTZFPs7qNwqAmWprEJ1nThDOq28IPIOej
	kHzpGlomwNRqaRaUjbdXrsen3LFNiz/hfNcZkVLuzWJQR5t+DEQGRqapsp9D6gg0EaCMwQThcdQdd
	dVYd2ID7hI21tsU2rZnAcS07y+VVqml8kRzOQ9ebD3HpHVrEK19FWCO6x7g7iiqTGKYg76knLqg5u
	7mrw4DQRL9qFJLjH3C1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxlQ8-007BQN-4f; Mon, 28 Jun 2021 07:11:04 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxlPt-007BIN-Gu
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 07:10:51 +0000
Received: by mail-io1-xd32.google.com with SMTP id k11so21064297ioa.5
 for <linux-nvme@lists.infradead.org>; Mon, 28 Jun 2021 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UVSMZPE6HVZeVjJspQpjfRUrVPhGhRcHcElfYQejdlc=;
 b=uZyT4oKhz1V0FtVulTixeRkUsGkSp5FlzSItc0hAlYCvwzQoHxpx+SI9dmAYXhQjfu
 SfSQek/YHDP3RUUCvPzh8LSwY9t+QFhd1bZEQT6ULcRqHgeSk1TdGmqz35ceRWFXB1yt
 9Rqgx5VbIioICJlu3t1zMmlSNeiD7FfMZUV+XIAO6TxaJwZscROl3nkgZUj+UA0H+K99
 Nrp+bWtnFRKH1ykN1AlQLoxAdr5p25J+Wj8/2Ep6kdi+drYPMKugLSiuyAivnloT8wSw
 RxX+im+I6+yA6U8tHWun4AuuQd7DV7I6DAb7IPkT7RZuhLw/cI/lA4FGS6W4Wv3OzlI5
 cd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UVSMZPE6HVZeVjJspQpjfRUrVPhGhRcHcElfYQejdlc=;
 b=TMdJl//0sFKTKfN47iIlmM7KZ9i8Z4mGFJ0facXAXZ/9vaaEOIsNJbIJWKFUH3brJS
 PpwectQCf0v+Vvds+zA5+r7QIUAmWlD75tuXR5oKIvBX/hhuzSnaQfwVWPXI4Ks2X1/m
 iQjH26aypwwWq5FWplODUK7gYwdHVmQ0KlW/tovvnBwAZ8UM3Hmf2q8RoZcFgUiKNyCa
 99BaBD06oewMANqpj162AqylYlblmRFjL7SEhAbjSSM80eWfr0M/+2qnpu3Vi6x2Rqxd
 07LeS26MIzpobdl8J8+rCESePiBH4PlpoLVlzsknX0AMiZZg97Z+dc/nW3NSHHfVMs4d
 Nh3g==
X-Gm-Message-State: AOAM5337UHwZP3kVYu3k9jsZFCV3hWGRml6s+n0HD+6CAc0CZ6rprvET
 /KubxffrgZpLKDNafK2DOrIM+mtKV3/IIQHn0tsL1M1T4wg=
X-Google-Smtp-Source: ABdhPJyPIDtxaAX0g51d/feiimSqPsdIeS52dcSIAtmgYUbMxgG+Fp/etKDFZfwqo6mEgQrEtCbpYBK5QBGX2xES3uc=
X-Received: by 2002:a5d:8916:: with SMTP id b22mr3874027ion.108.1624864248127; 
 Mon, 28 Jun 2021 00:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210624172410.14225-1-smalin@marvell.com>
 <20210624172410.14225-9-smalin@marvell.com>
In-Reply-To: <20210624172410.14225-9-smalin@marvell.com>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Mon, 28 Jun 2021 10:10:36 +0300
Message-ID: <CAJ3xEMhtrEEMLbkWuna_fvH_oinaCZmj3xr4y7gzdRawA1gmNA@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] nvme-tcp-offload: Add IO level implementation
To: Shai Malin <smalin@marvell.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
 Christoph Hellwig <hch@lst.de>, axboe@fb.com, Keith Busch <kbusch@kernel.org>, 
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 aelior@marvell.com, 
 mkalderon@marvell.com, okulkarni@marvell.com, pkushwaha@marvell.com, 
 prabhakar.pkin@gmail.com, malin1024@gmail.com, 
 Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210628_001049_623633_498598C7 
X-CRM114-Status: GOOD (  11.60  )
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

On Thu, Jun 24, 2021 at 8:41 PM Shai Malin <smalin@marvell.com> wrote:
>
> From: Dean Balandin <dbalandin@marvell.com>
> In this patch, we present the IO level functionality.
[..]

> +static void nvme_tcp_ofld_set_sg_null(struct nvme_command *c)
> +{
> +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> +       sg->addr = 0;

ok

> +       sg->length = 0;
> +       sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> +                       NVME_SGL_FMT_TRANSPORT_A;

> +inline void nvme_tcp_ofld_set_sg_inline(struct nvme_tcp_ofld_queue *queue,
> +                                       struct nvme_command *c, u32 data_len)
> +{
> +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> +       sg->addr = cpu_to_le64(queue->ctrl->nctrl.icdoff);

ok, what about dma mapping of the address?

> +       sg->length = cpu_to_le32(data_len);
> +       sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;

> +static void nvme_tcp_ofld_map_data(struct nvme_command *c, u32 data_len)
> +{
> +       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> +
> +       sg->addr = 0;

???

> +       sg->length = cpu_to_le32(data_len);
> +       sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
> +                       NVME_SGL_FMT_TRANSPORT_A;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
