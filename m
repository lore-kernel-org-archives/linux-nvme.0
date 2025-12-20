Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B84BE668B1
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pWVHQnXJHLnZGKwql2taywHS0CwUooADxiatSjOPg0c=; b=FzaF94rDfM7Q/35zNNYwAhsAt1
	AVqKx6dE6rEny0gofP2REySkmybpRIj0jBWEO+K3zticW5ymkSes4m2bw2LTZMS4wxqt/rpVgX/6b
	CkHCpRxIIAU/MKCfiHN22gxBL3gXm9JhbNSIHZAVppHUoh95aBXBHBRA80By/9DeXOADoA8DYC6SM
	yX6KYBwDncI486cJqPihUXs9FXjkwH5WHrthWBj/g7X32CJzIyHOcRsSLykIEHa/HAz79y8ekr9Qi
	eX172NGiC/Ctbn4XZl2ZueYq1kTE7QfyWi52uTeT0DJtm7qNMSHzqPEWdEjrU+zioKq3dMkDsWrTj
	t9LdqDDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vX0uj-0000000BmnU-31ip;
	Sat, 20 Dec 2025 17:38:45 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vX0uh-0000000Bmmz-2dAT
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 17:38:44 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-37d275cb96cso26917811fa.2
        for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 09:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766252321; x=1766857121; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pWVHQnXJHLnZGKwql2taywHS0CwUooADxiatSjOPg0c=;
        b=d7tZ8Z9YTtKqyIlz19J0e+HJjVpHzCrzTSyk6MhoCvNI9iuZ98R0jXPtO8kMuERGOE
         /bCDbiwPJmUEyjzK9e4Zs7MNRgwhojF2/1Hv4weNQvJXGVrft8YFZYYOjhW74bk82IFG
         cp7aDrtc5od7W3dHGDfqziKTKDhMAhqo1TUi4uq1Mlb+Ep3QlogAe+/yWvZKWwpj4gVU
         G2v07ecan1PvyLBH1gtfu2oZeiAlYA1Q5IeIRQm6PmJlsu8L8bUhOzUtpuk20kgHnXW0
         slVUXjBEhSrzulELTE1Scu56r7CRlJ1Au+75VIJxYp/CHkDDEbt6hEFTqc0XD5OQ+cdO
         8tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766252321; x=1766857121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWVHQnXJHLnZGKwql2taywHS0CwUooADxiatSjOPg0c=;
        b=TiC1DgN2o1o9DmlXKzBywAwRZJS555uYQxr7rF1q64lXqy4FqYlhWmhtYo5ApSOKKd
         cQIUPmuPsPLcFLwnPXbEwKKoYDz9v9JzgHxZIZtqQU1X0oWMq043BI1C+/ZPWDJgapV1
         MzzgtpuBTxMP29idGO34iBx9xCH7dtbDkeMrVIwbQkzYW+CwAu3r6QxkvZdW1NC0BvIC
         wawORbbbn5/NWwHrVoPjbdVbF9RmJf4JO2pPRRJ+we6b0B/Tb65AEAd+Dyh900mfktIj
         gcO3LSiylrJfJMgr28OzUZDWWKe4/xJtgcSOn3SynOwX5Xp76idFBRKFHsV0SEQPNcgX
         raaA==
X-Forwarded-Encrypted: i=1; AJvYcCVfKqluajdnVa4H1h7RjQRqZMcVpKjkzpukErc3dfWAqUeCcVgHkYnUZzvuCxrsbNThv39Rlq7uBx7r@lists.infradead.org
X-Gm-Message-State: AOJu0Yzru9cHoJHpU/YLxDComz2QMon/ZjtN8kOqawShR/GvWaJ3yzvW
	WxAwO0IZ/qSFLTHrpr3M3E2smykLPpiVHN66cmUj0DaKIAAXQHt/DyFL
X-Gm-Gg: AY/fxX521IhSGqOozsNvC9CrNVbOYq6TtHa7WBXhdL9iEvMYh52NIvh5nn9BW0v3zuz
	wTGtQbUFj1J9vwxh/PXjm+gVFFn0FRZwJ/jfVixPFDsV5U/NN/nJ/7oZ4KYKCNA5NNMXZTlzgZ0
	XcZwxTUMvA4CQy/YDtlriR1uU2gITF8YgUSvhG88OOj1acxXuQ4W0c+/ZQBJqhwRX+7KiKMmGHf
	eSvA16ffGgETuSQZ0Nd20sVKPey6atfBRHMWaKnRi1nYq9YeIimm5kirwzd6jr01zq8Ijn6R1c+
	sP2OHk2kco942kmVC2yCs/bJx4QMb5tNDQP38Ifc6FG+8w8izYR3R1rbQqYkKfSW542PLG/HBe+
	xkpMD0IETF+QDfnrNbgxyDYxLGFRphan1mefHhDh1b2MSlHLU5ky9NsPkZYrxERsg1pfai9Prgc
	8WwD8K+D8dZpcmCeu92859v34x1ND2tzmyW6pbsXgaG/1F
X-Google-Smtp-Source: AGHT+IF4oZaM2X0MjOhaWnNrJhiLDqITwDIXbBo4fYLLk5BmYfUmhvV6jmaDiuDNjWd2FalLYanAKw==
X-Received: by 2002:a05:651c:41c6:b0:37b:9ab6:a071 with SMTP id 38308e7fff4ca-3812162d6a9mr21438191fa.28.1766252321190;
        Sat, 20 Dec 2025 09:38:41 -0800 (PST)
Received: from mismas.lan ([176.62.179.109])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812269da5esm12685351fa.50.2025.12.20.09.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 09:38:40 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH] Do not require atomic writes to be power of 2 sized and aligned on length boundary
Date: Sat, 20 Dec 2025 20:38:33 +0300
Message-ID: <20251220173833.71176-1-vitalifster@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251220_093843_673728_725A0C1C 
X-CRM114-Status: UNSURE (   7.38  )
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
 fs/read_write.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..8b901be75a9f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1807,12 +1807,6 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
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


