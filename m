Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403FEC5DF94
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 23:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lBk9ofAY5su2wW8rAM+OgbzN/EaU3SA9gi2BVAiSaEc=; b=girEsKCkF9Ws0H7kQWrsMgcNYP
	3EZSpXOhYDROySQnT0ciGAwznQ4wFFruuyJy50kN34F9VbjlZrjE7mxSZbmwAd9Bx2vD4UErWzsil
	31Td0v7ijl+jmDqrIWmSrreokGWl3KP7qNDfZgCvYqxW40j65s4isJqZbMjHEbcbjlGm5pDVdMAQx
	Dnc/YnL3pyON32yx0iE5xPgg4b101V6051wbEFirUSsvj8fiywDr0azhnQTP++RRCl6Ecfc4N4H+U
	guHtVDssaK3kIpHB/dhpGfbDYs4+WEB4k6LRCKLMP20XMP4BBjmoDS2CY/niflL8Z9ZkmBYYzzYlU
	U5esFrAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxYGs-0000000E7lZ-2Cyz;
	Fri, 21 Aug 2026 23:03:34 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxYGq-0000000E7l6-1gb9
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 23:03:33 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2d032846c95so18713715ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2026 16:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787353411; x=1787958211; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lBk9ofAY5su2wW8rAM+OgbzN/EaU3SA9gi2BVAiSaEc=;
        b=ZbTXZ5rFb/UO750PET466//MHKmqLZ6T7Ri+JI3kppdQSijqE+Ukk58Mk7rY9XzBcl
         Rz+fuHPxBIz0bdHpOUBjQf5yjGXUEJdLw+HLWLT5fjXT9YvjkXlWxse2v1/Q/KH3RMm3
         27i8+M9ycmTwBJlpsOPrAy+3klGDgA3C93DTGsM/++i1z0/B+pd5r3tJrPf3cK15ABIG
         0RqWMwl+JJ6JiqWn6V1p5bUHJ3PTaPmu/MQ8dCwxZkgCtbl0Y/KIClIoQ0hPJd/wtAUr
         TpAzy/+zGlBU7Z/OgXSUoD4v0XXyZyiWivl8dgZz6A/Hb8amenHiqIe6PkJAJY28iPQV
         xZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787353411; x=1787958211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lBk9ofAY5su2wW8rAM+OgbzN/EaU3SA9gi2BVAiSaEc=;
        b=X3w/wHewHOMDEvz7naE8UEXVfzdRFkp1ZXuqZOsu0bBPod06iDevYY0TpN1t+t5gQE
         17f8l5mNpCxrTa+x1cwFfiuuXb1/ULrxQUrlrYmhsWSt4R1bCUsdlIRLuo8rd7tCNiyB
         8DcqV8WPqBdE1eU0HJYIAqAystYnq344Alba6/yuyZVj0vZ/OvTJKYJ7tNJEGvt81dkg
         5NgZlauNbc/6CK7Y7c10z8H8T0kH8RiX4lxaKvKxZwvVCTudFfFgGKc1uYsqfvl0usqA
         GHQawHW3IzIerA96hiHOo8Qy9Twk+8a4sJliyBII/eC6C95iYC1eyMHQFYoKdt36BcPS
         7xLg==
X-Gm-Message-State: AFuF++mp5AVS3P3yRopNFZmSRoz+DqDa/849awgJm2jx/6uA/YQ333sE
	CgCFVaNRcKn4finB0JayOh93PwP1qJY3VY1YJN59uVhI75k1p8srm16Tr//b3kaTZ1k=
X-Gm-Gg: AR+sD12tZnGvbylIvkohhKch5I9Ta9qi+fNNlZnSRYHewlOephcsG9S3RXIews65hso
	/7/HIkmzv/BKTpcf5JEyglPY9phol08qrj68sh2JWjCBaszeySClTedyG/3FoTgRjIlkvLND6qZ
	l3HMgLh/i2UUy9eRxajmDZf9dZRYePh9cVDtcvLJvx5Q+Jrh3D8du0J/LBE3maZrGzW6vw4dL48
	H5VteMpwPPfii4JuL7ePV+m8Vkfb5XnTmAvvW/vk90Y62cqF38ogaMto/JUwt3kna0V6bMZVyPp
	vZwFbtOaiNpEj7I445KyNZk8+eiMdCGLhBat7NbUlLhvgwj+gBONjdWsLux7NuZ6xQDpCFo8Y5J
	Fb3FTNRHAv3knF+0Tv4G3ygrIHMDujWtmgQcjPof9L3Tr3VzLNbx1kc4OSBQX/hp1Su3CRhf7k+
	ltNCgNoz4Pql/erpLOIXUPFGQR29nK5KCefI8m3u6CvH/2z05WdaRQVkni0vQFSyTlvJHF/oVnh
	hAytqCfH9IuY8qFukNGuXs=
X-Received: by 2002:a17:902:e949:b0:2d6:3c2f:6a5 with SMTP id d9443c01a7336-2d64b1d68bemr198688775ad.14.1787353411263;
        Fri, 21 Aug 2026 16:03:31 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-327f909c6c9sm122799eec.6.2026.08.21.16.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:03:30 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH 2/2] nvmet: print namespace IDs as unsigned 32bit value
Date: Fri, 21 Aug 2026 16:03:10 -0700
Message-ID: <20260821230310.3937527-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821230310.3937527-1-mkhalfella@purestorage.com>
References: <20260821230310.3937527-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_160332_461849_024FE836 
X-CRM114-Status: GOOD (  15.02  )
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

struct nvmet_ns.nsid is a u32, but a few messages print it with %d.
An NSID larger than 0x7fffffff is rendered as a negative number, which
is misleading in general and particularly so for the configfs messages
that echo back the NSID the user just asked for.

For example:
[  T200] nvmet: adding nsid -16 to subsystem mysubsystem

Print them with %u. The invalid-NSID error in nvmet_ns_make() keeps its
%#x because the two values it rejects, 0 and NVME_NSID_ALL, are more
readable in hex format. No functional change other than how the NSID is
formatted.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Fixes: c6925093d0b2 ("nvmet: Optionally use PCI P2P memory")
Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/configfs.c | 4 ++--
 drivers/nvme/target/core.c     | 2 +-
 drivers/nvme/target/pr.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 413ee2d16d29..6286e38436dd 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -814,7 +814,7 @@ static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
 
 	mutex_lock(&ns->subsys->lock);
 	if (ns->enabled) {
-		pr_err("the ns:%d is already enabled.\n", ns->nsid);
+		pr_err("the ns:%u is already enabled.\n", ns->nsid);
 		mutex_unlock(&ns->subsys->lock);
 		return -EINVAL;
 	}
@@ -880,7 +880,7 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
 		goto out;
 	config_group_init_type_name(&ns->group, name, &nvmet_ns_type);
 
-	pr_info("adding nsid %d to subsystem %s\n", nsid, subsys->subsysnqn);
+	pr_info("adding nsid %u to subsystem %s\n", nsid, subsys->subsysnqn);
 
 	return &ns->group;
 out:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d74c01c98f19..ad60b91ced6c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -558,7 +558,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 	if (ret < 0)
 		pci_dev_put(p2p_dev);
 
-	pr_info("using p2pmem on %s for nsid %d\n", pci_name(p2p_dev),
+	pr_info("using p2pmem on %s for nsid %u\n", pci_name(p2p_dev),
 		ns->nsid);
 }
 
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 0948a690a1c0..09d8c63f5680 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -145,7 +145,7 @@ static void nvmet_pr_add_resv_log(struct nvmet_ctrl *ctrl, u8 log_type,
 	log.nsid = cpu_to_le32(nsid);
 
 	if (!kfifo_put(&log_mgr->log_queue, log)) {
-		pr_info("a reservation log lost, cntlid:%d, log_type:%d, nsid:%d\n",
+		pr_info("a reservation log lost, cntlid:%d, log_type:%d, nsid:%u\n",
 			ctrl->cntlid, log_type, nsid);
 		log_mgr->lost_count++;
 	}
-- 
2.54.0


