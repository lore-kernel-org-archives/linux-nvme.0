Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240F606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zNwCCaK5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ST1HNZpZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ij51hxNW5zjirh2vfsWXzFWDuoTjiEkzczCqYtgwfDw=; b=zNwCCaK5unsu5i62w7pAPlPe4i
	xUv9coCF0sA+Rsq1YBPDB9iBNSuxTwfKA1qBJcgDM4liDG+mruu0UaOMvOYFsTyMk9M2iSU2h3sS0
	osFhfLFXMv89dx5EelO/O+FrbuzVK3A+D/75AVeEbovIV9vpKr/W+zF3TqVHbILfBtOTS0NGiQZ86
	2OO9TyVZOn4MSxs8oFJUuUFrjY2169JfZzlqcyvp2Uw9cuO7+YtUP2cI5mfRCdMgyT0JVX3G0GMMG
	COhhixzgnbnDMO2v/Yc7dna1/cUTB95kkg/Dt6DlrtOU87HqLGaS2eT834CzeAkfrg/XGWXZu5PgU
	y5vxSp7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJnHV-0000000DZSr-3LEF;
	Thu, 22 Oct 2026 07:32:09 +0000
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJnHS-0000000DZSP-3LoW
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 07:32:08 +0000
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-3514b90bb89so4201899eec.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792654326; x=1793259126; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ij51hxNW5zjirh2vfsWXzFWDuoTjiEkzczCqYtgwfDw=;
        b=ST1HNZpZ6qciFGHARoX1mZvCd48uG405ElILPhY384P/otGXrH6GxR5j+ZeWP4qiIs
         ULJPbsv8aY7jqepCOC0TkqJ0NFEsw9r68HkTBKPHi25ook5ru3aDwIMNfWA4CpK7CnIb
         2oTGQM9maku6CHMaGzkDhbIUDy9tHI72kt7Wv4ukgFXJFbCJDnu1GIfORlSvKy6pplcs
         uyWBasfnNhzJiodo987HQU2zUs7Oz2eZFYHt+zlk0gGboi8i3ATQ4wwliWtKLjVtHIXj
         OjSjUyYh0jP4KTSdOBUUrl9xTZrVaWsMs9RcWioxMWTZwbqZpfq+TzNYeWrF+D14I5na
         6E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792654326; x=1793259126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ij51hxNW5zjirh2vfsWXzFWDuoTjiEkzczCqYtgwfDw=;
        b=xd8QtrUUOYZW1x3DBGolIGtgfFFIhRJ3xBaXiD3bnQy4i8/eOgtD5XDGKj25jp24zS
         VIyPdu5svMTCK5+9nM8IaeRgfo7Qk4YrrcCSPkdi7gsSbfTh+qfRZ6Tlgmaede55ka06
         Q/VCj4DSvPd5+tT/G/xmrr2Tucm0k+3MWkT30vBlqZhTKz7ZNVJYe3xb6qgONjSjheoF
         AxFCimSgAXfp5sBp0iM5L/zkpFSMeEuz4phwLmCLXLuRmLjVlhg8wmxjbpD71trOTFHW
         l09jFbR6q+3GaICe0kaHBRILqCrmdVgMspgDyXyrWhfWAPwUEOQ0GuisNKR09VVeQcLG
         cNXA==
X-Gm-Message-State: AFq9FYJpy7cstV4ZzkmfA5P9ClJvMZmGhsyuBFvVtx9gXmCugNGhnsYU
	ZCAX0kKJ1wXLrQpQuVbBAEVuRI/FuhQPwgBbpHD2QpYURNE7mUDEvTe7qN6zKcRr
X-Gm-Gg: AYBFou0dEFXTtWE/unuDbOupXyibQ6wBUbPU2pnJYJj1l/uCHRlL9TqBOAdE4kaCZO3
	m3CDI5nS2fG12ZzLv1bajG8TZ+UlOIcqbNei07VzeUqm4tO2iZdyDSKqtQZrnLgCfoQe100cTFd
	n6+Le17R/DLZ3X0ZDWn67sENkFV22FyZ8of0JF4cBz3GKs6AbgQcdlyiSLqELAxvtIGNqc+g22o
	QXVf5se8FFglw/aa1LnG0WYhD+F9i2bqrKKRZgbhxI+0UL4KzqJNE54zUnWajNIggUaKQ4E/njP
	DGA5FuNQn9w15MeaYYNpQ1SlAxQBRvdQZSwi+1qREyatuqZ9BB/Hyw/AXiEXQNqnDrpVSTcMCRE
	hiofhrEU4D3TDwA47L8h2Omr4WNC7p/WkLQVq3Cymi4pz6sZ/97VoEve3Eg7exqrcRxqMZUxQ/I
	17UMyPSCHcOG/rz14d2PXHLSu+hG4VBQTDE5RoiYRd09Q0527KgsZKw+V4POp9H5aOgnUMDJAre
	bZwUNpJawFnzjW2k479ilHQ8OKIPMQGlkk11OARb7MGS1DV8RWue6HEqjtiwg==
X-Received: by 2002:a05:7301:fc12:b0:361:7ab9:47b5 with SMTP id 5a478bee46e88-3674df527a5mr5990754eec.36.1792654325532;
        Thu, 22 Oct 2026 00:32:05 -0700 (PDT)
Received: from gooner.hq.netapp.com ([136.226.242.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm28833907eec.26.2026.10.22.00.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:32:04 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	Martin George <marting@netapp.com>
Subject: [PATCH] nvme: add nvme_is_disc_subsys() helper
Date: Thu, 22 Oct 2026 13:01:44 +0530
Message-ID: <20261022073144.5239-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_003206_840629_F8108DF4 
X-CRM114-Status: GOOD (  16.10  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mirror the target's nvmet_is_disc_subsys() with a host-side
nvme_is_disc_subsys() helper, and use it for the open-coded
subtype == NVME_NQN_DISC checks in the host code to help
maintain consistency and improve code readability.

And while here, fix an error message to refer to the subsystem
rather than the controller.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/core.c      | 4 ++--
 drivers/nvme/host/multipath.c | 6 +++---
 drivers/nvme/host/nvme.h      | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 531f9bb14bab..96b1dddf439b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3329,9 +3329,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	else
 		subsys->subtype = NVME_NQN_NVME;
 
-	if (nvme_discovery_ctrl(ctrl) && subsys->subtype != NVME_NQN_DISC) {
+	if (nvme_discovery_ctrl(ctrl) && !nvme_is_disc_subsys(subsys)) {
 		dev_err(ctrl->device,
-			"Subsystem %s is not a discovery controller",
+			"Subsystem %s is not a discovery subsystem",
 			subsys->subnqn);
 		kfree(subsys);
 		return -EINVAL;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 87b934b46b85..1140491d58dd 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1072,7 +1072,7 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 		container_of(dev, struct nvme_subsystem, dev);
 
 	/* A discovery subsystem has no namespaces and hence no I/O paths */
-	if (subsys->subtype == NVME_NQN_DISC)
+	if (nvme_is_disc_subsys(subsys))
 		return sysfs_emit(buf, "none\n");
 
 	return sysfs_emit(buf, "%s\n",
@@ -1109,7 +1109,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 		container_of(dev, struct nvme_subsystem, dev);
 	int policy;
 
-	if (subsys->subtype == NVME_NQN_DISC)
+	if (nvme_is_disc_subsys(subsys))
 		return -EOPNOTSUPP;
 
 	policy = nvme_iopolicy_parse(buf);
@@ -1129,7 +1129,7 @@ static ssize_t iopolicies_show(struct device *dev,
 		container_of(dev, struct nvme_subsystem, dev);
 	int i, len = 0;
 
-	if (subsys->subtype == NVME_NQN_DISC)
+	if (nvme_is_disc_subsys(subsys))
 		return sysfs_emit(buf, "none\n");
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a8ef62b8e34b..ace9119d0c09 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -522,6 +522,11 @@ struct nvme_subsystem {
 #endif
 };
 
+static inline bool nvme_is_disc_subsys(struct nvme_subsystem *subsys)
+{
+	return subsys->subtype != NVME_NQN_NVME;
+}
+
 /*
  * Container structure for uniqueue namespace identifiers.
  */
-- 
2.43.0


