Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5353C43460
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:06:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6501861152
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6501861152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ItThz0+k5bYT/N5dPrYgOwArRWFlAXc1Q9ZsXPbvaJM=; b=AIqaleqSBzCp6+XCJ4HFFzb+E
	nEaufKLAH+RzovBp1Z0QK+mdKVjop5QPEsuQdhQXa77escoR88qakXOk3quHAofuxNFlJHcmzqWlb
	L/boJgoLnuUf0XxVhVmiiDf+lMLTMu9Aa5jsqqcmYw8xAJ5s7STv28TxpjqtdOdC9gVYk3dg0kRK7
	IZl5DhaxnzoS2vFf38hbXrIeOM3uFmjnpm4tywhGVYkbhTsoo5QcE75ELhvRj9Lu3Cqx1MTAm/Tkp
	LfgaeQrgl72b+RLZ9d0JTnqO18FJjxEFZjPX5U8IkbDJ832zZjZaQfHOPANow9+N99+Tt0fcAdsTs
	ZH6Z0dFkw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXEoA-000aGP-2K; Fri, 16 Apr 2021 03:06:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEnf-000aCa-Jr
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 03:05:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=P0g5FJKWOlwIZRs7Zdy98E2L0F20kgfqmyv+xNyCsJs=; b=xn8SOdApGkmt1qYBs9ii9JLYxq
 W3TMuMh1CT6hwBJo9SNfqPRHIzpSvHGC8ELLjqd3cvp0ziS0tmGzemWgsERMU5KR12l6m1Kc7CzhC
 SBwD9+XOnOK/O4Ixh9Lqf/0mw1juesuQ7z+cFhZcY4rOc5fDIYmHIIWPqPclZJWlsI+QGXsWuDAiF
 J4Arn2chONWE/L/qZ0jSdVt/bHqVh/S/D0zy8R24liu2GhI8Vdu4YTRdsE75njBUJynQum8JsFzpM
 cKzzTgn+HsqPFogNd8e6nj101Yx5F5xzUC2XpSpz0Mbm7CabyMWgUvrqnEvMRX4MS+DQL0wglHo3t
 ojy4NJ8Q==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEnc-0092yw-SI
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 03:05:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618542340; x=1650078340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7xpGw5gOit7hgiXUka877UmTYdM1ZmxbqzhNHdLZabs=;
 b=LpDgSswhSZcNTM4bL8DPxFRszL4rujSPA1df62scWuqEtqxXqrbhWkEG
 Oe3jNtrih2Z0wj2yK8T9gFWIDcbRzhO1kFa7rIVumvq79dmjFGZ5eueJc
 MZ2W+B9HORN/ebAaeZ9LWKPjDrx9HdxeH7CTO5WLLToxxlONeVP2s4SKH
 q3+ENU8jQIvCZfEVWtGadCXMWGJxG83uONyi77/JjwEsj8RB4KjlN4Oe+
 VrlUWGPPnvaO1f5KnyOmLpe4i8YaHDbOxxwzGKLCJqygVSW2WNlFZ81dx
 nAcfYZXtPLqNKsSXffkIhPXEB0YGVTdCwTMKgIfJ2dkWjABCD0+SBiFM8 g==;
IronPort-SDR: QW1km2ciJpSOZ+enOWNko1llr9+KQ6gsucxW4vneyNQW5KKDCM3iG/p50yZwJdA7bSKjbxEBB8
 I730ISSRocwn2hrhEqhEXOGt1TO3bK6sKF4P07oj5zif5iAWlsg645ZxO/H9ouxRYzQ2qVrK70
 o3/Uu6soWimTx663PaIkiOpnlmt9Kz22KWK0ECLvE46uGc2mTaSNx49GwPoQEj81lmbKp9BNYf
 Eh78iyNu7d/9n9bYUjJ2cKl56sOd5Swt6chmzDDXR8G0giRSADhHgukLhJdA0rCRDQP4KlLQWm
 CEE=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; d="scan'208";a="275938865"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:39 +0800
IronPort-SDR: Hu7TnXB7rHzMKl63RC/dr5nWrGsbBkC152EOO51Qrcn4VZnzDoOij6/RlJmJNzwBz1pXDIJoVv
 M5Mb8cGYePyuTA3EcQesFqy+frKLW/ZW57McqRX+cewZm6Wej9MZ2/5Ms8aU+hinW50gCk3qLF
 7qcc5N4yZ6x/nKt9UFjZCrCV9yR6ViN6apqx15h0fn83mzWhNA6eV9rtcnLqFv+qjtot9gfRt+
 0zaCs5rdbJljd7Iw7LKUB6xSwo/bIsfWkmWk/gfs1C1VDP7yvLcUAP7NrMNVwiDFCh+uBKwaST
 z43BUMtvbeyhrwhYh7LhQ9f2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 19:46:29 -0700
IronPort-SDR: reXaIl08fufcrKmwqlTrWikXVN+K7DeRaEHrim6atgn6l0Yzshs6cwZfuVPyG/kvBFwDZwOrfr
 KS+rIvyqVDxgc7Gk/123Bm8msgUO6s4kvzkQ+qbbMhLQMA2VUtrz2kPI7Uz0wH9p97zvdy+QzB
 dBNntEhDmRfVb+H6+MNJdlgbWRYLOtg4nGCU+7WubVXDhzMhGvHAgjkXjcQHedj6A+mGlgbgKU
 F2qkOL1fodLfhCMmK6ceLxyGqBvX+6LMi073Jjr5TrHhAQGPfhL+ssy2/DyhiIJ0c5n+L76/P5
 VD8=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:35 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/4] dm crypt: Fix zoned block device support
Date: Fri, 16 Apr 2021 12:05:26 +0900
Message-Id: <20210416030528.757513-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416030528.757513-1-damien.lemoal@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_200540_988854_D5CE70DA 
X-CRM114-Status: GOOD (  28.22  )
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
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm-crypt.c | 48 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index b0ab080f2567..0a44bc0ff960 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -137,6 +137,7 @@ enum cipher_flags {
 	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cipher */
 	CRYPT_IV_LARGE_SECTORS,		/* Calculate IV from sector_size, not 512B sectors */
 	CRYPT_ENCRYPT_PREPROCESS,	/* Must preprocess data for encryption (elephant) */
+	CRYPT_IV_NO_SECTORS,		/* IV calculation does not use sectors */
 };
 
 /*
@@ -2750,9 +2751,10 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 	}
 
 	/* Choose ivmode, see comments at iv code. */
-	if (ivmode == NULL)
+	if (ivmode == NULL) {
 		cc->iv_gen_ops = NULL;
-	else if (strcmp(ivmode, "plain") == 0)
+		set_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags);
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
+		set_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags);
+	} else if (strcmp(ivmode, "eboiv") == 0)
 		cc->iv_gen_ops = &crypt_iv_eboiv_ops;
 	else if (strcmp(ivmode, "elephant") == 0) {
 		cc->iv_gen_ops = &crypt_iv_elephant_ops;
@@ -2791,6 +2794,7 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 		cc->key_extra_size = cc->iv_size + TCW_WHITENING_SIZE;
 	} else if (strcmp(ivmode, "random") == 0) {
 		cc->iv_gen_ops = &crypt_iv_random_ops;
+		set_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags);
 		/* Need storage space in integrity fields. */
 		cc->integrity_iv_size = cc->iv_size;
 	} else {
@@ -3281,14 +3285,31 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
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
+		 * for the actual data location, resulting in IV mismatch.
+		 * To avoid this problem, allow zone append operations only for
+		 * cyphers with an IV mode not using sector values (null and
+		 * random IVs).
+		 */
+		if (!test_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags)) {
+			DMWARN("Zone append is not supported with sector-based IV cyphers");
+			ti->zone_append_not_supported = true;
+		}
 	}
 
 	if (crypt_integrity_aead(cc) || cc->integrity_iv_size) {
@@ -3356,6 +3377,15 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	struct dm_crypt_io *io;
 	struct crypt_config *cc = ti->private;
 
+	/*
+	 * For zoned targets using a sector based IV, zone append is not
+	 * supported. We should not see any such operation in that case.
+	 * In the unlikely case we do, warn and fail the request.
+	 */
+	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND &&
+			 !test_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags)))
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
