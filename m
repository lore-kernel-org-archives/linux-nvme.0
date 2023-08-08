Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B15C04A94
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cH8+J+v5eCSEAo5zzPYOsTrKPWy+zXGNhCQOIixYmz0=; b=DqdS60JyOpLTXyxrNRqfxy0Ixx
	ZG8Mi7aPhKIN5PvgDpQd+HKUnoyVRTjmoJFeduQPzdNvwVplyOEp7E/vV8u2oY3FQtA7KYeu3rxMM
	RLE9YCtIqcCwaG/BS3brN4/ILb+AOuMsnlhQV00SMqlRHLjj6QvQx/yDFcKi7qRuzIWElsFQtE/l/
	TzpMRCYgZfsOHeW2o5/Yc/oFknaWhgFPmiGB57GSxsC2OEbHnIn8BXCPtblzBj+qrvcIam/M9FTdT
	b1wcpY7QIyZ1j/dJqNT5rnVh0CA+zij3JIwE/QRsDw8pkzYQThvuHe8EleNn5j72PqOlg6RnFk6Ei
	vfrXrkWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKBi-002Jyn-0O;
	Tue, 08 Aug 2023 10:43:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKBd-002Js7-1q
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691491416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cH8+J+v5eCSEAo5zzPYOsTrKPWy+zXGNhCQOIixYmz0=;
	b=Ahh9aqdjlaq3y3AQ1IWC7uNicz+7pgWq1BuOo/PMh8KmjMRL5M1p/3Julfh6ybnuIu3kz8
	MaBm9dFKtlwVp4WNL+n6H479cj9ySQL2yhB121t2NgBY9A9Nb8SiNj4oITo3oHXE/Y8Zjl
	NedUVTCDqt5FwC6RntT3gpPwoJQwP7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-ORIgDiMuM2yLXyVmCPXrgg-1; Tue, 08 Aug 2023 06:43:30 -0400
X-MC-Unique: ORIgDiMuM2yLXyVmCPXrgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 363D685CCE1;
	Tue,  8 Aug 2023 10:43:30 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD0C140E962;
	Tue,  8 Aug 2023 10:43:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 12/14] scsi: ufs: limit max allowed nr_hw_queues
Date: Tue,  8 Aug 2023 18:42:37 +0800
Message-Id: <20230808104239.146085-13-ming.lei@redhat.com>
In-Reply-To: <20230808104239.146085-1-ming.lei@redhat.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_034337_701474_95B4DAFC 
X-CRM114-Status: GOOD (  16.25  )
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

Take blk-mq's knowledge into account for calculating io queues.

Fix wrong queue mapping in case of kdump kernel.

On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
`Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
still returns all CPUs because 'maxcpus=1' just bring up one single
cpu core during booting.

blk-mq sees single queue in kdump kernel, and in driver's viewpoint
there are still multiple queues, this inconsistency causes driver to apply
wrong queue mapping for handling IO, and IO timeout is triggered.

Meantime, single queue makes much less resource utilization, and reduce
risk of kernel failure.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/ufs/core/ufs-mcq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 6fb0e007af63..7d808836b018 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -186,7 +186,7 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 
 	if (!hba->nr_queues[HCTX_TYPE_DEFAULT])
 		hba->nr_queues[HCTX_TYPE_DEFAULT] = min3(rem, rw_queues,
-							 num_possible_cpus());
+							 scsi_max_nr_hw_queues());
 
 	for (i = 0; i < HCTX_MAX_TYPES; i++)
 		host->nr_hw_queues += hba->nr_queues[i];
-- 
2.40.1


