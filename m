Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C949DCD37AC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 19:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nfOb3jHTRscMBmAm3KtHvb3xtHWnMfP6QafPVBKjVnQ=; b=MJu7BogrKzegZj
	lIjoYZ+npIWc9zVwm5QTYrIQu5vuPY0EDn6OXck2gaMX2eeHpeyOtQdHXQOxd9BDgyKpzMJnzm5pA
	Sj5WySWCUlyglNfYHi73bOw3vP6/9bYt6lQe/W0Vn1ofUHkrzpwZK9kK/fytzPzWr2voRVmGVPW1O
	s7dgfQFxFW62xjxbrbppibuRb5rKbQvUW1zE+O2I0u1RQSIk40O4p7mb5hBFgHrj10Tt+ADXrkAjp
	HX914q5XfGXPAeCyulKMx5FK7rsHxQ/73yEBygUzwnksMghSZItg/oianvU8fw+psI5esymjs/Wa/
	QSbx91hKFsB9sK3RcBxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNFEy-00000003a79-33Fr;
	Wed, 13 May 2026 19:27:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNFEv-00000003a6M-3tEO
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 19:27:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778700448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nfOb3jHTRscMBmAm3KtHvb3xtHWnMfP6QafPVBKjVnQ=;
	b=NUVMhZVvyI2PNkHPedmoK+zt2THhPdRp5LP3gGIwo98jWY8F7sG4SuXjCHURvVx7yGhEg+
	cg7sCafX1U0c/rPFYefoda4pl5WrwHgp5n4drMRZ1oTpem6xeWB4EtrkNfrjJDms9BmMKd
	bRiCSNvm+YChVCnkx4Pvp3Sn5jt4Jss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-bxOTH2m-OY-pL16rCIL6wg-1; Wed,
 13 May 2026 15:25:55 -0400
X-MC-Unique: bxOTH2m-OY-pL16rCIL6wg-1
X-Mimecast-MFC-AGG-ID: bxOTH2m-OY-pL16rCIL6wg_1778700354
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35BB518005B3;
	Wed, 13 May 2026 19:25:54 +0000 (UTC)
Received: from emilne-na.ibmlowe.csb (unknown [10.17.17.93])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 815C51800576;
	Wed, 13 May 2026 19:25:52 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org,
	justin.tee@broadcom.com,
	Johannes.Thumshirn@wdc.com
Subject: [PATCH] nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue deletion in error path
Date: Wed, 13 May 2026 15:25:51 -0400
Message-ID: <20260513192551.892309-1-emilne@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iUt11YklsACdZ3WOuoU4h8gJm99urGzsZ2gWoobL5DQ_1778700354
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_122730_037567_37BF1825 
X-CRM114-Status: GOOD (  12.75  )
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

nvme_fc_create_hw_io_queues() will call __nvme_fc_delete_hw_queue() for the
last queue on which __nvme_fc_create_hw_queue() reported an error when deleting
all the io queues if they cannot all be created.  This is incorrect since the
last queue did not actually get created.

The most recent change to this code was commit 17a1ec08ce70 ("nvme/fc: simplify
error handling of nvme_fc_create_hw_io_queues") which moved the cleanup to the
delete_queues: label and changed the loop bounds, however the code was not
correct prior to this change in a different way.  The original commit
e399441de911 ("nvme-fabrics: Add host support for FC transport") had a
different error which called __nvme_fc_delete_hw_queue() on queue index 0 which
is used for the admin queue.

Fix this by correcting the initial loop index when deleting the io queues.

Fixes: 17a1ec08ce70 ("nvme/fc: simplify error handling of nvme_fc_create_hw_io_queues")
Fixes: e399441de911 ("nvme-fabrics: Add host support for FC transport")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e4f4528fe2a2..f5a83798f3a9 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2318,7 +2318,7 @@ nvme_fc_create_hw_io_queues(struct nvme_fc_ctrl *ctrl, u16 qsize)
 	return 0;
 
 delete_queues:
-	for (; i > 0; i--)
+	for (--i; i > 0; i--)
 		__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[i], i);
 	return ret;
 }
-- 
2.52.0


