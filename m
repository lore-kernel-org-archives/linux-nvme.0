Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03EAC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 22:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uOobr8g0kT4vEBTgEu41bzRQi+qLtEZA9dzxHh988+w=; b=eIrS3ltU43APT/j1B7Pd+LLldJ
	ao4VlxJ6v2LvoWqqXzvCEQxZ7QoIqd1W7rmZUgPm3zJKYf5yuU34XGU5rC+3Z+VO9dXjjEZVBW4QN
	K5KjVtm6wGxp8TlL+UFETl1PxODbgMTMsFxDthewBhvWSukG0TNeAyRdKwnlbn7wD6AwmWWx/4ost
	0021dJ0W1liB2tmbMiGWSmTgJAUIPrOm2knqWRXhOWhlsQ1RX1EVZs2aiVdodCArq58z+aBQvjD+M
	xt/XX1YhvB/aB3Dfcqu/6SbIz0C1rpKYqZKrZAq79Q3HHinBK03EhviaAqM5yjpQNwsBPptQpKs2d
	au5VCGIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntzKV-00Cqhe-2B; Wed, 25 May 2022 22:18:11 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntzKR-00CqgJ-Ml
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 22:18:09 +0000
Received: by mail-pf1-x436.google.com with SMTP id p8so148479pfh.8
        for <linux-nvme@lists.infradead.org>; Wed, 25 May 2022 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uOobr8g0kT4vEBTgEu41bzRQi+qLtEZA9dzxHh988+w=;
        b=xpDGw8HD+rq0ijZElDdUGvJGAZlpyvFvuENAf0s86Ef94wJeHiSRryth3N/ygc6E7L
         5EbTlAWA2vba+4KQRF0YHYTiOMYpfCE8L2MgOsIZ+w+i7JO5KPkF9xH/YAcXmLPaP1qy
         eQEVgSNsp37uRxguZlUK9MNiE7LoerAZtQ37XcBYz13entkCPWgEagwijO6PNNqKOvJh
         5bm9YGNvIy7wXQ/y81JLv6eS0t7JYb+HoHct/wdceSe1KE2/lnipDp4lcsvCGvwe64zJ
         iGyy7lWhoVTUfy7udPnkAQXCA0uBzZF/jRknEzFU9mqEnFQnJMD/T9ZZ9i97TYy2Tgur
         DZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uOobr8g0kT4vEBTgEu41bzRQi+qLtEZA9dzxHh988+w=;
        b=YN21gulr1eJCrH2smlWvg1Ry5mEbx8ena/aFsewgWBHQJWCfg2WHfMHBPP0gmI5cS6
         K0UPD5cZuSOPJGXZge9PEbsCd5DVcYO2PdvDqFdMndmQDl1WjFnuiYcO0yMSyTOBlnxm
         Nch14eWapBheKQF6tGO7xsZ8FpM6NO0DLqZwnYQmHQiM4/OCSHYOQtU8WCAcqiLxePXc
         oSIb2e7W+IlaBaNAsXEUqi/A5PqJepZOyqncagIht7yVHvTk3xXcmaGbSI9iaB5oxZ4m
         oXnyeoA/wdALZuRE2O2mr8BS0eNxSSntfINIz/JPXyO8trRnQXgR7ZHBKYNXoYbOA9X6
         zGQw==
X-Gm-Message-State: AOAM530GZVsJQDTRYNBWRCExTakd2c/DrGqjDX0qvDRS5QZdRgL6f2Mo
	2I4pxFNECKLIRuWq49kOiLbpvw==
X-Google-Smtp-Source: ABdhPJxpuTeIO1Oa9xMYMhqTlBj9aldPGGnhN2rnoNHGuNNCWXN2iKcf2lIwWGTCgnzjOycuK/okqg==
X-Received: by 2002:a63:5565:0:b0:3fa:78b7:55a0 with SMTP id f37-20020a635565000000b003fa78b755a0mr12773469pgm.384.1653517085208;
        Wed, 25 May 2022 15:18:05 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::4:38c1])
        by smtp.gmail.com with ESMTPSA id y21-20020a056a001c9500b00518895f0dabsm9109191pfw.59.2022.05.25.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 15:18:04 -0700 (PDT)
Date: Wed, 25 May 2022 15:18:02 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [ANNOUNCE] blktests under new maintainership
Message-ID: <Yo6rGhGdccNJXCe8@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_151807_781857_77D224B0 
X-CRM114-Status: UNSURE (   9.24  )
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

Hi, everyone,

I'm happy to announce that Shin'ichiro Kawasaki is taking over as
maintainer of blktests. I haven't been working in the storage space for
awhile, and I also haven't been very prompt to review or merge patches
lately, so this should hopefully make things easier for everyone.

The GitHub repo will be staying in the same place
(https://github.com/osandov/blktests) for now. The main difference is
that you should now Cc Shin'ichiro instead of me when submitting
patches, and he'll be the one applying them.

Thanks!
Omar Sandoval

