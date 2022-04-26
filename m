Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC01BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 21:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYM8xO87+eG8i48/IrRaE16CJcCxKlysX9Vzq+O/NV8=; b=0N1HLBBtxmYOY4qbjUcz2PVjYj
	gUvF+dCyRgjkMLx4diEZ9r/SbE1HPuoMEsVKJZFVPdUx+cKBrXWKPTGwFBovCCTTq6LlMUVTTMX3H
	pMBRjxq/cnqtSGEyPubMl/PKQEaP8vwbs95Tqc7M4o+qtSBLjDlckSmC//Sx4AIPdlzYspXbbZb7I
	kLtD9V/ZUOCVZRKQD3+7GhIEBOgQK4FBT3EdwyOwI8pJo73uk/rJCkXZrBNmn/TIVZLLVb3kr/sYG
	W/Asjg5wfE9f93zD4MjntX3pcV9cv+T+sea/zwGgMSvb9jyWQUy9ZiZyiQxhCzvHctb6OrR/oGtkH
	palYUEQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njSK8-00GGH1-Np; Tue, 26 Apr 2022 21:02:16 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njSJv-00GGCr-Is; Tue, 26 Apr 2022 21:02:05 +0000
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M2xjg-1niLKE0jUK-003MyU; Tue, 26 Apr 2022 23:01:58 +0200
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-2f16645872fso195902047b3.4; 
 Tue, 26 Apr 2022 14:01:57 -0700 (PDT)
X-Gm-Message-State: AOAM5329KqO8/xfQ/zD7iQco+vGx8JWsXJO4/GJVjbk15CoFkk727wlo
 tC/ffMqA9X0GA1BGLuThhYVEmT6wGgwoHsDYTUc=
X-Google-Smtp-Source: ABdhPJy/86FV4KH1867Lm15JAmIgDQfnAK7NPGjdzs+ZuMReM3UPpqkZq2mfK0iy60GKZRpX6sFCtSy2EluixJ9sXoM=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr24255532ywf.347.1651006916466; Tue, 26
 Apr 2022 14:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <20220426201539.12829-6-sven@svenpeter.dev>
In-Reply-To: <20220426201539.12829-6-sven@svenpeter.dev>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 26 Apr 2022 23:01:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2UEHfoDe-d=XEoTM=SS+7Lug7V1WQUa285LWdVLxjHYA@mail.gmail.com>
Message-ID: <CAK8P3a2UEHfoDe-d=XEoTM=SS+7Lug7V1WQUa285LWdVLxjHYA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] soc: apple: Add RTKit IPC library
To: Sven Peter <sven@svenpeter.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, 
 Janne Grunau <j@jannau.net>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:is21Fkr22aX5NkJlXBJTktSsQnKCW/Gq/6HfmS9jSs0XfI2EJWM
 zhAw7DaoRT7j+begWN5yOD39pC9Naqr2rMcNnANNlOj9HAqZpjLZRNiq0g390/UBENEy/LV
 PbNYiJvFQ6P+boD5KCqkQvEmVgrC41E9n7/RR2UYruF7KLag6X6Fiw/d4wGsxFZ9YG6nvc9
 KnIZadz58Sfjft7joXG1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S5W/ntr4CzI=:ONmEiImRx52H7Ihdc5lx2j
 6XJtl9ubRB2hEVwkZyfGnh1APWPMl89dBy05NnS5HK5bcGALMkLvT4AWtpJm1dKvPBnws2aap
 JVhsyFZ5zLkzvYbDoswlWHgp7vV1V9orChn6fRl1/SW6a+nAeayhImWCFIcRF3qYGCHA54QKZ
 EIBnaws0S8vCeloTYnQrQ2cr6Q40bL8GBBIaWjMHQLkVRXRziogsueb90QF2IS8e1uVXLLtq1
 rtWZxxiEtdJYW6dz+/P87WkG/CRVpy82YB8b8pZfLYOfQyQWvdofSuSzxMZSiwno6LFIFODoO
 gNBNc17ZGeJ3JvG/VoNVwi8WuBAKXFE2uOOxZg/19NNC8qYWU+khVcbV3+KMOBSSApXAWeqZf
 JDy3QCFsZ5RnSAy7iilc74CijHvKcWKa5GP1gArzqq+LeeOe5cSXvYcuTi+2G+byRhrbqkmIO
 VtrwXADJ7k6kscBT6B3gvY7pS4srLQPWaWY+WNuc0Mo7v/6cXDQ2sptlH0gNjdlLB2IM5KgWl
 xmlO3KK4TRmGyqWrLTsp8ENuvvVGZhvXeoj8CSkIcj9Oa6l+6porfg5Q8B2xTEVWtDSChfweQ
 qkAc99C8UiCHFOIA4EtUYAoaLNf9Lh36aYUyCBQvnuvSrt2lRqncEMn65snuElHixkAdVd3O/
 YwcLsvYEyCLYWcL9tWclqM9wImgFwnwXa3YiML77C79gqI7fLCDRwYmBaF48UyNUCyIWj95kd
 ThZzWiyh3slPI0UHhCwKIRzW+r4FQwVEiTXZudjKJaNun833EYEPqB4XGkMOuhRcVP0PgXMYs
 K1tPeLQnKacJEXsuUJwm3fnvHXI9AeY+qbk7P499CHgkXfDLOU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_140203_937948_202C2A2D 
X-CRM114-Status: GOOD (  19.05  )
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

On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> Apple SoCs such as the M1 come with multiple embedded co-processors
> running proprietary firmware. Communication with those is established
> over a simple mailbox using the RTKit IPC protocol.
>
> This cannot be implement inside the mailbox subsystem since on top
> of communication over channels we also need support for starting,
> hibernating and resetting these co-processors. We also need to
> handle shared memory allocations differently depending on the
> co-processor and don't want to split that across multiple drivers.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> +bool apple_rtkit_is_running(struct apple_rtkit *rtk)
> +{
> +       if (rtk->crashed)
> +               return false;
> +       if ((rtk->iop_power_state & 0xff) != APPLE_RTKIT_PWR_STATE_ON)
> +               return false;
> +       if ((rtk->ap_power_state & 0xff) != APPLE_RTKIT_PWR_STATE_ON)
> +               return false;
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(apple_rtkit_is_running);
> +
> +bool apple_rtkit_is_crashed(struct apple_rtkit *rtk)
> +{
> +       return rtk->crashed;
> +}
> +EXPORT_SYMBOL_GPL(apple_rtkit_is_crashed);

I noticed that you use EXPORT_SYMBOL_GPL() here, but a more permissive
EXPORT_SYMBOL() in the SART driver. Is that intentional? I would have
assumed that both are similarly private to the apple SoCs and would be the
_GPL type, but this is something you get to pick as the author.


> +
> +#if IS_ENABLED(CONFIG_APPLE_RTKIT)
> +

Same comment about the #if as for the SART driver: I'd prefer it without the
conditional compilation.

       Arnd

