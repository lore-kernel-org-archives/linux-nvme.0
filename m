Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAE8C71153
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Sep 2023 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nIwEjtsY0Ggze5y0crLHE0egaxqEfPY99SHGckpiA0M=; b=OsBeKDBmT6SAN4/Pitx2XeJDUt
	LvCQKG/5GkXkg7phJVIcNg6ves/ldtoKFg/W2Ji4gBNDoaew6ga1sAoMLFnQ8E0lIYWjScrV772dK
	uT/iQFKgbZRrS+oq7Y1qV1nqUzDE3tQ6yGZh0SLSBFuJ3dCag5VkcryNhpui/UDzVs7RzNrVa9098
	PqNwoEqg3dDcc8fQZzOmaMAbUlvTKVyK68Xq2NCkxNd/vY/32IdOlpHBTghOZHbrQsAxNAetvz6P2
	O+SbYuhrIPLakpppIsGy/dL6p7RmIdoxvT2QfVzmJnnEfiWeumuwCVALiriTYVTZtVekE1hsDldZF
	C5nXf+tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdBUZ-004NRy-2p;
	Mon, 04 Sep 2023 15:27:55 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdBTt-004NQv-1M
	for linux-nvme@lists.infradead.org;
	Mon, 04 Sep 2023 15:27:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 849BA1F74B;
	Mon,  4 Sep 2023 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1693841225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nIwEjtsY0Ggze5y0crLHE0egaxqEfPY99SHGckpiA0M=;
	b=TLJwQLh10tvwCO/QVttr6qB6k0R5+Teav5ckGQo5+uI5G5Dfbd0Xy3Eou8W9eVXVnFyHjA
	+AyivClzuJyeMJVld0phxgmHljP/vh97+aqj9RluXNDDqkszO7fyRrSqesfgKc5c15cbu6
	bETelefEm88g00ZtfoA6l2Vs0cYYzbc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3352D13585;
	Mon,  4 Sep 2023 15:27:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WJO0Ckn39WSgTQAAMHmgww
	(envelope-from <mwilck@suse.com>); Mon, 04 Sep 2023 15:27:05 +0000
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	"George, Martin" <Martin.George@netapp.com>,
	"Kumar, Arun" <Arun.C@netapp.com>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH] nvme-auth: use chap->s2 to indicate bidirectional authentication
Date: Mon,  4 Sep 2023 17:26:38 +0200
Message-ID: <20230904152638.28311-1-mwilck@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230904_082713_616339_23CE1345 
X-CRM114-Status: GOOD (  14.92  )
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

From: Martin Wilck <mwilck@suse.com>

Commit 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
replaced the condition "if (ctrl->ctrl_key)" (indicating bidirectional
auth) by "if (chap->ctrl_key)", because ctrl->ctrl_key is a resource shared
with sysfs. But chap->ctrl_key is set in
nvme_auth_process_dhchap_challenge() depending on the DHVLEN in the
DH-HMAC-CHAP Challenge message received from the controller, and will thus
be non-NULL for every DH-HMAC-CHAP exchange, even if unidirectional auth
was requested. This will lead to a protocol violation by sending a Success2
message in the unidirectional case (per NVMe base spec 2.0, the
authentication transaction ends after the Success1 message for
unidirectional auth). Use chap->s2 instead, which is non-zero if and only
if the host requested bi-directional authentication from the controller.

Fixes: 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/nvme/host/auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..064592a5d546 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -341,7 +341,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
 	size_t size = sizeof(*data);
 
-	if (chap->ctrl_key)
+	if (chap->s2)
 		size += chap->hash_len;
 
 	if (size > CHAP_BUF_SIZE) {
@@ -825,7 +825,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
-	if (chap->ctrl_key) {
+	if (chap->s2) {
 		/* DH-HMAC-CHAP Step 5: send success2 */
 		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
 			__func__, chap->qid);
-- 
2.42.0


