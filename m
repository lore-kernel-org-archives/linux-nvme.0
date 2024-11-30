Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8C7D73606
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Nov 2024 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R0AaYkKFQsr+kvv/7MjgBXXDtojf1j/34zDnDrr0iLo=; b=IgNzrk1zC01U5pZjbhSfPiyrIu
	QIxpxuZn8ecH+8X4eGzPM5nplrLi9MiruRFsuAYrX4hAie5gdrnWyS5VRxQkmzreXqIJV3mzgNmeX
	fcXZuYnG5u27KMWwVF/lsg19GFcfv3gO8jEotuICrVm3lKHhFkaPETl0vvjJydJjQ2TVBguZ+fmOr
	+pvZYxonS7Mlr6+VO/cFQyEndtLLhhPj57vPoV0/K0UgjxW3XQXJLsmjm8OAvtYJ50h4oNrY1lf7k
	+xlw7Fcwp/+Kc1jYpqha85B/+etjN/XgZG71vH816cWJuMwxuK/qAnBokJs8/yCgbw2K4YZKPtroY
	PbKr2Vlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tHQsA-00000002Kmq-1L57;
	Sat, 30 Nov 2024 17:03:10 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tHQs8-00000002KmP-1GAt
	for linux-nvme@lists.infradead.org;
	Sat, 30 Nov 2024 17:03:09 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-724fee568aaso2762033b3a.1
        for <linux-nvme@lists.infradead.org>; Sat, 30 Nov 2024 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732986186; x=1733590986; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0AaYkKFQsr+kvv/7MjgBXXDtojf1j/34zDnDrr0iLo=;
        b=gByp1iQYCqIH+SrCXSqjJ8l0DC4L4YnAfjfGX0/byDcAo9eiuH4mdvYmGGbIUFzoxq
         CxSqaGoN8xNKlEoMbKjo8mDZQ7aynOvop0JBZE6KfTw+mdmy334LE4N0pCfUaDEwsveB
         Sv/+8GeGRuFpcgW6oMaTqPJHEaTosWhpuk3BZ0JI46ryzeVfcdznOa3L78nIpBNlTlKv
         4Nb6x4LcqlQZZcWeivJR3lm3JWQNvpHPL/dPOAUWdQ7I8foEfHWu5Rc8RasCOoCLzOqt
         qIxGrqPz7Jv0n7sqYPkmVVpyxuwBU1KcLhNSCB0FJFWpxR8s/XMaGJ31ILXvj4hen4U1
         6SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732986186; x=1733590986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0AaYkKFQsr+kvv/7MjgBXXDtojf1j/34zDnDrr0iLo=;
        b=Q51zyZo7PWO33O9+2Htimhr95JfGaw6/cWD5C8XkgBjvNtSJRrpgntI8rf8OCYN0Q0
         7bU5RnQpIaRuTq7Kv3UR2ALiayaHQ9P0j4qYWMoPUSpGG1KcDaXtLwXEzL82xp5IRTH+
         nCwroTPMWS0J+EkZ6LGxHllK2FlAxMv8Npy3YYN7IJz1Lvk74F1+Z4R76Vhixs35q3wy
         eUF3TnvHs7Y+qRLdjEHhoRBQmQJa7h24BoA9AJU36KR2P0VZCvz/wDdfSdrrEi2MrHQA
         +zFbOAKmeGTydj4fv4DjVdYCeKrOxE7Cn7Lo8RScaHSe4LZbQZq4gJU1UJDQkyroo+ci
         8WEQ==
X-Gm-Message-State: AOJu0Yy/zJYJKIauMCyxC4KAOjzLnb+UYxuOpRQEUWrexoDowFYTP/Mu
	deICJAxm7gTBz7z3xPFXm/CUI0kcmPbrP1N7gV+oyD+DKicQk7H76JZ2caZi
X-Gm-Gg: ASbGncso8ns8uhs1Os0erMNY2G6MpsvPt8en2/RB9IKEKsRnXNP2ycvD6dTSqXXRVjo
	QnyoyCg/jde/8buCVf+Ctf5gt0hKMbsjxzniRWneaKsdqd72X/pob1gvazFztqkIQfqcbBoJsPQ
	jUTbz9UZGEXwm4Y1cE+rXMDLDoR2Zil47+gellnT8bqB6dp9Wl9y1Y4skOJvdPPijETRtRQQU1o
	e4aGqQ8LBpy9OsuCQmmcuItYhhfYigVfNc6JoyiXqdeXCN9tAFN5PU=
X-Google-Smtp-Source: AGHT+IHQKp97T17O74v5McT9T0BT8I/76CwyQ8bY2zWeqhgmq05Cw932j8Sn1yhdnHCSU0pyiULZTw==
X-Received: by 2002:a05:6a00:410b:b0:725:31f2:5d0f with SMTP id d2e1a72fcca58-72531f25d78mr25094931b3a.8.1732986186262;
        Sat, 30 Nov 2024 09:03:06 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725442c086csm5319466b3a.189.2024.11.30.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 09:03:05 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmet: replace kmalloc + memset with kzalloc for data allocation
Date: Sun,  1 Dec 2024 01:02:58 +0800
Message-ID: <20241130170258.103954-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241130_090308_383676_9B7453F1 
X-CRM114-Status: GOOD (  12.07  )
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

cocci warnings: (new ones prefixed by >>)
>> drivers/nvme/target/pr.c:831:8-15: WARNING: kzalloc should be used for data, instead of kmalloc/memset

The pattern of using 'kmalloc' followed by 'memset' is replaced with
'kzalloc', which is functionally equivalent to 'kmalloc' + 'memset',
but more efficient. 'kzalloc' automatically zeroes the allocated
memory, making it a faster and more streamlined solution.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411301434.LEckbcWx-lkp@intel.com/
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
build test only.

 drivers/nvme/target/pr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 25a02b50d9f3..90e9f5bbe581 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -828,12 +828,11 @@ static void nvmet_execute_pr_report(struct nvmet_req *req)
 		goto out;
 	}
 
-	data = kmalloc(num_bytes, GFP_KERNEL);
+	data = kzalloc(num_bytes, GFP_KERNEL);
 	if (!data) {
 		status = NVME_SC_INTERNAL;
 		goto out;
 	}
-	memset(data, 0, num_bytes);
 	data->gen = cpu_to_le32(atomic_read(&pr->generation));
 	data->ptpls = 0;
 	ctrl_eds = data->regctl_eds;
-- 
2.43.0


