Return-Path: <SRS0=1Zqd=Y2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F72BCA9ECF
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Nov 2019 00:28:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CAE208E3
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Nov 2019 00:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RuxZVH1c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightbitslabs-com.20150623.gappssmtp.com header.i=@lightbitslabs-com.20150623.gappssmtp.com header.b="QYgD4fHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CAE208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=BoraEmVucACG3823njDOEq3tx0MhQe326DZ5ziATIPQ=; b=Rux
	ZVH1cUX9yV32zjfTkd4t9kwi87lV4RyeHXcM8/V3adD6PBSVTNCcxyOwhxqGDcKySXiPOosVrb3ip
	ktaJFvI4lQyZc9A/M5hIobYPlolwHsko1dK0pG2a63ihKDwwSaC+DQBgZ312zyaZSjeqQbF9vpSk/
	t0kW6NCJrbPW/K2LnbO04rZZXt9YPPXtkZk1IMs11QWcCdKTJUcEHVNaTa2EcAczIzig+rorC0Rbe
	J7FSsrf+6sm03lqyBu2sDYhejwYD4gVk3SzBO49CooC0jzgrLR7y5AUVwdonsBuAA53ePmhVKnNF/
	I47DVzSxzNxHYKQHfjzsCVOeT4xZVsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQhHO-0000Nx-AQ; Sat, 02 Nov 2019 00:28:34 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQhHL-0000NW-8t
 for linux-nvme@lists.infradead.org; Sat, 02 Nov 2019 00:28:32 +0000
Received: by mail-wr1-x443.google.com with SMTP id a15so11161621wrf.9
 for <linux-nvme@lists.infradead.org>; Fri, 01 Nov 2019 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=9xsZmbbNVTBcpLmU7GD7COD7Xy7j5BGpYtq2JOJQov8=;
 b=QYgD4fHgz6jvPaCuWKh5g+hVzKdBQ1TMKowVRH7Oc2JymHpgB6w5MnqCSC10eDkPR4
 bhEEzCTUeE7pPaGzxW/r4d3UxiWpIudL7FqIVPeRbckEfZiW6FSXn25qNbON5RUIxsmp
 kqDq67bBz9L3X4Kj7mwDF97JDQh4CAlwPO1p9Q3/8gIXdSMRF+gGqLK/VL0s7aOll39q
 LBAjWKCI9tPudfbRuRxqzWS5VlXK3PCgeCeVXd01krtURU0me81oASbGzs6wLA+xNQU+
 RRH2PJ5tHTIzAbZ4b0ayZunepregQtpMQ/ysTIpVJKYTFMnON2OZV90BSOO+8VRD8QKy
 oqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9xsZmbbNVTBcpLmU7GD7COD7Xy7j5BGpYtq2JOJQov8=;
 b=TqmBwQSwRABMRHpTk/ziCdOJsrU7MjMghXqVYTTTQibdY6h44VevUWNfQ/tkERkPmh
 wM/R7FZqnAEH0fYZvMwvs8DrZ5rkgqMqNStjOW8FUJPKLIovOZbYtzFbRPv9Xn5miCMQ
 La3x8wyMDvYeZM+CV1OTe+hJt4nwNmFTcylAZTf2+orzd3BQk1xKaUMePsAib2as/F5K
 5bxPoWlBMEJeouchvzhQjqzjxFdQP2AUU54mPbRV9i0K7spPYhD6bh5EYlFNA9Onum6c
 UcwNbTKOQ4vz8VF/c2MeyX4e48Y1yyHHSQtxi9ZSSPuRe9ls3yiml82CKh7Jf5uEE9i0
 tJ4w==
X-Gm-Message-State: APjAAAV2Hom/QlX5uRO+rnXULjTixJDkevx3FJjLrUQlIfxiJJwB3D+u
 4n1JTP7oneK1F1777o7P8QUAZF4wFjQ=
X-Google-Smtp-Source: APXvYqxOccRJK8qnZHdZI7eZIMrrj0dg6LAzdyaynkn59bd7kbPeAJ37N4u17CEd5RTnAx/89nRb0w==
X-Received: by 2002:a5d:5050:: with SMTP id h16mr14051806wrt.380.1572654509038; 
 Fri, 01 Nov 2019 17:28:29 -0700 (PDT)
Received: from anton-latitude..lbits (c-73-92-252-224.hsd1.ca.comcast.net.
 [73.92.252.224])
 by smtp.googlemail.com with ESMTPSA id q2sm7794424wmq.30.2019.11.01.17.28.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Nov 2019 17:28:28 -0700 (PDT)
From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, keith.busch@intel.com,
 sagi@grimberg.me, hare@suse.de
Subject: [PATCH] nvme-multipath: fix crash in nvme_mpath_clear_ctrl_paths
Date: Fri,  1 Nov 2019 17:27:55 -0700
Message-Id: <20191102002755.25165-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.14.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191101_172831_456203_C2CBDBFE 
X-CRM114-Status: GOOD (  10.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Anton Eidelman <anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_mpath_clear_ctrl_paths() iterates through
the ctrl->namespaces list while holding ctrl->scan_lock.
This does not seem to be the correct way of protecting
from concurrent list modification.

Specifically, nvme_scan_work() sorts ctrl->namespaces
AFTER unlocking scan_lock.

This may result in the following (rare) crash in ctrl disconnect
during scan_work:

    BUG: kernel NULL pointer dereference, address: 0000000000000050
    Oops: 0000 [#1] SMP PTI
    CPU: 0 PID: 3995 Comm: nvme 5.3.5-050305-generic
    RIP: 0010:nvme_mpath_clear_current_path+0xe/0x90 [nvme_core]
    ...
    Call Trace:
     nvme_mpath_clear_ctrl_paths+0x3c/0x70 [nvme_core]
     nvme_remove_namespaces+0x35/0xe0 [nvme_core]
     nvme_do_delete_ctrl+0x47/0x90 [nvme_core]
     nvme_sysfs_delete+0x49/0x60 [nvme_core]
     dev_attr_store+0x17/0x30
     sysfs_kf_write+0x3e/0x50
     kernfs_fop_write+0x11e/0x1a0
     __vfs_write+0x1b/0x40
     vfs_write+0xb9/0x1a0
     ksys_write+0x67/0xe0
     __x64_sys_write+0x1a/0x20
     do_syscall_64+0x5a/0x130
     entry_SYSCALL_64_after_hwframe+0x44/0xa9
    RIP: 0033:0x7f8d02bfb154

Fix:
After taking scan_lock in nvme_mpath_clear_ctrl_paths()
down_read(&ctrl->namespaces_rwsem) as well to make list traversal safe.
This will not cause deadlocks because taking scan_lock never happens
while holding the namespaces_rwsem.
Moreover, scan work downs namespaces_rwsem in the same order.

Alternative: sort ctrl->namespaces in nvme_scan_work()
while still holding the scan_lock.
This would leave nvme_mpath_clear_ctrl_paths() without correct protection
against ctrl->namespaces modification by anyone other than scan_work.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 682be6195a95..cb00afac516d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -159,9 +159,11 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->scan_lock);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		if (nvme_mpath_clear_current_path(ns))
 			kblockd_schedule_work(&ns->head->requeue_work);
+	up_read(&ctrl->namespaces_rwsem);
 	mutex_unlock(&ctrl->scan_lock);
 }
 
-- 
2.14.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
