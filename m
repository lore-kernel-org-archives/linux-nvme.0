Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0775EC4743C
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 00:28:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653D561245
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 00:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653D561245
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IM3LmNWOhPwHM5LOKbLkXj0P2lsM4zB6r5sSJsP0G0Q=; b=n7++w5GvmX1oZb
	g0LxWgPnorQAr3+QQ5As8aYBKg91wjvJRXxq8B3yuqJxvegXISu//cC+xec8cfuu63tiSqWFUMFdA
	ezGk8w2ZfzAbGhcLXSlMVTyso84jlCK2aa/PdW0dVtGy24vctcLf0/Do7R62OgTZfNdmYAlp2gl6v
	TbsjQY00kpKvV+HmIN4v22XEr3Z/4mJ+/oBGXdfbab8/WiAVxXjw02kSNl0RR0AAIZVBxhXpWAbHa
	p3pxincPUH6gHxKhMx9f22qENcfcZOXR27C3n9sBavxL+qajzMcPkXKGZGsd6gjv7SZKMkGUtnIaA
	rxNHeyJYsyaJmMpmz56w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvUH3-005D6I-Fe; Tue, 22 Jun 2021 00:28:17 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvUGz-005D5T-Jt
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 00:28:16 +0000
Received: by mail-pg1-x52d.google.com with SMTP id w31so15594493pga.6
 for <linux-nvme@lists.infradead.org>; Mon, 21 Jun 2021 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fONzks9UFL30IhGMoRISte1aIdOvu/nzi0bHCfehp1M=;
 b=gF4QlqJD8SWm+8sX+BYdy4i0zr7aKWQIMPUKN9QLOtxioM7FukPrs4YIS7ixhX2d0y
 rsAO7t8IBFT2qH4Ea1Trywcrze4NEyWZtHREUzJjNbqw3Pb6uKGaOtNOT0JOI2imLQlf
 C3NGIiUvnY8J69vpv3CXvJOI0p8ShWR16Tf+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fONzks9UFL30IhGMoRISte1aIdOvu/nzi0bHCfehp1M=;
 b=m+Ly6K+UZPgo53zE5+dEk52M9Y8qQpdGx1Wt/owxUcPhFO/mKvhHoc15RnZgavxhg7
 U1kMaerJvr4J19UgY70vLqEPTwwd9/TrMlKcB+ekcN+/kjLg2fJEzFH03PiRoh03Gp+S
 RIUJYurIny0VeaBOVxQsPhATzPMcOYg4vJeaEu3hiUnpSs4MPkTkiiN23Zk8BKxllsZi
 GtgHcV2vROWbCVnFsgDCOeqovX7J91TYND04GstQ/mQBxPbWAr/WIlnO2jJiCBnWgcxp
 ZyxVIV0Hp+rcngbJIyk+Sd8PBNe/PBxOxf4J26V9Dp5WKoHyXFmdN9nUyoyeVBB4EXZh
 t8xQ==
X-Gm-Message-State: AOAM531CZ2g9VzJnv0d8Fb4N816O8unq4kXAnE21Mee65x7cD7GTDkbK
 XgD4H2BL8Q5mytf8ohodK5Q8D+qhdUs1OVCamzKp+bu5v168269TTESzKpHFelxsz9Dv1cNNuEZ
 Qoha3HbBxGSazaNgUbfo8cRO+HlccLzoDiLhYBl21EjOX4IMBr/ppU9jfDIiK2gaR6o45aqmlaw
 6eX9D4rOM=
X-Google-Smtp-Source: ABdhPJxzpdI2iN5gcZIP2Xlz4WDd8NW8pZeAcVxzOHxNgtasVc8lsX7CBdSSmHzfghI3pL6SAcxumw==
X-Received: by 2002:a63:50b:: with SMTP id 11mr1048890pgf.411.1624321692568;
 Mon, 21 Jun 2021 17:28:12 -0700 (PDT)
Received: from yoga.purestorage.com ([192.30.189.3])
 by smtp.googlemail.com with ESMTPSA id i6sm19714156pgg.50.2021.06.21.17.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 17:28:12 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: yzhong@purestorage.com, ashishk@purestorage.com,
 Casey Chen <cachen@purestorage.com>
Subject: [PATCH 1/2] nvme-pci: Fix multiple races in nvme_setup_io_queues()
Date: Mon, 21 Jun 2021 17:27:09 -0700
Message-Id: <20210622002710.26591-2-cachen@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210622002710.26591-1-cachen@purestorage.com>
References: <20210622002710.26591-1-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_172813_705679_182C6672 
X-CRM114-Status: GOOD (  20.73  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Below two paths could overlap each other if we power off a drive quickly
after power it on. There are multiple races in nvme_setup_io_queues()
because of shutdown_lock missing and improper use of NVMEQ_ENABLED bit.

nvme_reset_work()                                nvme_remove()
  nvme_setup_io_queues()                           nvme_dev_disable()
  ...                                              ...
A1  clear NVMEQ_ENABLED bit for admin queue          lock
    retry:                                       B1  nvme_suspend_io_queues()
A2    pci_free_irq() admin queue                 B2  nvme_suspend_queue() admin queue
A3    pci_free_irq_vectors()                         nvme_pci_disable()
A4    nvme_setup_irqs();                         B3    pci_free_irq_vectors()
      ...                                            unlock
A5    queue_request_irq() for admin queue
      set NVMEQ_ENABLED bit
      ...
      nvme_create_io_queues()
A6      result = queue_request_irq();
        set NVMEQ_ENABLED bit
      ...
      fail to allocate enough IO queues:
A7      nvme_suspend_io_queues()
        goto retry

1). If B3 runs in between A1 and A2, it will crash if irqaction haven't
  been freed by A2. B2 is supposed to free admin queue IRQ but it simply
  can't fulfill the job as A1 has cleared NVMEQ_ENABLED bit.

Fix: combine A1 A2 so IRQ get freed as soon as NVMEQ_ENABLED bit get cleared.

2). After solved #1, A2 could race with B3 if A2 is freeing IRQ while B3
  is checking irqaction. A3 also could race with B2 if B2 is freeing
  IRQ while A3 is checking irqaction.

Fix: A2 and A3 take lock for mutual exclusion.

3) A3 could race with B3 since they could run free_msi_irqs() in parallel.

Fix: A3 takes lock for mutual exclusion.

4). A4 could fail to allocate all needed IRQ vectors if A3 and A4 are
  interrupted by B3.

Fix: A4 takes lock for mutual exclusion.

5). If A5/A6 happened after B2/B1, B3 will crash since irqaction is not NULL.
  They are just allocated by A5/A6.

Fix: Lock queue_request_irq() and setting of NVMEQ_ENABLED bit.

6). A7 could get chance to pci_free_irq() for certain IO queue while B3
  is checking irqaction.

Fix: A7 takes lock.

7). nvme_dev->online_queues need to be protected by shutdown_lock. Since it
  is not atomic, both paths could modify it using its own copy.

Co-developed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Casey Chen <cachen@purestorage.com>
---
 drivers/nvme/host/pci.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aa7245a505f..5abc4c3be454 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1590,8 +1590,13 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 		goto release_cq;
 
 	nvmeq->cq_vector = vector;
-	nvme_init_queue(nvmeq, qid);
 
+	/*
+	 * Return early if locking fails as device is being disabled.
+	 */
+	if (!mutex_trylock(&dev->shutdown_lock))
+		return -ENODEV;
+	nvme_init_queue(nvmeq, qid);
 	if (!polled) {
 		result = queue_request_irq(nvmeq);
 		if (result < 0)
@@ -1599,10 +1604,12 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	}
 
 	set_bit(NVMEQ_ENABLED, &nvmeq->flags);
+	mutex_unlock(&dev->shutdown_lock);
 	return result;
 
 release_sq:
 	dev->online_queues--;
+	mutex_unlock(&dev->shutdown_lock);
 	adapter_delete_sq(dev, qid);
 release_cq:
 	adapter_delete_cq(dev, qid);
@@ -2176,7 +2183,16 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (nr_io_queues == 0)
 		return 0;
 
-	clear_bit(NVMEQ_ENABLED, &adminq->flags);
+	/*
+	 * Free IRQ resources as soon as NVMEQ_ENABLED bit transitions
+	 * from set to unset. If there is a window to it is truely freed,
+	 * pci_free_irq_vectors() jumping into this window will crash.
+	 * And take lock to avoid racing with pci_free_irq_vectors() in
+	 * nvme_dev_disable() path.
+	 */
+	mutex_lock(&dev->shutdown_lock);
+	if (test_and_clear_bit(NVMEQ_ENABLED, &adminq->flags))
+		pci_free_irq(pdev, 0, adminq);
 
 	if (dev->cmb_use_sqes) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
@@ -2192,14 +2208,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		result = nvme_remap_bar(dev, size);
 		if (!result)
 			break;
-		if (!--nr_io_queues)
+		if (!--nr_io_queues) {
+			mutex_unlock(&dev->shutdown_lock);
 			return -ENOMEM;
+		}
 	} while (1);
 	adminq->q_db = dev->dbs;
 
  retry:
 	/* Deregister the admin queue's interrupt */
-	pci_free_irq(pdev, 0, adminq);
+	if (test_and_clear_bit(NVMEQ_ENABLED, &adminq->flags))
+		pci_free_irq(pdev, 0, adminq);
 
 	/*
 	 * If we enable msix early due to not intx, disable it again before
@@ -2208,8 +2227,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	pci_free_irq_vectors(pdev);
 
 	result = nvme_setup_irqs(dev, nr_io_queues);
-	if (result <= 0)
+	if (result <= 0) {
+		mutex_unlock(&dev->shutdown_lock);
 		return -EIO;
+	}
 
 	dev->num_vecs = result;
 	result = max(result - 1, 1);
@@ -2222,9 +2243,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * number of interrupts.
 	 */
 	result = queue_request_irq(adminq);
-	if (result)
+	if (result) {
+		mutex_unlock(&dev->shutdown_lock);
 		return result;
+	}
 	set_bit(NVMEQ_ENABLED, &adminq->flags);
+	mutex_unlock(&dev->shutdown_lock);
 
 	result = nvme_create_io_queues(dev);
 	if (result || dev->online_queues < 2)
@@ -2233,6 +2257,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (dev->online_queues - 1 < dev->max_qid) {
 		nr_io_queues = dev->online_queues - 1;
 		nvme_disable_io_queues(dev);
+		mutex_lock(&dev->shutdown_lock);
 		nvme_suspend_io_queues(dev);
 		goto retry;
 	}
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
