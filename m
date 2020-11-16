Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC983C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:10:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC1522240
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qXfmynzN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C+aFntyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC1522240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+6XxmBPFKyNAY2aORnMi1oMTiNggDZb2gnbet73rOow=; b=qXfmynzNEDgesiPsWk0g13Tfz
	7mt8MoDJxoc1asctR3xnRWMusC6fF8MV0t1EL7CyNuHmtz/pzoP9ZzITVVR6XQ06XPXBBwHq8/R1q
	c0KyC44Rxe1M7sYPJgr1Cci9nM8jjMz9p7WNgnKLIZUWCjlM2j/PzMFO76b0YpLYhiqf2mQMnHY85
	JVeec/FgGYgzYeYTBHJBEvKiNOcmQNjwEJMi/AZapqbdos35YYNjR21VoN0bEItghdcN064AoVxIz
	LM+IRYuMkfwII1ZhPf9xLUb9kVbiQCf9uT5nZrq3L3WN1Q4VQevcBYv4OCmVuDpR4CKmrc7I+PHCC
	8LtnbU4Ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg9G-00021W-E6; Mon, 16 Nov 2020 15:10:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyb-0003uB-15
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=TGRxj3P5fN3QWbEKVTDt35+3igPcA4rCa+2EvBLtC8g=; b=C+aFntyXdJbXcDXW0zdEm0MZf/
 Q8Zx0N1Bi1RkYFpnimVowbz0rcddgCEhzUASaPfj19d8nD2OoiQ7zBRz9XuVFxvMc+YbxWMyHzaTx
 PYzv9LtI9kFkIcqvnRgzJ1QSX/8XbEjuPMJK4EkCHxJJNOZAq17DsBe6jQ87rPiGWnpudzQyM/EHf
 XW5TF2D/8wJwMwlrqTogsg01StwU1f5L48SB2l4E2dG+cGpvb0qjX+vW1trzMnD3BduvbANSwGVcX
 fXDT/3TaiGf3bIXETdbDeP/h5OUIqBlJlOYSObKbRBS9M21yv36cQQIio98w72OzH3KuXMzUGVMV3
 ibdbwukw==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyY-00044s-Tr; Mon, 16 Nov 2020 14:59:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 54/78] block: remove a duplicate __disk_get_part prototype
Date: Mon, 16 Nov 2020 15:57:45 +0100
Message-Id: <20201116145809.410558-55-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/genhd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 46553d6d602563..22f5b9fd96f8bf 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -250,7 +250,6 @@ static inline dev_t part_devt(struct hd_struct *part)
 	return part_to_dev(part)->devt;
 }
 
-extern struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
 extern struct hd_struct *disk_get_part(struct gendisk *disk, int partno);
 
 static inline void disk_put_part(struct hd_struct *part)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
