Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA26C982EB
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lHWLxN1z9UCBkM9IJvLJg4YXBPTZaz9qxxb7LJ22R7c=; b=CcX4DNk0MwlYnyQsAnM04qqVTB
	eJjDs33if6LvOE+vGqjsDupQJFpGDO8gukf2BJIcIc/wL0JqQygpGloy3XRHFnIf2tk58dQVXEGGp
	bN8ve/SWqyDng6+EAXlPpLDi81uCYzGUiFbV+8+4UXA/OSqjVOr+RtM9TmKmOGLBpKkOBb0vRnUNI
	vUBlPoic1eE9lhjNmV7qrIr4z9Rw0/0aoHQLrXKvymV5hLZiSijGFlrpsg9MC4U43JX4xoJZfc/R6
	DX5FhVQzvA3Cb1ZnZuE5Od59Dsf2or2c46T0DoeHEYm2SjbTCRAZWtsVr574N9rSo3DH3YaFxbazk
	TzZMPp5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ3-00000000DqB-2VjI;
	Sun, 20 Sep 2026 18:30:29 +0000
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ0-00000000Dn0-4C62
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:28 +0000
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-868a9c48f9eso2845356b3a.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929026; x=1790533826; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHWLxN1z9UCBkM9IJvLJg4YXBPTZaz9qxxb7LJ22R7c=;
        b=NAS8bNOdKEMmHeZzmkEF2YghZwCjaeLEoQkRZh9619T44xOaNWtHxR5UIIXWZjrDzs
         3aoQh7pSU4XnjZZHwo2gk08xlsoVkB5tT3I8y2onO/fbY1Bfdp0L57j4CqG4wC4Fk/3r
         crUBbX++LCIewvVC5p/Kluss+RhOEnzLhMN30ykMJ39nxxdfckIzb6Ha9wdx2ZveVheT
         imicVmh9XDGHHN5OMM73heep9sg9H70JXkK/M/5HTcgRrzP8c3nJ4x7xJDqEkuxoED+/
         nItMlDavvrDhHo6OqAqJVWlKnIsc6hsnqX9qPOU04vVklhpW2gwLNxlDw7c5XmrJ42ii
         9OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929026; x=1790533826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lHWLxN1z9UCBkM9IJvLJg4YXBPTZaz9qxxb7LJ22R7c=;
        b=Y3H+Z8ecRc64twgozh8S893UHPPEBECcAu5CMRClpbf5YLgKW91nJvblWxgiqx9Xk5
         G4NJZLLxjsAwk+XqjO02nU9dakkHASpVLzYuV7Wmlbk7vNbjYOXMiI6RRJutUzvEju6A
         Is+cczVqB0HF3IUb73WIlFJM51eu7Q35LkLil3mrkJdJ+BW/U5POF4joDlaEwjSSKl2N
         GN4qAHnwYs4cnwHd/YR4MZP6kJioutzI7fYO/T/Z962+ImgABoXdKSGzTfD93ZqLusSc
         aToElVIW4HxKRixGiNfHrDsV/+ITMxqc01+TNx6Qp52J9OOUbfdUsCQMsISBqH1sQ+89
         qLQA==
X-Forwarded-Encrypted: i=1; AKwUvBzI59Ii7FHn3RuYEyiiknLEPg2/ibtjdkizSyRoRYHjXxETgH4o0ikYsm6FHJs9JiR0/f0f9r4CSils@lists.infradead.org
X-Gm-Message-State: AFuF++lrzvD1HuOype8YDydX2NX1QX0OMQspv22n0gQD04dsB4cNqSTc
	GuT+K4mzSS2zlftS6/3itEizDlaSjLZcTDKvDR1hFIgkW5J3OLhmTyK3iwjVrHvxR10=
X-Gm-Gg: AYBFou0fYhMqXG8WBEv36mrf4pl1WEJa8efBUXPM0tgExcs9NDss7MD0TXAgnwmV2AD
	jpLdWN1O4Jxn1g4/VuyU5B98i0pYq8fwSsFckW49FznEnUpEanpk3GEqe/bPX2l8pote8LoYvuc
	gRRw+wDGq/rbVCP02hIoyuRWSqYXNf8l8ppE2/brMoQaCPYu5tKQaOcN7ViOfv2AsXJ2K9BlVbp
	XXhZhsa7G2aHEgID36WSm39DtCnZY0hcnD9yKRbPFMpmuH1/nwtRE3YS1tz17NZjgEXMK2QTk3x
	dX3GCbXPdaARohFaHl5SQ1rxbpXwMqHKJsd94YMk+KJWySPHWTJ+qDQordpeb4/2k2sSYJXr2ea
	MGH51EMz2IphcvDZFM02RukDVbjkCNj6U758gIQctjyepr9c/i8dkqzWqVqtmOuA8uv5lg311oo
	GVWotQYrYQQA9ZJLqQqLZdKsZ1NUysyZXuf2SwH07U6EpMfuDRxdvbXUt2
X-Received: by 2002:a05:6a21:7795:b0:3dd:a00a:1713 with SMTP id adf61e73a8af0-3dda00a3046mr6833488637.46.1789929025982;
        Sun, 20 Sep 2026 11:30:25 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:25 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v6 07/18] nvme: Introduce FENCING and FENCED controller states
Date: Sun, 20 Sep 2026 11:28:05 -0700
Message-ID: <20260920182936.2317916-8-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113027_041859_40F8BE2D 
X-CRM114-Status: GOOD (  19.93  )
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

Introduce two new controller states, FENCING and FENCED, and the state
machine transitions needed to support them. Transports will move a LIVE
controller into these states when an error is encountered; this patch
only adds the states themselves.

FENCING is entered from LIVE. While in FENCING the queues remain alive
but new requests are not allowed to be sent, and the controller can be
neither reset nor deleted (there is no transition from FENCING to
RESETTING, DELETING or DELETING_NOIO). This is intentional because
resetting or deleting the controller cancels inflight IOs, which should
be held until either CCR succeeds or time-based recovery completes.

FENCED is a short-lived state entered from FENCING before a reset. It is
the only state from which RESETTING is reachable, so it exists to
prevent a manual reset from taking effect while the controller is still
in FENCING.

Update nvme_available_path() to treat a controller in FENCING/FENCED
as an available path, both states are non-terminal states, and finally
add the state names to be exposed via the sysfs state attribute.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c      | 27 +++++++++++++++++++++++++--
 drivers/nvme/host/multipath.c |  2 ++
 drivers/nvme/host/nvme.h      |  4 ++++
 drivers/nvme/host/sysfs.c     |  2 ++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae7c04b77a3e..e4e18fb72159 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -596,10 +596,29 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
+	case NVME_CTRL_FENCING:
+		switch (old_state) {
+		case NVME_CTRL_LIVE:
+			changed = true;
+			fallthrough;
+		default:
+			break;
+		}
+		break;
+	case NVME_CTRL_FENCED:
+		switch (old_state) {
+		case NVME_CTRL_FENCING:
+			changed = true;
+			fallthrough;
+		default:
+			break;
+		}
+		break;
 	case NVME_CTRL_RESETTING:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_FENCED:
 			changed = true;
 			atomic_long_inc(&ctrl->nr_reset);
 			fallthrough;
@@ -786,6 +805,8 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 
 	if (state != NVME_CTRL_DELETING_NOIO &&
 	    state != NVME_CTRL_DELETING &&
+	    state != NVME_CTRL_FENCING &&
+	    state != NVME_CTRL_FENCED &&
 	    state != NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
@@ -828,10 +849,12 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_receive))
 				return true;
 			break;
-		default:
-			break;
+		case NVME_CTRL_FENCING:
+		case NVME_CTRL_FENCED:
 		case NVME_CTRL_DEAD:
 			return false;
+		default:
+			break;
 		}
 	}
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..023d09f3c8ba 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -512,6 +512,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
+		case NVME_CTRL_FENCING:
+		case NVME_CTRL_FENCED:
 			return true;
 		default:
 			break;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cb9d7f45188f..84ea3f2728bd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -312,6 +312,8 @@ static inline u16 nvme_req_qid(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
+	NVME_CTRL_FENCING,
+	NVME_CTRL_FENCED,
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
 	NVME_CTRL_DELETING,
@@ -865,6 +867,8 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
+	case NVME_CTRL_FENCING:
+	case NVME_CTRL_FENCED:
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index b60f5b66a1d1..3a12b07149d2 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -542,6 +542,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	static const char *const state_name[] = {
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_FENCING]	= "fencing",
+		[NVME_CTRL_FENCED]	= "fenced",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_CONNECTING]	= "connecting",
 		[NVME_CTRL_DELETING]	= "deleting",
-- 
2.55.0


