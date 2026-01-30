Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA563E6BF3F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LVIdRGLqMsWSyf1RS7DGFOpPJ0jysmOUh1LqSt0/BVA=; b=qXqE480F8IiGr5VmkZ5ByB7YrR
	5ZXC5Q7PM2HSDd0mybEYkZDl8nILhJj96WUOnqMyQmYbe3hmXRlDw8iYVblysjHMqxpPouyLWE1k2
	MjnSoyLsOFHIL551Qbpl3I+Q3k6/JyYSGjctfks+uXbqG80VA9SHC1dmNjAfxAPBe1T4IagUyEj41
	iBLjwpGnFTMJZCkFof896BIkBLbWfrk6i7ly8vimNKomNA+6hMeQJSgT/kr3JdwBChdrKRl1ocrno
	RijGT5CtIoVqbqKUsleLFMSa6NzM/hd3rx8CCUgAYbk4qjZtY6Ms2GVEnceEWp0+YqiW5gXTBsQ7+
	g5sBD5Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6P-000000022op-3dyb;
	Fri, 30 Jan 2026 22:36:33 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6N-000000022kI-1NS5
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:32 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1233c155a42so4518882c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812590; x=1770417390; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVIdRGLqMsWSyf1RS7DGFOpPJ0jysmOUh1LqSt0/BVA=;
        b=V0J1jPNUs3TnOtzVOfLgV29wWg1dxhVyihIpFFu8zOOhzF0KjzGC/DXwz2JkERzT1x
         JISDRIxxo5pVTgG4HgG/dSoDPiaVSDigjg4UsrMVXWpXUVLpeHxqtv+SUtdzHSS0fYRA
         M93H9KzGn+/n84dF2mORLUoGT7rFU7wr624B33AB4Nq5ZlCoiyDZkFnDeC4m4mpG0i3I
         QwkExzkP/8XRptsqYqCUSK5yk/hqtkjfyKP+Tn1l26mvsoRJuRLP29iI9qlADG6X99sX
         WwAeQJ2u+bvmLpP/hDTfcyCVKDyFW9M69PpIrWu2XBeavWUzSxyAiLlQopeO2d8e9Fwv
         UrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812590; x=1770417390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVIdRGLqMsWSyf1RS7DGFOpPJ0jysmOUh1LqSt0/BVA=;
        b=GrhGzknJ4N0A6gj8Qt7AM5o+PcP5jHFyzbDm9g3+16yAbeDSfx+wNHEUG0IPAGRC4r
         fRvnsvEdScZh23pgIZ0DNOOJtFg1du2+oAk2pp1fq5FwT5QFunle4qlgiEP0dcYYy+1+
         F1VEuo2LbO+o1GpxRDrWUQcEV7oVlqwOH13ZdUkmnSchIQm9gJimScxZmgo64Jtk3Nue
         8uo1h88TPGC02ZtaLLXiCjj/U+T7ZHjT/iMHz1TLm79C26ZGQeszKhtS+bNnKXfziAIa
         nrrisO325XtdckTtzvxz77JJ4ROd7vIeVaxGbqIclDe/pLZ2utCwudvrREVDojzqeEEE
         vlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrut9VwOmBUBMseM2oksO9JMCUEBH2QsiFlOsDD5444srLHfy2fD2kI9N1vxMXOFuOb1Srz7U0/zjE@lists.infradead.org
X-Gm-Message-State: AOJu0YwXaJiPzNaulUOaSJeypSiROwDQTWe6bAUT8aFwTraHLAmP1brb
	KPUutH9yBQ+IdirmiDc5sWJCkwztvx2sPPGITDb8RHSgEHoxGh2VqP4CrwFRErvry5A=
X-Gm-Gg: AZuq6aKbrdILuQN23cTPIn2YTIhVEKbwnz1sDeC+QXYR3i3PLunTnlH5ti66xrPmpCw
	q9TAcquckeRRRo3ZojJZmeCAm0oqHJXlnvqiQ390eQi0jo9Uf0Oh2emaYJALYnk5WduITrMty7j
	iDjVPgKh52t8ASPpCV8a8PEGECPwVnswqWLgD5XimwpoQqxpG3pdTF9OK6G3i1GTxWGiwwpujkR
	oNPshVk+MfqhM2TV3dgoEsS4E0CDokzFsCz1Rf3fD/pgfERS0IqdyLVeaomYRH5Lf50S8XCUupF
	D71tH245z5+TcKK7HJ7ahv4EBMB3rOqHmnuIzydeFvBsGbNPx0EaR88xihoqWVYTEXJwFjnjGco
	40cXd1puGb4gV+rAG3rPCLSa9BpHw6Jnj7awJDXZNHtQmk0F0BBsg3xzazV9Jcj3rPnTkV60Ehw
	cdlNRtvxIoOcGKNyoWSyVcFh7rEkijhhjJjA==
X-Received: by 2002:a05:7022:6281:b0:11b:9386:8271 with SMTP id a92af1059eb24-125c10081bamr2364267c88.46.1769812590220;
        Fri, 30 Jan 2026 14:36:30 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:29 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 07/14] nvme: Introduce FENCING and FENCED controller states
Date: Fri, 30 Jan 2026 14:34:11 -0800
Message-ID: <20260130223531.2478849-8-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143631_378888_10D84F81 
X-CRM114-Status: GOOD (  16.61  )
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

FENCING is a new controller state that a LIVE controller enter when an
error is encountered. While in FENCING state inflight IOs that timeout
are not canceled because they should be held until either CCR succeeds
or time-based recovery completes. While the queues remain alive requests
are not allowed to be sent in this state and the controller can not be
reset of deleted. This is intentional because resetting or deleting the
controller results in canceling inflight IOs.

FENCED is a short-term state the controller enters before it is reset.
It exists only to prevent manual resets to happen while controller is
in FENCING state.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c  | 25 +++++++++++++++++++++++--
 drivers/nvme/host/nvme.h  |  4 ++++
 drivers/nvme/host/sysfs.c |  2 ++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8961d612ccb0..3e1e02822dd4 100644
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
@@ -760,6 +779,7 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 
 	if (state != NVME_CTRL_DELETING_NOIO &&
 	    state != NVME_CTRL_DELETING &&
+	    state != NVME_CTRL_FENCING &&
 	    state != NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
@@ -802,10 +822,11 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_receive))
 				return true;
 			break;
-		default:
-			break;
+		case NVME_CTRL_FENCING:
 		case NVME_CTRL_DEAD:
 			return false;
+		default:
+			break;
 		}
 	}
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9dd9f179ad88..00866bbc66f3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -251,6 +251,8 @@ static inline u16 nvme_req_qid(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
+	NVME_CTRL_FENCING,
+	NVME_CTRL_FENCED,
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
 	NVME_CTRL_DELETING,
@@ -777,6 +779,8 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
+	case NVME_CTRL_FENCING:
+	case NVME_CTRL_FENCED:
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f81bbb6ec768..4ec9dfeb736e 100644
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


