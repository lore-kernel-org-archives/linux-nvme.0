Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDCFC55179
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R0GcIDTsY2CDASlyPqk465WOkbyFB/dgtSdtycnJJZM=; b=yvJWaRBFvdSwqOsAkGoictiOjx
	TOKneeTYuEsm44LG4JYTh205neBy64irHl7X1dGx+3wNdG64mNC5YJBWltAx0nnaOEHLLqT1c0UhV
	jRF6S2Oos8hTaTWv4+EzhivXaepFkB1D+jdh1TV1xQZ19R9dfKb0Q4YPSEnEdtRjA4VMZMXNB/EnM
	imyT26v4KClCQyFbiXjFlossV3VU2EAvsQInRhYEx4iedmMwaFdWR8H8Oh4RGR62n8BHXePtnnOBQ
	TrKtFq1JUqTIlmGAJoQ6fppbtk+LHSL8xPceHU34ksa11E14/C6jVELUoiqrcEl0gEYoX2qIj/NGd
	8+rSYPDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqPX6-0000000FOMP-2xLV;
	Sun, 02 Aug 2026 06:18:48 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqBwf-0000000Eozf-3N9I
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 15:48:18 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2caed617615so25865275ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599297; x=1786204097; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0GcIDTsY2CDASlyPqk465WOkbyFB/dgtSdtycnJJZM=;
        b=NcTYSnmJV7Q/E/h8ZHP2AoSwyagxCDgAvWVFdRTSNHMqqUUos15MTY1kJ/sFGlpsv6
         9bUm2yjphI1zsVQ3tARub9GMos4XhtJCQoIsx+444FYeRk02jeLcAB5KLBIlGSM0UR2t
         r7b7zcd7tAhdTayjZ1y/hG/KATXJfBOlaGjwVTrj6FLJsUoDwXFSUrcfZKrIk9CIQ4o7
         cGlOW9WJUICcYng5jjmOSJGUugc+ld8JuJLbWXUnBwf3AAOYfd/ztL8J8xs9YgC8He3u
         fL6R+DOBzvr6qF7JoxKi1uYUTJbeLB7jOt8JloxVu/y6gyINYZRjaqvtHfmX7+1a+IZl
         WIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599297; x=1786204097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0GcIDTsY2CDASlyPqk465WOkbyFB/dgtSdtycnJJZM=;
        b=pS7z04V6YbglahZr8Wcg87bS9RopMJrF+/xweSWvQ5n6m80NmfuMbUO0hcVilXP6Su
         xkmc0DdmTmqU0gk4cgt/LAb/+qRNR2jTg1AlfbmZ3kgnJ51tqixSrXkMST2j4dYQ/5UM
         eFm6WSx07wL6fBPbYZfwyeZbU0XinNIc4ou0brtQRbPUPFiwAR840HiWwYPtny5euvSc
         VytPnfGt4ak4LfISAEf9GGr2tqkFMeRyNpuH3NfMlo5oVZzv/zAHbXjxngKuoTN3lNjZ
         KuM4h7FqB3ObvAk0bOF6Lul46lilE4G8h34AMrFlM1zdrRxW5P5f7hWqfBD37U+hihNT
         yvcQ==
X-Forwarded-Encrypted: i=1; AHgh+RoA68DGpwXmvNM+4N8mmaNPmCN9g4RbHOVrGBM6NUABSINU0vhV+n+QLXdB8f1z2f1Wb/VIKrX9G2qE@lists.infradead.org
X-Gm-Message-State: AOJu0Ywsq9Giiyx/+PmB7NoUXGy9qUo7FgNyi873c4NeC5MW6rOXCjqH
	dd3ex7vazgIksWASJkf3gEixaZcNQ8y50CWLSUOCwn+YL6L+wj0fpG2J
X-Gm-Gg: AR+sD10gqiKD8rqkvBLKpKkJAH2jpx/HGeHotgNkiyEztIrUb4sgFvudjaIW8JpVyaW
	eHRIJXzJ2angbL88eGeegH72QNT3YqUmXkhNG8+XEiXdhe4uTTULpLMlhrSddfFQVHOdhuE4aTg
	4f3eFXDbZfcmpK5TuUR5PAGSyvBhaNj0Q3QafpMF+OvP4+UQxdYZfz+KrZ/gsC/+4SSF1nQPx2g
	MZvpFmjC0/NNf25q/RZ1xVBh7d2iQvMyyg5Fxyj7MOhp3qEeGzqsQ0LxTtmtecX/4Aw1YU0tyt/
	5O8YhPcoTycbu30qHd3rPTmq0SbPlmBJE1o99AvEeLMjaIV3Es/Pa2hwygjqdHswlZwvTwpTqPu
	kkmHLSiGs84Gs6AURDd1Tm16bUQmikTQ2S3vPG2t73Y9We98pTcVVx34HM1PxuV1GNuqyVTU8ir
	8i8XQl8uYd6HiPgOTozOE1J5BsXCb1uVUuISi4gMmZCQAFPS/SdX53yaAI72qfyItHVysZsEM9x
	QKvGz5UrJJwL/UxSkjFF1dAxsbnI50/dgI2uqT7/BVtEYc=
X-Received: by 2002:a17:903:22c3:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2d0521bcb54mr36749555ad.2.1785599297067;
        Sat, 01 Aug 2026 08:48:17 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:48:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 04/16] block: always adjust bi_offset on bio_advance_iter
Date: Sat,  1 Aug 2026 16:46:16 +0100
Message-ID: <64f559a1d1ac43880149de5950187beee6bc2aaf.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_084817_844516_D3B5AD09 
X-CRM114-Status: GOOD (  15.02  )
X-Mailman-Approved-At: Sat, 01 Aug 2026 23:18:43 -0700
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

Extend bio_no_advance_iter() iteration to also increment the offset.
It's not currently needed because the currently listed request types
don't have a buffer, but will be useful once we add bios backed by
dma-buf, which don't have a bvec but work with a single range.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/md/dm-io-rewind.c |  6 ++++--
 include/linux/bio.h       | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-io-rewind.c b/drivers/md/dm-io-rewind.c
index 04f3fc8aeb6f..b22719c6411c 100644
--- a/drivers/md/dm-io-rewind.c
+++ b/drivers/md/dm-io-rewind.c
@@ -113,10 +113,12 @@ static inline void dm_bio_rewind_iter(const struct bio *bio,
 	iter->bi_sector -= bytes >> 9;
 
 	/* No advance means no rewind */
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size += bytes;
-	else
+		iter->bi_offset -= bytes;
+	} else {
 		dm_bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0445ecba3b24..f9b8903c6a87 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -113,11 +113,13 @@ static inline void bio_advance_iter(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
 
 /* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
@@ -127,10 +129,12 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 void __bio_advance(struct bio *, unsigned bytes);
-- 
2.54.0


