Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD54CC531F9
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZaJ2bTFIw6n5gqGH1V3eysAf/jOPI3Jsri1IzDcY9ak=; b=kq8z7W0+ggHh2NTmTn0EXhHf2X
	szFOhOlCIjvgh5xQNeVVUmimIincDqzwoz349NMnfW+1fsM9NyV2EmaKpwu2wZZiy6NFae3FpOwdx
	j81Y7JZmnkHA40VtXoMUxJlk7URgi1nG4k6MzTscjGkU2f9CR5UwhyMD2M9bSiLdCRzKj2lJ6RQTE
	Kr+NWjBiL9tMpMkA0ERXcHoir6cYz7quOo8ml11ZxX8a9fL+Eq8fgVB1OCMk1P1r10cE6KClw9C7E
	Gn/LDxpTF1m8zrL9n715T0OYxBcsEFigOTx8f1L2/1LiA8JyRLbXUPcTEyflN9DkYWGy9sFZ9mhNi
	JMJ2k/Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6F-00000001752-009d;
	Sun, 26 Jul 2026 11:32:55 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx6C-0000000171z-11m6
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:53 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1263260f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065570; x=1785670370; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZaJ2bTFIw6n5gqGH1V3eysAf/jOPI3Jsri1IzDcY9ak=;
        b=N/LK4a/jmDsRhSIjeUjk2ExrMSrtomWg6IJ8xd3/vZREGcpmw4oJMzh/jKBOVUR6CK
         ijmvvbu6LwlnRJM0zmw19wvsASeXg0CcLiIJglP2TE5r9unGqRwWkfhUcKmf5sycn5LC
         6LFYqz0/iX/N7GLKdW1j7JegNe53T6l8r/VlXrtJkY2zxRAv0GuMJJfY1luaoMA3liNT
         L5C6sMP912581Hg30bbdrKLjwuelvyGzSY6054epgfVMjGr5omUlDkLRyJkXwCa2MeLL
         4EnQi+iyD1cam6syjlNLLK0db3Cz4/cS3CFppm2+5yyOuLRaVsZK459xJ/D2/iOSCCHk
         GZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065570; x=1785670370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZaJ2bTFIw6n5gqGH1V3eysAf/jOPI3Jsri1IzDcY9ak=;
        b=feWWYyLKmkHH3ZXc9UV/dcMTANIMWl7ul3XwnWbmsEYgjz+ZAtHbdkIq4V0C17hvLT
         CwHE1aFFp6UKRAOnFL7SzsUgUQsqLEXfz9FGutGFlJuJJQbszraUF3A2/nWuxRrCUbMh
         7xIGD8c9MxQ5yzQA3ajmW9cc7EOCpegzU8kB5AcDBgKf8GgM56tjGk7frbrYRfQbZ2lp
         6RWyhUVw5DBZb9rUMJrlf1uizOYA9zkM8My5S59jVRep8Rsxp8ea/ZBlMPDqqfyunJG9
         YlpU2i3Q/PQBgbvdKX58gfCGTU2zLJV8cWbue/s5j9//j+BQgqgsNKd19yCGg9tEhO7b
         7osQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq170vyz3fXmnhcNKF0KMkKxY0QlgBBi6M4RfivKDEljPym3rMr/zD8cpI9e/xwBD57d5+A7sBhOIsC@lists.infradead.org
X-Gm-Message-State: AOJu0YzknxMHF69nMt7jxMmL4HaEHgCz+mG+lmf919DvlEKzmPazifUJ
	V9r2H3i+O9nloUX8JzHiIHy1eIKpiRTKheZ0t58+C6bl1gweALPUnMRCLmwcXVJLOQ==
X-Gm-Gg: AR+sD12x3n01KBojNyjjbcUbeSC6CfDi7b5laJrVyVjYs13jrNSe37CkkAqyVsRf4b2
	FzrzwTibRnp81Hn5GdKBjNBI3YW+jJS/oWMOgNodYMDWQa7f6ZBxovT0dp6VdzzbV9E1ock1mCF
	iex3c5SEzZ0JJr5OGn3xm6kVLq/joFkej5Q7Q9PToqEdjQLvpq3JYYaeA1mHSTWOyRurtXJlgJE
	YfikTG8iNJQtfJDRu4mW/L0IS4CGHezACqp4HoJ3xWlL5lK/h8hlN7bhjZ5pY7j5EmjgL7yxpw7
	uez8ZQ4ZEsYxaMc2dLWyjihtskFcMlFSlNd3YKnM93lIim/KUJEfqarzf6YtM252FtJdFVJbI/+
	921TzREA8PkYESEpsc4s03m6uKGKded4RXe84s0NjL0oLLVwC11R/ekaDA+xX3z55SG2jhOE5T/
	TsCNVWpCr5gg4fn0Ae4NmC/Jxo7GT/w49QnJGSV3iyN4xYV1RexCWEtF8RQgeKLzHkS/14Yjobm
	4kEvidXnDiZffS3G1uAsRN4MNzmRxmjk64mMo3NWA==
X-Received: by 2002:a05:6000:402a:b0:47f:96e3:5322 with SMTP id ffacd0b85a97d-47f9fc8f595mr6148931f8f.7.1785065570487;
        Sun, 26 Jul 2026 04:32:50 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:50 -0700 (PDT)
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
Subject: [PATCH v6 07/12] md/raid1,raid10: skip futile retries on P2PDMA mapping failures
Date: Sun, 26 Jul 2026 13:32:24 +0200
Message-ID: <20260726113229.2154269-8-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043252_314218_6DE387F7 
X-CRM114-Status: GOOD (  15.02  )
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

BLK_STS_P2PDMA reflects the peer/member pairing, not member health:
retrying the same pages on the same member cannot succeed.  Keep
WriteErrorSeen so the range stays fenced, but skip WantReplacement and
FailFast eviction, as commit f7b24c7b41f2 ("md/raid1,raid10: don't fail
devices for invalid IO errors") did for BLK_STS_INVAL.  raid10
replacement legs are unchanged: a write error there fails the
replacement, whatever the status.

The failure is whole-range and deterministic, so narrow_write_error()'s
block-by-block submit_bio_wait() retries are pointless.  Record the
whole range as a bad block in the completion handler instead.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1-10.c |  3 +++
 drivers/md/raid1.c    | 11 ++++++++---
 drivers/md/raid10.c   |  7 ++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index cee21452e066..89daf8558251 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -309,6 +309,9 @@ static inline void raid1_write_error(struct mddev *mddev, struct md_rdev *rdev,
 {
 	set_bit(WriteErrorSeen, &rdev->flags);
 
+	if (bio->bi_status == BLK_STS_P2PDMA)
+		return;
+
 	if (!test_and_set_bit(WantReplacement, &rdev->flags))
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 19c4dec450de..83ebf40237d5 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2624,10 +2624,15 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * narrow down and record precise write
 			 * errors.
 			 */
+			struct md_rdev *rdev = conf->mirrors[m].rdev;
+
 			fail = true;
-			narrow_write_error(r1_bio, m);
-			rdev_dec_pending(conf->mirrors[m].rdev,
-					 conf->mddev);
+			if (r1_bio->bios[m]->bi_status == BLK_STS_P2PDMA)
+				rdev_set_badblocks(rdev, r1_bio->sector,
+						   r1_bio->sectors, 0);
+			else
+				narrow_write_error(r1_bio, m);
+			rdev_dec_pending(rdev, conf->mddev);
 		}
 	if (fail) {
 		spin_lock_irq(&conf->device_lock);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 428bddddfe71..77c7d8a59916 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2940,7 +2940,12 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				narrow_write_error(r10_bio, m);
+				if (bio->bi_status == BLK_STS_P2PDMA)
+					rdev_set_badblocks(rdev,
+							   r10_bio->devs[m].addr,
+							   r10_bio->sectors, 0);
+				else
+					narrow_write_error(r10_bio, m);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
-- 
2.52.0


