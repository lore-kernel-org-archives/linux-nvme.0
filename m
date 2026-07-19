Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC17BC4450A
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jul 2026 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2eFgBNGHZVs+4VEn+rFjG8dtsShNuRCRL19zmjqYsAk=; b=Gall/i+HLZi0pTL9s2/O8ElQBn
	sLez6GSzLVwda5ERgO2eWyAUAuNQCkxlzcEI+ey7nce3LKV22QDx3+vV31j/1pNTY13HRExN4qGhM
	WFlR8cQk5EXpKd8jo3OaWGJ5mAsD8+uQDJnKxOn/8ItWs7aLOXP5Ol4PuILs/fC2nNalcv+8bVE8C
	9FlUWQYWsOO2j7veKnzNkxxxtLvPRd8pK/Ujw6nGCWqeafGb4pZMmYC9P76JFwz7EMVJ+xwZfAjX8
	C6cIGMGUpLPTVl7STmTIm4cnbOnWRlNvcfPWSTh/TipD7oRUEEpzE11OgOWpSuhBOdhAA0RI+JK53
	FwwFI1nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9Z-00000004vec-1DeD;
	Sun, 19 Jul 2026 10:53:49 +0000
Received: from mail-wm2-x00.google.com ([2a00:1450:4864:31::])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlP9X-00000004vbc-02KN
	for linux-nvme@lists.infradead.org;
	Sun, 19 Jul 2026 10:53:48 +0000
Received: by mail-wm2-x00.google.com with SMTP id 5b1f17b1804b1-492367f3094so37280435e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 19 Jul 2026 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458425; x=1785063225; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eFgBNGHZVs+4VEn+rFjG8dtsShNuRCRL19zmjqYsAk=;
        b=PcdDbkyGTqJJGX69lxBOL7Hwcq8V2RDPhOQK4SP7WqbDkhf1J893spW6hkte3dX1Et
         CFtsfQnbESdyg1lLvztkgHNXuZiUUsjoJEPMysAwos/LMwONPIFbaksuAZS6MOYD+5sd
         w7R3cnSQGTWx424YDQEsXAOIk27nMm1b3sKA729bt2P30Z/TQxk9gKzFDSpwpUZpp9bJ
         uW1g7/GTLn+mrSnI5muGF/mXuDlBP9SiTm0HQGw+MKth3CqjWqDW0WZ6Y6GthgaCLB4P
         3AV9xODxWiUrUpm4wWl6slDLA6D8Kl5agpFbyPNk6rhhbOVOKCieFFL3MDF/ycO5H12+
         2sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458425; x=1785063225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2eFgBNGHZVs+4VEn+rFjG8dtsShNuRCRL19zmjqYsAk=;
        b=BOYIX2o6V/ra0kM5g+EHjaTEqF+Tjd1zP9p8jIG9cs5TaK46wLhDAi5prKx8ge6YV3
         a5QajHGsMxksONz1NYB3HSDKKN9rc5S278IyghL1tHuVnnvIrXdYqG6rgHkWPBfyBfFe
         DyFNVBMb+zVeCnWDq34Cqp0MsTa3Lt6ZwblS3gHC4OxNtyldXBm2ramEqLgpLAJrCytv
         oei30vtLRtDG3DyI2yYNnlkezjPopMpNZ3Pb9ZULZ0mDYwRMEMHGbXHUzXQIq+n9G/al
         ZlJvP1mPh9aor7c0i+/ywMONYGGDKUn1euTAY7Y5tJC2raOkMv1gvnssdJcz8Rwddwxr
         c9AQ==
X-Forwarded-Encrypted: i=1; AHgh+RobGWGpZ5t4jVfbGHF9JLhr8FsU8yDhywr1giGBFXxOXdOcN9iFOASwspcnQtJJYSpr/1jhQF4kag12@lists.infradead.org
X-Gm-Message-State: AOJu0YzP/N+AH8RNKIPgqSaPgS3WVvyU7uWUTru+jCdpLQ/3Dfqv+37y
	eBmVJmPgxFbpbxmTBTMoePduVH05y6OX4Z5XvsUvcUi+FpgMcyPlC9fou9QgQ7+5Mw==
X-Gm-Gg: AfdE7ckQJydKNtRICA6zm+vTnizJxW+4FJQ9BANxp4UaNMf0oLwJu+YwpQY2ZlZ4ZVi
	JxnAOBO6QWysVKBW+0vcF2DpivMexszd7AHvMqLHcG/CReMCIfmTO5GTl7tgTWSBVA+IQ6OKJtY
	cMVuyNRDRaVDxCtrNSOxblvSEuU5pj6DUTqDd6i32VrmrupoJm/6RHhQtx6YVbLwW/LUqd2LAla
	9Gx/8aa2xXssnMulTLghgp9tgpZf5yJgFdarfmZhvj1gZd+DF47V8FLysyTjlW2OemB15OcdbcC
	cBOsxFb3K31ok+qf+VO3TT/jVmtRQgwkmXwppqYhCoZNMP3exbKuI/J/6herHGcmegC/9sqKVQB
	jYYk/3Hskbf38D6/6JZ3ulmjswf+n5Njf3+MpzySiXw/eHVJmE3hyBYlaxbjaW2X7oVFxM+df
X-Received: by 2002:a05:600c:4585:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-4954a50b811mr100979195e9.26.1784458425036;
        Sun, 19 Jul 2026 03:53:45 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:44 -0700 (PDT)
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
Subject: [PATCH v2 5/7] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Sun, 19 Jul 2026 10:53:25 +0000
Message-ID: <20260719105327.864949-6-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719105327.864949-1-mykola@meshstor.io>
References: <20260719105327.864949-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_035347_071594_98C5A09F 
X-CRM114-Status: GOOD (  12.37  )
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
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 914fb86452c0..f562b6bd438b 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2573,6 +2573,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
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
2.43.0


