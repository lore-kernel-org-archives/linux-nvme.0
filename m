Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0029C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDF72068F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3O5IkZq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDF72068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DYVsO5IhFlUyjCjVozni1XlGlF8pTY/jufVOGWcieZE=; b=3O5IkZq6eptCdkK1q4EprPS7aK
	D4N18CmYLw3yizsq+ZPlTDywopYVZ6mMSAJYyC5ZQcL/mTx+DV3eUgw05mwBBM9W97qUItdlXrNrl
	UCPHI8UA+fya4cp9mKE2Ld0NVZAJBXJRtQKF0pnscwntHaAD0T0m8Hx/dWd8oJIE+S8r+LBOsZWRt
	pjnQ6ej00EZ+G56vCBKhA+n1cra1s4CL1Wv7ANocIeyYmprDFfH7dJR2L2VCBxO0YITvQh9ryyeRG
	7/IkQMOlgdbnW/fgYUU8li1UhqsOOGLwrQUHdgd6jStnosmdQEx/kjG1pBnxevgE8KoPxwQDg3KuX
	5kkRxq8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2URK-0004yx-6R; Mon, 03 Aug 2020 06:59:18 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2URF-0004wI-Fu
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:59:14 +0000
Received: by mail-wr1-f68.google.com with SMTP id b6so33093627wrs.11
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q/16xenBiDaxW9OZT4KyvJFOcnVNrmpKITIHzjZe93c=;
 b=PzhHmTi5FI01f8JLnWuo0/ZHnSz08FII0CJBTf32WCkokKpmA3QKpHwX80NqLwEBZi
 Dt3Ef0RaArUeGGpGJQ8SgWyWHH8awshSdl/YKlkBtykHxSUC5Z3kD43gLcwx8bcFZYgw
 4H+rffPDcYN/pNDe7USUzNtDrrLcDKAqdYro5f+hnyLaEsr0AxDoED5swgwyJBiQ9sr2
 oIR9UX6HuY7JM5oXkqtTYEw7NBgBLsEB9ZtOiSQIgRjmYaqQXcizNEmg2dOFjjMfW815
 dTspDi+vbu7KvDF2kyUqPWm8wERKmawbjfrUGcul7KNFW8O5AtEK+qqjlFTbsnhNWn4/
 T0zQ==
X-Gm-Message-State: AOAM530n+cuI0s+fsmPDJL74zxiKksYRr3tSnpygKvPeAnLnXEKJht5j
 PkinspAGjTgsoqjy+86d+s/iyBks
X-Google-Smtp-Source: ABdhPJxGGy4RzDhzniMiZbz3jDUmd/u++HVN57EN8ldaskhmAGitsJ59EMwKVXz6DssN0pKGSxs1zA==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr13061580wrr.234.1596437951322; 
 Sun, 02 Aug 2020 23:59:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id c15sm21574511wme.23.2020.08.02.23.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:59:10 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH 6/6] nvme-rdma: fix reset hang if controller died in the
 middle of a reset
Date: Sun,  2 Aug 2020 23:58:52 -0700
Message-Id: <20200803065852.69987-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803065852.69987-1-sagi@grimberg.me>
References: <20200803065852.69987-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_025913_760462_70DF2011 
X-CRM114-Status: GOOD (  16.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the controller becomes unresponsive in the middle of a reset, we
will hang because we are waiting for the freeze to complete, but that
cannot happen since we have commands that are inflight holding the
q_usage_counter, and we can't blindly fail requests that times out.

So give a timeout and if we cannot wait for queue freeze before
unfreezing, fail and have the error handling take care how to
proceed (either schedule a reconnect of remove the controller).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a58c6deaf691..96fa3185d123 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -975,7 +975,13 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	if (!new) {
 		nvme_start_queues(&ctrl->ctrl);
-		nvme_wait_freeze(&ctrl->ctrl);
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+			/* if we timed out waiting for freeze we are
+			 * likely stuck, fail just to be safe
+			 */
+			ret = -ENODEV;
+			goto out_wait_freeze_timed_out;
+		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
 			ctrl->ctrl.queue_count - 1);
 		nvme_unfreeze(&ctrl->ctrl);
@@ -983,6 +989,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	return 0;
 
+out_wait_freeze_timed_out:
+	nvme_stop_queues(&ctrl->ctrl);
+	nvme_rdma_stop_io_queues(ctrl);
 out_cleanup_connect_q:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
