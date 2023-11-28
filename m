Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4344BC07E98
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 21:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m46aWjRJfiE6LEyg2KuOLI4QN1RZrKa1SP5CAL1ja9E=; b=yS/Ez6qKKmoaPjkK9w/3hmfZci
	UYGRcX1sbi6Ueu+BIoEOCVuNZttDXZ3QxExgoTPoQM0aKFJxyYNHEiyZKINVb0RrHN5z/24A3UYSu
	Ejg1ffgaSm9oN5FpqsSWm7b6q/Zom1Syx4KxtPFZJX9QgDuQiqY+eENT0gptJ+RJ9ADz2aCtx1+y5
	37Lvav62vcjNQkq+W95Uzfqahn/UBriLGiPRPCyI5+p5r9CG9DDDcCGrPOzvHUX1FtQBRpqky5wlf
	Uqm67L4S2ktQczCWEdMiswsvtEeNtH24+5l4RqbZqjs3oPawgUqMwX6EnbwoiDpozNEhRU39qZsgO
	Bi8dY+ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r85IA-006LJA-1w;
	Tue, 28 Nov 2023 21:06:50 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r85I6-006LFZ-23
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 21:06:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 41D20CE1D2E;
	Tue, 28 Nov 2023 21:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8865C433C9;
	Tue, 28 Nov 2023 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205603;
	bh=IuRIfCe42GtH8vil+KPwg5Oag3H3ZiaNViBmiSmku88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNX0Kp4jYD65Hqx9/XscUqG3tqOaix0kOos6o3SgNG7Jui811z2LTmWXxOZy5lls6
	 zcjfGqGhqSz2/fQTH2MKFu8OAfZNB32u4QHgJEYfuK5oY/HvbGkHIIu9g/UtLqXqPB
	 PPxHNoaoAuy+gKZT7HjhFtSYOFQk5O7D7XT0q6Mtcgau/F0DlRT+TgLVMJXRJ8KGWV
	 ky6hMh74sCZkH4BFf2Ego+PVZLnS2FNdQyGUs4FzngKjTxHu5+ptG8pUWEULP+sDje
	 PkxCpEcvW2eJH3IXJkZS2djCZPQR+Uet9CQEAbyXoVZp8ACfOshz+Scgmd4/sPvAj4
	 dKkJurEAW3htQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark O'Donovan <shiftee@posteo.net>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/40] nvme-auth: set explanation code for failure2 msgs
Date: Tue, 28 Nov 2023 16:05:21 -0500
Message-ID: <20231128210615.875085-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_130646_887702_0EFDDB9F 
X-CRM114-Status: GOOD (  10.51  )
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

From: Mark O'Donovan <shiftee@posteo.net>

[ Upstream commit 38ce1570e2c46e7e9af983aa337edd7e43723aa2 ]

Some error cases were not setting an auth-failure-reason-code-explanation.
This means an AUTH_Failure2 message will be sent with an explanation value
of 0 which is a reserved value.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index cc02a95a50c9a..a31080b7fd7de 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -839,6 +839,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 
 fail2:
+	if (chap->status == 0)
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
 		__func__, chap->qid, chap->status);
 	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);
-- 
2.42.0


