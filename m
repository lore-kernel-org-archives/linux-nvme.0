Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C2CF8E49E
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 01:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nVdvVaugSDz6j9AO/nmgKpHbKb4qPtoLkQfjj793Zaw=; b=THoXHwo51+vVSb+QrLkthrujYk
	HjcwUqtjhEsVRsHqUW2kGqsPdDwStkC058wtXfkAol8esBITbnennNxf8YPggbDpHKD3067Au8pNq
	pDvsxAMt08CqUJLhDmYc3pwc1RuQNjSgLg+dmdfp55b3/uSPpb+DNRgLAjceSXCKW77GfG3wJq0FT
	VJbAFBX5HnrdJuu3f/AptKjuKWBmTxZK6xuILDLYaEn071seezumMSCkyNmlToHfR+S2pQ5hpG/W0
	SBLVQjThalWSxIkoUHoh/oZk4YAweEKWSMTSX0Oaw8WlKZNYKTOljcByTUAuYwlOenBZM9nwce805
	au0vAmtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSq-00000003IIV-0PTU;
	Fri, 17 Apr 2026 01:57:48 +0000
Received: from mail-yx1-xb164.google.com ([2607:f8b0:4864:20::b164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSj-00000003IDF-47s0
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 01:57:45 +0000
Received: by mail-yx1-xb164.google.com with SMTP id 956f58d0204a3-651b71f5cffso30435d50.2
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391061; x=1776995861; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVdvVaugSDz6j9AO/nmgKpHbKb4qPtoLkQfjj793Zaw=;
        b=RCywkXExrBhDMYubLyD8dhtU12c3EQTKT8DTVOhz6lH6iDeZdBdLTU7QBawLlgONm2
         vRxPjliubd6lSxpq4wv4B5iVYFA1ivk+geIcUCGHcb6G5ar4fFIQcJIam/3hqkPayTUc
         KKdPc4qLXFNQFcL0KZ6j6ZbGDhOFRheiq3juKX0VljBqLfWWYnkHPnMMROc0usOtF1m/
         itMT98GaQlc141WzXV+hu9q88EsAjKKxYKfEP+h1BAmwwH77pe48AUsduUL8tzo79dNc
         uOQiAmgX7V/HBQwzeLoUjBIy6HQ0q7FY6xS3izg/4QnrfbFJgCjiFdkZYbS82H9eKPUD
         quFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391061; x=1776995861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVdvVaugSDz6j9AO/nmgKpHbKb4qPtoLkQfjj793Zaw=;
        b=srtwVS5bW+1ax2j85i525yJk3XhGZCDOx7x4wYe5beJWd1i63g4IVrw/SdLWwQM3Sw
         MmGNTU9Dva5glOyr0kxazd0bkIf6MMOtGK0oy7CoVnPT4GOEHavbujplNpqM2GWqQgWE
         Fks6saXyIruPEkcVInOdXKUqKsy9Bw8SpPtg2SxugMA1zOH1VPNE/Lrlp9mFFPh/BD04
         v3HcNlc/DWxlI4dXBoIcpaFmgTd0C3rPh9/jQje5qXzLya3J1wAAlT80OBb3sYShJB3X
         eg+tagVbgU8FhynFe1PHEYadVVrUg//94C0tIjQesUdnqruM1n4bQrcMwUrEeq6rCuJl
         1deg==
X-Forwarded-Encrypted: i=1; AFNElJ/3F8KXJW5gkJfwQneCujvaIxAh+/ZVV0QMEDT+gjnZ8Pp34mfz/w8F2wZGYWZIvEidwtOWeimR/vkE@lists.infradead.org
X-Gm-Message-State: AOJu0YyGoUav7B+T04u/VL9oPI6fchG3VgJdKmd9IBxopVNy19F2C+PB
	8GB1RpnQUt23aqthJ235zfIFElsLHXPLaKQPzb3igO3pvSy1kSDsNUVbxUk/MYiXvisCwgFR/3v
	RG28z0FDesfi1EZcd5LzJHMckJOc++CJkWgeiEls5YYtq/9OYvnlW
X-Gm-Gg: AeBDievlUzAN6MMM4JSfohiK08ESYSY5YA0OcfEhmUR3W084Mik3kF1LiGaCSjFsdu0
	7o6xrkQG+qEB8Tilt4slv6lxWA8fVUGzMn4dNkdWIxR5/H0hCD0KgDcsz6fUN7NcLJx7UY9VyZH
	re8mllxwGaChCvb+tc4yIZMrx47N9hWWk+56Oy9Q/eFPZ7kGIOo++cf19jN47VuM5DbxmvygbXO
	MNsx8e6B888dFmf/afeLFfzPxgj5ejfvxQYT9xCGqXZaSJWWmSX7pvoHzE+BHS5fAN8rf7zIdjh
	wEKnx8Kwvv+Koqc9TH5SQw2gLAGf+HPl6J7vQF23U96Detv5sChUrVX9/HMTtKoJpqvnziPmcNy
	o1E8ikiPlxZuWFysn8gsn0bRSh/bfD0FCYUiQdvedBwgns7S+4w==
X-Received: by 2002:a05:690c:4b0f:b0:79c:ff02:a03e with SMTP id 00721157ae682-7b9ed037d1emr5894277b3.2.1776391060655;
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7b9ee9a8042sm125407b3.21.2026.04.16.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 295C2340BC4;
	Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 25C2DE406BE; Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 3/6] blk-integrity: take u64 in bio_integrity_intervals()
Date: Thu, 16 Apr 2026 19:57:29 -0600
Message-ID: <20260417015732.2692434-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_185742_047914_CE90713C 
X-CRM114-Status: GOOD (  13.37  )
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

To allow bio_integrity_intervals() to convert an absolute sector to an
absolute integrity interval, use u64 for its argument and return types.
Also use SECTOR_SHIFT instead of the magic constant 9.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-integrity.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b1b530613c34..825d777c078b 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -64,23 +64,23 @@ queue_max_integrity_segments(const struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
 }
 
 /**
- * bio_integrity_intervals - Return number of integrity intervals for a bio
+ * bio_integrity_intervals - Convert sectors to integrity intervals
  * @bi:		blk_integrity profile for device
- * @sectors:	Size of the bio in 512-byte sectors
+ * @sectors:	Number of 512-byte sectors
  *
  * Description: The block layer calculates everything in 512 byte
  * sectors but integrity metadata is done in terms of the data integrity
  * interval size of the storage device.  Convert the block layer sectors
  * to the appropriate number of integrity intervals.
  */
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
-	return sectors >> (bi->interval_exp - 9);
+	return sectors >> (bi->interval_exp - SECTOR_SHIFT);
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
@@ -151,12 +151,12 @@ static inline unsigned short
 queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
 
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
 	return 0;
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-- 
2.45.2


