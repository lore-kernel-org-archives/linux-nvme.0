Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442AEEC1112
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYRTIPm2XKejelZxbfd12xi/Cr57PQ2HDO5pVWa4Q2s=; b=jclCu/G1/OhBpjVuxwnODYkyFj
	ZNjY69cSpQy6bcHsTwogUe5MxjlT7dh1qxv5/x+C2QBruGIpS9aiFNhTAM5EpkRuI1f6Su60k9DaQ
	N6w6pXOMbpiQ8LbCwIOzStNEhFVQUoremfH1TC7uH10MMhatSyVAE8IYtoWAC1AeiDezRTnLJWlYs
	2B9DfHb4QvqGAdUJAysLB3jv+MwfKHBlcV88cEbPGixM2go0Qr4EVjxAY+ybaZtrTxar/w9v1rdT2
	PMZH6pdICtAxXfu9uHXCInLzplddi/hoEuOt54MWzuvdyXVc0Vqa/o6x7XbE12F3Mm/TjuDFKBwca
	KS5mCDjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZew-00000000lrg-1sXF;
	Mon, 23 Feb 2026 17:23:50 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZet-00000000lp3-1Cab
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 17:23:48 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-824c9da9928so2268516b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867426; x=1772472226; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYRTIPm2XKejelZxbfd12xi/Cr57PQ2HDO5pVWa4Q2s=;
        b=ALJMb1AgkFxsGTh9c4iK37Qn29jNd6V4xwyIHsCAdrNeF52hsAM9leRaOHhpLZEBml
         qfgTjdw41z29CwrRTCNRlrPeeBrW3eXI7T2/BuAEpDa0lwVAYpg4A13dFrkS+UuEfLBC
         AUEgCsfh3urNp79TA924k9jw6Hb/0ATPG3DBbdJVYGSSTjPMO8Hn1JY7G8ISlHZUd1yS
         LWXdfPOUIrATVrO+3LwDnqQwTz6adM5quBoMG7tm+YsCw14QxZNngU0aobMEqEfWDFPP
         Rsc2g+q7jfwLwqrEFqJ5t88rq6QiMy4YCQE65HQvQiCs+4Y3fyfRZM6iTMpbwVfFVv4g
         0ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867426; x=1772472226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYRTIPm2XKejelZxbfd12xi/Cr57PQ2HDO5pVWa4Q2s=;
        b=HdzrCYFHRrhbsg8awIpoVpuB3d/DYcjcDeqBLhHKtrCAugIMvNIq7+YRHJlmA1vEU9
         UhGDbdjNqfXEQ1OQxPKN9dbO9RN6wXP9jssdXYTgd5QVBgTcDVBBYaj2aPodt6qW4aoj
         gfzhuvQguK04mF3sw+DOB/kvFA91Z/JOocZgZt7KAA6xfMXs/PtG/boCf07voOlPk5X1
         L2AeaLMoTUUJrga9dyBCIanY6uSpUBXEkyT5xX/TCeTesW+oB92jzM/nnpFqwIdrnoLL
         dD0H/pbD3mj6mTWYtG1JnAhOnLiRFiDoSAsnVUKRq9PNcDtYkIu1/ALC3CwnT2LH7g3+
         YENw==
X-Gm-Message-State: AOJu0Yx4oIvxIFtQtKHQGBtZOPTNjVq8QsuDwlbrR8pzH7KJCY1ynewE
	MBycUrxBTtTC04+coG9Ub2TCrxD9SyMaOBl2Tcb2z1fZHQwggflCNJKu5lnrbSTvqcU=
X-Gm-Gg: AZuq6aKbAHzlimzsvgJISV5cYAIqJ23XtgQfVfDAxFLS8m628NdlIuFkfuvRqJwoT8T
	VjI3hEHoKVZWBG+YB9K4ggoxVngeTmO3hhk1MKYl8e/ttu8UQZDI9RTJd/RG1z+WtJ+izm463b6
	9iJd1xRYkcAV3piZPBQi70bCFxhK6faN7Mm4nNvZd1iOw6dSE8KmB6biLfTKOwCLTbZM9IH2V3c
	MfFDlJzfm7TARwt+abglc1iNzTb51F/4MZae5TCBTe8xnJIfNv335wd8TpWCht2JiBJUzZRH0WN
	7PxQNItTwrrOQE+oZn7toWMiE2tZnD4Fo6U+skLEJnC1Ud6kkMfBuH0BQCHZ4E1NYxgTwamBS4B
	i8i/VaN68jjB0r3sZlpL647fekW5BgOn2+VDHhx1H+vPK8FAJRcR84Ofo8JXdmWHvwg2pgR5fXh
	XJkSUp3yGD+aa+2WRjYgn1f+ld4SyxU/w=
X-Received: by 2002:a05:6a00:2794:b0:81f:394a:4897 with SMTP id d2e1a72fcca58-826daa66f17mr8441167b3a.44.1771867426585;
        Mon, 23 Feb 2026 09:23:46 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd641313sm7876162b3a.1.2026.02.23.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:23:46 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>
Subject: [PATCH 5.15.y 1/2] Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
Date: Mon, 23 Feb 2026 22:53:31 +0530
Message-Id: <20260223172332.291881-2-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223172332.291881-1-jsingh@cloudlinux.com>
References: <20260223172332.291881-1-jsingh@cloudlinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_092347_325964_9E08A401 
X-CRM114-Status: GOOD (  11.85  )
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

This reverts commit 60ba31330faf5677e2eebef7eac62ea9e42a200d.

The backport of upstream commit 0a2c5495b6d1 was incorrectly applied.
The cancel_work_sync() call for ->ioerr_work was added to
nvme_fc_reset_ctrl_work() instead of nvme_fc_delete_ctrl().

Revert this commit so the correct fix can be applied.

Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ac1e4482011e..a959b2c9ae38 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3263,6 +3263,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3333,7 +3334,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
-- 
2.43.7


