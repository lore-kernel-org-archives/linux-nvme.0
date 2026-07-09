Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A54DC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8ssAo0AR3mSCMO/CmbMqgkQmNZ819KECWYa6WDNvhE8=; b=cB3UktvsT6Svafmzx8BpC5QY79
	k9rFpeRMEefCKFy3rrnR4GIG8koD9QKx4wg6o+wqfR6mxl2yKkQPww2RQQXssO6z95Sy3HgE5iQlq
	fI6SxywYz+zwf7OQg3bg21usfbuLF5AkFfVedCX5ecGK4OFK/wVehz5cLyVBeDj5iMkF0J5I4waNT
	ei9vX84EAUqa9ZwO08INZlt7dJZksnohL7ZbjK058zPbCyeM7WXyBPhXxUJenpeD8kBDtNK57MEad
	tL8enVSSXodCY+F/k5c/g0o6MwBn2IxBixkHYuO+xud//UZzs02apK6oYEpBo7xneewi7r2Ehwq4n
	xEgyZR8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whnto-00000002Phb-0vxu;
	Thu, 09 Jul 2026 12:30:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whntn-00000002PhJ-2ZBA
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 12:30:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5854540460;
	Thu,  9 Jul 2026 12:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F2E1F00A3F;
	Thu,  9 Jul 2026 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783600239;
	bh=8ssAo0AR3mSCMO/CmbMqgkQmNZ819KECWYa6WDNvhE8=;
	h=From:To:Cc:Subject:Date;
	b=yCR6DlxMq8yyE3BcvnL5lUbZ/Jx9Yf2g2cqwXvKgNMHnALK4gj5p/lWWdwoeZZLkB
	 pI3QBk3Xds5yxX8N09dlg0WrBjObUTwz8lfN/GDTcaDVrNY5H3ZGCWY3D3l8AZ1PB+
	 2z+yaf6jLjpG0VNNtQPd6Lh+pln5LmYN8JZknrGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] nvme: bound ns descriptor header and body to identify buffer
Date: Thu,  9 Jul 2026 14:30:32 +0200
Message-ID: <2026070931-stopping-cost-239a@gregkh>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Xt5eXEL0N3t5nVlWvAruPNIVLqUfyhnCCxXQlx1s+3I=; b=owGbwMvMwCRo6H6F97bub03G02pJDFn+U9KtHXz9n023yjI65BLN9Oek/6Z3C4ot4mq1FvyJs rlkeCavI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbykIFhwbq41TFLslYuCrYw maa6PcbQ7DK/McP8XJ0ehXTe4Pm3nvgGrtVpN+RZudACAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
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

From: Hari Mishal <harimishal1@gmail.com>

nvme_identify_ns_descs() allocates a buffer and gives it to the
controller, which populates it and then iterates the buffer with
variable byte increments that vary by type and body size.  But, there is
no bounds check inside the iteration itself except the loop bound
itself.  Fix this by checking and stopping iteration if the next header
or its declared body would go past the buffer itself.

Assisted-by: gkh_clanker_t1000
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..6505da5c5ebe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1583,8 +1583,12 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
 		struct nvme_ns_id_desc *cur = data + pos;
 
+		if (pos + sizeof(*cur) > NVME_IDENTIFY_DATA_SIZE)
+			break;
 		if (cur->nidl == 0)
 			break;
+		if (pos + sizeof(*cur) + cur->nidl > NVME_IDENTIFY_DATA_SIZE)
+			break;
 
 		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
 		if (len < 0)
-- 
2.55.0


