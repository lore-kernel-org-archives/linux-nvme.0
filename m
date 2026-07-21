Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4950BC4452D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=; b=C4bmNOVNYRmbFP+nKk5EOiMGxl
	po6Qs4viIZ4E9yOidZYxC26okV/ljUEWYqXsQOv6X4pvbrFKSifbzEXVhoEZ9SuQfMg4gMghWZLf8
	4/Ow0S330XyhFHethqmXuxGWxJ/S4q4DO49m4LF4CbxPmyXJB4/nKRvUTof5Gy6B5eKjswsQ07oTS
	zFp8e3/7ckLtDLHi5hej9LTiSmxhgiwBjul+/mCQ+k6GdGBvaPK2rnL56oOaoa6vdci/1S4enH00p
	U65HhruIGkCOXr+Gm1IT7npjy/DPo6YxnhrNbumm4Iz67HLAwDw+lrqFd2lAj7Vq2oznZ4cfeyLQb
	/9PkDoUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXh-0000000A5P5-1LIQ;
	Tue, 21 Jul 2026 17:46:09 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXd-0000000A5MP-2uwj
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:46:07 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-471eeac43bfso10920436f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655964; x=1785260764; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=GkvbktGk4dIw30IzgsudQpnIoFBhY5pvckq+bWKcwOyqr5+BJml2WlmtQJWvdUJLY2
         bwUrv0fjocFBxqNMfLBPdXwMVldO037LzgtW44UN6tGn57TfbhVynE/eP8KZtXBmE8u8
         8LUFz5iWbDMS62hj8eOB4CfRFtczkdIbW7ou6x07QRMwa6S4q5q9H/7ooEgIk2IKvYOP
         GuiJA9onB52HCvihRFaaWgKUWeFZUmFvYnOgK4Smm1z540Q8zb9aaXM3rxwoy4yka6Kq
         RoDBgOFtdpMzNAXZuWb8f0bAJtFKfqo9utGn+TQy8WwA76lG69uQbJrZMW8wiZ4G712X
         rGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655964; x=1785260764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=ljWK68bU2pjLpW0B9T+GagD98bpZTjSerbia3an/NOiOVqzpP3KVHVmiNtr6HooCM5
         F3fIEFuKTtrUOzRxdMkSXW18ZJZeTSlDPkXtDM2T8CHz6j8cDbuRILlLjrX32MgJWCDE
         OWszcXMksWzUTcZO4ebyxlRYQZ1x1XYbRokrc/MXRHO4xVydlqHe210oFAwDd/EOJKSX
         xiMaYdur2+ZG7n7gpC4nEUMwHogMsX1zsBhxY97fki/WsfuyZMJGLDp6dDmVDaTPkf3y
         hx74DvTr5CdUydWQXVc+jmrX25KXnVhJ1u3C/s/daoxvudMJYps3Ts1DXjMa+kHeVsYy
         BHSA==
X-Forwarded-Encrypted: i=1; AHgh+Rro5yZU+CyCX4bLqEQ6AAi7vOllq39JphTzNp1gIYws8E41jF1iA3NMky+wLTvXq+x18Wxe0pIf4W6z@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1QJQPZFX1GETSQEL1sQbSfKkPle3Xeu/FDMWWEF5fYGvIC082
	xYbxG/n+RnzAbvdHNhzoJovoMdvPTmo8UEx40n9u/QyxI+m8RdO5+OyT/7sernG/pQ==
X-Gm-Gg: AR+sD115h1RvQasMHflgUjxE9vyUqLMXQ2cSGGc8yMs3a+NOOwp1i4FD0L3/I/fQ9aI
	NW4UfXraDxrQ8vKnIjIqHjrO3jDbV4cqVEtbRIEYG0N/3khDbjEWOoi0pXnD8zM4wyqItAvMXin
	eDg+/9GYVxQrxr1lhnUO8f5YPve+xxckwhzBHjBQD6YUoVX+7DYnKJGKd5XQj2h2ebGttqR/nav
	N4Wd/kAZy4lwHAKqodGoK7GrzBtSiSiyfdi7rMOCoF+1bAVGh4hK64ET29PNlD4yOObzW9aoL+j
	fkBJLwPwLSHfSO5O38/Ywh3W4UGpQqV7jp1b8Rbqv6nk/LVAooHr4EKtAeGXZisIfvqvQO0DBbe
	qvuvbq4X7W8yoV4N5SDtfATX2nWTWbteke1aPuW6wXC4NalCXzeXbz9OxKUe7jDO30WMhchGOwV
	r0OJjA+D0LURE/Uh+tIGur96+40Rky69LLqVw+3nddnuMMExM=
X-Received: by 2002:a05:6000:2084:b0:470:6dc:848a with SMTP id ffacd0b85a97d-47f622fcea6mr22185571f8f.2.1784655963771;
        Tue, 21 Jul 2026 10:46:03 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:03 -0700 (PDT)
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
Subject: [PATCH v3 2/8] md: ensure REQ_NOMERGE is set on P2PDMA bios
Date: Tue, 21 Jul 2026 19:44:56 +0200
Message-ID: <20260721174502.111503-3-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104605_753961_E0314629 
X-CRM114-Status: GOOD (  15.57  )
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

md_submit_bio() strips REQ_NOMERGE from every bio.  For P2PDMA bios
the flag is what keeps requests single-provider (see
__bio_add_page()): merging a P2PDMA bio with one over a different
pgmap, or over host memory, maps the merged request with the wrong
bus address.  Set the flag on P2PDMA bios -- bios built via
bio_iov_bvec_set() arrive without it -- and keep stripping it
otherwise.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 10 ++++++++--
 drivers/md/md.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..3770bdb4d4b2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -451,8 +451,14 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
 
-	/* bio could be mergeable after passing to underlayer */
-	bio->bi_opf &= ~REQ_NOMERGE;
+	/*
+	 * A bio md split may merge again below md -- except P2PDMA bios,
+	 * which must stay single-provider (see __bio_add_page()).
+	 */
+	if (md_bio_is_p2pdma(bio))
+		bio->bi_opf |= REQ_NOMERGE;
+	else
+		bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index d8daf0f75cbb..73df1a6eccd8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -11,8 +11,10 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/badblocks.h>
+#include <linux/bio.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/timer.h>
@@ -22,6 +24,19 @@
 #include <trace/events/block.h>
 
 #define MaxSector (~(sector_t)0)
+
+/*
+ * P2P and host pages never mix within a bio, so the first bvec is
+ * representative.  Read bi_io_vec directly: bio_first_bvec_all()
+ * WARNs on the split clones md handles, and data-less bios have no
+ * bi_io_vec.  Not valid after the bio's iterator is consumed.
+ */
+static inline bool md_bio_is_p2pdma(struct bio *bio)
+{
+	return bio_has_data(bio) && bio->bi_io_vec &&
+	       is_pci_p2pdma_page(bio->bi_io_vec->bv_page);
+}
+
 /*
  * Number of guaranteed raid bios in case of extreme VM load:
  */
-- 
2.52.0


