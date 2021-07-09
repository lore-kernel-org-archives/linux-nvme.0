Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A379BC07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:12:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F5B613C7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F5B613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j7pEk4+Q8RImm/aewuD/aEzBDfhVgvEAW5dCAtXTCiI=; b=eUTyBIxcOFUAwY
	uElOsy2nAD/MxtckP0RdsQIHSenEXbReKdV+iEodHLsQVNu9hhtt3Iqm/fhTX0Yy3JGoK8rH8sSVt
	JnrdIBaZzSVQqHnXXMh1t4IDU7gXisTiTwD/cO1xITyJUuyb8peYfIgH11k9wSbBHZnYW5hNwkTLj
	REc+qQI7x04vbAmUwLq7j69xFN5JJmCQP0VaNWVrv2BYBztfaX66GsYkzD9QdqHOhO9npUjWaZox+
	ht61QOvQxn2YJ4Aze8EANjTKG/Z3cy3zwY/CL2bYZgGqJJR9mK/wcqGpWOXC9kIQt/fP3cJ004LSq
	Ty6lp1bDoT30nFEkDV3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1lca-0014T1-8B; Fri, 09 Jul 2021 08:12:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1lbT-0013y8-Fy
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625818278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vk9L1G0njXZFju3Oa4mrApnhj5rcqMsMKonFv8gUeQA=;
 b=g7HX0tz/bRAVV+xGk2OLnYajUXEq+1u1lpT118ewF3jneIfPZai1SAaqZewTBB02oo7C1H
 MWQOuf3kNW50rQFx/TpYy+v6SupO0T2Bs1XbQOoAFnsebQNFBwmf4Z/NwqT/U3oe00eK8X
 JYFxj3jkLjKqTXNjMrlwNMQIEwJGhNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-aA_Q4guMN7ur9y0N5-yJzg-1; Fri, 09 Jul 2021 04:11:16 -0400
X-MC-Unique: aA_Q4guMN7ur9y0N5-yJzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B34D81084F40;
 Fri,  9 Jul 2021 08:11:14 +0000 (UTC)
Received: from localhost (ovpn-13-13.pek2.redhat.com [10.72.13.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CE625D6D3;
 Fri,  9 Jul 2021 08:11:09 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 06/10] virito: add APIs for retrieving vq affinity
Date: Fri,  9 Jul 2021 16:10:01 +0800
Message-Id: <20210709081005.421340-7-ming.lei@redhat.com>
In-Reply-To: <20210709081005.421340-1-ming.lei@redhat.com>
References: <20210709081005.421340-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_011119_688589_417CF4AB 
X-CRM114-Status: GOOD (  11.83  )
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

virtio-blk/virtio-scsi needs this API for retrieving vq's affinity.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/virtio/virtio.c | 10 ++++++++++
 include/linux/virtio.h  |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..ab593a8350d4 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -448,6 +448,16 @@ int virtio_device_restore(struct virtio_device *dev)
 EXPORT_SYMBOL_GPL(virtio_device_restore);
 #endif
 
+const struct cpumask *virtio_get_vq_affinity(struct virtio_device *dev,
+		int index)
+{
+	if (!dev->config->get_vq_affinity)
+		return NULL;
+
+	return dev->config->get_vq_affinity(dev, index);
+}
+EXPORT_SYMBOL_GPL(virtio_get_vq_affinity);
+
 static int virtio_init(void)
 {
 	if (bus_register(&virtio_bus) != 0)
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b1894e0323fa..99fbba9981cc 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -139,6 +139,8 @@ int virtio_device_restore(struct virtio_device *dev);
 #endif
 
 size_t virtio_max_dma_size(struct virtio_device *vdev);
+const struct cpumask *virtio_get_vq_affinity(struct virtio_device *dev,
+		int index);
 
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
