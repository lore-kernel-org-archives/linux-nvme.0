Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37EDC61DA3
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jan 2023 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5fsiEQ+emePj7QVpwdVIuator2OfZfjB01aqr9UBD08=; b=q24vFUP3/971zML+UXhCMbCD5I
	wLRpGgZHmQSrtACcI0f/ozQt243RTTCIXP0Wz26/0APlgegsY3viL9hFkkeSjL0C4uJelGRKviTEJ
	lWsg7qdZjn+Qrd8t+sVqNKMX3pp/R3lTwyeet/VTiXov/dRXgQ+oYbs/uC5pScIHt9jWMCBwMsVSC
	iQEiuR/iMvWYZJtEaAkXwYN1ukGBOoV0ovySSEEzwcqWKbDUvkpSnUBdK1wjbJgYAkZlL1+SD8lxX
	U/j+JEAO4hA3Fx82o/NG5+i/DuFS3ZsJr0hd0kxQ+GxE3DOvIb/VDVqaNFrA5QvHMR1UKY4Ifd0ll
	MmySRmIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLQuZ-00FUpX-Ut; Fri, 27 Jan 2023 15:45:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLQuW-00FUnB-92
	for linux-nvme@lists.infradead.org; Fri, 27 Jan 2023 15:45:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674834301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5fsiEQ+emePj7QVpwdVIuator2OfZfjB01aqr9UBD08=;
	b=I921WCmZJk5xoINWBhuO10iSt+r43c0mkUSqtOx8S4HHpjclott43IxeR724+tkDRsQlZ5
	Iqxz0FhpRXh1isKLrLo4Dq4lq6ubaQ0xVfWFNACDUzIE1pnos9ogCU2oJCslWCR806VGU2
	9UhFNpnOqbOg4+nWt8dQot5N5eqFKDE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-B8rTYHciNoyCrM6f-fvdGA-1; Fri, 27 Jan 2023 10:42:39 -0500
X-MC-Unique: B8rTYHciNoyCrM6f-fvdGA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E9051875041;
	Fri, 27 Jan 2023 15:42:39 +0000 (UTC)
Received: from raketa.redhat.com (ovpn-193-129.brq.redhat.com [10.40.193.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 18247492B01;
	Fri, 27 Jan 2023 15:42:37 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: fix potential invalid pointer dereference
Date: Fri, 27 Jan 2023 16:42:37 +0100
Message-Id: <20230127154237.349113-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230127_074504_451170_047CCADD 
X-CRM114-Status: GOOD (  12.70  )
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

If nvme_alloc_admin_tag_set() fails, the admin_q and fabrics_q pointers
are left with an invalid, non-NULL value;
Other functions may then check the pointers' value and dereference them,
like it happens in
nvme_probe() -> out_disable: -> nvme_dev_remove_admin().

Fix the bug by setting admin_q and fabrics_q to NULL in case of error.
Also fix a NULL pointer dereference (the ctrl->admin_tagset pointer
is only initialized just before returning success;
therefore, in the error code path, blk_mq_free_tag_set() must be
called against the "set" variable).

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7be562a4e1aa..6b277b80a09c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4921,7 +4921,9 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	blk_mq_destroy_queue(ctrl->admin_q);
 	blk_put_queue(ctrl->admin_q);
 out_free_tagset:
-	blk_mq_free_tag_set(ctrl->admin_tagset);
+	blk_mq_free_tag_set(set);
+	ctrl->admin_q = NULL;
+	ctrl->fabrics_q = NULL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
-- 
2.31.1


