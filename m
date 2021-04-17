Return-Path: <SRS0=qGt+=JO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1816C433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:34:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A50260FEF
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50260FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sfZyM2Qm5ZxbC9s600U5MIgRffaaLeNSCPOxMbdIEmc=; b=OrpPWFp4Qk6P1eQFg+2y+4/4m
	VYu5h2z0/YXAhwk7m4fpWby+Drm/dI9J6lqdMkEnFpyeamL3SJgvl5fqz+c+msH1j0xlU9suO8jgi
	wFk6Emf8dTWlDref/HzMI7VsWPEXswj5Deg1mXENYAzlpiQpo9qpASH7BxHTgfOgS6ENP+4Jk3bYV
	mwScL8BI0Uk1enQf4jQy3NZdfR+K+f9RSxnFJtn9aACqX3F8/fnn2/XScDwQxQm5QrvUVJsflHOg5
	8szGCbza7fDONp1huaNK9XmuGkvGtiPrsds5JCCY6a7Uv53SEHU2M/pW9/USs6sgOQR55dyodh1ws
	wStbEgPEg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXamz-0045oj-TH; Sat, 17 Apr 2021 02:34:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXam8-0045kH-L8
 for linux-nvme@desiato.infradead.org; Sat, 17 Apr 2021 02:33:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=uEr9KWfFWFxDdLbvSfDhRdLLpsAnMKrapFu5V7h/wIs=; b=0y+qN1oI6ye48W1yvUL5ePOj0r
 Xe23kiDpaEsJCLyNVm7lF+KPgq7QYRHyEJMGEgY2pW/QsiT/gT1h7YUm/21lNN17UNN1NDRbx7tz7
 8zpsFGpkR8JNE7LfdeXlOWV7fKr8fvt7kXZ4mzmKwgfoRDvYYmp3/QxPtrBoU2TVmdNqpsKjBAVd4
 c9AS4CTxgJSggXuaheErrsP3NGrxJCRnyealim8GUq187gKlA8Bn+Bwy1SWqvGFQ6opdkZr2c2/CJ
 pXRKEHYexymZCIOX0PXQq4vT6pBr9+HyBCXT+210Rf1DJsOLIAWBgfwko05WCVGlRyX+JDiKPnm1M
 pkB1poRw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXam4-009pkT-Iz
 for linux-nvme@lists.infradead.org; Sat, 17 Apr 2021 02:33:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618626812; x=1650162812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=najxIh+FXOHZ7dZhad+BaMtkrWLrGz6Zvppn8AQJSQc=;
 b=jwwelPRR+CakwQRokPYOvDsH8DAmimPBZ8jj8EtBhcgedZjFQOwX/eX+
 FP1laydRsqfAURGjZI4Irfk6B0eBj03GixrdNZQqkUj9xRLk4WWZb+pFG
 U+3l6ZjJNVx0aRuCOyVbqbZSeK/uzDogKRIya1vI7bXMHZfwS+woBRNUh
 CUk3sbB4HI/rLVRl3+PMl/WANTF85xQNuS7iTJlqVszcxCq9t1koXzc3v
 Qs4qZsnExvMsm0PSqJ20qCj+3q9KCxjFjxv+Y8NPbX4K+pLfUvo99bsoF
 4t0xMa5BOvlXpBbwkq6ANZJwqoiUi+IGTo+L6drJMDjbIxCRxQu3LtOMK g==;
IronPort-SDR: wi1pv2ALrZvXfyY9RJlVW4zgwi4kylYFfT9OcTzSLl0wLEjWbeaazN1Mi5vSGdzXNjdAMKq2Uu
 HtAGvg1WobkuTLNa4moSXnovV3bmCwfeBmiKNWnlmM5iBFli4MCoBKrxjcaK2chBy6FtVj1cK1
 jJsWsfMCXIH4KqEsxtVbav5Q1eok2aEJ626xzfterydk5/eyKtHSp/JNvO/JO4InXkR0eGjfEM
 Ot/R1KH27XQ6rzQbrH4/AhtbbU9BQf10j8HiJrb2XFIBv9wp3zdiSe1Nk7VqRhaz6itW+1KNbq
 MAY=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; d="scan'208";a="276118893"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 10:33:30 +0800
IronPort-SDR: 2IBXG4DvQw+TgqZXLVZn+JhEHRneNcCIsfL5qclmx+jQGhYg1m2G+vbkS4jbPkC/DUDxD7cvJA
 KV64KH9V44JzhAf6l7CMqJ2h8Utl/gGuqpd1VJ5aeN0I9BCNygVmvpDNiUUjaypzSYDuqEjpwx
 nujMNUu8IALPDl0zbRPb3GJS0a5aUOVsvZ3cz2SImSpXSab1cpXxJQvjPEH/z6MLxHXqeNVrMa
 Xs+Grdz2jdCugNN49N/poO2NrbgSs0VWOeMdrC1/2ipGA/c8adpFIvqZrmDJqH7r7x2Bs7Ql/V
 nOUqu0GjPJ18P9QbvQuzOQbP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 19:12:43 -0700
IronPort-SDR: xIOtvDVVUoEgifhjwweuy0fDdzV0M33C9Q/9LAS60QbO2JgzCZQNnvvYqoXOtCsotU6X1Tq9qR
 fRdbluZIbVpVm7Kdm6M6AbxvVhXX7+gHfj7VFjUlI7ggjslKXnRGbmZJfxt6CaVyEs8yLLb2ap
 xcl4sfWnLREwFWWruNSyclYXh1u8MnxTlEANLAvHw5TsltOSm4gZTenFH5kwSSxriR+VFF6G7y
 W2tjR8E/oS3cFvaD2JFJzrVxFbgRKyUn3dhoGIoRLiEMlr6hZwjTvpgEuHhNk35wxgqQnQFfPH
 QTg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2021 19:33:29 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 2/3] dm crypt: Fix zoned block device support
Date: Sat, 17 Apr 2021 11:33:22 +0900
Message-Id: <20210417023323.852530-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210417023323.852530-1-damien.lemoal@wdc.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_193332_697785_C26C95B8 
X-CRM114-Status: GOOD (  28.28  )
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

Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector of
the zone to be written instead of the actual location sector to write.
The write location is determined by the device and returned to the host
upon completion of the operation. This interface, while simple and
efficient for writing into sequential zones of a zoned block device, is
incompatible with the use of sector values to calculate a cypher block
IV. All data written in a zone end up using the same IV values
corresponding to the first sectors of the zone, but read operation will
specify any sector within the zone, resulting in an IV mismatch between
encryption and decryption.

Using a single sector value (e.g. the zone start sector) for all read
and writes into a zone can solve this problem, but at the cost of
weakening the cypher chosen by the user. Instead, to solve this
problem, explicitly disable support for zone append operations using
the zone_append_not_supported field of struct dm_target if the IV mode
used is sector-based, that is for all IVs modes except null and random.

The cypher flag CRYPT_IV_NO_SECTORS iis introduced to indicate that the
cypher does not use sector values. This flag is set in
crypt_ctr_ivmode() for the null and random IV modes and checked in
crypt_ctr() to set to true zone_append_not_supported if
CRYPT_IV_NO_SECTORS is not set for the chosen cypher.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 8e225f04d2dd ("dm crypt: Enable zoned block device support")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm-crypt.c | 49 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index b0ab080f2567..6ef35bb29ce5 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -137,6 +137,7 @@ enum cipher_flags {
 	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cipher */
 	CRYPT_IV_LARGE_SECTORS,		/* Calculate IV from sector_size, not 512B sectors */
 	CRYPT_ENCRYPT_PREPROCESS,	/* Must preprocess data for encryption (elephant) */
+	CRYPT_IV_ZONE_APPEND,		/* IV mode supports zone append operations */
 };
 
 /*
@@ -2750,9 +2751,10 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 	}
 
 	/* Choose ivmode, see comments at iv code. */
-	if (ivmode == NULL)
+	if (ivmode == NULL) {
 		cc->iv_gen_ops = NULL;
-	else if (strcmp(ivmode, "plain") == 0)
+		set_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags);
+	} else if (strcmp(ivmode, "plain") == 0)
 		cc->iv_gen_ops = &crypt_iv_plain_ops;
 	else if (strcmp(ivmode, "plain64") == 0)
 		cc->iv_gen_ops = &crypt_iv_plain64_ops;
@@ -2762,9 +2764,10 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 		cc->iv_gen_ops = &crypt_iv_essiv_ops;
 	else if (strcmp(ivmode, "benbi") == 0)
 		cc->iv_gen_ops = &crypt_iv_benbi_ops;
-	else if (strcmp(ivmode, "null") == 0)
+	else if (strcmp(ivmode, "null") == 0) {
 		cc->iv_gen_ops = &crypt_iv_null_ops;
-	else if (strcmp(ivmode, "eboiv") == 0)
+		set_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags);
+	} else if (strcmp(ivmode, "eboiv") == 0)
 		cc->iv_gen_ops = &crypt_iv_eboiv_ops;
 	else if (strcmp(ivmode, "elephant") == 0) {
 		cc->iv_gen_ops = &crypt_iv_elephant_ops;
@@ -2791,6 +2794,7 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 		cc->key_extra_size = cc->iv_size + TCW_WHITENING_SIZE;
 	} else if (strcmp(ivmode, "random") == 0) {
 		cc->iv_gen_ops = &crypt_iv_random_ops;
+		set_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags);
 		/* Need storage space in integrity fields. */
 		cc->integrity_iv_size = cc->iv_size;
 	} else {
@@ -3281,14 +3285,32 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	cc->start = tmpll;
 
-	/*
-	 * For zoned block devices, we need to preserve the issuer write
-	 * ordering. To do so, disable write workqueues and force inline
-	 * encryption completion.
-	 */
 	if (bdev_is_zoned(cc->dev->bdev)) {
+		/*
+		 * For zoned block devices, we need to preserve the issuer write
+		 * ordering. To do so, disable write workqueues and force inline
+		 * encryption completion.
+		 */
 		set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 		set_bit(DM_CRYPT_WRITE_INLINE, &cc->flags);
+
+		/*
+		 * All zone append writes to a zone of a zoned block device will
+		 * have the same BIO sector (the start of the zone). When the
+		 * cypher IV mode uses sector values, all data targeting a
+		 * zone will be encrypted using the first sector numbers of the
+		 * zone. This will not result in write errors but will
+		 * cause most reads to fail as reads will use the sector values
+		 * for the actual data locations, resulting in IV mismatch.
+		 * To avoid this problem, allow zone append operations only when
+		 * the selected IV mode indicated that zone append operations
+		 * are supported, that is, IV modes that do not use sector
+		 * values (null and random IVs).
+		 */
+		if (!test_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags)) {
+			DMWARN("Zone append is not supported with the selected IV mode");
+			ti->zone_append_not_supported = true;
+		}
 	}
 
 	if (crypt_integrity_aead(cc) || cc->integrity_iv_size) {
@@ -3356,6 +3378,15 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	struct dm_crypt_io *io;
 	struct crypt_config *cc = ti->private;
 
+	/*
+	 * For zoned targets, we should not see any zone append operation if
+	 * the cypher IV mode selected does not support them. In the unlikely
+	 * case we do see one such operation, warn and fail the request.
+	 */
+	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND &&
+			 !test_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags)))
+		return DM_MAPIO_KILL;
+
 	/*
 	 * If bio is REQ_PREFLUSH or REQ_OP_DISCARD, just bypass crypt queues.
 	 * - for REQ_PREFLUSH device-mapper core ensures that no IO is in-flight
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
