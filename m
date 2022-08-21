Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F89DC32772
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h6HHRBszP1qSaglLBv4CHXp3Ol6/zrgby+DBPe5JflQ=; b=wXx9j3joYHtnsGpZYrDbAcd8he
	zT7cYWLTRgLYTBFhxOkQhU9yErg9mPcKjVyqejkY1JQJ4SW6yUIF1RKyrPUiWfoutvM/eOVrfTEf8
	vhOdcIoRinpmiAMBM+2g9qLjruecZcbAV1u8t1Yp2bmJl9W/Th2XicTnbChkMGRNrohtcxre0iJ5P
	EUoQ5N+jjnFbTW5JAVWR/MnKDUaE+/twkNefUemZuCuS1xc2WVXBpuH4ZEHsb5ffaBGCaFZ2ETZml
	ktZJV1Bgl4k21HJMkYWfoMV/aqmdbAKKv0AIenmEgQH/GnuHwNkFx+asQODANCTcqxxswLL1rFBds
	F/sydU/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPmVf-00Be0m-R5; Sun, 21 Aug 2022 15:05:08 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPmVd-00Bdxs-3C
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 15:05:06 +0000
Received: by mail-ej1-x629.google.com with SMTP id ce26so1185047ejb.11
        for <linux-nvme@lists.infradead.org>; Sun, 21 Aug 2022 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h6HHRBszP1qSaglLBv4CHXp3Ol6/zrgby+DBPe5JflQ=;
        b=KDbmyK/uIIxxyzEqWmqcf7+9xsTBsInN0VwwzclaFHULK/BQNdFv/BKQGPCpuVyzUR
         kveviZ3z7NG/PRoBHBHJXm4rdlBzkVTbge7TyonLodwLUJb0wx6HdqHMKmR704AQ1BWo
         U5fS7iFzaBjzyWXYiAD3U7KP1YGqlTJInD8gXJDPJeIl12Cp3NOMry26wNutT2ayUL7i
         gUXZivwnydcFQMZcuSifKewMhSCY3KoH4b9SstDyUiwpvm0SCPPk6aNxGBzM8AueetFd
         qq69p7x07z9Op0944xhAHX1lzt4Bcz7qiwzI4wLDKYe1ff9pfoZdSSRQ9ChRWnxIXpiT
         MEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h6HHRBszP1qSaglLBv4CHXp3Ol6/zrgby+DBPe5JflQ=;
        b=atz0Qy28EX/Ccsl2MvMMOvfV/1tvhKOPQ0FSbZ/Oo/htDzQjrhp0pXRbpV7XfdJ75+
         nqVB3hgZWU0v9+Liw4Qy/kCChUuD/XYJFz59qJlib8eeGGEBvz5TAKCt4csI9ygnmZK3
         ALEtCI3aaWuIMZ4Y+ZeNpEeF0BL6Cf2luFH9FJj521d+grPHZ3WDukRk7zyfXcyYdwA6
         moZWTij0mdijYH8mK9KmGa3ZLmVIPVu7L6kBVYzeq0Q37P7XnBkvdtQW+fYzUH9lGTSJ
         uPsVOMCzHy71UpxPsAyX2Hz1fE0Ck72eN61Okr3ZrAyPQ/ldqfo3/Q2Z6+O3eTQ8HPs1
         o1Mw==
X-Gm-Message-State: ACgBeo1gLkFubC5Egv2HGx8yqbgclM9cpSxJ7+Avi11RqUaxW5FVkXVM
	Out17JPMKpKwp+xoE867ixs=
X-Google-Smtp-Source: AA6agR57fGQU2gSgrO8yJKl/jul1Q0zkPKgEf+Zuu+ozmwRZ8HdyGhfl0YB1gAfKwsD2lQJIs+6wXg==
X-Received: by 2002:a17:907:3e21:b0:730:92bb:7fcd with SMTP id hp33-20020a1709073e2100b0073092bb7fcdmr10369285ejc.170.1661094302340;
        Sun, 21 Aug 2022 08:05:02 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b0072aa009aa68sm4994409ejo.36.2022.08.21.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 08:05:00 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Sun, 21 Aug 2022 17:04:51 +0200
Message-ID: <5595912.DvuYhMxLoT@opensuse>
In-Reply-To: <c0d5e4c2-512f-3d6e-b555-8a87b1be1db5@grimberg.me>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com> <c0d5e4c2-512f-3d6e-b555-8a87b1be1db5@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_080505_254230_C56A90A1 
X-CRM114-Status: UNSURE (   7.94  )
X-CRM114-Notice: Please train this message.
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

On gioved=C3=AC 18 agosto 2022 13:45:49 CEST Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>=20
> Fabio, did you run blktests?
>=20
> The simplest thing you can do is:
>=20
> $ git clone https://github.com/osandov/blktests.git
> $ cd blktests
> $ nvme_trtype=3Dtcp ./check nvme

I just run the tests you requested.
I'm going to send a v3 patch which shows the results.

Thanks,

=46abio




