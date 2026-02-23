Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07030E98E10
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 10:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dUyoF2T2gBbaaeCPHjrOWpLkIBgTtnGfzrJoD7Nw1EA=; b=fh2b3D1PtSBZ/6KgKs3fX3HpUt
	R6K0MM0F5oxam4SIF8N+1/bh22QPMxEQyD8CRZiY+5IdpBUcYOqMbEM3RsuAApKBeLwKNdq4qFBb4
	brSAk+2XBXR/KfxSJSpYma6meFgx556xulRYFSVB06LqsiUaqE8NoRd4PSfkzPcwIZawsBdkLSm46
	cZB9B6oq6ep++fkTNy1mMQv6UykEWJklIhp831Us4c05Lm+ALaMmO3X+6HeVWTw4JtTHG2/H8Yo9B
	uo7UhwgcpZxC7bGH84kSBGjIGIi7zltVF1euu49eYBtx8ruQiJehBNzQQqI7gqzEXY+6fNX/WHpec
	eiG55O0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuT6W-0000000032B-0R0y;
	Mon, 23 Feb 2026 10:23:52 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuT6S-00000000305-3fGO
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 10:23:50 +0000
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-480706554beso50419695e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 02:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771842227; x=1772447027; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUyoF2T2gBbaaeCPHjrOWpLkIBgTtnGfzrJoD7Nw1EA=;
        b=fNoSIqNbqo6PzrP0/+I3qO735KYy6ZnBDRvMBzYkROaZE931gAd38Yr3mht4YOdCMK
         KETMDBWly80PqrNH+6VRi9QuNWddxnB8ynB3duHGSYCkTlvbQaTbnuqBm5HWJcuE0quw
         dJr49540lcVs9U0u2es7P9BG32s2VlKK6QMs6tsB2En0EGH1SB7WNnwfEG1yf06epQDL
         nTlYWceHkaCV9czHwakHtlKYi+rq//DY1jVyRSqcyQ4vYkp/kUoD8v/9eUZsex2+pj/o
         URxuj/5j0ibMhSUKKULhi5Q6z2YJGgJUaxNyjXI/+x32WaDhoSfwr44FzngZXJE7hyeH
         V7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771842227; x=1772447027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUyoF2T2gBbaaeCPHjrOWpLkIBgTtnGfzrJoD7Nw1EA=;
        b=Zg7CV2A2Eq7MrjgLzxyBwAOo5ns+rjK9myqOeE6XsVANaFeAgL0BfCdfZMAx1Ehhkn
         zE9dyjSL6Ns0vmWSgK1FYuolpCJO2D0RfZm/70zpT/aHK7EW1+bNrILouXPe4coXzGkX
         du9Ft6CO3Y/+alv7TkwKAwlbGpCt4Pgk91n31mjgCfTmqVDiLU02KxuwpGuGNpCe6XwW
         PA0mrNs+FkUtoPzlBSzbmdeXi9pS0zU90YvDiN0fFPelS+Ty1d3fI5nlPZ9+qtRoHw9A
         yX59UdmCPNIImmDPZL60sMlHuQEk7h416DY3mcvX+81L0R9VJHCNw6a/829768yy31WE
         iyqw==
X-Forwarded-Encrypted: i=1; AJvYcCVQgWY/UdbUmN++4p7fLAMk2trlCEsnjEEpyyE0Agm0q1R9vWdsX/JpQ6oMUoeamUOQiP2NeQxloy3k@lists.infradead.org
X-Gm-Message-State: AOJu0YzaZ3WR9xedDBwB0X5WNk8/rP5FgA6hjaosl6l7bNM0vlNV/Sng
	TBTwn/6VZPxYWZWh+W4K5iffGe4SwFGlEO4kXyUTzZNoI3mjCs40QP3UVKa13ziz6A4=
X-Gm-Gg: AZuq6aIJ8GzP/HXY3MgviuDqlJ+wdLE3XoXggObWdSR5aqprvI/AJLJB6H1te7fPX3I
	T820wVH4BmSKYVagpxcI6iqO621Qm3uooa657LOtfV0E+DITf8pkT75jKDrGSx4CSx/0PsZ0BcY
	2FI03QFGOvmeToYitHC6pwuJwB1wqBe6mFZKKgcsz2CU+d6DZsBsBpPf0PMJG8Tchsocy7JpO6s
	tvvKHUwAn0gvHjiqneFRqelwp8jQXjIXQ+siX0MHfr/F+8a8KtIQZrsL7kAcykm/Bj/YBB8Wh5Q
	NJ4CNNBiEhRmUOqkRk/MJ6Z9UzwaPrLNHOKcSELsqTkWN2Xz8/MtU5WbjNVQ6MgB2mDuRTmp61F
	G4VlFct2BhpkbSLigLmBe20Cd0cOYT3+wbxEYzv4B8bZT6xPqW/8jr8t+ctKSO3qp+GSr3zbpWE
	rRSAF0uG/kb1n/aag0/LFXInLioamF1NHoNC8HHDJuLNWT
X-Received: by 2002:a05:600c:8183:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-483a962e09fmr115119435e9.21.1771842226962;
        Mon, 23 Feb 2026 02:23:46 -0800 (PST)
Received: from linux.fritz.box.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm237342465e9.5.2026.02.23.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:23:46 -0800 (PST)
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>
Subject: [PATCH v2 3/3] nvmet-fc: add WQ_PERCPU to alloc_workqueue users
Date: Mon, 23 Feb 2026 11:23:29 +0100
Message-ID: <20260223102336.108512-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223102336.108512-1-marco.crivellari@suse.com>
References: <20260223102336.108512-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_022348_927848_3113E7A5 
X-CRM114-Status: GOOD (  12.96  )
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

Cc: Justin Tee <justin.tee@broadcom.com>
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>
CC: Paul Ely <paul.ely@broadcom.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvme/target/fc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 4eaadc711c99..d161707559ce 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -792,9 +792,9 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (!queue)
 		return NULL;
 
-	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
-				assoc->tgtport->fc_target_port.port_num,
-				assoc->a_id, qid);
+	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", WQ_PERCPU, 0,
+					assoc->tgtport->fc_target_port.port_num,
+					assoc->a_id, qid);
 	if (!queue->work_q)
 		goto out_free_queue;
 
-- 
2.52.0


