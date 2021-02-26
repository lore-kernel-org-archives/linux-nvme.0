Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AFAC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 07:53:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33ECE64EE1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 07:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33ECE64EE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wUPdOAJg7mr9kDyazvh2aegqomnkwItWydCGL3M0vrA=; b=FGTNa+1LggNg6A7OQR/0p3fCpX
	PLB8OJVRF4qAB+rQKb0onNpsbz5LRfK5jbb9HHgK3RqX3XBLtkUgNRHxLCYY69Z+toA1XZ1BnWp+x
	iLM64mX4PZ5f/IVsVdDgXy/DC/+YrPVBEEJ6n1/WtwNLBkVgFWcf0G9a1WI/YML73+5u6NHwnWg73
	mTTjYohQmWN2TnN5mWGV4O4EMbLDIabIyoYSluMLSFAXkSl7oEqwKh1VdZTykAjtx4F254Wk47lnY
	SLLih4/jOoCiry4JobOci1wF9v97plJcOgkMcPWppZVTxMxToRiGfgNPfW95G0fevk+xoF1smjOSC
	/XMTwSrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFXvn-0002V6-QJ; Fri, 26 Feb 2021 07:52:59 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFXvl-0002Ug-NN
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 07:52:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 50F92AAAE;
 Fri, 26 Feb 2021 07:52:56 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Keith Busch <keith.busch@wdc.com>
Subject: [PATCH] nvme: add 'kato' sysfs attribute
Date: Fri, 26 Feb 2021 08:52:51 +0100
Message-Id: <20210226075251.108025-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_025257_913223_AE3B51DB 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: Martin George <marting@netapp.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a 'kato' controller sysfs attribute to display the current
keep-alive timeout value (if any). This allows userspace to identify
persistent discovery controllers, as these will have a non-zero
KATO value.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1d5fc8a6fd37..9ad23472ac15 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3547,6 +3547,7 @@ nvme_show_int_function(cntlid);
 nvme_show_int_function(numa_node);
 nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
+nvme_show_int_function(kato);
 
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
@@ -3749,6 +3750,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_ctrl_loss_tmo.attr,
 	&dev_attr_fast_io_fail_tmo.attr,
 	&dev_attr_reconnect_delay.attr,
+	&dev_attr_kato.attr,
 	NULL
 };
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
