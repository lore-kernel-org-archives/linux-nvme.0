Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330F9C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:10:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C36C23A32
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fCEokFRE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YOFzGbUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C36C23A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LYWqET3obSSjDiPrqrAJcE1CtjjjjiO9i8jXSDMKK40=; b=fCEokFREA9wG32hB0+7zCYqGF
	zQQLhmBct0qYcaAzO5HvZ0WBV1RCvllJ5hYy6RVS8vge4gYW1SXgHJ354JIW48CLQDLByEo5tD1I/
	gh7F04KzT/NM07A3ZSprd0Sq5/b3R9e/Wn9YH3Ka+vuzIAUuQMrkyvPFMjwlNRpmOyuy9V3NfTAiq
	hheZkd+jtbxLt607rDHU+S2AGSd2S+JZNfjYNkMM4mHMCGxYTiD9A8jqWv0CO1baJbJmtLSxlkRb8
	3rUMHSSqUqR4KjbVDnGssrUdk5GQCVyGcWwGcfXxWwVRayB8O2DLS3CcfuWigTrUfQrJ4KyWgtmQE
	Q4sS4J94g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg96-0001x0-R7; Mon, 16 Nov 2020 15:10:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefya-0003tY-C5
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=JcB9e14ZTBoVWi3xdlC8mpSR3JW9dN3IR752p30j0qE=; b=YOFzGbUV9VEtyNxwp7qzlkBkkA
 Xn0oawKxqvp0rAIqeYWfpnGW5iMkDHaT9Q19LnRvvfRleFF+dEeV1rIXFrxzZ6V3OKsv1gqggDose
 CZ8HXwPH00Ft2bAKbkVkNVOZSwCoCf+BbjKAUSbeaDWhW2TFIaXsT/mf0vQ14ewbGqO18nmazvj5g
 b1Wy0xuDKhqpZX+ptswIwNRpIl/sRXy2DRT6yF/1ufD4XI4Nw45co8Yphscy9XmWqZZmCKt0hG1sl
 9Nlddjx5eT+Hbi58Z8JKvsvZh3X28RVFCimEe1Pj+dy6gOSZ5ekmYcmi5bYlS8agcooKnl5AoCpPZ
 e88oTXSg==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyX-00044O-9l; Mon, 16 Nov 2020 14:59:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 53/78] blk-cgroup: fix a hd_struct leak in
 blkcg_fill_root_iostats
Date: Mon, 16 Nov 2020 15:57:44 +0100
Message-Id: <20201116145809.410558-54-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

disk_get_part needs to be paired with a disk_put_part.

Fixes: ef45fe470e1 ("blk-cgroup: show global disk stats in root cgroup io.stat")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c68bdf58c9a6e1..54fbe1e80cc41a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -849,6 +849,7 @@ static void blkcg_fill_root_iostats(void)
 			blkg_iostat_set(&blkg->iostat.cur, &tmp);
 			u64_stats_update_end(&blkg->iostat.sync);
 		}
+		disk_put_part(part);
 	}
 }
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
