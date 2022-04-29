Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6F6C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Apr 2022 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xwTtJ5zCB+JVP8o2sHpOf18nb4PAHy2trWrM/oz6kX0=; b=qbJ69nJJIJabsl/xRElP50FM5P
	FPytMpmGRozNuqPGS0P0O8JfwwpvjEdqThZpfmx0hRip3FT8R1kwm8Unyu95FwVMLlgNQJqVrzvnw
	5lhPrmd6OppY8Lm2mjjr6/c2wcyd7kWpWzan1xi3caadbgeXuOAM101P9KfiLqY+o6ZgzcOqHR2k0
	8MEyH5aYxRn7LuNsne4t9fVih8Ns7tP/H36YjKKIZKvTdZXF1FU8NSq0UTUunAWkR6Us29DQFcvdX
	+afszbRSG6VCosqHGBuBN8hHg07gprCc1lVeElFGlRWFnUxoKa67kI6IYcKrzpa0jaQP7SaeChjmh
	GZEiYQyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkXJt-00CWWD-83; Fri, 29 Apr 2022 20:34:29 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkXJg-00CWSh-3t; Fri, 29 Apr 2022 20:34:17 +0000
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0Zfg-1o5Wa10jfo-00wRG8; Fri, 29 Apr 2022 22:34:13 +0200
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-2f7ca2ce255so96899047b3.7; 
 Fri, 29 Apr 2022 13:34:09 -0700 (PDT)
X-Gm-Message-State: AOAM5303m6Tb9T7hug6KtfiW4Kxnu0w5rQigZK+3HXo1zpnZHNYpEKTk
 siL63OvgpLjsB6oJ2QLCyszLX41SQBsPsQUgfxw=
X-Google-Smtp-Source: ABdhPJxmchRzlwbhUzJrTXSW5O46V9uTUf564hU5vkqZRRFSlvWrH3L90d9vRfJr0xR1Zvdx0EHMPavAkqrxafxfaRE=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr1115356ywf.347.1651264448577; Fri, 29
 Apr 2022 13:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
 <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com>
 <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
 <20220428142412.GA19708@lst.de>
 <be7e0eb1-c423-455f-bd89-050d52996340@www.fastmail.com>
In-Reply-To: <be7e0eb1-c423-455f-bd89-050d52996340@www.fastmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 29 Apr 2022 22:33:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1CO8_Pa=Hk3hcdNfT_eD3PQK2aWDFB9bwk6TCNbGmtEg@mail.gmail.com>
Message-ID: <CAK8P3a1CO8_Pa=Hk3hcdNfT_eD3PQK2aWDFB9bwk6TCNbGmtEg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
To: Sven Peter <sven@svenpeter.dev>
Cc: "hch@lst.de" <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
 Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, 
 "sagi@grimberg.me" <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 Janne Grunau <j@jannau.net>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mREFlLW2FxdLzFxa1JihlPyUkYa65shvqSrdLYHBBL7zS9zDzVD
 hR2wvLhYstjH5Gz821jSYlQXyhr9BbzUCkp08suS+MGBOt/7fON++FXab19ZHdPuoj5Pi/o
 giMf1sNtIMBmhYoJ1lWzY+aXAZaVNLSHL16Ct7YHmeBvqtl4fGrRBgI2WZl8cLxOxI8oxCz
 LiuBLTXAOBUJzJZ97kXbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Kf70gNBz+o=:V9af/yddgKC6j16MMRkwnf
 hwEVTRwqDcUlBvN6UBF7uAhnI11LeYC63LjsrMLadw7rvLniMZ0W/Irv5kkUAXVscGV4Y0Nnh
 rcT746lwz1RV/bNcjZQwx9EltBfLYpaGNxuCavEL0q3eYZRA7QJ9ghbWRsDHJyUkSUDmj/IQL
 3pRkF6u18uzhDgx5THQksC8R0B8r3YkL55HGSRlOz7FrOO1ke9hDBs9bmtXuSJq9oGzQRPEnO
 lc7GDIgNbGCgh2Ju8s/h4Q1qgXN/fX26rvDht9bhH97Kh7n3CNadKqhueSYFIgymWdw8dk6YV
 kFSx3VPjk3gtxHQirUVziET2+DPrLRDfHxY3MlpJvP+ZzB5lfZhu8V1fkHUvWtGmgyMmcbGXt
 E95kv1entKyS63dlt28g3N2aeJpcGBV0/7Zlpy9X/FMOcaHl1NAEvLzTDulEds4osO5qndRyt
 LkqGWdHOqMmnTCNN2nEl+5z0y0qfz4zxcyr1wv1G8PATXk/IDhw0VlLCpYKcx5zui5BQhUxoD
 rb2/0Xxyc1pjFrvnpirlgGp61l06vj6DLX0o1TnhC0GyDDzjvI2W2pA/NzCYbAeu50B27SLjq
 k6WD7EuHzGsoVp/DnfoSaKwknsVeMJ5QSoZMZEQUtVSN/tIP0Jmy/ODxQkT5h8pTPqYnUezeP
 5fUBTmrUu+4+mmOo7Zk5AdgUIYC3VfkSyu/+cAOCi0miTSDFAouNGxlrb/qVjQdE+Ci4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220429_133416_475137_B2BE5238 
X-CRM114-Status: GOOD (  25.38  )
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

On Fri, Apr 29, 2022 at 6:37 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Thu, Apr 28, 2022, at 16:24, hch@lst.de wrote:
> > On Wed, Apr 27, 2022 at 07:39:49PM +0200, Arnd Bergmann wrote:
> >> The usual trick is to have a branch with the shared patches and have
> >> that pulled into every other tree that needs these, but make sure you never
> >> rebase. In this case, you could have something like
> >>
> >> a) rtkit driver in a shared branch (private only)
> >> b) thunderbolt driver based on branch a), merged through
> >>      thunderbolt/usb/pci tree (I don't know who is responsible here)
> >> c) sart driver based on branch a), merged through soc tree
> >> d) nvme driver based on branch c), merged through nvme tree
> >>
> >> since the commit hashes are all identical, each patch only shows up in
> >> the git tree once, but you get a somewhat funny history.
> >
> > Given that the nvme driver is just addition of new code I'm perfectly
> > fine with sending it through whatever tree is most convenient.
>
> So If I understand all this correctly either
>         1) I send a pull request with rtkit+sart to Arnd/soc@ followed by
>            a pull request with the same commits + the nvme driver to
>            Christoph/nvme to make sure the commit hashes in both trees
>            are the same.
> or
>         2) I send a pull request with rtkit+sart+nvme to soc@ and we
>            take the entire driver through there with Christoph's ack
>            if Arnd is fine with carrying it as well.
>
> In either case SMC (or thunderbolt if I finish in time) can also be based
> on the same rtkit commit and could go into 5.19 as well.
> I don't have any preference here (not that my opinion matters much
> for this decision anyway :-))

Correct, those are both ok.

        Arnd

