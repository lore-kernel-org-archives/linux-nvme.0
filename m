Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF52C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TXBtgerhY2vz40E1BiNZvR68nOLcA3rB68dKpPRhG8=; b=V70zwYesVSd39t+osmb8hC386V
	iOm0isPf4TwYTk7jhGyglS/WscffuCUG1D4abQwj4D+aDqvWqUFV5iFmUEHe3Imx+qVFmZiK3wuol
	oJVJU6k8CTAyulLjbEs2dvUIwV1tlA7s0MslfzOWn32pflaWAdMWjiAnUNXMX1u7cKfIzP+RLxBWK
	VB0G42fgkP8w6d808pHb2NPpnssLrMIaPbCcvADJ3YGc2LJ+FfcbPn43TYvLhRrJK4xFO6a/1LtiX
	rmqgmgejj9c0APJZE4WmrG/jAmRl0F/9145zJ/QacVem6SrvFDTf32rHCCoY/PtAZsRDw2wwTquBn
	lYgA5VXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olZ9U-000nXE-RD; Thu, 20 Oct 2022 17:16:16 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olZ9S-000nWL-Op
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 17:16:16 +0000
Received: by mail-ed1-x531.google.com with SMTP id s30so558795eds.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2TXBtgerhY2vz40E1BiNZvR68nOLcA3rB68dKpPRhG8=;
        b=B5gHnbiJXUdhDCzqMJgOcQkFsziUWONNHtddTx6t98hLgp6MGEal7sjQxgUOyA3rFU
         Qfq/T1ymFmWUeV/2sKscRxxP9yEujBmFXTrXtQKlEy8RFKQ94lGmyL5tzMcXuS0N2Gb8
         SHyUQgUU2mHg3ZntaVaxS230u+Pm/pL5POmr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TXBtgerhY2vz40E1BiNZvR68nOLcA3rB68dKpPRhG8=;
        b=7qBDsyJoMwxr6QFq9HI7+tCS34ZACB7GGR3f9lGsjWYzFo9FBrp5OeADv8JDbcFPrM
         Zc6Z0FInW+83NOr3KPYlviqo80jO2xKKpFxTERltnhalnve6CsLgI4KRWeYZnwJnB9SY
         rrv6JZ3XOHpWvNGEHxbD7P9LiECOvA0KhHyT35TxbxjpFgai4FgNM+XoiF+DUm2HFhWf
         atJhVKjtMbcR/VAuRPFlWDKWnuwlCdM4tw+IvLvhMxHYHuTAdC0K4xVisYK200iFNf+L
         OyaoEoW03nNskNE/ZY0RtDImYTRm2m8OqOQEhGEcS528U/iM5tg0og5liccFP+xUPjcd
         IW/g==
X-Gm-Message-State: ACrzQf3YFfFik8xf0q2ga/CEmpZCVln5/78p0RaCLe9TkqQvNfaGbYn6
	5jqn3UxyZWAkI1RQoYaYaR79NL/LV52o6FgJziU=
X-Google-Smtp-Source: AMsMyM6SiFDMhi1Mwsob80VUv99Mvo6iNUAfiosE7NE1RyS39noZqvEx2OD7imyHug1FOof+Qru+ZA==
X-Received: by 2002:a05:6402:7d0:b0:459:d35c:8563 with SMTP id u16-20020a05640207d000b00459d35c8563mr13561326edy.229.1666286172070;
        Thu, 20 Oct 2022 10:16:12 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090676c600b0078c47463277sm10677987ejn.96.2022.10.20.10.16.08
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 10:16:09 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so141242wmb.2
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 10:16:08 -0700 (PDT)
X-Received: by 2002:a1c:7215:0:b0:3c7:130c:a77f with SMTP id
 n21-20020a1c7215000000b003c7130ca77fmr1992230wmc.151.1666286168514; Thu, 20
 Oct 2022 10:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221014083058.1451914-1-ken_lin5@hotmail.com> <TYAPR03MB3085DD9F15177F126E9DF7C6AE249@TYAPR03MB3085.apcprd03.prod.outlook.com>
In-Reply-To: <TYAPR03MB3085DD9F15177F126E9DF7C6AE249@TYAPR03MB3085.apcprd03.prod.outlook.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Oct 2022 10:15:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WH9N4Vx6e7Qr8q1fxsTRh=1kHBcg5RuWxOmruJEvr4kw@mail.gmail.com>
Message-ID: <CAD=FV=WH9N4Vx6e7Qr8q1fxsTRh=1kHBcg5RuWxOmruJEvr4kw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme-pci: disable write zeros support on WD SSDs
To: Ken Lin <ken_lin5@hotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	michael.jao@quanta.corp-partner.google.com, derekhuang@google.com, 
	chi-jen.chen@quanta.corp-partner.google.com, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_101614_848427_93509F6B 
X-CRM114-Status: GOOD (  20.33  )
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

Hi,

On Fri, Oct 14, 2022 at 1:32 AM Ken Lin <ken_lin5@hotmail.com> wrote:
>
> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> Write Zeroes command"), Western Digital has the same issue:
> [ 6305.633887] blk_update_request: operation not supported error,
> dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES)
> flags 0x0 phys_seg 0 prio class 0
>
> So also disable Write Zeroes command on Western Digital.
>
> Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
> ---
>
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3a1c37f32f30..5c1b812a3c2b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3517,6 +3517,8 @@ static const struct pci_device_id nvme_id_table[] = {
>                 .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
>         { PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
>                 .driver_data = NVME_QUIRK_BOGUS_NID, },
> +       { PCI_DEVICE(0x15b7, 0x501e),   /* Sandisk 2280 NVMe SSD  */
> +               .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },

So I'm not really an expert and don't really have the context, but you
CCed me and so I took a quick glance.

Something smells a little fishy. ${SUBJECT} talks about disabling
"write zeros". The patch description talks about disabling "Write
Zeroes". The patch you reference seems to disable "write zeros" by
setting the quirk NVME_QUIRK_DISABLE_WRITE_ZEROES. ...but the contents
of your patch doesn't seem to match. Instead it adds the quirk
NVME_QUIRK_NO_DEEPEST_PS.

As I said, I'm not an expert and maybe everyone will tell me that it
all makes sense, but it seems weird.

-Doug

