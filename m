Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E979C77B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M9tbVt8NGPXDxnsDLXyho3uyDx/xTi9YNa7+dwscpXk=; b=lHiuDVBfQr4m8qoBTX6nJKMCIg
	/btu+TZia10bXdgxEv6RgUvzRLqKT6DHuoXIqYaeKXu0sB6HPiXFMzzwPzRsskTlfnRoySYzIrvzS
	4oNAE0m+rugiwk/XdFMSWcOG3NtqW0LlBCYWnuHcQLuTV7bxDCQllhXjcq26wDYsbv52FE9K/y7Rf
	enkU7LJdGVDIKT3RUiZuXyxTtu1pKCZeBWjpKU/3w6LS/D5TGaA+ajgTPHzsvQEV8hZGg4ZnbaEOC
	EmQimeEtzRMzkBMnag9jDBdwiZrIardRtI6PR/9lPPOanjEDfqn4PY++fqenwRyHjxzrkgnPKCNZg
	ywz657TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptl8S-000ZEi-34;
	Tue, 02 May 2023 08:13:20 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptl8Q-000ZDn-0v
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 08:13:19 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-18ef8e9ab4fso2566042fac.3
        for <linux-nvme@lists.infradead.org>; Tue, 02 May 2023 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683015196; x=1685607196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9tbVt8NGPXDxnsDLXyho3uyDx/xTi9YNa7+dwscpXk=;
        b=NxldLMNSsow9pDylGL7yVvCbwDN877TyMMDsRr02XskotQdTrbdjS7oQhkFBBu0/up
         bQCv83W9EmSqqS2brfFikgWHWGxjl2WVoVBmhHqqxTxhOh8dGY1gEVaZP278rn/BRZyW
         BhOZUPa0IYkV065fjbCVsv9EQtolmjqHi4h08ejA/0OuLQPxfBZ4iBmFhM9wnHO04u31
         oW9LwcUvz45aGe3xg+OLuC6KPgCgH6/TfhLucnBfDM7kEpsbEyfCvfmxT4xohg5t26Yt
         0+vLTXg/lxSfsRTLTo/W8U3OSc8n9CihN05XuFRldqocHNjqCNcc/nvZDkHOvWhF5LhB
         GJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683015196; x=1685607196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9tbVt8NGPXDxnsDLXyho3uyDx/xTi9YNa7+dwscpXk=;
        b=KEE5S8rHWTOa90c+rC/+2r1rZhwwJiXlJtGTr9hR9GM0Z4KXTY2aM+DEiF+nAfBrfo
         voRVk5Fzx0tyV1HfF4CcpJ3XvyCKIVcVyEG7a+kz60IFGxH6nqDmVEUQU+ws9Ldn74cs
         06SGFiNisHivhR2OyUJxEvjZEYZn5FLCQotmoV/M1Nr+4+7X4jTbBmE7YQWaZ/arA/hs
         E9yGvb7KriF2VvzRnnFsGlLKwjufGVn6M6R0dfUTrgOA4yLFtveSPVEDW/KgaDwoZbrX
         zWDzv9d/IGvxqg1GOKXv0b+WTLSJn5a0A6tj6/hxPRGMxeqhqOpQI9shmroFNnAn4hY3
         q79Q==
X-Gm-Message-State: AC+VfDxbfn8m4z4elzvS7+1G7TYkWYd/m9+KHhGNCH3RFWZ6/8AwG995
	C0vxkkHH49fHNm7j+GVRujQ=
X-Google-Smtp-Source: ACHHUZ7eQLMklyGh9n7GSnXGOYvExpk5FaNGrkCbxGxvx/HEG8VEETXU/Db6Gd3S4s/xPJzGquktLw==
X-Received: by 2002:a05:6870:7711:b0:18f:aff:8da4 with SMTP id dw17-20020a056870771100b0018f0aff8da4mr7545865oab.35.1683015195913;
        Tue, 02 May 2023 01:13:15 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.194.6.55])
        by smtp.gmail.com with ESMTPSA id o18-20020a056870e81200b001805a3e722csm11975055oan.19.2023.05.02.01.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 01:13:15 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: sagi@grimberg.me,
	kbusch@kernel.org,
	axboe@fb.com,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-pci: refactoring nvme_queue_rqs
Date: Tue,  2 May 2023 05:13:01 -0300
Message-Id: <20230502081301.73007-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_011318_324164_EA9F5982 
X-CRM114-Status: GOOD (  12.73  )
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

When dealing with the queue_rqs callback, the block
layer guarantees that it only provides with us with
requests from the same queue (cf include/linux/blk-mq.h).
Therefore, we can reduce the code for nvme_queue_rqs.
We retrieve the nvmeq once because it is the same for all
the requests. Then the only thing the for loop does is 
test the requests and move them accordingly to requeue 
list. Finally we submit rqlist once outside the loop.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/pci.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7f25c0fe3a0b..f6cbcb63fc5d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -934,8 +934,9 @@ static void nvme_queue_rqs(struct request **rqlist)
 	struct request *req, *next, *prev = NULL;
 	struct request *requeue_list = NULL;
 
+	struct nvme_queue *nvmeq = *rqlist->mq_hctx->driver_data;
+
 	rq_list_for_each_safe(rqlist, req, next) {
-		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 
 		if (!nvme_prep_rq_batch(nvmeq, req)) {
 			/* detach 'req' and add to remainder list */
@@ -946,16 +947,11 @@ static void nvme_queue_rqs(struct request **rqlist)
 				continue;
 		}
 
-		if (!next || req->mq_hctx != next->mq_hctx) {
-			/* detach rest of list, and submit */
-			req->rq_next = NULL;
-			nvme_submit_cmds(nvmeq, rqlist);
-			*rqlist = next;
-			prev = NULL;
-		} else
-			prev = req;
+		prev = req;
 	}
 
+	nvme_submit_cmds(nvmeq, rqlist);
+
 	*rqlist = requeue_list;
 }
 
-- 
2.39.2


