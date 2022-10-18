Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0F5C43217
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TH33nrj0jL9KzFUPlVnuG9wneZydHB3fQz7G7TL+p7k=; b=e4Ycwjspn3ktaa4enwQwuLUDhB
	AsB8rycnxDmb3oKWWacqP43BSZIfni00DkQMuCL5sEBrYAWOIv5UZYw2NXEkhIW7YBR2/gU+gjGcA
	J2yav5H9sakmbtxCrHtyiBynjcZvC+k6iBm1bxDkWtIzK6hJ7KBfzmy3DHYSy05auFfbw7cQdQbvD
	BrJN2cJZ5+opHWdHz3dbCO0dU942tbCEtGVDW7/bvNmzHsD34+OR1DWrwPY6Eo2WQe5b1C5J38JOn
	mzVTXjr3pHJguvQeaZJDAmD/feNmtia6uu+BNJBw19+tovmMY21xzQBc9pLJMoNlqz22LGHxU1mnM
	1vnSkLrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoRA-007Zjf-Rr; Tue, 18 Oct 2022 15:23:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoR0-007ZaH-4T
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:23:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2A2368C4E; Tue, 18 Oct 2022 17:23:09 +0200 (CEST)
Date: Tue, 18 Oct 2022 17:23:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	fancer.lancer@gmail.com, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018152309.GB22639@lst.de>
References: <20221018145808.681327-1-hch@lst.de> <Y07C/FdD3mpKgBjN@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07C/FdD3mpKgBjN@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_082314_359962_D072B43D 
X-CRM114-Status: GOOD (  17.93  )
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

On Tue, Oct 18, 2022 at 09:15:08AM -0600, Keith Busch wrote:
> We still need to check for < 0 since nvme_hwmon_init() sends an admin
> command. If the admin command times out, the controller is reset and
> -EINTR is returned, indicating we have to abort initialization. All
> other errors should be ignored, though, since the controller remains
> usable.

So I guess we should just ignore everything but EINTR, e.g.:


diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 0a586d7129201..aed245678315f 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return 0;
+		goto err;
 
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
@@ -247,11 +246,22 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
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
+err:
+	/*
+	 * Do not return errors unless we are in a controller reset.
+	 * The controller works perfectly fine without the hwmon registration.
+	 */
+	if (err == -EINTR)
+		return -EINTR;
+	return 0;
 }
 
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
-- 
2.30.2


