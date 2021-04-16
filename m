Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D2AC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 11:47:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDDA61057
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 11:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDDA61057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CLkJJz6MqzZAM/caW7LMTWJWfY0BXYVdG73b8D81LDs=; b=hldMptq+OC9DdmzVs18YPPv7l
	myjJQiQrBG4YdDvdaEr/ypz7lpasAOwaofFUcrPHn4SLPaKUMHz35s1kmJGGRxkDjue/vG+596pfW
	PPhRmRVqsXdsY/OsRHaQ4/z4ln/MKR+54hU52IYS6agyKvvSdJgBIZGNI6H2XYwRPXFIZdyd38W78
	AmkgXutTU0YWeKHjEcAozKkYvI1lU2924O35Tco002Bfv8O3nfo9XYhv7naim0U3jQ9BflQiAv2MY
	B0GYkQXbzg1WzmG+vHAC7MhNzYHv6DoXsu9rfGecHy32imYRIF0Gu+NXxluWrD8PzBaugp3MsOWfS
	B+hYzA++Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXMwE-001yU4-86; Fri, 16 Apr 2021 11:47:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXMve-001yNG-OX
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 11:46:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=3wJ6HgBrEh1mxbKxdB/u1JQtHoOIaE1VMA6VpPF2TqM=; b=c7wIx0kJlYJFYx4dPro7MIGwXN
 hIldLmXLqT47dxGi/jBHEZl8Uqa51iU36HgX7iSwbgclyj9SXYSeTCMTR6l7Oxgk3VIPukJMRge9P
 5EYzpZdsF+n1nbQiHJcpYY/31FdKyk+dw9kOvTQ2d0Pu+2WqvVRKE9h6f+wkxm+rOEHh1M7Z+z97S
 uEKyix9HfBg5m+k1d0ugRpLcM2yspEOBba6656LIiPRTPSoJqz/qt+ZYnRO9mlLbTcf+Y1ZY5CrSs
 3MkIZzhVdVsqMlVdFXchsXjkG3RR7KLLiZ52alCP/qPq3GkGKJ6Rz1AdrQveyZhIS3GwPUVQ8da+b
 AHXKU1cA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXMvb-009KRn-8y
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 11:46:28 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B938CB02A;
 Fri, 16 Apr 2021 11:46:25 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme: add 'kato' sysfs attribute
Date: Fri, 16 Apr 2021 13:46:21 +0200
Message-Id: <20210416114621.129736-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210416114621.129736-1-hare@suse.de>
References: <20210416114621.129736-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_044627_503129_9CFC279A 
X-CRM114-Status: UNSURE (   9.53  )
X-CRM114-Notice: Please train this message.
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

Add a 'kato' controller sysfs attribute to display the current
keep-alive timeout value (if any). This allows userspace to identify
persistent discovery controllers, as these will have a non-zero
KATO value.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f58e196d5b4b..67f0607055e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3173,6 +3173,7 @@ nvme_show_int_function(cntlid);
 nvme_show_int_function(numa_node);
 nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
+nvme_show_int_function(kato);
 
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
@@ -3370,6 +3371,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_ctrl_loss_tmo.attr,
 	&dev_attr_reconnect_delay.attr,
 	&dev_attr_fast_io_fail_tmo.attr,
+	&dev_attr_kato.attr,
 	NULL
 };
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
