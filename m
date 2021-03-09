Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872ECC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 00:53:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C20764F96
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 00:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C20764F96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u+ap2Y0QbQouAk1ZlBBmfMjUtaDL234YVQimUwqiHMs=; b=FCnAjUDJWHzpJg0kvioMBxxCi6
	DHp8aYkhEWBk0XspYiJZZhaDCe6MuzVFae6DVSCYoVuwizctKT9RL/eoiOViNIPMDFSvhIvKSuzVY
	htvS+dvcgjKM4fLulErBAXZ1DSjVdC20EguUcJX9bI6WMEA0bn8Pti8HZBLOZwvnFooGl9Va6319l
	xiKkEjpbqOU2fHFY3hndaMbGcR7Lj9deXR0W/bnEqqnZZyaZmjEP4wxiZMi6Vso6SG1GmEuqxInEK
	jspnvPUsSqhKmZ/2YRsoZjqowV8ipf+zBlE8ntFZk0i8HHaSeApxM1bKFT9I7G7mVBOHmDgAE0ghl
	pWrSOQCg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJQd1-003Xq4-3A; Tue, 09 Mar 2021 00:53:39 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJQay-003Xnt-Mq
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 00:53:36 +0000
Received: by mail-pf1-x432.google.com with SMTP id 18so8319965pfo.6
 for <linux-nvme@lists.infradead.org>; Mon, 08 Mar 2021 16:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1ksnBHcq8a191mL7cykc1zhhIaT0z+FlFZs1orBbPpo=;
 b=SEVrioc6CJijxj68aYqqGPqqqLIi73KcAX1c0bFlryrsieX7bpHNpfqHF/7Mo3uUr4
 fMvbWTMYQ1798PN8QzOuRmwnnd58/Tb4yrHzgxr9BOZVl5L0b3rV7QCT6zBObFxlkXyN
 7LRl/oXQjfCQ1EMz8CmcH/8dOQkYTgTCtqkrh676VK7Nws2qMZcirbkg4SC2QnvOF+Xl
 D+m+VjrhVLLy6BZ+LZdretjC64cDrlxbJ1zIXH3ubTJfTTvS+0gtiECSXkMq3WVrT/PO
 ci+UeLDOJa4MAGv83UrpQsLxmwiMcutgwzN5/Vk/tDNbmqkAFbk1ehdTmBmiQdxw5Tlo
 IYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1ksnBHcq8a191mL7cykc1zhhIaT0z+FlFZs1orBbPpo=;
 b=nXFkrG3mXxDnVVYlRRm6yoQz2ttNrPoK0khF9yDz7te/2ri4dOkjGclhuRyEvv4OyU
 MzPx76158hbs+cnklaMXu6No+3AtSVFc0GS9yzfzYNIgpdygiTBxDrSoos3p3Gy/7PGV
 WY/Rn/CogNdOnump5Ca0eVJCzD21Lue2JcENokdadbgzN5Pe50I4CpzyOujLTSqo53T9
 g+UyFExokxa0phmG124VQFprXfJlLiu5pStCUR92TvD1DgW4RgL5hvtGE9zYyUzUSTdj
 wUO+cpDgikc8HcKYETdS5Nf5PiKyBtUjH9tX/bk5B9POsLRoXEeCbSjcMJRKrcBqmdpt
 GDAg==
X-Gm-Message-State: AOAM532/m+UDWwEIV4X/J09S64qgek7PASg5UsUbAGKXA92e6HRbTysL
 FiT+ZCpRaH0dMAlj15NmC9sVgFYSDU4=
X-Google-Smtp-Source: ABdhPJx+yx3/zD5W7fmbRtu+0DdvGxB0etDkyCxIkW5P4GER+cfJhLfCsK7TOGanBsjrH1DI1OALfQ==
X-Received: by 2002:a62:1911:0:b029:1ed:b722:3b50 with SMTP id
 17-20020a6219110000b02901edb7223b50mr1254481pfz.70.1615251090428; 
 Mon, 08 Mar 2021 16:51:30 -0800 (PST)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id i25sm10632269pgb.33.2021.03.08.16.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 16:51:30 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: emilne@redhat.com, James Smart <jsmart2021@gmail.com>,
 stable@vger.kernel.org, Nigel Kirkland <nkirkland2304@gmail.com>
Subject: [PATCH v2] nvme-fc: fix racing controller reset and create association
Date: Mon,  8 Mar 2021 16:51:26 -0800
Message-Id: <20210309005126.58460-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_005332_927722_F8B710DC 
X-CRM114-Status: GOOD (  13.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Recent patch to prevent calling __nvme_fc_abort_outstanding_ios in
interrupt context results in a possible race condition. A controller
reset results in errored io completions, which schedules error
work. The change of error work to a work element allows it to fire
after the ctrl state transition to NVME_CTRL_CONNECTING, causing
any outstanding io (used to initialize the controller) to fail and
cause problems for connect_work.

Add a state check to only schedule error work if not in the RESETTING
state.

Fixes: 19fce0470f05 ("nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from interrupt context")
Cc: <stable@vger.kernel.org> # v5.10+

Signed-off-by: Nigel Kirkland <nkirkland2304@gmail.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v2: clean up typo in commit header
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 20dadd86e981..0f92bd12123e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2055,7 +2055,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc)
+	if (terminate_assoc && ctrl->ctrl.state != NVME_CTRL_RESETTING)
 		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
 }
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
