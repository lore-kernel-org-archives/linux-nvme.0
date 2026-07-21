Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586C3C4452B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dWf575YMSf1W7NtVvbE0zlmvwqtjFzi0s/WGa1kQOeI=; b=T0CbP5SrfOtWVVw+FSLTPsk7Mz
	sVWwuY3Jsy/vfsPGtJj5g6EUldn7hTLDV00DT2qhvPRAP5vFZnRBtzwR0Ts9eovXZCeFShtkbV629
	zdM4qWynfV5WGO5+4ZCpzTfgkxGbtPMTl1++KOVBTnoZ5uoRkbZC535z6EOf2i7zVVLwAAg91qyZT
	mUGbFqsx/ChxYNvcf3wD7sdc8bbuviDH0etioysHC0SOv2TY3b6Id9iDS27ytMQs/j7JeIh5S2NgX
	zfILsdrMT5gxoTwXvpo2kBaZaVXDy8nCMnqd6DR2yE2tynef7DmH60wT2fYaPLAOvDzAud+cxGFrW
	mbpBavJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXl-0000000A5SW-3d9P;
	Tue, 21 Jul 2026 17:46:13 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXh-0000000A5Oi-3PcQ
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:46:12 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-4720f3bf164so2941509f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655968; x=1785260768; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWf575YMSf1W7NtVvbE0zlmvwqtjFzi0s/WGa1kQOeI=;
        b=rSddvKvQ1X/leRyj3B0Apt9vgixCRaFQc2Sv69yBXXYLrSA9SldyizSFR07+IVxPft
         aEUlLre2DdsSJYIv33wqeeLgbrCzq8FVlitiLJXFpX6Gmty/JN9iGj5rZoNxn5nTKJWW
         pG9xjoVByRhxccD5NBKhRba+iQcLqnkU1MohOCLHg0MElaVF7hJablujWwxq50t5WeBv
         LLbZ8x0x908uffLyREbTZr6m1hAjsUS1JYhU1nwri5ex3X/77DW0u/ef2mZo9ySlahbk
         ijUEsS0CxnWjbQ8v19JC22dixmLS45qs7a49rHDzAO6D1X6HaaQojadkyV6F4BciNVa/
         FPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655968; x=1785260768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWf575YMSf1W7NtVvbE0zlmvwqtjFzi0s/WGa1kQOeI=;
        b=eEJbh9JTgNZSkZMi6Dxhx4945u8ebHE/LpBs3VLBWIkLwkD3ribTtSbguJ1x5Uc2hD
         pBNglmxTY/D8Nc5JjIPrbIAd4LQ8sglotPwfewfZTfy+WMo74qKQ42qMUXsBw0agHFGv
         dDgCR8doR8eoSDs1VQ8vHy592nW9GxsjFskxO1v8u7G3nJ7k2YZrEXHMhw8t1hY0UMfI
         1mTq2XOWny2pIsGftB0bEBpBjjSxX8p8lRU62jUWNC+7MLL/gX7jBrKzPT/UrEyBExEa
         6vozNRfd8MouzL4qOnz+rRFS3AikRieGTKqLjPzYQR/PPu2qcqh6v6cfMwuWyyfLIdxP
         VzQA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8jPTkvsFpXsE9u01FHG72Z+LbeFwagHuEvn/Crf6vsiUhNe0iROFIR/LBuzSx6lnh1ynfZ9fMleRf@lists.infradead.org
X-Gm-Message-State: AOJu0YzX+s4f2oIA/MCqGfxcrEHUYhTi/Duh/p4fBx4ATrz2B8tB5BVS
	qhGVsOl0JWXzd0twHREQU1l0jE46Eh+Kn7Nlk7XD+Zztbeikv/uG/Yic8uBzJbG6Yg==
X-Gm-Gg: AR+sD12HuygO4Ou0CFYJXaIC8Z3S9V+0XgcIb3W0dD7GWLYrypQlMa7APVMvMSdOyWL
	MpdbT0cf5Y5pGt9QntAwUJniQIDBr97VQSSAIX5Ibd3yk/5rD9WLi5vwhhZXaIbuzdYDR7NM2iW
	kSNl+1yET7U3rrfiqasMSfcJD0tHYKqqGx8O8GFSfTWInJyrvBzwCzXwjynZe+iMpiy/ozVDOVS
	64nvc36h7yAjeNkI7xmYy/U/KVxZPilsX3sYqVFd6Oj4RE5pGtqhzj+ibI7dgiSMrPRXYl2Shgp
	UG9U0FS4Bpcr3zmOEZmrArjjSx55qkDN9EYZxb+JP8omx93mkiCz8Lgl21DjqXrfh5fQ8gspoiu
	nf5hIGJNpC4DnZExa5wGcJ1SRF1yyNA7SLa8qq9cxWVPVP11pcNCvqzEW8H5+ZQCCMCpy9MKeW7
	WlKqMUpomjLBVX1XDKqSJ6UYCfkWV/1t265UjlKqpIlUfogJs=
X-Received: by 2002:a05:6000:2903:b0:47f:7864:1b7b with SMTP id ffacd0b85a97d-47f840c596amr727053f8f.24.1784655967970;
        Tue, 21 Jul 2026 10:46:07 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:07 -0700 (PDT)
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
Subject: [PATCH v3 4/8] md/raid1: don't use write-behind for P2PDMA bios
Date: Tue, 21 Jul 2026 19:44:58 +0200
Message-ID: <20260721174502.111503-5-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104611_083888_C28BDC7F 
X-CRM114-Status: GOOD (  14.33  )
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

alloc_behind_master_bio() copies the bio's data with bio_copy_data(),
a CPU copy. P2PDMA pages are peer device (BAR) memory; generic code
must not assume CPU load/store access to them is safe or fast on
every architecture, and bouncing peer memory through the CPU defeats
the point of a peer-to-peer transfer.

Skip write-behind for P2PDMA bios: they are written directly to all
members, including write-mostly ones.  Ordering against write-behind
I/O in flight to overlapping sectors is preserved: the non-behind
clone path serializes on CollisionCheck rdevs (see the preceding
fix), which covers these bios like any other write that bypasses
write-behind.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 997f79c05db7..7d769b6460ca 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1523,6 +1523,7 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 	bool write_behind = false;
 	bool nowait = bio->bi_opf & REQ_NOWAIT;
 	bool is_discard = op_is_discard(bio->bi_opf);
+	bool is_p2pdma = md_bio_is_p2pdma(bio);
 	sector_t sector = bio->bi_iter.bi_sector;
 
 	if (mddev_is_clustered(mddev) &&
@@ -1575,9 +1576,12 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 		/*
 		 * The write-behind io is only attempted on drives marked as
 		 * write-mostly, which means we could allocate write behind
-		 * bio later.
+		 * bio later. P2PDMA bios are excluded: write-behind copies
+		 * the data with bio_copy_data(), a CPU copy that cannot be
+		 * assumed safe or fast on P2PDMA (device BAR) pages.
 		 */
-		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags))
+		if (!is_discard && !is_p2pdma && rdev &&
+		    test_bit(WriteMostly, &rdev->flags))
 			write_behind = true;
 
 		r1_bio->bios[i] = NULL;
-- 
2.52.0


