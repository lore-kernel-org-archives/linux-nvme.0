Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E3DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 21:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h2s6b46fGq2Ra/R9HiY0AFiKS1Y9rWSjhF/Ii9t/tbA=; b=kEk4ZVbtZz/IJv216v1vxLOEF0
	x/KgQC+tOAbxqIsuB1/2XATFyggGIDfFGUhPX8ldJopVgufiS/42b8SP9R+7GrcJS5E8w/bo91L3n
	UKfw6cqf3gxs+KkW8ZjBCJooYEjkp/fEG54oRCzQdtAtyWTfaN5eJbArGJ4hmD9ndauoqxUG6V+jm
	1bV3BJA9ELGmp5w9MF2HuG2b9jXv9jKwPgOJnLgOjmJEXL+6lAj3yjBDbc0NfQyCxu8OPvBpY+MgM
	lOCcyFUjaKQA+6+Amqy/EdGWnllZEqtsZRsWFTtKMRn47mtwENvnl5xreUgiGi1vLdADhCJfLkzRg
	T+eNTsJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njSPW-00GHXZ-S1; Tue, 26 Apr 2022 21:07:50 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njSPJ-00GHTB-H9; Tue, 26 Apr 2022 21:07:39 +0000
Received: from mail-yb1-f169.google.com ([209.85.219.169]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3loZ-1nkHLx354F-000uP2; Tue, 26 Apr 2022 23:07:34 +0200
Received: by mail-yb1-f169.google.com with SMTP id d12so16024885ybc.4;
 Tue, 26 Apr 2022 14:07:34 -0700 (PDT)
X-Gm-Message-State: AOAM532nZCic+vmq3C58sv5qQXtG07zzPPgRndYwkEAmdKcEyJpn6Lg9
 gxfBmOryP3K9BUPF0zd8JVbiX426hO9QvXLmjAc=
X-Google-Smtp-Source: ABdhPJxSSDDOtEn7aGJKzNZ9mnCcpZOReFbUpWu56qgp9Lnx/3jQsTHsY7svsF5iLlzz6Yj5mPVQ8TSE4yoAsZQQ/cU=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr22931175ybx.472.1651007253244; Tue, 26
 Apr 2022 14:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <20220426201539.12829-7-sven@svenpeter.dev>
In-Reply-To: <20220426201539.12829-7-sven@svenpeter.dev>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 26 Apr 2022 23:07:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a263ojCtYRec2RwvvcY1H1k7chqXyRhovrWRXh=hFYgfQ@mail.gmail.com>
Message-ID: <CAK8P3a263ojCtYRec2RwvvcY1H1k7chqXyRhovrWRXh=hFYgfQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] nvme-apple: Add initial Apple SoC NVMe driver
To: Sven Peter <sven@svenpeter.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, 
 Janne Grunau <j@jannau.net>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mD7vOx3JjJNjhrcxl4bq0dtVjvFtopAefGsoWE/qaEF+V5k53oe
 ezAgu3LKM40bFzFI4Q7Re5xNpQ8W/ED5qYc6Va1JAQp8n6fVZvWde+COv4Ys8CzxxPn64Yx
 azkPI2DVdJm2WuHR0tRAKwqGL5xNlS6Ley75Zno//ATUQJaQl59+t6UUnUiiBBcjakxJk2/
 XMz4lPjw0SQvGh9j+e2Jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V8QY3xac2gE=:z1JovAObtao+aspypi0Z0t
 CTVVU2gAq9wSzEzRdiCysaLBp0wVL28Hw/nEXKHLESVkBi38MeMZw0q701ilxPnlgkLq67yTl
 MzORBho3bBl0xrcVe3z0CAJywj/M94m7nyab6UAZU3G8oFiFRP69c4Vh1PLEOse9rI+1pH3qK
 5rs9f3p13KdMeFdDrV7GlfMi7p9H3nNv+/eDQvsWQhKd24O1jh4AWYC73U+x4EwXjSPP7BRMJ
 RElEYM5EnkolqeJ6y6Dr3YKlsMjl4KFBWuiPjIJ93XZlZNfudOfRycjxnHzxTPt908A0pWW77
 LHWJ2HWiEqa6ZWNghBSyn+5maA7g4p0xIWQqL8CA4DRmP6DSq9rBMv80BOLe7HkwMk0Oy1OUM
 pAC2WOBuoqbde2oJvQbZT4fa5lPFSGcGbJKZtrBrw5DzT/J+WpAY86nVzBDv+y+X/bPxV2QSk
 HvGYhV268hDAU1FFmCbEGdjgbyrctMfehXZEbIMoU4k6RwzzZI4QNCOENEGeWEQr5im0fdk64
 oT9ybwuThLpxiuOyUW+yFLC+xUtUf5RdnfIPsvco9may7FacMsgRxpMsPXRcDAMgt7EHgdO/t
 mt8+DPQxnCo4/LKRIvNIOjjsBOqlGN3uW7WteuhXzpc/0LIp0jvDrutg9N1jpu8QU7xH39WhN
 MdPwPHt2e8IXQJdBPhAcJj++KVCSwmUbghoEWEWLe23NBfXwON+Gs7Q+wOIqkz76BedZVJh1b
 h7/VnA+3Fi7caIHjsNnXTexG1npsB6Phe7NrV+StOilpNPrQAFECQtSh+JjJxPQQPCuu/kjzh
 4OwdetoWTB+Yvi4ZVT0XUWaHYKSVn/yQrXX5E4dTvlhEP2/glg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_140737_899959_4CB34E3A 
X-CRM114-Status: GOOD (  19.26  )
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
> Apple SoCs such as the M1 come with an embedded NVMe controller that
> is not attached to any PCIe bus. Additionally, it doesn't conform
> to the NVMe specification and requires a bunch of changes to command
> submission and IOMMU configuration to work.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

I did not do a detailed review of this again, but the previous version seemed
mostly fine already.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

One suggestion for a very minor improvement:

> +#ifdef CONFIG_PM_SLEEP
> +static int apple_nvme_resume(struct device *dev)
> +{
...
> +}
> +
> +static const struct dev_pm_ops apple_nvme_pm_ops = {
> +       .suspend        = apple_nvme_suspend,
> +       .resume         = apple_nvme_resume,
> +};
> +#endif
> +
> +static const struct of_device_id apple_nvme_of_match[] = {
> +       { .compatible = "apple,nvme-ans2" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, apple_nvme_of_match);
> +
> +static struct platform_driver apple_nvme_driver = {
> +       .driver = {
> +               .name = "nvme-apple",
> +               .of_match_table = apple_nvme_of_match,
> +#ifdef CONFIG_PM_SLEEP
> +               .pm = &apple_nvme_pm_ops,
> +#endif
> +       },

You can now use "static DEFINE_SIMPLE_DEV_PM_OPS()" to define
the pm operations without these #ifdefs.

       Arnd

