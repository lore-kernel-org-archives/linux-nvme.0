Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3BBEB64DB
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eVjehdUAO3eBQAkJp4hVrkCOuUZkb08TzgaPLCdTLBI=; b=C3Nq0rSd091kESUiUhohl4vnqq
	1pQTUi4iw92y6LVDp5Ukh/SGCN5P9LoHNaeNRBn9b6KcLVOqrzcALvCOKZyAIaP9mbjLx0OQOLC62
	wuHaK27IXWH7vzam1rydGhFFrCGPT22q5iTMSohbm4DFSn5tszKAo9KHJVZ4PFgNG9gU+ZUbwO/NJ
	XL2pVyxdgrmA9ST0ks4629X9VHpI+33TjXE1B4e8gqWoqMILCaqftAnKm+EJzRXRF3r4ifa4Q3Mrj
	wZQAynb5d1Vzbf8xST0zlRj0KzYitif/TVoxPEqG+8wx41woDd6/42GTxXh2JNnhdmkBET4WrkQ8x
	EBhNKWWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9lJV-00EjAH-0I;
	Thu, 15 Jun 2023 11:38:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9lJS-00Ej95-2f
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 11:38:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5D197639BA;
	Thu, 15 Jun 2023 11:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DEEC433C0;
	Thu, 15 Jun 2023 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686829129;
	bh=HsCyUvfibQH67qp1YfRajXMffQt8/KA+bwrrVsqQPUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNI6JtGLgJ1DqpI5cdrAr2uqeSY6nWvRVvRt/iQJIMBNnfT1dkorsjhBVKLdGARYI
	 0co+48ndIqBFFEfS0nwdua5BYkiGXLhq8rASx3x27FshQZ+q2VV4JkAFwUgnWdYVrM
	 57cu+DedQSN0XWEOPQITkBzGKacKG8HE9MVI7OLboZTOazSUYqTa6rPjVd2i+hyHii
	 DG8iKlc2C96XPRoM6SMn4Pfez1MhrNT0J0Wz2c1fFnxsntPo4bxGQ7jfzkpADv84hL
	 AgHTy4GoUY4vdCM+l/hqAeDqT0MRz3VoYWGmuYLKLSwgrZNRq73B7GF9x87i6xizVN
	 0QKrOgdXrXIJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 13/16] nvme: double KA polling frequency to avoid KATO with TBKAS on
Date: Thu, 15 Jun 2023 07:38:13 -0400
Message-Id: <20230615113816.649135-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113816.649135-1-sashal@kernel.org>
References: <20230615113816.649135-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_043850_948640_EC3D3CE7 
X-CRM114-Status: GOOD (  16.25  )
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

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit ea4d453b9ec9ea279c39744cd0ecb47ef48ede35 ]

With TBKAS on, the completion of one command can defer sending a
keep alive for up to twice the delay between successive runs of
nvme_keep_alive_work. The current delay of KATO / 2 thus makes it
possible for one command to defer sending a keep alive for up to
KATO, which can result in the controller detecting a KATO. The following
trace demonstrates the issue, taking KATO = 8 for simplicity:

1. t = 0: run nvme_keep_alive_work, no keep-alive sent
2. t = ε: I/O completion seen, set comp_seen = true
3. t = 4: run nvme_keep_alive_work, see comp_seen == true,
          skip sending keep-alive, set comp_seen = false
4. t = 8: run nvme_keep_alive_work, see comp_seen == false,
          send a keep-alive command.

Here, there is a delay of 8 - ε between receiving a command completion
and sending the next command. With ε small, the controller is likely to
detect a keep alive timeout.

Fix this by running nvme_keep_alive_work with a delay of KATO / 4
whenever TBKAS is on. Going through the above trace now gives us a
worst-case delay of 4 - ε, which is in line with the recommendation of
sending a command every KATO / 2 in the NVMe specification.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f502e032e7e46..50a83306bea7b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1198,9 +1198,25 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
+static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
+{
+	unsigned long delay = ctrl->kato * HZ / 2;
+
+	/*
+	 * When using Traffic Based Keep Alive, we need to run
+	 * nvme_keep_alive_work at twice the normal frequency, as one
+	 * command completion can postpone sending a keep alive command
+	 * by up to twice the delay between runs.
+	 */
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		delay /= 2;
+	return delay;
+}
+
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work,
+			   nvme_keep_alive_work_period(ctrl));
 }
 
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
-- 
2.39.2


