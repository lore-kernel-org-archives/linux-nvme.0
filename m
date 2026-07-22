Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F27C4453A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=; b=vp59R771R3bOiE3ObPoFuqhk2I
	l3irJZ8PHybGzAXbLOUGs1PF9j1htnSTwpSdazLnT07LEtWDZUvuMd+5eaSP6YUepmdCtcyughUJk
	5ZNhXtlJMkhfQHVvPmfV1+vsycgc72zRSCxoMlkVYrabsUlzQo2/AF+2yj2JZFDFuGnMSrruJNIYQ
	Jg8UnPMaA0PNG6fr9VwCm+yY1R/gHXce0INtt2wjk3SJBPzLe69/Lw4mZj+h5Gcz8w6nh0Im5EBls
	aI2ChOxh91xTOxtmXhU5jZlLbBBG+abLBqYol6EmzUsZckdE2tyaQIn9qtm8GbetE3RkAP3N/2qaT
	ZcueJ2cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmcA0-0000000Caox-0Rn9;
	Wed, 22 Jul 2026 18:59:16 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9x-0000000CalO-1aKZ
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:14 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so37163965e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746751; x=1785351551; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=XQCBJWXocPoA8AzL0fnPQvvcVlNeWIJqUy6hy9nwDf4wVYhsf88gmXPTscgWilhYMw
         drJ/x2qpFw7M7DPML1urQokZI+X1m1A/rRMIXIDi2NKEFkLdKOm+JAcRpVYfIslp8ILZ
         l4/AGAZgCrVR7R6CzKktt5m8tp54I8gVwP+W8DtrG8cllben3ZQdraitbndVZxaLsQMQ
         PJWqDKFd0P9Vc7pqLQa0IANFxLOBpMWOGxcfVOJz6/bsZueSFw9qWmVbHotzWRsjo8Mf
         slWi1BF3zL3vp3X4LUpiiRg6RZekqzlDEbTXTGC3oVTxqgavi13z1hv3Bl7DKNLxaWRC
         K/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746751; x=1785351551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=J/OvgoO3AA/WFXyEk9xgfKmrJoTKOW+PfcoUul5l28uWTDZVvxWM5DM0cFk5ClhlW7
         3ELDPJWR9mpzXsXEv5yM9fcQgZUGI+duiWOEmLzoENEqtLGv+UXzPsPbYNkUciGT6Mqv
         Np6LNUjEGKeQ9QrjfKigWA7vwgd98WNlHmie4Iwuwc7Qf8B9cCRa2236mFFqDy9UebBQ
         JHN8PprUCRLGiTcIbJNZhIqWn69vnP1EiNslUly+/vgXNsdWWIcM6ryjmq26+AGEYrGk
         3WOD9a+9p7N3yx74sBiEUMPUKfc5wsRTQqognQVzx6F4iPbGfWB8Y7p9oaPN0Pqg2ewq
         i/nw==
X-Forwarded-Encrypted: i=1; AHgh+RprtGMLJEvMFbdJpJ5yKkNuOln+UNIaWYVhN4ZjrlXCta/RcQirOPIPZ1N6viYu0pUBscKpSWnE/AO3@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+eqN19TLmEfHyY2wBc5yLJ1tk6TD5AjVj2zEA5pOg+QsXn+o2
	wju5zsOnxlMvcbZq8cA4VADIuhMXpH7bHHf8bRrFKDGGyIvlbWxhQUjJ9zqdyNy9JA==
X-Gm-Gg: AR+sD12zKwAWvEhnY6oOpBjzyyAGysx0w0Mdi1fs3sUbea8mMWo7CINjPV5iCbbtTJ4
	QooLbisCWTS6Fzj0d1P5gIGEtoqV+x+YA1rCVsfUBQ32i8VjSG9w4Nlw5s/FTHPYjSmkMyJ/k/2
	38LtG1GWGVYhEhMpJcjiuMhvWoSz+ETQfEZULBeBEj5cMPxg/8QVmZMJAudy+e7J0DToblL0zCn
	NpL2Jwlj0ci0XVWlWwI5lLrL06Fr15b3OEtJFdgJppy20WnlJVm6+39ncb3usNBSujfl1vVU1Bm
	PTN726dnLyoDiEyswH8a4reRISOBApuf+8nSrarQacBlXS6+nAz3aW8awMJ7YLRrZwB2QYp8b2p
	o8qaGSctPyehupgNoNf3CYA0Yr5VUneXmjk4bZ20w2yaZXM2HmALGcOkKkaLbKhAV4zrsE3lN66
	f+LO6pl/fgnT0DjFPRWqwELTIxwLYT16qXda3/eAFmlWH3Qoc=
X-Received: by 2002:a05:600c:1551:b0:495:5858:e163 with SMTP id 5b1f17b1804b1-4955858e1damr203016475e9.27.1784746751519;
        Wed, 22 Jul 2026 11:59:11 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:11 -0700 (PDT)
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
Subject: [PATCH v4 6/9] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Wed, 22 Jul 2026 20:58:38 +0200
Message-ID: <20260722185841.449934-7-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115913_539259_51CA1D63 
X-CRM114-Status: GOOD (  12.52  )
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


