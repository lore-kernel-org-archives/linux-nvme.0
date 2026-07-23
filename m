Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF054C531CC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=; b=oTD8jM0QYeeATcOKxMgwwrQEzW
	/DeHr4NgOiBOFG+uMfEyYw+dp+DLdgHFNzqD9q+UfeubPPURi8o7m7VhdR0WWRLeBTzAHmFsCOSBd
	hp46QdDiE2UINJai/yH75zqkSHOY7mXa2xiYafaRCi7JX4wUSSbW2ww/fX5JIPwC0nIASBxlDMGhK
	EkQsa9RT9Z6EQRqqZX7Wk4Dm0ucmz6VJzqdHvQAh4qHB8ryx+ifN+eS4A5MFJ2LMkJU0ZmuISadz2
	mLgC1v4iD00jv51++5+WL1O7HACjgEt8hDAgstawBTc3+LukC9F1pSeiu6viEJ6ltZ9rsUi2svM+r
	nkiZADDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0G7-0000000F3fV-22eQ;
	Thu, 23 Jul 2026 20:43:11 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0G4-0000000F3ce-2fVY
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:43:10 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-475417f010dso823608f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839387; x=1785444187; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=K5DmlURMHhBPSQBml4QqfESeeBmWVjdcAUAjgMTCjqFDDFTrJXRcQTif6rcArBA0t/
         F10pjtov50hTvQoxNx/OJIluiO3QCRIv/+wOEEttq/nKYDWokWcDUWMo3NUBmNQzM3xE
         +ieILLg0GfOtVkYAyOOa10yukGk6qkRKr4DMa6e3tNNtLybbiNoYsU8fMW8zc7REjkeh
         1O7yQrNRPLzsz3KaDR8YTctPNYLr8QIW0s++NOH5C5zBvk4f2xUwXLwtyrZhEukzvrs/
         lyKVOBfgrDKs0wO3chdhXC3iKlrm/etiQcmPltwsq9ox7L6qjIufW8H9fXDRJuROPYRo
         zQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839387; x=1785444187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=lCRZ7tIM4e2LN5Tcf4Xusr4/4md0CVvTf+sHggbatCEPZFIxp4PZWDDrTXZ+SfoFar
         nbNaTeeVmZrFfM2sX/mVNSN2PK7vf92/Xd7uPODVDmCMqhl4d5sU+QTHobKvZIR54uM4
         uJ+mWUCYpb2w12uKzcY2xgtY1FaKWY63iEzQk7PKB9tCUNn6IXXVGcDgSdGTzTE7zSCD
         3IAe29SnJm9xmBe8++qtcsssxZab/0MPnDDUnk2xnD9moH3SGrOcVvgp2+LeDjxAEiv7
         VLS90yALhxBCffBv7wJMtp+Kxwb4/5di3t3ygfWcA7NKYy7+z/o72Go3WAo4guqb33k8
         b/lw==
X-Forwarded-Encrypted: i=1; AHgh+RodEW719BT2NHK4zdsqufCpmFeF1M3mShD7Ve70WN8M8zU5N1kftYu/fDXyUW/uP1BvhQLPvAfGLldv@lists.infradead.org
X-Gm-Message-State: AOJu0YwbxxAkuaKbyYkhkokgmpJyeM4DeruQT8suVq/5nwsCUD87ifwp
	iRb+SGcEYf9sJ9MJV4D3TEP6W4h9978hYGTkskjZUuOYeiD4WKeYpTp4yOReoV4sjg==
X-Gm-Gg: AR+sD125bR/zE9yXVNdZAcjUTAyjptBO8J/NcBf3VHeuVywDydaMVnttasfeXL7XcZE
	yMzgY3AvyFe915W7f6ecsY5Hp192PIJFh+bXaKktbS6JLywnDm2Vsohmnq1aW7VApvujkfv2qhR
	jryFtxp7HSygNk6xnqz7PwysbAaWuk4mzwU28R4aiPN3/cAln5GDledGaPVBhpIRGkl6t6LwFl1
	DvhwymwxYujZ/SRWJG7NDTOFIwu0UTmGBN46YIRHTHQd2yieI9ALVZDM/gLufptfJLW3zNGVqRB
	M2cV8Mi+KBXxIBIjDuX0Zlaq956VifijPZrSzxKcehe+x+z2uSeEuyiwOukbMYbfPj4xUS3Nhgg
	Qhy1aZ3imHURYQBK5C48HfYsW9KbtjaJFcCekYM9FoidAHcxXCS3Z0JfZGtVPKrWzjSIpIEWbea
	/oZQ8NBgs4OcjywJu4j/JPQT7IoLpkQsUwntSmpGFLMEa1JL9S43TRUOzrUkIRUL/LER/4IwZ9T
	6r2vrk5WqzzMH9h3ZchOWGvLANie0AK5cC9zriP7Q==
X-Received: by 2002:a05:6000:611:b0:47f:25b1:e7b6 with SMTP id ffacd0b85a97d-47f8dc7a211mr5521629f8f.30.1784839386364;
        Thu, 23 Jul 2026 13:43:06 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:05 -0700 (PDT)
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
	linux-pci@vger.kernel.org
Subject: [PATCH v5 06/10] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Thu, 23 Jul 2026 22:42:02 +0200
Message-ID: <20260723204206.76930-7-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134308_695121_CD1F7BDC 
X-CRM114-Status: GOOD (  12.12  )
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


