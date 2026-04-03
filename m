Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E76E85368
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 19:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBT4yhY9HCpI609RSvOs0NG7s5YjLQ+PXcfiCvwv9X4=; b=hyaMlq8y5JDP4RowbaLiHkhFuw
	+HOPyUu01cDiYECel3+KEVWgUtDiVtGEnGBf5fuAbQ2+9vzx9s6CzqAN35DH3kEMbk1+YsR5xhEq9
	XKC9s7Bv+5LVuACgom2A5eHxsWUuvLV4CRTVC/31Syc8mdm6IKK84CYsmzpaqEWx2d3IpNKYTYD6R
	PqxF5KJEhYMbebpTQnvBoSEKOabFSazyXclt8Z2HlcIUYSLiLWKzwVtliS8xsjji4vD3EY6U9A5GP
	/ySLf7fAmBzivb0cOr9oIH8OPgDQd0e+1aYQom+v7eLsRbL0+wFk39YqNDVG9Q7RyUnwhW4jaN0Kz
	+QggFbRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOV-00000002Uma-3a85;
	Fri, 03 Apr 2026 19:41:27 +0000
Received: from mail-pg1-x561.google.com ([2607:f8b0:4864:20::561])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOQ-00000002Uj7-44Sr
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 19:41:25 +0000
Received: by mail-pg1-x561.google.com with SMTP id 41be03b00d2f7-c65c87f73e3so137252a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBT4yhY9HCpI609RSvOs0NG7s5YjLQ+PXcfiCvwv9X4=;
        b=DEdIV9XNsJobAYvZo4BmYOBxHm2lYiW7ns5IyYqAvYckjUefLt1eHVtTf9PIgaL/sT
         ajcU7L+yiZP8v+egjPfD+yMRxVYMg6/JFSE/KiPfoxQyF4GyAxmtomXyPKsWMbiMMmJ8
         qAAW8VJLlnhaFI8BKmBaDczs+lfaN75SlMYOp6QCM88bNTNGbYuiqLUcR08xMolsH34F
         F26wPcr9BbyWmm/yJsNSZBEzQGuZBuo0Ss2Vt/Mrt0Q5Dns5Mq5/S+wd07ooWYvD8PRg
         T4ZuX2QpbcJcE4UkMaynELXsBEIXG/4f1ZLh6gp/wwb2lO7nwmM+G5BrA+9QLlLMFZze
         nFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBT4yhY9HCpI609RSvOs0NG7s5YjLQ+PXcfiCvwv9X4=;
        b=fUFq7VMBH2/fF49t1AXGjWzSSK+vblgnNzBy1XNtCp1KtkkQNYPHP/8Pxc+7YiMJYp
         qRdqIujyVywippfYz0JXrrr+PPXxWg/PFscV8oXxPVKqGmCSsU+1NKltSXSdqRkdD0bk
         M7uvdiyXIpwx4HtRLmHXtzg6GJYB9yjvm+MkB5bkW9rtRU7zxxbXJ3F/nx79YOM390Lv
         m2EIW466Tk8Dnap+uxvgyHMheY4EMwAJ+0FfXWj0AmY4+kWaHSq5L9u1FSQ5k2RztWyP
         scNFMnifSZrSkHxf0TDdh2CTX4lazK5/+Xw0gpc8KseleEVP6hGR3oSMbwVeRdl6p9Me
         yP+A==
X-Forwarded-Encrypted: i=1; AJvYcCXJg0EmZN4hu/6F7l1K55vf74yuxZQBTUmAVz97AMwE9N3IGEJk79WKVujF34m03YS4yzJB8EngBK1g@lists.infradead.org
X-Gm-Message-State: AOJu0YzSBRusdyf6hiWWnfSfaBs1b1OWMjjuEDpgWzdOf/P4F4wth/20
	t6dQlI8h+DV0qvD/X5JAxURKYzXmQwofsN9cujICWWoW5sOQiBqVR3vSk8g+KzSSpjghgdJzbXw
	89xXhu14f95fLHPuRosgFWlnW959x1k3cNMA7
X-Gm-Gg: AeBDiesw5RWz/GlvNP0K6a0tmNOX/1OhM7sDJqKXxLjtsg6DqZEURPxxFcdFB0gWaF0
	GZZXhyW8XHUJCqMERfJ5SWEqBDG8YSKlkNcKkupzEi7G8GOfLeX6votTui69tgaMzr0OUTuz39D
	YsXWQ07VXNKiSt395FCPUpIAFX4TvM2mqnnhHC/3dA7E+KHSwx6sJoaCIUshWTsimQT95iCBABu
	O4Ck1hlVOkOPXYEdLzK+Ldfbqq0/RRC6kW5Q4jb61mf/KxRCyuMBn/jAiq/S18mIbbx7lkZv9b7
	05IaLU8+uDp+Rjqk5D+thdOamlPdN3gA7tXwdS7Zti3C6hsRdbVMoFr/SLLAZceCgyteG3sts8K
	/iIh2Hwfho8+uW+6h1C4XSXBT4oRBbj2NtTAIyz3/jVSR/NPWCHl7sw==
X-Received: by 2002:a17:90b:4b52:b0:359:ff8a:ee4d with SMTP id 98e67ed59e1d1-35de69d98a8mr2252048a91.6.1775245282098;
        Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35dd3602d2csm550564a91.2.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 583413422E3;
	Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4EF9EE41AC2; Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
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
Subject: [PATCH 5/6] t10-pi: use bio_integrity_intervals() helper
Date: Fri,  3 Apr 2026 13:41:08 -0600
Message-ID: <20260403194109.2255933-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_124123_013871_72D15879 
X-CRM114-Status: GOOD (  12.46  )
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
---
 block/t10-pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 36475369cd16..112015cdeb72 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -540,11 +540,11 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 
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


