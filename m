Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807AFC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:01:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B0A64E12
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B0A64E12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZMm/jBYNepDvJmU7COJuIf1SPBI1rOMYlFOEImYQ1M=; b=Kf1uxvBa6lj/RNhauRl2a3wEWU
	U1od3MxqakETzO/OmaYfGuN8EaR9406VyDL8YuzSn+DUBE9C19nhlQJtOiWj7umNDPEg+inzpr9eo
	HDuK9MYklWAvhP6hpU4FdmeWE8VZIYD8vF7cdhIbQjTXUy5V6vrbTEYcck0W5AFw8FWbf20QqMXIp
	pHsbdAKGe9xTZMhvwr43QrTJiBwmH51gaX30JUUMi5IZ34K+oQ3WxpWVsLYk3GyHCF3+q4yYt7/oz
	3A7Ec/INUgLfJhji/ouQwTORRaNU+b+7uRvoYsbcneTgejNasfM+XnQP/zhAJxRovGC1E2gUvkjfB
	JMEXMtDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEGSP-00063M-Lj; Mon, 22 Feb 2021 19:01:21 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEGSJ-00061n-0z
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 19:01:17 +0000
Received: by mail-ej1-x629.google.com with SMTP id lu16so30992944ejb.9
 for <linux-nvme@lists.infradead.org>; Mon, 22 Feb 2021 11:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BMVnVWbgA3Vc7YyOK5ql/rQggQNVPkXpg0QebYCGCmA=;
 b=S9GIbuLT8fULLS2cH7TQ6ZZTtgEQroFUNl6mlhzyxW7m7q7N53xc1vd7xRo8zhVTLw
 1tJohJ4stukFwIFPk0d/x//RagpPWVUoIwF7F0IMdtVY54PFTJkbKm8yqkdA/4biGjJP
 hVmIaB0DXjsPZLMe//rSYj3pCks8yf6tQmAXUKpHjYjvY8xahQ8jKY+ngA3Q5XyuFDIV
 c3ld2/VhBduQa0AHxdQDDpMLcwxk5SVY9RzkajukSdxHP13ovMEaoIhNdNsa7UoFyzYw
 vTEiMU1lcasrfkii8qZeh81w53QIDheojHjPBUZf8VU1ZsHhzYUHZzrRXu2KeVO/8BGG
 ccMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BMVnVWbgA3Vc7YyOK5ql/rQggQNVPkXpg0QebYCGCmA=;
 b=nbqnFFeWzjhLFjkLJuvChMIl2WZMcI12wAOqOWuucVtWL+0fTABKXS0K8Utth/XzNV
 grq5OQzPpU9VmjU0kcFRE3G7gK1YgchaSuM0mvAOh70gxbs6aTy+dn1J+ahBEHIvHOYQ
 bG40B7w0uDgSQk0zVG7E2AzsMaLI8idkHXvYsEcTXpCe8lTiOb9fLi8quPok44mEXID9
 8cTYQorij6cLWf0ERbc/eIczNe2O9b/cPDe0qpaY1uLitrPvPej6fEvbTjANTk/ZeuDw
 xK3cgMZMjcbUTL9SmBRD1RtTEdcuYohdW/IV4ZSl7cCxzGCPNo+tDNrLhikaM4iRC3KF
 7OWw==
X-Gm-Message-State: AOAM533C+qRHGpKf44B/Qu22341OSez/Cj/UpNERwNWUkLoWRaPeiuvI
 pnw+FIIlyZ1yT+QgwTQc27lTtYeWAz91OFiH3TY=
X-Google-Smtp-Source: ABdhPJw4WH+Mftr3Ggam0OCESHx1erRSnVtWm5h7BV63+LF66xGqvZP+PfrCNcTRcJr/ke+/xFeIVA==
X-Received: by 2002:a17:906:6942:: with SMTP id
 c2mr7313906ejs.425.1614020472153; 
 Mon, 22 Feb 2021 11:01:12 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id d23sm9204528ejw.109.2021.02.22.11.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 11:01:11 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 2/2] nvme: allow open for nvme-generic char device
Date: Mon, 22 Feb 2021 20:01:07 +0100
Message-Id: <20210222190107.8479-3-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222190107.8479-1-javier.gonz@samsung.com>
References: <20210222190107.8479-1-javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_140115_486743_73C6FB0F 
X-CRM114-Status: GOOD (  14.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, minwoo.im.dev@gmail.com,
 hch@lst.de, sagi@grimberg.me
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Minwoo Im <minwoo.im.dev@gmail.com>

Keep rejecting the hidden device access via open, but allow cases
through the nvme-generic char device.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4884105ad95..0d0522bd4c2f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1885,7 +1885,7 @@ static int nvme_ns_open(struct nvme_ns *ns)
 {
 #ifdef CONFIG_NVME_MULTIPATH
 	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(ns->head->disk))
+	if (WARN_ON_ONCE(!nvme_ns_is_generic(ns) && ns->head->disk))
 		goto fail;
 #endif
 	if (!kref_get_unless_zero(&ns->kref))
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
