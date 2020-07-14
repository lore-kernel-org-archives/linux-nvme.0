Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C504C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9F020674
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iGrriRR4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C1uyqyeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9F020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sw2bJf0fuzwlmAthTt4Cqu7/hVzjzXfiRmyrDV7eEu4=; b=iGrriRR4j1/O9aSakJZB7HWb+
	2YI195CarTAA15Ad1ROpXLbja195evFof1WRGwZ0wDBTtDWmmQ2Swlt7g6vldY+bSh3+97nqn0Uej
	vo8ty6C1gk1kLOr/i5lLMQ+zwEyf83SwK+oFE4ObRRNyhpQCyZZi7O7mD87ZrmsM4ZT6kRWSzEhAT
	MTjPtUZrXy43mK7G5rp53/bdGsaHS/5c6IpXfxC0iWJiyohfmWL+HfH6WY4QxHBFNrXBbFtEpCkmQ
	7G/s7hW+bVTRskFepQHiGccVv1TuMbPYgi09Xe+Gl5NEhsaOkp8zNnaj7pRsfQLWU533hpeurFtiC
	Ntu99MnyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvUOV-0005KI-LZ; Tue, 14 Jul 2020 23:31:27 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUOT-0005IW-Cp
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 23:31:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594769486; x=1626305486;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rQPOaf1VTfdffBzz0PrnVL+Q0MhB2KhlG2kCacIRdbw=;
 b=C1uyqyeVb5x7Z1+ojBHBTSFvCM9PlkoEzOgVphYqazYeQqyOeLZspOL7
 k4O91mN4lI0k74MiRODnOZRTIWwAO2uOKk/mJKVy51d+6f2TE2hUBnZih
 WurHiXwfd7nUAI/WkDDvWZGY48TImqX7HCCHxb4Kq0Xu4VkUBxf5KF4Z2
 1opNiUL7WcvpE1UG/lQ8JRu/IV39CIFSAei9hlZOWU7b8YckckS045ds8
 PK1GCWrks6HlTib0ZIcCKmvnRGbjDezBhgqnUZujq1v9G4eGcNgsdxhcV
 c77/TVOv+IH7XwdqsbUP09OoUEqwe+BJcVeQF2FaLA/CGEfT9hctlDK9O w==;
IronPort-SDR: F+dwYdO8Sqv3jozjwQRcpy3LpwT17TvrH1NW/JXPDTBYwpx/upsZ+vD4Dl6isI5NR/nxZ0Yg/4
 MwJZ5QlH+ie+VjRTEHmvx6E1Y/JaUJ5UHsN1mcVi07fAmulSZ4y0wH6lOuIdcVydJZ/9UkILDn
 27md0aZcnp7/f2oUxh/xU8YS8K0O83xEciXIU6tvbk5BE/Oj8wB7tkF1cLxFZunoQHpTk6cgZK
 TgXoWu61G87t1ExpXsIha+ZFBp3PfuBkfhqFy/uNt2AGleB3JCoSzsKGgXISDXsFtuvg/QsfQ4
 Bt0=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="142609494"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 07:31:26 +0800
IronPort-SDR: cjEbfq2uNWCJOmSG2kayQae2qqo5qhSSCKzd9DoG5TJ6Gj4x5xwRB/77vOTtXbtKTCqCyuJEsH
 +v6SH+WL0tiqllWgkX47CokXZv2iryD/E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 16:19:51 -0700
IronPort-SDR: 05b+45gHTRrhm5HPt/o43GBSCTN0ENREiNaP1yfiyRoNDgkWxut8E/162lojJtZqCK0cWCfWIf
 mSlZEcHuVEGA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 16:31:25 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	willy@infradead.org
Subject: [PATCH V3 01/10] xarray: add __xa_load() version
Date: Tue, 14 Jul 2020 16:30:48 -0700
Message-Id: <20200714233057.10915-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_193125_642020_F036B9DF 
X-CRM114-Status: GOOD (  12.00  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds a new xarray API __xa_load() that moves xa_load() core
to its low level function __xa_load(). Caller is responsible for handling
RCU locking. This API is needed for NVMe subsystem so that it can take
an advantage of the RCU locking provided by the XAarray for reference
counting.

This is a preparation patch for replacing linked list with XArray for
NVMe host and core subsystem.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/xarray.h |  1 +
 lib/xarray.c           | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index b4d70e7568b2..ea63005779ab 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -344,6 +344,7 @@ struct xarray {
  */
 #define DEFINE_XARRAY_ALLOC1(name) DEFINE_XARRAY_FLAGS(name, XA_FLAGS_ALLOC1)
 
+void *__xa_load(struct xarray *xa, unsigned long index);
 void *xa_load(struct xarray *, unsigned long index);
 void *xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
 void *xa_erase(struct xarray *, unsigned long index);
diff --git a/lib/xarray.c b/lib/xarray.c
index e9e641d3c0c3..cb9188e74505 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1288,24 +1288,42 @@ void *xas_find_conflict(struct xa_state *xas)
 EXPORT_SYMBOL_GPL(xas_find_conflict);
 
 /**
- * xa_load() - Load an entry from an XArray.
+ * __xa_load() - core load API without rcu read locking.
  * @xa: XArray.
  * @index: index into array.
  *
- * Context: Any context.  Takes and releases the RCU lock.
+ * Context: Any context. Caller is responsible for the RCU lock/unlock.
  * Return: The entry at @index in @xa.
  */
-void *xa_load(struct xarray *xa, unsigned long index)
+void *__xa_load(struct xarray *xa, unsigned long index)
 {
 	XA_STATE(xas, xa, index);
 	void *entry;
 
-	rcu_read_lock();
 	do {
 		entry = xas_load(&xas);
 		if (xa_is_zero(entry))
 			entry = NULL;
 	} while (xas_retry(&xas, entry));
+
+	return entry;
+}
+EXPORT_SYMBOL_GPL(__xa_load);
+
+/**
+ * xa_load() - Load an entry from an XArray.
+ * @xa: XArray.
+ * @index: index into array.
+ *
+ * Context: Any context.  Takes and releases the RCU lock.
+ * Return: The entry at @index in @xa.
+ */
+void *xa_load(struct xarray *xa, unsigned long index)
+{
+	void *entry;
+
+	rcu_read_lock();
+	entry = __xa_load(xa, index);
 	rcu_read_unlock();
 
 	return entry;
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
