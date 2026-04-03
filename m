Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7B0E85368
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=otX1Hqc0T9DvgqLYhcqiRNaRpAdPxblh5+E7UixGoPQ=; b=ohLBAg62yYSxZdsAg50CcnyxpS
	QePs9wYqd/2wrvm8KbLRyuZOV/WRR/6cWSPW6ur3Up0Lb6C4QliprzV+egBFa3XHjzW0IaiZWMOnF
	ojSS+fOwKR7du7+XeT1i2SSUvWkvBirhNc29e0FMsE49JRIDdmln42XWexdHXDM/GuChTSfulZl3h
	b0LRV2BcNyqX/c56+Ai9cuXZAoFBS9R1Zg9quNvrK4OKOFrWcYZpk54w+REBuPFwfvip450T9BM8T
	ZK3ONq0uM5HXZZx/iMYi6S4iPyj5pKbbAruwvF0uvm0a3PV6cu22PYqMK581/fQxJiOjNyOU5ULnm
	wnaaBEEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOV-00000002UmI-2AJu;
	Fri, 03 Apr 2026 19:41:27 +0000
Received: from mail-ot1-x362.google.com ([2607:f8b0:4864:20::362])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOQ-00000002Uiw-3ePb
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 19:41:25 +0000
Received: by mail-ot1-x362.google.com with SMTP id 46e09a7af769-7d7ebe875b6so320159a34.2
        for <linux-nvme@lists.infradead.org>; Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otX1Hqc0T9DvgqLYhcqiRNaRpAdPxblh5+E7UixGoPQ=;
        b=Qw4iRy3YxbhLI4fLEypyQ226lk1NruOwfRzvrYwwjWmLd0vxP/keOnAqKxt2CSwqAa
         A/j9fQmTbUdB273cY9tIMLwrTjmOXu65nbxsV7Cmr/iCfy023NJ+POvE+7lXhvcACgcL
         /Hq9sGTZlVLNHAbLTz3lX+qmKWYWM6zslEY/0DkPqCPUJRWOZ/W4M3msKItdZ+326ZIA
         sv+GZRHgvNz931XV1SPxJq1IuyfiziMKHnhzfrPRVB2lXmmy6hq79O7v3X49qTaU3sGp
         JhmP9SgP4J/BmLUcDDa1IsK94Aq5xpYcerwzoyxXOASZS7oN8lohKjgbz/igpfjpbu9H
         vrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otX1Hqc0T9DvgqLYhcqiRNaRpAdPxblh5+E7UixGoPQ=;
        b=Z4SwmS3fwVuHN8+iP4Rt7xtRZsFNLhfPmwOlDrjfL9rqbivrZSiGTFDRzg9MgTUML9
         3+KGG4TslB+Tt6H2LL0/86/eoQghdDpHLsrdwD+1zV8PkXWXQnY0IGwoDdKFWs50FFwd
         7hDrNb1HK9fW1rB2A/NbklNqjKuMDb6ekIuXhtKhJfYLZZcRYmLkEi5aNKMEeV02uX77
         pAR91KPnQ0bGhoKZ4tBICprSF2oDWVzpGfZp+qV4KmamEQ+92cS+dvx81wYNJmNcXZt0
         UFwOxD2KAlM/L84XhS31zdWRBW55TJu0Z85Bx11qPJxFg/zN6o8SxOsRitRgf/dcHR7t
         CEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbc+uElJemqbNqY7sV1biQoZ/u0eR/ROpUPXxLQ1QHqks9hlI2Kj0vWTwCcmegM9KOM6+kIJYURVK6@lists.infradead.org
X-Gm-Message-State: AOJu0YxqZubQaIo99FppdfzXt4U/VoGHDKixuQdNsHt3NLg67qVuQ47O
	wgCr3UYdxOLWICCVMBNbpuBssBw61uym+3TWkl6u6DQdqwacwEDW/r6dG8BCyUHbcZf2NNwxyY/
	PhR7VUw0a4mFS88+zXddPQEojnWV8Vu7CnZY/
X-Gm-Gg: ATEYQzzfACrJYjNrFUuhV3hGaxjCyB+kxuRb5/wwwqJl+NxQYwjUK8VqcX+yDudDozf
	yJoJiXQQM2ZbBX3P0PoQl4RSwP4alt5zqAzuxvF1kVIzfkYw0wFBd8Vnqd2NAVBRzrQrrrPNlaq
	fhq5Zn5q4b5gIQMjqlb5EhoQpZb7lG/FQ8PTjgJZXkIYODP+yJXudp4cMq0KNHRENnYdlamjuy2
	2Q3QZAR+x2ttODF1Si3NpYR2n/zlOmy8juwwHfbhcrFXenpSMKEg+ie6terhwzKzr9HwIBYWIf1
	ioOYOn2YzLxK8MbQi4iRahjbns84swKqmexq4ni/hQPDFl7UCU3a2XILxL/SE1TlTNx54vAdrZ5
	dyAbkezECydgJujXPKVOGXbiKfw7EqdvAnL0OB36s26lpoJxzXQcJYA==
X-Received: by 2002:a05:6830:25cc:b0:7d7:ce56:b93 with SMTP id 46e09a7af769-7dbb72f247cmr1794595a34.1.1775245281603;
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7dba72d7182sm505129a34.7.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 31F7C3422E1;
	Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 27E8FE41AC2; Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/6] bio-integrity-fs: use integrity interval instead of sector as seed
Date: Fri,  3 Apr 2026 13:41:07 -0600
Message-ID: <20260403194109.2255933-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_124122_919201_4CF5E544 
X-CRM114-Status: GOOD (  14.21  )
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

bip_iter.bi_sector is meant to be in units of integrity intervals rather
than 512-byte sectors. bio_integrity_verify() doesn't actually use it
currently (it uses the passed in struct bvec_iter's bi_sector instead).
But let's set it to the expected value for consistency.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity-fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 389372803b38..5d1b0e33fc5f 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -62,11 +62,11 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 	 *
 	 * This is for use in the submitter after the driver is done with the
 	 * bio.  Requires the submitter to remember the sector and the size.
 	 */
 	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
-	bip->bip_iter.bi_sector = sector;
+	bip->bip_iter.bi_sector = bio_integrity_intervals(bi, sector);
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
 	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
 }
 
 static int __init fs_bio_integrity_init(void)
-- 
2.45.2


