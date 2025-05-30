Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EC8C5B543
	for <linux-nvme@archiver.kernel.org>; Fri, 30 May 2025 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xfbIKX3nUHCl5SttY5hXf7aTrqxY5xSWq7Ko7SA+Op8=; b=BZ6xCZIndmJRna+mi/HjizZPlt
	yCfLXW/v434AK0F3OpbeXKUb6v1dzJaUK7ItSDQ/RI7og8JIJOsv3c54ldaNkivJncEwjhHs0eH2s
	VuNZXNiqdcRFw+7UYdOanXEDK4uePfN0Bicqm4PQEEaBqCCjTT66D1EVxQvmHio4BoOapYhZepEP/
	rnwLIH8BnPzaN4mnEMKlRKz3K2gE1OEB4d8sS7Wvr558ewz+6XM4S96yq+oz2p1D3Vg2sfvGslljL
	yWjMbeuOcXBDl/dqw+hoO00k/dWjudyLApb5uE13FgOy7SCPKCyLtqumaQiDEm5LRPKFjkfqdyxu8
	0dwD1HLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL0Ku-00000000qPd-3Ayb;
	Fri, 30 May 2025 14:03:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL0Kk-00000000qOe-2JEz
	for linux-nvme@lists.infradead.org;
	Fri, 30 May 2025 14:03:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748613819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfbIKX3nUHCl5SttY5hXf7aTrqxY5xSWq7Ko7SA+Op8=;
	b=gQCW60uFBT8hBVi9zxgqO1sPWljuXdScWyr3eiOrCRxmTiTCC7Uv9PYPKXLI4VY3OMGwEv
	wV5Eo7j18BRQVOkY4kL94hkA9hGBQYSRAaP1c7ua94xYgQpl63fm1gg8huTziuxV89YTry
	/s+64MASRNzMcveO7NWhoZM5ABfyZXI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-U9do4yeVPoGgeXTiPwDsXQ-1; Fri, 30 May 2025 10:03:37 -0400
X-MC-Unique: U9do4yeVPoGgeXTiPwDsXQ-1
X-Mimecast-MFC-AGG-ID: U9do4yeVPoGgeXTiPwDsXQ_1748613816
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a6ecca672so11868841fa.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 May 2025 07:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748613814; x=1749218614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfbIKX3nUHCl5SttY5hXf7aTrqxY5xSWq7Ko7SA+Op8=;
        b=KHgNhDrIgo5yZotI8dIltjZa6BY/J7bzn6MUL9C1mL3hsqawRlQmC3QtIVAZMfmFSB
         Sex1ds5iK75jpYrafRSc3Z7qYSbInGoJ6oz9mx7/4y0fq0crSAeJYUFSoVlUwkZaK8wz
         N7AlzuuzuF7HEOSmvErJSWuMrrGiJBXs+FuDyxD9SoxUvC3XbDK5IXH2AG9dIYi8aXeZ
         pZny4veGeIrnH0p/ajMAyUSX4Jn5Xw55KIcKjRQ+FO/VoMPQMRmWRpafOefpbZRW86gs
         YFoSQtaZvpKyccpgeoC1BYBxyqEkm9fKpo5KPJKTusJcq2GK2INgXFO6+mD5MbEuYE1u
         EShA==
X-Gm-Message-State: AOJu0YynpO1JJM1JVen48oC6iHiWwDDh1K84I0Au2Nv3kqgO7he+ubnY
	Xk0CZkhFsekURa9ueGfyVvVvjDVGUzU7ovcEzMyBRDElltFNtqi5ymrAwvnexzLM0xStecAVvzt
	d+azeZ78mctUTKNDFPqr8uVwrySHkS/YFwXMn1JGK2hTlGVyAcFC4t40w1UqtinEUGyn/pQY8TR
	tqG6IEndmitEUcpMzeHgTCo8se04QH5RwtUXfUk1RfHLe0jqx3sKqxBWMa
X-Gm-Gg: ASbGncsSbeI6M46LX10aokw8oP3G3WlN0QNW2fnTkQ3IiiuLppVPT6kpLEPfEMDDSTc
	FTcf1Wn3x3k6lWIAlaN52m1oeECsLdJbhI+WHGf1FCZl1G/g9ZYPhusHArwmg6vNWa40A8RCfnL
	8U23bu
X-Received: by 2002:a05:651c:547:b0:32a:83b5:34ba with SMTP id 38308e7fff4ca-32a907a5dbbmr8440181fa.20.1748613814131;
        Fri, 30 May 2025 07:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrTfFdddIfzrGc9yiIk5DBiyhq4jEQY62qbo/5sdNxsi9GW23tO/8f7P9ktjWFcb5OEJSMJe1MZUP5SkpneII=
X-Received: by 2002:a05:651c:547:b0:32a:83b5:34ba with SMTP id
 38308e7fff4ca-32a907a5dbbmr8439611fa.20.1748613813555; Fri, 30 May 2025
 07:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250425100107.844298-1-yi.zhang@redhat.com> <96445ffe-2d02-4b3c-9a8e-eb7d8831cb10@nvidia.com>
In-Reply-To: <96445ffe-2d02-4b3c-9a8e-eb7d8831cb10@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 30 May 2025 22:03:21 +0800
X-Gm-Features: AX0GCFs_RFvDEg3DyzKC6nnjNcVIXjVV-D5W5rqwRMO-L0JTkmoz8SK56DDC3l8
Message-ID: <CAHj4cs_x7sF3iu0sMyrxkQ1MxeeOtop0zwCKUai1YKDTamdG3w@mail.gmail.com>
Subject: Re: [PATCH] nvme: typo fix for nvme subsystem
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Y6iixYyD-678K5qxgKsbfmRVGPRIbfr2IDJVKagk4c_1748613816
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_070342_660699_A22C5255 
X-CRM114-Status: GOOD (  11.09  )
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

Gentle ping...

On Wed, Apr 30, 2025 at 12:33=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 4/25/25 03:01, Yi Zhang wrote:
> > Signed-off-by: Yi Zhang<yi.zhang@redhat.com>
> > ---
> >   drivers/nvme/common/auth.c        | 6 +++---
> >   drivers/nvme/host/Kconfig         | 2 +-
> >   drivers/nvme/host/core.c          | 2 +-
> >   drivers/nvme/host/fabrics.c       | 2 +-
> >   drivers/nvme/host/fabrics.h       | 6 +++---
> >   drivers/nvme/host/fc.c            | 4 ++--
> >   drivers/nvme/host/ioctl.c         | 2 +-
> >   drivers/nvme/host/multipath.c     | 2 +-
> >   drivers/nvme/host/nvme.h          | 2 +-
> >   drivers/nvme/host/pci.c           | 4 ++--
> >   drivers/nvme/host/rdma.c          | 4 ++--
> >   drivers/nvme/target/admin-cmd.c   | 2 +-
> >   drivers/nvme/target/core.c        | 2 +-
> >   drivers/nvme/target/fc.c          | 2 +-
> >   drivers/nvme/target/io-cmd-bdev.c | 2 +-
> >   drivers/nvme/target/passthru.c    | 2 +-
> >   16 files changed, 23 insertions(+), 23 deletions(-)
>
> Looks good.
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>
> -ck
>
>


--
Best Regards,
  Yi Zhang


