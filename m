Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7B606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=V7dpZrQj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sI6ekdm0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PrklBKkcVwO3V8O9sw0CVF0qG6S9AFzj2KttEqdFQnA=; b=V7dpZrQjpUvNzZ
	VvIAyU/FdgpO20JtacWqAiCB13WRETZdeNuVuaIxP61x0+CdOev0sI0TofAGzsJbDgIZ2Nx8yu+Op
	M7merqbfPjeHTdUcQ/0zMPlWpVajiw+iM8HsQhlDfSWX/48eWG9rA39uffps1K+z6dOnl/dwJhaZ1
	KG0Sjp/iUQb57oc7wnTR9hpzM4udHKXNecPYBL1TKyOrJIDJLflad4f4NGKvu3H5fmSCDJpoF94Va
	rxdgO/JG8+NO0Bqs4KBw8FcK+MMfy6WMtxn3ztiPZtrz4XP7HxDLBifK65nNC3vT/B5sbZMef+O6n
	G/JX2mbL9P2JHFzLap2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3Y-0000000EKop-1d4g;
	Thu, 22 Oct 2026 14:46:12 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJu3V-0000000EKnd-2Pdn
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 14:46:10 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-157fe9d771bso2499330c88.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680369; x=1793285169; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrklBKkcVwO3V8O9sw0CVF0qG6S9AFzj2KttEqdFQnA=;
        b=sI6ekdm0PLCIvVINqFIFlN/JeF9dXvuSKF7j/vKMIoxP/jn0wzg4U/F2tQAmixlREY
         kvYcmzSpmdIiOqr7ouTJEBnbKeOxdoG19B6C4gwdwIR44MvkIzlmiwebxxWTSFal7r1k
         +Y+TtIBVuBC9g3MzoX7TadOn2SKmgRgiZxKEzLb3A2IIk3C1NrLwU2f2CLcYqLWhg01i
         yH0pTt7svzdVxjidWn9HMW+PVA9ofvbTVZQXJ3Gf3cU3mKWSxd6uP54DOSw+WbEOhudT
         pCjQnamtL1Gr/rTqjtzpeKnha/3GZttNR05TkP+IzkaFUQD52Sl5/R81dcm1lcBUJu13
         AFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680369; x=1793285169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PrklBKkcVwO3V8O9sw0CVF0qG6S9AFzj2KttEqdFQnA=;
        b=sxBCC0Pgl0LH2xb7tkLNSAWPEzzs7jKTirC764WI28nEKn9stjcbfVo7GH4BLmrojm
         aoNelkTd1WgriF90/RuO3/f4veV5jxqGi24Ha/yG0IEbxjJUs8Kh1GBxosWOdnCtP+4d
         /XmVVsD4MZlRXvR+0WtVyFjQSCPkDxBLTE3RKHHRagJpU3lYCs437RC+eDYedDUPsd4O
         siM9iS8Lo/rMH1kiaqV8gB5kes61vpH3erYNtobaixR0MtefO7pwksQvdAtH65JN2lXo
         4iwtagdCzGwA9vwk9GsOO4+0PrXkGtyBsbGzms6awA1L3aA/zE+QSg/3y8I1Q6lD6x42
         7PLA==
X-Forwarded-Encrypted: i=1; AKwUvBxV52nC3TVB56Plsm/gRX7h51r3b9KBZredkAppzm26XOTrhT7spIlR1A3IccNS91hJNvpBWXq69lNJ@lists.infradead.org
X-Gm-Message-State: AFq9FYLu8Xk36jXOY/K5JkMV+6fFPHNJvjjDXysgZZf5wq4K8HYi40UP
	VpAEJ03gvQ0QpJAwcLg9RUJqeSuC4RuIg1hteXxghP6l5WW1jcJlF93TIvuhB5s=
X-Gm-Gg: AYBFou1fFemJvJz9+pCSQfuu1/43aqPECJJqTJpljafPIWXtdAAVPnP4dAq16N8rqph
	4UTSQvxSK4MJkgwd8x43IBcLp8I6gcfwW4BkRwaq17Y6AqBJ0UfcdKEkxkz99az/s3cXZQE0MsF
	gZnLW5h+Udjr4WxorHhKTgiuA+CjDhVmG5U+8S5vzi5hkKHFwP+ztF4/rtaNLkzWQo5kAau707T
	0oD8FCIROg0iYM60X/OKPl+U7KXlHkAYcckbCJ/5LT1zuCeGnYUTEqdjF/2iPgM9KtAOoNzfegq
	Lj05z+ftfr1e35XThbx/2pH4VIZ70xQNOR19dc0kP1H1nCOnm2Ee4r+0x4L1HZoeWePVbZATh2o
	K8wzK3JbyVzgWp750GlTg/DuX8hBCuXGnkTqhfGJEJtLWp2A18csCyOXxtCVxGlNV9qRqZg3bJM
	xJnARv3cl1/q9Dfo+4w2knxuavQAcuiXXPyN1y+PxTq1s/YbqrOlHCKfAN8mOM1mN7kz7gZ9lto
	haJyqkoBfeHoGJxxwmvu6jpPqqNAkkatDzG8Z1Lt4ZekHD/cX2VIX2uZkf0zxn2iEDRJwC3tum0
	LG2nrPyPvLhWcMsUWAsiD4cnShGDsyv2NocEsMExRb8=
X-Received: by 2002:a05:701b:270c:b0:190:d9bb:281f with SMTP id a92af1059eb24-190d9bb28b2mr6570477c88.18.1792680368388;
        Thu, 22 Oct 2026 07:46:08 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:46:07 -0700 (PDT)
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
Subject: [PATCH v2 4/5] block: map dma-buf iterators in blk_rq_map_user_iov()
Date: Thu, 22 Oct 2026 20:14:55 +0530
Message-ID: <20261022144501.2478417-5-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022144501.2478417-1-anuj1072538@gmail.com>
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_074609_627190_704C415A 
X-CRM114-Status: GOOD (  13.43  )
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
---
 block/blk-map.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9cb9605d1f62..d1e096fdb03d 100644
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


