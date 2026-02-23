Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2F7E98E15
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 10:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQ8IZEw2bB4rRelBG9i/t9o3cIiKHGPboX690VT2QzA=; b=KY2HvmLP7fF4A3hW0665zrKmFc
	xNocYRuouAvqyNzCDv0yVN0wGco7+vaZJ94u8+scupoRf5vqrIGnwfIbhEjtF8opxjy2P+5mx4CpH
	lwrNxwCVFVGKDvpaYojZjOZf49dLzbI4Rvj5Ipd0fkxu85ywDq0GgWfcGDYck1xj2V3NrYsnoCgJO
	ETEvX2GxzvjDtUKEmOyvlXun8c3AvTlJexgKS7AOBztzQ7yonqajNzQY4XITDkcwmTi1pQpXYXcjo
	uCR5lhcLuqv+8kqLGK/cs9OExoTUUk2LOkunBH8fEA12MdUC/w68A4sb0ttE2AhCxVq+NU1wWIfK6
	z9ec31TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuT6V-0000000031j-2h8i;
	Mon, 23 Feb 2026 10:23:51 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuT6R-000000002ze-3cuu
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 10:23:49 +0000
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-4834826e555so39872005e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 02:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771842226; x=1772447026; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ8IZEw2bB4rRelBG9i/t9o3cIiKHGPboX690VT2QzA=;
        b=egH3mtwSeUFYk0eZ5wy0p3jC9UBw08JgTcPzMXs/+zJwjHAkuiNDLdqwFFkeFRWMcX
         MqMfL6GC+vxxzxtUF4kw+Mg3UnwxoUNEL1pcYZzDQPKtrk6G9nyd6J+U17ax/fyp4YYI
         wB8MVNeuA2tkMLwn1wFhpoD5ECecgCDjvv2Vs+KPbNzJU7k6BbvlpXTITLwAOYKHXrF8
         dtbGnSM0kbhmMiU6WvNN5MP9/0b4AVcuzBiqngJMHVEvuyBRiLbP3llYOdMYlTE14vIv
         KoAGqwgJVdMFFqSG2jZ3yS9Da5GHBrd+1xFyc3CEIFBC6USAxB7IOwsaqsRoj+Jog+As
         wV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771842226; x=1772447026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQ8IZEw2bB4rRelBG9i/t9o3cIiKHGPboX690VT2QzA=;
        b=LaHPDN1vhN+64caxhXNwEr2PAIeNnzTr1tUYIC0VidfvL9V9BDTUHZdCXsj3BO7GQJ
         igl4vBN0ZcpRhAUlntt64GDN1/7pEljp62MyN2QpU1eDxh848WPIL/wcipYQNxNl5gmD
         V8YV56va6dMSH0p4UDsSD7HDkJBoVTIjolO3VjXqgY6npbKzJSgPDiU/jyi0UOrt9Xdc
         XpdEFofwNg45VnbjM7RuBLgUow04zMiePPMIbK4NZyKLs0wJ4HF7FYXzAKScbWTzdnTB
         x5NGo0+fviKaKH9SSQBEKSitCTsxYXfQb1Gcp+iE3TKkUhkHL6gEzhSbZu9jvoi/mk/E
         /Bfg==
X-Forwarded-Encrypted: i=1; AJvYcCX9GUNPvqcJIE2NX68MeeGAQaS//P0mEmEWhwhnLFATO91jyrcA1wqyKV3qV4mg9fGnky5KR9wfyYGh@lists.infradead.org
X-Gm-Message-State: AOJu0Ywgvsdl+eCr/+H60I+PWWsxUik6gM2P/KNCWfbeBbXffFS20J8Z
	BIQFirKBODk7pl8KKbl3X7MarUP/G14r/H5EacAdxQNVzcc5dQNVii4IFGiTI8kBF7w=
X-Gm-Gg: AZuq6aJhhQ/n81dIkl/jiUf1URVaqll56rk/SIsLVcySswdfrqWL7AFlHr8hfc9LjGm
	Ok2ttEq1ivR0dnNN4GFuxUivZoctM/jpasK/Y/FU+tNDbH5kGz4QbGRi/OekHvlHzWezngvP07e
	jwtMnF/vJ86FCr3VT4NbFfVjNC1Xo6ukO/G8C4h+KprXv9Tv2ksoRFXEAYghQvJ+wkzNJfaGexP
	NN87wtqY9qN7JKCKECklNhyMzu2ExZlIxeXhNwHgD3YtPUfJ6PUdGpr9Z36F0aV6UTO4X6npYb1
	03FTry2380WbmzYfFD+8T7vRWoAatsBV3gjLugw1ZoMdWnz/eknUEL5SkMdt5Wv2QE65Ep+V2Iy
	K0NCoqA4zODCdmG/E6Nekk47wql1R7LdFOGqm9t/o2USkEWMlKRplO3ZK98uRoHOCIV6MFhppL3
	hTADumMADLfDjV4UShJqIxEXE8H0oFpO41ScUu7OJgMKRm
X-Received: by 2002:a05:600c:3e05:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-483a9636692mr117427825e9.23.1771842225872;
        Mon, 23 Feb 2026 02:23:45 -0800 (PST)
Received: from linux.fritz.box.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm237342465e9.5.2026.02.23.02.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:23:45 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 2/3] nvme: add WQ_PERCPU to alloc_workqueue users
Date: Mon, 23 Feb 2026 11:23:28 +0100
Message-ID: <20260223102336.108512-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223102336.108512-1-marco.crivellari@suse.com>
References: <20260223102336.108512-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_022347_917831_D7AAD954 
X-CRM114-Status: GOOD (  13.80  )
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

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvme/target/core.c | 5 +++--
 drivers/nvme/target/tcp.c  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5e43d0acc86e..376d38b62da2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1942,12 +1942,13 @@ static int __init nvmet_init(void)
 	if (!nvmet_bvec_cache)
 		return -ENOMEM;
 
-	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
+	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM | WQ_PERCPU,
+				 0);
 	if (!zbd_wq)
 		goto out_destroy_bvec_cache;
 
 	buffered_io_wq = alloc_workqueue("nvmet-buffered-io-wq",
-			WQ_MEM_RECLAIM, 0);
+			WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!buffered_io_wq)
 		goto out_free_zbd_work_queue;
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..4b8b02341ddc 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2225,7 +2225,7 @@ static int __init nvmet_tcp_init(void)
 	int ret;
 
 	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.52.0


