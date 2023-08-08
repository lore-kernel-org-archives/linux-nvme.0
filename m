Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A1EC001DF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 10:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TEtH5yVIZkcHhXlx7zXOq0kKCJ4wWHrHIE0jkzlzuw=; b=o3UQi5GlvbPNmdUr9X2HWnXfE0
	RMpGQC540wv73eX7+/UehU+NxG0/j+839yu+3n7WF+XD7URaQQNM7aF+5Qkam16vw1AlsJ0f5ZaHZ
	93ZGYsf0cwQL4ywyRw8uc8Nzmid72UvVEGPWabjcGS3sX4HtlZuh3+9DtKVBmRMiN3sE1t4wcdTtC
	pwbOff8e3Y0DvfXRlvkk2+RMKGw9UMZkNNRGy3xWJPtxqlvUdhEqBl05yx79xZlXvJa6PERQKOFZh
	XWV/i2vzA/gcgGOvS1FuOn5j9m4fpstcckyrQnbubbWoR5p1RgOIACyE+k0Dzqx3+3n6MZzEGWiXT
	kJVFusLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKBk-002K1o-1I;
	Tue, 08 Aug 2023 10:43:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTKBe-002JtH-0Y
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 10:43:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691491417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TEtH5yVIZkcHhXlx7zXOq0kKCJ4wWHrHIE0jkzlzuw=;
	b=euzjuy3eDhP6rDV61bpQGZ+Da625yw7272E6CVO8EWFhk9a0Dj9tJJ8+3sBIcFzcI9gLJi
	mmM4j8Y4H/ETcNmN+zcY9F+8sn5PU3fZ4MZ/okfTK+QckoKh+NEmeVAFhfaP2r7+OGvqqF
	ocX6Eu+vk8Si3se4QAplmkcMG/nO43w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-leUcPBTANJW2QpPc0r0CxA-1; Tue, 08 Aug 2023 06:43:33 -0400
X-MC-Unique: leUcPBTANJW2QpPc0r0CxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 604A785CCE1;
	Tue,  8 Aug 2023 10:43:33 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C31B140E962;
	Tue,  8 Aug 2023 10:43:32 +0000 (UTC)
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
Subject: [PATCH V3 13/14] scsi: storvsc: limit max allowed nr_hw_queues
Date: Tue,  8 Aug 2023 18:42:38 +0800
Message-Id: <20230808104239.146085-14-ming.lei@redhat.com>
In-Reply-To: <20230808104239.146085-1-ming.lei@redhat.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_034338_309699_6FE05C30 
X-CRM114-Status: GOOD (  14.23  )
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
 drivers/scsi/storvsc_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index f2823218670a..50df040b100d 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -2040,6 +2040,9 @@ static int storvsc_probe(struct hv_device *device,
 			host->nr_hw_queues = storvsc_max_hw_queues;
 		else
 			host->nr_hw_queues = num_present_cpus;
+		if (host->nr_hw_queues > scsi_max_nr_hw_queues())
+			host->nr_hw_queues = scsi_max_nr_hw_queues();
+
 	}
 
 	/*
-- 
2.40.1


