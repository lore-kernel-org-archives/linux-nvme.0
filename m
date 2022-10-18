Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97689C43219
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hk8rYtcSJUPxhrkQYAtgfqsUEBlrdLQh3LdAvknI5Gc=; b=2EiqdE3p1C7XDPK2vLcU3jPEim
	8MqcboSaqZVvPgKR6a4KTIb/yGibrqC1eTLsNusbF2CYJbkjNSek72uxewQCpfuIoKARFhZfCBxgO
	LspNAL2sAS6opYP0jl+wZsLagP9GXsh3kJk4nXzf52UE9+puW5F2jpnPjOkonTGwEgbjM03g/lC+k
	1AgTC9BHKBjknUT6vyWRGkI++v0h6inr4JTXvtsH9RO3OYppGw8XgIjMQ3ocHgApnXRG6t6D9E3Qe
	2tK9PwWSZBclDq30LSmNTWYXAM2Ty8ci/ZU8ZQureKAz8sL+ez91dZhKMlepIMs6HRFNMDkj2RGNJ
	spexwW4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okohv-007pBN-4r; Tue, 18 Oct 2022 15:40:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okog4-007nWF-CL
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:38:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF2F768C4E; Tue, 18 Oct 2022 17:38:41 +0200 (CEST)
Date: Tue, 18 Oct 2022 17:38:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	sagi@grimberg.me, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018153841.GA24029@lst.de>
References: <20221018145808.681327-1-hch@lst.de> <Y07C/FdD3mpKgBjN@kbusch-mbp.dhcp.thefacebook.com> <20221018152309.GB22639@lst.de> <Y07FoBKCrJibFOY5@kbusch-mbp.dhcp.thefacebook.com> <20221018153136.yjsnmhppwstbcwac@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018153136.yjsnmhppwstbcwac@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_083848_594336_83D4FBFC 
X-CRM114-Status: GOOD (  17.31  )
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

On Tue, Oct 18, 2022 at 06:31:36PM +0300, Serge Semin wrote:
> What about just taking the -EINTR error into account by the
> nvme_hwmon_init() caller and ignore any other there? Meanwhile you can
> convert the nvme_hwmon_init() method to return any error including the
> ENOMEM. Thus the function will be more consistent and will have
> independent from the caller context design.

Yeah, that actually looks a tad cleaner than what I just sent out:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9cbe7854d4883..7c949f44e1db2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3261,9 +3261,13 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Do not return errors unless we are in a controller reset.
+	 * The controller works perfectly fine without the hwmon registration.
+	 */
 	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
 		ret = nvme_hwmon_init(ctrl);
-		if (ret < 0)
+		if (err == -EINTR)
 			return ret;
 	}
 
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 0a586d7129201..23918bb7bdca2 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return 0;
+		return -ENOMEM;
 
 	data->ctrl = ctrl;
 	mutex_init(&data->read_lock);
@@ -238,8 +238,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 	err = nvme_hwmon_get_smart_log(data);
 	if (err) {
 		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
-		kfree(data);
-		return err;
+		goto err_free_data;
 	}
 
 	hwmon = hwmon_device_register_with_info(dev, "nvme",
@@ -247,11 +246,15 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 						NULL);
 	if (IS_ERR(hwmon)) {
 		dev_warn(dev, "Failed to instantiate hwmon device\n");
-		kfree(data);
-		return PTR_ERR(hwmon);
+		err = PTR_ERR(hwmon);
+		goto err_free_data;
 	}
 	ctrl->hwmon_device = hwmon;
 	return 0;
+
+err_free_data:
+	kfree(data);
+	return err;
 }
 
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl)

