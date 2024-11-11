Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E3BD2E9F0
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7BT5yyJtGTxupoGIZHnZGSIcsHjesSC3f0ZNAkxR6uU=; b=UfShH8z6MNgWIR1Mzz+ziNox9R
	5U5poUxGW42YgCBDnHvD8VSZp2QTmJ4zb4RoLi81xYINE8Z21BSSXTb6eaXF9rZgp/7LHpxUQ1sN5
	Lzy1BkDCe+aG71miVKV/RK/qSD2BhR0skUewAQVBLMYewAq5Ci9y2IpVoZ2stXd0vLlHUFIIP6ohI
	XctZ8/pMxAktaXHDCPQRdOB9/amKZmz+k6JT+sILqQRr8nUpHBmfAMAHlI52Hsz1/fmsvOaqgA2bp
	+mwM00FCrpQTm8A4YKtJI2BtvlBIrYUqQlcRvcp8Op8w1wmL+6vSyb7tD09+wwSNN6AaGW+s9cwcS
	r4CSSYkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAVrD-00000000NfU-2jw9;
	Mon, 11 Nov 2024 14:57:35 +0000
Received: from mta-03.yadro.com ([89.207.88.253])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAVr6-00000000Nev-3z0w
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 14:57:31 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com C28B6E0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1731337040; bh=7BT5yyJtGTxupoGIZHnZGSIcsHjesSC3f0ZNAkxR6uU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=HmxFlFAaL65fRcSFohGGi4x1R1CUOdeh0SYV5Mx3kJyAqjWSXeAJMxF0rTHrnTuVj
	 M4QDL5T+bz5xRN0YqeY3WRyKPMFsRZg5CLUbTn6Mu88HvNw9yE9dUJiax/hU2CqMYd
	 PS/QlT9/1kVvO/Ax+Tj9Hj4K7YRiDRDPcTr8bC/JdxUvFt/4DHwZ8hwXCHSxFUPCLN
	 Y/9gs9YitdWKP++npcmrx/gnzKuk1f92X923Sdpf2uajJW9uCdxmd5HX/yP45ih5GB
	 13sXenh0hXlgF7Gf997nz7rNGOMisT1GFJRptiOn60dI3Tu2Jfipl5sSH9GSRbANRo
	 Cs+3xKtUru8TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1731337040; bh=7BT5yyJtGTxupoGIZHnZGSIcsHjesSC3f0ZNAkxR6uU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=q1uerANF6XC6ItEEMH8vQcYsTwWr2geiXRlcR0jMtpcRNNPNDFnSsbG9qsfG6nTEB
	 e702QJp9rMUe2uXX6TkdUccHo4doBnCsPebBkLctCRZO/Qhd5gIWUq4Va+XyaDt34m
	 KRTlbEUY4Yr2oldfMydRdb+m/jPJe9uGEIxBpL9TgTCcV4dV1KZ6PRw2fugoxJBtTU
	 nPtz0Q4gN3Pd3i4BTtCUtCqRIYsXcfoQa0vPnkJwjmoYhTCDgxEms0ibTP/ZTiYUfm
	 3sVCy9vt4wppJucU1SA7zKnu59p5w7nIYzTeqIf+YTrtUz6C38Ywdh4JAFeXCKb+03
	 WAS1gE8Qz2quQ==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Guixin Liu <kanie@linux.alibaba.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH] nvmet: fix typo in pr log enum
Date: Mon, 11 Nov 2024 17:56:49 +0300
Message-ID: <20241111145649.18332-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_065729_853667_D530F9E8 
X-CRM114-Status: UNSURE (   9.92  )
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

Fixes: 1900e1a4495b ("nvme: add reservation command's defines")
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/target/pr.c | 2 +-
 include/linux/nvme.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index bef82135a0e7..fafea299570a 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -201,7 +201,7 @@ static void nvmet_pr_resv_preempted(struct nvmet_pr *pr, uuid_t *hostid)
 		return;
 
 	nvmet_pr_send_event_to_host(pr, hostid,
-		NVME_PR_LOG_RESERVATOPM_PREEMPTED);
+		NVME_PR_LOG_RESERVATION_PREEMPTED);
 }
 
 static void nvmet_pr_registration_preempted(struct nvmet_pr *pr,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7e8e80f3aee1..cee36d24a5f1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -2106,7 +2106,7 @@ enum {
 	NVME_PR_LOG_EMPTY_LOG_PAGE			= 0x00,
 	NVME_PR_LOG_REGISTRATION_PREEMPTED		= 0x01,
 	NVME_PR_LOG_RESERVATION_RELEASED		= 0x02,
-	NVME_PR_LOG_RESERVATOPM_PREEMPTED		= 0x03,
+	NVME_PR_LOG_RESERVATION_PREEMPTED		= 0x03,
 };
 
 enum {
-- 
2.25.1


