Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578A5C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7841DLyqRx4+GFENMTDanBPrbVQXHzKvu3LLMhu66w=; b=VthhC8UmcaMwZrT9qEv122qVZ+
	huBK0a1hf0Ee5MCq6iYeSWwP/fjXIdSU9NeEun+tht/NlPK1oSojARrst98Eio8YWtVaarkoEo4SO
	0m+upNH1xyBYmuB5bf/WcpwUQ0miy1uc7JqPN5oyFXL9lbpz3aVDh3BzyQgNHG/mOhbMgYq+ZElNA
	z79AjstxFVpT1QzETmoTcskmzs9uRNEnJPAE6QV8p/jfJd6jGcPOAnqgA0YrY5nbIcygLoKTYAURO
	uVeYbkG74lOTP1o31ZZClRfB/+MLZ34eT0kqI/GwHMbZWF7Iz8B/IDP27iI7kHkcJEWaY3uCJu8YW
	QkoWEJUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmts-0000000BVg3-3Sfc;
	Wed, 07 Feb 2024 18:44:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXmto-0000000BVcE-2DJK
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 18:43:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7841DLyqRx4+GFENMTDanBPrbVQXHzKvu3LLMhu66w=;
	b=Y+YioLGqoq/52a15lLas7T8suRWf6B/NmdYMAlTLxJHqET2x+u/vxYWvgKop5kuBWgrMOU
	mn/mFvSJ7X5iUg4PegaCtkInXbn+mEMa0BHZgHVxjU1QCnqXlmyinDVOpiT2uDDADT7vid
	CoFk6i60ClW6dcYTx9azD4HYiQUDop4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-g0k1TawDMgiM8jXxLRJciw-1; Wed, 07 Feb 2024 13:42:22 -0500
X-MC-Unique: g0k1TawDMgiM8jXxLRJciw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 602F2185A780;
	Wed,  7 Feb 2024 18:42:22 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6DB24011FF1;
	Wed,  7 Feb 2024 18:42:21 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [RFC PATCH 3/6] pci bus async shutdown support
Date: Wed,  7 Feb 2024 13:40:57 -0500
Message-ID: <20240207184100.18066-4-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-1-djeffery@redhat.com>
References: <20240207184100.18066-1-djeffery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_104356_793534_C40D2684 
X-CRM114-Status: GOOD (  17.49  )
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

Add async shutdown shutdown fields and Convert pci's shutdown logic into
async shutdown calls so that individual pci device drivers can implement
async shutdown.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by:     Laurence Oberman <loberman@redhat.com>

---
 drivers/pci/pci-driver.c | 24 ++++++++++++++++++++++--
 include/linux/pci.h      |  4 ++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..0ad418905115 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -502,16 +502,28 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
-static void pci_device_shutdown(struct device *dev)
+static void pci_device_async_shutdown_start(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
 	pm_runtime_resume(dev);
 
-	if (drv && drv->shutdown)
+	if (drv && drv->async_shutdown_start)
+		drv->async_shutdown_start(pci_dev);
+	else if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
+}
+
+static void pci_device_async_shutdown_end(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = pci_dev->driver;
+
+	if (drv && drv->async_shutdown_end)
+		drv->async_shutdown_end(pci_dev);
+
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
@@ -523,6 +535,12 @@ static void pci_device_shutdown(struct device *dev)
 		pci_clear_master(pci_dev);
 }
 
+static void pci_device_shutdown(struct device *dev)
+{
+	pci_device_async_shutdown_start(dev);
+	pci_device_async_shutdown_end(dev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 /* Auxiliary functions used for system resume */
@@ -1682,6 +1700,8 @@ struct bus_type pci_bus_type = {
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
 	.shutdown	= pci_device_shutdown,
+	.async_shutdown_start	= pci_device_async_shutdown_start,
+	.async_shutdown_end	= pci_device_async_shutdown_end,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index add9368e6314..6f61325c956a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -917,6 +917,8 @@ struct module;
  *		Useful for enabling wake-on-lan (NIC) or changing
  *		the power state of a device before reboot.
  *		e.g. drivers/net/e100.c.
+ * @async_shutdown_start:	This starts the asynchronous shutdown
+ * @async_shutdown_end:	This completes the started asynchronous shutdown
  * @sriov_configure: Optional driver callback to allow configuration of
  *		number of VFs to enable via sysfs "sriov_numvfs" file.
  * @sriov_set_msix_vec_count: PF Driver callback to change number of MSI-X
@@ -947,6 +949,8 @@ struct pci_driver {
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
+	void (*async_shutdown_start)(struct pci_dev *dev);
+	void (*async_shutdown_end)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
-- 
2.43.0


