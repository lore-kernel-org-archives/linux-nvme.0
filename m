Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0897BC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Xz6rkNFT+N3+z5GHliBzDaeRK81yOrfk7eIGZzmG81Q=; b=sNk9CG8F6V+0lOVc7zGJ2pqCHW
	eGv3BmZSvgH2zDncb1sme6CjKum4Pc5zh6vMpS8XhEQqB6dy59xD7KKxrhJqZ1CzL60mvcsHLPc4C
	cEriI278St3zanG6cjrjOqT2HLpROnq0t+P5UTuH3obCsiOqtvXE+8WpkMRi8De7N4XMeqdsR44LJ
	23wQsBeVgwGAHEhoB4hkxfoGITXcm7MBfyVx6vga8MaK/AFvxCHzw4dOiDtxphcolkMB75xeMnGXM
	VwsHi/zWdYTK9dLlygMaJ6f8rLfA9mh0Ij5rr3pEsqUQh9FYv1cFEPXNu3zNmlMaiLrHekHpql4vp
	MsEzkFhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olXaQ-00H7X5-CB; Thu, 20 Oct 2022 15:35:58 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olXaN-00H7Us-TG
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 15:35:57 +0000
Received: by mail-wm1-x336.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso2695981wmq.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz6rkNFT+N3+z5GHliBzDaeRK81yOrfk7eIGZzmG81Q=;
        b=LrPvFB8gDO64B7UiPcOEb4r4czILVjpCtcxZINcfAFDa3JVnVixw8m/oGT/SX21zP/
         Gr0oby3J6kWKup8VmdmabJ/RmMiUTF41qbixfM8VEDJItjOUfbI+i4eL5pPeXKNAC14E
         dFkAG4sTNCeJGTXP9FerhSiUuerkXXeqxmrzw4EjmqkkUs0TqQd5EofrRaek32k73Lrv
         hovubnAzUZ9PQje3IfBFZK8uo/EOI95RVgx3leGIGBT81cFNKVXmL2Sc4MI9FZ2Jo2o3
         E4+/DFmy8GAK+x+xJAmWJ9xFNcSRq7lHXKBFpaqNZHYOCvETpZaQ5vW86279Aqavyawn
         TvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz6rkNFT+N3+z5GHliBzDaeRK81yOrfk7eIGZzmG81Q=;
        b=uhPMI33NYl0URbx734mIMVrmeh9/FuCAlvDV8Ranxl6t0dqHzUPHhcPSTQffU68X0l
         21tvx9Getpu3NP+RMlVh0HwmcZXqMYx02NKcwEDWirGyJQZEGkkx/I6hz7zXG6GubQwd
         Qit3bGDlPF4DlQCbEifS1OqoeMsL0w1i6sfuC73NQ9lVkUygvizXboKAKtuzzCc1FjwB
         t47ah7co8+eutBXGnBVq41V3J2VtYo2pI+swshJf43XEPgJlji+2S+/jGQscjAf9yfCs
         YWFdRxefXNIOaScL/smsLDOpzwvyffCxopVyRpBBZT1JzgHnxof5lPpx3mnk0e6GQRTn
         ouYA==
X-Gm-Message-State: ACrzQf0SKTXHFVSBDF03yBQaBu/7Eb8Cjs2fIxEwNzPR2swfZ+kszfAb
	c+Jy4/OANFCMVETM7K5vHb43uWgu7QrmjA==
X-Google-Smtp-Source: AMsMyM4pV8NHWIEwjJS69o/OmV0HUECe6P8KknLlVHAsYIYC4Dfxg1lkV2Mfvx/hOkcIzm80PmhVSQ==
X-Received: by 2002:a05:600c:4f46:b0:3c6:fb4f:3e1b with SMTP id m6-20020a05600c4f4600b003c6fb4f3e1bmr9922108wmq.159.1666280151918;
        Thu, 20 Oct 2022 08:35:51 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id u11-20020adff88b000000b0022e2eaa2bdcsm16486515wrp.98.2022.10.20.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:35:51 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvmet: use try_cmpxchg in nvmet_update_sq_head
Date: Thu, 20 Oct 2022 17:35:40 +0200
Message-Id: <20221020153540.8226-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_083555_962088_0AAB8A4B 
X-CRM114-Status: GOOD (  13.64  )
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
nvmet_update_sq_head.  x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg (and related move instruction in
front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 drivers/nvme/target/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 14677145bbba..a384a0927aed 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -695,11 +695,10 @@ static void nvmet_update_sq_head(struct nvmet_req *req)
 	if (req->sq->size) {
 		u32 old_sqhd, new_sqhd;
 
+		old_sqhd = READ_ONCE(req->sq->sqhd);
 		do {
-			old_sqhd = req->sq->sqhd;
 			new_sqhd = (old_sqhd + 1) % req->sq->size;
-		} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) !=
-					old_sqhd);
+		} while (!try_cmpxchg(&req->sq->sqhd, &old_sqhd, new_sqhd));
 	}
 	req->cqe->sq_head = cpu_to_le16(req->sq->sqhd & 0x0000FFFF);
 }
-- 
2.37.3


