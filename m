Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F52D116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9JuZTiXTtCfnBMrxTr4djU8x13PVqvGl4QPuQVkzEeA=; b=YS2dBDa4dUmt/6ivEX/JNLaq2L
	Ha447RbDyqZTpwzJIMb34dBS9Fsy1mWAUSYUj0b7mpT/zQDv5WMc8txSCT2TW15gTXeVEidOPtfkj
	ePwlQnCSiFijj0iNPt9TL046CgeqW5BVaJDpPdqEQfZOwIeH5dk3yMTErnyS+h6ADvmk1tMngVx31
	iDG1HVrcI4CAMiBXCe1cTdhb/KnBqttXv4jLoOlYXrDzuPAjAuXoAE/T1Xyo+deMQhtkNqdd9QSQ2
	RdUQCANPdCr29upTzRGD7GyObtufFlqqoVyUsrZLjeFJQjV+cvuHjaEBbhngU7Bwc+lq30diBY4t1
	ODKW/Z1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtvD-00000000A0W-1dTI;
	Fri, 28 Nov 2025 08:33:43 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtv9-000000009uy-0eOz
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:33:42 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso1002931a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318818; x=1764923618; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JuZTiXTtCfnBMrxTr4djU8x13PVqvGl4QPuQVkzEeA=;
        b=hC8wCx8L1mD5gRkzl+RfBkVmGF46UDlY9/YCjMuXFR3WwncWrXAaeTn/XkVJQUPykQ
         87u/WBCE9oPz8D8jJ34Y7f92XMlITzmz2NK6K03aM1snmk+gyg4xactiYd79dTV2jIkc
         A2RrVJYWwcRAuyquY4axi5rH2XVsqwO2QrTHJHtYctHrwfSNRzQ3X3H5kRw0urxn+aY0
         4vccPfb66oEvUR1mZ8kkstHoSFcTm3NMXXhZ424p80jnsZ4nzRhmXOo75yjuUS+JZ4Mt
         W3eoReaQEId8kcZpg6a9BaPtP2YD0SBt9o7oU9cNhZDLGsigsEl8fpDPpCAd5Dnz+6Q/
         Pn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318818; x=1764923618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JuZTiXTtCfnBMrxTr4djU8x13PVqvGl4QPuQVkzEeA=;
        b=SzHcjMq0tBxYCXZjEy26x24oSrRv4Cef5HBHLSVo3xelMIAC5YMni4t2+wozjlisH5
         4nYRnDxOYinERjRCPrBvQRcr4vf76zDn6r3gsd2kwSZsfaqqKsr0Yok1kk6aSvSrZ5yo
         X+Tr+fFCNCTFqFWtcXOtPTpPHdSu0y39Ha5cXjH9PXmRut8MBr/213/uM4a9I45KzCGy
         A78726/wEpPK4/L+06jJVMWWCQMWI2YBqIWp39U1ejwNIOvVOFv/yxKefJ9TciEmR1Su
         UFfKjjBFEMrEDUmADI2KPN/s2+q8jQBJfNYbUuCb3sCxr1+VC2gvmx+tacTrv0T4RyID
         yyDw==
X-Forwarded-Encrypted: i=1; AJvYcCVxrVVf3Du5MyJpSbHPsuL0+cCR9M3Gs+yzVb9aUBOIKWamGlnzRU/NTY+81mDbgFhPLtegviznnymW@lists.infradead.org
X-Gm-Message-State: AOJu0YxWqAY8t4WZXXtKrXP0UzYUfxT0wOShUjmxbne9qC6wHPcmb07V
	UCO8/+XYDe6cfd/kMj+AsRRA5Y60Olbx87h79vBjCby0WaQn4METpdj8
X-Gm-Gg: ASbGncudrjxU4tM2lqnyOBADlbsb9rechbgFyu1hZGq4i6QxOlFz44/K5j2lHBf6jCv
	oIXPT6ld8HX6CGY0Bqbg0pAyMqdNz9wyTtoI9GkqWaaxCu6u1E491JxfuDhC51HVy3qorP5+lc7
	HiqYwKQo8BEVf1LtC19VwcQqpiw9lXhEe0fsvrEOS8gB2DgitqkLjkTTHXiHtVkHmlcZR7gjOk0
	bK1ySZMwcmx8/BgwwgwRzNC5vmINqGf020SxXnynhufUOZnzCTSNstxfFOEcWF4dQ8BJkMknb7x
	d18XL2gfpJJGXHKbKLYunpWG2hcLvUhd32MT9puZls+NUujGbIKqcCppZqp5h3Awm83T4UvZfie
	yd6y6e0uQSan7P24FtHBrEhdyKPjbY5Ut8Ftw3ERHjzpupvWY6QtLXnQGXGmU9OmnznVCuZz4E3
	8uoS6c/wM6jYCAx/QGkpwlUYUrDg==
X-Google-Smtp-Source: AGHT+IEiYKFOm1UmbHzu9Io+L0ipF/pftCo6ih2XEqCkxPLrZNrFMt6HrxgMvpe9BJ/P01XRe5CPUg==
X-Received: by 2002:a05:7301:162a:b0:2a4:3593:ddd7 with SMTP id 5a478bee46e88-2a71953bfaamr12018765eec.4.1764318818087;
        Fri, 28 Nov 2025 00:33:38 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:37 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
Date: Fri, 28 Nov 2025 16:32:19 +0800
Message-Id: <20251128083219.2332407-13-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003339_240895_1938DC5C 
X-CRM114-Status: UNSURE (   9.69  )
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

From: Shida Zhang <zhangshida@kylinos.cn>

Replace repetitive bio chaining patterns with bio_chain_and_submit.
Note that while the parameter order (prev vs new) differs from the
original code, the chaining order does not affect bio chain
functionality.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca60..4af45659bd2 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
 
-			bio_chain(bio, prev);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 
 		sector += sg->length >> 9;
-- 
2.34.1


