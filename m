Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB40C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 07:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AHdzuTNipJnZS3n53Hb5cITle8nDOxmN7btqLDyJMjo=; b=g/fQFhncuLaxcbNUltxSpmKNvV
	IqBJZupfvveB3kOJUUFlzgWeQK9k7CTw0SyUov07/A3op7kBuX42xSyGihcOlHJz8RSvGJsU3Hj/R
	TPGdcFI9pmCE9Gtl4GpG5o4FMiSFCZ8UC2F+J3feXxdvLzrUGCmcgyZ+OwzkJX4FmLf1UA+TYDFti
	o6RoYPFDKBX0eBf3D4DnOemFMOBzN4n5pkZXr2kRCfHydApEZBgksNrMf9rcIcFJj/qfH8UZ5Qx7v
	Be8LvM+5+CthyDBa4POhrlKDf/iLA+KOOMBs+XHULDeEN7sExEGkbwzLhEb6yNvtS3Y76AqMk1miD
	GpyQ2HRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDhDl-005lbi-Pq; Tue, 19 Jul 2022 07:00:41 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDhDh-005lYd-CA
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 07:00:39 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VJqbCMx_1658214018;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VJqbCMx_1658214018)
          by smtp.aliyun-inc.com;
          Tue, 19 Jul 2022 15:00:30 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: hch@lst.de
Cc: sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] nvmet-auth: Fix unsigned comparison with less than zero
Date: Tue, 19 Jul 2022 15:00:05 +0800
Message-Id: <20220719070005.39531-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_000037_671679_9B2A8E09 
X-CRM114-Status: UNSURE (   9.94  )
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

The return from the call to nvmet_auth_challenge() and nvmet_setup_auth()
is int, it can be a negative error code, however this is being assigned
to an u16 variable 'status', so making 'status' an int, and change the
position to keep the code format.

This was found by coccicheck:

./drivers/nvme/target/fabrics-cmd-auth.c:488:6-12: WARNING: Unsigned expression compared with zero: status < 0.
./drivers/nvme/target/fabrics-cmd-auth.c:251:8-14: WARNING: Unsigned expression compared with zero: status < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index cc56e8c821ce..02d1931a8219 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -190,7 +190,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	struct nvmf_auth_dhchap_success2_data *data;
 	void *d;
 	u32 tl;
-	u16 status = 0;
+	int status = 0;
 
 	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
@@ -443,7 +443,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	void *d;
 	u32 al;
-	u16 status = 0;
+	int status = 0;
 
 	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-- 
2.20.1.7.g153144c


