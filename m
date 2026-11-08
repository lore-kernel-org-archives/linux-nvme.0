Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5636606D823
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZxtIcela;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=epb/f0m5;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vcxQBIGT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bg8FXpLHnbOeiNV48wfI35oG9d3WX/Hy47TPVM7dxC4=; b=ZxtIcelasyoaNA
	2U8NaIfIEJUCFRdRYlrQSSuscE040ySU4LeK6Kyglyh42dr99Dh30uWzDasO7b/dx2nZiar5FNzKG
	87BJ0zU5ao7Z5Or2+lWvxv+nWhPj1WCAY+gMrB64311f6mtlUowGQ3tZX7F3+9f53NLEae+LSDmeq
	Sy1n3vZr5zcPOHikXSpdQcAXI3weFF2H6c6MdwL3rqGO8tIbAFf5RTT8i/VD4iXVtaQJfTel29mTR
	ccNrHHXzlimBfXcrjI+HuLh3m1G269KgmKB9KMMJN13PKnOuCgMh7IwVzj46VfEOrPzYUD8/C7UBk
	5fetATCEOSEb/ciwX2GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oN-0000000GcKZ-3aOz;
	Sun, 08 Nov 2026 20:48:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oN-0000000GcHw-0aUa
	for linux-nvme@bombadil.infradead.org;
	Sun, 08 Nov 2026 20:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bg8FXpLHnbOeiNV48wfI35oG9d3WX/Hy47TPVM7dxC4=; b=epb/f0m55OmT70S4PzBonWL4v7
	SAcwe3iAI76U6U4r4pu8/TiFzWCMgj6jGYGVBMDnfEk0OiiTkTZSjt7W7XV0GAGO8nJhvnNWsJGJ0
	K1/Y+YMG0CYtbloGFNjNDKXK/Z5a/5LVlV4PM/RDSBcPCkozcnh5hXQzEZH8pAejzIg5ZhFfYZc0d
	QQUm1PA8+KJjlanA1HacYmSXej6Dmy40aAnzU8Y8jqzPc46LFwhzEa1hP80B8hKg9Lc6rB51f721K
	AoCoj4sqONRCUVsAj4iof7cwTrsFBUKWHvKMfdXsWXhbqgQEv2E4DptXz3roZpLIrtF0e/w4ruKPO
	7BaTmbpA==;
Received: from out-125.mta1.migadu.com ([95.215.58.125] helo=mta1.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oJ-000000060GZ-47sZ
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:21 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=UyfHMX3gPf6wrmvanoi2cr7axUd6+M+2yQBxEJvHYJ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170898; v=1; x=1794775698;
 b=vcxQBIGTD+JRdf/eMc+16fxaDHKm+w0w/DUbOjsrA4Lq/DcEm8CCcbFcE739JXeGb3/8m64v
 Vb38AXeyPUswuiLgXNSwnBzfiHdCl4Prr5tptPKNGUD4AF7UpSsGiu2QFPArsFvxK6yldwzGNSB
 qyy/JwpgP7MGDH8WsxxRmysI=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 98e5f5536fe4272a;
	Sun, 08 Nov 2026 20:48:18 +0000
X-Mizu-Trace-ID: 98e5f5536fe4272a
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
Subject: [PATCH v9 19/29] scsi-multipath: failover handling
Date: Sun,  8 Nov 2026 20:47:23 +0000
Message-ID: <20261108204733.557995-20-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_204820_104087_4F81A538 
X-CRM114-Status: UNSURE (   9.42  )
X-CRM114-Notice: Please train this message.
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

Failover occurs when the scsi_cmnd has failed and it is discovered that the
target scsi_device has transport down.

For a scsi command which suffers failover, requeue the master bio of each
bio attached to its request.

A bio which for which failover occurs is handled in
scsi_mpath_clone_end_io(). Failover is detected for blk_path_error()
occuring, same as how dm-mpath detects this.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_multipath.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 008bcafe73ad..4c965650c2bd 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -262,6 +262,20 @@ static void scsi_mpath_clone_end_io(struct bio *clone)
 {
 	struct bio *master_bio = clone->bi_private;
 
+	if (clone->bi_status && blk_path_error(clone->bi_status)) {
+		struct mpath_head *mpath_head =
+				master_bio->bi_bdev->bd_disk->private_data;
+		unsigned long flags;
+
+		spin_lock_irqsave(&mpath_head->requeue_lock, flags);
+		bio_list_add(&mpath_head->requeue_list, master_bio);
+		spin_unlock_irqrestore(&mpath_head->requeue_lock, flags);
+		bio_put(clone);
+
+		mpath_schedule_requeue_work(mpath_head);
+		return;
+	}
+
 	master_bio->bi_status = clone->bi_status;
 	bio_put(clone);
 	bio_endio(master_bio);
-- 
2.43.0


