Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F0EC77B61
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 21:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ysNuQHbgRpr4R7vgo4/QubAeuoxRUUI6GgbUVg31pXQ=; b=B+4GlLKtRkx+SH59tVurYJ/7sm
	EY9ZcIwyJmj0dJXVYYa9QYB0lzXcdn8dDBLC1yO0gzg8hXMZrWa5yEGVrBQ/U9dWEDuMUKEccqJGX
	uAOsjvk57yJ0mqxUJZFWURkwQERh/av3PKp3E8KOmAfRaLVtgV73856XylT5xwAj5bRx1Zpcd1J0z
	6GM272rjgY8jO/eaa7j8CR2hNybsu3+ywZH6ZPh48MRBi9Nr7QRoBZZ63dxsJBUt4L+qqN1pbk5H4
	dvK6KxHULtAgtzSiZWDf3XGHIP6NuF8P1GtHuLfN7AlqzeNFlsgJy5uNJVPfxYM0w/Lqs25rFwKFO
	DrZKybCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prQ4Z-002ETs-0G;
	Tue, 25 Apr 2023 21:19:39 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prQ4W-002ESN-1Q
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 21:19:37 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-187b70ab997so33564421fac.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682457573; x=1685049573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysNuQHbgRpr4R7vgo4/QubAeuoxRUUI6GgbUVg31pXQ=;
        b=piXHaMKOsQPgn5LhKnV8KQ1f7GA+dyxUwISmKV3ekH+gH3T+71hEYpCKAs/IZo3Ogz
         96ksXXallIzcpSVhKl7jy3GnOIQ0W8WecXU6WGkDFgh5rP7s1z2iJLDZTiqbD2G78Gfz
         aqlHwb3C2AjO+lxUhpYZWL51nIbiFWm2ObmQNiCZvwN+LQBYGnjcgn/KlYHPx0eEAKdJ
         rd3Plr668iVChodPMV8Y841qCm9KPURbCdz1wiz8VRCTDsgSAt/Iclx50LgmIXBpDO52
         fkU89w73A69DUeU0fqXbfeykiRkG588s68QrDs9cApoMUv4w59ANZAnphlvFsQbS73ol
         VfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682457573; x=1685049573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysNuQHbgRpr4R7vgo4/QubAeuoxRUUI6GgbUVg31pXQ=;
        b=kPQgJYf8Z6AZQ/ts96sCvUcwtp79E37x7fFZQUBS9PoDdHk86NzaErsjkdpHlKtWum
         1tiiU3kvQf1HTeP/GqL20cbRUMhHZKp3xCXA+9nXqVuGIYrqTQHV89DKqViA5GoZxs/E
         Nrf+qA60sE1hBjiQVYCeIK/Vz7Or6xEKoEdSPFI+J1sFNQb5zcQ5bzIIAxU6xrOijvQY
         f4JV36vOGN9Ls+Z74PgrVx5HLX9SLLqDZ3vi4AXMZnzyYTE1EqmR/8FgBOmwbBxeQHKX
         qEMi1UatMPN3EcPUB/RoI5aME0k2eYv+KjwNShU3j/JQBk4P4km/x9MBTgSNqadEynTs
         6OqA==
X-Gm-Message-State: AC+VfDz2broN/it5rOAhKlkoHwv7y7B/UbPv2wyHS1sTODJo2NLWaUJA
	nG39fF+0yLdJ0gQliJTviF5urN6M9akYfpnz
X-Google-Smtp-Source: ACHHUZ6wSzOoa8PPp2byZNjodKKn26O+7DABmmGbYXr11bvKy+PMe0DKE0KphL+divasp2eO7I0l2w==
X-Received: by 2002:aca:a981:0:b0:38e:e5b5:493e with SMTP id s123-20020acaa981000000b0038ee5b5493emr153407oie.11.1682457573335;
        Tue, 25 Apr 2023 14:19:33 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.195.153.187])
        by smtp.gmail.com with ESMTPSA id u2-20020a05687036c200b00177c314a358sm5945357oak.22.2023.04.25.14.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:19:33 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 3/3] nvme-core: preventing double freeing in ctrl release
Date: Tue, 25 Apr 2023 18:18:36 -0300
Message-Id: <20230425211836.14283-4-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425211836.14283-1-irvincoteg@gmail.com>
References: <20230425211836.14283-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_141936_482594_0DDA7EB1 
X-CRM114-Status: GOOD (  14.49  )
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

The teardown logic and the release method for
the controller both free the same resources.
This introduces double-freeing issues.
Since the release of the ctrl is the last step
of the teardown, we can solve this by setting the freed
pointers to NULL in the teardown path and add checks
in the release method.
The only issue is with ida_free as ida doesn't offer any way to
indicate that an ID has already been freed.
In our specific case we can set the ID to -1 to indicate that.
We can do that because, the way we've setup ida to manage ctrl instances,
it always returns non-negative IDS.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 7 +++++--
 drivers/nvme/host/pci.c  | 8 ++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 353443250d48..15df7846fde8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5091,14 +5091,15 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
-	if (!subsys || ctrl->instance != subsys->instance)
+	if ((!subsys || ctrl->instance != subsys->instance) && ctrl->instance != -1)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	nvme_auth_stop(ctrl);
 	nvme_auth_free(ctrl);
-	__free_page(ctrl->discard_page);
+	if(ctrl->discard_page)
+		__free_page(ctrl->discard_page);
 	free_opal_dev(ctrl->opal_dev);
 
 	if (subsys) {
@@ -5202,8 +5203,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_free(&nvme_instance_ida, ctrl->instance);
+	ctrl->instance = -1;
 out_free_discard_page:
 	__free_page(ctrl->discard_page);
+	ctrl->discard_page = NULL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 65e4b9f1b632..ff5c876739bc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2681,8 +2681,10 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 
 	nvme_free_tagset(dev);
 	put_device(dev->dev);
-	kfree(dev->queues);
-	kfree(dev);
+	if(dev->queues)
+		kfree(dev->queues);
+	if(dev)
+		kfree(dev);
 }
 
 static void nvme_reset_work(struct work_struct *work)
@@ -2973,8 +2975,10 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 out_put_device:
 	put_device(dev->dev);
 	kfree(dev->queues);
+	dev->queues = NULL;
 out_free_dev:
 	kfree(dev);
+	dev = NULL;
 	nvme_put_ctrl(&dev->ctrl);
 	return ERR_PTR(ret);
 }
-- 
2.39.2


