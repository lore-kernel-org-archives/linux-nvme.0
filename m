Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41ABC54E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 19:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IUcbpgXT14ijwo0i0o66tU/rwBo9RUA5TlAkXg/6+sk=; b=G/6SGy7kd2HD+za7M8s3I8UmP/
	WqLtGyiCbxF71pAbhDVXdzwYO0xyiAHziwZsaaZbyeTBjXNi1deya8LcBxkRZytJIFqetT57qjiLG
	A+KWEUzNw/XIxXB7WJYnl8LHLsqP4rGFCTHHwg0rWezozX3p6pWDKgfwQrjm9ThPuMqQoHa5fwq0S
	gY/aN2wzhQx8JOXx/4fx5VjoQ1xVubtmOH63ZnyeP6/5WxsDlqX8FjNHLMK5ezGLQsX9sMNwbJIso
	0MvnUERJ1vWBKJoohzVrVcP0lgee6lUqzUI70UotUVXcDa2BMJsXjr17wN2QlmYO9YuS8qVb3CKMR
	lHNtWLJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riJG5-000000062Pg-2V4X;
	Thu, 07 Mar 2024 19:18:25 +0000
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riJG2-000000062P5-2caM
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 19:18:24 +0000
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-78833eb8fe5so191898985a.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 11:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709839101; x=1710443901; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IUcbpgXT14ijwo0i0o66tU/rwBo9RUA5TlAkXg/6+sk=;
        b=crcUrEAsEfu/1Zqi+tsozhx7QovAk+in94589tLDbE7b7L/Crt55O0+edYEK3wTOo2
         bUhRoqQCxnf/K96FXvCWmPE1E1xfJ1zfWqG0CXZ1yR6/sfCaqFoMo8wb7Sh3vPSosohF
         BbnJh0cIunroiVPgECD8qs5wo9ZqWjJGcZmm9aXUC8KfMPwXpghcnNiLByZtdVlZQy3m
         cw3SvxsnYsQxyFECp2/I7FJg/4iznhiLz92qWOuzuYK9W8277NP4yUdh+JkwDd39+2Z/
         J+vfGpm8KrTECV5eZvpiATnCOZ8jYGgPNNWKQhgBw0dGYwJf2GmtCEx2lgGMyShZV+TP
         FZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839101; x=1710443901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUcbpgXT14ijwo0i0o66tU/rwBo9RUA5TlAkXg/6+sk=;
        b=ljtfaypJJfQ0fJbjuvyQwBhYTVEQCGFmijVgaK6xZ8dQGXm4plFabwMv/FhoPsgrWB
         572ErydqZ/NgyjSiVJFAy8/Umn76kTncZBJT4lGnjq+VI1ffZRA6L89J9B151hXO2uIA
         8N9QvexF2HKBr1Um/T5z5ryZU1oZeH18+V1ICn34lsJUKG7u4o1x0quHrpO1F19tPmOq
         4m9GRaiC0YiKcaLEAaSRQBIdy8eHaxAEidVpunTz6DpM+cK/xgXI4GbSHvLxT3CLb5WS
         SLqluNEJ7uObGEjKf69y0ygt8CK9cCG4jDN7LlnXbKeaLjERXEYG+ZUVs0vdDywTW7S/
         kI7w==
X-Forwarded-Encrypted: i=1; AJvYcCVwGuWEH9MRb5cU9hCkTJVgz7nSiiKmQCEImskSAdfkIOSHOc7vCga/ZEt37bhAom8LtjI33PgfQUsWwuT2RXsK53AcNlicYmYalw5vxYs=
X-Gm-Message-State: AOJu0YyTN5+1ORG/OnMTryUKZFe5ewo7SzCK+vdQguEYsqGReHikloVu
	0evO3A6YXYY7MZlPQv0cWUgmdbMaSPIeql3qWIVXI6FP9cMc2aZG
X-Google-Smtp-Source: AGHT+IF9MeM1ABWvNmsZcRe8ULj3hdGLeMEL7M/i4Bz+23B6tNjVwKln114k4+Ax/Fy+ojLQcCs7yA==
X-Received: by 2002:ad4:4f14:0:b0:690:ad27:bc77 with SMTP id fb20-20020ad44f14000000b00690ad27bc77mr2212712qvb.28.1709839100861;
        Thu, 07 Mar 2024 11:18:20 -0800 (PST)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-d46e-8590-8b01-6ff9.inf6.spectrum.com. [2603:9000:9f01:67cf:d46e:8590:8b01:6ff9])
        by smtp.gmail.com with ESMTPSA id jh19-20020a0562141fd300b0068fef023e6esm9042555qvb.88.2024.03.07.11.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:18:20 -0800 (PST)
From: Len Brown <lenb@kernel.org>
To: kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: [PATCH] nvme: Re-word D3 Entry Latency message
Date: Thu,  7 Mar 2024 14:17:34 -0500
Message-Id: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_111822_793879_CF2CD446 
X-CRM114-Status: GOOD (  12.07  )
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

From: Len Brown <len.brown@intel.com>

Some words are alarming in routine kernel messages.
"timeout" is one of them, so avoid using it.

Fixes: 1a3838d732ea ("nvme: modify the debug level for setting shutdown timeout")

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..2601dc1c4f42 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3206,7 +3206,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 		if (ctrl->shutdown_timeout != shutdown_timeout)
 			dev_info(ctrl->device,
-				 "Shutdown timeout set to %u seconds\n",
+				 "D3 entry latency set to %u seconds\n",
 				 ctrl->shutdown_timeout);
 	} else
 		ctrl->shutdown_timeout = shutdown_timeout;
-- 
2.40.1


