Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A8AE75448
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Dec 2025 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V8YUcaf/+H/QKaxsmZyXiuyc2oeBQf4LAuC8T+FhL/0=; b=2/tI1SwZh44NicdZ3yARrtBoAp
	0Dclxfks6t5/CTynXkieJ8ZE7FLX1Qz4Ik3votft6mQyHKOTP5SmoARqraeTJqo4OZP8DI6J6/Gje
	cQx7nnpYb9pHhmqTIv22SerCF6zg79qVjAv42sImEISx4kUHFWM8dI2NgTAlqab9qvTm/5mZyCrAe
	yTR5xL+IiTwepIRdWOe94sq9sqTiYcjIJUMSj5TzGB0GajbtnXZLAQ5Js+OewreFD8JYA9kyqguQN
	9T34IRtaTcl/WEvJ9mgf3eXN1p0lu2oh8Tm6BI3Vls4va/xLM9347S87ne0Z07QULpvdl1V1D6Lw8
	puR7Yxng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYNQg-0000000Glkp-0GOI;
	Wed, 24 Dec 2025 11:53:22 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYNQd-0000000GlkS-1hI1
	for linux-nvme@lists.infradead.org;
	Wed, 24 Dec 2025 11:53:20 +0000
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5957c929a5eso8340294e87.1
        for <linux-nvme@lists.infradead.org>; Wed, 24 Dec 2025 03:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766577197; x=1767181997; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8YUcaf/+H/QKaxsmZyXiuyc2oeBQf4LAuC8T+FhL/0=;
        b=TlxEUktPnbC8EIAeDXHhUKhMVmkL8XzgxOLTopTQJS1lbMFiIsLUCOBb8sNWAOqm6m
         ZlBvbYFBGXYvkQqUQQMvxlIsTsnx7XKrrUILPNpOd3laE/DKaoj3GxOE7Lol8bn5nTPM
         u+71jhUNuDTn2g3PEjGL98HuaOTvGnSBlsENKp4KTboT2Xq/p6NAqYeakX9ISBmagqbd
         4IulpGYtxSw+MEQEBG/tGJJ0TiXRFAzmnPKprQm/jqC/+QeOH826UVkW0EyHuaj4OUd3
         s75EpoOdCflFdqq4TnBo5OhE+ybKRKDjIqHrfRIvKlCt/Ez7Wcgs09Wbws2fmDmhGN4u
         vAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766577197; x=1767181997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8YUcaf/+H/QKaxsmZyXiuyc2oeBQf4LAuC8T+FhL/0=;
        b=dMyyl+u9SdEjDF+bBHCHE/2sdTrupjv7yA3JWNfyRADK2gwz53R21EkdtcOQw/uGHB
         shM/C0OozrNm6OzLSxXNDDyKsulvZCm+eE99vaAoiDyPUG8KTuV4zAKUfwfhesEq1IxO
         94xgy6JdEwydCRwpNhxiuqeYVg24lyzjFDILm1HwuEKjVzgxB9M2qg7qddY6SMPFanc7
         gBsWFyF/j48jEb6h6QhWeQKL3lxELnN3G7mDjj/FzrPLQC5kkHVJ7skMez+IK6GuTPZs
         Qpz2qGr3+88oaOCEfvKWIIg2i92R2PsLmDJ8DxeHgS1/4eF1zrYOuiCm/GW1x8AyhWdX
         oNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu2aTuDChjKofSSYCSCl9MzsS/ztly6+HxON+OWOtGHLngQKE0/u6+z74slDGv5bqiu22u3/84FacG@lists.infradead.org
X-Gm-Message-State: AOJu0YwQRwcoyrEHWHsq3bQXW/u8NkseRcV90C+7Bkoozsg6VAtuQPow
	K6T9wukNyxX/bQaLtX+eCT92u3T8b1aInEulu+iorjJ8zumqyet9CH2H
X-Gm-Gg: AY/fxX59zUGk9HhPA+bacbw1ZPWwfkZAO0hIh4TzK94i3hNVu8AXgO953ebFi+GB/II
	lWVPYk5bK4jomQ6M9mHZciRc2kMP1UhZUBc86DJtNHjMtiQdEm7Ky1XOiC4aqNrAh8/6lwKXGJa
	WYh17laZx4KVpuP5sc4eTlCHpfkPvPMd2qQuIuvAfbuEwXHWc0mDJVSg+pUFqLtFV5fU+sItH5d
	zw0HUQnWCbA7ld2n1xAw4meWTqHNfwZ8UEgWlLupj79E/5CUQ2Pik6UEhgOfjrD9A9VlndWPK0/
	eb8RChFOPMp3yvmkm/1Ok2iuQ7bCWU0IjuOvSsk3fROnILR3qmeQfaPs0Wnl3WI+yNdpfhx1d0c
	436tjCf7/SrgelZUH71VZ3EobDv5m6tMHLK38p5nOvKIHZk/ocbfHtuFuIOaIq8ns5UE5P5Twuj
	ceQl6XIAlLuDHvbAUJb8R0g1bSE7+tLtM/hDWDC9gIs4LVuIpMw8TBab4=
X-Google-Smtp-Source: AGHT+IHl8Eo9AGUWnMOS6OLlY8nnfRyvT8wSGm+8a+ZcGoLGwGz2KeB3ggknYBIzCKI0HX26v2IIwQ==
X-Received: by 2002:a05:6512:39ce:b0:597:d765:19f9 with SMTP id 2adb3069b0e04-59a17d057c9mr5575656e87.4.1766577196486;
        Wed, 24 Dec 2025 03:53:16 -0800 (PST)
Received: from mismas (filipovv.starlink.ru. [77.50.205.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5d7csm4847935e87.20.2025.12.24.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 03:53:16 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
Date: Wed, 24 Dec 2025 14:53:12 +0300
Message-ID: <20251224115312.27036-1-vitalifster@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251224_035319_469958_284E8916 
X-CRM114-Status: UNSURE (   9.33  )
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

generic_atomic_write_valid() returns EINVAL for non-power-of-2 and for
non-length-aligned writes. This check is used for block devices, ext4
and xfs, but neither ext4 nor xfs rely on power of 2 restrictions.

For block devices, neither NVMe nor SCSI specification doesn't require
length alignment and 2^N length. Both specifications only require to
respect the atomic write boundary if it's set (NABSPF/NABO for NVMe and
ATOMIC BOUNDARY for SCSI). NVMe subsystem already checks writes against
this boundary; SCSI uses an explicit atomic write command so the write
is checked by the drive itself.

Signed-off-by: Vitaliy Filippov <vitalifster@gmail.com>
---
 fs/read_write.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..5467d710108d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1802,17 +1802,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
-	size_t len = iov_iter_count(iter);
-
 	if (!iter_is_ubuf(iter))
 		return -EINVAL;
 
-	if (!is_power_of_2(len))
-		return -EINVAL;
-
-	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return -EINVAL;
-
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return -EOPNOTSUPP;
 
-- 
2.51.0


