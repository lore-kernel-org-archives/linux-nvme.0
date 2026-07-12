Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097D8C44501
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6DHY+73TsJixrpWZb9EMzOuJGBFm5beeq+D2G4BmDA=; b=BRKcKGUYWdLXOOLyJIKtPe9dc2
	0nPtdFR2awZdtV2u9n2udf4Fhi1rkAr9DKC7ftVDgBC8920Dsxo/fiKTLiLK5tw2TaEHHvyF2IVyE
	hnFsh+SwyHxXMTgSgzk+ytgXcH+CfBzI5cViaa9n8hoIQuwfA2pUxJBMG8YxiNLmnzwVwzc9qFrXs
	bPsICoDBqzFnLHoI+hAwKRYZfjFSRxnrGPs1gy1qflaF45Fie+8kM9Bg6ovmWhYod/EB/OBIxQeaV
	MI0Bi+7vxBdgzoCBdbcUJC9uK+dBX07p40n9iAPDMhnKGKfANHqYUmRKYVD+TTOZ5siXrzYMQ9iQq
	A9Ocn43w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsq-000000071Ur-2c6E;
	Sun, 12 Jul 2026 02:25:32 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijso-000000071RK-09ZP
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:31 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-38175907a56so2470582a91.0
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823129; x=1784427929; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6DHY+73TsJixrpWZb9EMzOuJGBFm5beeq+D2G4BmDA=;
        b=Vd9GBkS7iTd51vUbFOt1eCWpnl5s4xtbi0Byefh1Jc+qyZ273L/R3eJaCUR6yCi68B
         /T3o1TYAqZfyR2pjdqgFeltvKbrq4ytcDKE03nU3Ecb+S7BLWzJTWFtxdjgyqcuMzfoK
         J88LpTs0Om51SQi8Q5bjiIlsC4XRJE0P+N0ixg46Jgu4+4f4/Sb5LHuao1Rjis93W0em
         Ccn6sOd0BFcAbQKcWDlHd/+Huztpy43iXMybU6pPyv9BLLXPAfRI8V8DlNCj0oUP5yVy
         F5AViicSnOkbdzAvTUDdWphyJxsPa977xU5BCmXqPX+beDhdUm3aGa5ORm1Q31okR5kZ
         c0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823129; x=1784427929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z6DHY+73TsJixrpWZb9EMzOuJGBFm5beeq+D2G4BmDA=;
        b=hXQT2w7g6+1Zc8avJrMAnDLHsFpTyrtnwU0m8JKR7WWg+XFfsLiiNf534A7yB8CLUv
         9MplTnGECtGgXzd4QCXj25QiHub7EDQAnuuDLjxsWZcZALcI5/jPU4kwFHS8hjnZ5sN1
         YXZIB9UaFQZZHjuYPxoa2mJIhatSwFakY15YeVzlmkpqk/buwOY6pIh1eLeKK6JHuK2u
         kDaRtvLKYMcS1+77V0zmCecoShuqvVJ3NMPCA9Jc/W/CCP8eVBaTRSyA8C4Wl14WVTih
         tS3R/lNNmiWk9K4YL8nxm0ULrHkOx7uHZi+UiuxEKqZICcqGuSH1b1I6wA47wrtNBniJ
         at1g==
X-Forwarded-Encrypted: i=1; AHgh+RoMFxjFwBwobSq+mLGjP8RA5aYe8oohIP1MsTs4Wga/Xkhl+3jBjCVUq6vKWJ+jFLfgCJAfDC96/3O9@lists.infradead.org
X-Gm-Message-State: AOJu0YyXYH8zMVAX9wcoqPiWEVY5jVjaqm4Lp3lyHSrV+wL2yQMEFUZ6
	cWl7MOYgWhqJ0kjZujcB3xKnDuY5sXFyKOm7Or9i5iZnw4ZnxJRtCQUnFhdBRjT8qEM=
X-Gm-Gg: AfdE7cm5MfnvE39YB8CDFlh5HisnuyNQ8NLS1gedmYvcGiQI09iPZ3hxd6J7G/7JicP
	PPD8UTafI3Ug16nJLwpUja5NElbX24z2HLRJBpYp5Oth90nepOXFYw55hTubNaiUNeIyeCNdL8F
	zKb6wwL9z7mFKWhV4G0aUjNdK99GiSsuSWHui1rSxq7uGvvXjXPPZxGd1d4OA2Rmi04kkCXd6xc
	j3vfy/s4S/1QSN47IO0Gc/kbhRYbzoOA9wkYcRVBVX84yb54xqDlzJ0mhlyEj++RoWLamCylG+m
	SFdQnPjOy/QQJKgfvAwRm7OJghbuDBXlRxhNrOZAeCLUPT8ubsuMTC1tR2lk5lzCSiicBONRQ+d
	XqxJwuBJ6Cj1+MeGHB6U0rmZ8QslZA5pAJ0+hUZlQqqciBXYwJoTaziO/EKRFivwNuz9E/3H+Hc
	qsmcip
X-Received: by 2002:a17:90b:1d09:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-38d11279610mr10117714a91.0.1783823128742;
        Sat, 11 Jul 2026 19:25:28 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:28 -0700 (PDT)
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
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 07/16] nvme: Introduce FENCING and FENCED controller states
Date: Sat, 11 Jul 2026 19:23:28 -0700
Message-ID: <20260712022437.3743117-8-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192530_345291_4496D7D8 
X-CRM114-Status: GOOD (  18.03  )
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

Both states are treated as non-terminal by nvme_state_terminal(), and
their names are exposed via the sysfs state attribute.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
---
 drivers/nvme/host/core.c  | 27 +++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h  |  4 ++++
 drivers/nvme/host/sysfs.c |  2 ++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 203ecafc1aec..1ef4dc38f755 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -591,10 +591,29 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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
@@ -776,6 +795,8 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 
 	if (state != NVME_CTRL_DELETING_NOIO &&
 	    state != NVME_CTRL_DELETING &&
+	    state != NVME_CTRL_FENCING &&
+	    state != NVME_CTRL_FENCED &&
 	    state != NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
@@ -818,10 +839,12 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
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
index 9b071076c9f4..e558a19781bd 100644
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
@@ -850,6 +852,8 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
+	case NVME_CTRL_FENCING:
+	case NVME_CTRL_FENCED:
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index dd48c0989301..3853c9a6356e 100644
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
2.54.0


