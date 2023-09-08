Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C34EE57EE
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EyzKgBDwo1Ka7RQjChBDI8laSFJAqROvg0UETiT3gI0=; b=KyUV6JiOW8nO7pLbUV+1DUpGJ4
	GYgvm5ru+rdiiZtcEchCmSBe03yjIVxOxRD79RsHGhF6E0r4SFaDs4FCTI7mNV0d9bzn9mA2a1ng7
	u6w0oIt/qmQjGM2XeMMoQwsKGb0ZEwZuy9Dn8AchFE3Wfn5u0ECrzjVhbgD4qr2QSDJldmHOD4+cg
	96K0/kf9dHFKZpC3lsXpvbXk9wjoYP1hcYV93Fd9qIZMTnaMZqBGE5pzhky4AX660pWwgeJOmFbwp
	YB8xWKA1jA/Vu7v9syxyIuhK6AQOGW8KF3FZWYqtBVnGQl3eTQ08h8yTbU19th0+EcnE7vyzWuXGF
	Yjg8DaLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeYIR-00DRKr-0v;
	Fri, 08 Sep 2023 10:01:03 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeYIM-00DRIN-0d
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 10:01:00 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id EEA891F8D5;
	Fri,  8 Sep 2023 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694167253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyzKgBDwo1Ka7RQjChBDI8laSFJAqROvg0UETiT3gI0=;
	b=x4PIgTx0GiWJNhz/UP6s6wjQeMAmVilpF94ViGzfnV78nLJsmSv3MUkWS0vsgOZnaSBBw7
	D0/mWk41DIo8vDkDqw26L5q2XHr7JHbRwhzMhybUvb5MLlSG8onjED6iT3PeNMZUtituth
	nxZzqAzZa3ISnw2tXNywwKf0uJvktdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694167253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyzKgBDwo1Ka7RQjChBDI8laSFJAqROvg0UETiT3gI0=;
	b=tV+3sB8hnNgR5AtBTuF4OZGOL6d7GXB+5E8q/4k78ftYSUUaxYj2aM1xdb7E2I9fRzMNrW
	e6ZzxYw7XRywTEAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D72A52C143;
	Fri,  8 Sep 2023 10:00:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id CF25751CC67D; Fri,  8 Sep 2023 12:00:52 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvme-tcp: Do not terminate commands when in RESETTING
Date: Fri,  8 Sep 2023 12:00:47 +0200
Message-Id: <20230908100049.80809-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230908100049.80809-1-hare@suse.de>
References: <20230908100049.80809-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_030058_379583_0C459211 
X-CRM114-Status: GOOD (  11.81  )
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

When the error recovery started it will terminate all commands
anyway, so we should just return BLK_EH_RESET_TIMER for a
command timeout.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5b332d9f87fc..1faef1cf5c94 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2274,6 +2274,14 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
 		opc, nvme_opcode_str(qid, opc, fctype));
 
+	/*
+	 * If the error recovery is started all commands will be
+	 * aborted anyway, and nothing is to be done here.
+	 */
+	if (ctrl->state == NVME_CTRL_RESETTING &&
+	    work_pending(&to_tcp_ctrl(ctrl)->err_work))
+		return BLK_EH_RESET_TIMER;
+
 	if (ctrl->state != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
-- 
2.35.3


