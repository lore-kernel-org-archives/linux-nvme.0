Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28120C531F9
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=; b=DdTh5dfxFD2D5/LfE59LjSI2rj
	q2crKLirQ+3QUSX3vL1DxWK3WAWI59qQJwWwCRSLxhlZsCRQUqF2sitxIh9nkEtr79ibC53EnfRwA
	6A+eTB/uOnmvzs12ynnSAVIBwP1JrJDBYAJJJFyWLA8wKFkG6qem8bVBPLPX2PNmD98gSCPs88a1L
	z0DGhZlqHHEw6xjuxpjcg7J1TMOwLeINwfV7GrBIsS3f+quSIoppxdrACNLO1NSjIgCbVGT+I0rmx
	lK5Ccc5AtOZ7aHBbogF7u1QRK2cD2QKj9717Jrt2p/6EO8Lg177DM3OAMbqbWYe4DPe/zc7+X5rcW
	CMbAvmmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6C-00000001736-2y1d;
	Sun, 26 Jul 2026 11:32:52 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6A-0000000170e-1J57
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:51 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-47f71156e1aso781652f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065568; x=1785670368; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=Jn6wILipFdDRUrJqSM5D4wGxNMWo85+CBIbwBcTagw7a7sie7Hd1mJ/fzKGjo6eUzj
         +6tO91wc7kT4QQ715P63Pl8zAxC4trC03DvrUqexGB3MTASpDgC0lnzfmI0iqbI1UMMm
         a0tskVabdB45sMCsbUrT3ahY6KVikYZl8Vi5vmX9sgvWJyPZtSUHXyoef8c6IkhnYGgP
         UehPzicCaObICZhKHD0EiIEZIsL/KbdRBzNHq0RNllZDqCOdK5UxyCJ82/Y3x2KORXTA
         I5HI3Um/uqH3iQNHml8p6/1tLaGzq51d1xNhl4Q4aEodL0IkyXIonNhyC75hL1qdTG4U
         uASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065568; x=1785670368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=dMe0yAC8dFWXhvmQsVA5Vdro0oNwY5wxaHQi59P1TX0doOxrBBk4/j7rj3SbhWZUuO
         Mk8BTZTnQrhbvRogx+hjc8Z9lD74cOQehucpRpTgHxqfK4u58NXH6vzBBROwW64z2i+1
         a8KN8Lme+C+W0tFhD/lrVOS4wW2zWXQDne/9fbFYcNh7NJht9YWJOtBoH14AbWIag/rM
         moyi4B2jHAlb71WyJhcG0veIsRQt3PrbBAkl7qbn+hhZEf+vKMeqvFjicknFWB3bG791
         sOPBCbCGgE0J6PZhMY9o7PyuhOD8CWGCmg6YmLsZ2Jqj/NIDRxV5vkkaXJAuYxWlUZtT
         SEEA==
X-Forwarded-Encrypted: i=1; AHgh+RpFHBJ2Mn7CoEYBtQii8jxMzL2Dq341VxVvHJziS4wegbz2fzaf30nMLQ1M6TcaF9/iVAAP/eCGtJCK@lists.infradead.org
X-Gm-Message-State: AOJu0YzSVegoE/e9FB7cvMqk5dowt1Byt/ZzvsftCWIIm6AqZHEjz+Le
	f13nE+xKPypou7wCH3XV4i4EgYJ487RM9YfRvqeO9yz+0GRUDi4A35M8nBU8RZnZ3Q==
X-Gm-Gg: AR+sD12eawQm9LcmRoAZ5+ghT95fsdNHWOZV2iIQit6KR1MZBOYu4lBgFgNbA9pUl7Z
	m91+kUIZUeQ0nQYM3rl2XumlsdZJh2HfJ4zWHvcFyCF9tyCMGtTI59ikOYFBJtgXD+7zkdBs/YN
	c5+9xc6kJp1rHokEIzRWRmlvmgZadRm0W0h6PJmlHKeVFF2mncbi5r4nZl0RFmoX0k8SgFzYaJB
	EvyTzEXJTMojRgULi1t974ZTz1h+mSJQnOUlu4FVoGLhO+vsIfxB5/0zytM3BnN9zLZm8CBL8Ah
	IVTHM0oYUnwjn85redGH0/qNE7vcHCyAbZPR1J+nn2aTT9eV+9IhLVoIUxOIgzJgPDQvYVqkGx6
	uyuOk43xNvJVGjza1BeHWImfbI2Bhk7+60b4XRuXP7u4lOkeSKfhua1qob+CabmVdns+N3I59KK
	jr68gKOHVaSlY4+TqvNQb2GpuUwf7nYzVQQvqsQwzxwRvBPmBY0O63ZOKBGyZA82lvoYGgiavPH
	Xac4KsuFRvKh8zdrdbKU5il2ZBeDQ2mHOQF/oluTVwu5QG8SR25cJL3UQnfmq9Ga+5Phk3eBeQc
	Cu6n9Z5oULa9SQ/C2DEOYyYscY/+rr4hTDo=
X-Received: by 2002:a5d:5d09:0:b0:472:7dce:d8c7 with SMTP id ffacd0b85a97d-47f9fe9e8bbmr5988536f8f.36.1785065568316;
        Sun, 26 Jul 2026 04:32:48 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:47 -0700 (PDT)
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
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 06/12] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Sun, 26 Jul 2026 13:32:23 +0200
Message-ID: <20260726113229.2154269-7-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043250_361696_489DD6D7 
X-CRM114-Status: GOOD (  12.25  )
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
index f07edeac6e5a..19c4dec450de 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2561,6 +2561,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5b63175fb382..428bddddfe71 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2823,6 +2823,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
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


