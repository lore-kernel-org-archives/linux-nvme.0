Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6336C54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=09m5+SBfJc6gX7T4nbwPoMZXriAQEu+6FlQsl0sanWI=; b=Hyxw2wm8n1p6H7827nG/zfgygT
	Geg0k4z1gHKPkt3sAv1SWIIA7UpAUzcAuQZOTFYlYxM+t42bbB9yn6WejjjSPuG/4PqD2KASSA1ZW
	NFwbdZlbCB97eTf0nqZhifGdncr8pe+JkIsrTwLMuRrCKA1CD6SWjw0w62n+bmTnTCl30f/vLudkW
	mFyEjvshoDaHO1cw8NZrizwtt1uCitbgFcAu+dz4HuoZi7ngwtOi7XTjHdePWy32t7JMx602Rb46D
	N8VQzU3u0bDhbO/mgZFgLIO91t9twDcykleXffsfagfxIyD+2sU8FOSSyrhfzpbcPZPHh3ms1Wrq5
	laY13C+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUeU-0000000DhUa-3Nn3;
	Tue, 05 Mar 2024 13:16:14 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUeR-0000000DhTB-3qT3
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 13:16:13 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6e558a67f70so5023544b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 05 Mar 2024 05:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644571; x=1710249371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09m5+SBfJc6gX7T4nbwPoMZXriAQEu+6FlQsl0sanWI=;
        b=axf0dIMbS2qd/a4tG6rg1tEn+mg7R1u7+j7TxGeg0H76Ier4+PK3H+kmO4+An9Kpiv
         /8EAF9Sbfkca190YT5sliIBuFWEBqnXsHttsCklD22/w5/NhlKokfvNwgbgPhAV0ouaA
         Vf6nHjgCk/GBwNRXsMuPsTYcuAtC3OracakEB23l3L5oCBoGfWwZ7EDnLrsCDrn7EwXI
         gjx88cNYbSo2fpR5JPlC4lYvRIv/zy8NQ0R3nHWfkTMJvb1sNMDDCPbwWdGKvnBNRYBN
         EfDSzvTH1J9qsfG0gB14CTjCAKNqn/4evJYDduFNmGgaBE+qBBybjIWbq49jb88QdC6G
         GsgQ==
X-Gm-Message-State: AOJu0YxkUVpEzLlTJRBtYfg0lrpBI3VJSIMkpUldauQD/pHUR9HKQGND
	7VeBLWTYzlq18zmmwqbKQpd2hWSeoe4hZmTiAbJ0BBW7kQeUEpMU
X-Google-Smtp-Source: AGHT+IEeC1ChjkRaiz7c+VB8f3cr0pptDOo5y15zzCK+P8Uc/lkjf/BcXyQejrRAR+y/zgOz6btJXQ==
X-Received: by 2002:a05:6a20:8f0c:b0:1a1:4cd2:4398 with SMTP id b12-20020a056a208f0c00b001a14cd24398mr1743647pzk.8.1709644570566;
        Tue, 05 Mar 2024 05:16:10 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b006e509762bc2sm8948560pfa.26.2024.03.05.05.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:16:10 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709644569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09m5+SBfJc6gX7T4nbwPoMZXriAQEu+6FlQsl0sanWI=;
	b=cKFrfHDg4W23mqvrUZ0nGbHiVnX0hmV+shCzba6XDCQjiiMQlkV2J7Ml2bvrvTyUZ65wHv
	Q0IPP5SxrqylsP49H9OkuHcoRVnzJ9RhPzAWw/8fqW5W8UuteBcYOlmzRfNQvfze7KNmrq
	ZfTsIotK43wZ38CHui4I6bwK428aEcfKeU7kSh1BJ0ddgAE02P7AlGgtTeDvO0Wtn2xEAb
	Q3AalaM8mhaDYZZQV8z3Mu8623dr790ndU26llwaFsnxRwFYJ86BBMBUFewPI5nQJRtgeT
	8UdfoaS7bgQOdmY+FcH26jXFrE8qLwnOIbLvhoVmbeR+4ydUV9UaMAnyCXzgLQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:15:56 -0300
Subject: [PATCH 1/3] nvme: core: constify struct class usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-nvme-v1-1-c707fc997774@marliere.net>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
In-Reply-To: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4952; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=N127LXZt4grt1w/gMcszgp3Y6dKY6UU9hI85A/v/RiU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5xsRAgbkZFHltPBoK7XwGNvlCzRSGVI2XEudk
 eoKO0P71o2JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecbEQAKCRDJC4p8Y4ZY
 psf7D/9xaaHQVVjmQLJ/6qwlPxjZZAPXOIVGYtTc3mGa3fmormjDdsvtxJVYybF5kToAel1CP5/
 W9Ri0Gf6QPj/SxaXuwO+LCnm/3uJ2LtWklaYyzeRTbmNzJ80FTh9MntPLp6WsdPh9DBXjot5EuQ
 E4PC4uOS4TdQfmjW/UcL2CI+vZDajsdKna59Bo6/nTCSeg8Sch4K3Q+13bQHu/C+UXzqeS9yixG
 Z0vipWjThk8JfnD/mBS6q8OEVF1glL8Bly1iOiY0hY+AjcX5sfPaIGA/uRYPSEiAQzOARm5DRl+
 R+L2jnIbv4TzSdDnh4rcgU7HdTLnLxIjoSXT6Vdi8erj4SyIRsydehuEYdjo8mssp6VeTTPnGCI
 aUK7/l0bd+IPX2dHzjzA1cdmMAAo2G/Jp1oPuaxzlR0xBzny/x+na8akub5vWP1KYk+L257VFwK
 w1WC4KBJylzDuj2FziuLC6Kvf3HkEkz/PDVV+7jXJwXVtpDMEeAQ24UFdZ6ZQh9P7b9egRux3Lx
 BgV9iRwFbwMwDK9jYVjgSVLumG9kxSj2JhhqdWBq3x7NxD3o+4MjdLLKdi7oj3GHEw8FF2l0iG5
 UxSvnti//gh9MSnzaHvwTx9TwEkwPI/zmuP7Zb3DE91Lu2kLegsWQAbtX4t7tPUjZeKMF0jYtUY
 oWueNeX8ZVsbpmQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_051611_999918_1B00940A 
X-CRM114-Status: GOOD (  16.53  )
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

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the structures nvme_class, nvme_subsys_class and
nvme_ns_chr_class to be declared at build time placing them into read-only
memory, instead of having to be dynamically allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/nvme/host/core.c | 53 +++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 60537c9224bf..fdddf2b17519 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -114,12 +114,21 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
-static struct class *nvme_class;
-static struct class *nvme_subsys_class;
+static int nvme_class_uevent(const struct device *dev, struct kobj_uevent_env *env);
+static const struct class nvme_class = {
+	.name = "nvme",
+	.dev_uevent = nvme_class_uevent,
+};
+
+static const struct class nvme_subsys_class = {
+	.name = "nvme-subsystem",
+};
 
 static DEFINE_IDA(nvme_ns_chr_minor_ida);
 static dev_t nvme_ns_chr_devt;
-static struct class *nvme_ns_chr_class;
+static const struct class nvme_ns_chr_class = {
+	.name = "nvme-generic",
+};
 
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
@@ -2873,7 +2882,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys->awupf = le16_to_cpu(id->awupf);
 	nvme_mpath_default_iopolicy(subsys);
 
-	subsys->dev.class = nvme_subsys_class;
+	subsys->dev.class = &nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
 	subsys->dev.groups = nvme_subsys_attrs_groups;
 	dev_set_name(&subsys->dev, "nvme-subsys%d", ctrl->instance);
@@ -3416,7 +3425,7 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 	if (minor < 0)
 		return minor;
 	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
-	cdev_device->class = nvme_ns_chr_class;
+	cdev_device->class = &nvme_ns_chr_class;
 	cdev_device->release = nvme_cdev_rel;
 	device_initialize(cdev_device);
 	cdev_init(cdev, fops);
@@ -4609,7 +4618,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->device = &ctrl->ctrl_device;
 	ctrl->device->devt = MKDEV(MAJOR(nvme_ctrl_base_chr_devt),
 			ctrl->instance);
-	ctrl->device->class = nvme_class;
+	ctrl->device->class = &nvme_class;
 	ctrl->device->parent = ctrl->dev;
 	if (ops->dev_attr_groups)
 		ctrl->device->groups = ops->dev_attr_groups;
@@ -4842,42 +4851,36 @@ static int __init nvme_core_init(void)
 	if (result < 0)
 		goto destroy_delete_wq;
 
-	nvme_class = class_create("nvme");
-	if (IS_ERR(nvme_class)) {
-		result = PTR_ERR(nvme_class);
+	result = class_register(&nvme_class);
+	if (result)
 		goto unregister_chrdev;
-	}
-	nvme_class->dev_uevent = nvme_class_uevent;
 
-	nvme_subsys_class = class_create("nvme-subsystem");
-	if (IS_ERR(nvme_subsys_class)) {
-		result = PTR_ERR(nvme_subsys_class);
+	result = class_register(&nvme_subsys_class);
+	if (result)
 		goto destroy_class;
-	}
 
 	result = alloc_chrdev_region(&nvme_ns_chr_devt, 0, NVME_MINORS,
 				     "nvme-generic");
 	if (result < 0)
 		goto destroy_subsys_class;
 
-	nvme_ns_chr_class = class_create("nvme-generic");
-	if (IS_ERR(nvme_ns_chr_class)) {
-		result = PTR_ERR(nvme_ns_chr_class);
+	result = class_register(&nvme_ns_chr_class);
+	if (result)
 		goto unregister_generic_ns;
-	}
+
 	result = nvme_init_auth();
 	if (result)
 		goto destroy_ns_chr;
 	return 0;
 
 destroy_ns_chr:
-	class_destroy(nvme_ns_chr_class);
+	class_unregister(&nvme_ns_chr_class);
 unregister_generic_ns:
 	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
 destroy_subsys_class:
-	class_destroy(nvme_subsys_class);
+	class_unregister(&nvme_subsys_class);
 destroy_class:
-	class_destroy(nvme_class);
+	class_unregister(&nvme_class);
 unregister_chrdev:
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 destroy_delete_wq:
@@ -4893,9 +4896,9 @@ static int __init nvme_core_init(void)
 static void __exit nvme_core_exit(void)
 {
 	nvme_exit_auth();
-	class_destroy(nvme_ns_chr_class);
-	class_destroy(nvme_subsys_class);
-	class_destroy(nvme_class);
+	class_unregister(&nvme_ns_chr_class);
+	class_unregister(&nvme_subsys_class);
+	class_unregister(&nvme_class);
 	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 	destroy_workqueue(nvme_delete_wq);

-- 
2.43.0


