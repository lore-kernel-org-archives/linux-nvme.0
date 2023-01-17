Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B37C54E76
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CzwF5BzfZiEwMc8JLNxN1UV7FuteYj/Hj6+tT0FWNZA=; b=yKcGwp5FFLS0e3Fo4i3RqEKL+/
	GbdRFg1mhLZi3nA/8tJ56kIUP9FyibIUAOc+BKfwuAtla8MnnHspmX602HXLUudUuF8lHor4b7f4H
	rs5/uzuYioBLP6ddIXZzsR6SbGYTJirODdq71UHIJNgyFJee0Q5lWrzGEWqSf4WAtD0KN6HDr8rPa
	DqISRF5CUuKLKCEsQhyaQgY8JoPSiVhqWIgkaNSd/bTCoGnXgbaGGqsWWN5RDgitc8Hp/3NUUtPPi
	OuQoFEQfWuHVD3+KKf+guXskrlFp5ktPU8pVfL7iGJu8XgIrQNYyrIADborVCXXF/6efYDH34ROwa
	z34msD5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHpyX-00FILI-4s; Tue, 17 Jan 2023 17:42:21 +0000
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHpyU-00FIJv-GN
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 17:42:19 +0000
Received: by mail-il1-x12f.google.com with SMTP id i17so10904779ila.9
        for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 09:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzwF5BzfZiEwMc8JLNxN1UV7FuteYj/Hj6+tT0FWNZA=;
        b=Vuatbj30pmN4rjk20ihgJ7Zg9SqQwFKjf3Ujz+Q7VpE7HeLb/KBgCBd8p3qZ4GC3F/
         VAcMZ3aKsiXUTgwRtRdAJJh4rxhrWKNk7aSIM/04CQCeuZjHLknYqug9vDT5enw/ZVgX
         JF9gPzKnmWS7ksJJ042s0osBMwj9tQXZW3gutFtj9oBGDFrFnm/NUogZsSNvvMFRWuRM
         e/9j3up6T0QxyP0gr4E179qV30bXOwnhwbyibx867PYPMrKvULntAxSxXRZ9ar5LYyiH
         91Ht/+hQ0WlBPeySnjFhFiBN2sIPSeqEPBHJ+Sk4Jiiu/0ZSOS/T3YJrjn4pem5+umfl
         j/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzwF5BzfZiEwMc8JLNxN1UV7FuteYj/Hj6+tT0FWNZA=;
        b=h9u+6Zs3ZbW2tQP200j4AdQh5OPsEA7PHJfadgBMDlwgbgt/6QEBB5YwKDeQNdgcim
         P1/Sea57peT5TTxLKcjeOA27eUtLnRZ31bYYbkR5blG/p2raNjA4RXjsBziQXEmuimWl
         PLGmbpHPYouox63WTBXaawhJB06/BqCLQ9eB7LyFd7Rd+VG0SCSGeDUv/xeRaDTRnxNA
         Ida6voYApUVRxRoLq/f6bgRqW/C/zb5csE9yjtGhWlXpPU8OdOZvaP3oebEIMK5/UyuQ
         rHcVZgHEfM2ibqJZibY56FltDqxp9TBtuvb13DAT/Jp1J9cl9MfELfurhOTL6IleNquY
         iV0Q==
X-Gm-Message-State: AFqh2kpPXwIIkkmo1ZLIxEO/oDRXCj8Ot0wFzbFW1G2s59BznWtu3A5b
	V+DdTJ4mx2NMDIz1VYVAKNFDElstKjShnXQ1
X-Google-Smtp-Source: AMrXdXsl9aUQNyQY9A36xgDC1oRBAbg4qdu4YRmacmjQXY6rAMn83tdIyxJlvjLYVCB9d4oevmnOMw==
X-Received: by 2002:a92:d342:0:b0:30b:c9ec:fc23 with SMTP id a2-20020a92d342000000b0030bc9ecfc23mr744371ilh.2.1673977336475;
        Tue, 17 Jan 2023 09:42:16 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o36-20020a027424000000b0038a13e116a1sm9670735jac.61.2023.01.17.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:42:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, bvanassche@acm.org, 
 linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com, 
 gost.dev@samsung.com, snitzer@kernel.org
In-Reply-To: <20230110143635.77300-1-p.raghav@samsung.com>
References: <CGME20230110143637eucas1p1d82528b632ccda1de4fb2795ff691fe2@eucas1p1.samsung.com>
 <20230110143635.77300-1-p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/3] block zoned cleanups
Message-Id: <167397733558.19825.2181123982002401602.b4-ty@kernel.dk>
Date: Tue, 17 Jan 2023 10:42:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_094218_582653_90E9F8C4 
X-CRM114-Status: GOOD (  11.27  )
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


On Tue, 10 Jan 2023 15:36:32 +0100, Pankaj Raghav wrote:
>   It is still unclear whether the support for non-po2 zone size devices
>   will be added anytime soon [1]. I have extracted out the cleanup
>   patches that doesn't do any functional change but improves the
>   readability by adding helpers. This also helps a bit to
>   maintain off-tree support as there is an interest to have this feature
>   in some companies.
> 
> [...]

Applied, thanks!

[1/3] block: remove superfluous check for request queue in bdev_is_zoned()
      commit: ef0e0afd782eff20d4bd0c145c647fa01aa16bb1
[2/3] block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
      commit: 3b1c494c4317777da0c5a96b002f954583611345
[3/3] block: introduce bdev_zone_no helper
      commit: 803e2ec47623e5625dd3f5808c175b49f92da9d0

Best regards,
-- 
Jens Axboe




