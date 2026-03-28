Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB6C10F3DC2
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5zI5jX/tvcIMUGp5fm4rmIBCKjqdOpV/MaWj1qN2SKQ=; b=dHZsadBOdQImsoFr4vnQivlRzQ
	WjO/Z1qtLRtEopDt4SCel/SbQ99RVjBFNYWHN6g9qhSNblehh5KBYVCAf/lksi5Ow0bSqQMtKSgpR
	ps7qM9brTXDhbp9+SQp3NrfTOkCVF4kSy9P4iInq1lO2Q1pHRmdCSlAQuAd+JMgzmLA+hU5MYS3oG
	oI+Nm+Rldii7+mRrjNsDNKjckYpCM9jvjJWrayatbQK6o0t44iFx/qbpl9YhjhTBQUwYnZxcxZaN9
	V389LVjPuf2xiXg4Y19NgTeTxKCvFq47jLGhM1224oqvNJWOiALFgq700ZjbN1nlEP61i7gzLZUM7
	ZjGOq+og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6Hoh-00000008OFQ-40PY;
	Sat, 28 Mar 2026 00:46:19 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6Hoc-00000008O74-05wk
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:17 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2aae4816912so17427465ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658773; x=1775263573; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zI5jX/tvcIMUGp5fm4rmIBCKjqdOpV/MaWj1qN2SKQ=;
        b=AOPS/u2y1OaL3I6tftUD8J2S5+HrXrikpbqzFSpEOVqaRk+j8F6lezskIKGOHgWisX
         6XYy/81pbGvwPEGS6w/oAiDuez/r+JrGL7e5jiwZU3nztltAg73J0RXclNo6mb9ccPLw
         6kuyD5TEyJsxJFtDxHtHByGt4CtgNhlUHsAQcnetzjn0H5cvpRx/EebKWBSbsITOEk1j
         kkaxJiDwgUQjxhkmJVPo6iDdrcc1bqrpafMJO7+z2gPwDTlrVoQt9NK7VhCc/8mZybqM
         qZ7wjLptLKrDrY0s2NvzcaVcWwN4phSQxe5LtRSDRlLXdr+PqNr5ztMV7Jw5eh155Ls1
         A5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658773; x=1775263573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zI5jX/tvcIMUGp5fm4rmIBCKjqdOpV/MaWj1qN2SKQ=;
        b=jBabkzoqmqkNY/shDztt0y565eAd1eBj6H1Am7vY9kqZWkjCT+kxFL7XHd1XIVLz5y
         vIfxFVERwNd/vdzfHaqVcW5kaC94eaM+Ur/C9UvN1h2iRWizJC0u8UwwYLE+D9FollOp
         vZlxV2MUz79dWL0H6L2j4LAF97ihlhZo94dMZq1BntUy0h0fjK0YnSgyZJmWDNAKHtAh
         YUbT+GVBY8jpD7L6yKYlaGYGj/g4aN2eOSuE3GmKxvQ+vPGScD2eK7voXYSbejiJCF+j
         nEnt47/XbOo4M8cUfi4CwnuCfEVsfLHhbq/YN86mJtypWuauvT97TzILYMG89SujretB
         3cJA==
X-Forwarded-Encrypted: i=1; AJvYcCXxma/67AL+yPNE4ucVVrqVG51LJWaaOrwBBnBf4I/kvc4il7e0NeHbgmQVY+EqwIL6uvjO+pYMEZdH@lists.infradead.org
X-Gm-Message-State: AOJu0Yy14jMzjcO1CMHE7afrDDIvXl33Xne7Z9P5EQfhO9Guqu7b9+Gu
	A2NYuT6fhiZnx/pXMt2x76i+UcSDEQEeJzuFcIRLjwfC/epr8oU95crGNrROGJ/lVaU=
X-Gm-Gg: ATEYQzxzb21z4q9VqQp7jgtAcD4lroT3S7OYlhadtj+cXtygmDu2IkSczHynZakoj1z
	Eh2FFu//+sniqtbQxxli9NO46v8MvwURVt4ik+uOaPVcSnjm8uHoy2kHjgmUIL8BE3zovBMEfR0
	hTEtW0z/3dEOvR7T+kZ+k69sPnXZCQVef/a7SZKS0SOs1B3WERCHGMg5hZGYOz3o96R67nwwEOl
	bckw6o4ah6898FFkqA0JysydhCJ1MFJ9jjCC0cb1EuogwyD3d3B4a55Wq0GBP9kogcHwfga8bcx
	UeJ+ixYKUJq0GZtKeZXQdrFvSE0NnC0iNPN40gO3ltPa27JLJdZ0c2OUzco957cI5bndfsjxpBe
	7e786Vp4NsHjB2zQGnfOVVWJucvE3jRZqhPsjJcn0esO7JYDJ1tHsq2hiTFDNplzwLqggDKjsQc
	sIqtdc0rk=
X-Received: by 2002:a17:902:cf03:b0:2b0:c90f:44b2 with SMTP id d9443c01a7336-2b0cdc1027amr46114045ad.12.1774658772780;
        Fri, 27 Mar 2026 17:46:12 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:46:12 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
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
Subject: [PATCH v4 15/15] nvme-fc: Do not cancel requests in io taget before it is initialized
Date: Fri, 27 Mar 2026 17:43:46 -0700
Message-ID: <20260328004518.1729186-16-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174614_084631_C640BA01 
X-CRM114-Status: GOOD (  13.59  )
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
Signed-off-by: James Smart <jsmart833426@gmail.com>
---
 drivers/nvme/host/fc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index eea5a90d936b..e342d522145a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2554,7 +2554,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * io requests back to the block layer as part of normal completions
 	 * (but with error status).
 	 */
-	if (ctrl->ctrl.queue_count > 1) {
+	if (ctrl->ctrl.queue_count > 1 && ctrl->ctrl.tagset) {
 		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
@@ -2951,6 +2951,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
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


