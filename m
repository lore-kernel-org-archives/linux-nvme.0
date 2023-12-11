Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED73C46CC5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Usf3I5xxBL6U4O+F3MjpjOR7bT3iwG1zG2ZLA6gUGM=; b=vXeaeiLa+BL1p2VWzdixbIJ+Oj
	g2B9NqidpklLM2QCdOXptztEmtncUKEmIarYTmwbpEiCKImLyEe8rj1UzSyFfmg7Hzks+LyPWuwJE
	kBYFWGw3lhz25bRVTK00HqUsccecvn7ZsC5diY7HV5KALEIB4IPrPghtDt94MVr1rSIq3+JR/mStC
	vHgBp0jvPhJN0yrYCBiumu41izojGFNYmisd2ekfiLSULyrUyPHz+w83W2RfC298MrV70zvu/TYUe
	vHF25osC6cqGxhM/Rh3CjZizfSFgDzmEbix6w3R7yzxI77sflyhkU0321kX/bWRpAyli08JVd9B5l
	S3sd6psg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgm0-0052mP-0V;
	Mon, 11 Dec 2023 13:56:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCglU-0052Yz-05
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 13:56:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 75D4E6128E;
	Mon, 11 Dec 2023 13:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702A3C43391;
	Mon, 11 Dec 2023 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302967;
	bh=7FWLRc1p6rU6lBfjPN3MpBMeNXSUTIig4nLI3YeSsPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMDtTmrZdRo54xdeGELIEYyXlyCPWGvTXl6Vl320flODlruS9ce+NtOYct/wAWxOj
	 WdUieECt9yZV+82SRFBDsIBvL0fe5WSxIkxxAYMklpI5pe/otBR8Ld+FCtKOvcFkri
	 j+pY9F+1C7lqU0YDsWolZPt8iUFlWinPKdfhfbUZ1D9lmqug7Dm34QBeV1sJtfW3oG
	 MSaDRHlVVtRkkTdOjRK2CL/cmfWawbUdVmTyBuWhCPyLHipCEo4HOkVsK1ggHmewbC
	 cyIXDfaTkhk6GPOgfDnV5ZtLXdwKp0be2tv2wRKV30R8VpQKHGRaYfsFkQ62lsAi2f
	 W2YMJ12yAmvSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 19/29] nvme: introduce helper function to get ctrl state
Date: Mon, 11 Dec 2023 08:54:03 -0500
Message-ID: <20231211135457.381397-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_055608_238574_89FE5689 
X-CRM114-Status: UNSURE (   8.93  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c687c287c46fadb14644091823298875a5216aa ]

The controller state is typically written by another CPU, so reading it
should ensure no optimizations are taken. This is a repeated pattern in
the driver, so start with adding a convenience function that returns the
controller state with READ_ONCE().

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 69f9e69208f68..8b50b56b8ee31 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -377,6 +377,11 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
 };
 
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.42.0


