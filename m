Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3FBC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 07:13:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4DC61181
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 07:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB4DC61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZBXST5SY/iHsjHdapMGVNWxCqE+5TZwYeA8Pjjh71lY=; b=r/SrUmqC7HwD3kRTULk1Ai8cwc
	T6vhc1WyQQTVsWhlbAmxAcIsT6vMZ/LD02wSs/1YOMYQqRTGXaKrgdIweO7rq3b6aU9THl4xAg4RK
	eY7YkYEg6OT9VVCyG+bxtgq3+pdQyzrvYYs6c6IO44f9FEH0EBl5vEjyPbUfRKUQtzFXPGmRB89go
	Dwk5WbUz0vJ4Io4Ng5QQ9abJsniulQAR88/Y917hQDekN5cGWCoc1Zy7S/R4G4N5W+wKCfKajqjEK
	P6bkOXol9b00NCuyziOKyzIaqr5WfnEMX+6gN1j5rZ4c7jtE9z5k327HDJQQJpPNwF3hJYGhAhH7M
	eok2Qghg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkLJh-000qMc-6o; Tue, 09 Nov 2021 07:13:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkLJe-000qKu-An
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 07:13:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636441989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBXST5SY/iHsjHdapMGVNWxCqE+5TZwYeA8Pjjh71lY=;
 b=AcBNyQQMCfhNU+/5Z3IkmP1UElrdFOtYHworih3JcOkTWmwP5TKrYzAC8l+xrWpojMlCQC
 zYGntSHCZV/rQIjAE+M774mmn9WMobVgiGx0AZae5y7jpyaPx0Xwy9ewUqVbKd+m6AC097
 EmmqLI6jHKNevdfu+DetCv3rnz47F0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-MztoMq5oM8O-J46rTTR1lw-1; Tue, 09 Nov 2021 02:13:06 -0500
X-MC-Unique: MztoMq5oM8O-J46rTTR1lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1DFD802C91;
 Tue,  9 Nov 2021 07:13:04 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A52AC5F4F4;
 Tue,  9 Nov 2021 07:12:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH V2 4/4] nvme: wait until quiesce is done
Date: Tue,  9 Nov 2021 15:11:44 +0800
Message-Id: <20211109071144.181581-5-ming.lei@redhat.com>
In-Reply-To: <20211109071144.181581-1-ming.lei@redhat.com>
References: <20211109071144.181581-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_231310_487018_4167AEC1 
X-CRM114-Status: GOOD (  11.59  )
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

NVMe uses one atomic flag to check if quiesce is needed. If quiesce is
started, the helper returns immediately. This way is wrong, since we
have to wait until quiesce is done.

Fixes: e70feb8b3e68 ("blk-mq: support concurrent queue quiesce/unquiesce")
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 838b5e2058be..4b5de8f5435a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4518,6 +4518,8 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 {
 	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
 		blk_mq_quiesce_queue(ns->queue);
+	else
+		blk_mq_wait_quiesce_done(ns->queue);
 }
 
 /*
@@ -4637,6 +4639,8 @@ void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
 {
 	if (!test_and_set_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_queue(ctrl->admin_q);
+	else
+		blk_mq_wait_quiesce_done(ctrl->admin_q);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
 
-- 
2.31.1


