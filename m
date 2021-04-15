Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021BC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 10:34:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8685A61152
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 10:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8685A61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1vpZs4JyLf2aADJ0gmTVdT7NdtnoZCSDlfORBacQQns=; b=LmpC24M/Efpe/FKgogJvrxmA1
	koX+ARP3I1gyo6/4gQwp8GF7+8ZgnkaRc/IVt0959s2izBZSduMXOVNbREgeWwlGC7BoY209mdplX
	txA/xJ/PLHJGSemXcbc/XvbcwqN6Ra5aBh6SvuKKLwkuej7t8NCB0uUQC2wr1Jp87ijwlq4eBQWGq
	5UmOma6XmVXvd43foKy4Fu41D9bH0pwkUUoYt1z/M4BcCp7mFGHXVc1tDeSYOlsC1AzZ994vnQPtW
	F4aTKd4KKQVcxHrGF2CgqTM8bWBbBmoQTazwLhfqCv57X6LxSjsktHSN3vNqtp/5leKwQfxeCrcaq
	5ng+Qa9vg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWzKL-00FkCK-0J; Thu, 15 Apr 2021 10:34:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWzKA-00FkAk-Bp
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 10:34:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=oi3Sd0OUrlMjtsLbv2z+fg1JsicP7YegqK4bHsIStuc=; b=B46zu6+NCe1gOl2jGG9eKnpeyx
 0kKLbQzqjpoeR3ZrDx8z6bw1CpkzlVA/6NyIV2gD8HRDnpyKnVOp979lN0NKF4aYWtKabLtKRjIsf
 m0I6DbYnZIgEYvz+9lxF4I9yIhBmtSgHt6Yvy7vmGclypii6d0NWJQxBE5K7U3Ao6F01lJrffXyoy
 m3Wsyoi0vfAdt0mFnl1tuctpaEtf5h8hAW2ZzX+M/pzYeOu8usIPFW4Vpn8ELEbhLKluF9QqUwRQ/
 R0ZM1g63+Xwq6HyGQYLCemoiJ30fKZy3aaYi5Ph92mUBdtIc2aeOy/EwVdcFIP8+03MPyvW+4kjJL
 qobtE60w==;
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWzK7-008Tye-Q6
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 10:34:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618482850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oi3Sd0OUrlMjtsLbv2z+fg1JsicP7YegqK4bHsIStuc=;
 b=f6/aQFQ+YAHroFkt0Oqy6M9XQVCczxqD47ElV2q8c2pam4A0FUIszH43VJf8nEwcqONTMd
 QKzghNzYC8jaqP9BGgLxH708ZIrs7D4traC2smrooxQ0Z/qhp+Bt72cTlBogLjJFBj97I/
 /gpeYQqxBLYwgK3YM6/vZE46ncQEL3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-5aR0btvYN7qUSfkf0icajg-1; Thu, 15 Apr 2021 06:34:08 -0400
X-MC-Unique: 5aR0btvYN7qUSfkf0icajg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BE4A6D582;
 Thu, 15 Apr 2021 10:34:07 +0000 (UTC)
Received: from localhost (ovpn-13-200.pek2.redhat.com [10.72.13.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3101262462;
 Thu, 15 Apr 2021 10:33:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>
Subject: [RFC PATCH 1/2] percpu_ref: add percpu_ref_tryget_many_live
Date: Thu, 15 Apr 2021 18:33:09 +0800
Message-Id: <20210415103310.1513841-2-ming.lei@redhat.com>
In-Reply-To: <20210415103310.1513841-1-ming.lei@redhat.com>
References: <20210415103310.1513841-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_033411_943242_8E700A2B 
X-CRM114-Status: GOOD (  17.29  )
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

Prepare for support freezing bio based request queues.

Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/percpu-refcount.h | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 16c35a728b4c..9061c7e3113d 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -267,8 +267,9 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
 }
 
 /**
- * percpu_ref_tryget_live - try to increment a live percpu refcount
+ * percpu_ref_tryget_many_live - try to increment a live percpu refcount
  * @ref: percpu_ref to try-get
+ * @nr: number of references to get
  *
  * Increment a percpu refcount unless it has already been killed.  Returns
  * %true on success; %false on failure.
@@ -281,7 +282,8 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
  *
  * This function is safe to call as long as @ref is between init and exit.
  */
-static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
+static inline bool percpu_ref_tryget_many_live(struct percpu_ref *ref,
+					       unsigned long nr)
 {
 	unsigned long __percpu *percpu_count;
 	bool ret = false;
@@ -289,10 +291,10 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 	rcu_read_lock();
 
 	if (__ref_is_percpu(ref, &percpu_count)) {
-		this_cpu_inc(*percpu_count);
+		this_cpu_add(*percpu_count, nr);
 		ret = true;
 	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
-		ret = atomic_long_inc_not_zero(&ref->data->count);
+		ret = atomic_long_add_unless(&ref->data->count, nr, 0);
 	}
 
 	rcu_read_unlock();
@@ -300,6 +302,26 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 	return ret;
 }
 
+/**
+ * percpu_ref_tryget_live - try to increment a live percpu refcount
+ * @ref: percpu_ref to try-get
+ *
+ * Increment a percpu refcount unless it has already been killed.  Returns
+ * %true on success; %false on failure.
+ *
+ * Completion of percpu_ref_kill() in itself doesn't guarantee that this
+ * function will fail.  For such guarantee, percpu_ref_kill_and_confirm()
+ * should be used.  After the confirm_kill callback is invoked, it's
+ * guaranteed that no new reference will be given out by
+ * percpu_ref_tryget_live().
+ *
+ * This function is safe to call as long as @ref is between init and exit.
+ */
+static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
+{
+	return percpu_ref_tryget_many_live(ref, 1);
+}
+
 /**
  * percpu_ref_put_many - decrement a percpu refcount
  * @ref: percpu_ref to put
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
