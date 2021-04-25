Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1454BC433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:58:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BC3613AB
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 08:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BC3613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7XYaTidubobrUp3jJxWeWw2cHZH6Z7qM9N91EbOqIy4=; b=SazBm4dT0TivCKU+hOvEUO7nX
	BsoThp4sqbhKavG5KuN7URwgiQyj0QTGK04gzDk4bVf5BscUSUcUBiSNRs/MfTP0gYusWiJxQQWbr
	TuzMuic/P+1DHn/ZIQrEdI+yAaKtUWOR4cv6v/hBEjUxlfw4lxpVsXGmp9NenMkKG6IEDVl7OdP4h
	FN6l62sEmDEaomsJM5tkSSpIhAdVkOoayfXMHGtbjEze2HKtXgOJcUUPXN3ddn+SPu4QDvq5vqo6i
	ll/MxxW771gXsJjwMD+bylwIv8wpDPkVLDF8M2n870DUqJlFUpa+zPtiYqOKrIW2kYRqS4gvDrqcx
	ag0AZWPEg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laab9-005Jrs-98; Sun, 25 Apr 2021 08:58:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laaat-005JqF-7z
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 08:58:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=1ncarbKPgNU0ZeJA+q4PSEQDtpWvG/p0TouzrHLB+yU=; b=Ap5P4yXQZWmRvuJVNZqLFDbPlg
 JLNRgtmJPsmnXOBOIkfAc++kunywcnd2azu4aJgSJto921gVI8F6riqqSdTgKVjx421yFk5oeizPr
 AEFUSr8k2P7ojvjhOJQb8kVmejiTTGPywnER1x44+Yc09RGQuxV4YvMPYRusqni+lMLSTl8yRwNTE
 xIHQUbXXFlaRBc7xFWjyyvav1+OiCGanPDxIbZqKNGj6oT+/th30PytW0F0j5XYyVas94JICt/yZ+
 UA2fE8p1UHL5jL5knppqxi6v/kkqD7PE2H07KycZvurL0Udam5YLshuCRC+I9DIGkXR3qopFcaJab
 cGHtZEKw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laaaq-00FMXj-SX
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 08:58:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619341099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ncarbKPgNU0ZeJA+q4PSEQDtpWvG/p0TouzrHLB+yU=;
 b=AdrXpzQPjx/lR0imBmBIQF4ku4lZgsc7vct4paZG1kMh63ixZR2vtteYTERMNLANwOmy+5
 DCR7b5pfEuHna8IS5ijdECPAToEEl++EmqlaJ+EJKZLTqguN0BrKc2Q5XwzA0VRNQ7y8W/
 +32bjayDj9dkOAtC3bTgMh5qElORzko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-9R7uqRVmPr-f_nmiv8kLAQ-1; Sun, 25 Apr 2021 04:58:15 -0400
X-MC-Unique: 9R7uqRVmPr-f_nmiv8kLAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E755E1006701;
 Sun, 25 Apr 2021 08:58:13 +0000 (UTC)
Received: from localhost (ovpn-13-143.pek2.redhat.com [10.72.13.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4420C2BFF1;
 Sun, 25 Apr 2021 08:58:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/8] Revert "blk-mq: Make it safe to use RCU to iterate over
 blk_mq_tag_set.tag_list"
Date: Sun, 25 Apr 2021 16:57:47 +0800
Message-Id: <20210425085753.2617424-3-ming.lei@redhat.com>
In-Reply-To: <20210425085753.2617424-1-ming.lei@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_015821_013363_D0CBBF1C 
X-CRM114-Status: GOOD (  14.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This reverts commit a8a6ac7ad3fb6b84b933ca1ea5110998bdaeee17.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7d2ea6357c7d..8b59f6b4ec8e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2947,7 +2947,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	mutex_lock(&set->tag_list_lock);
-	list_del_rcu(&q->tag_set_list);
+	list_del(&q->tag_set_list);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
@@ -2955,11 +2955,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		blk_mq_update_tag_set_shared(set, false);
 	}
 	mutex_unlock(&set->tag_list_lock);
-	/*
-	 * Calling synchronize_rcu() and INIT_LIST_HEAD(&q->tag_set_list) is
-	 * not necessary since blk_mq_del_queue_tag_set() is only called from
-	 * blk_cleanup_queue().
-	 */
+	INIT_LIST_HEAD(&q->tag_set_list);
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
