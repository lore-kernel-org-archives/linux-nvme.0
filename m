Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A619CCAC597
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BzYi9UrrMK3oiXPjdWgFJHAlZqk/pGJoUWmFK9K1t7k=; b=chqTE2mk2WZJzSu9laCV3r20yk
	oJrA2SODXkVpOiRl+o5r4Kf+NVk36zs8wOb8lTbYoX1Qt1iEu22CBhnvorkEvunsDEr1ikQKbjFNK
	c0UfLnZJaneorh05XhKWixjLZcn2hS5/qfrKi2b5Xrgc8pkQpTwomiddoW2oNzDLc3ypld0F7BZlh
	3w83+S746WeOkuVO1DdSLsPiPf6igooO17/70ZugpsfPA1vJJuU4eaqxTCrhVFeHwa79J68ojqE4P
	wiK0Z3crRMoOZEz3wr95Ca7CYj5dRNTTTfZLVDzLSZbfFsVSkHGJROxMw1d0r8pOyzCqP+DByBy+G
	j8uBMQUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7iI-00000003zxm-0X67;
	Mon, 15 Sep 2025 11:49:42 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7iF-00000003zwX-1LfL
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 11:49:40 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-32e64d54508so808862a91.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Sep 2025 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757936977; x=1758541777; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzYi9UrrMK3oiXPjdWgFJHAlZqk/pGJoUWmFK9K1t7k=;
        b=XODzsxL4VF0yF0955IYc7q1NN7fbNmEanoAJrp/yD5Bf67nkduw6KVgy5vKOtQkTfQ
         gaCLK6oGL2GiTp4BSjnzswlj3EZpNqORToxA2qLLVYPROE3IXzmaoUSg0QEZ6nRIkORg
         pujIn6SJ+yyMLVFsy6PQG0qRjg8Gc/0uJdfWL2bp7s+UKAqGEy4fnLDTq87ZGlFnZzjd
         I+TXnsSZBhRJKO4FqTmEruFQMfxXJP6aiWTmsKz9ojqO8nyHFVDxEETXMfnpAz1IM6RK
         jv1uHAeEdubq20b5UQofWE4HsSG7g/HGrHEs6bbDSF0QxjagGd2IX63vszf22V7EgA5e
         Ye3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936977; x=1758541777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzYi9UrrMK3oiXPjdWgFJHAlZqk/pGJoUWmFK9K1t7k=;
        b=Xr92MRIhvhkD22Wg6cU1M81zT/MNRWdMecnCibx/TfmK8lMANVKi7ZmixtCuwDsK8l
         0+dKbJM0+0nGvUCbDf6pCKXbqYwoTpDwmQupbhK99tQHN6Prx5S5PstoB9XIBbc1pehi
         DC9wH+DbfqOlmwyqD44LHXnAmBr+deXabb8dqIdHf0uZj8F7Fem7LWkhn4oscCJKJfX9
         xaGyOzjTj484fofln6Zm1LyJIlnZCfQdgUs0Xk1yoAA3gEvB27gQ5uA7+5ZeAmtkA1IK
         vHRrGFVws7DenNV+CZjjoIVt0d6tO87zPHM6xRQAtuhKlGtQV2uK3Xdw4lkDuYFCMYIR
         pNiw==
X-Gm-Message-State: AOJu0YwNpJy8qdwMcQwA3ECLfuBFbJhdg5lek7+N0hcJwtPfgJm6DBpT
	XWJlwn8wMkQFPAIv/NiFsXRcpesWafTuuLX7CsIw67svnrEG0YA+PS8qSnriDQ==
X-Gm-Gg: ASbGncsKxIX0z4N210/ILp+nOx9i/OLlzEdBj+QFsjKjWNmswLKoPIoM0YboTJQRAZI
	5YY2Qb4ndHr5mmBr4UAnvBsRube2QSrZUcUfJq1nh9Vy2350UnAxhzLTVT/4lhWfNs9NZivcLBc
	jl61TzOkeuzuXwfj3Sxl0/nC0cpHCdP/MaDIC+v8GniiNOnASksyySZ7yT9fl8CWPn4COwHVeDy
	Xqo0+Dzz+rudrG3ptY5pwBgdt2XlD9AxnZYY6qVH2k78uVpy80s6LTkA+gVyKDQcc2WvAHrdT2f
	PKW/0lm9iOjK9mZjp6z7o7pM3zianXhidL25eueJ2IBtibeUUjXYz/rWlDyXaZALhILvhUowNTw
	zkWl/y5Jx+vpPpxgeeVAS7d7P8YNwJEnGTmm86UiW+Lko
X-Google-Smtp-Source: AGHT+IFVTNOCZSXMvxA/0FApxZerUAEVLOEuFFVpTtNmxn6YRvm4W7SE1+2BOZzH8KZ6CA0k3VWoyA==
X-Received: by 2002:a17:90b:4e84:b0:32b:8466:a66d with SMTP id 98e67ed59e1d1-32de4f8c826mr14386278a91.28.1757936977621;
        Mon, 15 Sep 2025 04:49:37 -0700 (PDT)
Received: from gooner.vpn.netapp.com ([202.3.121.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b18366sm13223011b3a.53.2025.09.15.04.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:49:37 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@kernel.org,
	Martin George <marting@netapp.com>
Subject: [PATCH] nvme-auth: update bi_directional flag
Date: Mon, 15 Sep 2025 17:19:21 +0530
Message-ID: <20250915114921.4715-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_044939_357596_18E71A8C 
X-CRM114-Status: GOOD (  13.07  )
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

While setting chap->s2 to zero as part of secure channel
concatenation, the host missed out to disable the bi_directional
flag to indicate that controller authentication is not requested.
Fix the same.

Fixes: e88a7595b57f ("nvme-tcp: request secure channel concatenation")
Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/auth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 201fc8809a62..012fcfc79a73 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -331,9 +331,10 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	} else {
 		memset(chap->c2, 0, chap->hash_len);
 	}
-	if (ctrl->opts->concat)
+	if (ctrl->opts->concat) {
 		chap->s2 = 0;
-	else
+		chap->bi_directional = false;
+	} else
 		chap->s2 = nvme_auth_get_seqnum();
 	data->seqnum = cpu_to_le32(chap->s2);
 	if (chap->host_key_len) {
-- 
2.43.0


