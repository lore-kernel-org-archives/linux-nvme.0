Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D77CD5BDE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 02:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SOIvww4p9dI6iVgYWCUzrJL7pR9pb6hrrJ+56OmeK5o=; b=lDcQFv7blkRoFdl1RwaqGoAYqI
	lYRaMoxV+1SWCOgowYUT1frMWxNK6lBkcYV6WtY4ki3puWagjzKS5FJnSpp3tdBZAW8AYrwMjDr+x
	ZALvWZ+YuLwaC3/jEhJJq4PJeXrgO35R5JWfzRqCcXDja0PrHcW2aYq5RuyFqy1oUHaRnv2sM/RK1
	j0N3e5LSexUfwL4Kt3Jdr+mE3lM8j/0fyeqhqf9/PXMH5X6gO+NicJJSXdy3y7nYxLnsxl6hTc47L
	4i2VQdbZjWVHL1k8E5GLnkbxzX9usX2gCbs2IDw2st532Wff6m8jIObcmb8vlre4OiGxX67bwrFLK
	nDILZDhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS41n-00000003A2a-1Ck9;
	Wed, 27 May 2026 02:29:51 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS41k-00000003A1z-20VQ
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 02:29:49 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-83ec36a13e9so5609490b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 19:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779848987; x=1780453787; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOIvww4p9dI6iVgYWCUzrJL7pR9pb6hrrJ+56OmeK5o=;
        b=eNlOHf0lGXqBYmOlgOneyxlJO9a2keCZxprdglQlwk6BZiuWUqLS4hS/Ug1KT7QAZJ
         JLPVGLuaA9dNRZ20o0fiHxOfenMLiExz4lgXJunx6fzyA5sinSsGpS5W5RiDToUnbOpZ
         VcIPoe82El66DqHVN1fSWxUIQmeP6yHwWmpx75syWWbl9tw+nsDF2drzSp0Z4CM2lxHK
         jsuFPIbGjwMcPFAHVGxiFLmFexNjfUshidfmhht3Z2ZjF9+D9Ecv+kz+NAhfyyx5GlWn
         5B9H1plot+mB7MZLNtxYQud+W2rZx/VTmhGedAr9M8TJtCBeFLUm+zVQPDPyOZpnV6Em
         T8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779848987; x=1780453787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOIvww4p9dI6iVgYWCUzrJL7pR9pb6hrrJ+56OmeK5o=;
        b=eX3KcWUD4Q21zKN/+epOEzNqYNbBdRFD4dRKme4FnNOZkJ4dwwI+dJG888P8nRgHsf
         dvJpD7zmfmC3Z/NkoJbL+A6VCobN6+VZO5+LJNl4ln3IHfITIfEmtCgWURtxIkKLEihj
         GSQaumYlPdakyZy9ZS80KHLJikyu25+FMTUq+VRmyOf/LRzBZT5aSTrpDaZtJqNBia+Y
         erHDuvk1cyHU/pUUXCJatUALYcR3b7uUYiDEir36LewjZstN7hnW/XBnK4yPTRRkMIa0
         64JXZxGvsbr4rYISYlfQpi4ClHtXRU6ttpPt55y/6oHXflCMzWlVO2emui/vgFCh3Gga
         zexA==
X-Gm-Message-State: AOJu0YyQLHXJKGH8I2YlCEtgE5cts8vs0n3KZnXNRWiWrAD5wIs0oY/y
	5XRPZDlkUk7c8fMo7ru+xzxDgbhJHpV785EiWQWb5UY0zk9k+m5mZ4SklLg0HRhrsq2WTw==
X-Gm-Gg: Acq92OE4VFpnJkyjEsrJMcRNtlFlQgKYFQSnSKaRzxlBt6cgGQyBJfN24J5UuiXPrc3
	7S8jmP1+HC87AjENrVk53bpGT11VvWwhMhOCxJD51etpu05DbAYPf+PFZS0OCkfY8YPqo0MODuI
	Z8olRuh75/QmvC4GnzgM1wV7R3Kp1xqVUrqf6Z2JgIMi7aWvhGdinSuKDbuv2YcKZfvvj8aNCcS
	neJnw31FAtUM/Rs9nlIT0UZNUB3+F0Axdm0yKjbeng1MrDt0VuCMqgjwiJziLM/arfJQxUQOorc
	mCUI5f5cc6ZEcLQmslPQB/JkUwopswTwP+wzdoVsE66HAman963GmpPxJdesSGqVumNsRFyqV33
	aNwCG+1PlhpJJqNZ3pfquS1Wp6LqeRAmat3tMPNttt2ULW0sTrCHF2FnLRojPGqFCTUnuYnidYu
	vU/aR2PekqwPYgY2JYzwe6pNoD4yjU
X-Received: by 2002:a05:6a00:8c10:b0:81f:9b4c:81c0 with SMTP id d2e1a72fcca58-8415f58d727mr19397002b3a.41.1779848987559;
        Tue, 26 May 2026 19:29:47 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d72eac34sm634308b3a.49.2026.05.26.19.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 19:29:47 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] nvme: fix FDP configuration log parsing
Date: Wed, 27 May 2026 10:29:45 +0800
Message-ID: <a989258938de2d1fb01e70fd5ea2e50185cc6899.1779848573.git.gliuxen@gmail.com>
In-Reply-To: <cover.1779848573.git.gliuxen@gmail.com>
References: <ahWw_09BJkQi9zQe@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_192948_517698_5CCDFDB6 
X-CRM114-Status: GOOD (  15.68  )
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

	<cover.1779848573.git.gliuxen@gmail.com>
From: liuxixin <gliuxen@gmail.com>
Date: Wed, 27 May 2026 10:22:32 +0800
Subject: [PATCH v2 1/1] nvme: fix FDP configuration log parsing

The fdpcidx bounds check sets n = NUMFDPC + 1 but used > instead of >=,
incorrectly accepting fdp_idx when it equals n (i.e. NUMFDPC + 1).

Also validate descriptor sizes while walking the list so dsze == 0 or a
descriptor past the log end cannot cause unbounded iteration or reads past
the buffer.

Fixes: 30b5f20bb2ddab013035399e5c7e6577da49320a ("nvme: register fdp parameters with the block layer")

Signed-off-by: liuxixin <gliuxen@gmail.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad..40e87b563 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2263,7 +2263,7 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	}
 
 	n = le16_to_cpu(h->numfdpc) + 1;
-	if (fdp_idx > n) {
+	if (fdp_idx >= n) {
 		dev_warn(ctrl->device, "FDP index:%d out of range:%d\n",
 			 fdp_idx, n);
 		/* Proceed without registering FDP streams */
@@ -2275,7 +2275,15 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	desc = log;
 	end = log + size - sizeof(*h);
 	for (i = 0; i < fdp_idx; i++) {
-		log += le16_to_cpu(desc->dsze);
+		u16 dsze = le16_to_cpu(desc->dsze);
+
+		if (!dsze || log + dsze > end) {
+			dev_warn(ctrl->device,
+				 "FDP invalid config descriptor at index %d\n", i);
+			ret = 0;
+			goto out;
+		}
+		log += dsze;
 		desc = log;
 		if (log >= end) {
 			dev_warn(ctrl->device,
-- 
2.43.0


