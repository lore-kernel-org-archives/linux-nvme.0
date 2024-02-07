Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC6FC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGLbc1PKrzYNG1DVi1O9z0qqpyXgsX3NFWaLC1uoUmo=; b=sqCPdtrr0w3talTeL/zt7x9V0E
	VsyuQh2TDzfW0ssxVU9aollfLL3geEpA3wandGadZOxBUfFF1ZfqkBig2UsabH63Rj3mv9DYC4lvZ
	yIcmIK9NBGvVC60ZUt5vGH0G3jVfoiAQFnzuY/YXjEgNfRd3AwokTKuIoodZfdWBDTr/IN3Q9yBty
	fgQAmcQiC6Qs06q3OtH4FXgLmXGcZ3mh+svlrMcdwI3LgD6IxsrkJ0jjiWx0vOTY/cClUrTW1teaS
	XkarZ7PsDK7k4A9Q/lXwiVwdmXbm4Rej4dOYB6AkVaJnlgBvhfKNQJWDA1EGuyb9sQV/6f3OKiRpw
	bFmHVDfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqSS-0000000C7FR-2U7V;
	Wed, 07 Feb 2024 22:31:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpS9-0000000BthO-3cGJ
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:27:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WGLbc1PKrzYNG1DVi1O9z0qqpyXgsX3NFWaLC1uoUmo=; b=ZGR4gN2bVXZm2hARG9OqgTTh4o
	7TD8PAGvJN06a15JkGGHZx3IQdO8xf5wQLxkyEjUbGJYzAg8Xj4jXr/72fyiVhbAhfho8Q18gA7sK
	mlhCCImSEso69A5enSLu6XjKdwYOqSxEQKi+ytfmqdEAvcMwCEBOcIJzXO+tGtsBOXDzFr/QBSzF1
	egYvDgsXJ/SlXJgu8ot0DFw3fvbEqw73xPWgvhfH08eG8jW4a8pAeSLnP/ufX3dqTmpIX+oZjspdF
	I7fPWAUePUU9XpxtBP+zXw0a7Nly7EZqNH/3bHmPyptCbri2F00Xl72LENHrHu/2y090aQKCiQQV0
	JLiSe5aQ==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpS5-0000000G8xB-0Lq2
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:27:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 597C361AC8;
	Wed,  7 Feb 2024 21:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9269FC43390;
	Wed,  7 Feb 2024 21:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341246;
	bh=bQdppS9UAQRred1gpAr3p4kft8EjZf1tmlb3dTOulA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hO0HVvZTCPS8syvHGZYj32fFcRWkChaK0AveWX7j8Xb88QK1SAdX1tYJ38ajtxXnB
	 f+ECc+x8l5rNaeOVR9P5iDyH+atZdMu74mIQ2m2OSpMvp4jdszBZL5mEs6sk2/j/wB
	 l/PVJ1crsoX6wClgCCScJmBTkM+UFgpVj+g+bhp4cub1I5hkmDQt74n6TnS+ODIZsi
	 XF0XKQplr8NrMJQzVTSCuQP/N36Ef1JA/r2qcYKSQcj9TLN1h4FVY84vgdPlVaG+ng
	 ovYmjJWDBk1DgCrpt5WRps24TKQ/4z39BQX4fk1DkqFP5vtgQRC2rdvzQVRZZ06/N/
	 +wZ+Hnb6pni8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 14/16] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:26:54 -0500
Message-ID: <20240207212700.4287-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212730_619264_CAE884E0 
X-CRM114-Status: GOOD (  11.51  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 3146345c2e9c2f661527054e402b0cfad80105a4 ]

When the target port has not active port binding, there is no point in
trying to process the command as it has to fail anyway. Instead adding
checks to all commands abort the command early.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ebbc513682e1..6bdf9235b14d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1102,6 +1102,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2524,8 +2527,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	if (tgtport->pe)
-		fod->req.port = tgtport->pe->port;
+	if (!tgtport->pe)
+		goto transport_error;
+	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
-- 
2.43.0


