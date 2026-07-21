Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE99C4451C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yn3hWNKXTlSTf/hzkreGnovc9sItcGhl/RSESOOgGvw=; b=l0sMSHyV+qbbEWkY/npVTQ2iDF
	QM5250F6i4GbedDIggV0vejboAFcNSLbxEJZE0W/VD8Pp0SgV8l3Eo34Fei0t4OojdqUFWmM/vbbK
	7sehL3i2ZA9XBHm64CPqAILzJexGZhZOBWSkhxSArxHed0olB5Nn8kzwzzBSSI/vYRkuPIVkE9djP
	0zReHQJRVXmsa+a4B32bfQ2KyJHbU+GHLetJLzXPfAbsmeY5yS0NgAr3Sg6xL/HqNVRGL50JIzqKN
	DmjXs2TmPfzP/Ub9o+5le4cheDeRwWixrSHWmx4OeiORAdaWIl1xlm0oO6pNeB0zFIvRQ2SsmmWwO
	HRZ3ouHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXo-0000000A5Uz-069O;
	Tue, 21 Jul 2026 17:46:16 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXk-0000000A5PZ-01jo
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:46:13 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-47f7444576cso1929484f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655970; x=1785260770; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yn3hWNKXTlSTf/hzkreGnovc9sItcGhl/RSESOOgGvw=;
        b=lNGKpLV95c10bdu1Y917pid/WYwt4u7QyxycJ+N5TQQvTD1nLEYzxVWgfbcgwyJlLN
         ybNeqGxvPANoiTW7Fug7HJ1mONUQO2AwquFEPgy0JTnjkVis7ZbmablAJuMuzHO/FlO8
         qekk6SofX052AbYwmULzRCZe6mEIjNAyS9oT58kRUJak8M9kN+O6jb58/oCZ+yvU829I
         uajm5k+5uP7jazp4+feKX3R0SFF0jjTtv1J+SEg12SnP1zTnR+nqju4l1zJXzAc1HKFu
         sjPQby8RwhoBWFvPxumZYk2LSM2U9QGPIsNx1KvqWWtuYTqadkGsoh6QvhzLuOn+GMhH
         EdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655970; x=1785260770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yn3hWNKXTlSTf/hzkreGnovc9sItcGhl/RSESOOgGvw=;
        b=SI1vum6B3qTHJz1v3WcOAaZNw2vrlIpdgZnmk3Dse6SH/Fn3geM8Usc0ispd6D9mxT
         tcv7jDOwlOr09H6ewZ8Iujl/yzVZnXXI33xo/7quGtwag//ikjsHkO4VertiWybZyTFh
         4SOa3yVbN+6q7Hk6ZWvl7TzB6UCOznQao8k5U4shAGMPr0uMQ2UB83cSIHYV+ceErqMo
         HLNeRIRlNTUG/rX3l5+mnyqhf1zRvHc4rrDieq0h5RkrCKMEn4Wj03ar/PZdNik6oG36
         qpnU1DL11R3C2PyqHAY0qheRnFWxTKr2UZOLZyst5Tf5FL9wxEvOwTp3CJjzICb3WLNM
         asGg==
X-Forwarded-Encrypted: i=1; AHgh+RoVoq2zLOpIWXuNiWm+UqO6TuKS11p+Ap9M7neCzW1SZtUI7Snyd3kazCpZ0ghm7oIfa3qKaPAJ80b/@lists.infradead.org
X-Gm-Message-State: AOJu0Yw212tVH0oTCeS+e12N0FdvelFbrmq87+BuMheUDXV0ngwmK1o+
	nGraOZrNLo2n2knjcQ6JP8uo1XXtlp4Zl+TVW5z1buLH9Klb3eyhWxC9iVKZ3Aao/w==
X-Gm-Gg: AfdE7cmrO00gIHhOFFvicwGHAnXvHV9X2LUTKcjjUIfI/4ryCbHQILYkNmF1f/pqZmW
	vAGPyjkdxEFjk6AJHXRpL+Ti2HnOzlvhM6SLy2Fl4wH3uVB7bRcpQ7zVaWKzUVQfiBa7NLi/iuF
	168ZpfDFimovA4JhuhzVsrJV/HdiGsoFEzlP1j8uCeqtJOJx61A4AB3tlvkMsvhUd1JhI6Z3I5a
	vR82KlZiz5beRmlbQHsVdzTezSipa6hG2OIv+jWTgOV2GZYn8MhZmK4TvSW+lMQbhqHFT2Ggex2
	xNof+XnhRGiCVK3UL4CvdIky7lI1GQ+26L2FcYgXmBiFO8C5qIl87JBj0EBF+75VbZu9DVyHXcx
	UC+bvrDW+OhGd4PseN5VUBLG0oRU28MWxpHzgXwS/juYuhuMqBGwNqCa68GgvCsLXipWPQfFkPR
	78eAhQvFYl82zxgYxVUg3nLXfru5W46cFzD54uT3rABkWHQjnGAH0AAbEAVg==
X-Received: by 2002:a05:600c:2908:b0:493:bb6b:5bb5 with SMTP id 5b1f17b1804b1-4954a3dcc67mr172161575e9.13.1784655970189;
        Tue, 21 Jul 2026 10:46:10 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:09 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 5/8] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Tue, 21 Jul 2026 19:44:59 +0200
Message-ID: <20260721174502.111503-6-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104612_085513_602E05DB 
X-CRM114-Status: GOOD (  12.62  )
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

narrow_write_error() re-issues a failed write in badblock-granularity
chunks, cloning from the master bio and resetting bi_opf to a bare
REQ_OP_WRITE. For a P2PDMA bio that reset drops REQ_NOMERGE, which is
the only request-level protection against the member queue merging
P2PDMA segments across pgmaps or with host memory (see the preceding
md_submit_bio() fix): the retry path would quietly reopen the hole
the submission path closes. Restore the flag on P2PDMA retry clones.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7d769b6460ca..16b7465c233a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2570,6 +2570,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0a3cfdd3f5df..f7ef903a3d4e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2831,6 +2831,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		wbio->bi_iter.bi_sector = wsector +
 				   choose_data_offset(r10_bio, rdev);
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 
 		if (submit_bio_wait(wbio) &&
 		    !rdev_set_badblocks(rdev, wsector, sectors, 0)) {
-- 
2.52.0


