Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABD8C4708F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 17:10:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5317261CA2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 17:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5317261CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AJRBjGrfEsdudtB5K1tCCNEayYZgk/uNDfPaTTSc5H0=; b=EXfZGbrDwUflLO
	CZ5LhnYW+t8x5ImFRVcXyDCz0UaVUbPKqWdh3KX1k9+hV2tboza45N40uJtS5eW9L4exE6GKl9f44
	lTDO+5Hof14NcWRyL1hjkufrQIzvIGPaBZ41c5aNAi+BPeV4CVx5LZmHqzEjswzb0r+HHs3T+1SKf
	geV+Pb/YfeX8zgt6uvDwEFNGxv9vb313xpFr7/9aCiGbBRVjqraWtmaC624xVvJBVLJUcgkm6nacg
	M5E4IYLXo7GW8qZXSClX/7vn4PejNg5rB+2IZvDomzZzY1ruJAYdfKTc8dCOZO3OR1H28TuDsDgxd
	IEyP0Xf0CojQKfgzfABg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loUNL-005Oah-6f; Wed, 02 Jun 2021 17:09:51 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loUCi-005Jp5-8c
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 16:58:53 +0000
Received: by mail-ej1-x62f.google.com with SMTP id b9so4825376ejc.13
 for <linux-nvme@lists.infradead.org>; Wed, 02 Jun 2021 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zWXcMXIXe43DdCrZwVU2gm3AEkb9sumOIKnJ91MhiyE=;
 b=JiXeB/Iy1jWKNdpMloH98tmAwZD74NrLiQ5MTLgZkzDDVb8UIwCWxiWXodkOAHSuUG
 hcM8Sye/pcZKp8X3tV+iIC6JStx8pJ1FmrwQuo7nkG3ZrrezuL3hPOeAhSb8ck4Ps+xy
 Hjc+GTe6C3XS4+PbV2XGBk2wY6t3DgStD40lKH9x7kKS2T6nuDKe6L84Su5xFlOC5FLp
 BSw+ZdLog6CjXNoHzKnOSblkk37VFpGNyoLNttuv1pPUK2JBcrT8E/CVLEbOrJu6EHwW
 Q5JP8yvFO3o7T2olG/LE9lqlJNVdZQ1CQGyFpzEXis6qaU5Xw9PcWqg1d3OyhIiGFVpE
 PVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zWXcMXIXe43DdCrZwVU2gm3AEkb9sumOIKnJ91MhiyE=;
 b=mSMAifsRp7ws1NsMro8Mogr+s8j+Kr8+5cAlfbhH9lEIB33r0isKVWHJ4CGTsc0SSH
 PhGpqC/Lf4ivaARFRD00W1ZdhK8qxrYkopIu4MVXuFZ4YxAQ1XB42rLfk5rGbFN22oWE
 bK8HzUKROtcJFi/7iGQwMwwpkWAaUEBy+lRlFMs5WNYVvJ5aSUBje3DRsVmdP03it8zl
 p1Z06I5N5ICig37XVMoTr6SzBm+z8BMldXHHISg8a079LXbFwWV6mksWEeJsmaOr/fQa
 bu0LGTaAhoSn1p7T9Zo5REKKcennqHR0x7LXCpNM60xRwbrszc3lm+pmBDs5osfINtbc
 tg0A==
X-Gm-Message-State: AOAM532Bk2iEwYAEzo6XGZR2d/p65mFY0MZ5VAZo9sCHdrImmU7O/ZxM
 EVBYiLUh403XC/VuXPZm8L3m71GOwVijZSwILeWT6IQ1yok=
X-Google-Smtp-Source: ABdhPJyzpEUyoSUxNR5hxxu6L4MBKcvAkWHM1TzbrC/z9ibGHM+lE9wTXpLUfPAKJjmb4LBOSXCts6y1RE4oAlG8+Lg=
X-Received: by 2002:a17:906:c247:: with SMTP id
 bl7mr36152569ejb.288.1622653128035; 
 Wed, 02 Jun 2021 09:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210531225222.16992-1-smalin@marvell.com>
In-Reply-To: <20210531225222.16992-1-smalin@marvell.com>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 2 Jun 2021 19:58:36 +0300
Message-ID: <CAKKgK4z7o1f-PJ7Ta_fGAhxMie_ftB2UV9Phy2KjrEh5WFx9mA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 00/27] NVMeTCP Offload ULP and QEDN Device Driver
To: Shai Malin <smalin@marvell.com>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org, 
 davem@davemloft.net, kuba@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 hch@lst.de, 
 axboe@fb.com, kbusch@kernel.org, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, prabhakar.pkin@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_095852_365501_8A8E8742 
X-CRM114-Status: GOOD (  10.87  )
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

On 6/1/21 1:53 AM, Shai Malin wrote:
> With the goal of enabling a generic infrastructure that allows NVMe/TCP
> offload devices like NICs to seamlessly plug into the NVMe-oF stack, this
> patch series introduces the nvme-tcp-offload ULP host layer, which will
> be a new transport type called "tcp-offload" and will serve as an
> abstraction layer to work with vendor specific nvme-tcp offload drivers.

If there are no additional comments on RFC v7, I will split the RFC series
between the following non-RFC sub-series:

- Part 1 (RFC patch 1-8): NVMeTCP Offload ULP
  The nvme-tcp-offload patches will be sent to
  'linux-nvme@lists.infradead.org'.

- Part 2 (RFC patches 9-15): QED NVMeTCP Offload
  The qed infrastructure will be sent to 'netdev@vger.kernel.org'.

Once part 1 and 2 are accepted:

- Part 3 (RFC patches 16-27): QEDN NVMeTCP Offload
  The qedn patches will be sent to 'linux-nvme@lists.infradead.org'.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
