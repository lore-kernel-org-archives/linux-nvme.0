Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B82E668AE
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rl/cdRp1y81VP+t4Wtk4iRNQzSmALctEG5vDaqc5Y0Y=; b=qjeQRmdMueMN3gpOm9wmHZDHDb
	nFyDBEVhFLlkMsfp69eGdzAKTcG6AlzY3ABrKkoq6HN+QEwFTdp6ckZDQMxPnF5lKFbUluSlWPa4i
	XogATQocbREkBNXhMoRY98gbI6IBiA4MrgniljnruXcf7+e2PO1yqU5qUL7iwdf9crukgbO/cYb9o
	GvmpyciBkOnLFitWDcikUnlzBRL+xOwGbxLKltlbt5ZQe9H6TFsnpOtqOZChCmfxH5/RKqMCc6JhY
	U7dMnb9ROuQq5zMfKW0pl3H55LKtFS7WyRY8iIOAGfmm087+goyEgFY9TJJZaF1lzB2oZpA+FwIN1
	k3GyZBmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWvXk-0000000BZg0-07i3;
	Sat, 20 Dec 2025 11:54:40 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWvXb-0000000BZfS-46Cg
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 11:54:33 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-595910c9178so2096716e87.1
        for <linux-nvme@lists.infradead.org>; Sat, 20 Dec 2025 03:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766231669; x=1766836469; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl/cdRp1y81VP+t4Wtk4iRNQzSmALctEG5vDaqc5Y0Y=;
        b=nhvQLdd4A3BdHgVCEtGPJdaiabwrHb/O0X754TrQbyKjDDa7Gf98JgOTwC7pNCqSYf
         F2ZLjKKsHdpz0wRWqPPOG9L5LJqVyTryDF9ezcvy+Hyv56RFWWahUZhDBhUe7sN+ZIDD
         I1mYzhhgCas7XlpT16qHlHIo0zYcBu9PNV/wG45GMSy2J9h7kRWSbGuGDwjjWX5pfptY
         qOQABZiZ0pGliqL5iilTVFem8XtKeVd+xdEwLB2fAFT0LzmwkCpd2hhpfb4ynf2zHImL
         tHZc7/RgOpxPRT2YenCTYnB2WrOQ0e8FxnTDlj6WomL6tW6XR1Mq9sIos2RK765zI+rS
         5Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766231669; x=1766836469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl/cdRp1y81VP+t4Wtk4iRNQzSmALctEG5vDaqc5Y0Y=;
        b=wiPoslDrmjl+PS6CefjZOYMe7jpK6nhK30hE8v4OoIM1WB0C0a4IDswNkr9PMjDG0O
         okUwO9+gj1FXkO9Jo88eoTYaHZC35eUGfwrd3NgLFdc5PUJS0N9FAzjmYv9PyQ+VKf7C
         Pgr531GCBz5KJ5IWyVeHkYdLTcbKPaNOMi1DoNZ2eQ9nQJUZBe/tMb3e9SpVtmGO5P1v
         MBcVw0W+fgpysqLCJ/AUM7azBlyPPeGD0RWR3ZSD5j2i/2DcILwijAXa4fJ7x9JJRob2
         bpLTLiiwXH61IiGmEyS2H3W5p/4SyR0rwrv51/1oEg1f2YkBzjvyLMOuet3i3nFF1gmV
         5GPg==
X-Gm-Message-State: AOJu0YwE2XjSQk1WiD9gljVeT0VsPnXKLbAdoybnJHwy+Vsm3zs9SnWC
	e4FsQaYr3szqNI/aXa1JN+6rt/4aHnVP8EBgJo5myoJBuySTDDEDoxSXL6KyZg==
X-Gm-Gg: AY/fxX7wqIv+u41dUmeAKJyeQW3/aJRWqom5cpLzIfxZIqL4AVj/ofZZ8DK5yhD97Ok
	jVXXhh9hGJercgA+Ocbowyb2axxHS3BL0Tf2oiCpprmTXFony9okp9RyqXhyLhlJSEWPYtxk6mU
	EPI11JRfeb83qIHErj/SEcgX5uxlqVWcIgRd8XsbJac/BY2iULIHXtRoB+93Pozfe70Cv2ptnFw
	hAuNojKQmHYDngA1/DOWJtglAD8qu0OD5tRvDAT4lsxSZYKT3bN7QxEO2pAf7BxAHyYoN/sfZHR
	pB4ew7pDVqiMOHH3UmIKDLF51qP0zr2Y7e4mdQ2hVClYf9dUjaX6r4WKQm/fM3jQ+NVf128ILJu
	0rzLZcEubQu3LORU7hk1d81jNLPF02dWqKXqdji+kMj7WR6+5AC6lXrvFtnW0sOfk24eBQ7ui6x
	HSPzdY0+/P+E56Gv/ea8KBTcHEexII9Gj2nUNW5bDtRDSR
X-Google-Smtp-Source: AGHT+IH7TQFo5vn2eYkpEL0Qioj5z/p/MF/SG1bn3+U4jUC878nibFbqAaNm11x8VZPmQARLF8RlUA==
X-Received: by 2002:a05:6512:a8c:b0:598:ee60:8aed with SMTP id 2adb3069b0e04-59a17d08bdemr1809987e87.1.1766231669425;
        Sat, 20 Dec 2025 03:54:29 -0800 (PST)
Received: from mismas.lan ([176.62.179.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861ffdbsm1442825e87.76.2025.12.20.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 03:54:29 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH] Do not require atomic writes to be aligned on length boundary.
Date: Sat, 20 Dec 2025 14:54:26 +0300
Message-ID: <20251220115426.12710-1-vitalifster@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251220_035432_030419_C2C36512 
X-CRM114-Status: UNSURE (   7.87  )
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

It directly violates NVMe specification where alignment is only required
when atomic write boundary is set.

Signed-off-by: Vitaliy Filippov <vitalifster@gmail.com>
---
 fs/read_write.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..babd95e7096e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1810,9 +1810,6 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 	if (!is_power_of_2(len))
 		return -EINVAL;
 
-	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return -EINVAL;
-
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return -EOPNOTSUPP;
 
-- 
2.51.0


