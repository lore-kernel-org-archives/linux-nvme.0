Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494C6C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7hyyumCSZIC5XideAfYnPwWN4qI+s6d1+FqYbtdN2Oo=; b=dNwIAftWmhapqXdF08PF+wGdUS
	CqEVClZKIG6ASpO0/UiW/SbyJmDZS9Sr8REZ/Xr0+M1YScf6rr9x5Jz5LwrYf/ZFPNtxZ/5IiDYC0
	kqem6OqEaZLyWXdCYFX/VwsssFLhlIBXubLxvAznKm7jtSW/iYCRvHu3mPearebalSiL8SowXei5H
	cdCvbPB/SW/oyDgBdHgc+wL9a8Ku0yKuQr/wEIWoQb+fE+/STQvK/kXCh7bu/77BGEKMEMFo6oVVc
	yI+jyzZBoNpjsRuyp3xf7evjBPxeYmMtyon7L2p+d6IHkuUrHoe5E28HBi6Yg663cox8hakjXBVHR
	JhUPp44Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIV01-006SlF-0d; Mon, 01 Aug 2022 12:58:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIUzo-006SZZ-Ux
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 12:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659358686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7hyyumCSZIC5XideAfYnPwWN4qI+s6d1+FqYbtdN2Oo=;
	b=SFFBGrnnQKr/uMWD6H49BNCE1OUZcPX188zii7qbuxpoP1z6Ak+2r0bY+y6ibiZwRCpCRD
	aA3EEdahIlXGLcSSM8u8DSFOYUBa6B2e1S+wNkp6jGMaRyy2XP5EQD0ICCRPtSK3j3WQEv
	nVFqN+r/vs8l9XihUhPXiE8LLiqxrl8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-xC5Lf6kkP3mcj8RyKOvB_w-1; Mon, 01 Aug 2022 08:58:05 -0400
X-MC-Unique: xC5Lf6kkP3mcj8RyKOvB_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98D23811E76;
	Mon,  1 Aug 2022 12:58:04 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9CB9CC15D4F;
	Mon,  1 Aug 2022 12:58:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] nvme-pci: fix race between pci reset and nvme probe
Date: Mon,  1 Aug 2022 20:57:53 +0800
Message-Id: <20220801125753.1434024-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_055809_122945_68A9C0E0 
X-CRM114-Status: GOOD (  14.70  )
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

After nvme_probe() returns, device lock is released, and PCI reset
handler may come, meantime reset work is just scheduled and should
be in-progress.

When nvme_reset_prepare() is run, all NSs may not be allocated yet
and each NS's request queue won't be frozen by nvme_dev_disable().

But when nvme_reset_done() is called for resetting controller, all
NSs may have been scanned successfully, and nvme_wait_freeze() is
called on un-frozen request queues, then wait forever.

Fix the issue by holding device lock for resetting from nvme probe.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/linux-block/CAHj4cs--KPTAGP=jj+7KMe=arDv=HeGeOgs1T8vbusyk=EjXow@mail.gmail.com/#r
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4232192e10dd..d49b1a082983 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3075,9 +3075,14 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
+	pci_dev_lock(pdev);
+	nvme_reset_ctrl(&dev->ctrl);
 	flush_work(&dev->ctrl.reset_work);
 	flush_work(&dev->ctrl.scan_work);
+	pci_dev_unlock(pdev);
+
 	nvme_put_ctrl(&dev->ctrl);
 }
 
@@ -3154,7 +3159,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	nvme_reset_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
 	return 0;
-- 
2.31.1


