Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1E606A96E
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=B3+MVmJz;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DyZnnwp2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=EZ1n97WIaS0quFafvxQMGHq1ybtUxrApBPjDUdcn/Xg=; b=B3+MVmJzBOXFXzQBB+W2wtFFOm
	zM2vrBf1lyW0Uf0t4bNPvtUn1YRgalHtsSxzRUb5HVAK3ra3CNLhu9EdQQhPNRpp5oSYbXFbQM1qe
	jh61KyGjfwFD1PW1IVbvcIEgH0I2qxSXBFhGHvc9KjiFFNZHUpuRKy9U7oX9emC5Th2mTV3PMeg26
	faXw/GMqCKhGKJY1Ns7Hy+RyWGbWu+30l/YBwzbH3W7fjwXJ/XK1OlsL/nH9PJsWXmDnkyTVIHIfx
	bmsxSq6On0fJyCTqBA1GVGAOpqcCpTkwkW5YqBd/JP4Zj01BWLT0x3iatbb470pseO6yO2a3AMgQr
	CELXHLAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM8C5-00000007kC6-1AA8;
	Wed, 28 Oct 2026 18:16:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM8C1-00000007kBO-2btZ
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 18:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793211366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZ1n97WIaS0quFafvxQMGHq1ybtUxrApBPjDUdcn/Xg=;
	b=DyZnnwp2dNHLEPv80eYLtp/l5uG+B9rqPieZhfy6JWEIn6pxcyap6+YHXSmbzFdj1nd6v8
	+p2vj7i226uXLdY/PkoSjH+M79wBDFMKjoWJlhgf4frQIGUADzeuWl238LnJogQSOinbSY
	2V5Dswj+N9x9FGSZm6zXQwa/KPzmYOw=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-qLkH_sPyPP2omIj1tMxvfQ-1; Wed, 28 Oct 2026 14:14:31 -0400
X-MC-Unique: qLkH_sPyPP2omIj1tMxvfQ-1
X-Mimecast-MFC-AGG-ID: qLkH_sPyPP2omIj1tMxvfQ_1793211270
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so1358960c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 11:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211270; x=1793816070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZ1n97WIaS0quFafvxQMGHq1ybtUxrApBPjDUdcn/Xg=;
        b=ooGQfW/RBu06n1mSg7iI8InaI9aw7Ruza0VCbnfTWHjzf6eXF4J+4wpeGEFMv1ns++
         1+3ezF24OLtZvtRMPxdUtdq93LbLwuhoT00ERc6KRME81SEHZNw02kTKuGf25BrV8u2Z
         q9bhd6eOc0ukkfiw+sdJYSpkj73Nn5KarC+BYOTGGYBlXH260Gy4CmC6RKHuYkkHDIpM
         /n8ho0nRbJpbHB2CjDvmNALzQ788Iiw0knNIkKVzZkxGNwTJS4083+WhtDOoxFpUnmsr
         pTDSlOu+J10vev44Ecku4ZTiN+3x3OJNkNXfVKnYHnuxUxGIBuJXaaD4IKewTIqlyvX1
         y8TQ==
X-Forwarded-Encrypted: i=1; AKwUvBzew7bDNHSITTUe0/GI3sZG6kB4rIRx/n1XpRG3LYRYGTy5MwQdUqJF8V6cv7U1osu29cmFa9QZLIvj@lists.infradead.org
X-Gm-Message-State: AFq9FYL2MLmNksk0VbI3SUHAzv0RwQiU+CLKJB4JFrdagC9ZE224ve6a
	Wxxvcnu8NVkYsFmoGLwj+gjVRh1WetMgT647/DLJNfnb6b6OYV6VTG9QQaQgeqki3SyCdZBmTJ2
	9Gn2GxVk6eVDG8HwSuFRH0ULxget8+oXktCXOJFU6MZ/xJ6MQQWgKzZKELZDM3e97lPze
X-Gm-Gg: AYBFou3JX4buYt/oCjjxI2B0aKSi8mB6NfSzXJbhiHsL8Px5GLQzDkHRHqujVHIjB2o
	tuo7MXrZjZGyaq2bem44fGVsXIVCYPnaT6uv0cPIljStpSfj/wC4ja7sP61gVYm3J41iSV5epDz
	Rz+4d561yvGL0htwkn85qQYoxnbYF83PGh+XQDLFc9XAG8i3UkPdHDvodumHyUR6xPKPNeFhwW0
	3Cl3e2Dg+v6gy3x2/LzDO494p67I37VMCOlpQxwmgnQLwAnWuJvrRdK6XQLK5hIk6OZ6JrkaJ0v
	cTbcws2/NEsFizNtczJU6s2WyfN0F0vBSRgCd1ujrN23YmMTBSeG9dlwhUCPMEZfHCJwL/Nrdpu
	PH8OCKcYSnhHVISoGP9/qJrtsySGEJsFXBsMV
X-Received: by 2002:a05:701b:2414:b0:19d:81db:1ec6 with SMTP id a92af1059eb24-1a6cbf75087mr3886285c88.14.1793211269635;
        Wed, 28 Oct 2026 11:14:29 -0700 (PDT)
X-Received: by 2002:a05:701b:2414:b0:19d:81db:1ec6 with SMTP id a92af1059eb24-1a6cbf75087mr3886246c88.14.1793211269001;
        Wed, 28 Oct 2026 11:14:29 -0700 (PDT)
Received: from alpha ([76.166.245.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c9fd2b4sm7438411c88.6.2026.10.28.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:14:28 -0700 (PDT)
From: Kyle Bader <kbader@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Kyle Bader <kbader@ibm.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: only fail dma-buf bios that need block layer PI
Date: Wed, 28 Oct 2026 18:14:12 +0000
Message-ID: <20261028181412.1919506-1-kbader@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PkNkRl2q8Bb8sW_nNmN1Mq4jypxltoQR6PAoFiwKX2U_1793211270
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_111609_744609_CB595B22 
X-CRM114-Status: GOOD (  25.16  )
X-Spam-Score: -2.8 (--)
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

From: Kyle Bader <kbader@ibm.com>

Any dma-buf I/O to a device with a PI checksum fails today.
blkdev_init_dma_buf_io_ctx() returns -EOPNOTSUPP at registration, and
blk_mq_submit_bio() fails each dma-buf bio with BLK_STS_NOTSUPP. The
checks prevent a crash: bi_dmabuf_map shares a union with bi_io_vec,
and bio_integrity_generate() and bio_integrity_verify() walk bi_io_vec
to compute the guards over the data.

Only the BI_ACT_CHECK action walks the data, and a dma-buf bio does not
need it in two cases. In the first case, the submitter attaches its own
integrity payload, for example with the io_uring PI attribute
(IORING_RW_ATTR_FLAG_PI). Then bio_integrity_action() returns 0, and
the device checks the PI as the submitter asked. The block layer only
touches the integrity buffer, to remap the ref tags. In the second
case, read_verify or write_generate is off. Then the device inserts and
strips the PI, or the block layer allocates an integrity buffer without
PI in it. This is the same as for any other bio.

The first case lets an application read data into device memory, for
example a GPU buffer or an NVMe CMB. The device checks each block and
puts the guards in host memory. The application can then check the
data, or combine the guards into a checksum of the whole buffer. The
CPU does not read the data.

If bio_integrity_action() asks for BI_ACT_CHECK, fail the dma-buf bio,
and otherwise let it through. Remove the check at registration, because
the integrity payload comes with each I/O. With the default integrity
settings, a dma-buf I/O without an integrity payload still fails with
-EOPNOTSUPP.

Link: https://lore.kernel.org/all/bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com/
Assisted-by: LLM
Signed-off-by: Kyle Bader <kbader@ibm.com>
---
This applies to for-7.4/io_uring-dmabuf (45b716456dd9).

Anuj's check in v10 fixed the crash in blk_integrity_iterate(). This
patch keeps that check for the bios that need block layer PI, and lets
the other dma-buf bios through.

The sysfs knobs change the integrity flags only with the queue frozen,
and blk_mq_submit_bio() holds a queue reference from the new check to
bio_integrity_prep(). So the two calls to bio_integrity_action() give
the same result for a bio.

I tested in a QEMU 10.2.2 guest, with udmabuf and with an NVMe CMB
that a small module exports as a dma-buf. The namespaces have 4 KiB
blocks with these metadata formats:

 - 16 bytes, PI type 1 with the 64b guard
 - 64 bytes, PI type 1 with the 64b guard in the last 16 bytes
 - 8 bytes, PI type 1 with the 16b guard
 - no metadata

With a user PI buffer, reads and writes pass on all three PI formats,
and the data and the PI match. This is also true for a 2 MiB I/O that
the block layer splits, and for four commands with one PI slice each.
A write with one bad guard fails with -EILSEQ from the device. Without
a PI buffer, a dma-buf I/O fails with -EOPNOTSUPP. If read_verify or
write_generate is off, that I/O passes. Pavel's rw-dmabuf test from
liburing rw-dmabuf-tests-v8 passes on the namespace without metadata.
On the PI namespaces it passes with read_verify=0 and write_generate=0,
and with the defaults it fails with -EOPNOTSUPP on the first read.
The tree builds with CONFIG_BLK_DEV_INTEGRITY=n.

Without this patch, every PI case fails at registration with
-EOPNOTSUPP, also with read_verify and write_generate off.

If a liburing test helps, I can turn the test program into one.

 block/blk-mq.c | 9 ++++++++-
 block/fops.c   | 2 --
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7fff1305b..3fc9fdeb3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3138,8 +3138,15 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
+	/*
+	 * The block layer cannot generate or verify PI for a dma-buf bio, as
+	 * that walks the data pages.  Only fail the bio if it needs that, not
+	 * if the submitter attached its own integrity payload or if PI
+	 * generation or verification is turned off for the device.
+	 */
 	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
-		     bdev_has_integrity_csum(bio->bi_bdev))) {
+		     bdev_has_integrity_csum(bio->bi_bdev) &&
+		     (bio_integrity_action(bio) & BI_ACT_CHECK))) {
 		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
 	}
diff --git a/block/fops.c b/block/fops.c
index 01bc8afe3..5c8024011 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -947,8 +947,6 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
 		return -EINVAL;
 	if (!disk->fops->init_dma_buf_io_ctx)
 		return -EOPNOTSUPP;
-	if (bdev_has_integrity_csum(bdev))
-		return -EOPNOTSUPP;
 	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
 }
 

base-commit: 45b716456dd99488a0cef58482120dc0474aa696
-- 
2.54.0


