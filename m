Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C62EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCq8xRoRgefYdTMPzPs81UzOJXdfZMfyRSilxmWgAGA=; b=cwva0RFxr5RPi+vvn7rJef9tkZ
	cn1Z5KAjp+eb+BnQEJ+r9FS5goDmjVjVyRfiGOeoWG4nEnuopHwpHsMgnG18p8FAw9Ei4WrRSK5p4
	dY/P444MfewTDy7Pv5/ZXgfHESrrIWcBpNnpUGMsw4OyHqwZ8ex0RDvTGs2RVNpsX6UrITMzdumee
	juOkFUYG6SYBYFTw5fdprLdyn5kQOUgulEHVSzYvfVQqgYjWdz3mHpCyFrPyisemVJmi0YnZGtLu7
	Tx/mdo3GoFbZpvmZFTGRmN7ILRpeYDn1IH1VGyozT15DkDWMm6bclht6DC3a6MowBl6D3XRUv556L
	Zb1jBZzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWGF-00Fsan-2g;
	Wed, 28 Jun 2023 14:35:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWGC-00FsaC-2j
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 14:35:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 31D3B6133B;
	Wed, 28 Jun 2023 14:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13661C433C8;
	Wed, 28 Jun 2023 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687962907;
	bh=SoYEiMCAJ933BAt+0O/4yhFG8Ayk3K3QxicFuOWsNh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLBRsUBLAIVRs27Z82I6Ru7Mg3cULGPtveTXNmuqnAvYtRMH98wslkiNROvYc8jjt
	 wfWKToVOhfzNx+5wd4rFwfCzBmpSZxnZr6K4yefzvARXP5ydl+EChRBeYFw8dds/d3
	 TY+pI9/ELHb+onX15X19+uXZUssWrApsJ3eJ64316rqZBFWjQXNWdWN6YdfVqdKfjJ
	 WG2ujISQJ5IMopRf95YyPLEcab97t8Wqql9MU/IHM/XLOP/JG6j/DRtmdDu46iZQPA
	 2lChnWwdDLxNXsH/EiR+eG+FDKKWwtYOjwZ45HjoA/7gRcxaJ0Kp3cmsO11DRjeXvG
	 gO7gLJn9+291Q==
Date: Wed, 28 Jun 2023 08:35:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJxFGCziTP+0Yb2n@kbusch-mbp.dhcp.thefacebook.com>
References: <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
 <ZJuNKGy5dXPC6i+H@ovpn-8-21.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJuNKGy5dXPC6i+H@ovpn-8-21.pek2.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_073508_948628_81C93DC8 
X-CRM114-Status: GOOD (  15.31  )
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

On Wed, Jun 28, 2023 at 09:30:16AM +0800, Ming Lei wrote:
> That may not be enough:
> 
> - What if nvme_sysfs_delete() is called from sysfs before the 1st check in
> nvme_reset_work()?
> 
> - What if one pending nvme_dev_disable()<-nvme_timeout() comes after
> the added nvme_unquiesce_io_queues() returns?

Okay, the following will handle both:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b027e5e3f4acb..c9224d39195e5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2690,7 +2690,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
 		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
 			 dev->ctrl.state);
-		return;
+		result = -ENODEV;
+		goto out;
 	}
 
 	/*
@@ -2777,7 +2778,9 @@ static void nvme_reset_work(struct work_struct *work)
 		 result);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_dev_disable(dev, true);
+	nvme_sync_queues(&dev->ctrl);
 	nvme_mark_namespaces_dead(&dev->ctrl);
+	nvme_unquiesce_io_queues(&dev->ctrl);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 }
 
--

