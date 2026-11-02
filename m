Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31866606A324
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FJJsLgL4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pK01e3FH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=LDtf/6qsvrJUn6LMYvjURkTS8eXDbVvfh2YukZT9J2w=; b=FJJsLgL4gkX2r3EJsvRgy6krVZ
	mM7reUyKQpkzgiTfaCb3zMhjlN4p5nXo0nQ/EnmgESihOdBCQ0IXWPtJcFJl5oUumwXCUbqTjBy4E
	PkVYbpi2FmdulJIO6iZ0w9Lu4r7ml7a5hDm7/LVDPY0ZhM8c9xBGVqv/WR53g6oqFlzJGtV47MDgQ
	i0phRUpBCS2RFDHBVF1Fo+GgIi7BN4jabwv+IeL4E2tayshrP1XngyrqShLwrjML6dZWLX2S9eEE1
	UEtM3aTtz1+aJ7EFalQ7XkZB+L1aobbCRbN8U4vgy5qs0GzeChKPboEOufhKyvLeGevt5Itp41O1B
	0A/1Wm6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNogK-0000000G5Fp-2y9F;
	Mon, 02 Nov 2026 09:50:24 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNogI-0000000G5FE-0qw9
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 09:50:23 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-cc758830601so1660294a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793613021; x=1794217821; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LDtf/6qsvrJUn6LMYvjURkTS8eXDbVvfh2YukZT9J2w=;
        b=pK01e3FHASoGT9SjUuFg4e5z38L0coJPhVfitJXND1r6WYhsnYidrXI0kuH6bJZkUR
         hIWhm+NSx3gMQ3sJq095vtOLZNwJrirDwD5lwikOgUtdisRyVbvO5ModOnUs0IRPsYQJ
         +uDwPxyrQMKYERqJG1X9zJuZdIrzRLdssFLpx+LaAfXDJ/AQQo6tm2XUlyAKwp4azrJo
         i7AgZyxCDfrpZt3demGwscbMfqNgoo7sJH6P59Mj11iPD29Nuru9+2cOK9JaR9FWJp7V
         6sF40I95lFvCXJ+3iZKx5Ak8nqYmv0ExmGcDRwov34r+oJKGxoSQo22HcUOUpA+7d077
         L4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613021; x=1794217821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDtf/6qsvrJUn6LMYvjURkTS8eXDbVvfh2YukZT9J2w=;
        b=mtGNRjmp3bEigkTiEb3vnsv+eFRyWyG+fgSSvno0Iu2sMkFS3FNZSsIs9kooGMgdFB
         WKigSn6GPe5YQKRMP6tNPoB77TLJGApunv68hTiF5YB7j9jknqIvmNZhQ3IEkJdPNkoF
         U31ZffOAj4ta41plBMTwajsE9OwbeYMxq7l4m+glOyzhoM452YFRUuU/lWWw+KHlvkkF
         41B5HSdeF8RWDTCsG1EKeQJdH62O3ZprFoteMBcVGg/xoneNLLgZ0+HoneFywszTPJL6
         VQo/a4anEApa+SRyOXXdPEgYgg/D3fE6CDSPEEXe1NHwvPytHjDNpr2po70I7XwoyDYp
         1kOw==
X-Forwarded-Encrypted: i=1; AKwUvBw5y/n04vUkMeuvaWxfpnI2H/zAoDqotqZHOGyrgOUdjiFFbPBPxerUvXSzfH9t1SQ9m/1xfFfOuNXw@lists.infradead.org
X-Gm-Message-State: AFq9FYJTMoy8VVIpn64v4CMou5Kh+J1rFPUWj8UkagSsbC76bZBJKi/k
	D4RbVRtIjSJmFmOi7bLIkHlVKj2zBGCIQgaUFqOTmnuUK2B/Cgcm9/KnRFabFpLJ+qD3rw==
X-Gm-Gg: AYBFou2NVGHmviCsTRJ1fp6ItHdtbgRHBX1DD1nkI0kDqT5yfYIqXLYDLLSUNBf+g5v
	D5nXr72myct0gjtWYykrMjbrlLqbY4ysbI7mH4nw+mRxMESs0qRhYeCc5SyxjvFPAFxOMC4YD/5
	MBQsnKWlKrzhhnQg40/DCcvwPIKTKdMR/0TRDggsZj0RV4sQOC+bUqHmhaFvZDsgQhWMD8XtQdm
	vQwuoVwhqeShPLh4OtlCbD32CWhd45Cb/KOKMDvSVtbFPLO2rl6dTsFVni91YkjofHxD4h3433K
	lIE5TfmMLDC6QC0aGV80tbont5y1Dy0nu0yPhhMWDU+ON0/XkbS0wIYOV02NB519StFE4Tfb52P
	4a4LbCpujrxUTGEpSRDD/PaxNjga3/dmvqihqMY0batsTcjgjcHAfbepZwfSixZTv6YG0uNwM7g
	1tz22NPt5Irq0iFCLApOnZIqikS2zAGEfWYMMnyImTbaPVGfptjTupu1n1suiuneBVWCBVIlx2B
	pXtVO6elnUHliAim+wWz0rmKuq1cn4XePWPoEu/+EQ1AHGN55ZtFKiCxEzDccvYAWoOiPRwLFWy
	u3PxEnJKNT1yDMrqrLgMm4SHzATOWWDszMmtukf7fx9cnJX35gPE8UE=
X-Received: by 2002:a05:6a20:a120:b0:3e4:b458:5239 with SMTP id adf61e73a8af0-3e928d687ddmr9858850637.45.1793613021164;
        Mon, 02 Nov 2026 01:50:21 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d06ae7sm1797411b3a.30.2026.11.02.01.50.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 01:50:20 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: john.garry@linux.dev,
	nilay@linux.ibm.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme: Do not drop the cdev reference twice when cdev_device_add() fails
Date: Mon,  2 Nov 2026 17:50:15 +0800
Message-ID: <20261102095015.36448-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_015022_245716_30F6AC82 
X-CRM114-Status: GOOD (  18.19  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 9952f3882ecb ("nvme: fix cdev lifetime"),
nvme_add_ns_cdev() and nvme_add_ns_head_cdev() take a reference to the
namespace (or namespace head) before calling nvme_cdev_add(), to be
dropped by the char device's release, nvme_cdev_rel(), and drop it
themselves when nvme_cdev_add() fails. But when cdev_device_add()
fails, nvme_cdev_add() has already put the device, and nvme_cdev_rel()
has already dropped that reference: the caller drops it a second time.

With one allocation failure injected into cdev_device_add() for a
namespace on an NVMe over loop controller, deleting the controller
gives, with native multipath:

  BUG: KASAN: slab-use-after-free in nvme_put_ns_head+0x21/0x140
  Write of size 4 at addr ff1100000a4ea078 by task init/1
   nvme_put_ns_head
   nvme_put_ns
   nvme_remove_namespaces
   nvme_do_delete_ctrl
   nvme_delete_ctrl_sync
   nvme_sysfs_delete
  Freed by task 1:
   kfree
   nvme_ns_remove
   nvme_remove_namespaces
  refcount_t: underflow; use-after-free.

Take the reference in nvme_cdev_add() instead, right before
cdev_device_add(), and let the callers neither take nor drop it. Add
nvme_is_ns_cdev() for the check that nvme_cdev_rel() and nvme_cdev_add()
now share.

Fixes: 9952f3882ecb ("nvme: fix cdev lifetime")
Cc: stable@vger.kernel.org
Reviewed-by: John Garry <john.garry@linux.dev>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed and tested them as
    described below.
    
    Changes in v2, after John's review:
    - Add nvme_is_ns_cdev() for the check shared by nvme_cdev_rel() and
      nvme_cdev_add().
    - Shorten the comment and the changelog; the testing is below.
    - Add John's Reviewed-by.
    
    Tested on QEMU (x86_64, KVM) with KASAN, on next-20261030, with a loop
    target exporting a null_blk device, with nvme_core.multipath=N and Y:
    - failslab failing each allocation under nvme_cdev_add() in turn: before
      this patch every failure in cdev_device_add() gives the report above
      (or, with multipath=N, a use-after-free of the namespace in
      nvme_mpath_clear_ctrl_paths()); with it nothing is reported, also
      with lockdep and kmemleak.
    - the case of 9952f3882ecb: hold /dev/ng0n1 open while the controller
      is deleted, then issue NVME_IOCTL_ID and close it. With 9952f3882ecb
      reverted this gives KASAN slab-use-after-free in cdev_put() at the
      close, with either setting; with this patch nothing is reported.
    
    v1: https://lore.kernel.org/linux-nvme/20261101173400.98931-1-izaiahsun@gmail.com/

 drivers/nvme/host/core.c      | 18 +++++++++++++++---
 drivers/nvme/host/multipath.c |  2 --
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af71d02b8476..9ea9db0271c2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3941,10 +3941,16 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 	return 0;
 }
 
+/* The char device of a namespace rather than of a namespace head */
+static bool nvme_is_ns_cdev(struct device *dev)
+{
+	return dev->parent->class == &nvme_class;
+}
+
 static void nvme_cdev_rel(struct device *dev)
 {
 	ida_free(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
-	if (dev->parent->class == &nvme_class)
+	if (nvme_is_ns_cdev(dev))
 		nvme_put_ns(container_of(dev, struct nvme_ns, cdev_device));
 	else
 		nvme_put_ns_head(container_of(dev, struct nvme_ns_head,
@@ -3978,6 +3984,14 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 	device_initialize(cdev_device);
 	cdev_init(cdev, fops);
 	cdev->owner = owner;
+	/* Undone in nvme_cdev_rel() */
+	if (nvme_is_ns_cdev(cdev_device))
+		nvme_get_ns(container_of(cdev_device, struct nvme_ns,
+					 cdev_device));
+	else
+		nvme_get_ns_head(container_of(cdev_device,
+					      struct nvme_ns_head,
+					      cdev_device));
 	ret = cdev_device_add(cdev, cdev_device);
 	if (ret)
 		put_device(cdev_device);
@@ -4010,13 +4024,11 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
 {
 	ns->cdev_device.parent = ns->ctrl->device;
 
-	nvme_get_ns(ns); /* Undone in nvme_cdev_rel() */
 	if (nvme_cdev_add(&ns->cdev, &ns->cdev_device,
 			&nvme_ns_chr_fops, ns->ctrl->ops->module,
 			ns->ctrl->instance, ns->head->instance)) {
 		dev_err(ns->ctrl->device, "Unable to create the ng%dn%d device\n",
 			ns->ctrl->instance, ns->head->instance);
-		nvme_put_ns(ns);
 		return;
 	}
 	set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9e0a0fd77c56..ae8059366b57 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -681,14 +681,12 @@ static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 {
 	head->cdev_device.parent = &head->subsys->dev;
 
-	nvme_get_ns_head(head); /* Undone in nvme_cdev_rel() */
 	if (nvme_cdev_add(&head->cdev, &head->cdev_device,
 			&nvme_ns_head_chr_fops, THIS_MODULE,
 			head->subsys->instance, head->instance)) {
 		dev_err(disk_to_dev(head->disk),
 			"Unable to create the ng%dn%d device\n",
 			head->subsys->instance, head->instance);
-		nvme_put_ns_head(head);
 		return;
 	}
 	set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.53.0


