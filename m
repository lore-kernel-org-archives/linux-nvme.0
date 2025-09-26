Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B0ECAC5AE
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 08:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CFCODxIzulv4q5YSURKomxw32kWcxgZHrAdUJR+mPs=; b=GynsGMK51i6bt2aIEja8IP/84m
	QN2MjdaQRD31CWIynII0ArEK2ATt2tHwu2s6l6WBuBGnz2SiGi+ZhokLKXqfaty5ihVcnQxM+rVqE
	6lcRHxZq3B592WWw0x6GkZl4wdP6k3W1ySrJLKy4I722aiUe3LBBN1Jqo2p19l1vAh5qyaqvSWez3
	/c3ZUR3kEQ1G9GuFivj8ZLxjYjESX3COUswmfaxKXIDwksquyPKjIlD4bEXeXqEVYEIg1H/epxzVY
	wxILAc7dGej5/FuvfKRjPRCCl5WRwl2G5mGzfLrXzFx/c34Whq/LCwWT9d5MrYhP19CahpIsO9uKc
	eU2b/chQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2433-0000000HG1p-08oL;
	Fri, 26 Sep 2025 08:43:25 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v242z-0000000HFyA-3Sjj
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 08:43:24 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 63709fa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Sep 2025 10:43:17 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 10:43:16 +0200
Message-Id: <DD2LKQ2V9VGA.1IBIWFZRKRZPU@bsdbackstore.eu>
Cc: <kbusch@kernel.org>, <sagi@grimberg.me>, <hare@suse.de>,
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH RFC 1/1] nvme-core: register namespaces in order during
 async scan
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Christoph Hellwig" <hch@lst.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc
References: <20250804114355.30212-1-mlombard@redhat.com>
 <20250804114355.30212-2-mlombard@redhat.com>
 <20250922173033.GA13802@lst.de>
In-Reply-To: <20250922173033.GA13802@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250926_014322_204075_7D6C6959 
X-CRM114-Status: GOOD (  26.21  )
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

On Mon Sep 22, 2025 at 7:30 PM CEST, Christoph Hellwig wrote:
> This idea looks fine to me, but I hate duplicating the logic
> from SCSI here.  Any chance you could try to factor the logic
> into a common helper?

Ok, let's try. What do you think about something like this?
I am not good with function names so I am open to suggestions:



lib: Introduce completion chain helper

Introduce a new helper library, the completion chain, designed
to serialize asynchronous operations that must execute
in a strict First-In, First-Out (FIFO) order.

Certain workflows, particularly in block or
storage drivers, require asynchronous operations to complete in the
same sequence they were submitted.
This helper provides a generic mechanism to enforce this ordering.

struct compl_chain: The main structure representing the queue of operations=
.

struct compl_chain_entry: An entry embedded in a per-operation structure.

The typical usage pattern is:

    * An operation is enqueued by calling compl_chain_add().

    * The worker thread for the operation calls
      compl_chain_wait(), which blocks until the previously
      enqueued operation has finished.

    * After the work is done, the thread calls compl_chain_complete().
      This signals the next operation in the chain that it can now
      proceed and removes the current entry from the list.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 include/linux/compl_chain.h | 34 ++++++++++++++++++
 lib/Makefile                |  2 +-
 lib/compl_chain.c           | 72 +++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/compl_chain.h
 create mode 100644 lib/compl_chain.c

diff --git a/include/linux/compl_chain.h b/include/linux/compl_chain.h
new file mode 100644
index 000000000000..663c105b6605
--- /dev/null
+++ b/include/linux/compl_chain.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_COMPLETION_CHAIN_H
+#define _LINUX_COMPLETION_CHAIN_H
+
+#include <linux/list.h>
+#include <linux/completion.h>
+#include <linux/spinlock.h>
+
+struct compl_chain {
+	spinlock_t lock;
+	struct list_head list;
+};
+
+#define COMPL_CHAIN_INIT(name) \
+    { .lock =3D __SPIN_LOCK_UNLOCKED((name).lock), \
+      .list =3D LIST_HEAD_INIT((name).list) }
+
+#define DEFINE_COMPL_CHAIN(name) \
+    struct compl_chain name =3D COMPL_CHAIN_INIT(name)
+
+struct compl_chain_entry {
+	struct compl_chain *chain;
+	struct list_head list;
+	struct completion prev_finished;
+};
+
+void compl_chain_init(struct compl_chain *chain);
+void compl_chain_add(struct compl_chain *chain,
+			struct compl_chain_entry *entry);
+void compl_chain_wait(struct compl_chain_entry *entry);
+void compl_chain_complete(struct compl_chain_entry *entry);
+bool compl_chain_empty(struct compl_chain *chain);
+
+#endif /* _LINUX_COMPL_CHAIN_H */
diff --git a/lib/Makefile b/lib/Makefile
index 392ff808c9b9..8eea23c22b45 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -56,7 +56,7 @@ obj-y +=3D bcd.o sort.o parser.o debug_locks.o random32.o=
 \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o bitmap-str.o
+	 generic-radix-tree.o bitmap-str.o compl_chain.o
 obj-y +=3D string_helpers.o
 obj-y +=3D hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) +=3D test_hexdump.o
diff --git a/lib/compl_chain.c b/lib/compl_chain.c
new file mode 100644
index 000000000000..7f7063802286
--- /dev/null
+++ b/lib/compl_chain.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compl_chain.h>
+
+void compl_chain_init(struct compl_chain *chain)
+{
+
+	spin_lock_init(&chain->lock);
+	INIT_LIST_HEAD(&chain->list);
+}
+EXPORT_SYMBOL_GPL(compl_chain_init);
+
+void compl_chain_add(struct compl_chain *chain,
+			struct compl_chain_entry *entry)
+{
+
+	init_completion(&entry->prev_finished);
+	INIT_LIST_HEAD(&entry->list);
+
+	entry->chain =3D chain;
+
+	spin_lock(&chain->lock);
+	if (list_empty(&chain->list))
+		complete_all(&entry->prev_finished);
+	list_add_tail(&entry->list, &chain->list);
+	spin_unlock(&chain->lock);
+}
+EXPORT_SYMBOL_GPL(compl_chain_add);
+
+void compl_chain_wait(struct compl_chain_entry *entry)
+{
+
+	WARN_ON(!entry->chain);
+
+	wait_for_completion(&entry->prev_finished);
+}
+EXPORT_SYMBOL_GPL(compl_chain_wait);
+
+void compl_chain_complete(struct compl_chain_entry *entry)
+{
+
+	struct compl_chain *chain =3D entry->chain;
+
+	WARN_ON(!chain);
+
+	wait_for_completion(&entry->prev_finished);
+
+	spin_lock(&chain->lock);
+	list_del(&entry->list);
+	if (!list_empty(&chain->list)) {
+		struct compl_chain_entry *next =3D
+			list_first_entry(&chain->list,
+					 struct compl_chain_entry, list);
+		complete_all(&next->prev_finished);
+	}
+	spin_unlock(&chain->lock);
+
+	entry->chain =3D NULL;
+}
+EXPORT_SYMBOL_GPL(compl_chain_complete);
+
+bool compl_chain_empty(struct compl_chain *chain)
+{
+
+	bool r;
+
+	spin_lock(&chain->lock);
+	r =3D list_empty(&chain->list);
+	spin_unlock(&chain->lock);
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(compl_chain_empty);



And this is like scsi/scsi_scan.c would be changed:



diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 3c6e089e80c3..0f833c5888b5 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -36,6 +36,7 @@
 #include <linux/async.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+#include <linux/compl_chain.h>
=20
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -112,14 +113,11 @@ MODULE_PARM_DESC(inq_timeout,
 		 "Timeout (in seconds) waiting for devices to answer INQUIRY."
 		 " Default is 20. Some devices may need more; most need less.");
=20
-/* This lock protects only this list */
-static DEFINE_SPINLOCK(async_scan_lock);
-static LIST_HEAD(scanning_hosts);
+DEFINE_COMPL_CHAIN(scanning_hosts);
=20
 struct async_scan_data {
-	struct list_head list;
+	struct compl_chain_entry entry;
 	struct Scsi_Host *shost;
-	struct completion prev_finished;
 };
=20
 /*
@@ -151,9 +149,8 @@ int scsi_complete_async_scans(void)
 	struct async_scan_data *data;
=20
 	do {
-		scoped_guard(spinlock, &async_scan_lock)
-			if (list_empty(&scanning_hosts))
-				return 0;
+		if (compl_chain_empty(&scanning_hosts))
+			return 0;
 		/* If we can't get memory immediately, that's OK.  Just
 		 * sleep a little.  Even if we never get memory, the async
 		 * scans will finish eventually.
@@ -164,27 +161,11 @@ int scsi_complete_async_scans(void)
 	} while (!data);
=20
 	data->shost =3D NULL;
-	init_completion(&data->prev_finished);
=20
-	spin_lock(&async_scan_lock);
-	/* Check that there's still somebody else on the list */
-	if (list_empty(&scanning_hosts))
-		goto done;
-	list_add_tail(&data->list, &scanning_hosts);
-	spin_unlock(&async_scan_lock);
+	compl_chain_add(&scanning_hosts, &data->entry);
=20
 	printk(KERN_INFO "scsi: waiting for bus probes to complete ...\n");
-	wait_for_completion(&data->prev_finished);
-
-	spin_lock(&async_scan_lock);
-	list_del(&data->list);
-	if (!list_empty(&scanning_hosts)) {
-		struct async_scan_data *next =3D list_entry(scanning_hosts.next,
-				struct async_scan_data, list);
-		complete(&next->prev_finished);
-	}
- done:
-	spin_unlock(&async_scan_lock);
+	compl_chain_complete(&data->entry);
=20
 	kfree(data);
 	return 0;
@@ -1947,18 +1928,13 @@ static struct async_scan_data *scsi_prep_async_scan=
(struct Scsi_Host *shost)
 	data->shost =3D scsi_host_get(shost);
 	if (!data->shost)
 		goto err;
-	init_completion(&data->prev_finished);
=20
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->async_scan =3D 1;
 	spin_unlock_irqrestore(shost->host_lock, flags);
 	mutex_unlock(&shost->scan_mutex);
=20
-	spin_lock(&async_scan_lock);
-	if (list_empty(&scanning_hosts))
-		complete(&data->prev_finished);
-	list_add_tail(&data->list, &scanning_hosts);
-	spin_unlock(&async_scan_lock);
+	compl_chain_add(&scanning_hosts, &data->entry);
=20
 	return data;
=20
@@ -1995,7 +1971,7 @@ static void scsi_finish_async_scan(struct async_scan_=
data *data)
 		return;
 	}
=20
-	wait_for_completion(&data->prev_finished);
+	compl_chain_wait(&data->entry);
=20
 	scsi_sysfs_add_devices(shost);
=20
@@ -2005,14 +1981,7 @@ static void scsi_finish_async_scan(struct async_scan=
_data *data)
=20
 	mutex_unlock(&shost->scan_mutex);
=20
-	spin_lock(&async_scan_lock);
-	list_del(&data->list);
-	if (!list_empty(&scanning_hosts)) {
-		struct async_scan_data *next =3D list_entry(scanning_hosts.next,
-				struct async_scan_data, list);
-		complete(&next->prev_finished);
-	}
-	spin_unlock(&async_scan_lock);
+	compl_chain_complete(&data->entry);
=20
 	scsi_autopm_put_host(shost);
 	scsi_host_put(shost);


