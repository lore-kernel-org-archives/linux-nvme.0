Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B1FCED619
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 07:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V7wsUBBpyLsHvIcpuWZOmppXiQmagQNXt+Y3YerXGt0=; b=syMNTfLqXHfY1KRZ5BWofKO669
	MZy58Z08bwjPhLQ4RyZBAwA75TNRt1xz0gAw0ZxeO9umTWqfC+OizaOfHH4pmMwJ71q7I3ffW0/Mj
	gVlOKgFwjcz3lCLA4SoT1jxidRPiV3LA6+R8PMTm5YytEqImojAsRkZW1eHuBoArBsV8qNJwyPf1P
	UsI592uHGL2VQh+1jJHT5Lcxr23XjjBqr413bwJY0Ro7G5+2kUTRWqmqKTsnhorl2I1gBb/n/2gvA
	us2W9gYDtA0lkUPFi+07uCqou6BoTqzbybQHGv9DiCpPNl1BI9tzFyfjnhywATElCaeYS8+dZ83PG
	UEz46VHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syR8U-00000008Eko-26Oq;
	Wed, 09 Oct 2024 07:29:30 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syR8R-00000008EjI-1GQg
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 07:29:29 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-e25d57072dcso5734137276.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Oct 2024 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728458965; x=1729063765; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7wsUBBpyLsHvIcpuWZOmppXiQmagQNXt+Y3YerXGt0=;
        b=XZUlrBD+QoLh6L8lTmgrVrf9/0UZDiKBdAvUiekW7b3t/ahpPADh3HmM56gq3E77P4
         10R5IM7bLHHlMklfQRAGXvHOAs7QTNunc1PDhjPAmvvEd66UJMspV9XzGpA93h6yz9NU
         0johdIfYoRXz+Yxuh4TFXUbJ0g/u3k4KNi93awKY66XQ6p1cfP1ERoHKf8i7zs4M9k2M
         dyDW17Gmf6kMSlOVhKT7UzV0ZDlF9pCSoLpOuExgqRgyXLW7kQA0jdcgbwallwjmcptz
         ECdS1HGgNjpfadZDoxme0fXbqyjJRba/oZlNMl3/4l6xwsL1kCSE0gplY14/Odd9Ih/m
         lKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728458965; x=1729063765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7wsUBBpyLsHvIcpuWZOmppXiQmagQNXt+Y3YerXGt0=;
        b=nxDuWEFUaJ7jwGRMdoeRjHa6woh4xK0DJvsNBmHqXQJwDZQHfupTLSwVpvSnjsn0EQ
         TWY19/byOvZ2n/58jLJSJSYDsLpBIpLpfX8gw+E4apIp+H8/xlfDurtVxOvomUv6lz16
         JyICUNAJY3AKWUCDt3jJWiI6asByWK/ebh9qiokHsEjxjUwUf0QZ4FeNQ+9c1JmDfSiD
         vLqVCE9yyJhf7ikYs2lGtqHZz8TXExmNGyVj3AL19KdLx9y9lgcMfuFipD5taIdsLYkL
         DDGpxJc/ucsuFEgjC/rW9KebSsiQrstf/YnzSU3qhUSqgDbFw7dX3CWKzTDrubnYRVzT
         SyJw==
X-Forwarded-Encrypted: i=1; AJvYcCVg9lGHrE2CJuH3RnM5RfBEe7iXzRFfRAq7BH5d0WiOgOSEv1zFoecO1PO6ArQ/nb4omkpsLgk8aVfE@lists.infradead.org
X-Gm-Message-State: AOJu0YzpXa5lBNum2CC2ALgZv42LeKI//zmaVALBuWyWqEDeowXp0iNH
	xpWUC6VEFTNli3l9t8tI4GBG1Dq/kmKYdnkFPFTGXOgc+5cFxk4ool/W5LvVGpDVbaH17sN+Som
	SICf1qebFBEabYUqr4/NCsfKIyyE=
X-Google-Smtp-Source: AGHT+IGGImEZpS6v5xk+2Z92nkV1YU7EdG1EaWEgmDxgG/K4t3PwC4fIGN+fMb3TYrqJuyntagmd+ahXNdHfDV92NCk=
X-Received: by 2002:a05:6902:1203:b0:e25:cfe3:9b50 with SMTP id
 3f1490d57ef6-e28fe4d6a04mr1317597276.37.1728458964556; Wed, 09 Oct 2024
 00:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241007044351.157912-1-dlemoal@kernel.org> <20241007044351.157912-5-dlemoal@kernel.org>
 <ZwO0H0WCnORq9EzQ@ryzen> <8b1c846d-6c86-43ea-bc73-aef619094267@kernel.org>
In-Reply-To: <8b1c846d-6c86-43ea-bc73-aef619094267@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Wed, 9 Oct 2024 09:28:47 +0200
Message-ID: <CAAEEuhqpthLsNX70WWCn6+udPaNhks41d=oCZRKpPSHKnRc-AQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_002927_360725_C47B6EDF 
X-CRM114-Status: GOOD (  24.33  )
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

On Mon, Oct 7, 2024 at 12:26=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 10/7/24 19:12, Niklas Cassel wrote:
> > On Mon, Oct 07, 2024 at 01:43:50PM +0900, Damien Le Moal wrote:
> >> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> >
> > (snip)
> >
> >> Early versions of this driver code were based on an RFC submission by
> >> Alan Mikhak <alan.mikhak@sifive.com> (https://lwn.net/Articles/804369/=
).
> >> The code however has since been completely rewritten.
> >
> > Here you state that the code has been completely rewritten...
> >
> >
> >>
> >> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> >> ---
> >>  MAINTAINERS                                   |    7 +
> >>  drivers/pci/endpoint/functions/Kconfig        |    9 +
> >>  drivers/pci/endpoint/functions/Makefile       |    1 +
> >>  drivers/pci/endpoint/functions/pci-epf-nvme.c | 2489 ++++++++++++++++=
+
> >>  4 files changed, 2506 insertions(+)
> >>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c
> >
> > (snip)
> >
> >> --- /dev/null
> >> +++ b/drivers/pci/endpoint/functions/pci-epf-nvme.c
> >> @@ -0,0 +1,2489 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * NVMe function driver for PCI Endpoint Framework
> >> + *
> >> + * Copyright (C) 2019 SiFive
> >
> > ...yet here you claim Copyright (C) SiFive.
> >
> > *If* the code has been completely rewritten, then you probably should
> > put yourself and/or your current employeer as the copyright holder.
>
> Oops. One thing I forgot to rewrite :)
> Will change the copyright in v2.

Hello Damien.
Thank you for acknowledging my contributions in the commit message. I
would appreciate it if you could add both our names in the copyright
for the v2, I don't mind not being in the MODULE_AUTHOR() but I would
appreciate a mention in the header comment of the file, thank you.

Best regards,
Rick

>
> >
> >
> > Kind regards,
> > Niklas
>
>
> --
> Damien Le Moal
> Western Digital Research

