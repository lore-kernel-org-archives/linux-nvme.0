Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31597C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhiJoyGK6i48A+CV44wvGM/sNOc2SA/ZHL0e71y9Ouw=; b=gMYJZ844AQm/2XHUpBdObuOD/S
	4hAgaS8C6IYkKXn2zN9ezAoRHFJM3aDOuWYMHICdL8CGNTGDXFHs4smXRIXE181jQMLUcq+3k7ke+
	tIwhZ11Fk/lpH3qHORdtMbfzCU4TRgXVoNdHzweKiyh7bMP79v3BebPxSj8vpBaXHRJKwfVVw1a+p
	rLxikkXRJFClJQafsUujhRata8/NVDlJAw6Y5P487kQ2MQfOzkvRA8WXbeW0EYUC1SWrnIeMFXW5p
	T2yug1/OQyGjcXk5NwGKbZtyepqg7TsNCkULu4NcmpxZwedcCc8Ijka10dhG6KPvIO/PIO96k2rO4
	qBXfNPOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSkO8-00039M-Fs; Fri, 11 Mar 2022 18:53:20 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSkO5-00038e-KC
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 18:53:18 +0000
Received: by mail-ed1-x52f.google.com with SMTP id h13so11996975ede.5
 for <linux-nvme@lists.infradead.org>; Fri, 11 Mar 2022 10:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mhiJoyGK6i48A+CV44wvGM/sNOc2SA/ZHL0e71y9Ouw=;
 b=oxd6LAQKWQ5hKfBrALwTaY5UPGW3xSf9z0WFCbd/U2Y6H0HdsW/os1CmTDYsESly0w
 tqUHS7uXcBfX3xvTcS15ysDWNektRriLFjwr2sFQrEkwYcoMX8VEWNHfqqXCDF3yJGQv
 NydGiZKzqXKRAx3KfjS9uNw11cYYRQcS/FX2RoEVSsCkVCHpb3WSXmZ63bSDR5fQfyUL
 epYrOqC8w1p7y2RIEPMp8bx2BMtBa3Q61oUyL1IgQd6FtXH1elLFXVm9PyDdAGEDEe3z
 A/aZlLmcTeMQ4MaY52V9j7G8gOX5WZdDofYqd8HZfnGW0lzoThKe4Y+F5geLdfpjodDv
 7Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mhiJoyGK6i48A+CV44wvGM/sNOc2SA/ZHL0e71y9Ouw=;
 b=Yh8SGYKlGqXrif20bmig31HGTqRkiPlyrjX0CeqVU3qTm5S0CPm4TavO792VeAx3ov
 2clkfAhCdQ5XLztFpB3fkyOEqHzuNXoU4mnxzpLqWJHQ5MibUST1NUJnB2By69vdDxOf
 KpNAduBpCLwAYSgvYFIStqtfMizcLC6ipXB8zGqW46WPJWaiJQLlqqgLK/Xd4m0soDMP
 QGBspr/n7vifl2ohT7+HqJ/uvLVmFcUgyj2lmo5TaFcrXFQG908zDwvTvD1ssTYRHZ1l
 MDohm9fPYv6fQs4Oxwrj/dCF4VTfGEdGT2Sv/cBAH9TPc1GIf++1ctvPJ5951FOAwjmv
 2XDw==
X-Gm-Message-State: AOAM531FM25ue4KtJlm0WVA+5ZHamae2AQyiMN8UKhIic5DjICXCyLmk
 Sf0ngQolc0i3B217Rb1UaIA/ZSloKDNvRG5a/MlB
X-Google-Smtp-Source: ABdhPJwxFS6emBP91ghOo78Xcf38HmQKuJ92uGWWAskNZTBSdMpqT2NKwaEKOmMFF9dvmety1PBkMMF2unwneHLaEzA=
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id
 i20-20020a05640242d400b00412c26b0789mr10168594edc.232.1647024794826; Fri, 11
 Mar 2022 10:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <YiuNZ7+KUjLtuYkr@bombadil.infradead.org>
In-Reply-To: <YiuNZ7+KUjLtuYkr@bombadil.infradead.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Mar 2022 13:53:03 -0500
Message-ID: <CAHC9VhTnpO6LyaYWDTjJAy_ztGw+qqf-YS0W7S-djyZVnydVHg@mail.gmail.com>
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 linux-security-module@vger.kernel.org, axboe@kernel.dk, hch@lst.de, 
 kbusch@kernel.org, asml.silence@gmail.com, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, pankydev8@gmail.com, 
 javier@javigon.com, a.manzanares@samsung.com, joshiiitr@gmail.com, 
 anuj20.g@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_105317_689776_800D68F7 
X-CRM114-Status: GOOD (  17.34  )
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

On Fri, Mar 11, 2022 at 12:56 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Mar 08, 2022 at 08:50:53PM +0530, Kanchan Joshi wrote:
> > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> > index 5c9cd9695519..1df270b47af5 100644
> > --- a/drivers/nvme/host/ioctl.c
> > +++ b/drivers/nvme/host/ioctl.c
> > @@ -369,6 +469,33 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >       return __nvme_ioctl(ns, cmd, (void __user *)arg);
> >  }
> >
> > +static int nvme_ns_async_ioctl(struct nvme_ns *ns, struct io_uring_cmd *ioucmd)
> > +{
> > +     int ret;
> > +
> > +     BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
> > +
> > +     switch (ioucmd->cmd_op) {
> > +     case NVME_IOCTL_IO64_CMD:
> > +             ret = nvme_user_cmd64(ns->ctrl, ns, NULL, ioucmd);
> > +             break;
> > +     default:
> > +             ret = -ENOTTY;
> > +     }
> > +
> > +     if (ret >= 0)
> > +             ret = -EIOCBQUEUED;
> > +     return ret;
> > +}
>
> And here I think we'll need something like this:

If we can promise that we will have a LSM hook for all of the
file_operations::async_cmd implementations that are security relevant
we could skip the LSM passthrough hook at the io_uring layer.  It
would potentially make life easier in that we don't have to worry
about putting the passthrough op in the right context, but risks
missing a LSM hook control point (it will happen at some point and
*boom* CVE).

> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index ddb7e5864be6..83529adf130d 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/ptrace.h>      /* for force_successful_syscall_return */
>  #include <linux/nvme_ioctl.h>
> +#include <linux/security.h>
>  #include "nvme.h"
>
>  /*
> @@ -524,6 +525,11 @@ static int nvme_ns_async_ioctl(struct nvme_ns *ns, struct io_uring_cmd *ioucmd)
>
>         BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
>
> +       ret = security_file_ioctl(ioucmd->file, ioucmd->cmd_op,
> +                                 (unsigned long) ioucmd->cmd);
> +       if (ret)
> +               return ret;
> +
>         switch (ioucmd->cmd_op) {
>         case NVME_IOCTL_IO64_CMD:
>                 ret = nvme_user_cmd64(ns->ctrl, ns, NULL, ioucmd);

-- 
paul-moore.com

