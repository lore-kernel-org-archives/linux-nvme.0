Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50367F433D6
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=; b=hq8sfzCbY4wFoRIOINZino+uMD
	uKBW9wqT6chlBh7uUPlJnOLaSxQzVtmwHUwcUoLq50SHOO87lFnuqCYeX+b+bNrNiuvyVgZIpv3g/
	nh++8zuVrJWi3qcofIGymwBmHo3De47O6TGhpKWNdNH/R9QagNGIrW6zobjglzB0AiNlZGiV/fIRw
	8pH+6WAFGBqC8YacQ9IkL7EB0uuZw9v3aKfaLd/2+EqXE8maCF239BqJFTSI2AkutgvGHPUqNLG0r
	tRsLTA+9tCwbfgwbdwl3FjygxPMAtrCYW09vEdjZRbV0r8xWhb+IHtdI2zS8rR+llNDpZ06REl+RL
	x2Xs5TeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVT-00000001njY-3tfm;
	Thu, 16 Apr 2026 00:22:55 +0000
Received: from mail-dy1-x1363.google.com ([2607:f8b0:4864:20::1363])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVN-00000001nf2-0kMH
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 00:22:51 +0000
Received: by mail-dy1-x1363.google.com with SMTP id 5a478bee46e88-2bd5658b901so367335eec.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298968; x=1776903768; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=;
        b=Yjtm1M0+HU5F3+ilYcuIUsBdZr9WNbIIvnyOxl7e6ZpGpkq2lOoe1A4hkvp5QOmXPf
         Y72k7R8pPXJOVpt4ks1GhBjuiqer7a7uoBWQH0rjTJdDF12pmfSPkBZpJTrPvQZyIwNY
         v2pufW156hxjifZLQY3yICoBuiPzs5mxF/46nkqg0pK52wX++RhxV2OPMrvAJ+53c0/B
         CtfaRjU9sTi+rXelt5YuSTiZmEcik4MkLbjHO43gL76cQRCnjMiI+4ZdMvlrNbQJ0w1U
         w3rzjlP2HuG5+/qTidyieCIBufqeGg5UkNXVZT2xxp6cC5i77u6A0xkj/k7a2No8KVX1
         27ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298968; x=1776903768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=;
        b=ib4y890k2GOT+aYkR7Ui7AZgGPM9YpZvFuN4PBmNJ4llJzpJhvndOKoYfb8S/ylef0
         mCJ26BOJ2dNCZI4FmEskiiFR5idAMTgI3p7aRksJrpZElkYPjJSVuPVwWv+kaD586UTG
         SLTxmSYbtfxP4xIf8fEvWWIR5SVHBVqNgVWTHShozCewc2UBkhV0AxB1KloY/A8IU73M
         n6iL5mUMnPfMc4VDb3Gwc+DQ/SXDTmQz0K9mDbW/T1xqeey969RTuN0RKDagyv9KFNBL
         Y4WipOd7AeGPn8FSbcH62I93Iqaz6xb8+Wi3bV/sUXncfk3M2JeVWlMjgyEltJxdvp6V
         HIaA==
X-Forwarded-Encrypted: i=1; AFNElJ9zZaa/e+Avt6YWHThGx+YJHpaVXLK7XuLTr51GpaT3+vZMwYhIzFTMWgAghnN71TdpucK9oTxMGow/@lists.infradead.org
X-Gm-Message-State: AOJu0YwDnFrJCp7AfbkOeJg3hs40y1La7DPUQ0tRrgV9O3KrSovUJzVy
	PWmaP1eLVRKkGRlFS+Lxvops8unHdARP43WNcZ/HcdpumaEeCetDbhPnsPHzVaDZ6hxz1j8MZ5k
	aJ3i/rCmMDIf3HkjALcYLIUAempgotqk2/BNVex4cmXp5CkQosrEB
X-Gm-Gg: AeBDieuJsIA0h84LyrZ4iqVpMkcek2snYK291smpwDAGB64DtOmFjMt8laMdCIIFNQZ
	Pd7J58RuMKO7+8UvBK7ix3bjCaf3SDhmAqz3cvixAeY01YHHZel3lC8StzBUpc4+iheQkAfThJq
	d4IwoIR8SYKWpy6mb+Q5pKOS/9M/hKmcLym+/JvNqUOl1PdghTpEyPL93b8wWBeH61Lr8a/3MK+
	jYjQTuCRviCBe8c5FPNjiMyWHzF6C76olLaTJdv3R9c9sdnQPmQJe+Y2L1fcjsBxsYjihx7xipq
	lv96JqFbs+suwU2D7ksbpxPdZhn1goXU/1XndmDITb0uVM8T/9xTsbpqdWnMISz4JIrLl6SKPRv
	cf15AUJaMU5BV4+KvCDq0uhjPoq/T6uvrIHtAHV9scnBBpfDxZQ==
X-Received: by 2002:a05:7300:ac81:b0:2d5:9438:2a02 with SMTP id 5a478bee46e88-2e17d815b51mr60486eec.1.1776298968089;
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2de8ea899b9sm240344eec.18.2026.04.15.17.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 49AC33405AE;
	Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3F4A0E41B93; Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
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
Subject: [PATCH v2 5/6] t10-pi: use bio_integrity_intervals() helper
Date: Wed, 15 Apr 2026 18:22:13 -0600
Message-ID: <20260416002214.2048150-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260416002214.2048150-1-csander@purestorage.com>
References: <20260416002214.2048150-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_172249_214208_898C635A 
X-CRM114-Status: GOOD (  12.86  )
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

Use bio_integrity_intervals() to convert blk_rq_pos(rq) to integrity
intervals to reduce code duplication.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/t10-pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index e58d5eb6cefb..787950dec50a 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -541,11 +541,11 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 
 static void blk_integrity_remap(struct request *rq, unsigned int nr_bytes,
 				bool prep)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	u64 ref = blk_rq_pos(rq) >> (bi->interval_exp - SECTOR_SHIFT);
+	u64 ref = bio_integrity_intervals(bi, blk_rq_pos(rq));
 	unsigned intervals = nr_bytes >> bi->interval_exp;
 	struct bio *bio;
 
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
-- 
2.45.2


