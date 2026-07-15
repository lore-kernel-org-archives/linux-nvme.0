Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB101C44508
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 00:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JPDFGbUcKjq0fLUsPvbs/BQdu6/FNunI8oqbYcrNDjI=; b=tSAu8aI5WJDatGHgIZYP2u5E9r
	T13WGpF8j6zbnLBvNRJmM0k7kROT0U0vWjiAdgIt5pEvFqXBH+SAxY1QCTdyZydesyOVIeQT/Mbco
	2bjtkcLwKGXctUAZvXpJJV+ZdAOfKVPd4JvsusetVH+ydGT9NcSheheq1D1VutGIdcxo3gqKUqavh
	hRuAkzmgtvz41AIrszrcNd8t1FGnnqIRJ04XaWq8/U7OoC7Ki33LgcYe6XcryeLqb91gc3zgy5h8P
	Sb2Vleg52uYYwgmC/bMITNRrvqt9ilziwJV+8ukO5rXWtm7nQSmijsj+egRtR2SX9oLRU/KKQ4qlD
	7bxbCg5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjnqE-0000000DWFV-3ZnZ;
	Wed, 15 Jul 2026 00:51:14 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjnqC-0000000DWEi-2ctQ
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 00:51:13 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5bdb162ee53so889207e0c.2
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jul 2026 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784076671; x=1784681471; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JPDFGbUcKjq0fLUsPvbs/BQdu6/FNunI8oqbYcrNDjI=;
        b=ankr6lHdvs2R37yMvJM9EVZcXzhbFhJnXylDYkQdmE+56pkVjUC+D9aZZuPMTGzQXC
         X0BvhrQbPc1u/JpJU9PV1WnTYCMlaxHybEpGWQNNqnO9YHMfpeT/viwB8eyxRXpYmPVx
         zmC5/OTcqrwcRrfWT/+oVHCxAdbHAgvdHqJCr8xH0uXwf5oYDd522sn7h4oYIP/HCuLx
         ochR1wvbxEqEYpQVTM2NOjZxSOPb0CiZUTPYeLXDNtYEWqJCWGio6tlNGKGQPiXHi5cB
         fKgEdQ/RXdBgk9teEtXDXQjMRxl7R1MIHdXHn4ENZfbBi6jrdPjyRy/+cwHTd3ZGpEPF
         HBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784076671; x=1784681471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPDFGbUcKjq0fLUsPvbs/BQdu6/FNunI8oqbYcrNDjI=;
        b=de75n4tIKMdngwK8Agqg8/DEs2qYidFWhc2LTCunm0C+To+Hb8ZRlaRYB2GqFt0i7M
         Lr15jlPPXagxpnN6NmeAEkvTsiiefXyPM6UkHw/oWOqUtagM4o+h84xt2Y3ogFxOHzrx
         ga22vAaOHzxnCHJFGLsBS64eG/erVCfvIoUAw/bE6GDkU4CMpGpK6WfkL5ZHNJ48dsFo
         0EkbQXDWGnIKd+/OTI2/maLiSJkaQRlnIs/zxld0iKHGDUHBBC0srSmpg2migSgnGmyF
         JBDXeFeeV/cojRmVYrgH8Tc//pyALR2MK5Jg069BkDt/dptbz68zsAnHjaO0FVJmWCWC
         QQ+g==
X-Gm-Message-State: AOJu0YxjqITKYVjWS2WXpw1vlImiHfIPlD3xr9e2j+sotP49clG8hu2I
	jZAlnWz/oeHzi0ULr0whGk0IxmLKoXk9H56dGneb2US+ju/6EJsxF8MR
X-Gm-Gg: AfdE7cmc92mx605mI6iuf3p+KGAvwIyV8G/mvqJf/6uGGhKXPBEw/loQpLaWuvqW2gr
	bxLiuAB8Gxq/ECj2VeRhnzJDBQaBSRO3rQcXsgqVM224GVRl9Xn5qQDbjxvYXS/GcVyf9bYSWjC
	UogB7Ensc7eETiiTh15TpoGoZ+aZdSZAbnpihs6UCaMiAKFG7AXeNR842lEaH6mhnyzcGL+DhzZ
	l+aT3ZLEehXqKqpXyqbhgKk+AkrdxGby246PEWcr0i3XEllM1SIqjekbuf+H4rw4SJmBVYKsyFB
	yehtl9zU5+294Dwv31iAPLefQHXkfilP9m/wVJoc2sClOYvIz5c0iZdWkP/Qlh/GwdZfVqlo6dq
	6T0WC6AXny6GytBzrv22erYarbORC6Iq5LxL5rdfX352xSQqE27kbB+BEi1hKVOZHGer/wlnhA0
	iX36jjQ2gCskx2NxXgU5JtMteasVt3/Aw=
X-Received: by 2002:a05:6122:787:b0:5a5:3eea:4513 with SMTP id 71dfb90a1353d-5bfbf34947bmr8882689e0c.12.1784076671006;
        Tue, 14 Jul 2026 17:51:11 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bfd0b319cesm6149473e0c.11.2026.07.14.17.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:51:09 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH v2] nvme: reject completions for requests that are not in flight
Date: Tue, 14 Jul 2026 20:51:05 -0400
Message-ID: <20260715005105.1115958-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_175112_674210_47CDF1BE 
X-CRM114-Status: GOOD (  14.96  )
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

nvme_find_rq() resolves a device-supplied command id to a request with
blk_mq_tag_to_rq(), which returns whatever request last used that tag -
possibly one that is no longer in flight (freed, or never dispatched and
thus with a NULL rq->mq_hctx).  Commit e7006de6c238 ("nvme: code
command_id with a genctr for use-after-free validation") guards against
this, but its generation counter is only 4 bits wide and can be matched
by a malfunctioning device replaying command ids.  The driver then
completes a request that is not outstanding, dereferencing a NULL
rq->mq_hctx or double-completing a command:

  Oops: general protection fault ... KASAN: null-ptr-deref
  RIP: blk_mq_complete_request_remote+0xe5/0xa80 block/blk-mq.c:1319
   nvme_handle_cqe drivers/nvme/host/pci.c:1418 [inline]
   nvme_poll_cq drivers/nvme/host/pci.c:1449
   nvme_irq drivers/nvme/host/pci.c:1463

Require the request to be in flight before completing it.  The check uses
the request state, so it also covers controllers with
NVME_QUIRK_SKIP_CID_GEN.

Found by FuzzNvme.

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
Changes since v1:
- Drop the "malicious device" framing; describe the trigger as a
  malfunctioning controller.  Commit message only; the code is unchanged.

v1: https://lore.kernel.org/linux-nvme/20260522153034.2168862-1-coshi036@gmail.com/

 drivers/nvme/host/nvme.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c..3a525c1dc818 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -615,6 +615,17 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
 			tag);
 		return NULL;
 	}
+	/*
+	 * blk_mq_tag_to_rq() returns whatever request last used this tag, which
+	 * may no longer be in flight if the device reports a bogus command id.
+	 * Completing it would deref a NULL rq->mq_hctx or double-complete a
+	 * command; the 4-bit genctr below only narrows the window.
+	 */
+	if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
+		dev_err(nvme_req(rq)->ctrl->device,
+			"completion for request %#x not in flight\n", tag);
+		return NULL;
+	}
 	if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) != genctr)) {
 		dev_err(nvme_req(rq)->ctrl->device,
 			"request %#x genctr mismatch (got %#x expected %#x)\n",
--
2.43.0

