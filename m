Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C06D0EE20
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eeh7ekKkQYcrs75J5ObC3O3XK8/UzyW5cXGpqZFp+AM=; b=sORLy8yfUOHXC2uVM6SqfJppVI
	DZUXZ6vIv38tBzZqRBaBgjDIzTqBikXFx9hqnx4mWDExCuNQQKkOxNs2AF/ptvl+tbnTAcFxZNmY+
	GnAFHg/9t3oikhpr24IHd7SiYwR+VoytGJTG+cGbH2BPL3VoYEbWuY3qzXbff+uSsGu4x3XYmJp/7
	GpXRoXhI1gdNyI9j+flMfdwn12Cocd/nMOlc1ZTAGAsMzbB8hKUewPI0ILhokObgC9IC4n7QR11jB
	SBhFbIVCJkHSe/jrGI5GK6uO+Qt08U6O/FXc05UxmDPtQSJ++IoEuY59TsApJa+beZzxYTLKIEZ26
	T5C8FsEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szI58-0000000GtuW-0TFb;
	Fri, 11 Oct 2024 16:01:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szHyq-0000000GszP-1C2H
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 15:55:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5A3BA5C5A55;
	Fri, 11 Oct 2024 15:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77095C4CED0;
	Fri, 11 Oct 2024 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662103;
	bh=pFqbPRAdiuRsY0v5qj58v/zUdbaLboMBN8uycfJ3/pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFp25kEdGhNq8LJP0wqL1jE3+R3VPxch677kxDVBbHkMX6F+c4vkcRjVt2+fnB5L2
	 D8qp3xOFUHvq2EyCAB51H6r5uvY7MyWVhUVdWdpOpTJfuZpF4vAoo7GoeuIjcrsAi0
	 ghdNCr7Db5Bi+3A09sQoqoFoHsL5lrro1i5CWith5bFRcj+Q4C8DTIrCTM3jOVQMa+
	 1+DtN56JbKBc4zHqKUguUGlanTyNb28+edNPeiBSaoovhl0o/NO+yNvWeOCs1J4Y7E
	 CavXcmZUhXfAYQzDSZEiBotOi7eR+3d27pbiQp22fo4FLY/OD7UPVzDFmuSZw0SaDm
	 72xp+uDA96tsQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/9] nvme-fabrics: reset admin connection for secure concatenation
Date: Fri, 11 Oct 2024 17:54:28 +0200
Message-Id: <20241011155430.43450-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241011155430.43450-1-hare@kernel.org>
References: <20241011155430.43450-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_085504_415716_150F29AF 
X-CRM114-Status: GOOD (  11.32  )
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

When secure concatenation is requested the connection needs to be
reset to enable TLS encryption on the new cnnection.
That implies that the original connection used for the DH-CHAP
negotiation really shouldn't be used, and we should reset as soon
as the DH-CHAP negotiation has succeeded on the admin queue.

Based on an idea from Sagi.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b8a3461b617c..04f0ac57855e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2251,6 +2251,15 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+		dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");
+		nvme_stop_keep_alive(ctrl);
+		nvme_tcp_teardown_admin_queue(ctrl, false);
+		ret = nvme_tcp_configure_admin_queue(ctrl, false);
+		if (ret)
+			return ret;
+	}
+
 	if (ctrl->icdoff) {
 		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
-- 
2.35.3


