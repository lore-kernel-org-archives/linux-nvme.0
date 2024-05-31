Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1488BC25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EEZUDPG8IaESZsyP/PkDdrfoGtanN7ZjWLyO9o1BDNs=; b=i7H6hBpVdpdVk3ZsNh5V2lCnsb
	8hspTvOrZj+s80ALAkRNa+ur2Tj7XprjQOIgnSGSotuOdwcT6HaGhLa4yAJZJcFLOJLOKZV7K5S50
	2PPBLd2SXkoac9QjXHENMXBAft1m1+Di5kYl4bDh9q/IQL0rRaPH7QD4NDqWC+teEwLgvmS82jQt4
	YUbUpq3B2GNLIUQAkKuy2I/2DGAeKl/VEJ/Sqpo05xCNIkQxNOOhBdAbLBZySxRd731o4XgfwhMgr
	c7BXf8WgMX2zbzOIIIo9//CJFwu7B+5WIoaI9dp2WvyX/IeSqvOuv0ibAHLrGZaCTrnXuAE03kmuN
	IwkCAbxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD3Ni-0000000AX8D-3lKX;
	Fri, 31 May 2024 14:37:22 +0000
Received: from smtp29.i.mail.ru ([95.163.41.68])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD3Nc-0000000AX7R-2fXW
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 14:37:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=EEZUDPG8IaESZsyP/PkDdrfoGtanN7ZjWLyO9o1BDNs=; t=1717166233; x=1717256233; 
	b=dOv/BY0Cgz3YkgNnX5MBcgBh1GkQpipadLFkIKtUpoe85KkLjjsIgqyxDkH6EAsErH2V3X5WjA+
	uodLrkhQg9IKraWWn8MW1HN0txkjTeGSWqKYGNUE3T/OZIBf5Aeh/KETsCn3npiTx/5J5IVj/K8A4
	oW8JhuVam0lyUdPlozJ9OAq2c1cWpWVbrWfzFTd0jao8bHcwqt39vDyJybmhoiCYB/OLnt9Y+uS6u
	dazNFs+vEB/agH4/gl6JucBOnAr9pewky48u0f01y2E2gx+AmnlWfYkL5edD6/hAjMFUm+XnkbEK6
	Fydq60Xw0AnuQhgCKzbe/xry0fOjAhwclXGQ==;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <m.lombardi85@mail.ru>)
	id 1sD3NV-000000051dS-2K3X; Fri, 31 May 2024 17:37:10 +0300
Date: Fri, 31 May 2024 16:37:06 +0200
From: Maurizio Lombardi <m.lombardi85@mail.ru>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: blktests nvme 041,042 leak memory
Message-ID: <ZlngkgSTK6IPcVc9@kalibr>
References: <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
 <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
 <93883147-490d-4065-a741-3e49288ea3af@grimberg.me>
 <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
 <Zlipe2FVAIRmas1e@kbusch-mbp.dhcp.thefacebook.com>
 <CAFL455kq_prujkCbNUwJzpqhL1B_P_Yu+b83kBSc0FQRAhQs8w@mail.gmail.com>
 <CAFL455ndGuGRCv7X6S6qtiEi6KhBs_sxgeyfzoLCqu6i8TyNuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFL455ndGuGRCv7X6S6qtiEi6KhBs_sxgeyfzoLCqu6i8TyNuQ@mail.gmail.com>
Authentication-Results: smtp29.i.mail.ru; auth=pass smtp.auth=m.lombardi85@mail.ru smtp.mailfrom=m.lombardi85@mail.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9F634E6C4921FF12D5775A4C805B6A3A271F27ED70B9B8D9300894C459B0CD1B9F0932195341800AD32A2F8DE070D437795445CFFA5883864136E7A862CEDAF2AC7997A56A7FEE5D2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7257031E595304076EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637C218CA8E848E3B7A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83998B16BC632553822B7416D13EA57BDD1E8D9DA1CFCE3AD20879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F7900637FD2911E685725BF8389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC85FF72824B19451C6F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CCE135D2742255B35AD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C31580D188F428539ABA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF27ED053E960B195E1DD303D21008E298D5E8D9A59859A8B6D52CD31C43BF465F75ECD9A6C639B01B78DA827A17800CE79C3ED69499EF45C2731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A59C7CF1274AE060C95002B1117B3ED696269414DB680EBC62886DC9BC01168B20823CB91A9FED034534781492E4B8EEADB73CFAAED92B6E13BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE3942288C290C15E59FFEC89FBF059EB17755D8270B0AA82581008E121471C1020A397324AFDE1B899DA2A9D3DD19F1F2B9F1F4849A5D7B3B8DA260F25701C299EC3E2B6BD11A7AA36DDF96CB8D31E6A913E6812662D5F2AAF96C8710EA0325A80F89563ADA45E48C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj0sbWSqVKv8rqIg/kznEGiw==
X-Mailru-Sender: A8F475CF1C824D1CBA77B1F2B8087B00C121490C1A767CDE4A63FE079F7B704DBD2C6B34D9420DB20D9A4B9E5233F3B4D8A79CCC3C8D74D41DFF15BC5ABCB624EF07C4B4834D601BDC6127B08F856444D0E43066D6DAA6349E6661CE6659AC881C93572D6AD3136CB4A721A3011E896F
X-Mras: Ok
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_073717_239835_1E78B75F 
X-CRM114-Status: GOOD (  16.34  )
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

V Fri, May 31, 2024 at 01:55:03PM +0200, Maurizio Lombardi napsal(a):
> Maybe a better idea:
> 
> move device_initialize() to the very beginning of nvme_init_ctrl()
> initialize ctrl->instance to a negative value, so we can check in the
> .release() method if we have to call ida_free() or not.
>

This is how it would look like, I did some base testing with TCP

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 371e14f0a203..f809a4fc23f9 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -886,7 +886,7 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_wait);

-static void nvme_ctrl_auth_work(struct work_struct *work)
+void nvme_ctrl_auth_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, dhchap_auth_work);
@@ -934,14 +934,13 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 				 "qid %d: authentication failed\n", q);
 	}
 }
+EXPORT_SYMBOL_GPL(nvme_ctrl_auth_work);

 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dhchap_queue_context *chap;
 	int i, ret;

-	mutex_init(&ctrl->dhchap_auth_mutex);
-	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
 		return 0;
 	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 954f850f113a..e775c4df9af5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4572,14 +4572,16 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;

-	if (!subsys || ctrl->instance != subsys->instance)
+	if (ctrl->instance >= 0 &&
+			(!subsys || ctrl->instance != subsys->instance))
 		ida_free(&nvme_instance_ida, ctrl->instance);
 	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	nvme_auth_stop(ctrl);
 	nvme_auth_free(ctrl);
-	__free_page(ctrl->discard_page);
+	if (ctrl->discard_page)
+		__free_page(ctrl->discard_page);
 	free_opal_dev(ctrl->opal_dev);

 	if (subsys) {
@@ -4610,6 +4612,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
+	mutex_init(&ctrl->dhchap_auth_mutex);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	xa_init(&ctrl->cels);
 	init_rwsem(&ctrl->namespaces_rwsem);
@@ -4621,6 +4624,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
+	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
+
 	init_waitqueue_head(&ctrl->state_wq);

 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
@@ -4631,16 +4636,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,

 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
-	ctrl->discard_page = alloc_page(GFP_KERNEL);
-	if (!ctrl->discard_page) {
-		ret = -ENOMEM;
-		goto out;
-	}

-	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
-	if (ret < 0)
-		goto out;
-	ctrl->instance = ret;
+	ctrl->instance = -1;

 	device_initialize(&ctrl->ctrl_device);
 	ctrl->device = &ctrl->ctrl_device;
@@ -4654,16 +4651,28 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		ctrl->device->groups = nvme_dev_attr_groups;
 	ctrl->device->release = nvme_free_ctrl;
 	dev_set_drvdata(ctrl->device, ctrl);
+
+	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
+	if (ret < 0)
+		goto out;
+
+	ctrl->instance = ret;
 	ret = dev_set_name(ctrl->device, "nvme%d", ctrl->instance);
 	if (ret)
-		goto out_release_instance;
+		goto out;
+
+	ctrl->discard_page = alloc_page(GFP_KERNEL);
+	if (!ctrl->discard_page) {
+		ret = -ENOMEM;
+		goto out;
+	}

 	nvme_get_ctrl(ctrl);
 	cdev_init(&ctrl->cdev, &nvme_dev_fops);
 	ctrl->cdev.owner = ops->module;
 	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
 	if (ret)
-		goto out_free_name;
+		goto out_put_ctrl;

 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
@@ -4684,14 +4693,9 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
-out_free_name:
+out_put_ctrl:
 	nvme_put_ctrl(ctrl);
-	kfree_const(ctrl->device->kobj.name);
-out_release_instance:
-	ida_free(&nvme_instance_ida, ctrl->instance);
 out:
-	if (ctrl->discard_page)
-		__free_page(ctrl->discard_page);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cacc56f4bbf4..b0e378e6ca63 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1124,6 +1124,7 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 #ifdef CONFIG_NVME_HOST_AUTH
 int __init nvme_init_auth(void);
 void __exit nvme_exit_auth(void);
+void nvme_ctrl_auth_work(struct work_struct *work);
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 51a62b0c645a..bc749bebe134 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2302,7 +2302,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
 	if (ret)
-		goto out_kfree_queues;
+		goto out_put_ctrl;

 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
 	WARN_ON_ONCE(!changed);
@@ -2322,12 +2322,11 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,

 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
+out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
-out_kfree_queues:
-	kfree(ctrl->queues);
 out_free_ctrl:
 	kfree(ctrl);
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b5e4327fe83..9787a4fdbb00 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2759,7 +2759,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,

 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
 	if (ret)
-		goto out_kfree_queues;
+		goto out_put_ctrl;

 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		WARN_ON_ONCE(1);
@@ -2782,12 +2782,11 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,

 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
+out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
-out_kfree_queues:
-	kfree(ctrl->queues);
 out_free_ctrl:
 	kfree(ctrl);
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e589915ddef8..6d1359915b6c 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -550,10 +550,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,

 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
-	if (ret) {
-		kfree(ctrl);
+	if (ret)
 		goto out;
-	}

 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		WARN_ON_ONCE(1);
@@ -611,8 +609,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	kfree(ctrl->queues);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
 out:
+	nvme_put_ctrl(&ctrl->ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);
--
2.43.0


