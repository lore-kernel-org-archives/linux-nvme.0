Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B475C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 00:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8cCZvDWhaCkmIXxD501GEeM3UPcsCWm6cE45dA8mIss=; b=e8zp2v1p/ECIWR94bo2nIi0yXU
	XkbPgPj4NzmAylW9VYKON/xnzs3ztZM0bRyMRtghdwIwh53ud+6IxSQjXap88VxfzG5dFI4Q5+SZh
	nN0aegCW2I3iVn1wULhzm8v+0kgd8TTIJujn8+SwryrCFzkA9QtNChWsUvTqlEPymOjQQ8YKSKTHU
	7zP6hA6OvfZ6jataJqo0Z7ohGe53kR5RG4n97XLR2kIZhnV1cS+xTEExDhHwxEvmAsubS19QiH1jo
	F8Xk/OwTN2SR6b4otDZy9CH9VxsK+FlTn7k/w8yrMU3Rj1Zfr97OJ9DYmQ+dANQDX6xIaiMjlFzmJ
	J344S+tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEK94-00Dx53-MM; Thu, 21 Jul 2022 00:34:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEK8x-00Dx2U-DS
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 00:34:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658363657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8cCZvDWhaCkmIXxD501GEeM3UPcsCWm6cE45dA8mIss=;
	b=NLhxQk2dA+c6IhqE31t9INrPKZORjLwfzk5IQzPDx3n38Peac+ATvSz77QaEW4FG8bSEDr
	iKA7tnxBIWfwOmeZVWgOmGciy1Ru7yfTYBdhQ2J+iPyX3O5KgSHO7Lv1vzXGYhBr2ib4mL
	3FbJaFBkaVOvpdCm7TLQaklUdNBW/B4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-x32CxBHjPZaWz-1HtV8AcA-1; Wed, 20 Jul 2022 20:34:13 -0400
X-MC-Unique: x32CxBHjPZaWz-1HtV8AcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77FB63C0D196;
	Thu, 21 Jul 2022 00:34:12 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A67A9C28100;
	Thu, 21 Jul 2022 00:34:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH] nvme-fc: restart admin queue if the caller needs to restart queue
Date: Thu, 21 Jul 2022 08:33:58 +0800
Message-Id: <20220721003358.543509-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ming.lei@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_173419_549154_D763037F 
X-CRM114-Status: GOOD (  10.67  )
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

Without restarting admin queue in __nvme_fc_abort_outstanding_ios(),
it leaves controller not capable of handling admin pt request, and
causes io hang.

Fixes it by restarting admin queue if the caller of __nvme_fc_abort_outstanding_ios
requires to restart queue.

Tested-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9987797620b6..8d14df8eeab8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2533,6 +2533,8 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
+	if (start_queues)
+		nvme_start_admin_queue(&ctrl->ctrl);
 }
 
 static void
-- 
2.31.1


