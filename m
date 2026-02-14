Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A5EEF99FD
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ekotz5RVjYf6MGMkCCi7bJt1PcW5y5lDCPYdfqHxyyw=; b=BOjDFfEqxtJ1V7TsxEbn6qr+qo
	RrEiBUe93Ots8hjFl0z38S+XiDY9/KMaoOuGf7q8udYClQPhFXeHwMj8shDrsb1Znflqlcwk0lLnG
	Vr6OLCbhAwrftwyfBJVnwPAGqyFW3XUZ7ewvs0c/QwmiJxnwJyYMEmMAiv35/c335t0fhu/jtjjYy
	ZuopMSpn4ogcRLLDdeVqtfTFhN0YURl1nDyNxZ+K20jjDTbp89hYA0Jf/aQghz1FS0fTSgrMVUv2q
	MpFt6k5k3sytVFyxVevkdL8J0sqOcdXOfPjfGVDVfTivVwqk5h08tCydpKy6Q3KHM3rYCZuaQwqxi
	0J749E/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gs-00000004FOD-3T3w;
	Sat, 14 Feb 2026 04:28:42 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gk-00000004F83-1WMd
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:35 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-127380532eeso4212942c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043314; x=1771648114; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekotz5RVjYf6MGMkCCi7bJt1PcW5y5lDCPYdfqHxyyw=;
        b=JtQqI5rz478ilZJI8/7zzTGUi03ApFA9UrWBPlRRVy4yV4W2/FUpir3Qa2SvLx+7ty
         3RKAWp3qNo+9jRuFgv3PiEdK4MYtaFkLc4K7GylgMqr8onYFDkUGSDx5JNZp4dMiTgHu
         iKzeZ2eWLRKc8TGlzWM84k57GIe936XNr4LOWNvDwFwvmZ9i3bPamRltssz7+3LSzDmA
         zdzufsDYTi2zJkVc17jw3ZTpqtlOgb71hpm6PbevidAZJgByTkoZvYErvxeGBMKJCf/K
         NoqgrL6K+4Y62fhZ+J/gHJq7hZTW+f1Hbqj5VzltYov543ysKlb0JmBi+zvYk8CY0he1
         v7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043314; x=1771648114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekotz5RVjYf6MGMkCCi7bJt1PcW5y5lDCPYdfqHxyyw=;
        b=ctRdDHpvIdCHWSnn7SvTg9+O8WNR4e/No4NRaoPBxGzVh99ccaqu37tA89W4DFvJDI
         +AKuEor2hoTrnZPyW6YzENXtWIDqbb3PJWe3whuUTpaehrpmXell5ERXNEPzvBT8UkxJ
         N6HnBMTKdBLaSylWjglXXGPeUJnbAV9HjnZXFqbWkOU9799PyuSuh+BqNBHIpSRMondp
         ptY9V+M4Hh1sfb4nCBXmBmWyzAnfcLf4hQHupVDt7gInGtQzvdoKqF7iChnviGJgmxC2
         VQ9kiFilAuNJDLg+WO5pvvOsygk/mdSG3rUlAJeFWW4PFzn+J8dYd1okcYMbvpJEntfN
         NZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTq3v6Nx2bbKwKFBSaD3oxzZJdzXnl3KZ4yGH/1zdihypri+h6CCZIEHTGrhMa9Lt7y1c1mMDcziRG@lists.infradead.org
X-Gm-Message-State: AOJu0Yyq6/WyBAHpbJk+FLzsmjHV1We0vGD6gRYe0WRxtufrA0dVjNVm
	DhMaRfhq24BvSqclvO0RIC8Rkii6qufSVbBemBUCR+WZkoAeyrQkW+IluWKYev38TV8=
X-Gm-Gg: AZuq6aKR12t02/Fad60vsxEmpIri+oa0UTgKb8fOgumMAwdslc7bqpGvguwc2JQBfmH
	1/X+kP8/qKbJpoPVcjo+f2YuC+JHTrckQ0qgYzHWz6lTIhcLDhcOOSIYXcpS8gpkQTWlGhKAn/u
	tOUkVvYUYnMASH2yHpv2R171ZgovRjozuB+8aP/ElVA8L/wV73p1dvjDm3nElF0vWKN9zjv1gfn
	zKdQW4E+So7Q0NaPP2kbn81waL8y6pyOYgn7+NRZphAxdM60x+ALAWBnYu4hPhLKf+DbfWQW5Aa
	/rdiu4vhX60J1ClAan0OZSyLRL/k2AQ98BCvTUZ+aLZr80cIIfkqD9vWISRJb6L1lSiTZ6GWerC
	2u9NEenwzHTgXwrLv64MMYFMfIRoXwIu5BBEcKCDunRLxuEwBgw5qt+mnRyddZOjzHhygdU8Lfu
	ttjIWJMU5r2hvqgl/hCEhWV0MMCwVlhiASB5Do3fcH7VD1Og==
X-Received: by 2002:a05:7022:e1e:b0:11b:9386:7ed3 with SMTP id a92af1059eb24-1273aed4989mr2119761c88.48.1771043313356;
        Fri, 13 Feb 2026 20:28:33 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:33 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 15/21] nvme-fc: Do not cancel requests in io taget before it is initialized
Date: Fri, 13 Feb 2026 20:25:16 -0800
Message-ID: <20260214042753.4073668-16-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202834_425634_3BB1CD8D 
X-CRM114-Status: GOOD (  13.58  )
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

A new nvme-fc controller in CONNECTING state sees admin request timeout
schedules ctrl->ioerr_work to abort inflight requests. This ends up
calling __nvme_fc_abort_outstanding_ios() which aborts requests in both
admin and io tagsets. In case fc_ctrl->tag_set was not initialized we
see the warning below. This is because ctrl.queue_count is initialized
early in nvme_fc_alloc_ctrl().

nvme nvme0: NVME-FC{0}: starting error recovery Connectivity Loss
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
lpfc 0000:ab:00.0: queue 0 connect admin queue failed (-6).
you didn't initialize this object before use?
turning off the locking correctness validator.
Workqueue: nvme-reset-wq nvme_fc_ctrl_ioerr_work [nvme_fc]
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x80
 register_lock_class+0x567/0x580
 __lock_acquire+0x330/0xb90
 lock_acquire.part.0+0xad/0x210
 blk_mq_tagset_busy_iter+0xf9/0xc00
 __nvme_fc_abort_outstanding_ios+0x23f/0x320 [nvme_fc]
 nvme_fc_ctrl_ioerr_work+0x172/0x210 [nvme_fc]
 process_one_work+0x82c/0x1450
 worker_thread+0x5ee/0xfd0
 kthread+0x3a0/0x750
 ret_from_fork+0x439/0x670
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Update the check in __nvme_fc_abort_outstanding_ios() confirm that io
tagset was created before iterating over busy requests. Also make sure
to cancel ctrl->ioerr_work before removing io tagset.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e605dd3f4a40..eac3a7ccaa5c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2557,7 +2557,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * io requests back to the block layer as part of normal completions
 	 * (but with error status).
 	 */
-	if (ctrl->ctrl.queue_count > 1) {
+	if (ctrl->ctrl.queue_count > 1 && ctrl->ctrl.tagset) {
 		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
@@ -2954,6 +2954,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 out_delete_hw_queues:
 	nvme_fc_delete_hw_io_queues(ctrl);
 out_cleanup_tagset:
+	/*
+	 * In CONNECTING state ctrl->ioerr_work will abort both admin
+	 * and io tagsets. Cancel it first before removing io tagset.
+	 */
+	cancel_work_sync(&ctrl->ioerr_work);
 	nvme_remove_io_tag_set(&ctrl->ctrl);
 	nvme_fc_free_io_queues(ctrl);
 
-- 
2.52.0


