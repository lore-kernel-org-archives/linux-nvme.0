Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3289DC25B76
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 09:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CNFo5g0hRi+i6cIJeOrClKFoitXxxfiMokNmoZsmo8=; b=AVbSra/kocKDLAxTLUBW6FYLg6
	jvvlGsWC/LdzhTJYqSizRMcXlp6qswIiUQ8R0vPwSm0x7ESQB1nssB3j7JoS6JkHYp9dFeoA2Ae9h
	QFN4ZRyS7UpZw13LXwZOFdXCp38YVsn/EktqVzuIW0S4Lnn1+q6XEOD3fLnJRG1hLLsQfW6b97XWD
	wabyQ5FywB2PFL3Wtrrg6COl0AgGM4ZcJLl2nRYvDaRUuqdqsEi0YmADiURrwIZUm47a02V6uurTO
	ROzgwnpzH7JDVtLxfZ922h8owHcqy3nPCR7aHFyVn3Bm4HPHWbcMjCHHU9Kb93KUomtVSIOQbIuoY
	d/M8iPUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE46T-0000000GFja-2P2n;
	Mon, 03 Jun 2024 09:35:45 +0000
Received: from smtp30.i.mail.ru ([95.163.41.71])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE46P-0000000GFh5-0bNW
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 09:35:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=/CNFo5g0hRi+i6cIJeOrClKFoitXxxfiMokNmoZsmo8=; t=1717407338; x=1717497338; 
	b=cEODpgyP9ArMbmeyWf+UGsVxSMamXcIjmtXGCJ5T+GXt4NgHS6+uWhdVWWPX+10ZmRM2w2gyKG3
	le+qQaMa6wTpBBy58l6uzwXxol3e8dBenWhyzz2QwmYjdnpoHhe9/dsArfUeE7eZa9GsR90trROZ+
	uNF/eSu+OTzj3mAgejbUFv/lgvBNi2iu9C6czAHKD/rLoVEjEQa4luanoVcitSaEcHu2W7+Xl1meP
	IJxEemc4BIfxSOY4qi9DQLgNNoBJz3SJZJN9IahoBCjxwaDNo1zn3wG16KVP4dqNbOszmC/J8pH9w
	HPexP611W52d2HUJ1J/5AbH9Z16ro4MSFWZw==;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <m.lombardi85@mail.ru>)
	id 1sE46H-0000000FdMD-1Aep; Mon, 03 Jun 2024 12:35:34 +0300
Date: Mon, 3 Jun 2024 11:35:30 +0200
From: Maurizio Lombardi <m.lombardi85@mail.ru>
To: Hannes Reinecke <hare@suse.de>
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: blktests nvme 041,042 leak memory
Message-ID: <Zl2OYgyN0exmIKk0@kalibr>
References: <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
 <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
 <93883147-490d-4065-a741-3e49288ea3af@grimberg.me>
 <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
 <Zlipe2FVAIRmas1e@kbusch-mbp.dhcp.thefacebook.com>
 <CAFL455kq_prujkCbNUwJzpqhL1B_P_Yu+b83kBSc0FQRAhQs8w@mail.gmail.com>
 <CAFL455ndGuGRCv7X6S6qtiEi6KhBs_sxgeyfzoLCqu6i8TyNuQ@mail.gmail.com>
 <ZlngkgSTK6IPcVc9@kalibr>
 <8058afc6-8272-42fa-a024-e477a29148e1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8058afc6-8272-42fa-a024-e477a29148e1@suse.de>
Authentication-Results: smtp30.i.mail.ru; auth=pass smtp.auth=m.lombardi85@mail.ru smtp.mailfrom=m.lombardi85@mail.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F634E6C4921FF12DE67FB2CFD1D320ED62F032EB0E50ECA500894C459B0CD1B992F89E3F1328AD6E49397DCC231462261DA567273A481B9572C5D88630C25417224C9A2F61B97637
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D63A32B630C59AACEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373C710FAF3667BB888638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8D0A218B8C67FF5C39360F406E97DE96551671A598313DDC720879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C045A75973B56231AD8941B15DA834481FA18204E546F3947CA816C540FC8EEC30F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637FBF931FEADDDACF0389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006373D67B33AE81423FDD81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE79CEA59AA0980FD5AEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE7A03E8F3C2D3812562EB15956EA79C166176DF2183F8FC7C0444A83B712AC0148725E5C173C3A84C33C2D715BE4CE1EFB35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5B5750B2D1D9354495002B1117B3ED69644B48B10F0DE82608D59E407A97E9958823CB91A9FED034534781492E4B8EEAD0AA277257C6A5E3DBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD820FCFA723562C51251A4C96932B810FE63B0BEA8253E7148EF2E2E1E6073F04D6C1B221ADCA6645A25C67AD25077CDF2F4CCBF8AB8F5D4DF8720A1A8B189483EAE76459C091E8336DDF96CB8D31E6A913E6812662D5F2AAF96C8710EA0325A80F89563ADA45E48C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxO1G5pUKYoGp3mRxPdL1TA==
X-Mailru-Sender: A8F475CF1C824D1CBA77B1F2B8087B00C4C67F283C8B7E32B82541541FEA4800247D4D94DA40AD1C4C84BE0C2679CC0FD8A79CCC3C8D74D41DFF15BC5ABCB624EF07C4B4834D601BDC6127B08F856444D0E43066D6DAA6349E6661CE6659AC881C93572D6AD3136CB4A721A3011E896F
X-Mras: Ok
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_023541_738395_CF0FC736 
X-CRM114-Status: GOOD (  16.96  )
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

V Mon, Jun 03, 2024 at 10:37:33AM +0200, Hannes Reinecke napsal(a):
> Hmm. Don't really like it.
> We took great pains of moving then entire DH-CHAP code into its own
> file, and this patch reverts it and is causing the DH-CHAP code to be
> littered all over the place.

The following would do the same thing without littering
the auth code around.

But the real problem of this approach is that, in case of failure, the nvme_init_ctrl()
function is unable to cleanly revert all of its changes and cleaning
it up is left to the callers (they have to execute nvme_put_ctrl()).

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 371e14f0a203..df0c8211b381 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -940,6 +940,8 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	struct nvme_dhchap_queue_context *chap;
 	int i, ret;
 
+	ctrl->auth_initialized = true;
+
 	mutex_init(&ctrl->dhchap_auth_mutex);
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
@@ -947,7 +949,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
 			&ctrl->host_key);
 	if (ret)
-		return ret;
+		goto out;
 	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
 			&ctrl->ctrl_key);
 	if (ret)
@@ -977,13 +979,16 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 err_free_dhchap_secret:
 	nvme_auth_free_key(ctrl->host_key);
 	ctrl->host_key = NULL;
+out:
+	ctrl->auth_initialized = false;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
 void nvme_auth_stop(struct nvme_ctrl *ctrl)
 {
-	cancel_work_sync(&ctrl->dhchap_auth_work);
+	if (ctrl->auth_initialized)
+		cancel_work_sync(&ctrl->dhchap_auth_work);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_stop);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 954f850f113a..68b9f2ce98c8 100644
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
@@ -4631,16 +4633,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
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
@@ -4654,16 +4648,28 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
@@ -4684,14 +4690,9 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
index cacc56f4bbf4..c723c51e244a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -368,6 +368,7 @@ struct nvme_ctrl {
 	struct nvme_dhchap_key *host_key;
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
+	bool auth_initialized;
 #endif
 	struct key *tls_key;
 
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


