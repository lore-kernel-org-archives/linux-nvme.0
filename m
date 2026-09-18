Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BEDC982D7
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pmH177YS3gZ19sjEKDEKKTFEFMiPIMvZkv9++g5knBc=; b=akFv8hl5xHIQ1tP9TOEMC8dyal
	f4tqKGXE3uQl9tPzwWDl5F2sFQvT9AqwUzHZf5je06uIsOa7V+m6ZfjAlHWFL22EwCymbwAeqIu6a
	/xJBIewdyHikuIpBDZpkSY2z82j2edwNsd10Q1xHptYeBOTuT/eQ5psdCV0D7hBPLb4aciBbho6oM
	BODsotGB5IXpRxtwNx/hRoJUPQ91LOXU59UX3Vhli092a+rhLfiIhSgUc5iEEkiEFnhPB3Oo0Bu9V
	7aVL/9fdaPLkGwGB7B2rOBoLuOdlsazaG65AkSG+QvP0guDfWQEy0Unp+o1vRBkV1MxSH2jgk32sl
	zko+80mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d9C-0000000FHJT-1OAl;
	Fri, 18 Sep 2026 18:17:18 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d97-0000000FH9b-2pi5
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:15 +0000
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1082258a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755433; x=1790360233; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmH177YS3gZ19sjEKDEKKTFEFMiPIMvZkv9++g5knBc=;
        b=Q6NY2VaKbOzpTYj0/YMIgFoH83rpKHrx9g6ereKAa3nP/vGMs17c+wTIPvEmbKOe4s
         0J6H9oEaCjOa6n3KFEgyOi+dULu5ncPAVBVa11+7vF3HLFlNx0uH3EzNPXwxsR0YmP0P
         GxxUYH3SQ7yL749LCp5Her3bM7GtLIZ3tbTNvnF5FXUTQiiYENChnnXwSZmwginGgovx
         gtZbA1CmrxbRFhIc7775xjdfuRprPUe1Tnd6OLxqy8+tzMonmjvlD5PV/+se1Wchne8A
         RfCzaS2cY4CNOvX3VfSKVm1zPA5q6m5jANxJHNxGzzBjJEtRYnA2DJwI2tt0TV34yIY8
         nmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755433; x=1790360233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pmH177YS3gZ19sjEKDEKKTFEFMiPIMvZkv9++g5knBc=;
        b=VeqU/UL/MI+CJASgeNjaDqJabPibaMHQU3X56/DJ/jdIMhJ67xPlkuAkV6lViO0gRT
         TDNijoYn6ugJt9btVZ/7fg0z588klZ5qy2XqXV/GBU9N5lOhUH5aX3Wr+eailIP+F352
         s6xH8b0ZFJYEC4i9UYHnHkyogkR+LfNT7zGqiQnbWcg8c/jy0DbuqLyVOTRN/2k4aX3E
         zcnJdbLDpdcgOnSux8k3/aiJBXGbsKVW3sce/sO3hLUgPRJ+16N3bENja4+ejLi5/LJm
         fqU33RpJRlzFeYAwJw8n/nzxcXGBvFiwjK8n2wgPZweN4ny9tEBoFcXzr577Zuzl85UY
         /VZw==
X-Forwarded-Encrypted: i=1; AKwUvBxWWwOWl4h2YtF6SJNitB7XSHToyUZa5sLr4eIfSqx6XgxZWrf25yRYa4MeoIdPGY6+2t8UkaWCZjxO@lists.infradead.org
X-Gm-Message-State: AFuF++nt6zaNT1znpJ3ggWICF9SkzQ91iDSoFoAuc3oyTnSWwJpXEzza
	C2RB0o70oIEw2FGaGBSOx3zQKwrrcuM7K2hg0W3aTP3rY95f16PWxhjIpWRu5A4XjMM=
X-Gm-Gg: AYBFou1YDjxs8+IVpe50nTzgwOGOGdMuOLglU0ddsk4nd/bjQ8aIVS9YwWm4q4eNbfI
	nKVcuW3DNf2xfszKuDrjl4yGZFtQvfdu3pDuap4y4QMQnQbYq8vu6qb3cVZIBf6gSrI09BZTC3+
	PqWl3AD+9VKy/GtaDsqVNhzthcuPe4/52jODvHIN1lzS7E4nQX3ZX4Ryy64XW5TG/ox/IpgHlXh
	b0R2IZprghKsS95RbD4vEPHxVVjwwUcblOZaFWXUGbwYfdTCZnUkhGX+C2cv96OclJN2eqIRZF7
	rfrM7bKmY6WD/yZpF4yAlOsgS/9KJePu6gLhcZhWIqICmwN9tvJ6f+Jcbh4XAUumgsy0Uy1m3Su
	cUdSSjwKlbJY5rdMMgo07D0BqTmiCKiTDKmUZAFhI6E0RLOEZ4nwzyPybsPm0h4xYuGz+KCbdfs
	2gxj5LOaUI5uA+Ht2gp6o9YdFutD6B+72jy67tUWew5LGLOKXcQ5F5UlurTF0ZfrAGV03Qj1X+n
	Gt3S/pZIjCMoermjCMRgOYd/ISVx//d
X-Received: by 2002:a17:90b:4c:b0:39e:6c68:c780 with SMTP id 98e67ed59e1d1-39e6c68ca53mr592406a91.54.1789755432638;
        Fri, 18 Sep 2026 11:17:12 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:12 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] nvme-fc: start error recovery instead of aborting timed out IOs
Date: Fri, 18 Sep 2026 11:14:12 -0700
Message-ID: <20260918181614.3947933-13-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111713_762975_BFA3DEE2 
X-CRM114-Status: GOOD (  23.44  )
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

Aborts issued from the timeout handler run outside the FCCTRL_TERMIO
window, so they are not counted in ctrl->iocnt and
nvme_fc_delete_association() does not wait for them. The association
can be torn down while the LLDD is still working on the abort.

Instead of aborting the timed out command, reset the controller like
the other fabrics transports do. All aborts now happen in
nvme_fc_delete_association(), where they are counted and waited for.

The new nvme_fc_start_ioerr_recovery() queues ioerr_work directly in
CONNECTING (abort the IOs so the connect attempt fails) and in
DELETING/DELETING_NOIO (tear down the association so the IOs the
delete path is draining get completed - the timeout handler no longer
aborts them, and a dead target would otherwise hang controller
deletion). In all other states it moves the controller to RESETTING
first. Connectivity loss, disconnect LS and IO errors now go through
the same entry point.

With nvme_fc_timeout() no longer aborts timedout IOs the reset code
in nvme_fc_reset_ctrl_work() needs to be updated to teardown the
association before stopping the controller. This is important because
nvme_stop_ctrl() waiting for ana_work or fw_act_work to be flushed can
get stuck forever.

Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 48454cb7a0fc..6181cb7ea8ce 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -227,6 +227,8 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
 static struct device *fc_udev_device;
 
 static void nvme_fc_complete_rq(struct request *rq);
+static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
+					 char *errmsg);
 
 /* *********************** FC-NVME Port Management ************************ */
 
@@ -788,7 +790,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		"Reconnect", ctrl->cnum);
 
 	set_bit(ASSOC_FAILED, &ctrl->flags);
-	nvme_reset_ctrl(&ctrl->ctrl);
+	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
 }
 
 /**
@@ -1569,7 +1571,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
 	 */
 
 	/* fail the association */
-	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
+	nvme_fc_start_ioerr_recovery(ctrl,
+				     "Disconnect Association LS received");
 
 	/* release the reference taken by nvme_fc_match_disconn_ls() */
 	nvme_fc_ctrl_put(ctrl);
@@ -1892,6 +1895,30 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 
+static void
+nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
+{
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
+	/*
+	 * In CONNECTING, ioerr_work aborts the outstanding ios so the
+	 * connect attempt sees the error. In DELETING/DELETING_NOIO it
+	 * tears down the association so IOs the core delete path is
+	 * draining get completed.
+	 */
+	if (state == NVME_CTRL_CONNECTING || state == NVME_CTRL_DELETING ||
+	    state == NVME_CTRL_DELETING_NOIO) {
+		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+		return;
+	}
+
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
+		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
+			 ctrl->cnum, errmsg);
+		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	}
+}
+
 static void
 nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 {
@@ -2049,9 +2076,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc &&
-	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
-		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	if (terminate_assoc)
+		nvme_fc_start_ioerr_recovery(ctrl, "io error");
 }
 
 static int
@@ -2548,24 +2574,14 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
 
-	/*
-	 * Attempt to abort the offending command. Command completion
-	 * will detect the aborted io and will fail the connection.
-	 */
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
 		"x%08x/x%08x\n",
 		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
 		nvme_fabrics_opcode_str(qnum, sqe),
 		sqe->common.cdw10, sqe->common.cdw11);
-	if (__nvme_fc_abort_op(ctrl, op))
-		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
 
-	/*
-	 * the io abort has been initiated. Have the reset timer
-	 * restarted and the abort completion will complete the io
-	 * shortly. Avoids a synchronous wait while the abort finishes.
-	 */
+	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -3348,10 +3364,12 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_keep_alive(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
 
-	/* will block will waiting for io to terminate */
+	/* will block while waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
-- 
2.55.0


