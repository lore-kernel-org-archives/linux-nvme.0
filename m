Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65513C98328
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 06:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XaC6DkyMRoZdb4oAVjU9pdXNfcIMayAmSL3fDY/VEnU=; b=ls7UWVlZHN4l4aMaJu8i76q6ZH
	UZQmNTCqQrXIPdAJ+YOvYFfze79XBv2a1LRZOmUwve2G7JWQKG5KvZl6qGGqGePA3cYYTgRbcc6BC
	P4tu1UGvBpAP+2UJ2EpGaqN3Ggs3N86FRt0CMERK54Zor6fEtIryOCDMehYrmkB/g0PWrUTVOLJ/t
	E//fwNY/2IElvXFngIDW1Tp3w0yh5lOdW9ry0aSj+i+Eg+/H8Rr9kuhzYWrb9Un9mV4dnXQhy80yg
	+FO2KUKm54oh7xZfSw0bO3RjjbPqY/9n/m5GvZMriadWoc4H/fzwKuX+VZY1nVdtqAu640/fRj1l/
	e4YkA1HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB4d9-0000000HR4V-3LFZ;
	Mon, 28 Sep 2026 06:14:27 +0000
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB4d5-0000000HR37-2G79
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 06:14:24 +0000
Received: by mail-pz2-x2b.google.com with SMTP id 41be03b00d2f7-cc794a06e5fso1152605a12.3
        for <linux-nvme@lists.infradead.org>; Sun, 27 Sep 2026 23:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576063; x=1791180863; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XaC6DkyMRoZdb4oAVjU9pdXNfcIMayAmSL3fDY/VEnU=;
        b=nrZIaGrYiVkTDxW3D8vMDD37sKyfh/tpJKuEg+EorhBGLLlvniCKyy9HwmtswLeXH6
         Cby4ruQZWBamfZF91WG9A9QIsT26F0nRRcJ4xxKHsQtoHgMeFKlsadTkV2VRo8ypLqOh
         acUouuEO+3ogTIYFC25CGDavurOhnySV+SweqADB7pcCXafmNoBnURR3tfAncfgCvZV/
         viZNEqtKLoxPZXEahjCgs1BiA86z1CM9/sKzzsbPy41TSsdgmAhMUyNNdAoMAXQHHok6
         xM9xbJt9NzqHmJGqPxdg0YzHnfUtVNmGG4W2DFxDvdLkekVgRfbbAfm+G3LNlkWdV5cu
         TmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576063; x=1791180863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XaC6DkyMRoZdb4oAVjU9pdXNfcIMayAmSL3fDY/VEnU=;
        b=IojjEOu+YP4s1ijHbNmqsd3DLqfa3wU/YnKAe9lt+Mk0Lcn8heqDbKY/iM/wLntOrD
         CdbF22kINkZ/hfYCwJnvJ42uS2/Zne5s4gtkrzUQKVbJIaJDYcBeS2gxYZTqBtZRicof
         epR/GRJOWpV3XOhuEkhGfqdec4H1f7diX9g1KT9pa6WdfM9t64c+QF6tnN6IsMFwJslk
         sMEPRTHs9nXf10HRp18nBse1vgBxz2inuYZvmMvOuDD6kQ2XOeOtvBZ1q+GKyyvMvt9I
         3sq/CEOmkJp/R1+zNj8wxG4FeGeR7enCESq5CgVHeq/cgZvLIH4cLRLhwuwku35qLUUJ
         6tgQ==
X-Forwarded-Encrypted: i=1; AKwUvBygsuerI3ksD6CdPhuOeIcbuXaYB+aNIt5baZdwmMFE9y1MFy7yQsUYqWTTsiXaxL35g9VmKwWF3T7g@lists.infradead.org
X-Gm-Message-State: AFq9FYJEIyRQ6rWWYhqqeFi5c5f+on97CIzVOPX/8khuwgg8MY+q74n2
	SG/yLcLNJbebq0hVqSI0Ge/UwHkJf6i+Zi4GgjGylOzfS9OeiTRaTqWb
X-Gm-Gg: AYBFou1GA+7HRzCNqHoo1sd5dQhhcjWJLMyDWrJDXbE5upgxSAjIXX54+NV9KD7uiAe
	eF1sRjznRWaXFS9Goo2Gl9hXuVtyJLIPpyl7+1dAl6p4ErPiQ27QPpGrZkwpkjNfzqf12NP/Jvq
	NcWlNXzJnaE3oCU4ae+g4Pk9VlknqEU7Yp7wbXw5qbOUVpPBOAl52N+sVu7LQZUriprYD1dF5DP
	0S67mkWjZoxI3HmMp2TyrEFJvdlaBytrsHiVQnvxjSjhOTJABi0+uvTnGDrxCOkQxwjk5D1RgAG
	qz4OUgyeSOaBLjwfJ6ZybiiCv2GWiz26LxuHSrW1rFxR7YbqJSWs5nIKRzW9fUnG1n7/gnjOoaA
	0NF+9JdiBdjjoA4MpbQ5T5g5vIvaBkbEhTDptvXeV8Wt6MuCD9RBqI4R3l7qDDUXxACwq2fXQcf
	SEDKyDua9NJvCQTa1Zlc3RWvnoR1La0GYOMZhGrvhmaEqakBOd1ajVA3jTRaQ+IVyxakInVhzxg
	T/ed1+ZkgiV+H2ItcHKebUGud4ZYdE/pYfkAMwBpnsMP4hZ92hHN8NPw27/U/oB8/bEul0sD/Kf
	VcU=
X-Received: by 2002:a17:90b:560f:b0:3a0:9aa4:f9bf with SMTP id 98e67ed59e1d1-3a0bb552f06mr6777589a91.12.1790576062923;
        Sun, 27 Sep 2026 23:14:22 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9892dbfsm18864088a91.11.2026.09.27.23.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:14:22 -0700 (PDT)
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
Subject: [PATCH v6 1/3] cgroup: track the effective css in each cgroup
Date: Sun, 27 Sep 2026 23:14:15 -0700
Message-ID: <20260928061417.1574676-2-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928061417.1574676-1-yupeng0921@gmail.com>
References: <20260928061417.1574676-1-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_231423_580709_C2AA6390 
X-CRM114-Status: GOOD (  17.53  )
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

Track the effective css in each cgroup and make cgroup_e_css() and
cgroup_get_e_css() use it. When a css is brought online or offline,
update the effective css of its cgroup and of all descendants.

Signed-off-by: Peng Yu <yupeng0921@gmail.com>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
---
 include/linux/cgroup-defs.h |  2 ++
 kernel/cgroup/cgroup.c      | 53 ++++++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 3754d697854b..5bbe6025fc77 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -555,6 +555,8 @@ struct cgroup {
 	/* Private pointers for each registered subsystem */
 	struct cgroup_subsys_state __rcu *subsys[CGROUP_SUBSYS_COUNT];
 
+	struct cgroup_subsys_state __rcu *e_css[CGROUP_SUBSYS_COUNT];
+
 	/*
 	 * Keep track of total number of dying CSSes at and below this cgroup.
 	 * Protected by cgroup_mutex.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2d532bf2c0c7..69b0f0cf2f3e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -548,20 +548,11 @@ static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
 struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 					 struct cgroup_subsys *ss)
 {
-	struct cgroup_subsys_state *css;
-
 	if (!CGROUP_HAS_SUBSYS_CONFIG)
 		return NULL;
 
-	do {
-		css = cgroup_css(cgrp, ss);
-
-		if (css)
-			return css;
-		cgrp = cgroup_parent(cgrp);
-	} while (cgrp);
-
-	return init_css_set.subsys[ss->id];
+	return rcu_dereference_check(cgrp->e_css[ss->id],
+				     lockdep_is_held(&cgroup_mutex));
 }
 
 /**
@@ -585,17 +576,10 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 
 	rcu_read_lock();
 
-	do {
-		css = cgroup_css(cgrp, ss);
-
-		if (css && css_tryget_online(css))
-			goto out_unlock;
-		cgrp = cgroup_parent(cgrp);
-	} while (cgrp);
+	css = cgroup_e_css(cgrp, ss);
+	while (!css_tryget_online(css))
+		css = cgroup_e_css(cgroup_parent(css->cgroup), ss);
 
-	css = init_css_set.subsys[ss->id];
-	css_get(css);
-out_unlock:
 	rcu_read_unlock();
 	return css;
 }
@@ -2131,12 +2115,17 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 {
 	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
+	struct cgroup_subsys *ss;
+	int ssid;
 
 	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
 
+	for_each_subsys(ss, ssid)
+		RCU_INIT_POINTER(cgrp->e_css[ssid], init_css_set.subsys[ssid]);
+
 	/* DYNMODS must be modified through cgroup_favor_dynmods() */
 	root->flags = ctx->flags & ~CGRP_ROOT_FAVOR_DYNMODS;
 	if (ctx->release_agent)
@@ -5856,6 +5845,22 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	BUG_ON(cgroup_css(cgrp, ss));
 }
 
+static void cgroup_update_e_css(struct cgroup *cgrp, struct cgroup_subsys *ss)
+{
+	struct cgroup_subsys_state *d_css;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	css_for_each_descendant_pre(d_css, &cgrp->self) {
+		struct cgroup *dsct = d_css->cgroup;
+		struct cgroup_subsys_state *css = cgroup_css(dsct, ss);
+
+		if (!css)
+			css = cgroup_e_css(cgroup_parent(dsct), ss);
+		rcu_assign_pointer(dsct->e_css[ss->id], css);
+	}
+}
+
 /* invoke ->css_online() on a new CSS and mark it online if successful */
 static int online_css(struct cgroup_subsys_state *css)
 {
@@ -5869,6 +5874,7 @@ static int online_css(struct cgroup_subsys_state *css)
 	if (!ret) {
 		css->flags |= CSS_ONLINE;
 		rcu_assign_pointer(css->cgroup->subsys[ss->id], css);
+		cgroup_update_e_css(css->cgroup, ss);
 
 		atomic_inc(&css->online_cnt);
 		if (css->parent) {
@@ -5895,6 +5901,7 @@ static void offline_css(struct cgroup_subsys_state *css)
 
 	css->flags &= ~CSS_ONLINE;
 	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
+	cgroup_update_e_css(css->cgroup, ss);
 
 	wake_up_all(&css->cgroup->offline_waitq);
 }
@@ -5966,6 +5973,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 {
 	struct cgroup_root *root = parent->root;
 	struct cgroup *cgrp, *tcgrp;
+	struct cgroup_subsys *ss;
 	struct kernfs_node *kn;
 	int i, level = parent->level + 1;
 	int ret;
@@ -6010,6 +6018,9 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp))
 		cgrp->ancestors[tcgrp->level] = tcgrp;
 
+	for_each_subsys(ss, i)
+		RCU_INIT_POINTER(cgrp->e_css[i], cgroup_e_css(parent, ss));
+
 	/*
 	 * New cgroup inherits effective freeze counter, and
 	 * if the parent has to be frozen, the child has too.
-- 
2.53.0


