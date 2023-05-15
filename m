Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A33CC7EE22
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 12:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A48EUvATFnZh9D6jBlZ8QJ+HRRU2GPVKxJ6T/ClswYY=; b=fF0uyodSOke0i526c5Cj7A9Gp0
	YsFL+VNlDpMtfvSnCkO7jjpc0+TYCmNis3AH8nOFL0HiIQYF5HOHbz0eHLOMZlNHdl8Qa9u6YWPKV
	dY3LvDqTtl7U8lnqVgQ3fkXXWFUdsw9nLWHI04SgQhJZlSV6Sk2hsZVPiSvQ9aNpvuB++d6effBm0
	n+JP5RTadaYiFQ5j8QvKaGrR0xxGtRTR2aw5WwmaUjA/GE4OfsxtXYosmdw1dtafJlm29qnX+l1Rt
	3GURvL3nzTr4ZsGcsv8LlyiNASuQwtS5K+5get224Q/iS9xycOimMVrV0Qo/HVMxROeG1JghHkixY
	ZNr7D0ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyXls-002Bio-0q;
	Mon, 15 May 2023 12:57:48 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyXlm-002Bh8-0h
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 12:57:43 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9659e9bbff5so2356581166b.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 May 2023 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684155459; x=1686747459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A48EUvATFnZh9D6jBlZ8QJ+HRRU2GPVKxJ6T/ClswYY=;
        b=B94E+rYQEFtywvHsGIgQ9mmQaaFbdMyn2sKZp5SXzSvrHpndqya34/Wg256icZ6H/d
         C6i4TBNb/nm9LFRrnldiL5RDBY0qQYgteR/qWCNp3ePZaI9bS+aDrBVGH86FuarHNLh/
         qOdS7lhDJzCWsyL6E4cUVM5SBRoc4A4oZDsG+e/KSeQ8LNU1PasU71B7rd+TFN1kaXlc
         kHu+DujDp3gALaNiGffHF6f52CccQqkVN104W3Adg3ay1TBfsI2XomQ3y22dzIa9Hwji
         RsTMTDVKIRBWhune2y1mIWFfkoxRJqNJhrF7WQpPSYNAzLzVeSUCCkxLtGjCo11EGGUY
         ZVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155459; x=1686747459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A48EUvATFnZh9D6jBlZ8QJ+HRRU2GPVKxJ6T/ClswYY=;
        b=eMtQF327uQ1rQyi5fHHDwgTL3VlL5mhY8e2v2F9t+KpdTSYs0w+mph5I3BHWb6YTi3
         rY+6mVoxgwxpRm+0I6BJEJ+Lpo1Z/XvH0s0lHYRBsaAz83ZzRaBQpGXOtLkxyKE68jNF
         WdFXYAHTCBCt1jkjinqHy2ZbxSPv8s9b4I1/m8Lj1lSbnTq8oW6GN448cZb+bi49xyNB
         CviS6kNKa2p0X0Jn5HP027SUPFmKCcD5DfUG/AD+e71QG6DJLgXxLHNx0VYS6gVTpWhK
         C0MeNSF9q4V5j3uUmo6Oj32pbAok2tLyTzyQtPkAx9Rx8bUqijoTysKRcbYSk1piFL5W
         GlJA==
X-Gm-Message-State: AC+VfDyFbpv7pcEULVFusMOCWLpwDrFPTM2vI/dEvgzO7DNiH5oiz5/1
	ewjIRK98gnWsQdOB4DNH8NQJvOxal3g=
X-Google-Smtp-Source: ACHHUZ7Ng0cIhxR4lpY4sfifZqKzwQl+W7KvOkOYDWeQBODzPtjKkf8J4RxdtSlK5nvP0gOSrg9eQw==
X-Received: by 2002:a17:907:6088:b0:949:cb6a:b6f7 with SMTP id ht8-20020a170907608800b00949cb6ab6f7mr32952390ejc.56.1684155459464;
        Mon, 15 May 2023 05:57:39 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::2:6366])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090672cd00b0096ace7ae086sm4003685ejl.174.2023.05.15.05.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:57:39 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	axboe@kernel.dk
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	joshi.k@samsung.com,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next 2/2] nvme: optimise io_uring passthrough completion
Date: Mon, 15 May 2023 13:54:43 +0100
Message-Id: <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684154817.git.asml.silence@gmail.com>
References: <cover.1684154817.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_055742_254413_2F0E797B 
X-CRM114-Status: GOOD (  10.87  )
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

Use IOU_F_TWQ_LAZY_WAKE via iou_cmd_exec_in_task_lazy() for passthrough
commands completion. It further delays the execution of task_work for
DEFER_TASKRUN until there are enough of task_work items queued to meet
the waiting criteria, which reduces the number of wake ups we issue.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 81c5c9e38477..52ed1094ccbb 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -521,7 +521,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	if (cookie != NULL && blk_rq_is_poll(req))
 		nvme_uring_task_cb(ioucmd, IO_URING_F_UNLOCKED);
 	else
-		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
+		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
 
 	return RQ_END_IO_FREE;
 }
@@ -543,7 +543,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
 	if (cookie != NULL && blk_rq_is_poll(req))
 		nvme_uring_task_meta_cb(ioucmd, IO_URING_F_UNLOCKED);
 	else
-		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_meta_cb);
+		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_meta_cb);
 
 	return RQ_END_IO_NONE;
 }
-- 
2.40.0


