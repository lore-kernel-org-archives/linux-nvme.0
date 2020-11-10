Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D545C4742C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:55:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F5E21D93
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 03:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AR05L49C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZwEdVPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F5E21D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8YS9QkJa1c7M8i2O3NHxV9GK0/D51GwvHdFQhmUdgZs=; b=AR05L49CluolxG8Dbli0LEJeV
	W7WOfGEyhlxu7Odj76J19/nrtrjkpzhyy/mqhdrRUXzL2Jty4lTsL7KCpfeCiCMY6JGiO8u6B+6Dy
	IKPLRDWZBkyQNs8XQT9DZkNaP5nxqYYg9P0RBwLNUOnrvfITovyIYov51bfCtLhbjHBaTVISCT+Zc
	0Vy2/+OZhhvcb9yOptNkni/m0sXea4E5Y2eZ3rsUI9FWh3fAjANKGRGBAws2KU4fpY7v6O3JDZ5mF
	/lTvJVdEdyKklHrEvIhz3mapyC8ZV5nRmQkkGBK0WgUvOSki6qKA3oiMcBpfAnGQzjzz9Y07u7bTk
	G4w8/pejA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcKkv-0002eb-PU; Tue, 10 Nov 2020 03:55:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcKkb-0002Th-4X
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 03:55:22 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 682F121D7F;
 Tue, 10 Nov 2020 03:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604980520;
 bh=kV+qDBtDnP2542WwcfD5iDSQX3OY2/PuyoOpF9RD6+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CZwEdVPsM972AxwGUv4F9+uMOE45A2Ja9m0TmycpX+68M7qqT27PUvA/AeU8a9/Ap
 R/jtij0snercNoaUBKt0NuTYhmhm95vrzFnD2SFwmpJ55X736bugte8wrSj4UtQuZ2
 XaabyI7gGehGuy+8FishFVeenjTIay30+RwDzjCI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 28/42] nvme-tcp: avoid repeated request completion
Date: Mon,  9 Nov 2020 22:54:26 -0500
Message-Id: <20201110035440.424258-28-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201110035440.424258-1-sashal@kernel.org>
References: <20201110035440.424258-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_225521_358415_5B47096F 
X-CRM114-Status: GOOD (  15.91  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 0a8a2c85b83589a5c10bc5564b796836bf4b4984 ]

The request may be executed asynchronously, and rq->state may be
changed to IDLE. To avoid repeated request completion, only
MQ_RQ_COMPLETE of rq->state is checked in nvme_tcp_complete_timed_out.
It is not safe, so need adding check IDLE for rq->state.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 76440f26c1453..a31c6e1f6063a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2071,7 +2071,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
-	if (!blk_mq_request_completed(rq)) {
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request(rq);
 	}
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
