Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD92C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmUiY9ZEjEZGC2aGfwSm6xcWZAuN4JLkyu/tzL/ne3A=; b=kA9xJRmeu5jWG3yG040IutfmDU
	dFeIMwiz4kNg7x9t6VRwHhNIXa5sABoE9NBIEk9MrwDK//APhZh6cemUNpzukGP53gRDRulJoS1Xk
	U5CHiv8N0h0ye6P0ZP9NcMsPwzqT7XKsjSMlb3nsvdSl7aXAAhslIAqyRjTX43wOhNL4IkHo8RVBk
	ZzZzWKkW/WwZVknJjQ4McDeKRFqFY4Lb+jvlSZ4n/8vL75Yo018AYaxMG6Sx60jcExdV0BaSHIAhj
	4tph+8HEwFAM7t4vJAQEuBlwQj6x8d6R0HdqiaRA4PIns79CFoDqQRkrIj+BOXbSVoT2afd8mYQ4N
	g+J9XaIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA9tz-00000006Z5M-3Wrf;
	Thu, 23 May 2024 14:58:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA9tw-00000006Z4X-1z0g
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 14:58:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716476318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmUiY9ZEjEZGC2aGfwSm6xcWZAuN4JLkyu/tzL/ne3A=;
	b=gLs/QobtWTQ74xp4YZQl2aDOGyI/3c+hTJb3MCrfdWetYB24srGm2qJcRr6Jr/4xwiqk36
	Z27DUdfSpeZkqH7YEs6Sq8ksm3dgqqtYRFb2tYen1j6rUwA0UXRz5ZbWCtbohFGNQAwNjD
	kyOqnGpzhI7QzCJgTkgP/8q/NlXf0KU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-tewdWmgVOpuCWGIP_MSJ5g-1; Thu,
 23 May 2024 10:58:31 -0400
X-MC-Unique: tewdWmgVOpuCWGIP_MSJ5g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37ED429AA386;
	Thu, 23 May 2024 14:58:31 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1029440004D;
	Thu, 23 May 2024 14:58:31 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id EFD8930C1C33; Thu, 23 May 2024 14:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id EBDAF3FB4F;
	Thu, 23 May 2024 16:58:30 +0200 (CEST)
Date: Thu, 23 May 2024 16:58:30 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
    Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: [PATCH v2] block: change rq_integrity_vec to respect the iterator
In-Reply-To: <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
Message-ID: <7060a917-6537-4334-4961-601a182bca54@redhat.com>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com> <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com> <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_075840_611523_4C45DE9F 
X-CRM114-Status: GOOD (  24.03  )
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



On Wed, 15 May 2024, Jens Axboe wrote:

> On 5/15/24 7:28 AM, Mikulas Patocka wrote:
> > @@ -177,9 +177,9 @@ static inline int blk_integrity_rq(struc
> >  	return 0;
> >  }
> >  
> > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> >  {
> > -	return NULL;
> > +	BUG();
> >  }
> >  #endif /* CONFIG_BLK_DEV_INTEGRITY */
> >  #endif /* _LINUX_BLK_INTEGRITY_H */
> 
> Let's please not do that. If it's not used outside of
> CONFIG_BLK_DEV_INTEGRITY, it should just go away.
> 
> -- 
> Jens Axboe

Here I'm resending the patch with the function rq_integrity_vec removed if 
CONFIG_BLK_DEV_INTEGRITY is not defined.

Mikulas


From: Mikulas Patocka <mpatocka@redhat.com>

If we allocate a bio that is larger than NVMe maximum request size, attach
integrity metadata to it and send it to the NVMe subsystem, the integrity
metadata will be corrupted.

Splitting the bio works correctly. The function bio_split will clone the
bio, trim the iterator of the first bio and advance the iterator of the
second bio.

However, the function rq_integrity_vec has a bug - it returns the first
vector of the bio's metadata and completely disregards the metadata
iterator that was advanced when the bio was split. Thus, the second bio
uses the same metadata as the first bio and this leads to metadata
corruption.

This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
instead of returning the first vector. mp_bvec_iter_bvec reads the
iterator and advances the vector by the iterator.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/nvme/host/pci.c       |   14 +++++++++++---
 include/linux/blk-integrity.h |   12 ++++--------
 2 files changed, 15 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/nvme/host/pci.c
===================================================================
--- linux-2.6.orig/drivers/nvme/host/pci.c
+++ linux-2.6/drivers/nvme/host/pci.c
@@ -821,18 +821,20 @@ out_free_sg:
 	return ret;
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
 static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio_vec bv = rq_integrity_vec(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
-			rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
 	return BLK_STS_OK;
 }
+#endif
 
 static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
@@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
 			goto out_free_cmd;
 	}
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
 	if (blk_integrity_rq(req)) {
 		ret = nvme_map_metadata(dev, req, &iod->cmd);
 		if (ret)
 			goto out_unmap_data;
 	}
+#endif
 
 	nvme_start_request(req);
 	return BLK_STS_OK;
+#ifdef CONFIG_BLK_DEV_INTEGRITY
 out_unmap_data:
 	nvme_unmap_data(dev, req);
+#endif
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
@@ -962,12 +968,14 @@ static __always_inline void nvme_pci_unm
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
 	if (blk_integrity_rq(req)) {
 	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+			       rq_integrity_vec(req).bv_len, rq_dma_dir(req));
 	}
+#endif
 
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
Index: linux-2.6/include/linux/blk-integrity.h
===================================================================
--- linux-2.6.orig/include/linux/blk-integrity.h
+++ linux-2.6/include/linux/blk-integrity.h
@@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
  * Return the first bvec that contains integrity data.  Only drivers that are
  * limited to a single integrity segment should use this helper.
  */
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
-	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
-		return NULL;
-	return rq->bio->bi_integrity->bip_vec;
+	WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
+	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
+				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
@@ -177,9 +177,5 @@ static inline int blk_integrity_rq(struc
 	return 0;
 }
 
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
-{
-	return NULL;
-}
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 #endif /* _LINUX_BLK_INTEGRITY_H */


