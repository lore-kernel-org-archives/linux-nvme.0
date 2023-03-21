Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D40C76195
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XEMveR89p3JwC+5cnQbeIOWQT2OIO/0Es9Z5fC5uJOo=; b=0gSZJKuByyg/rF6Opvey8IGsB8
	YMcl/Vg8PrmYghWq74z/Xoz4qW1ngiEKAPuF/J7u7dCXFOD3qCT3Z+vOrC6bjWk+ifJkxANviqCWg
	g3X6DlophUtJzn6nm+x7x1DXP+pp5PJrzndEMUUdu2G0x8ghCN3dBmg8gdIVyDm22DiYVCpSoLsLN
	jFI8096exoEqF2S7Ehd6YI4cdbM3gw3Rk+j8xUwXKJRZabW8VNSIj0e3KJVxc8rzmz9paZbIp8O/v
	aDiEggR50vTj0+9x8NLYxJom438TeiWwo7HXV80bLFdFrfj/pTGedzK+haTvTRxXmaxI1tjBEOunG
	DUxfiyUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLY-00CNYF-0P;
	Tue, 21 Mar 2023 12:44:12 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLN-00CNOW-1Z
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:44:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id E9F0A20000;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679402637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEMveR89p3JwC+5cnQbeIOWQT2OIO/0Es9Z5fC5uJOo=;
	b=LxEdfpHPM0PvKUTQNvfIJC0zyYy2pG6pWDEeHxc+QH23i0WRoo/8OXx7e6JfDb+skbX5L2
	6oWGcFp/jTpwY58FkhdXUJLOLaD1/IcItEanvfD4LrftkaATzpxK2/zilKgaPG21tZFVCJ
	pIIT319QyFabhiqmihiO0wi5IDXE8JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679402637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEMveR89p3JwC+5cnQbeIOWQT2OIO/0Es9Z5fC5uJOo=;
	b=TfX64V5NNtQ3iSKrsxistU7nYJc3uMxGtgyt73IypDtVKog7bouCs/iNT9D14MugYifUHQ
	jlptm95nGLpxl/Bg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D53682C149;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id CBEC951BEEA2; Tue, 21 Mar 2023 13:43:57 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <cel@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/18] nvme/tcp: allocate socket file
Date: Tue, 21 Mar 2023 13:43:14 +0100
Message-Id: <20230321124325.77385-8-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230321124325.77385-1-hare@suse.de>
References: <20230321124325.77385-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_054401_753636_FF912116 
X-CRM114-Status: GOOD (  14.05  )
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

When using the TLS upcall we need to allocate a socket file such
that the userspace daemon is able to use the socket.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0512eb289dcf..0438d42f4179 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -115,6 +115,7 @@ enum nvme_tcp_recv_state {
 struct nvme_tcp_ctrl;
 struct nvme_tcp_queue {
 	struct socket		*sock;
+	struct file		*sock_file;
 	struct work_struct	io_work;
 	int			io_cpu;
 
@@ -1330,7 +1331,12 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	}
 
 	noreclaim_flag = memalloc_noreclaim_save();
-	sock_release(queue->sock);
+	if (queue->sock_file) {
+		fput(queue->sock_file);
+		queue->sock_file = NULL;
+		/* ->sock will be released by fput() */
+	} else
+		sock_release(queue->sock);
 	memalloc_noreclaim_restore(noreclaim_flag);
 
 	kfree(queue->pdu);
@@ -1526,6 +1532,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 		goto err_destroy_mutex;
 	}
 
+	queue->sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
+	if (IS_ERR(queue->sock_file)) {
+		ret = PTR_ERR(queue->sock_file);
+		queue->sock_file = NULL;
+		goto err_sock;
+	}
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
@@ -1647,7 +1659,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 err_sock:
-	sock_release(queue->sock);
+	if (queue->sock_file) {
+		fput(queue->sock_file);
+		queue->sock_file = NULL;
+		/* ->sock will be released by fput() */
+	} else
+		sock_release(queue->sock);
 	queue->sock = NULL;
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
-- 
2.35.3


