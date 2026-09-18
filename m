Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B63C982D7
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lHWLxN1z9UCBkM9IJvLJg4YXBPTZaz9qxxb7LJ22R7c=; b=qixaL/q8cKvoBw9CuKYSAYkWIh
	owWYGD5HFbaLxt5YQllpeCR1b93i5SUHv/I8JF3zumHZDR83F9fyT/W46Ul42pAgGHY9sewZzbLvw
	2T5DWRHI+AsZORJ87/GFMPBXoxNJqDYwZEOZzgA9mMPUaJsQPLCe4cy75e9X+O8H+O28MfjL09HD4
	Gy31D02GzgqjbnfeWsDXq4jRy/ZyBRPWOo3WurW/jLxv7f6E1dCOI72sTGteIsWBXVbr9kSniYPpT
	IPFD5DVIns34jPiaOGRvDwWn3aB2811iIbkp+cUf8StnoRSL4Zw1R32lSUm8OaPRdorCuQdVScJlY
	aDz8N2qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d97-0000000FH8b-0L8s;
	Fri, 18 Sep 2026 18:17:13 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d92-0000000FH1Q-2Ups
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:10 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1082166a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755428; x=1790360228; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHWLxN1z9UCBkM9IJvLJg4YXBPTZaz9qxxb7LJ22R7c=;
        b=RvPv0w31qh4ci/Ux7hgWTdFp0fvSiDc+rzWb/25GFLt92GncZ0JPeBoWwzdibNzv5E
         ZkIuv4qpLh8HHqzbQ+7QTARJXYC/EgXZ+n1DA9RoC3Nx0i03jo1Y1zJoTmBR1gcTX0PJ
         jbSFhtxFbL2uAP67kwgq8ywYHn4iE6SJZFYLSqJbE77SWp1jWT7WjFEg9gzOURCk372Q
         WAHC9JEz9pp+qEsCS4NGJd4eXiPBcIcFeiAYL5sYE/1aqPNwuPvdfI155MFJutsW0JUa
         R0VZKKK9tuEfDNQwe8Yp7KjRbOHpjOtp/LbitMEfzPJcKVAWDgZi9FbiP05ealMM4TBy
         PRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755428; x=1790360228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lHWLxN1z9UCBkM9IJvLJg4YXBPTZaz9qxxb7LJ22R7c=;
        b=Fj7lSEu/8Gap90mEEyyTmathEnJpq5nhz5rur9L0oXfWNWfU7fxcJqGA0ieKODH6QR
         X5Wasje8tcB1OwnLyYwt1wwgkx/UO5fdLLrnF/Ty7rzE05FlZjpEv6nqqFeMQOAPP4pS
         LqT/PEpo/Aez6dkXPbPc79begxHMYC4BPiGYAnMhbsYy/YmjQK++BjQX23Er4kriQB3f
         1SUSyZidv4eKIW6TXKyIfRb0xb1SpIvH1ui0SxEHl6i30ceaEfMLs+oxroETpu3I/KWv
         NsZobuXGm+DGNVEKCqg754VNEJn7YFooKNVcA8ujVxWI9ICibUacBXzawl3Y/9CvF97W
         VB/g==
X-Forwarded-Encrypted: i=1; AKwUvBxso4ixHX9GkJ00bnx74bOoWMGZv5sWWJA3/1PYk3xBUJP7+Dnn+m+k4CXlSUDww98qGzvgU5koH9Vt@lists.infradead.org
X-Gm-Message-State: AFuF++nDiKn3yjL0FhmCFlOU4wA7agGCBmNrMpm6Gc89h7rdprR9g8aR
	njUVpHiMuGhPaxefdatmwQ+dfxC5Ir+4fdGYq/iED+a059DbQ5sDtd3UWm/Xyh5h+Wk=
X-Gm-Gg: AYBFou0676sGubvxhJeDGzMyFzOA2kyRgKAaWdWi1EhSnsVBtdV7FPrDcTrqh22ilLt
	lRS2M2S5LJIC1U7X9/whbwKrp1pHhPSKbK4FSFJ/9CkvbblpNT7/7lyRSKOBLuXiEd2GVA/4m+F
	1wJo/ubeFzhlKRJaj0hu0VVoLCXG97aYIKchAanW9r+xaUTbBHZKVuU28jjGsncKg/y7iCMs50l
	+Ccdt7NdZ4nDI7duV+8ZRUoapc3qOIO3j0PCDcM/xGpEkfkpg1lRbULtf66wpeoqfQ82OVXzTEf
	rldOgK+Mm0tn7Y+7axkiexJV1VeeVxq05njeYy9wCvZ9UcyACVwWjcD+lPGCidJzuNz6x1drjNb
	wcDC9oehNF0vOEm4WJoD/FSsH67350XNDe9EIuKOsT+EwznKvakliqY/OHyVbdnhNB3QfgrKz21
	Kv/3+hPlHTKPMCRizhLrPYOvBsQmQ25OY40/qoHjIfmgO1nvFZk6zrpRwty+fl3+aHBfCTPIE+4
	5QzMBfc+x4QoI4TOq6V+Q==
X-Received: by 2002:a17:90b:4c0b:b0:39e:6c68:c77f with SMTP id 98e67ed59e1d1-39e6c68ca6bmr654464a91.53.1789755427466;
        Fri, 18 Sep 2026 11:17:07 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:06 -0700 (PDT)
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
Subject: [PATCH 07/18] nvme: Introduce FENCING and FENCED controller states
Date: Fri, 18 Sep 2026 11:14:07 -0700
Message-ID: <20260918181614.3947933-8-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111708_638487_0AB67CA6 
X-CRM114-Status: GOOD (  19.65  )
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


