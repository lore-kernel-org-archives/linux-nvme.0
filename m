Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F8DC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1XgcwGNiLhuNbTsKsZPDlJOJFRrpCZjlNcF1/j0WSlk=; b=t2nFxnyCxCgZ3FvF+qwgXYWgcE
	l/w5E+WzhtfncfbYjOXPem2boiCpNQyr/XsJN87cFf8yKaFmMv+kQis26O3KQ+xRv1K4XiQohTk2F
	M61oEU8jToxfax3KXE5qDUbjHkWeLMnKIbXF82GMH2Kb8sMceoP5Mo1p5rz8X0WeQWYFSgpRYa7Dn
	FVZ8/pyHRn6H5RvfxKp7kSYf5EXAC771SuIvp7FqFEEIk6sLLqIQcZKmayPH136rDlOEJYxkvrr9Q
	tDv/EMrpdrakYeiZA5j3vs+UmX2NxKdQaukaU3hw4NyaQ8ROUVu3a4liGzb9at7IypN9p9bZ5JbSC
	2uUgtk5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqS7-0000000C6xu-2Dju;
	Wed, 07 Feb 2024 22:31:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpQe-0000000Bsaa-0mjv
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1XgcwGNiLhuNbTsKsZPDlJOJFRrpCZjlNcF1/j0WSlk=; b=TkvJcbgxxstucdo8x9x4zAHPGn
	p6axoTsrl69fmQerYpGjnHhVgRTv3qQRdraDvxZOHUy01m1MDxfSPAuBsfzdnuUru8P3mk5ySSsXP
	zTrhK8ZzgBeU6EHwbXlGgLlv/uxE965FlhUY53v1pvfgTiQM58v/72FX2JQXfRMIk/Hf8rdDJnjyY
	rQ9PlUJIWtt970THKv5Z+kHVG838uDc2xTkWfRh1LWJ9khq0CMQXoymJMmMdAxoGyKz76+JIwtNrd
	VtlPstnRIqPocNPcBqURoMY6de3fSOEaoBAbeLbtrIR3n2ozvUemnmNZWYq+oy5rHm07Mp5NuiLpW
	/Gu+igag==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpQT-0000000D81M-3LK3
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:25:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2482261AB3;
	Wed,  7 Feb 2024 21:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACD0C43390;
	Wed,  7 Feb 2024 21:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341147;
	bh=bNk4/N865uxd8oiyvt2u0F/rM7pIoJSR5LF6seU25Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdQ03/kTMLpJGnhkRplLeDqqBpGkzs18/Oe4WFL23kt8sL0Kq8uss3yHKd82u1VWf
	 6SQ3XPdt2hZgu4yM96SLTQGbeBZ3hIK/eWaE0sMe0KXBKGJ2vCeHDHqrkFSXYAs2ND
	 NjeaVw6xHpR46tDsaV/gk8SvWU3gzVVC+9/Ny6Im8BNE7S052uW8Qv9shLdqOB7dCO
	 7KA9sBhK8YEOfQgmW4fQQ2bAqZwUDqFPQZmRg29316RFFRqzLmhukw3vJqIYPjVw1/
	 z7IpJpeBU6RT0R0w9juxy1XdZ6PpQaniuPgXfNOM3mWpngyENFu1IslNDenx7HOHBa
	 8H3XohiWgghEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 20/29] nvmet-fcloop: swap the list_add_tail arguments
Date: Wed,  7 Feb 2024 16:24:45 -0500
Message-ID: <20240207212505.3169-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212551_703835_B3A495B5 
X-CRM114-Status: GOOD (  11.44  )
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

[ Upstream commit dcfad4ab4d6733f2861cd241d8532a0004fc835a ]

The first argument of list_add_tail function is the new element which
should be added to the list which is the second argument. Swap the
arguments to allow processing more than one element at a time.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fcloop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c780af36c1d4..f5b8442b653d 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -358,7 +358,7 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 		return ret;
@@ -391,7 +391,7 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	if (remoteport) {
 		rport = remoteport->private;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 	}
@@ -446,7 +446,7 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	if (!tport->remoteport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		queue_work(nvmet_wq, &tport->ls_work);
 		return ret;
-- 
2.43.0


