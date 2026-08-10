Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58AAC5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 22:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L4HJis6zMvRkqVAWz+E140YbLNtXuGOK2SxG+4zvx4c=; b=z0AT7Vo/j+IiUg/j6jCwTWSZqc
	N284u3Yre+QW7NV/b4LM6JYC1vYLDJMVZSV8Nx88v31KrZogjJ/G1QngU35j0wRpNCHerfwc2L/Hh
	8Ep9TqpJHLO9a4eBFzmqTaQHSOL5LJSIWY7dUYPPnJ7YFhWAN0taRDgIO8xHTDFuGqKdWCnX73gsL
	qaveBe7eL9P2/f0c2IFhX1BdhMQMxfoMk6cUs2HH7MO0FFRGB1J/a+NQJRkiZ1Lwc1UOoxoxwK/td
	EvQrlAWoZXoY9XDnIbphv1Gz0ZBBKDpcqNdhxZtUkaG9/5kSjEGtfT63mg9WoGrSRkmXVdJ7fkUMg
	5aTVghdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtY5H-0000000Cwf0-2C06;
	Mon, 10 Aug 2026 22:03:03 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtY5F-0000000Cwef-23bI
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 22:03:02 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-66b13ee8801so964858d50.1
        for <linux-nvme@lists.infradead.org>; Mon, 10 Aug 2026 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786399380; x=1787004180; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L4HJis6zMvRkqVAWz+E140YbLNtXuGOK2SxG+4zvx4c=;
        b=WYpfY1SLFGzmqPgeDWgMIOqJ9VgqwW9RW9B1g7Iytu9bqZ/3hL2QQyNwvb/0Nn9u1w
         jmYl/ErbE7Y2EsMNMUir4WbzY7gApMMApprfWiEOvXG6sA84qjgCK2LpmqbLa2GN4suX
         9vPx+3UxWa1gJM6efX62TYjA//G0x3CRbfMfgweFfNiRCm9hM8Mcq+88LmQi21csIC9q
         8NVntTY4Z51Tjr8+A2RLZuxNMd6yNoijJQ1iEEWAMx7oOWhjDCzEDXRnuTr9Ph4DtpHC
         NrRxpNvhNJF4CTJePBcASwxJTxzJHpMiZOljCGC/AudXx+L/PNuURe2tyyxuTsaadARU
         4F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786399380; x=1787004180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4HJis6zMvRkqVAWz+E140YbLNtXuGOK2SxG+4zvx4c=;
        b=H+qm26eHrdd0KMnAfcwsrYthN7f54iiHL3JhamjIbGV5mXbAJYYWYmaA6nvINvNyN+
         5GRPZIOMJVV9Gl+ia6K012LOCTDLY1njwHwDlTcVMB8rgrfQ5J/4vLoaWasmX5bOFHuk
         /Y0ONas1dLLjtuQYEHI107U/Wn/GWn1ooVt6hrRRWGNeDHFrRZ9D2lQTNC+nwaVHSZ39
         SKHuIMwGTaR99viUrkgHciDP8RoGH4rD9V6gNwTDaCONZ3ks0HXgEOAiQQgzHKqOpXTw
         ifqxi4CKX3xmCPCS/wPwxmIw+yA4ds5g5Z9pI1e2UCGEijrwdfsfsH096CFp4gUUKD1/
         7WXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGLFpv21jsyocHpzUunl+qc5cUjGpo3H76o9/PyZVNQXvoQ/VjIv70rtrsKB7ZedMtsnEDDafcVbdh@lists.infradead.org
X-Gm-Message-State: AOJu0YxdOcRKL8okGy5xfH2c3qm01zJWiaeeuASg5NAbXMpTnE/feJzK
	fkNY5EVFvAqUbH99ZUyIL4W+gx24wSYsHeZ8lpqSt08dIf4o48WajCwk
X-Gm-Gg: AR+sD10UGzx3p1ld6HOj7tx+LOjS0jX1PrqWS21ytNQslJLlnGNEi9Ld2/qXvJLY959
	+29LSHtE2XSE37BvnWicp8sOtdrRCXXB2kvAO7fY3RbYtnhmNKNTwMtHhgu065HMPq/rKV9Mni/
	YY2hRfXboT4+VH2Valo4P6zcnRglSfwz/AxmmSN48kUx1xHo8ewyeYrXAppzFYdkHU/QuKc4svp
	+hUdW3VqQOIbpLbQYyMj8FT1tr3W1OEkUR+7zn+hp4Ato/SbfXEnLnKi8NFnZS+IUTTpuZ2cVqz
	bywO1J4wur/6JjW1oqt0xHk0AilSdaZcNLYnGZ+v2sRTiLVd2BG7wCJZBxSizak6t9vlCho3F4f
	vPUK9Q+At5ZNQyvi8KJxBcehKdGgP568oSi2hSezOf60gHkp83bvISeGrcL0aTK5Ew/boGz6RQi
	s+OCFuHc0gCtj26iyWcAb9IkiDm/RVwY1FspctGyGZvfxa4tKFbffVXJc6UpBwYm7+f9SjqBsKK
	93VDW8=
X-Received: by 2002:a05:690e:d43:b0:664:7d5d:4390 with SMTP id 956f58d0204a3-66b122944damr2929855d50.1.1786399380140;
        Mon, 10 Aug 2026 15:03:00 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acae62283sm7139966d50.13.2026.08.10.15.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 15:02:59 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: ratelimit the completion-path messages driven by device data
Date: Mon, 10 Aug 2026 18:02:58 -0400
Message-ID: <20260810220258.1960208-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_150301_541292_F637EF9F 
X-CRM114-Status: GOOD (  14.65  )
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

nvme_find_rq() and nvme_handle_cqe() print an unratelimited message for
every completion queue entry whose command id does not resolve to an
in-flight request.  Both are reached from the completion interrupt path
(nvme_irq() -> nvme_poll_cq() -> nvme_handle_cqe()) and the decision to
print is made entirely from device-supplied data, so a controller that
posts a stream of bogus command ids drives unbounded printk from hard
interrupt context.

This is not hypothetical.  A single boot under an emulated controller
that posts invalid completions produced 846 "could not locate request
for tag 0x0", 846 "invalid id 0 completed on queue 2" and 123 "genctr
mismatch" lines.  Once the tag set has been torn down every subsequent
completion resolves to nothing, so the print rate is bounded only by how
fast the device can post entries.

Ratelimit the three messages.  The information they carry is diagnostic
and repeats, so the suppression count printed by the ratelimit helpers
is enough to tell that the condition persists.  This matches how the
other device-driven error prints in the driver are already handled, for
example the status messages in nvme_log_error() and
nvme_log_err_passthru().

nvme_find_rq() lives in nvme.h and is shared by pci, tcp, rdma, apple and
target-loop, so all transports are covered.

Found by FuzzNvme.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/nvme.h | 11 ++++++-----
 drivers/nvme/host/pci.c  |  6 +++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..31e771e1b721 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -666,14 +666,15 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
 
 	rq = blk_mq_tag_to_rq(tags, tag);
 	if (unlikely(!rq)) {
-		pr_err("could not locate request for tag %#x\n",
-			tag);
+		pr_err_ratelimited("could not locate request for tag %#x\n",
+				   tag);
 		return NULL;
 	}
 	if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) != genctr)) {
-		dev_err(nvme_req(rq)->ctrl->device,
-			"request %#x genctr mismatch (got %#x expected %#x)\n",
-			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
+		dev_err_ratelimited(nvme_req(rq)->ctrl->device,
+				    "request %#x genctr mismatch (got %#x expected %#x)\n",
+				    tag, genctr,
+				    nvme_genctr_mask(nvme_req(rq)->genctr));
 		return NULL;
 	}
 	return rq;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db5fc9bf6627..93c0cb47bcaf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1549,9 +1549,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 
 	req = nvme_find_rq(nvme_queue_tagset(nvmeq), command_id);
 	if (unlikely(!req)) {
-		dev_warn(nvmeq->dev->ctrl.device,
-			"invalid id %d completed on queue %d\n",
-			command_id, le16_to_cpu(cqe->sq_id));
+		dev_warn_ratelimited(nvmeq->dev->ctrl.device,
+				     "invalid id %d completed on queue %d\n",
+				     command_id, le16_to_cpu(cqe->sq_id));
 		return;
 	}
 

base-commit: 8541d8f725c673db3bd741947f27974358b2e163
-- 
2.43.0


