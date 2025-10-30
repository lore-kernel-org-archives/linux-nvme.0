Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62A2CCF9E5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 03:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DK21muBo3UIxSycy5cFvME18bLykBwIoMuPFojznbjI=; b=DKQT1b5WqTPqkX7IMf6M3B8TFj
	9KrDf2cKZzNIDZs3Isc6Do6kSrZ1BfB8OD0rtdmAJhOfAJyckvSugVXaQ4jMbcUyE2w6Nw1EEXzzU
	mGzfudfRztvv5CgsL89iTxuvdRHTOGfLPKDHr9qGKty6Pug/lU6pDdn1laosVUjbr+scx2rIlZViU
	41LD7aE35VvhpWh3cJB0mvQzTDRbuKpcVhBhtlnzu06ClZcrH48GDuj2TzrIP/Nm6GHERCR4cnwcY
	a+IgAZUDpy8O2ADKQ09dL9hyDhO6RAAVFC2ynhXME4C+Of7y59fquZexSGDxC9z+HMjSLmrUjWefv
	2V5FXA/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEJhB-00000003QtR-3IVU;
	Thu, 30 Oct 2025 03:51:29 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEJh8-00000003Qt7-3LB3
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 03:51:28 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso428725a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 20:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761796286; x=1762401086; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DK21muBo3UIxSycy5cFvME18bLykBwIoMuPFojznbjI=;
        b=DNDitCgSFxIP6WI0WzkB6c3SE5Fu44Es9Z7Bwx2njh+hnPAd2+5yzz0WTABrL7/jeA
         MwzRG/MEyNaAWz1nJx3M7FkTN6O/4Un1CtbSeYm8w2dWgmxwajqIOXFqDydvK7H5Uh6U
         a68gS/UJU7qxXt0cn2xHw88ijNAnSkZ7AMSM/gcPjEUMA5VJoYqxhf6YU1el+jzaUn3a
         jnIadEPJYyfQZohtZAtbXKeQk5YE3GWihd+zlbjoAw76bppIq+Os1PZMxjRY2djpumCT
         mhYORiW9BIoNHFKkCoUuySK1RKjKYex6WDccThDKNYYspPfHpoT4VLQBYQ2BempIEkTe
         PZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796286; x=1762401086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DK21muBo3UIxSycy5cFvME18bLykBwIoMuPFojznbjI=;
        b=npZkSI4JAxkD6sAMLDvmD5BXji6FJGr6D5qAHlxcR4T50AIkvxGgml0cLi0sd2MLm7
         wZXr9xN4+ZEdosvNZ8y1SN4kCZjLNNEyx7PhSFrGDh/LDy/MG7/flQ0453p55B5ZTtaY
         I7dc/eJtOXQ3A9ryCaQRsvGDdHuFnSjdDuo//GeaFYuG/0NT7yINpRpHHyDf/54iuriZ
         JmGHhD2qbBtC9pVauvFCBOG8vUGMc+8Ussa1xlryZjS97DJCGbdn73R/3b9kGgBaDshv
         PrH7NtfC9cHBwQPCZGz+adNpuUs4U8T1VGC5wWI90Ew+mqGBg2qdLbiu2P8xiTmRvMPP
         Lc3g==
X-Forwarded-Encrypted: i=1; AJvYcCX8Yqx8WawE6MHlog15KyB8ldmRu5aTnKM/O+g1+byVFmlyKWVi4N+CiTqG+9yovnLJ7qINFLsB0GZw@lists.infradead.org
X-Gm-Message-State: AOJu0YyeVW1ZpF8ZxfQdSiLJ6ltlru+pN60twxdgDmmpAJF8Z7G5zg/4
	ZaJYbmWOiEZ1+8jIs7CXSxoTPjruAwopwn0KKXGPaZNntz3+u+WdAt51
X-Gm-Gg: ASbGnctGTZw+4UiT51SBkp8Q977WlkbYe+EDiTifsV197ZT1PI70kroT72nWRj0WE6l
	wA8x8si9hAItP7YFSyM7zj/I2BMH6WosUJGoZWFV3xdjTYi4ACvfok0AtxPmsZSCS6AFY6c79o3
	WL1HvN3Iv/1Q/OJnsbTy5+RrWjD+kpMdWKZ58YxJEBlYWEqfPd3K51flJlfO2B1W309cpr7ZFVL
	H5Tya0BNvBbA4575fG2zaTnJJNf6/s6uzvm2FB8iCLtNYAp2zc+9P7R5btJC/5IJoa6vZyfPR37
	0w3owmqRRt44bZgtzkF5FK5szA0V4MqfEryjp7oW9D0MbG1/wPW+pY6l+EDr5T7C0mPBVGaFvTS
	NGjI2CZo4obuOcRHErH9jigV6LJriwtMqn8//W42ZU53PH+F2dylL72tw0hmVIBWzsSSMwpBIIF
	Rzla+Pe6O+ukbJNpZZTClB1WrrkILezs9qP8Os0+1+q5H23tTVnJ9kTrCGUozWL+hu559FfsKj5
	A7qRQxQNSlqYhBM2jBk
X-Google-Smtp-Source: AGHT+IFFhXTigNwcgut4xjvhuiYCf7MizqLvVK1GubXrZ6u76gHvkgwJt2E9krH32A5XWoR0OKr3tw==
X-Received: by 2002:a17:903:2442:b0:26a:8171:dafa with SMTP id d9443c01a7336-294ee35d302mr21391585ad.21.1761796285826;
        Wed, 29 Oct 2025 20:51:25 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm167953225ad.16.2025.10.29.20.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:51:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/3] nvme: Support PSK reauthentication (REPLACETLSPSK)
Date: Thu, 30 Oct 2025 13:51:11 +1000
Message-ID: <20251030035114.16840-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_205126_958870_DC5B0879 
X-CRM114-Status: GOOD (  12.05  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace on the host to trigger a reauth (REPLACETLSPSK) from
sysfs. This will replace the PSK for the admin queue when using
a secure concat connection.

This can be done by writing the queue ID to the sysfs file, for example
something like this

```shell
echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
```

`replace_psk` will only appear for concat connections as that is all that
is supported.

This series also include some fixes for the NVMe target code to ensure
this works against a Linux NVMe target.

Alistair Francis (3):
  nvmet-tcp: Don't error if TLS is enabed on a reset
  nvmet-tcp: Don't free SQ on authentication success
  nvme: Allow reauth from sysfs

 drivers/nvme/host/sysfs.c              | 31 ++++++++++++++++++++++++++
 drivers/nvme/target/auth.c             |  4 ++--
 drivers/nvme/target/core.c             |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c |  6 ++---
 drivers/nvme/target/nvmet.h            |  4 ++--
 5 files changed, 38 insertions(+), 9 deletions(-)

-- 
2.51.0


