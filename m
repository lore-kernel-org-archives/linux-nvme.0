Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B3606A8B8
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yvhXbQXS;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=STJzQ6jd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=c5aNvHozYviAhxVs1kBeJuiLRQl1AQb1/qe7EnXaxK4=; b=yvhXbQXSaQwtCT
	iRzVyEjXXcqxp3Rhk6UEbytyaNBYx8xHA9rFvioVLX7PSwWP36PNj581FV5q0+YaE6RJpHJ+CIBbx
	uWP3Ym2cussPtob98LLEtw6RLrFd1Rn7SMepaXS1gBK1EjgSSWm/giAWMU3E7jPFLjHxyJ7Gm1MfN
	ydSK/XaDiE8vVQcIY4FKX/vpEWXFXgmIbgUso3AxUBSSZVpsH2RGZebYSsa0Vkbdm+3Eu9m7Pr6vj
	78RXRGIHTaiv9qA6/qW2mftn0IM6+AF9L7mjOSVlrGeatdu2CzKqmYyIFZ9KdOB2ZIoE57UM8bDAW
	Cqppv2aBKL2wVFQCj7mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45h-0000000FA97-1SJr;
	Sat, 14 Nov 2026 03:06:09 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45V-0000000F9ps-1YRQ
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:05:59 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-1a2af4c8d00so3456660c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625556; x=1795230356; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c5aNvHozYviAhxVs1kBeJuiLRQl1AQb1/qe7EnXaxK4=;
        b=STJzQ6jdUHdAUyM5aatD4QY7r3+3EILnI6YD6jXN5Wazp7wQ9OjI15RgHC/lrJx5gQ
         S/i7MA3HmmdvkbbODTPsuQO0BJ0atFgDTx0x5iy5mPod7TcsF9s6Q4+AE1J5uGMvQLc1
         n4T4lhRsNsb5cy5Ows9njZyALBgm4wvvn0D1gH0889uev5se12zkooI4/UXPCNy99Ja+
         NXcM0s1dK2lG9s69IzNW957SE3WYzWGWhPyiZNQas6gIyRPMwQ7ezaLxgcCBYi48NRN9
         Lb65AXh7j+aFz1JlXAH7a2QciAtsjD9DiRFX7JASKphgQZrol1Y66WHG67AGCiVXoNNu
         8xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625556; x=1795230356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c5aNvHozYviAhxVs1kBeJuiLRQl1AQb1/qe7EnXaxK4=;
        b=YXjD9NAoPLjxSEbgBcrKSjkMjPvadTygl7fmT95wE07svFEUnA2RvFU10ZHd9iI3bG
         LtlmnBsv7tZ7o0m+OziSDVgII+ghR1vzSkFmDIeTfegSv0rrJZrccvh7vLnHC1hDqIxB
         f8bNjcreo83kXGiY371VpIa+uB9A4yj0fgs6jWBA01EzLAavJrbjAqjNX0ZoSeln/3r+
         Xc2KMYP+rdYWB6f8EBIalwHdn2KWsE70qCMldwALk6VbFdKzY6DiHWz/3jPleF4KoN33
         HUFi+snQpJ5kzTHeWZOO2msSwzP7hSuGlL57O5vQNJNEHHuxhoYF9DKl8M/QIVZvzBkT
         TiTQ==
X-Forwarded-Encrypted: i=1; AL+hErERD1Dm5e4JAxMnv+aW0O/3dj7Lss6JLdSnfo8CQ6XKCF91pAFp6KD2HZzUgVFE/K9LDX90Sf+GBBBl@lists.infradead.org
X-Gm-Message-State: APuU4Z/qLXOF48APiRcf3wzc14QkL+atTGybrgjLALMhbiUOPwhug4aK
	nUcUC2HC74m1Yg/5Bl/q96C0B5er20d+C9przhmqGB4+4hH0ndA1Mkl3AUIvPn2N3FQ=
X-Gm-Gg: AYBFou097gcZtAz82qLrZF/YVBjkisA+mRHbeDatCaLWwqjScOYFntkjths1kz/AWXA
	Q2gmbRcSYLv1WCGqlkcERbVRbEsemuAn6vw0/arQeCgRcBRN3utmvo/R9Nmu0O83Vs2unPAdh/I
	9D94G8+QjWSg1aW8bPEhWKr06eap4eux+sF7Rg/RJfA27uzvs1KBTDYcH+xlpAQ30gA1/0xclvr
	jPJ40nts5glBJmIftC3kmJgcx2abskVJNer+d0jW3nKyoOvdl0spfR/ffohxFmM0sW4xdlrrpSa
	xZH1xmip4vQbyPGlgozRzZ3RXZbYPOjdDO8X22g89m/GnL+rjYyugxCI3Ju2tYJBIxVe6FCD/6E
	XrOGnPTmMpoL/b/1BEgSii8x51tuPiXEP/2OLXlg1uUesZ3vNAaM+3kh5Z2fZfLi2V6NXYbsUvP
	Vph4lUQNlnLJwOPACVRTkvJ3MqL/E+X3M0dsO6rKuDh/qR59dAXIcRwjuI+6cw9oNc0BwpPxnYN
	wEe5lcWstaqUAHl77MtpzmDaMeiE8HGiLtVXM5Oms379qZPiHdOUrgRyVKnyQZtaOeJRmYMSy0g
	/mKgiIlpvJ/qcPBdQV/OQyZIwWkdIAI8u8Ng8TK2IC5RruGR9BxF
X-Received: by 2002:a05:7022:f116:b0:1b3:ad88:b9c5 with SMTP id a92af1059eb24-1b503100521mr3871981c88.24.1794625556198;
        Fri, 13 Nov 2026 19:05:56 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:55 -0800 (PST)
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
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/17] nvme: Introduce FENCING and FENCED controller states
Date: Fri, 13 Nov 2026 19:04:21 -0800
Message-ID: <20261114030454.2836543-8-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190557_486277_F6CACB85 
X-CRM114-Status: GOOD (  21.68  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce two new controller states, FENCING and FENCED, and the state
machine transitions needed to support them. Transports will move a LIVE
controller into these states when an error is encountered; this patch
only adds the states themselves.

FENCING is entered from LIVE. While in FENCING the queues remain alive
but new requests are not allowed to be sent, and the controller cannot
be reset, since a reset cancels inflight IOs that must be held until
either CCR succeeds or time-based recovery completes. A new request
issued to a controller in FENCING or FENCED is failed with a host path
error, so a multipath request is retried on another path.

FENCED is a short-lived state entered from FENCING once fencing is
over. It is the only state from which RESETTING is reachable, so a
manual reset cannot take effect while the controller is in FENCING.

Deletion is allowed from both states. Callers of nvme_delete_ctrl()
assume deleting a live controller cannot fail, and they cannot wait for
the fence either. RDMA device removal and the TCP/RDMA module exit
paths hold the transport's controller list mutex, which ->free_ctrl
needs when the fence drops the last reference on another controller.
Instead the transport's ->stop_ctrl flushes the fencing works, so the
delete path waits the fence out without holding any lock.

A controller deleted while fencing does not keep the fence's hold on
its inflight requests. Once the state leaves FENCING they complete as
in any other delete and may be retried on another path before the
fence would have ended. This is a known limitation, to be addressed
separately.

Update nvme_available_path() to treat a controller in FENCING/FENCED
as an available path, both states are non-terminal, add the state
names to the sysfs state attribute and document them in
Documentation/ABI/stable/sysfs-nvme.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 Documentation/ABI/stable/sysfs-nvme |  5 +++--
 drivers/nvme/host/core.c            | 29 +++++++++++++++++++++++++++--
 drivers/nvme/host/multipath.c       |  2 ++
 drivers/nvme/host/nvme.h            |  4 ++++
 drivers/nvme/host/sysfs.c           |  2 ++
 5 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index e3395e5730bb..df883d644fb4 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -156,8 +156,9 @@ KernelVersion:	4.11
 Contact:	Sagi Grimberg <sagi@grimberg.me>
 Description:
 		Shows the current state of the controller. Possible values:
-		"new", "live", "resetting", "connecting", "deleting",
-		"deleting (no IO)", "dead".
+		"new", "live", "fencing", "fenced", "resetting", "connecting",
+		"deleting", "deleting (no IO)", "dead". "fencing" and "fenced"
+		were added in 7.5.
 
 What:		/sys/class/nvme/nvmeX/numa_node
 Date:		November 2018
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 38b27d8db011..4be3ce2e72a7 100644
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
@@ -622,6 +641,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
+		case NVME_CTRL_FENCING:
+		case NVME_CTRL_FENCED:
 			changed = true;
 			fallthrough;
 		default:
@@ -786,6 +807,8 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 
 	if (state != NVME_CTRL_DELETING_NOIO &&
 	    state != NVME_CTRL_DELETING &&
+	    state != NVME_CTRL_FENCING &&
+	    state != NVME_CTRL_FENCED &&
 	    state != NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
@@ -828,10 +851,12 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
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
index ae8059366b57..a987e2413acb 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -538,6 +538,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 				continue;
 			return true;
 		case NVME_CTRL_RESETTING:
+		case NVME_CTRL_FENCING:
+		case NVME_CTRL_FENCED:
 			return true;
 		case NVME_CTRL_CONNECTING:
 			if (!fail_on_ctrl_loss)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0c87072c5265..cb9fca419935 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -320,6 +320,8 @@ static inline u16 nvme_req_qid(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
+	NVME_CTRL_FENCING,
+	NVME_CTRL_FENCED,
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
 	NVME_CTRL_DELETING,
@@ -875,6 +877,8 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
+	case NVME_CTRL_FENCING:
+	case NVME_CTRL_FENCED:
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 5b549a0513c6..ec4ca1669253 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -546,6 +546,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	static const char *const state_name[] = {
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_FENCING]	= "fencing",
+		[NVME_CTRL_FENCED]	= "fenced",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_CONNECTING]	= "connecting",
 		[NVME_CTRL_DELETING]	= "deleting",
-- 
2.56.0


