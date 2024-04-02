Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17B4CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hV4KuEKNW7ZcJ4NByBKEhY3Zp3n2MSZhBevhoHroCCs=; b=3tFGQEBxa+5dbaA7sxcI/GO7fl
	+VQp/byHN5OMLcVeQ4QUBQ9wYzP8FzvXXvQo9963w6WTZ6Szm2CpvJqLaRFfF20/HhmqiRJlNX3yP
	KvoWUmvFBy6sMnXfh957m3d2mlcTJaDN7kabeBVvqvZJxt37rMb2CLtrMHEbCsdpGiMXpIx6Tvy5t
	bBEMSq0En3nbd9RZh2YVyHkQumvFkTDpVOhXmH/Nq2FltpdxW1TM1E1iAZssaG5VGL3UHGGuleEy0
	MpZ6EHe4JxgTB+zJPtivQbAyXC/d0sx8ItCmGgEwN/N+WJFLQ46eV7iw+bNe03p60cj9scBhvebvS
	2e0uzFPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rreVM-0000000BQVm-3o0J;
	Tue, 02 Apr 2024 13:48:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQW-0000000B6YT-2iPo
	for linux-nvme@bombadil.infradead.org;
	Tue, 02 Apr 2024 12:39:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=hV4KuEKNW7ZcJ4NByBKEhY3Zp3n2MSZhBevhoHroCCs=; b=dJ9+WwdCdVrlrXigc3S+ARoC6P
	JPO3a0iKSeTG/v+uYGECaxyZkNv6m38z0ENbLCSgStXJPUKEwqg0LOQ++24jS5GANlo9v4t0GeeL0
	OFY7coyZMoMz/Ce87QW4XqyHstY9ZgAdEUT//spbnYZg676bqvW0vQITOhcCiWTbjUQ3xeuxNSYBw
	d50ibpmBXRCUgnTBadR+GcvzpdkmaJQ6PyXDo9w+5ULsqH0dRY2GS0AE0Ev8NvGu+rZbzS5hkbrky
	6NJxvQdFE6uJzki4Kp9qpT0QGf+5W2XgDxGTmYpmMbFMZSmSyhLomk2VgmNCf515BJY2HD3jx7XRY
	MpNt7Row==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQM-00000003cIK-0Nqi
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C897561003;
	Tue,  2 Apr 2024 12:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FB4C433A6;
	Tue,  2 Apr 2024 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061571;
	bh=AlRpJddvRHquUbj18752X4Iel9EVoPRdVoTyldN+Rzo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p26gum3sBeFCuVwFVjD85N/wm2xo7Mdm6rpYY2kyiHK66ybM1M75OfL54LCZOi1rg
	 QBkp0cUna0iUDgj3eMNkKrYnXb12dMpvbNjI5hV3fvjS+e7vZs04kEBE/qtRsFYdMg
	 8WY07VgPq01sY8VpdJdQHrbcj2TLHnCtTD+72ZFadCCOTyxvaod+ZgZ2O6RUPxBBlh
	 zBTSFRlGKvha5OxfN5nK08ouhtguh0ty3kS9h+D/wNrxsGC9SUNOzdRaScbQJRKrF5
	 Nu/oKwhKnNfjSULZTTwU27W+KGCn3oDNt8uSmVafQ0hq9bZwGLKl+wSMJaUFrG6Bhp
	 9GrHUBCxr6ysg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 15/28] null_blk: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Tue,  2 Apr 2024 21:38:54 +0900
Message-ID: <20240402123907.512027-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_133937_107430_E0BC1BAB 
X-CRM114-Status: GOOD (  11.47  )
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

With zone write plugging enabled at the block layer level, a zoned
device can only ever see at most a single write operation per zone.
There is thus no need to request a block scheduler with strick per-zone
sequential write ordering control through the ELEVATOR_F_ZBD_SEQ_WRITE
feature. Removing this allows using a zoned null_blk device with any
scheduler, including "none".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/zoned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 1689e2584104..8e217f8fadcd 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -165,7 +165,6 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
-	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
 	return blk_revalidate_disk_zones(nullb->disk, NULL);
 }
-- 
2.44.0


