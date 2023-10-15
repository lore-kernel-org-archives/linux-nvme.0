Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CECCDB47E
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Oct 2023 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8GofQLZWTi6FbZHWXBIt+6WRQsgJYYQDRGNXx0VI/oQ=; b=hrGiXUi+UtHRNS5/pN5b7xWNw+
	wBlht1TcW2yCiZFPzoxQEsRXGCOOiHVfncj7hSddIo/AFYrgf5B19UiIasfqUcot9cY2yfo+7Rd+t
	yNIIzB7Vbq37RTTMfTHI/o7KQCaciFBWL917aNB1wwGYVnfCBh1g2MvCOV+2HJcqKTWFp5hDdho5D
	IjXh4jSHLcMPT3GdFeKfojYvp8t7oeU2qXjVvFeG/kR+oKXywf+vVsGduEGoB1sYpHMkgbrEu6M2b
	a4L+eQSUIKwn9Qc4zhCUR++quIs6vrMlVPIw9hRz5cvp5GLzRLNAxloK2oSOeUv4ClhiXyYZpa/b7
	lSn7hTiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qs6ey-007bsN-1y;
	Sun, 15 Oct 2023 19:20:20 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qs6es-007brv-2h
	for linux-nvme@lists.infradead.org;
	Sun, 15 Oct 2023 19:20:16 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40537481094so38904085e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 15 Oct 2023 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697397611; x=1698002411; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GofQLZWTi6FbZHWXBIt+6WRQsgJYYQDRGNXx0VI/oQ=;
        b=hFFWMV6Q9Nu6NreJVQz018RP5hPjFPKaSMN4uxrs1nV9Ka/5z6V3uZWFoS2PPlvaLR
         Ws8iRuwDmdJtRsEPFhmwU+6/ozRS/3E8K/YhZsXlLaT/gZaA75F49ZiUmnkqxLwKYoqb
         uTUFOZYbcihAfL1AQhm/VoPCMjSFzNcBp0g+deTrc9TIq70BDu2IOhSe8g71ryAKXBIW
         F8a74lmvDeOTV9lGtOI/PlP16lXtGgwdpMAKt5tXbI04CnFY8mVyOvOcBaPrVL/LtCQC
         98r4W1aaXOeakjEe3HRWds6xIfTANqO5yeUTIJwE8aun0HaWUYrPdXwuSqbUzzttRtlZ
         Zo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697397611; x=1698002411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GofQLZWTi6FbZHWXBIt+6WRQsgJYYQDRGNXx0VI/oQ=;
        b=nwBkuIuBuwfIFSTFCNMAU179wJEP78ikiCTjA/m4q0p0bPqiseT1JpBx9t+TcMjRhe
         uAdHWyjhOZvYOXZND9k6sG0CFpLeueHrklg2Eb4EMZeQgPgI7b0IwoM8ZGjjJwopDk1n
         bs4r75H3fTpwprvP+8Ls6bdEbIH5IgNCCxwe8ElOMcWi3qxbQamTJlCP5T7cBRQal3oN
         OR98sqQ7Nv+ft6T1WlztCqwv6ym0vrCOUMgbvLjh9wgC00cpzAcvxt1u49p3xAwg/5fy
         DqT6DiQKXy3FxWCha0CPqNmOoiDSzVLRyXA1Vu7qEjg7ROCbaZWMkq7o9wkkr7jmet+h
         ZPUQ==
X-Gm-Message-State: AOJu0Yw/qFvp8F3yCBZtRa8itj1W/s4kR5u8afv7CSJdRcA/18IEJpNm
	/JqiaNngUbgsfSLQQRXeMXlZDbnFz3ZOMdqCe7s=
X-Google-Smtp-Source: AGHT+IEO6jRQY0jXh4Tku2XP4+Z/ER8upt6B/6W1/9HjOIaH5cul61iotiIWNzdCVUPNTj0udX4pcEQ+I6aneunUQ2M=
X-Received: by 2002:a7b:ce09:0:b0:403:b86:f624 with SMTP id
 m9-20020a7bce09000000b004030b86f624mr27452222wmc.23.1697397611251; Sun, 15
 Oct 2023 12:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de>
In-Reply-To: <20231013154708.GA17455@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 16 Oct 2023 00:49:45 +0530
Message-ID: <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, vincentfu@gmail.com, 
	ankit.kumar@samsung.com, stable@vger.kernel.org, 
	Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231015_122014_961224_F60C8DAA 
X-CRM114-Status: GOOD (  14.96  )
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

On Fri, Oct 13, 2023 at 9:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> The main limitation is that the device needs to support SGLs, and
> we need to as well (we currently don't for metadata).  But for any
> non-stupid workload SGLs should be at least as fast if not faster
> with modern hardware.  But I see no way out.

You may agree that it's a hardware-assisted way out. It is offloading
the checks to a SGL-capable device.
I wrote some quick code in that direction but could not readily get my
hands on a device that exposes metadata-with-sgl capability.
That reminded me that we are limiting unprivileged-passthrough to a
niche set of devices/users. That is the opposite of what the feature
was for.

OTOH, this patch implemented a software-only way out. There are some
checks, but someone (either SW or HW) has to do those to keep things
right.
The patch ensures the regular user cannot exploit the hole and that
the root user continues to work as before (Keith's concern).
So, I really wonder why we don't want to go for the way that solves it
generically.

