Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBB1C88CB2
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 00:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gStSfx1ogbTdgzJdx2VuBuo97qQ8rhlYaSRSYb3L4aY=; b=RYoTP28XcENn4pVeQEBakzaGbf
	h2VzXF83UxcZJIrU4UG7EGcFAZhVwSpMDS2JmtWy2P1jPALspR0ylujBeZBQ4KLrdkE/EvfyvwRNO
	Pgw9GnuF0yUhqJWjBZ54YxlCLq9xwITPIrRy3PRZkzy0CMIMrxXnmm+rFf/KTdmEEjJ4MrDVvsPbq
	/xB4rnFoWuZ23j1gw8o6qjmpX9kmpjME76ByzndatM3seZ1sQzo834Br6G4er5qsEE30GsIdUCH/x
	QpD5bKL4t9OBS+35mF8o5ynRjkMxDaW2AR44+YYia5ITn+b2sTyJ9oSVtQiFsrrfknpxwHjLBOwON
	rKdIVw5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sNV-006Uwz-0s;
	Tue, 13 Jun 2023 00:59:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sNQ-006Utr-2W
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 00:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686617951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gStSfx1ogbTdgzJdx2VuBuo97qQ8rhlYaSRSYb3L4aY=;
	b=dWfPephnppiKFteYUCBgVMhE/RPZ9+9FuFEVPCujvbi4KnPTqjNS9vNksjTXCbJ9CVEA30
	LsWfYV2mthhZLPCrh2lHHZ9P9+gI5JDRVIjs+Hn8LIFEw9ODtYtqBXSq+s2Tahj0Guw9js
	WsBmqykq27Zm0mkF6P4odOKvhifHixA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-JvDnC9Z6PrCkzsLufI4JuA-1; Mon, 12 Jun 2023 20:59:08 -0400
X-MC-Unique: JvDnC9Z6PrCkzsLufI4JuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2F7F8007D9;
	Tue, 13 Jun 2023 00:59:07 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0AB7340D1B60;
	Tue, 13 Jun 2023 00:59:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] nvme: core: unquiesce io queues when removing namespaces
Date: Tue, 13 Jun 2023 08:58:46 +0800
Message-Id: <20230613005847.1762378-2-ming.lei@redhat.com>
In-Reply-To: <20230613005847.1762378-1-ming.lei@redhat.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_175916_886513_3A73AC70 
X-CRM114-Status: GOOD (  12.28  )
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

When error recovery is interrupted by controller removal, the controller
is left as quiesced, then IO hang can be caused.

Fix the issue by unquiescing controller unconditionally when removing
namespaces.

Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ec38e2b9173..4ef5eaecaa75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4692,6 +4692,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/*
+	 * Unquiesce io queues so any pending IO won't hang, especially
+	 * those submitted from scan work
+	 */
+	nvme_unquiesce_io_queues(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
-- 
2.40.1


