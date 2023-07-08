Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D7CEB64DA
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Jul 2023 02:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2cuKCmBQa82KcQVBvKsR3Bqh6Wey0jvyzaoVZ21LvA=; b=FMjMoYhKx044VFMQ8hHqp2is5d
	ArleQQJvYmswDPOD2zX+fJ3l7EjNfCAdSBmcEqVZI7WlPNAztPOqdtDbWLZZ/cnZCxEFzp0wTYLYN
	YV+Q+sjKC45mtYIWJlbPByT5dYN8nn1b8EhOnTGX5wzOtSfevXCxbY1bPPo2tYD1ScbkoMb1Ol4ph
	km8CU/qN3lfpSvLvNSFfTO789YyYQ3cwp/b+fCPkEc/5p8JdEbbiysfBOVriB9IaGZ8aY/LStxORy
	XhRBiAapaKhIf84ZVmXdY+IlUqzohoo4671rE6Mbp+eTJ/HImFqeHB97c6mymJKf9A4a+USYTvPt7
	Suq+YaaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHxI8-006Iq4-0I;
	Sat, 08 Jul 2023 02:03:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHxI5-006Iol-1X
	for linux-nvme@lists.infradead.org;
	Sat, 08 Jul 2023 02:03:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688781796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2cuKCmBQa82KcQVBvKsR3Bqh6Wey0jvyzaoVZ21LvA=;
	b=NTisXJwcOlYD4aR23GnfAOOnsVS1hnZbIarFzmGe1YKSqJX13tWTJdE2ObD0cDkZC66Bkv
	u1djWOBCo8xhVA8majRyUHj825UudYmkyTw7iHKp6WEwpfW8xo8sZMFRoGngjGKASIWjFF
	2tgcC3f2TxD+4XUT20+iTj8pNvuHIV0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-WrHccZDQOh-DDZC09KWaMA-1; Fri, 07 Jul 2023 22:03:12 -0400
X-MC-Unique: WrHccZDQOh-DDZC09KWaMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82329101A529;
	Sat,  8 Jul 2023 02:03:11 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A652D4087C6B;
	Sat,  8 Jul 2023 02:03:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate io queues
Date: Sat,  8 Jul 2023 10:02:59 +0800
Message-Id: <20230708020259.1343736-3-ming.lei@redhat.com>
In-Reply-To: <20230708020259.1343736-1-ming.lei@redhat.com>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_190317_585660_03855CAF 
X-CRM114-Status: GOOD (  14.90  )
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
still returns all CPUs.

But blk-mq can only support single queue for kdump kernel, this way
causes wrong queue mapping taken for handling IO, and IO timeout
is triggered.

Meantime, single queue makes much less resource utilization, and reduce
risk of kernel failure.

Reported-by: Wen Xiong <wenxiong@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72725729cb6c..cb13ba203956 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2247,7 +2247,7 @@ static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		return 1;
-	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
+	return blk_mq_max_nr_hw_queues() + dev->nr_write_queues + dev->nr_poll_queues;
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
-- 
2.40.1


