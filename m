Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD97CC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3imiXOhpbNzRxvj4fv0vsBxkQ4hjyHoSIAvra1r780I=; b=A3olboUoWcPxSlLcPSjIOaf8p5
	QQJlGGP+BuzRUtG1iuAsHsv6/Fu0TFDfnfH+rbNl2VOE8AXU/ZXNVKor4F69PfQ+VG+0tCCl+glC7
	4W+RBzrDZvoSkLOld3290t617y/NUp+HlnRlNHDcBAyg0nB6VAKZh2Kbxm1QlPopDNBBppLuv26pt
	djkBJR76Mv7cPhLZYr5RShRG0xRBXzIYBTFIbaCWNejwJ534rqXbSvry71O7wUfEj2YyeBZedgafX
	y+wQhtkYtifDaDLpIyBzWLcj8BWmDXBWfuRGNGA8pPF/rd81hwIuRfft6ANdjKRe1lcaFwYzNAcEU
	T9v71OlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6XA-0000000GPXo-1Rmy;
	Wed, 17 Apr 2024 14:45:12 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6X5-0000000GPU6-2aeM
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 14:45:11 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso79675039f.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Apr 2024 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713365104; x=1713969904; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3imiXOhpbNzRxvj4fv0vsBxkQ4hjyHoSIAvra1r780I=;
        b=PUr6b2uWbhS1F0D3x1Kxq1KavLrzEA1K8SwuZrGeNc8sBxp3oBzFgPA7IT+3a4ibrz
         K/uJhDr6PWi/ibuU+ICXSLS4fJ/WXXyfoQEuTd/v6wjExRf2PGRTJkEtxcvzuXjB/u2O
         bzFPqFL4PgV7CaBckSl/GpLXl08MZFO1sxeVXdkec+ETz1vb61t2lECSU5oUXn+6dBZX
         f1hD079tCTUBPbYob2orHhfTyNCx7XOyVzHP31VTsSm7x7F9AeoOWyNn+a5gIrwrEjrS
         Srb6recvjInZX6qJTVEQBt3xCXWYQx114tHj4drY/ZwYuG2jDB94o1PIME6/NmQrU8Dt
         LfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365104; x=1713969904;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3imiXOhpbNzRxvj4fv0vsBxkQ4hjyHoSIAvra1r780I=;
        b=hkiyC63Wz/kfjSO7xhXNjMdL8xQB2xdKfnLGast1M5sMr44BvqNaBehCxSA6DyeKSh
         vUJlzMDfbux32uqwUUujnuFbLWl1YgLB/Ejm91wO2eSX+dsiZks7YtaSrzsYUC04zeXP
         gp834KiEjViCQt08Osp/OozrqkbswdEk6OjQdUK5Ty3IxIM+s1wG/BHwS8ACRqOqf80m
         j0V7IVNsTfX5rHdDhWKaBBbaymEZY8YRU8hi0eckYCf1zoo8EIepfRt5sZa+oXVRIdQe
         kXKQZOogFQhWBCB6dmFSLdzCHace4qwdsnAuKJ5yBty9lbfNCNiBw+tPi2GoBJ+rNVo6
         EhWg==
X-Forwarded-Encrypted: i=1; AJvYcCVfALAU80D8FUghU3zdRy+xp2/2pWH1yP8omuzDuhsP9Xqw7vY9oHeTBrG6kpzgPd2ugg6SWMGTaI2ESW4Gm4g5NanH3k5GWa5F86AUV+E=
X-Gm-Message-State: AOJu0YwGw7C5PfqAgdT7PRm6cSv1La14U+lER0VBjQI5qRux3NtzH0c5
	UT2n2/cqb05GT96E5KPPW8rvl+POzAdsNIcwPr7Sug7LPMPmzPXHggv7/cmDhFo=
X-Google-Smtp-Source: AGHT+IF0fdXNTAkJe0fRhzf9wvKPogLBbJtbaeMkiaL/Yy1YZ3LxzMQBRxxj8FFwz/o+EVr6wvaCXw==
X-Received: by 2002:a92:c14d:0:b0:36a:3ee8:b9f0 with SMTP id b13-20020a92c14d000000b0036a3ee8b9f0mr13764398ilh.0.1713365104702;
        Wed, 17 Apr 2024 07:45:04 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l2-20020a92d942000000b0036a373e3874sm3727881ilq.78.2024.04.17.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:45:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>, 
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
Subject: Re: [PATCH v7 00/28] Zone write plugging
Message-Id: <171336510373.151809.107599732887371811.b4-ty@kernel.dk>
Date: Wed, 17 Apr 2024 08:45:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_074507_920790_86BBA7DC 
X-CRM114-Status: GOOD (  10.97  )
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


On Mon, 08 Apr 2024 10:41:00 +0900, Damien Le Moal wrote:
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

[01/28] block: Restore sector of flush requests
        commit: 6f8fd758de63bab513c551bb1796a14f8cdc40d9
[02/28] block: Remove req_bio_endio()
        commit: c0da26f950a355ef3540ca8d215351e1ed4cac47
[03/28] block: Introduce blk_zone_update_request_bio()
        commit: a0508c36efa838b16aa93a23e3583d68d3ef6c33
[04/28] block: Introduce bio_straddles_zones() and bio_offset_from_zone_start()
        commit: b85a3c1b7978f942fa5bf8cfe22b6a6aaa49d3b7
[05/28] block: Allow using bio_attempt_back_merge() internally
        commit: dd850ff3eee428b4e1276bd51263dd937643ba19
[06/28] block: Remember zone capacity when revalidating zones
        commit: ecfe43b11b02ffeb24c203af7d3947417d412cf7
[07/28] block: Introduce zone write plugging
        commit: dd291d77cc90eb6a86e9860ba8e6e38eebd57d12
[08/28] block: Fake max open zones limit when there is no limit
        commit: 843283e96e5a3d8379579ac13ce9cbf75522ffde
[09/28] block: Allow zero value of max_zone_append_sectors queue limit
        commit: ccdbf0aad2523ca133cceb22ce0f8306730e7ac3
[10/28] block: Implement zone append emulation
        commit: 9b1ce7f0c6f82e241196febabddba5fab66c8f05
[11/28] block: Allow BIO-based drivers to use blk_revalidate_disk_zones()
        commit: 946dd71ed87dfa8d72f1404f906e1ae413a62d0f
[12/28] dm: Use the block layer zone append emulation
        commit: f211268ed1f9bdf48f06a3ead5f5d88437450579
[13/28] scsi: sd: Use the block layer zone append emulation
        commit: 1846f308d66f9c9a9c4f20df530dc77e57e3d92b
[14/28] ublk_drv: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
        commit: 11be0cb5fe25603472831f85abb32f0112239238
[15/28] null_blk: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
        commit: b66f79b706f0cfc09bde8465668428eef188a94c
[16/28] null_blk: Introduce zone_append_max_sectors attribute
        commit: 997a1f08b4d4283687477470bcc256dfd33ba9d0
[17/28] null_blk: Introduce fua attribute
        commit: f4f84586c8b9c7d5312d6f8fb4db1e12f2b83c27
[18/28] nvmet: zns: Do not reference the gendisk conv_zones_bitmap
        commit: d2a9b5fdc16941243bbd8b360cb6e4fd62f41265
[19/28] block: Remove BLK_STS_ZONE_RESOURCE
        commit: 63b5385e781417e73bda3fd652c2199826afda6e
[20/28] block: Simplify blk_revalidate_disk_zones() interface
        commit: 9b3c08b90fc212de58c34621d83e74977170b2cd
[21/28] block: mq-deadline: Remove support for zone write locking
        commit: fde02699c242e88a71286677d27cc890a959b67f
[22/28] block: Remove elevator required features
        commit: e4eb37cc0f3ed8971c50dddfbeb35a799e5b504e
[23/28] block: Do not check zone type in blk_check_zone_append()
        commit: bca150f0d4edbf02002efa3309bb8e8c9d6596c9
[24/28] block: Move zone related debugfs attribute to blk-zoned.c
        commit: d9f1439a30d607f7bd06494ea2a63018b7d46380
[25/28] block: Replace zone_wlock debugfs entry with zone_wplugs entry
        commit: a98b05b02f0f1f9f4a504564070af208b70214d0
[26/28] block: Remove zone write locking
        commit: 02ccd7c360b1692da164842f211d41fab7d83adc
[27/28] block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
        commit: 97abee507b4b71d43dc1c1d3de4739db2c86c0ac
[28/28] block: Do not special-case plugging of zone write operations
        commit: 99a9476b27e89525cef653b91e542baf61f105d2

Best regards,
-- 
Jens Axboe




