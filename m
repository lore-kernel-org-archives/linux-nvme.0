Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF90AC32771
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 01:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gw9lyqQe5R+yw+IDPoV4+8Za+H046k5YKHvd8lw2rPY=; b=Mq8TEIwBfE5RMl9M1pzKbJZ0hg
	6GmP0OJRZC6jFx1d92jpZr9uLJ1A0g1mGKJr9IWInGKPqkRlutNxd//+escrqQCn+TG20h0VRntl9
	yHmDyDV2b4GhTz+IySO14RjXaHKfJqeIsGaK9IzFHPm75y4iExhVSm2QuiS1ze0f4E5hI4WtcPyrI
	ylhkBW1dgUZLzLuezZeC0uRgbnAITu1jAU/HQJtwBaeUhyrV//OuVUZBVmgAtuD4wwPruLq+T2YyO
	hsWxoYjAXUsQwKeHJKaRnUwOs22uBRhr8UDqr3xNtdvSsTGhwRy4K0w0ibKSx/aF5Cyd0GIV7VsCA
	nPIoRM+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oczeY-007h8F-7u; Tue, 27 Sep 2022 01:44:54 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocze9-007gzN-DD
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 01:44:30 +0000
Received: by mail-pf1-x436.google.com with SMTP id e68so8408060pfe.1
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Gw9lyqQe5R+yw+IDPoV4+8Za+H046k5YKHvd8lw2rPY=;
        b=N0ygZaFhLSOXkV8fuZqHVSFTMa/CFtuXkka+qByZM4y/jLM4N7XGTKIRmXsUIUHrON
         3xw/74DNSgBGpgoVZi5QLh/wZc1wsmK9f+44t89KaCF9k8cJDA1unvlZlkR+JNBM4Y32
         JVSVDHu/2ByQpfKZJPkcQK3WPaFQjwh4QKyWOnegEVT/KegEFa6ydXk+zn0Hh71SCb3E
         AkSNsCF45qlH3oMFjCWFG3IK+mMS2HkWwZgHtEbMES8GCHhmXPAayxJsUrxMP5o3pxN3
         Wd03JthVfnQhbLCxYibxseOrQ9fhcin8EAGRuttygUZlR4eg0jcZRycz+DOG5IA4VI/p
         oQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Gw9lyqQe5R+yw+IDPoV4+8Za+H046k5YKHvd8lw2rPY=;
        b=lJg4NUqN3SFy694XOoXXAy8ECL/KxgnqpaJ1l06gybrHptBE5ap2hpNpy32ZVsz36Z
         Uj3htTNZSBklcYw7M3PV1eCVRd2IVFuCsA6SL4M2//FJiPakvYlew7+YpsFOXrAQHHcO
         bdKRszCYaQEuaHX9AR83EMTIDXP+vVd/likzo5ouC15LWbwttfhWZVOLTI10q5yar1WH
         0mycWibb9TYcVftCkd/y5O88lNwCVuZM5+IxHGZXuV/mrCNugzlEqIHYKy0HBjg8MgTW
         7Mf+sfh/GlkgOAh5AyhjjKd1zvq2J26NBJHDU3EwuML79pisA5+xGbHVZhuHt7nYobwB
         /Nbw==
X-Gm-Message-State: ACrzQf07Agj5YGqmyzxblDuuzjqpRihxio73Dy1+SXQzJ3jU98vZ9sTx
	MFyLf3LTbn/NWGQZY7NgOTQl1w==
X-Google-Smtp-Source: AMsMyM76dVAl8IUXKH4912uerp2IA/RXyHJpj8bhTIn05ne6zZSO1S91VEgYu/TmSWlfMDVcAlB4Pw==
X-Received: by 2002:a63:2ac4:0:b0:41d:95d8:45b6 with SMTP id q187-20020a632ac4000000b0041d95d845b6mr23016941pgq.132.1664243067888;
        Mon, 26 Sep 2022 18:44:27 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o2-20020aa79782000000b00537d60286c9sm183062pfp.113.2022.09.26.18.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:44:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Stefan Roesch <shr@fb.com>
Subject: [PATCH 5/5] nvme: enable batched completions of passthrough IO
Date: Mon, 26 Sep 2022 19:44:20 -0600
Message-Id: <20220927014420.71141-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927014420.71141-1-axboe@kernel.dk>
References: <20220927014420.71141-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_184429_473345_6EE19C91 
X-CRM114-Status: GOOD (  12.79  )
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

Now that the normal passthrough end_io path doesn't need the request
anymore, we can kill the explicit blk_mq_free_request() and just pass
back RQ_END_IO_FREE instead. This enables the batched completion from
freeing batches of requests at the time.

This brings passthrough IO performance at least on par with bdev based
O_DIRECT with io_uring. With this and batche allocations, peak performance
goes from 110M IOPS to 122M IOPS. For IRQ based, passthrough is now also
about 10% faster than previously, going from ~61M to ~67M IOPS.

Co-developed-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9e356a6c96c2..d9633f426690 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -423,8 +423,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	else
 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
 
-	blk_mq_free_request(req);
-	return RQ_END_IO_NONE;
+	return RQ_END_IO_FREE;
 }
 
 static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
-- 
2.35.1


