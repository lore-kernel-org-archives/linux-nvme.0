Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7C1C28B20
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 19:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jVDLjf96+CIUoJN5Qi13tgNS9/4rLlwNZkSbNFjDtK8=; b=w1vVnbGtDpSOaf3rxouZNar+ZV
	9nOc80YFHqoaTy6D2jEbM/kX+cbldGYpH3orjgoxzT4E/xDdzZHC9bsiprM5HEDb/iKwKlnYUU4th
	G6i5Jq9tjb5nsbW45nfa0VkDBAtH0VyWlrs8qhIY/iO+H+NylHhmu0W4QXfYO1LsKeSbTG0SP0FHw
	Uh9DHi7tKT+9ZNWKWjqied8WsFCDRVTwDk6rTL9HM5TBAus/qunzf2UhWrxsIzIKuUeSy7QDawup9
	68tIzIxBCXrqZm9juYgLA0hp32AHW8P9ZGMJnqeq8A920PeElyo0QCmlHV6FDQdZZ8Z/fw4ePOspp
	B/gu/W5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFiC-0000000ECyp-3HMM;
	Fri, 28 Mar 2025 19:49:52 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFiA-0000000ECyJ-0Hpa
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 19:49:51 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so588170a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Mar 2025 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743191388; x=1743796188; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVDLjf96+CIUoJN5Qi13tgNS9/4rLlwNZkSbNFjDtK8=;
        b=E7m8Jm3cD8T40VbvmfXXwn3rBclILgSlheSM53UAo8D8LYTJd0cNgEq3SRHiXh5FE4
         6K6ZHqmnYlKmR09FFfnXCf7lNdTlESY72ZXb2D6e7Czx92Wm+/pY0Xu5WJj7vyu30yVJ
         cjKe53HoooXiStRfHAM07m8NSVCKqWTbELTMZhPUqQ6ljUknOtgboaUsjed0bRcoefEu
         lWGmKOseX5jF+Ol7zQ+JyuBeXwJrn8uN1BQop4Z7H4nIohFx/325rFvWqh8QRZCprJNo
         YioKuPsJCKVU1to29Is0S+PfUKKjXp74FZwtXPZWgqEvA9FUJfNOiwwjdFKaOb6xmKtG
         1tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743191388; x=1743796188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVDLjf96+CIUoJN5Qi13tgNS9/4rLlwNZkSbNFjDtK8=;
        b=rTT8NuBknVR1J8aBN9SjQ4fFAt1kQNZH7kXcZtSHrzXGq5CWyTLtA5Xe3Q1waKmaUt
         Z6wEiYNdCHVKUF/VEFA69FYM+qkwo624jgkNKEMDh+F+R8nV2xXDgSXSDsS5cV/0OpEz
         adLmW6EU9v+Reb1x1Rj5Yzn+euO/tvozEQ+wOGOUVY5iyvaPtgGjPnFM9k5u6zmBsQtM
         1UqhyATT73d5g87w0Nufwl7Z7Blp5gngzE69KUi0BmT72NXdZhSxlMKyIYMmAgxUJcvd
         qt/nkU1Ihg0O+JlJXICRrpBGCrGdxsa+lc6P1AL70Gcoh0JxeFRprmn/58AviKGRcId9
         jQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAlrwZkIBlsX6y2vOXj6IwO7HT5gxFDXO+zhmeThaTGH2xtiZpMr70kuA0S4ZiuCEgsh0+Y/0u9xpu@lists.infradead.org
X-Gm-Message-State: AOJu0YyHAres31GQKnbZSMr5R0chPwL+qV8S1/nemfywiV1Or4TdTXk+
	UHl1Fd/eMXJzVcsg+jZXEluQec80AecgMnffxAwCwx6VCI5ZafGPSAk8siE6EkaQACzpW886tcw
	3yOaIpHdAO0cd3zhxIyXW7dk/KkmgsKQo1bwaYA==
X-Gm-Gg: ASbGncvh39DO7FqMZLPnOA9Ny7eyTie3TgKTHQjGz0gRewiVY7tATbbo6n/MaNJiRdf
	JPeTmSYN4ccoTXz155nLp97P4fc3v7dTLzHFK5WBdBkiJjkQp7hTJqXtYtAObdpz0gW0P3+aknU
	oA1sJbm71oEKU6Iqfaa1umoB4YukYwCKY1nl4=
X-Google-Smtp-Source: AGHT+IGrl/mKQfFw/+XjS8bzX76MdoEk88bqdDe6coxyEavvPIofC41z6Z7UbgR1Z4PlFwBz7py/lYatV3/VrQbVZ04=
X-Received: by 2002:a17:90b:3e8d:b0:301:1c11:aa7a with SMTP id
 98e67ed59e1d1-305321512bdmr289975a91.3.1743191388477; Fri, 28 Mar 2025
 12:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250328193826.356257-1-jmeneghi@redhat.com> <20250328193826.356257-4-jmeneghi@redhat.com>
In-Reply-To: <20250328193826.356257-4-jmeneghi@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 28 Mar 2025 12:49:37 -0700
X-Gm-Features: AQ5f1Jo3KdNQ8qCtKv_TRQl0FksSqMC2EEdES0mrQoJ0kwJ1SERO0qy9kiXvybo
Message-ID: <CADUfDZoXg39h-5gi+aVj2u1H6HC4Beyp2XPTrjJ_PMDPf11dQg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] nvme: add the NVME_ENABLE_MULTIPATH_PARAM config option
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, loberman@redhat.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	emilne@redhat.com, bgurney@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_124950_112133_6DE6AA84 
X-CRM114-Status: GOOD (  19.03  )
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

On Fri, Mar 28, 2025 at 12:42=E2=80=AFPM John Meneghini <jmeneghi@redhat.co=
m> wrote:
>
> The CONFIG_NVME_ENABLE_MULTIPATH_PARAM option controls the
> core_nvme.multipath parameter. When CONFIG_NVME_ENABLE_MULTIPATH_PARAM=3D=
n
> the multipath parameter is removed from the kernel and nvme multipathing
> is permanently enabled.  When CONFIG_NVME_ENABLE_MULTIPATH_PARAM=3Dy the
> nvme multipath parameter is added to the kernel and nvme multipath
> support is controlled by the core_nvme.multipath parameter.
>
> By default CONFIG_NVME_ENABLE_MULTIPATH_PARAM=3Dy
>
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> Tested-by: John Meneghini <jmeneghi@redhat.com>
> Reviewed-by: Bryan Gurney <bgurney@redhat.com>
> ---
>  drivers/nvme/host/Kconfig     | 11 +++++++++++
>  drivers/nvme/host/multipath.c |  2 ++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index d47dfa80fb95..8c04b6b93982 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -28,6 +28,17 @@ config NVME_MULTIPATH
>
>           If unsure, say Y.
>
> +config NVME_ENABLE_MULTIPATH_PARAM
> +       bool "NVMe enable multipath param"
> +       depends on NVME_CORE && NVME_MULTIPATH
> +       default y
> +       help
> +         This option enables the core_nvme.multipath parameter.
> +         If this option is disabled the core_nvme.multipath parameter
> +         is excluded from the kernel.
> +
> +         If unsure, say Y.
> +
>  config NVME_VERBOSE_ERRORS
>         bool "NVMe verbose error reporting"
>         depends on NVME_CORE
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
> index 6b12ca80aa27..83084093e8db 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -10,9 +10,11 @@
>  #include "nvme.h"
>
>  bool multipath =3D true;
> +#ifdef CONFIG_NVME_ENABLE_MULTIPATH_PARAM
>  module_param(multipath, bool, 0444);
>  MODULE_PARM_DESC(multipath,
>         "turn on native support for multiple controllers per subsystem");
> +#endif

If CONFIG_NVME_ENABLE_MULTIPATH_PARAM is disabled, could you #define
multipath false in place of the global variable? That would allow the
compiler to optimize out the multipath checks and the resulting dead
code.

Best,
Caleb

