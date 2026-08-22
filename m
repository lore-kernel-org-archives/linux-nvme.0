Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B24EC5DF94
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 00:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rAZejaEbKsnP8oB+qFIJJ4xrJXuHQxUEjQoIuUKalNM=; b=WzI6osG2UwUpLhZus4EzC4U8QU
	YisCZ5/MDuH+ZCQ4SvPDY+WTjwPnB6ziQsDORgBeN87KfEichL7g5ek/v5wM+buJNanPMojWSMJRk
	aXH9KPA2W07HRZs3BrwyVH+jkY03TyWVpQHfCxoAU3YVqF8TcIIljT6RHWPl1buVC+ikW1UjX36gA
	AqTMILv5jVABG4fT/6ApciitfGZ7w2eriZgaB+GbGyQRK1OHdKmGosYyBDMwNigOtCqrc1wFN6S5C
	257z2/7GC5fLL6jHBGmM+8XD21V51mdqs34WQAtIgqO1EcfSTka9LKzO9MdQpPfnxSe1WfIQqX5m0
	KcMQo+dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxZHd-0000000EBCR-20zh;
	Sat, 22 Aug 2026 00:08:25 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxZHa-0000000EBC4-2dXy
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 00:08:24 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1730050a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2026 17:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1787357300; x=1787962100; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rAZejaEbKsnP8oB+qFIJJ4xrJXuHQxUEjQoIuUKalNM=;
        b=Fj9xwh631T+b+Km+UJk+Du0ySsRqwg+4xcKAWAmFIR74SO/MK+DkLkbn5X2INgoWJF
         2W1xjE4KKgC9oCEmtjkjVAXdVlTDeWWbn+0xUBDvUEqSYM6MuCE04fgJVkjBiTL9v5zt
         LZwPQ02NejymeHmdjMFU19BT2DMkgYpirrHSyokvns9oooQxjHqF2dXLj2OwzydNI3vR
         tXoj0WWf0n/YRVrVyKecgomGp14hja99QCewyQbAof8wySYvG3nNcrTPsJ2+aB8X5WKg
         Mb3D9/BN6yyZRoQrSJYlDBjSm/yegWgJGIj7iZ+cJ2FhAQ1vqO82SuuvAVUqr6LBjqL7
         oL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787357300; x=1787962100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rAZejaEbKsnP8oB+qFIJJ4xrJXuHQxUEjQoIuUKalNM=;
        b=QyRa68aM0YEwa9D+sTx6tDy0Q3R3JQuFdLfhgFLfgu/AATGdsiafvIqbeIEHQhPZjE
         +rtsK8I+9SZy0AnLlV0C+hiTrPXOuHB6rCyDOHhpq9pO/i3tpq/hMzji1r0dq18+tw/7
         uFptuNlShPWzyhMtI8h5VszDSZ1yuolCOMhmqiLhI96Pt7QPDvi/ks3KhQtUvLWiZZOw
         qUGOvjl+QnhqbXGyi/Ry7yn6WSyV2A4h0JK2sScv5X4H2hcMjz6vNG5/ZLpyShu88XZp
         G9kSK/kmDcTOvNqVzr4PMMRobBCAJzTGhOcMfsF5dOxFFYIRm9pZ5CgugiDj8MPZrech
         eg2w==
X-Forwarded-Encrypted: i=1; AHgh+Rr6yH9x8A4oxmwjqW+9YW3u2Xd8+t0uwcCX0N/txSsSipwHZs0c2Vi75eiE26cQf6Sp8peyk3L7jwzq@lists.infradead.org
X-Gm-Message-State: AFuF++l0oxRP1O7AH7jFoM/2G8NonLo7/ov3n4J9JbFq2DWC7NVwlMyR
	AE2VpEw9mCAnL4EoVDnv3xJKvwHngwjbgt9I9A38vTKAUtAjJc39cH9/HkN/WvILn++aPbxvdwt
	JN5cDvdir+w==
X-Gm-Gg: AR+sD10QgmrwkKcCCO5IY7ftIXKEZsuJuyx5ZnX9f/p2uiUHpWHyVZOPvrQ8nRODw1i
	wGrcpo9uG3Vz/YNum9A3brnKZcDQSEyBOwXpudGS8msUiHS8uYHhg+IZiNkiJD2YAA3vBYiLxau
	XTFFstrQpgaL88+WJEFs94MVV21UQt5XhDeP4k4KkBoQNWYpPjlrhwKTxh9Bg5U+hmBqkG5W9LK
	FSjVFK7/YcaJITsoJ0cqO3zNU7hPOEM0z6bosRgzPAQUTGeP6rlP9vSkQxHay7E/Q+n3YUQg6Gi
	tFavWucPGI1U9sM6FpuTyxCipSUcARZssgHLtB4sqUkqIm77W+KQzDXkzhrJCfGM/0AzjEmmYQn
	VwcG3GeHw3I45oHVJ0vOdkUW2bOojfRWimX5UmHwFzRBi1/zO81dc/c6kX4Zil9Q5CzFsffrekB
	A83p8aracmZzYVZ0WxmMR40Ib2xa2bTFSFroe4MpkQwvy9bO42pkskO7iQAwY21uyoC0qC+ptKq
	uhkad2MVtINrmEo5ddx1EKpK1gBt85Bbg==
X-Received: by 2002:a17:90b:164e:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-395c352fa60mr14692097a91.9.1787357300647;
        Fri, 21 Aug 2026 17:08:20 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860c697esm1683257c88.3.2026.08.21.17.08.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 17:08:20 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Daniel Wagner <dwagner@suse.de>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
Date: Fri, 21 Aug 2026 17:08:01 -0700
Message-ID: <20260822000817.65989-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ab3300bc-1ac6-4235-a0e6-350e001e91f6@flourine.local>
References: <20260820083634.71689-1-saravanand@crusoe.ai> <ab3300bc-1ac6-4235-a0e6-350e001e91f6@flourine.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_170822_715689_6BC75B54 
X-CRM114-Status: GOOD (  12.79  )
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

On Thu, 20 Aug 2026 17:39:48 +0200 Daniel Wagner <dwagner@suse.de> wrote:
> FWIW, from past experience if this gets accepted, it is most likely not
> the last policy controlling knob which is needed. I see this somewhat
> orthogonal to io_policy options. Thus my question should this user
> interface be just a bool or should we have something more future proof
> here?

I agree with you, wq_unbound already exists as a boolean and this
patch introduces io_cpu_adopt as a second one, which is why I had
to introduce a precedence rule so that wq_unbound wins when both
are set. Adding more such behaviors as separate bools would only
multiply these precedence rules.

So rather than a bool, we can consider io_cpu to be its own policy
knob which is orthogonal to io_policy which primarily decides
which path the I/O takes. io_cpu=<policy> decides for a given
connection's queue which host cpu will perform the socket work,
with values such as default, adopt and unbound.

On the same theme, the one heuristic in this v2 patch is the re-arm
idle time, which could be surfaced as io_cpu_readopt_idle=<sec> to
become configurable.

I am very new to nvme-tcp and I dont have any strong opinions on
how to make the contribution future proof and reduce burden for
nvme maintainers.

Christoph asked me in v1 to move the knob from a module parameter
to a per controller connect option, so if you and other nvme
maintainers have a preference, I am willing to consider the
interface before v3.

Thanks for your review.

Saravanan D.

