Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E770510F3DC4
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ddfbk2XDqKMxw3Haokga/Yx24j2zOVvDwNay846hLWQ=; b=y9yKvQREXN5QVPRzICZS51TcCK
	zWlWTnYffQU8PNjRxLrifYBXWFshKTMwU2ixTMlgtgeyRa09xCfHgPV+nLuruloi3EbfEZ6OqM1aD
	JzjcDyOSjTtz0nLxISOg7FgJ0YPRkdQiVSwKfQab3UPasqck1819W64fc8vJZ4OU7IhC5M6nnsE+Q
	QGmbOKeUGYS6M9XfIzAaX+bCYtJx14elKRWYLxI3xDfQNvQ2ACVHQ5K4aTPfjMKDYnyuBEW7zl3WY
	2RSIV40sBF1RfQTcOq/q6rU0Po0CyZnM6Y9qNLMU7OOJbvJCUrfSqsZIO4m4CAEuNE2pxNRdrRvbo
	t41itiQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoR-00000008NwB-1EEM;
	Sat, 28 Mar 2026 00:46:03 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoO-00000008NsC-0S83
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:01 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2adff872068so11297955ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658759; x=1775263559; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddfbk2XDqKMxw3Haokga/Yx24j2zOVvDwNay846hLWQ=;
        b=EsHG03elxoSrYNTy79Y13nG7qQQhDEVkwaeJRdXtQLTH3SOGO5cBq+nagJyvpY5Ef+
         Dpo1TyYbEPL4tNp69LocqKtkcQcnuq9/IXvDoxB7W3JSW0bQb8y0grbAa3/zaNoSPlRi
         AaFXfC8es3+Qg2F9fOlP5cg53QyYbFKnf5SJUtq+XLram74WObyEjpqC7X45dtXdtzT+
         hCtwcoOF7OA3tRlwW6mi6/Ek72OncFyH/K3ESoAZZi8T3w1U4qmoQg5unb2TxEt52ben
         GOvpH83HLa+QeV4VL/2nW9LAiix+Ki6WPDkLA8VaOeUssuK2ntt3Y0algV5iG07Lx3tp
         vr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658759; x=1775263559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ddfbk2XDqKMxw3Haokga/Yx24j2zOVvDwNay846hLWQ=;
        b=J7Ee/qaJHH0wcxBja76c2Z6+tXqYk0ULd1jOczpMgBPisAt1Vzd15kbKQ6cTwlM+Ri
         /VLCvhnI+WqWDqOjueRt8kMRA7SxgL2/LPAQUHs9FY2tDwxuyISVEY8wx/b62/zocm3s
         x9RDVqohUD85tKNE5G3Jf/zyNDDjI143gFHyAMRSM/nQP2i2r3jCXH1siXswFR4mN99r
         dfccar9Pwya4dqNQz3SJuQ2aKR1dlfqa0OH5dOSZMkMDAnPzCFGz90+Qs3NCL/4oEUQz
         pXqdym+UXDGeQr6hzSDUsUr+4IPrW+XzM/QtonNkfsgIY6ORk5ctvmFi9ltC0MWl+pZC
         gnMg==
X-Forwarded-Encrypted: i=1; AJvYcCUEXLZNJFSMfTQDXgkEl7w+YIpXUOVKVlikHPUWypBMOBohbFLBYUd0kZ+w6iV6hnTvSgSetplQSC+j@lists.infradead.org
X-Gm-Message-State: AOJu0YxD3UI1OFZfoY/z9SwAWfhvMsn5tlLv8iTq595JcHXHtebd6/Py
	6VHJyprLjjFPdnpDy2HGnS0gg0Wm1mbSFNjrBfNtJUSz77crUfL9Px1ir1SBoRkW7/U=
X-Gm-Gg: ATEYQzzhPak9i3ctLBlqn0YZQCEqGOjvtq2CT4Z/KIfy4zs5haKdlvvrDIwyW5SW3cA
	5/enB3yPl9qEpw5vefNgyJMwLw4gM6zD5cy1HBe/dizLo9wi7uh6Q2ecj53SB2iVRIlMXIYln5L
	sez++bRnfkt0CaptjXtkaLkgSekqXBS6S5jUIjBMaoaDZREIlgZFMrKcBEpeJR/nPDm0s3HXFGF
	fznkLqosnQGKUJ3NyCRtz0ot0dLpDDsYr5RjpKX6dPgl/RgpKhWqTrjAJyaqBQ5yFFOqmgT/0YB
	M9dn6oXCL0+63yrKWFFwghbS8FmGYL9WAVz3I1Wxi+W4D0KNE869TB6JPQrmkFmsIaQmVcnpdbV
	y4L0EqMndd9WPWJAkhsWdvdJ0RKT8XzQp8wNKHQKIBhHTY5ExjDAUtnj7JFPenzzr1I5RkWnaaw
	WyTZ0PJ8Y=
X-Received: by 2002:a17:902:e809:b0:2b0:5cb4:d89d with SMTP id d9443c01a7336-2b0cdcb05c7mr47028665ad.29.1774658759359;
        Fri, 27 Mar 2026 17:45:59 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:45:58 -0700 (PDT)
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
Subject: [PATCH v4 07/15] nvme: Introduce FENCING and FENCED controller states
Date: Fri, 27 Mar 2026 17:43:38 -0700
Message-ID: <20260328004518.1729186-8-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174600_174695_FE6A1863 
X-CRM114-Status: GOOD (  15.62  )
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

FENCING is a new controller state that a LIVE controller enters when an
error is encountered. While in FENCING state, inflight IOs that timeout
are not canceled because they should be held until either CCR succeeds
or time-based recovery completes. While the queues remain alive, requests
are not allowed to be sent in this state, and the controller cannot be
reset or deleted. This is intentional because resetting or deleting the
controller results in canceling inflight IOs.

FENCED is a short-term state the controller enters before it is reset.
It exists only to prevent manual resets from happening while controller
is in FENCING state.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c  | 27 +++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h  |  4 ++++
 drivers/nvme/host/sysfs.c |  2 ++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7a07c23aefdb..824a1193bec8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -574,10 +574,29 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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
 			fallthrough;
 		default:
@@ -760,6 +779,8 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 
 	if (state != NVME_CTRL_DELETING_NOIO &&
 	    state != NVME_CTRL_DELETING &&
+	    state != NVME_CTRL_FENCING &&
+	    state != NVME_CTRL_FENCED &&
 	    state != NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
@@ -802,10 +823,12 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
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
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 234f3872a212..45e58434cf30 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -305,6 +305,8 @@ static inline u16 nvme_req_qid(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
+	NVME_CTRL_FENCING,
+	NVME_CTRL_FENCED,
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
 	NVME_CTRL_DELETING,
@@ -831,6 +833,8 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
+	case NVME_CTRL_FENCING:
+	case NVME_CTRL_FENCED:
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f182a26b38b0..6ae29fe431dc 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -443,6 +443,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	static const char *const state_name[] = {
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_FENCING]	= "fencing",
+		[NVME_CTRL_FENCED]	= "fenced",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_CONNECTING]	= "connecting",
 		[NVME_CTRL_DELETING]	= "deleting",
-- 
2.52.0


