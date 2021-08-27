Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF56C432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 19:06:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD43E60F39
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 19:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD43E60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fHYO1wUuYMg/uzzPyCroWKe/571b2xFVX8HEazYIuwc=; b=IjHjlUKARw1b2C
	ibylSi3Ugk/wTf29najSuD9igoKTrp553C4EHO5Xc4d0IlcnyjKO/idM9F0OArmewN9YrQK0+Ky/k
	41h79CncB2yWKVuY+7ZN0+1c3hysZ6t55ddbanO3iTktqfZ2DxBT0kTv2gVSIBi69fnX6uLQwd9n6
	UHVXj5piS3BpayHSO/CdFrfoUY63wCTSUb1lU4hSLJx7WafnCXjqXxmyTTTM32qKYd9RCO5+Q3tSt
	AmCppRz403AT0MDkpimwp6sJ1WGRFaf9psIukfTJ781/FP/lDBNmVpcInenkR5yHEbDYWJhTRXkxc
	a2TfFhoh+9mixU/jsjsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJhAz-00D1md-4g; Fri, 27 Aug 2021 19:06:05 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mJhA1-00D1L5-BD; Fri, 27 Aug 2021 19:05:05 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com
Cc: hch@infradead.org, hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 3/6] nvme: add error handling support for add_disk()
Date: Fri, 27 Aug 2021 12:05:01 -0700
Message-Id: <20210827190504.3103362-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827190504.3103362-1-mcgrof@kernel.org>
References: <20210827190504.3103362-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8679a108f571..687d3be563a3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3763,7 +3763,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 
 	nvme_get_ctrl(ctrl);
 
-	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
+	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
+		goto out_cleanup_ns_from_list;
+
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
@@ -3773,6 +3775,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 
 	return;
 
+ out_cleanup_ns_from_list:
+	nvme_put_ctrl(ctrl);
+	down_write(&ctrl->namespaces_rwsem);
+	list_del_init(&ns->list);
+	up_write(&ctrl->namespaces_rwsem);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
