Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C17C27C44
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0V4okOI9JSCbrdXGbY8ZlnNET05xXlUWVB3ySJdkaz8=; b=JLlEra/2rYLZcfqYxVKo9ecWNK
	TgVYzp9CRwUly/UL76SqrmFGRGynsGlztlPXMisDjtN1n+T3nhKK2/92Ilg5S/cSARlYRydqZSR7C
	kAUhj7Z3JujvjRJz5ScvXA+R7WpDcR6q5e11fX0aNmK+EfTJfbPnC3WGAApnKmDNXcDyiLyW0MxBC
	q4Zyv31sM6/ct83qcG7hDMpwNMECBTvJAcKa38cLx4FjAWSMRgSMUEWnYiiFMMTLf1ekf5kAPMk1w
	R9bnaSOuDJLSwErQS1KLkrjt4jhQWxhrN7jPonCo2rK0to/hMv2srq1YEw/mXJGeZb7HuugsaIARn
	NYSsPyxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCM7C-00000004tyE-0WfR;
	Wed, 29 May 2024 16:25:26 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCM79-00000004txl-46ag
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 16:25:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2B363CE0138;
	Wed, 29 May 2024 16:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4861C113CC;
	Wed, 29 May 2024 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716999921;
	bh=BFlX1dFPy3rO+iHqHs3v6FO4qzQGcsfwWIfwFpI4Zes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrWFCOOqxmcg93ukU6ZvqFkaLWgl4QXyazdI2lzDULih8lcAjhe1OXEYb7hcO2Ac7
	 QJUaFObAf10ie79B5qw2Wpqkc2fvm1jVi5M7Jnto94ZqnxqojHce28fzyCRwBpN5Tw
	 u4HnR5i9Yar3koA+yWGA7EOKluKy9r6+e0byIwN/HR+iHfWIeuu1giZZd0E43fv6dt
	 k0yaYMVsTFE9l4SYU2dCJwxACFssbRXkcCHFDtvXuzn7AFv3H6AJA7u8HgkrtY6IAl
	 WcvM9DYBbjTxL/sLUDIjJAmB3XMOIvguqKdr3CL8uQAbfMrhUzzi66CGyGBoc+T87d
	 nzqMp/f+P8ZQg==
Date: Wed, 29 May 2024 10:25:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Maurizio Lombardi <mlombard@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: blktests nvme 041,042 leak memory
Message-ID: <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_092524_516520_065F0A50 
X-CRM114-Status: GOOD (  16.90  )
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

On Wed, May 29, 2024 at 03:51:09PM +0300, Sagi Grimberg wrote:
> 
> But this is ugly...

I agree. Could we not work around the device model instead? Once we call
device_add successfully, we really need to pair that with a device_del.

I see two ways we might be able to do this.

First suggestion: move the device_add to the end so we don't have to
worry about cleaning up if subsequence actions fail. And auth_init_ctrl
doesn't appear to have any dependency on the ctrl->device anyway.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5d150c62955d..d86db6a193fcb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4675,12 +4675,16 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_release_instance;
 
+	ret = nvme_auth_init_ctrl(ctrl);
+	if (ret)
+		goto out_free_name;
+
 	nvme_get_ctrl(ctrl);
 	cdev_init(&ctrl->cdev, &nvme_dev_fops);
 	ctrl->cdev.owner = ops->module;
 	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
 	if (ret)
-		goto out_free_name;
+		goto auth_free;
 
 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
@@ -4692,15 +4696,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
-	ret = nvme_auth_init_ctrl(ctrl);
-	if (ret)
-		goto out_free_cdev;
 
 	return 0;
-out_free_cdev:
-	nvme_fault_inject_fini(&ctrl->fault_inject);
-	dev_pm_qos_hide_latency_tolerance(ctrl->device);
-	cdev_device_del(&ctrl->cdev, ctrl->device);
+auth_free:
+	nvme_auth_free(ctrl);
 out_free_name:
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
--

Second suggestion, let the error handling release the last reference.
The trick here is to not call the "free_ctrl" callback on "new"
controllers, and don't take a ctrl reference until the end.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5d150c62955d..72c9693e1df61 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4601,7 +4601,8 @@ static void nvme_free_ctrl(struct device *dev)
 		mutex_unlock(&nvme_subsystems_lock);
 	}
 
-	ctrl->ops->free_ctrl(ctrl);
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_NEW)
+		ctrl->ops->free_ctrl(ctrl);
 
 	if (subsys)
 		nvme_put_subsystem(subsys);
@@ -4675,7 +4676,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_release_instance;
 
-	nvme_get_ctrl(ctrl);
 	cdev_init(&ctrl->cdev, &nvme_dev_fops);
 	ctrl->cdev.owner = ops->module;
 	ret = cdev_device_add(&ctrl->cdev, ctrl->device);
@@ -4696,13 +4696,16 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_free_cdev;
 
+	nvme_get_ctrl(ctrl);
 	return 0;
 out_free_cdev:
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
-out_free_name:
 	nvme_put_ctrl(ctrl);
+	return ret;
+
+out_free_name:
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_free(&nvme_instance_ida, ctrl->instance);
--

