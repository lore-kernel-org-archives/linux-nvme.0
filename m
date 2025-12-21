Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97C3E67482
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Dec 2025 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=; b=vtrXQDFQzgOEdpMuu1epWpaN8t
	0f/zMN/9ZQOdLd6PQe2wbfTr/sjzBZkh0PMrWoyMrzUW33cGNLAfCCT2Dl/q4Rl8+6InPH3eBTCFQ
	9Mo7Ow6A/Q/krfG27QmN9rWDVbt5TAGlgoTz5qIF+KWdLmQlwW0fGcM3oSN5cuAORRerq6Ep4BReb
	8ODzsWlSAD/Yoj9FYP2Z8hH5EsjxOoE+KDo8rf6A6uGtlgtvS36aq96442L0+G4L9gXBBCppNlwfT
	kgTWvVSZrHLOs6ZxEjjVoQWJJnP5za8lDjFeyg2W7rQBdn+/TZzJ2yJmie7f+JFdsAShJf6bFifhO
	yugs1OCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXHRt-0000000CNqF-35fj;
	Sun, 21 Dec 2025 11:18:05 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXHRq-0000000CNpo-2RAi
	for linux-nvme@lists.infradead.org;
	Sun, 21 Dec 2025 11:18:04 +0000
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5943b62c47dso3133716e87.1
        for <linux-nvme@lists.infradead.org>; Sun, 21 Dec 2025 03:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766315880; x=1766920680; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=;
        b=TeB8pp7m87AsQqyBxhe9RQm6cSczc8uaY9Q8aDqvtt/jXn/L/UtvGuF8F3BXdmYfLU
         nvKgOYO1nz4k+wHcuCq98FeIHnxO6Vui3Obe/oIR+0Scew7uMbPb9ZTwjcq628HCUVL9
         MhKFgZC69q73phqliUhaTLTTcA/L2VxH6O49+A/fuOj5W13w4Nwr2CuFWeifXL7atH6m
         QneuzGpZClca+0BhmIr2yJR32ccXPdy/U0S4+WJYKqtaR1JuRd9/h85+tVJ5u4icQq0/
         kafsv5Z4wpbllcBBT/c2DwyMkv17GcFlHt4cvKI1GZsdETKgGMozaCcnJ362y0Mpgx+E
         ND2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766315880; x=1766920680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoSQ42mrLVsYXEbrMaFWRBaq0h+SRn/ybUjjsp9uLcU=;
        b=R1fgdC4BtcvqyvfyXKXYrrD/7KC0eTQJFSVn9FD6bfD+nz04/+Vv0foWywkh70FF/b
         jX5RRg8JkfbD4kvzfgOlwAxsPgfDcFfBIFY/AFqugbusxBPknFhCCeRP1FVUmvBljtqI
         HzhcoJPyOXBQJHKKO3+jPkYUgoSgkPWNdALC7OZhepewefqEDlh2BZH71ALrWcPZVwfn
         /V4zss55c60xZ/olFbFTznfp+9kOwuqVk+A/a0PGybJL4hhFUUdmYajOs5z8xWkv9hB9
         KhF9C0Ek5rAj25IDRUKuOEotXQUcns/G8+1LtG4jVmd6aItgnMo3U9ADzYqf+WO/nDP6
         w2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaSjIv4uZ1blYiM8uPNu71Gnkm+wrk9qr/cjct1oYT/LAI+EyYIHquxeaWFWHEv+gYK8HC9QZjnday@lists.infradead.org
X-Gm-Message-State: AOJu0YxNTyDAIjIsJAbtUNXFd4XULaa/y8Z4jxH1oogsmsQi67yVGGvh
	oLCeVQsYkHZHvrxK7mNL/zdDmfwqHidH+q395/SwJn58MljSCekRI6vI
X-Gm-Gg: AY/fxX69GEcXpMCg3uuw3d5jGaljw3Pnd0OlGn1RFWjUasGJzNCL59rSzk3UStQwsL1
	5yQ0RLmGENDQ/KuWyeFnYi/V6voOCeEMjnM88uFRFeWn7uZldEqK1+pvqub8olIDCFOOUwnlVzl
	cl96rvYmZjoCMj/05bqwCUsZODGGvu1IogRQ49jo1bzS2WZHpdDbBLAxaLFLoM7QBBqkyZa1oz/
	L0DquzUOjmAYDGYKDG3vYoH6G79qQP9kQqE1MhMe6PYvePgrLuive5JLy2cGwiys98EF3QgALkI
	3b+DTUVWESmi2iC4Osy/l8sbZ0teMeffcVXpG3pYlZViEjIkIHdLQ7/0lrCJFrQnLbLVaOq21eB
	xef+Es4y/NN152hi9k30JTAM5pG6tP0KPW5VMcobvt8H17px0NO1NRS3Ir1wfLjxB5ziXtLZNYo
	T8efcgrhIBwyHnxEwsjKw/9HYcIQMNGdPb8cIgiOSlfVqZ
X-Google-Smtp-Source: AGHT+IH6d4JJLvxJFsfU8GDWtEpaAdLJtPwCBVEJ7tqIIbHP6cYFV8AmeGI+MWfAbrGcvYKoAAskIg==
X-Received: by 2002:a05:6512:238c:b0:594:768d:c3ef with SMTP id 2adb3069b0e04-59a17d3c40emr3003521e87.30.1766315879363;
        Sun, 21 Dec 2025 03:17:59 -0800 (PST)
Received: from mismas.lan ([176.62.179.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18628388sm2283132e87.99.2025.12.21.03.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 03:17:59 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH] Do not require atomic writes to be power of 2 sized and aligned on length boundary
Date: Sun, 21 Dec 2025 14:17:25 +0300
Message-ID: <20251221111725.19141-1-vitalifster@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251221_031802_631050_D464B632 
X-CRM114-Status: UNSURE (   7.43  )
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

It contradicts NVMe specification where alignment is only required when atomic
write boundary (NABSPF/NABO) is set and highly limits usage of NVMe atomic writes

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


