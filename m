Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC19D609B8
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RSIHKTpy8icvDsa4C0bncAYt/fFFkTLxjGVcQzpyx0=; b=kiqDXCB56fQjTE2ZcwJRKsmLJM
	fxlghdejXhzJv7hT2VhqM6AsX0DONqlBbzWbRy1TKJCkNbJbtDpp9rFWAloj4kmvbAtR81eJMSvdL
	4kE17lT6OeQXVZaQ0vq+TBBdpS6p9KCIXsaxt4yJipUh7Go5MMarJgsp/Vw9D0o66pDCTHCylyGZE
	MBz6hSgMKT6E9pNy1iK93PLMyRI95nCxKi2KdGT2GK462cvFrqXr9blKsmrOGlAaZyLMOhDvR4HVW
	TzBZU3zYZx7b1nhu+eEW9TqdiRYBPMJrxtx21A4uik/cKCTasPpLTT6z5lMx2gVkgIS4KGANTpzyI
	MxOEb/rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmf-0000000CcRf-44jl;
	Wed, 27 Nov 2024 08:52:29 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmd-0000000CcPw-35Id
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 08:52:28 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so4843435a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 00:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697547; x=1733302347; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RSIHKTpy8icvDsa4C0bncAYt/fFFkTLxjGVcQzpyx0=;
        b=BxuQfNlqTjoklxnboGV0vUattcsaa/fkQ3X/Tq/OZXS1a/4rUSxepMSxnV2W+FWYo0
         chghBaBL6S4XPN9PypgTb6zAv+EmN1XQoUl461VaVqYlPOyUijvFX8VZTfJiZ6NJZwGn
         XMPc8J5M2KGj2KNZcLIQEH8ANpUuuDTYMKndMLG2Jo6u5v1a5VYISIJc+hVTIT+b7xuj
         h7cHI/+Pkc+sfI66Mi70NZnN9pMRTMGala1l0BW1YEI7npGQZCumHAFu3Ajk3SQe7afc
         SklHc+wxuNH402lxknrN6svOkQMKUk+pq4lJrZvBU0kwracsylgc/PFRCYC9jW7PSiD0
         N47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697547; x=1733302347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RSIHKTpy8icvDsa4C0bncAYt/fFFkTLxjGVcQzpyx0=;
        b=jTrQ8oppnXNy8054kOvQuTJ/A567QpQTspLZk/1xRkJOhmzz5rVfBgTxQEDQNb62iP
         16wfilOVu95WyUyQ+eLWu5KyMlIp3syUSAfj1lIa0Eoe7JzOxxAR2+YuppEgcsIYm3YV
         jzvkzAt3xf8dXUH7sfSxshpoA177cidIaOQ19sqMuF4lgLmLL+uAyPNOzCvpVQfn8e0F
         TN30QE/xRdEKNjE6/5zvC7SFwtsHhqrHGDNVCpJmPsIdl8OQiVOjUMuIbuz0bXNjDAq5
         rFE2+vW9Z/7r10QkR1ne97zVWBP7bx08ZQ1okdvZ0M3cm5gf8ENUPzbMPH+8EqhXP+IG
         k3fA==
X-Gm-Message-State: AOJu0Yw9j7WgQuve7veTu8zg7bLR6sTfxWwdS1j5rXMBoYL49h6whzhe
	cM8TA9PxZJwTnPEay5MCN9e5WufKqDwdd5kdvE2CVbpi/R/JJu7T
X-Gm-Gg: ASbGncsdUjpYMHAZqI/SQNjWjqHF4MSnMNKca+rvICR4JBSiEYLKCNEyBApVBj3ITCf
	bT0184Y3Z9kfdUH5HE4zt6DbLBctSFhkVblCCig+4MDgnyZwmm++Xq3PkTnxYZZNrYqGQ1a9RW1
	1Z+zfop+W2RjBaW8N49Wm4e81iFpl3nnaw4NGa7b5fkXoLGJKxQ+hcAwAG3mw23QamjEg0L8CWj
	RyazFWM9qAYgn53TGB935IP9Ipu59AX7teVRmBoVbM+bFFXuGfy69WhcbPW2w==
X-Google-Smtp-Source: AGHT+IFnDmXR5zcT1/Y9Mc2kxjwApnxXnOIz6wmA06+t0D7T3R5QzG3gdIfmwN80A+SWqMRjZsk87A==
X-Received: by 2002:a05:6a21:9986:b0:1d9:c615:944f with SMTP id adf61e73a8af0-1e0e0ac35b8mr3936370637.11.1732697546789;
        Wed, 27 Nov 2024 00:52:26 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:26 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
Date: Wed, 27 Nov 2024 17:27:49 +0800
Message-Id: <7e662471e392c6b45fc37de94139e886c53c9cdd.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732699313.git.chunguang.xu@shopee.com>
References: <cover.1732699313.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_005227_804243_2F27DF9A 
X-CRM114-Status: GOOD (  11.14  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

As we quiesec admin_q in nvme_tcp_teardown_admin_queue(), so we should no
need to quiesec it in nvme_tcp_reaardown_io_queues(), make things simple.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 55abfe5e1d25..98bf758dc6fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2178,7 +2178,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_quiesce_admin_queue(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.25.1


