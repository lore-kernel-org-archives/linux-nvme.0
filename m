Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92E2C53200
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=; b=3oNMF4SVaQ/EZSEK7SKcLMNcmU
	vPZ9gHY5WitMzRmoL3mrh8bvNS3U7APDgZzEl9SM7RKBpbo4rSngueXm54weuSoVA3e1jo6yM/lOC
	NBpt7fTeo/07sQlB8mDULUY7fwUByTg/HppONyTL6Qb6hQ+ZGH6QAJ+BnOdpZOc6bUyF+Rrx0Kmdn
	8AkQLOthDQ9hlJRQHFyTBd/doxzKuw4th2yT0MCqV6bmKP729Cbmx56OetN5nzUBl9bg0NHL7M8qv
	ks+QyUvpEzaZ5cgqaF2q+qKSu2zkPiomyuSy0o+siDTe8v4z4Ww5dpbhMQ2UQmUMCpicfhXCI8Syq
	ryISYgbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx68-0000000170B-230R;
	Sun, 26 Jul 2026 11:32:48 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx65-000000016xq-31D4
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:47 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso921405f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065564; x=1785670364; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=Z2inwmxXFfZkEaZd4KhxfuOedITVVJNSGgE1bssVUaEgT6bfmYHMeYtq8YcYlNNWxM
         SuxT7WL4XMomMD0MPILwWGMjp24jW0UomIioYE2RgmTcyN/BY4o64dYNvcTo8myugs9j
         22iFiFPQJQTrNji7cnzKQIdLbjGomHyalmoVMWOxuxKsVfNNMN3GFfcw/BpM0MwMnFvL
         ZuRZ5o0wlMguCYVlcMZPrjL5EabZCUQWt7RmJQ9MbNdGF+cEI4xN4nqBnEZdX4W5opgS
         jzPL+/spIyaWAYffnRVOMKjrc8ppI3otYgCXn+NYfybo/n43rkxLAvu/gt8APTErBala
         66gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065564; x=1785670364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=WHkdvK90BW/hIHBh8AKyzsAcCFsN4gBwM0f8jP2hOHtMlpeJxdat0mULguDSoU7W1y
         T/JyZPcd0Rlno+lQ6EOcUKPpVKXvX4RX/00o669fUzDS5LU4rOVCqTGDNyu2Aqx2aGUg
         v30pPPJ73byWr/SCu90hcV1moWcqUUp8l2wE0iNWKeXqFBMYAGCy2EOllwUaE7+COaz2
         Ht5AjarDKup09RZ8cY+3KvS7/tStWFhLVqztk+eRzHRZWcOt6ITGe/yGLO1YweKH7VPj
         1AWemTxkp6cXkVr9YdEMEm2BWESc6Vh1tyfSzmKhRDHd6LjulNq5mcju4te/W6s8luzE
         i64w==
X-Forwarded-Encrypted: i=1; AHgh+RoM5/BIlPx1O7FuHeue8mAbsElFwroWrsGhar5KE+atIfQEo/m4sjk+3Og/eqmUaoBKwmhw7pHjVmDT@lists.infradead.org
X-Gm-Message-State: AOJu0YzN6wDC9oeKvhFwTqw2KVy7VA4XdA3x81/n4aW4rKjJbvL3BKKo
	9NQ6BwK7V0thOIjCfYq5IKbeYtB2QJn671KYD/M0iRavyqLsy6AkVvHMa0NzO+kDBA==
X-Gm-Gg: AR+sD10H/swzQIHuDps2HZcEhTuXbyQZrQ4u/eXlz2lS0VIQwYd/9OOA5DXt1bBRU4h
	x6C1YC5WP3oK6oT9ZY594G/QbXJZZOmk4S6bzPL6zsjYVDKTLd3D0MNuuRF8TW5iGqgHQeaHBJs
	fDJJiJpVilJv4tyakoQ7cjJn2md3j+enJQlcOM02OyqNcjmHePwHeONzPmW0xfi28XWP47xxNBG
	tHZfgtLScYKUbPy8IKm29Irg5geXs0h6wb75/OL6w22WGjcIV0DpjbYRwCKUe+WcevJ8LHyNuS4
	VZCenufJ77u3AYgePu9vwn6NAyuNVbq00w48RhJaaGphK0FqliYddAZUcxxlkhVaFzyZVovzFfQ
	bYPWs9Hh8bQeumfnAcEdlr9Avx9JU7i2TYahQUJ7TvM+7882sW8SgGKhkc43lKrmylSDZCLwosy
	8uh6zd2HOYy7lFzpJEPX1rItkG27rLljJtDuBYpFGOm+BOdYmTIDrUU48wwRpkYWP4NpQfd5KdW
	1ERjzBhzAcX/HTsa4TUxq12hw0lQj4fPGvgy6OqTQ==
X-Received: by 2002:a05:6000:40cf:b0:47f:77dc:b072 with SMTP id ffacd0b85a97d-47f9fc8fc9fmr7735691f8f.18.1785065563917;
        Sun, 26 Jul 2026 04:32:43 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:43 -0700 (PDT)
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
Subject: [PATCH v6 04/12] md/raid1: don't use write-behind for P2PDMA bios
Date: Sun, 26 Jul 2026 13:32:21 +0200
Message-ID: <20260726113229.2154269-5-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043246_222629_D6D7329E 
X-CRM114-Status: GOOD (  13.86  )
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


