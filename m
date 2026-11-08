Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE8606D80A
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HucdbAGP;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=RPBYn1qf;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JoCP8mSk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wUNj3zcErgaPzyJWqZg0hX16vWl0qpJJmvLNO3XQBUs=; b=HucdbAGPCDUA1l
	e0FjDhrNcvbp39vv6/o3WA/81O4jEZJi0ScnwlQkjgfkHBbVOA3VL8xd1z+HDHYMN4URiYRMj65/O
	4t/CKLZWNBsjgIvItwNI+1BQLicmA7y0i/7CElA3QMECf8BHIzoVoicaKtfD9r9RW2L9C6tCfihPU
	zD7trq19J0+blucLMZOY9OmzfHE/7ql/tiVJwNRu+2hEpnbUjflGM4UiXMYpAbsyk0DGgXYXrhhCV
	sxp+HzYZokLTyrN+FoqbnwyCkDK1oC3hXxCXOBHTEX+NxknfMVnnHumo3hLwEjFNb9SvMdVTuyIRo
	QZM7L7T8HfvdNt4pAS2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oM-0000000GcHQ-0h2E;
	Sun, 08 Nov 2026 20:48:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oK-0000000GcBW-1Rgj
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Nov 2026 20:48:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wUNj3zcErgaPzyJWqZg0hX16vWl0qpJJmvLNO3XQBUs=; b=RPBYn1qfj+OCVwHupDO9OYCWz3
	Fy8Jx7yuqY6EmDd2KJ7TJGdU1+xV7S0Ynp9ZS0F0nSFS7Gvy3jhlR2Hg453RMrCzxq5CHj+D4N//8
	72z7/78m1PavIHZS/+hqeiJFXOblOMvT8a6sAYSGtJfzY7DkK/DjGVHbffrewDHeQr6BrGSAfcYSA
	NiXCF87qhOiDwMv+fS0e6tBBIYGyK17aR532AfKYAp81IqdF9KLINmgv3BKCCfAZlGcOyIS5Et4/3
	l+W0O3MfM7w4NMiFRvBA0XAi4bzWnFc51q2NV0nwtLJCHuwg2FV2OtQPY1aFxN8vLUUpb64fUvqeL
	uSL+4c1Q==;
Received: from out-107.mta1.migadu.com ([95.215.58.107] helo=mta1.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oH-000000060G2-0kkA
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:18 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=pn2Yu/uIIBg3kKaM6bVH+66C04F3rhaZVDPZfB5P3mM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170893; v=1; x=1794775693;
 b=JoCP8mSkZajjXQrlA+PQu8uVatkwBDgTURkfM5QEdlXUt66/zi9cx9goYvmCloHvEFGEegpH
 mCi9ag8zub8hANZd+jMaZG4AmkE1yIRRAi714xkQVxrhYh5zhEvLrdPaFwlx670npjtvxAtXLZe
 HuSBhzAdU3uWGXo+nZLqHXDU=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id c491654f1496b39a;
	Sun, 08 Nov 2026 20:48:13 +0000
X-Mizu-Trace-ID: c491654f1496b39a
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: james.bottomley@hansenpartnership.com,
	mkp@kernel.org
Cc: hare@suse.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	snitzer@kernel.org,
	jmeneghi@redhat.com,
	bmarzins@redhat.com,
	dm-devel@lists.linux.dev,
	hch@lst.de,
	michael.christie@oracle.com,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v9 16/29] scsi-multipath: clone each bio
Date: Sun,  8 Nov 2026 20:47:20 +0000
Message-ID: <20261108204733.557995-17-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_204817_359680_4268BC1A 
X-CRM114-Status: GOOD (  13.45  )
X-Spam-Score: -0.2 (/)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For failover handling, we will take the approach to resubmit each
bio.

However, unlike NVMe, for SCSI there is no guarantee that any bio submitted
is either all or none completed.

As such, for SCSI, for failover handling we will take the approach to
just re-submit the original bio. For this, clone and submit each bio.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_multipath.c | 33 +++++++++++++++++++++++++++++++++
 include/scsi/scsi_multipath.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index baf4ca73f8c9..8e229357e62c 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -101,6 +101,7 @@ static void scsi_mpath_head_release(struct device *dev)
 		container_of(dev, struct scsi_mpath_head, dev);
 	struct mpath_head *mpath_head = &scsi_mpath_head->mpath_head;
 
+	bioset_exit(&scsi_mpath_head->bio_pool);
 	ida_free(&scsi_multipath_dev_ida, scsi_mpath_head->index);
 	ida_destroy(&scsi_mpath_head->ida);
 	mpath_head_uninit(mpath_head);
@@ -239,7 +240,34 @@ static int scsi_multipath_sdev_init(struct scsi_device *sdev)
 	return 0;
 }
 
+static void scsi_mpath_clone_end_io(struct bio *clone)
+{
+	struct bio *master_bio = clone->bi_private;
+
+	master_bio->bi_status = clone->bi_status;
+	bio_put(clone);
+	bio_endio(master_bio);
+}
+
+static struct bio *scsi_mpath_clone_bio(struct bio *bio)
+{
+	struct mpath_head *mpath_head = bio->bi_bdev->bd_disk->private_data;
+	struct scsi_mpath_head *scsi_mpath_head = to_scsi_mpath_head(mpath_head);
+	struct bio *clone;
+
+	clone = bio_alloc_clone(bio->bi_bdev, bio, GFP_NOIO,
+				&scsi_mpath_head->bio_pool);
+	if (!clone)
+		return NULL;
+
+	clone->bi_end_io = scsi_mpath_clone_end_io;
+	clone->bi_private = bio;
+
+	return clone;
+}
+
 static struct mpath_head_template smpdt = {
+	.clone_bio = scsi_mpath_clone_bio,
 };
 
 static struct scsi_mpath_head *scsi_mpath_alloc_head(char *vpd_id)
@@ -265,6 +293,9 @@ static struct scsi_mpath_head *scsi_mpath_alloc_head(char *vpd_id)
 	scsi_mpath_head->index = ida_alloc(&scsi_multipath_dev_ida, GFP_KERNEL);
 	if (scsi_mpath_head->index < 0)
 		goto out_uninit_head;
+	if (bioset_init(&scsi_mpath_head->bio_pool, BIO_POOL_SIZE,
+			0, BIOSET_PERCPU_CACHE))
+		goto out_ida_free;
 	kref_init(&scsi_mpath_head->ref);
 
 	device_initialize(&scsi_mpath_head->dev);
@@ -284,6 +315,8 @@ static struct scsi_mpath_head *scsi_mpath_alloc_head(char *vpd_id)
 
 	return scsi_mpath_head;
 
+out_ida_free:
+	ida_free(&scsi_multipath_dev_ida, scsi_mpath_head->index);
 out_uninit_head:
 	mpath_head_uninit(&scsi_mpath_head->mpath_head);
 out_free:
diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
index d6f290b84f7f..d2ef94ebd29a 100644
--- a/include/scsi/scsi_multipath.h
+++ b/include/scsi/scsi_multipath.h
@@ -26,6 +26,7 @@ struct scsi_mpath_head {
 	struct ida		ida;
 	struct kref		ref;
 	enum mpath_iopolicy_e	iopolicy;
+	struct bio_set		bio_pool;
 	struct device		dev;
 	int			index;
 };
-- 
2.43.0


