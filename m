Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CCCC98328
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Sep 2026 06:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Qh3I8a6NY8irFKYYs5frRNlHo7TF6xowJJxcHvbgDM=; b=UTorsLOmc2+hj1OLKrfhBSFQra
	P1e7vq/pntJsYpxjAcRfm88oB2SJQlpm1WBw8Z0IvGYzbho/+sqgULvnp8VaRWm9WkKg5CQU14ZJP
	AHMM7BYqphP1Qp4ov7Aft09rRadZOWkOsoFWUbKSQRq1u1JKMfR4N/H1hSZNO5nxyAwIv/WfQPvp3
	LbqmThxvBnTVK7l6Hrw7bW396MbeTfHYIaDOW5uDfIeXPLvLqLQeOS7L7oCfX3vpnfrMrBkYCgcUe
	nw6txjohaZyeNcMOx/bppuiNthinDSxdHMqxzJkrnK/alPrHoh+fm4roFKoHfBzDQlAuu8pheFwNn
	VxtN13VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xALye-0000000F4t6-3zpX;
	Sat, 26 Sep 2026 06:33:40 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xALyb-0000000F4re-0VCL
	for linux-nvme@lists.infradead.org;
	Sat, 26 Sep 2026 06:33:38 +0000
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d91c22d27dso5010835ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 25 Sep 2026 23:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790404416; x=1791009216; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Qh3I8a6NY8irFKYYs5frRNlHo7TF6xowJJxcHvbgDM=;
        b=jP3CkCfwkf9QrmwceQWg2Nc+yartpN5g00yZSoOmQXuXVEoOIJR75H5H1fmRxwXZv/
         n+nhI9XN2XIniSYq0/ol+sHmorbvYqqlx1DfI/+LyqFExj8s9vwtwhJy7UHrf9+268sb
         3oSwcGmI2xSn4foQaNQfXD71V+0bgVEfl+Wzk9bVmEtRluZ25GAaDRlvDGpekJWzgbAz
         iR2cF+kq+q68KLE+locXX9Pt1RkRSKPGywSGg0qe4IEB9cs2vXFDGSvB0UQCK0GbA5MQ
         W+Cm948FBvZJ3cH+jgNNEaP+DuxZK71SjClDOynCzqW0OEvM/vqOy5t6B1yNo5bT9+bY
         Vbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404416; x=1791009216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Qh3I8a6NY8irFKYYs5frRNlHo7TF6xowJJxcHvbgDM=;
        b=J7bNu8krOdgCE4TBdMwTewhr87rQ+6Hq/tob8zP8H2d0xED/65q90dDtXd+/fAO0Nq
         +8ZgmL+gjIdeJdlJNtZVcalqfGpvCbt/aYAWkmzsBtS7//E9Xux+QTaq3eIE2Tsr8v3O
         x0AIo4J8eHmWdca0ikQnIIRA0jLVe4jPGVcCaP7s8MS5xrPtcLCOJp68tMNVB6Dfa1RG
         4jOYMMB1OIY+1r7OUkdVL22UIypIR+TokUy9rc2OwDVAG/IfLuwLcPDlsedI6XTiJKg1
         rizd60QVkYiX2+CrXQgGZs37Ud+mMxu1fc+OZDR3FVFytG0/i48uaaZZKHXeXUc6z0Vt
         +7qA==
X-Forwarded-Encrypted: i=1; AKwUvByFZJ8B4DsVtVinYVCAHwe+rXAZzp4yHC0HZqBcbEpZcNsmQHQUR4GrU/7gptN93+RPMD86EcCpbqvy@lists.infradead.org
X-Gm-Message-State: AFq9FYKwfSQuQIg0XBzrAomYl6tkKMQTASfSusOgg96oWgp5Pn6ExwQ2
	db+6zpsR3XV3FPLrVvOQ+qf+mDC7ZQG0JNJZMQ4+YnT6lwvNHxBrf364
X-Gm-Gg: AYBFou0xMaufrU2C3oJDWC1/Df0kYwxox+h/9zcC1P9+QdV23yyDuOZpyaET0Ss36l+
	MKMuGsGPMDA7qcPmSp+z7EmKB4OMZO5nUILrni/eB+eKJzguN9T8eozeqQOGMLgBmFFB3tbMupZ
	zddT2ilxGLlStFUHlrlJ8HnCojHMBWiOod29xY637A3BOWc0aoJ6PRUEIgHwjnQsmMToowVatz+
	ehKJ0itRYC9XVyAJGIzKktstEda1F1KAcC2DhZeasoto06pWK+xT3WwM8YJ5k/GBoPLMC6pTqkk
	p9HD0/q1owg1fupgm8KYDIZ90hVgGjz1swRQ6SpMDySRqiBWPS1oMCrrnd8UYgag6N6pmBxDlgl
	MIR5g78oRAmY+ni1Wm1oQ2frwqnGalNv9sc46jbIZMVjTt0QZ+2xT8qU9FlWJxTsN2BE8XWrYEN
	HmDXXPW7dbtBmX0YMSdLBh4fY+aRoJrvzcStl86UV+p/+z2J5bQwsP5oGJn7HmdVfDDdJ18TbWP
	cj686gtY613fJyRKAYLr1sXobOuDR8WAz3v/M/spIlLnjpcB0pTYbgvvnse6ug0I66jvsbZjU5c
	wuY=
X-Received: by 2002:a17:902:f64c:b0:2df:9eb0:760d with SMTP id d9443c01a7336-2df9eb07af8mr20882645ad.61.1790404416418;
        Fri, 25 Sep 2026 23:33:36 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91460aaasm19196895ad.73.2026.09.25.23.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:33:35 -0700 (PDT)
From: Peng Yu <yupeng0921@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Yu <yupeng0921@gmail.com>
Subject: [PATCH v5 1/2] cgroup: export cgroup_e_css()
Date: Fri, 25 Sep 2026 23:33:27 -0700
Message-ID: <20260926063328.257023-2-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926063328.257023-1-yupeng0921@gmail.com>
References: <20260926063328.257023-1-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_233337_167912_024BE716 
X-CRM114-Status: UNSURE (   8.36  )
X-CRM114-Notice: Please train this message.
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

The nvmet invokes the cgroup_e_css for each bio and under
the rcu protection.

Signed-off-by: Peng Yu <yupeng0921@gmail.com>
---
 kernel/cgroup/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2d532bf2c0c7..2cb0f1355c05 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -563,6 +563,7 @@ struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 
 	return init_css_set.subsys[ss->id];
 }
+EXPORT_SYMBOL_GPL(cgroup_e_css);
 
 /**
  * cgroup_get_e_css - get a cgroup's effective css for the specified subsystem
-- 
2.53.0


