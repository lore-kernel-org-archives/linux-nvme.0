Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98658C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 02:35:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5909F2073B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 02:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RxNjd1wM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5909F2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lNdMad23W/l+236qpQ86wR+ijLWxuYv3ixS9PZWHiNY=; b=RxNjd1wMbnui85
	eek+OzdZvb0Q+FRz0F/knx0Fn3eaKZj52RD9z+6sf9A3R1bK16xg3EOUVWovuuUhnljLXUKWaKXXA
	e4sIJwLTNPqP0nbDejvbAWn8S0GCmkjGpgbBSITUHUsryTsEJdLrutcZNbnCsxrTuOZsMRlnlYmyn
	bWYJ6ndzgpT9BW7mh09nizBMlNZGnINYRBtHf+vhopyHeZmdZGFN9F+pdsR/LQWqvwc6xKbc1XkpN
	mIr6l6xIW+rTjsjtU03ikMTw7LrkWOtQNFlv0gnne3StAOHHk9J498hpWRkjkbRcOaUjT3XzG1euj
	MH/tC3X4bw9dP7XG9/9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ierqa-0006GV-7Y; Wed, 11 Dec 2019 02:35:28 +0000
Received: from mo-csw1516.securemx.jp ([210.130.202.155]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ierq4-0004l2-LT
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 02:34:59 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id xBB2YSd4013429;
 Wed, 11 Dec 2019 11:34:29 +0900
X-Iguazu-Qid: 34tMYYato5bS7R02mG
X-Iguazu-QSIG: v=2; s=0; t=1576031667; q=34tMYYato5bS7R02mG;
 m=/vTa4uwk9xHZhk3DJtgQaXSggUeS3i11m/Dn92K4lZs=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1511) id xBB2YOb6037685;
 Wed, 11 Dec 2019 11:34:24 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id xBB2YO7Z017204;
 Wed, 11 Dec 2019 11:34:24 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id xBB2YNfg018075;
 Wed, 11 Dec 2019 11:34:23 +0900
From: <tsutomu.owa@kioxia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@infradead.org>
Subject: [RFC PATCH 1/5] pci: to export functions needed for nvme reset
Thread-Topic: [RFC PATCH 1/5] pci: to export functions needed for nvme reset
Thread-Index: AdWvyS2tDA3+3Us9TQaprUAAS0xX1g==
Date: Wed, 11 Dec 2019 02:34:22 +0000
X-TSB-HOP: ON
Message-ID: <a09e3b377d064d71b729d2c877461ffb@tgxml778.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.118.176.119]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_183456_918046_6E36D344 
X-CRM114-Status: UNSURE (   8.32  )
X-CRM114-Notice: Please train this message.
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
Cc: tsutomu.owa@kioxia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This pach exports pci related functions which are convenient to implement
nvme reset functions.

Signed-off-by: Tsutomu OWA <tsutomu.owa@kioxia.com>
---
 drivers/pci/pci.c   | 15 ++++++++++-----
 drivers/pci/probe.c |  3 ++-
 include/linux/pci.h |  6 ++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e87196cc1..543dd1991 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1020,7 +1020,7 @@ void pci_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_wakeup, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 {
 	int delay = 1;
 	u32 id;
@@ -1060,6 +1060,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_dev_wait);
 
 /**
  * pci_power_up - Put the given device into D0
@@ -4874,12 +4875,13 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
-static void pci_dev_lock(struct pci_dev *dev)
+void pci_dev_lock(struct pci_dev *dev)
 {
 	pci_cfg_access_lock(dev);
 	/* block PM suspend, driver probe, etc. */
 	device_lock(&dev->dev);
 }
+EXPORT_SYMBOL_GPL(pci_dev_lock);
 
 /* Return 1 on successful lock, 0 on contention */
 static int pci_dev_trylock(struct pci_dev *dev)
@@ -4893,13 +4895,14 @@ static int pci_dev_trylock(struct pci_dev *dev)
 	return 0;
 }
 
-static void pci_dev_unlock(struct pci_dev *dev)
+void pci_dev_unlock(struct pci_dev *dev)
 {
 	device_unlock(&dev->dev);
 	pci_cfg_access_unlock(dev);
 }
+EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
-static void pci_dev_save_and_disable(struct pci_dev *dev)
+void pci_dev_save_and_disable(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
@@ -4929,8 +4932,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
 }
+EXPORT_SYMBOL_GPL(pci_dev_save_and_disable);
 
-static void pci_dev_restore(struct pci_dev *dev)
+void pci_dev_restore(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
@@ -4945,6 +4949,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 	if (err_handler && err_handler->reset_done)
 		err_handler->reset_done(dev);
 }
+EXPORT_SYMBOL_GPL(pci_dev_restore);
 
 /**
  * __pci_reset_function_locked - reset a PCI device function while holding
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312..2156d3d8f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2116,7 +2116,7 @@ static void pci_configure_serr(struct pci_dev *dev)
 	}
 }
 
-static void pci_configure_device(struct pci_dev *dev)
+void pci_configure_device(struct pci_dev *dev)
 {
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
@@ -2135,6 +2135,7 @@ static void pci_release_capabilities(struct pci_dev *dev)
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
 }
+EXPORT_SYMBOL_GPL(pci_configure_device);
 
 /**
  * pci_release_dev - Free a PCI device structure when all users of it are
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c393dff2d..32651b29c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1172,6 +1172,7 @@ bool pci_check_and_mask_intx(struct pci_dev *dev);
 bool pci_check_and_unmask_intx(struct pci_dev *dev);
 int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask);
 int pci_wait_for_pending_transaction(struct pci_dev *dev);
+int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout);
 int pcix_get_max_mmrbc(struct pci_dev *dev);
 int pcix_get_mmrbc(struct pci_dev *dev);
 int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc);
@@ -1194,6 +1195,10 @@ int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
+void pci_dev_lock(struct pci_dev *dev);
+void pci_dev_unlock(struct pci_dev *dev);
+void pci_dev_save_and_disable(struct pci_dev *dev);
+void pci_dev_restore(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
@@ -1248,6 +1253,7 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
 /* For use by arch with custom probe code */
 void set_pcie_port_type(struct pci_dev *pdev);
 void set_pcie_hotplug_bridge(struct pci_dev *pdev);
+void pci_configure_device(struct pci_dev *dev);
 
 /* Functions for PCI Hotplug drivers to use */
 int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
-- 
2.17.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
