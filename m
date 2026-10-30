Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C60606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W8vsaaDY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Blbw32TY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KBjoHjefEpt6gXeu0uBAO7mx6fOzElk1Inu+2ky7I1c=; b=W8vsaaDYhFXT1i
	C0u5uB9W87yVGYbxtHv8B55vPxOw7Z3vhOwJgRpoUSJsfgOvDOZUSGDx8Ir32mnlZi5ZD9eWBkiLG
	03hjhRuDVojnVknoaqs5b9kcn8eRPGmfU9F93nGDnTYfWf8wzfn6hFTxgaHVP49/3swgj2id7+O7r
	hHVTRaN2+IDkzm8LJWwdszbvc4PLyNqyh7/JlWOzI0wwgJH7wpzq6np+EO3jZ0NZa86hrqkvfcG00
	mcsO2AHumpb1ISBJmlzvYkfXTzsgrJJb7K32iTvOEX+CV4ZgI+yG0ERF4qaIWuOWVKFFDps7TW22h
	YgyNt185VdUp9GRPrOpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbhG-0000000AdCq-34l9;
	Fri, 30 Oct 2026 01:46:22 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMbhC-0000000AdAS-1KTB
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 01:46:19 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso554616eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324777; x=1793929577; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KBjoHjefEpt6gXeu0uBAO7mx6fOzElk1Inu+2ky7I1c=;
        b=Blbw32TYs1GAAe6mhwKayNf2fH3k4xFg6Gm2EdDNTGf0JUBg9rbfW2u0Xige5J/Jab
         MBSTYEId+QAFGufRYuFCNrd85yiGndF32YFhmGDAo2wjZszKcmLvEhb75XHFd2QkAtvv
         dOilxYWvu1+N8MpJpQjJ9vvrzyvbdioqBkP9sCsbu6AW4lmMPzF0yMmhHkaQDqsaD1jQ
         l3iKICL+FFi/9uBC/GThHEruPT5eGO51Gt8D707CQC2DqVsISHKOkv30FOT6rjDuc5aG
         OgquTgm36ljMLFibp5x38CGfwHpVXV88yjKOswrh6EJ7yO8XScgTnLjPGv2lfkzm3h7J
         XrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324777; x=1793929577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KBjoHjefEpt6gXeu0uBAO7mx6fOzElk1Inu+2ky7I1c=;
        b=WDo3xdIKmg3EhAH6jBKQ5F1DixKGZ1efqEkqqx+qv5oCUF+Wp57Pv2mEZm5GJKnp1g
         NpHa9Crh44tl0eQDqNqhwdUj5rpkGChiULo3gZ6MI6SVu+XLpuJz+IAI6zfEB2nn+Hak
         /5O2+hTmAnCM60OvhEuS191iE8smT0UPx0ONn8fa4InXcVa+9BQFzg+ay8hpV2pH/nFA
         ngyAHA5nTBlc7te1peEqYaCx+5BsaCzb8Ltz/bPrcm73tQ1cXXx17YovnDy+1lUp8ecJ
         lhkr5HYWYgKl1kkswK91WrqU2R7Icl3KrLLBmvBvMhptakePzQ4GzOZN7l0Jfu1oDL2D
         ymSg==
X-Forwarded-Encrypted: i=1; AKwUvBxI+n9J18K75rjywm/MDtpUH3b8COu/PH9i7F5+fXYBZnKGeazG3xxqrTYJezCJZ5+kCm0WAsRqS1YJ@lists.infradead.org
X-Gm-Message-State: AFq9FYKtkxYY5/NThW+AjtYhesKMkaLUxMaOX9nC33SGIPMPY5jvFHxR
	MxomsV1IJfmHxQUJM3qqRBgV3bkGuaPsbOaiOMTUFO492L33b5buVqc=
X-Gm-Gg: AYBFou31bV+bMKLmlgBB1UhzgVMZpw8Rmi5KQu/jGICy+wFc2IdCK3/KIetsNX7eBxM
	bjBuOR0AwuPVU1kUl3M9eto5N/njSHIBaeBfAS4fZ8ebh6cdzZTad8mk1wa5En+gX61jq1rR56/
	Ht2T5PmxAICg77NEQbc2FnYOTLd6A3KgH13AdnPjPpaJNkKGThnFhspD2ipXt/nJbEkYRkHJjS0
	dOXtRryhdOwiuq9AMVhYO97DWv9LE4jPTVg6lViGDVIhl6PLYN8cax4rliXnZXkQvAXpWuTfk8Z
	xGS5cjki+iGvk+HnncdjLGT/puRLbsLyE/svyQ8mQVkdoX3yqf39LtxvhrMODgOm4L7MYD27AaK
	D4ZHnAp5TJfdXIYY6eEFabNsm3PNWu19XTbx2YjyHrUJHEpWYfLhMfvO7WjZtwVqXcYfaOyPRN9
	8ZvVpleAyWtJM9K5DWVutqWLqlU4WsunKpFp7EZb7Edvbo65GOUEM9ZtTkpC3+S+uDSz8GyoJ9A
	TeGelYdsDTBLl6Ew/XvfqzkjPZMV5x0yCvkwaIBPnYevIJDSNWMnt/NskYuMlottfkVq7hsF9dL
	AqHGEhejG3kSI0GcCdj9i2Y572yGbSbAVUFUGOmZdMVOPdx9B705TW/K4p2A3GF0jDhlWbVkemg
	A+K4fPmzrQB1n41a8
X-Received: by 2002:a05:693c:20d3:10b0:369:fa21:ba0b with SMTP id 5a478bee46e88-36a42451227mr1548074eec.33.1793324776753;
        Thu, 29 Oct 2026 18:46:16 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:46:16 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v3 4/5] block: map dma-buf iterators in blk_rq_map_user_iov()
Date: Fri, 30 Oct 2026 07:15:39 +0530
Message-ID: <20261030014540.3065403-5-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_184618_397172_9242B764 
X-CRM114-Status: GOOD (  13.99  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Anuj Gupta <anuj20.g@samsung.com>

A dma-buf iterator can't fall back to a bounce copy, so map it directly
with blk_rq_map_user_bvec(), which already handles it through
bio_iov_iter_set(). Fail with -EINVAL where a copy would otherwise be
needed, and update the blk_rq_map_user_bvec() comment to match.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 7369aba74771..a65b255b229c 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -459,7 +459,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
 
-/* Prepare bio for passthrough IO given ITER_BVEC iter */
+/* Prepare a bio for passthrough I/O from a directly mapped iterator. */
 static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 {
 	unsigned int max_bytes = rq->q->limits.max_hw_sectors << SECTOR_SHIFT;
@@ -506,6 +506,19 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	struct iov_iter i;
 	int ret = -EINVAL;
 
+	if (iov_iter_is_dmabuf_map(iter)) {
+		if (map_data || (iov_iter_alignment(iter) & align))
+			return -EINVAL;
+		ret = blk_rq_map_user_bvec(rq, iter);
+		/*
+		 * -EREMOTEIO asks the caller to fall back to a bounce copy,
+		 * which a dma-buf can't do.
+		 */
+		if (ret == -EREMOTEIO)
+			ret = -EINVAL;
+		return ret;
+	}
+
 	if (map_data)
 		copy = true;
 	else if (iov_iter_alignment(iter) & align)
-- 
2.43.0


