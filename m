Return-Path: <SRS0=KBoe=7W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15402C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 22:43:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EA82068D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 22:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u33LXObq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rM5XfmCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EA82068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=X1+r3q6biw8ALFtZpexHibR1yzGgIBeIxejq0Bs3q9U=; b=u33LXObqbyZJrP
	3EYjmrsNdi+wfOdQhb1uJA3mzUn5BEAKtMFjfeO3IWzvjcU3CfVQknNesfXfaSewzO+H4YBu3V3SP
	lbtfvJ8j/RMcCdUCzv0naP9L89VFwENq+CC5kBhVMODYz6UpvZkj/gfXQL7eVezSFud8Qy1Ew8QPH
	mTLGHVxGhZg1315A3QII2NydmU77PbRgB3+1UdDl6VeqxqaAGqWNbAzoBM8xZ4bfBd3+/ypDy0Tf/
	aLw1y5wSmObFddVONYyaFfTRoFS6qDN4Ez9bBeY0cmQ0DAIy5i6zUbvBY9hO6YCEm7o9frDZqT8BD
	l0qn/41QH9WWMylKKWeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jimxk-0003ut-MY; Tue, 09 Jun 2020 22:43:20 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jimxh-0003tR-8A
 for linux-nvme@lists.infradead.org; Tue, 09 Jun 2020 22:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591742597; x=1623278597;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UqodpXdV9StEbx3MAhn1HgcBV53YXEF3al3X4XXPzEw=;
 b=rM5XfmCk7UEnm+U9c1iOr8EGrBaViVWmh3VxqPbkIh4mkkdSMNG0RpPz
 rq57ICvCBzEUkwBEjrOljRZm9ME/kKmwkK3qUdXCqcpFzPMGLaUdMs12q
 vMiqq/2af9EXtfddvzTZ7eAn+Ds9hu+x1XZ8Rj+M85Cw5d3rL38ALsD7u
 Zth0ucYiFSE3KF8shEXc/bpjcQyOCsMlBJ8YlnUtcB+m9+DJcOML1CZ9S
 kNgpJn1+bR+c5XFYwO3mpqRmH/jtrqlLXRQGnFdgsdLelIWcje/R721da
 CtAioO3Vi8AjTXYAfB++LtAnEr+ejX/DJvb5yOnJbVIRhIA+MPwBTIAup g==;
IronPort-SDR: fUcH4lxpyJFtJdMlSuufcyRlzY4wjaS5GfOzPnxnNt2mhPC7ZO2VIoOoBMnkFQ2f73oxYa0D/O
 PI0rw6Go4Em3YAwvpRFLkYsCCXqz9mBbTof6IgCPHrpgfCH/bgxGtYGOwHVYHG55Sll6qDtDz+
 wIZhtA7XU6ew1mFiDSrSbXLm49CtJ7IKiP0NuK3abpXH82LnflbECXKohKLKAeiRwDp9hj+k5D
 AqcsCY0Ln9aXtckCEhbpOzOJGBy8SMeaglfEv13ebxGX7tPLVZnKTF8fxnQDkVGLehcGsFZpwF
 wfs=
X-IronPort-AV: E=Sophos;i="5.73,493,1583164800"; d="scan'208";a="139875702"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 06:43:13 +0800
IronPort-SDR: WeHj2pZXVnsdgxzN7saNqbsCb5eITcSbbyJJD4419Lv3aU0ZOjFZp8r26h3Q2a4edsYY/b+S3z
 S8eAnxZTz14icyJsgAnFCCQtbqIdk7ZjY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 15:32:41 -0700
IronPort-SDR: i6r/vxkVWzv13MCaKOv8xFndcMZGG7ITTxrSDuJx++mFiwNHGUEQRMZUw4BI8EzBLxpZ24fqBU
 3hkkPnTAwnAg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2020 15:43:12 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: fail outstanding host posted AEN req
Date: Tue,  9 Jun 2020 15:43:11 -0700
Message-Id: <20200609224311.35142-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200609_154317_326982_3083BDBC 
X-CRM114-Status: GOOD (  14.01  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In function nvmet_async_event_process() we only process AENs iff
there is an open slot on the ctrl->async_event_cmds[] && aen
event list posted by the target is not empty. This keeps host
posted AEN outstanding if target generated AEN list is empty.
We do cleanup the target generated entries from the aen list in
nvmet_ctrl_free()-> nvmet_async_events_free() but we don't
process AEN posted by the host. This leads to following problem :-

When processing admin sq at the time of nvmet_sq_destroy() holds
an extra percpu reference(atomic value = 1), so in the following code
path after switching to atomic rcu, release function (nvmet_sq_free())
is not getting called which blocks the sq->free_done in
nvmet_sq_destroy() :-

nvmet_sq_destroy()
 percpu_ref_kill_and_confirm()
 - __percpu_ref_switch_mode()
 --  __percpu_ref_switch_to_atomic()
 ---   call_rcu() -> percpu_ref_switch_to_atomic_rcu()
 ----     /* calls switch callback */
 - percpu_ref_put()
 -- percpu_ref_put_many(ref, 1)
 --- else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
 ----   ref->release(ref); <---- Not called.

This results in indefinite hang:-

  void nvmet_sq_destroy(struct nvmet_sq *sq)
...
          if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
                  nvmet_async_events_process(ctrl, status);
                  percpu_ref_put(&sq->ref);
          }
          percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
          wait_for_completion(&sq->confirm_done);
          wait_for_completion(&sq->free_done); <-- Hang here

Which breaks the further disconnect sequence. This problem seems to be
introduced after commit 64f5e9cdd711b ("nvmet: fix memory leak when
removing namespaces and controllers concurrently").

This patch processes the outstanding ctrl->async_event_cmd[] until
there are no cmds available in array irrespective of aen list if
empty or not.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6392bcd30bd7..fd7095ef7bcd 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -150,6 +150,19 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 		nvmet_req_complete(req, status);
 		mutex_lock(&ctrl->lock);
 	}
+	/*
+	 * Target controller's host posted events needs to be explicitly
+	 * checked and cleared since there is no 1 : 1 mapping between
+	 * host posted AEN requests and target generated AENs on the
+	 * target controller's aen_list to the async_event_cmds array.
+	 */
+	while (status != 0 && ctrl->nr_async_event_cmds) {
+		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
+		mutex_unlock(&ctrl->lock);
+		trace_nvmet_async_event(ctrl, req->cqe->result.u32);
+		nvmet_req_complete(req, status);
+		mutex_lock(&ctrl->lock);
+	}
 	mutex_unlock(&ctrl->lock);
 }
 
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
