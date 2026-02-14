Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766AFEF99FF
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+YYScjSesE0x8k06HUvqt/BkKPH2VBLshBgb+fspSKA=; b=P3eqrh+PVUnEgY0i4DnBeteHX9
	TYKABM72p+IR1AsNZTAb6ZIfNI5apoBGQC06dPUpmY9myAUNbRAEgaDl3SAsxLtBxuKcwhDKjR/9v
	FBfWOskUx7nA9EDHilstAS2D3h+6AW89J2wdPFkJvTf7cYNYOYjpe3X7YRnbmHC2HmpH+W9cUZAJU
	L1AwYkhfMuujYJihmDtR1FLJZX1wNLgAdp5OA/4lY60NIJ1KTKBkVPYbpoGb2rVyuBoE0JpOQTzSs
	c+ZU4NyjCpRPYrKlhnJQA+GHCH9VLCXY/1yh6JA0bA3DNV0fRnNQmkXIkUpiS6wvgVdhe3UuXYLLl
	0RXRS/VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gh-00000004F3b-3Dui;
	Sat, 14 Feb 2026 04:28:31 +0000
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Ge-00000004Ey8-0YH7
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:29 +0000
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1248d27f2b9so2229475c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043307; x=1771648107; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YYScjSesE0x8k06HUvqt/BkKPH2VBLshBgb+fspSKA=;
        b=E6yFABIZ5674LfvUnUazJiBjjvKt9GjfhIi8jVnpNREYRCxuuojaorbtOgHTOT74eC
         NQoOABUMXEOXz0OZIa5uXQkJ5Gxz4ieH/Guk9EBWdakFNcg6hQ2oLM+wEZRZYRcuj5vQ
         S+LTM1GOxmenTc0vdRwuNyHnQGfqmk04eh6HJhgwElN3dwHw2YMDaUtc6JSqYMnuMlZV
         1WV8XNBOz6uqeqWhH3fJkJ3qLBCkj2JJoAa2ZWnTr6N/kMYJzzp/DisxxVDrYfIDySXy
         8SckH3v4a8jKDCsk3ybJcsaImMaUjGANt6jSYneeJE6++H13+/vpQngpslLmGWPEjxfg
         wa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043307; x=1771648107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+YYScjSesE0x8k06HUvqt/BkKPH2VBLshBgb+fspSKA=;
        b=eysEPcq18NyouucYD3Z4WFmZQK6vWuRDUVV6AW6enTpOvJgBY3tuLV1LC88L7SG2qV
         jIbRjSPPXUwEIJJH6SRA6g0mwfXJT7iQ4Ia/aUSQwscKJYILoyyeronUq9lYNbtmgJSR
         IC8o5TMO8oVKdKyFod6AZbRPngQyia/C5o75fTWlJJPlFoqPsVwqPekiSVGAVIxk77xN
         h5p9eKQbKk4jz/H64cMDpiffG+XhAVQKHxRlDKaRjPV9wnP/rDw3pFlnMscMR5TqsjFM
         fTeJCgpOhDQC20QYPgkl3vFxIAnlig88LZFH7X4AjdHkzDOAJAjeyk+aNsQmFH4Ouoh9
         LDXg==
X-Forwarded-Encrypted: i=1; AJvYcCXWl/yVmPnWrA9gOCjHVztIm8ACpqXzV/EdiAFywIPqMq4xQI8NiURSbzE2O0AkRueQ4wuObxmqco+i@lists.infradead.org
X-Gm-Message-State: AOJu0YwRTp5EeWZORRX0XgnklxgbQgPQW9dX+BEBUtO/s40g69uUwV8r
	XKhvPaVRqAAPhn1p0kHv+m4cYw3RHezwKo4qYv2cUea4+EvzFASdb+iPhC4CHebOfdk=
X-Gm-Gg: AZuq6aJy///F9l74L6Sh0XXPVSUbUy2WvPspcV3n7p4OQixfFc1iY/B5Sqq488GF0Dv
	31C3k5nxgOX/4VF/O2kUMxmQYi1Z/jLwRdfAWJzP3GfEY0+xqhfAiicJmY9WmMG/cIXkg0wtEcw
	ZIBi2t/Eh6feukwJMGMGn+P8tFJt4lJGtIIMBA911RrujllKavBvrPe1lIH29lCAdsQSFD3utcI
	SlyCZZPZvdNg/OywVx+duEWJ4yca0szyNLhGYGvsFFOTfrUmO3q07NbfuaBNpTkEYhSxGuA+kPp
	0QxAZvOgsWdQ/2V5/1jDuDkbj/e17Fq3aAYwVklONEQ9hejHGS2s9AomjJ54DIlIcqOnw5ypDSj
	sHXI50SCSF6WJEyepMB3wQ/7kMbrWruY7If9hX5qsLfOrmozpk80VgceVIvbZXTgTC7BGuXuF1L
	3Cvlqlhs7BuKDpmghppaZJUkX28cQoxe2B7ggzGCWSXTzlSg==
X-Received: by 2002:a05:7022:4596:b0:124:65f7:2c2e with SMTP id a92af1059eb24-127398443b8mr1428287c88.43.1771043306958;
        Fri, 13 Feb 2026 20:28:26 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:26 -0800 (PST)
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
Subject: [PATCH v3 07/21] nvme: Introduce FENCING and FENCED controller states
Date: Fri, 13 Feb 2026 20:25:08 -0800
Message-ID: <20260214042753.4073668-8-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202828_181234_1A776DCD 
X-CRM114-Status: GOOD (  15.85  )
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
error is encountered. While in FENCING state,inflight IOs that timeout
are not canceled because they should be held until either CCR succeeds
or time-based recovery completes. While the queues remain alive requests
are not allowed to be sent in this state and the controller cannot be
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
index 8d26e27992fc..231d402e9bfb 100644
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
index 6984950b9aa8..b1c37eb3379e 100644
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
@@ -776,6 +778,8 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 	switch (nvme_ctrl_state(ctrl)) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
+	case NVME_CTRL_FENCING:
+	case NVME_CTRL_FENCED:
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index cd835dd2377f..1e4261144933 100644
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


