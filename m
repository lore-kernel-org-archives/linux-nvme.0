Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1B0EF99FD
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmQB6UPDuJJWXHBdsmsQAxC67O4gJkvSY/l87y/lKo8=; b=vqfoDiELH/GadcyJGe9SUaG6h/
	cdNEURbzQecX+iQ+Mh0FDJO0sM7DAdSVnS/U8uMe4bPxWvAb2/xymmX3uDj/N5OJn9bRROyC5qggM
	H17F44G8MtaXikBZDo1g3qkh3I/SP3V0tg4bpTEyyv9ekxI2gOFGScSDNToG967gf//PW7AWXiv3U
	rtCFeYtzRX28NhMlnj2CsFrIZr7GVMEAj7ws0LFOXTagGfQFnfLV6JJGfA1LXidt+II4hXJRm2cx1
	7HcvZqAjn7nHTFkJ5hdSAyEEX8D3ZrGlyxKsP8HyEia63SdR9DroOj9c0X0xoD2aG7VGXeSa3VfrP
	jdA0LoEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7H3-00000004Fcz-0ZKj;
	Sat, 14 Feb 2026 04:28:53 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gn-00000004FEg-1ijI
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:39 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-127380532eeso4212989c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043317; x=1771648117; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmQB6UPDuJJWXHBdsmsQAxC67O4gJkvSY/l87y/lKo8=;
        b=OO/W1DGeMyUwmRH9leCHQEKvxDp242GwO4FyoXhnyAu9J25nbrERkc7UArYKhb9ut3
         HZkpPdBYgY3rZ9h0UTuK5dLBBM1f1RdhcmKHHQcUuP01soa68lsFD2CLBWE0h4mwpbMX
         rdLnHj6V40OfC0MGdy51+IW/PuFKF7mMH//hTyruXOyt0F+XA1awFGm/ZOPfKA3+sFOD
         SJndujuzxqOwfgCZhN2A6+fUXLIJ3ltzB18ryWZQ2nM0KWLR9sE+rFa/PitQeK2Wo1/c
         yqIKo+3Yo8UrQovZFCq5Km0FZF7/ttowY1JqaUwR5UsKAp/63mwLsUbijZHhrz8Au105
         NpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043317; x=1771648117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vmQB6UPDuJJWXHBdsmsQAxC67O4gJkvSY/l87y/lKo8=;
        b=FEuoZeg3CvNqPyyqPRlmD5Fr6/kvav51HMeJ8fmjb7nqJxz9TLQYpwd7b6agW9btLU
         6gQG9YopDzsKE2nFcJu0gKBoJUk7BnYiGnlHt+KajGZ6RtZr56r1pzmW6CTB6gVDC4t4
         f7GVu8TgZH2HI4S/N4PvMBwugwjq6BPOGcGTEC71cLwGw79Q7jykSgEZIGuQNhmJX2mp
         P1Zsn2lgKp/V5nPgTUwJsbrp9/tZ9Rr5w+IHJzzTb4vwNGCBcsJ0KtMP9RLn8fRMLe66
         270GT77s+uYCbMX90uXB//u+SHqt+d73y5aEICR0Rv2E3Rn073hXGgis5i9bj2W7TG3y
         TpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCqSERiK0/SWuGmrs+HmvpULhUw4rvvgJ9Uvyqk78PII34/f42qIx87ihuTKdXZnha73YwBpo/XKEV@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2URgzORwCifIjknj3/ZQGAVt3wP8muzLvOdQb2AL3+BtOsN1m
	2pDFhxgdTEdEnd1KFe7/8QEyvsRnCueR1tFFU7v5BRbErUcxkWbxeuFkTHEUvDJRIac=
X-Gm-Gg: AZuq6aLIAsqzZqBARcMRIn/Oln80JOa1bXRlsaKR9zlsMCgPHwXv3uSIvkJ4mHIijTv
	hrwahM7KHK/0hFZ3Zbk7c2avk+u52dWEiBWkpKEPInCzobA3UMOOSWo5iCjQULYnAsD39RYZKlY
	zAEIpTHjxBOcdcQ5vT3IWMGsCmW1qODdbLm5zezA8xI5bSCQ3duFJjbYSgy/xE5q1DfqIu2SIi7
	jpSj48qpS0JCg+Zc3fzJNxVwei+h3+H+yeH5m/6XV5fxaBpb/e+l/cn9MYNKVI++14DX78hwvDz
	eG92yNnN/DG3L4F14VSx3X0QOUnOTdGMqacN6wwW5BGKRSp3J6AzZUZLxYerw/DZ/a6qfXXpYiD
	LRyk2h1MTntr2aD/Dlsm3fDFwl/G+jhZpx4jHIqFokgNOnvQ2R5K2JUOpfvzaYezsYEAjbBs75m
	g7WQFLSwerFMOHWUwkZdI2wbt5DOmre/UtUPjAIQv1uu/6MA==
X-Received: by 2002:a05:7022:2506:b0:11b:bf3f:5240 with SMTP id a92af1059eb24-1273adf2adcmr1795450c88.9.1771043316554;
        Fri, 13 Feb 2026 20:28:36 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:36 -0800 (PST)
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
Subject: [PATCH v3 19/21] nvme-tcp: Extend FENCING state per TP4129 on CCR failure
Date: Fri, 13 Feb 2026 20:25:20 -0800
Message-ID: <20260214042753.4073668-20-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202837_473208_7D2493C0 
X-CRM114-Status: GOOD (  14.30  )
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

If CCR operations fail and CQT is supported, we must defer the retry of
inflight requests per TP4129. Update ctrl->fencing_work to schedule
ctrl->fenced_work, effectively extending the FENCING state. This delay
ensures that inflight requests are held until it is safe for them to be
retired.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 229cfdffd848..054e8a350d75 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -194,6 +194,7 @@ struct nvme_tcp_ctrl {
 	struct nvme_ctrl	ctrl;
 
 	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -2477,6 +2478,18 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_tcp_fenced_work(struct work_struct *work)
+{
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
+					 struct nvme_tcp_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+
+	dev_info(ctrl->device, "Time-based recovery finished\n");
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
+}
+
 static void nvme_tcp_fencing_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
@@ -2485,23 +2498,40 @@ static void nvme_tcp_fencing_work(struct work_struct *work)
 	unsigned long rem;
 
 	rem = nvme_fence_ctrl(ctrl);
-	if (rem) {
+	if (!rem)
+		goto done;
+
+	if (!ctrl->cqt) {
 		dev_info(ctrl->device,
-			 "CCR failed, skipping time-based recovery\n");
+			 "CCR failed, CQT not supported, skip time-based recovery\n");
+		goto done;
 	}
 
+	dev_info(ctrl->device,
+		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
+		 jiffies_to_msecs(rem));
+	queue_delayed_work(nvme_wq, &tcp_ctrl->fenced_work, rem);
+	return;
+
+done:
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
 	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
 }
 
+static void nvme_tcp_flush_fencing_works(struct nvme_ctrl *ctrl)
+{
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
+	flush_delayed_work(&to_tcp_ctrl(ctrl)->fenced_work);
+}
+
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
-	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
+	nvme_tcp_flush_fencing_works(ctrl);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_keep_alive(ctrl);
@@ -2544,7 +2574,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 
-	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
+	nvme_tcp_flush_fencing_works(ctrl);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_ctrl(ctrl);
@@ -2934,6 +2964,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_tcp_fenced_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.52.0


