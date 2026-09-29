Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D883CA5FB1
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 23:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LqO5rqFvyRue6UM+wZoeSHLBr6tsHYDgvKbTW7jcYak=; b=1dL60FCsKH4F2x6H2DjOT2rb1Y
	6Fbact28y531YgwF9gfZp5kOMask208KbPlj5YGDQo8uXnLwG2Uw65Nyl7fbmy5NvQl8nt51z9LPh
	cktwtqIcNzut2096ipfEX3Ycr2GYeRRMfyug5ebE/ptDJgz7GVaXH2m043gmajl+L4ISFcMuK6BIx
	CGGMtnXeg+7sTpWMLCy2M8was0XpLDPLPHiGX8M3rwfJn58yUSIls/LdfwzikXmBqH2RCk99FkmLO
	jJy/wdSsbCT8vfJmJJQaebmDMuLXXeG+Uc7p7rhn0jd6y0bRtkRSmarGkXPmpBWZ1qePxtvgwxKLK
	okHig+vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBhBS-00000004kkO-0zWN;
	Tue, 29 Sep 2026 23:24:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBhBQ-00000004kjS-1TlS
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Sep 2026 23:24:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LqO5rqFvyRue6UM+wZoeSHLBr6tsHYDgvKbTW7jcYak=; b=MhrM2dQOCyaCjM491f02rNiBxy
	BE/KtHNNzGGsaYiQZg8DZD9XKYKFn05yuWKrOjYFa28m6iIAAeqK2zt2Sjq6RkJ+D+E7T+RobqSSw
	xdUtNY9DWmOMKuVL7vbxD1J1aQMqgB7QWXlry3gW2T96pgcD1EdIXKcmskKurzg3+MWCIOZlElEux
	SjYRGFrtHBRKK0aPtmesI66uzPUHu6jCMO6Cs4MkW6GQiq6mO84O6STs3kg5oj+CxaCsBQP+g9kmw
	ivgUNS5hgMXbHeaJRZveuB5N5nHdvXyGb3mxtEWqavJ6Pb6uTVXvJqaG7dFElvDDiPoICyny3Ov0k
	4s9+3ADA==;
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBhBN-00000003Ab6-0f4Q
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 23:24:23 +0000
Received: by mail-pz2-x29.google.com with SMTP id 41be03b00d2f7-cc7cadbe09dso430577a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2026 16:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724258; x=1791329058; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqO5rqFvyRue6UM+wZoeSHLBr6tsHYDgvKbTW7jcYak=;
        b=jzdcGq9RUxPhJk+GzqbS2Mdul0suq166mJzAxulbutx9C7TWwPWn9RVT675EBHyb18
         7goKh5fgFuFzBq0BBPqA4RAXVh/1imbRJLcb0iGU5kwgY+LAq+r7bLLf4S9DXTCC4oCS
         fIGJzB+Jehqh2qmVNnfvsAy2Do0Zgjs2A+Dlr51q66YDUQ794R9VKKEpSVmn9k0qjY8S
         2JxBqwwQ+4T7Sbdsr04vkI6LdNF+TlVxIbGjYOMf0aIiQH9lF27D2tZRCwwsAWKgg4F3
         nRM00sKuEEbEqltK7xamWXikWv2rfplhtTgdWOzG/dxO0CUOwRPgkrv0SVAaK+EieG+/
         KijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724258; x=1791329058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LqO5rqFvyRue6UM+wZoeSHLBr6tsHYDgvKbTW7jcYak=;
        b=g05dFtTzDULfZzgWe2Mnz6QkskAICopnWkAYhRUkc6FmmqaT/jE0KmcZ13lrf38og1
         CRUXidRrRk9NLEeP0GQDYnGmjOkGxZX4Jd97i8VDZImjpalGtnMJWr8VQwmMGI8Y4zVu
         reLo1+vRVroOiUq8osT0XX5g82hsc4ZzrqukC6e+4E6GFDfdgqO/HrS9N6B0Qjn6OlD2
         WlZObh1srFGJ2Wde12b3I2tJp9Yk8RFiVCUkfNSYzpWL2v00O3m81xVEttMLHCYRrQ3l
         aN4qIbNNHxMzNKA6rTlg7VKif2X2iBsx0agjMeSK2C+plsO8jpzUhcvYSnmOCQz5P41p
         o0lQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAdE1UR1hxsiDImko5aN/j2WGnyLnQaBzmRSuAuIKTm4WYmknjXGzO3lRiHiGO0zz4X6AK1lf1eDQW@lists.infradead.org
X-Gm-Message-State: AFq9FYIlvV9hDzzRng60fG4Mv6xPjRPCgDnN+BA6oVmCNJ9ECPAw6j60
	55x4K3aSd4T68eGOqkTlMSO54snN005dNKSzQtDNeprkpGHIgz4wb8VH
X-Gm-Gg: AYBFou06/esI5zUEekJLYQMp2yaV90c91ASRSV/G9xeRa/jh26kf7Jd8jyJfQ+4jSj0
	wwWOqrn5WCco4mh6BvPSUg60Dqg/E+M9FX9t/VdK8/HsSNoaUIBpbcjtZ3uo/8o5sgUbH5p1bPD
	B5fmHYW8vigayVBnEEO/myZV3kfcdePl1k0FC+0w0oWGRoCKOQ00WAbDb0gjtXZF4SCCdAlKo+k
	bKjU3tCM8bhkpoeomhAKIflNWTYR0A4HfTyGRtNbRmdBYjpL11U6+AzovZsjh4S2Q2llU8yZ2Qu
	W6s+b9dYBGD885XeyoE9gQuBsm/qKYTvpS72DO0tkvtz7DwS/oUYpkWUsiz/mGOrA/cwJ+4AqYM
	QlyhAQqBlnCA+ZOzBS4tTmvQhqz54VvTpYopQajYgsNemNtNmikwvaFutqvvHFXVK0VSug0wqX6
	vp8O4LHXr0mQTidBQfVl5ubT09zyEQQNSC46TcKZE/QUBgLQlHuUA+zHAAL6gZVyiskmXYG0vLz
	Ln47WP473MjEDPOyQnyZaGmfPmucQLY+ZtXC3V+fq75qAQDSpnTdv3b4hDeb3XfQnQzWiw4wlhH
	aGE=
X-Received: by 2002:a17:90a:d448:b0:3a2:b036:ed62 with SMTP id 98e67ed59e1d1-3a4bff0ef48mr451780a91.37.1790724258206;
        Tue, 29 Sep 2026 16:24:18 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca78102csm138700a91.4.2026.09.29.16.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:24:17 -0700 (PDT)
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
Subject: [PATCH v7 1/2] cgroup: track the effective css in each cgroup
Date: Tue, 29 Sep 2026 16:24:10 -0700
Message-ID: <20260929232411.101087-2-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929232411.101087-1-yupeng0921@gmail.com>
References: <20260929232411.101087-1-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_002421_457589_96C40FF3 
X-CRM114-Status: GOOD (  23.09  )
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

cgroup_e_css() and cgroup_get_e_css() find the effective css by walking
up the hierarchy until they reach a cgroup that has the subsystem
enabled. Per-I/O users such as nvmet need this lookup to be O(1).

Track the effective css in each cgroup and make cgroup_e_css() and
cgroup_get_e_css() use it. When a css is brought online or offline,
update the effective css of its cgroup and of all descendants.

Signed-off-by: Peng Yu <yupeng0921@gmail.com>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
---
 include/linux/cgroup-defs.h |  8 +++++
 kernel/cgroup/cgroup.c      | 60 ++++++++++++++++++++++++-------------
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 3754d697854b..cbfe8937647c 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -555,6 +555,14 @@ struct cgroup {
 	/* Private pointers for each registered subsystem */
 	struct cgroup_subsys_state __rcu *subsys[CGROUP_SUBSYS_COUNT];
 
+	/*
+	 * Effective css for each subsystem: the css of the nearest ancestor,
+	 * including this cgroup, that has the subsystem enabled, or the root
+	 * css if the subsystem isn't bound to this hierarchy. Updated under
+	 * cgroup_mutex and read under RCU.
+	 */
+	struct cgroup_subsys_state __rcu *e_css[CGROUP_SUBSYS_COUNT];
+
 	/*
 	 * Keep track of total number of dying CSSes at and below this cgroup.
 	 * Protected by cgroup_mutex.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2d532bf2c0c7..54b207d246bd 100644
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
@@ -2131,12 +2115,24 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 {
 	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
+	struct cgroup_subsys *ss;
+	int ssid;
 
 	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
 
+	/*
+	 * A root cgroup's effective css is always the root css in
+	 * init_css_set.subsys[], whichever hierarchy the subsystem is bound
+	 * to, so rebind_subsystems() doesn't need to update e_css[]. For
+	 * cgrp_dfl_root this runs before the root csses exist, and
+	 * online_css() sets the entries when they come online.
+	 */
+	for_each_subsys(ss, ssid)
+		RCU_INIT_POINTER(cgrp->e_css[ssid], init_css_set.subsys[ssid]);
+
 	/* DYNMODS must be modified through cgroup_favor_dynmods() */
 	root->flags = ctx->flags & ~CGRP_ROOT_FAVOR_DYNMODS;
 	if (ctx->release_agent)
@@ -5856,6 +5852,22 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
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
@@ -5869,6 +5881,7 @@ static int online_css(struct cgroup_subsys_state *css)
 	if (!ret) {
 		css->flags |= CSS_ONLINE;
 		rcu_assign_pointer(css->cgroup->subsys[ss->id], css);
+		cgroup_update_e_css(css->cgroup, ss);
 
 		atomic_inc(&css->online_cnt);
 		if (css->parent) {
@@ -5895,6 +5908,7 @@ static void offline_css(struct cgroup_subsys_state *css)
 
 	css->flags &= ~CSS_ONLINE;
 	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
+	cgroup_update_e_css(css->cgroup, ss);
 
 	wake_up_all(&css->cgroup->offline_waitq);
 }
@@ -5966,6 +5980,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 {
 	struct cgroup_root *root = parent->root;
 	struct cgroup *cgrp, *tcgrp;
+	struct cgroup_subsys *ss;
 	struct kernfs_node *kn;
 	int i, level = parent->level + 1;
 	int ret;
@@ -6010,6 +6025,9 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
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


