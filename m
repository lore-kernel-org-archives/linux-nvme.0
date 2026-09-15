Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478DCC88E75
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/3N/+rWGKvRZFyDxLDOMYwNS8NT38S86dcm9RzMICj0=; b=KfOSoBAeKKUJocix6nr6VwQtE3
	qjIhQMdXqaxcuK1QJu2uvgH0E5WAHYo6CJxfM7pAXfU8O9rlGnscaFJ7Lb/GxEq17Ao7Alf4fL5GA
	jVXHuAKw9qLbVsE+Kop1sb2mb9dzcXan3Pi/BER7lipcPThMfueshtgehADDHTBljalR/bfKfaQNL
	QvlsNttqWMRBbhAbWlJGIUUwM5VfBKLovBbA5sDLGopnA600WPBqjZxrHItEqTEt0KG2iENQxNnt2
	9g3CqevYGo/uEP5u8VbNqgDPqAc2sy7azvC9A4F0Xle2DcGIbaj/rDPanHPKVz7kggu4kw2YzBIlJ
	uoYhBwAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6PxT-00000005q7l-1KEG;
	Tue, 15 Sep 2026 10:00:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6PxO-00000005q6n-31U5
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 10:00:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789466402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/3N/+rWGKvRZFyDxLDOMYwNS8NT38S86dcm9RzMICj0=;
	b=VrFNrN9MuInnp5WkLnslVi6C/czuposyIqe/l21k+OFOXnjtTiUpwCdVOWpL3Qm6rNjpL3
	hEU24Mg7KzWB0yx5QirlGG6sSrV2IfJTAQcjG7jXggQOsMG279xIFRBfV+/ugGrO4tv1iW
	LTgEGMI4dWbj27iEi9zxH2j9fPFIZac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-GGhd8gZqNT2VdQv6JN5kog-1; Tue,
 15 Sep 2026 05:58:33 -0400
X-MC-Unique: GGhd8gZqNT2VdQv6JN5kog-1
X-Mimecast-MFC-AGG-ID: GGhd8gZqNT2VdQv6JN5kog_1789466312
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F51D18009D0;
	Tue, 15 Sep 2026 09:58:30 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2A08754;
	Tue, 15 Sep 2026 09:58:28 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	mlombard@arkamax.eu,
	hch@lst.de,
	hare@suse.de,
	dwagner@suse.de
Subject: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
Date: Tue, 15 Sep 2026 11:58:27 +0200
Message-ID: <20260915095827.698928-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nSm3CjbMeXmMRru5XKkGS-GSuIDo1NFoYMmQQE9w4JU_1789466312
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_030006_837313_A7F6D3C9 
X-CRM114-Status: GOOD (  12.90  )
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

During NVMe controller creation, the controller is exposed to sysfs via
nvme_add_ctrl() while it is still in the NVME_CTRL_NEW state.
This creates a narrow race window where a userspace process can write to
the reset_controller sysfs node before the initialization thread
transitions the state to NVME_CTRL_CONNECTING.

If a reset is triggered during this window, the state machine allows the
transition from NVME_CTRL_NEW to NVME_CTRL_RESETTING, and the reset work
is queued. However, the original creation thread continues its execution,
subsequently moving the state to NVME_CTRL_CONNECTING and finally to
NVME_CTRL_LIVE.

When the delayed reset work finally executes, it attempts to tear down
the controller and transition the state to NVME_CTRL_CONNECTING. Because
the state is now NVME_CTRL_LIVE, this transition fails, triggering a
WARN_ON in the reset work.

Fix this by removing NVME_CTRL_NEW from the allowed prior states for
the NVME_CTRL_RESETTING transition.

Fixes: 8bfc3b4c6f9d ("nvmet: switch loopback target state to connecting when resetting")
Reported-by: syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index beea23d04a70..7ea8dd27d08d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -598,7 +598,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	case NVME_CTRL_RESETTING:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 			changed = true;
 			atomic_long_inc(&ctrl->nr_reset);
-- 
2.55.0


