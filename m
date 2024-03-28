Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E465ECD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 23:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jH6cSamYqu9y6NrHpddafX7jLWVjJSO+MIjSmesZ7SQ=; b=oDlYjQBWbozfuqck1YJo5chq3/
	9D0yOb3873sgNwVHXGkn77NepSW0b/ZdW017UgarL+KGjiHo0n2+ETv4LwpEjrOE7bpdkbY14VnG4
	Hj44VwKf7arexW6uUM+voWrCMajn9jP7baTABoxJKsuhL6hJuEjMXIE1S5qFMOcYQrPpTKQZvo1lf
	uBs7SDBdsGasmQ2A+l1T2nEpZZmGyc8sj6pZU4tp6TpOx26MEtrUl5HGPeWxePcHMUrrnz6Wk6R1s
	ewBhpYx8q8+pcOwfmqGGUttzK08Gr4hVQ54G68CXsLhWJWO/sLpxgDHbk3tPMWBq/nrOXiY3eEE0a
	dTR5r3FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyoN-0000000G1IT-19sn;
	Thu, 28 Mar 2024 23:05:31 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyoK-0000000G1GN-1pnr
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 23:05:29 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1dd3c6c8dbbso2198005ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 28 Mar 2024 16:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711667126; x=1712271926; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jH6cSamYqu9y6NrHpddafX7jLWVjJSO+MIjSmesZ7SQ=;
        b=SJh27cVxIyAEGKioJRqa4XTNpchdy79RNRkZISG6TbSbQNUJH/cSE6ET9hYtJ5QU77
         shWPTv2KpvpjFOulHwLg4kTHTCX0clUv1FmWNo7c00nXdAvgCHaWF8wLew3mTNKDcTvG
         G/Q4CnRDr3H+dGDl4VyJz5927cOQmDF1ARGOAg3ILwvsMzbwFTuGrOpYF13p8ziFVl2S
         3AP7W1Jd/jHMxi31+yKGNMH+6gfgnVprbV7ZfofYkjfJ6+YV31CSXer3XwtoHRdf1Q8A
         RTKbm2oiLzXOWTQqkK6JhqhJBJVNGOVmlRIf10dgzwkysTTkYG+O4COTLSGNmrdqo6Ea
         aquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667126; x=1712271926;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH6cSamYqu9y6NrHpddafX7jLWVjJSO+MIjSmesZ7SQ=;
        b=OpxA9EDwWJmZLeDlR0KRUZ1y+hzvzm7OtuAi/g0u5gMM8DrOFBqeUEA79mTt2UYOnj
         EjzQnP8+67xffQa7ajbq/h+VNk5anY0WWAzy7jxUA4L5oDKjKmu7fKfHv1db+Yj1z0Vi
         ZiM16TN1zdZzKSraPITVwEUqykWD0CMslpWERHjI0IwMMT7522fIDpqx+JfST248A203
         uWNBprWKj0ePuzDKfhkHwl++HJ5yWkLwUgfOW2RXA4XBhc4mMnQUPeR6aci9xVodAqw8
         3WC4i1gJR4blIY9yyG/qGEfTvFZf7EFsjfvXbUlU1+9sBnVi16WOg+U1KUGBhnewHJec
         CcNg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9k1tYxwfZ57gEEi0V+02XV4wo24DLrI50MILcTEIi5rYXHubSaKYhlifxEReJpeAAOVnqakSg/6GSVha9GLvlFqAt4ZXAhWdXBO9ueg=
X-Gm-Message-State: AOJu0YzoGEj5/CMW98Q/3myPNlbJwEI0Wz2KkjazLTN43O0k93JvNQsV
	DNbmyGwXAjq0ZRYKu95YSieGQY6w83Ko1irKZdn4m9kKJr7Kq46yxlEFyNHyC9q37WB9audwb10
	z
X-Google-Smtp-Source: AGHT+IFz2PM05uHbkjHCxEwx7ITQmcuHmP+Q9onJ6IDFb8FdZ5M8mwUFVEVXNdLv1bOXS14zB6XpZg==
X-Received: by 2002:a17:90a:77cb:b0:29c:7487:43b8 with SMTP id e11-20020a17090a77cb00b0029c748743b8mr839839pjs.1.1711667125810;
        Thu, 28 Mar 2024 16:05:25 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id cx18-20020a17090afd9200b0029d7e7b7b41sm4013902pjb.33.2024.03.28.16.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:05:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>, 
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
Subject: Re: (subset) [PATCH v3 00/30] Zone write plugging
Message-Id: <171166712406.796545.15002324421306835511.b4-ty@kernel.dk>
Date: Thu, 28 Mar 2024 17:05:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_160528_516702_B212E880 
X-CRM114-Status: UNSURE (   9.99  )
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


On Thu, 28 Mar 2024 09:43:39 +0900, Damien Le Moal wrote:
> The patch series introduces zone write plugging (ZWP) as the new
> mechanism to control the ordering of writes to zoned block devices.
> ZWP replaces zone write locking (ZWL) which is implemented only by
> mq-deadline today. ZWP also allows emulating zone append operations
> using regular writes for zoned devices that do not natively support this
> operation (e.g. SMR HDDs). This patch series removes the scsi disk
> driver and device mapper zone append emulation to use ZWP emulation.
> 
> [...]

Applied, thanks!

[01/30] block: Do not force full zone append completion in req_bio_endio()
        commit: 55251fbdf0146c252ceff146a1bb145546f3e034

Best regards,
-- 
Jens Axboe




