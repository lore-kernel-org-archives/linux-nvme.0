Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18D606A329
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XpjHKpcI;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pj1iKOy2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UYKyTKANHmNueSZX+Vts+dz5q7U+GTeUPWVYwIUP5po=; b=XpjHKpcIweVCkN
	FU0AYyvcYg/DwcGlT1uarqFgaUabDI6ze0Ci6X5YATJgdswpFIdyAT0boFBq9OIkQMrW11uDCCSjz
	enq0Ol/aaBgzOVO1oeY2mUAs+4lXfNQVU6lVnRcnTHvkoaNCwTaZ3jBjS4s7zc/VosASsTXf8fb95
	//BIwXQyjPDr1oPy9ZhvjRlojMcuKnjXwbzV7878tOUsTwDxo25aYVVXiyVHx+Raf02WOK1ZaKiAk
	3ntPjXKYYH8Fj8fBOxyUJNZmU+jgZpv80g7GRKUyim8AVmxMuzL0x95XAvmhIYZovHEIFXaZQ3LxO
	AeruTJO19deQggEYu3yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNlJj-0000000FdGf-0zem;
	Mon, 02 Nov 2026 06:14:51 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNlJh-0000000FdFZ-0IXZ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 06:14:50 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-14394530ec6so3185267c88.1
        for <linux-nvme@lists.infradead.org>; Sun, 01 Nov 2026 22:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793600088; x=1794204888; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYKyTKANHmNueSZX+Vts+dz5q7U+GTeUPWVYwIUP5po=;
        b=Pj1iKOy2yaAhTR8oe1nO4kPFkoB0v49gijoCUvdubmuv1EW6cAg5Fdj3tVUjrNzvQq
         nTAHvbnKZDq9o2F9CF5tTuuIDY+tHf/vwDNxC3c4wV7jOXJyDjdmKviPU4OxtIlK3s6T
         VukU2DZSk1fY3WuXof08B6lkfPjTZLmR6WBCSFQAB5wQRhRucVdLeCjfhKdh7LgxAytc
         GRCK4W03tngQDDddyZBbt9fMIOM6OgQFr/ufAW8t3AaLbRJoYBc5SXNsANqpVlNjGm7h
         xkGrnAqxZx8I0JWgAzOUygz/PcHJt2xBZuI9dXQn4Evrv5X+zQ3m7Uheh51eCpudlPfT
         6ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600088; x=1794204888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYKyTKANHmNueSZX+Vts+dz5q7U+GTeUPWVYwIUP5po=;
        b=gyID6QtqqMyWUDtksRJtdvT29ToFxDdQt3OlG+7+GyfgXUoOhTcYEjSEfy8rD5BWx5
         EIalHJsI8KVSF+BAr9p81ZVsY0q3XAnPTF5gVcLAFp5eAP6fPhON8xIea5GKtCUS3oig
         naUaBvvFvyer/yRoiBKd8gwfHesNYYmVgiCJBIZzFqV1TqLkeMx9hNYeyyEaVqEe+cf8
         pGylg475GQK9gZGc8VE2RNiepv1zQnZPAIkI8Jd4RwmCZBMQ0HDgiwcZ2wh979OTQFam
         U0Qk4hK3HaojKkrVcCSqN4XegmM5JSi4lBqdZrRsRLHBEglRkNJrCpIXex6G9+5feCqg
         Fb6A==
X-Gm-Message-State: AFq9FYKgycIgOWREdMxY+IqvfP4KxkzmJ9ZxuuO38dFrzHOgsuwbuNTM
	BUBZ4YFAnOjWppSOyP1OyAaFGdRvVEcc83aituYEgUx2teAIU6kOvHOc
X-Gm-Gg: AYBFou3D21Pba8ePN9Hpq7SqTPC8mxwWeX9YktqgRGfC1y3QAVqgMK6adm+xoUHudvP
	yp9lrTwC8ZucGZb/2KZDjknAZUiBAxoozrb8tqD0emCav6WMtmsankN5xWc3IwL5hxgi3fklXDu
	68Z5xty4Omms+Sc/iYs20ApwBLHbvpXDwR+9nNV2Pbbr4qU33vecyxJPy2jn00v25pev1DNt+2Z
	Tv+8XalCSvP3/wUYIP4JHBnfJbgrn90Qn9KU/lmXoWHb2eKkjTEUqaa42vMF/Y7+tYBygn4PLam
	xqnsnNbt1cx1FL7MnrYkk6KGxBznJ//819ro8i70t8Pixe76JzlTg9h58RY2+AXLTIe68l5aT7G
	8r1FHAY+UzcrARejddCRv9sRKgQJy6efFAmFq0UeNkoaWQlrxiLWvy7XdK7ELdszbrKJISyhRtk
	nPzkqm/bFiRfZGhQ6Ik4QckmJdqlOHq0S2F6bcgfeNJo8JmXCI++UDdskNNgLF1FcW7KY2KNmgd
	psba3LQqvmWcS+HfuY2LWkHnm2R0kTzarELc2ma57UJduKosjdXrwNEvL4FU50fN2uwDGf4g2c/
	MXCGTmxHrbiWkSmqpWjNjIQCNkGBv6KJEknOLuI2xqhVf9w=
X-Received: by 2002:a05:7023:d09:b0:1a4:4194:fc04 with SMTP id a92af1059eb24-1ac5e320bd8mr13624659c88.28.1793600088113;
        Sun, 01 Nov 2026 22:14:48 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm30288043c88.14.2026.11.01.22.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:14:47 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 01:14:37 -0500
Subject: [PATCH 2/2] block: set QUEUE_FLAG_NO_ELV_SWITCH under the read
 lock in del_gendisk()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bug-nvme-remove-ns-async-v1-2-61780fee111c@gmail.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
In-Reply-To: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Stuart Hayes <stuart.w.hayes@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_221449_126341_985F7C87 
X-CRM114-Status: GOOD (  16.79  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

del_gendisk() takes the tag set's update_nr_hwq_lock for write to set
QUEUE_FLAG_NO_ELV_SWITCH, then for read around __del_gendisk(). The
write lock was there to wait for elevator switches from sysfs, which
held the lock for read when the flag was added.

When several disks of one tag set are deleted at once, as nvme does for
the namespaces of a controller, each write lock waits for the other
disks to get through __del_gendisk() under the read lock, and the
deletions run one after another.

Elevator switches from sysfs have taken update_nr_hwq_lock for write
since commit 4ff58d6bc9dd4 ("block: serialize elevator changes for the
same queue using a writer lock"), as updates of nr_hw_queues do. Set the
flag under the read lock instead, which still waits for both and keeps
them out.

Disconnect time of an nvme controller that removes its namespaces in
parallel, from a target on the same host, over tcp to 127.0.0.1 and
over nvme-loop, with 4 I/O queues, median of 3 runs on each of two
boots per kernel:

  namespaces  transport  before              after
           8  tcp          85 /   91 ms        51 /   47 ms
          32  tcp         294 /  293 ms        75 /   70 ms
          64  tcp         533 /  550 ms       115 /  124 ms
          64  loop       1283 / 1200 ms       185 /  204 ms

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 block/genhd.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea7..5afc60bf139e6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -781,16 +781,6 @@ static void __del_gendisk(struct gendisk *disk)
 		blk_unfreeze_release_lock(q);
 }
 
-static void disable_elv_switch(struct request_queue *q)
-{
-	struct blk_mq_tag_set *set = q->tag_set;
-	WARN_ON_ONCE(!queue_is_mq(q));
-
-	down_write(&set->update_nr_hwq_lock);
-	blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, q);
-	up_write(&set->update_nr_hwq_lock);
-}
-
 /**
  * del_gendisk - remove the gendisk
  * @disk: the struct gendisk to remove
@@ -820,10 +810,13 @@ void del_gendisk(struct gendisk *disk)
 	} else {
 		set = disk->queue->tag_set;
 
-		disable_elv_switch(disk->queue);
-
 		memflags = memalloc_noio_save();
 		down_read(&set->update_nr_hwq_lock);
+		/*
+		 * Set the flag under the read lock, as elevator switches take
+		 * update_nr_hwq_lock for write.
+		 */
+		blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, disk->queue);
 		__del_gendisk(disk);
 		up_read(&set->update_nr_hwq_lock);
 		memalloc_noio_restore(memflags);

-- 
2.43.0


