Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B721061B2B
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:From:Cc:To:Subject:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=s/neG+eP6x2X2WHp6yoXl4nuNPnjXkwaaR0nyQmO5Vg=; b=cHm1M3t7H5J+XBr7zBDw2cMOlT
	3+Fm258KaFme3y8xdXVMzBKorOlepl/XIcQD3nf43UxrnWpuUp3AtSkjrfLqP/8Rlx9MVp4vU79Ru
	7DBj5o6YE0VeE7K4jsdc4DTddabf6vhRQ4Wx1/xZWazeIjQ4BHkeS8RPr/9HqhPHxuIJx/RVq06gj
	9h+x7RRrwnuHIZmglbA2UNJeuOBMRhU8LRofsonUHmqS1B+awrHgS9YBN0a7znRkKrWyfiaaDKFfP
	EIOiTL+hAjtHD2w931SP7zFA104AvMB+TKgAMqZqbxe3NFi6A+WELeARmRhqBQjtWT0fs2JyfB2H0
	9jxpTDfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7XJ6-0000000Csc7-1o8k;
	Tue, 31 Mar 2026 11:30:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7XJ1-0000000Csbd-0REe
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 11:30:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 81E4260120;
	Tue, 31 Mar 2026 11:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C424FC19423;
	Tue, 31 Mar 2026 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774956646;
	bh=CCUP4sHYCQ9axw7943rER5xM/KZ1AUs+kGKRSkEffmc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=BjzGfbrcnXGWiW9k25HwLiyEozu/Ckerj8dWUv/smgHmYJZ5FVv5V4TxnXGwmtCbY
	 zy5B2TZ1zgsJcceDcZf6uuFXAn+qNUJN2OWLqBtC4DlyvvrmDgG80WECActMxf6ocn
	 s2+w7/6M2DOHFFyEf8ZCbZgmdRTnZTQXNpwrUfMM=
Subject: Patch "nvme: fix admin queue leak on controller reset" has been added to the 6.6-stable tree
To: 1468888505@139.com,axboe@fb.com,gregkh@linuxfoundation.org,hare@suse.de,hch@lst.de,kbusch@kernel.org,kch@nvidia.com,linux-nvme@lists.infradead.org,ming.lei@redhat.com,patches@lists.linux.dev,sagi@grimberg.me,yi.zhang@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 31 Mar 2026 13:30:22 +0200
In-Reply-To: <20260331073659.3136206-1-1468888505@139.com>
Message-ID: <2026033122-stood-unaligned-08af@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    nvme: fix admin queue leak on controller reset

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     nvme-fix-admin-queue-leak-on-controller-reset.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-231348-greg=kroah.com@vger.kernel.org Tue Mar 31 09:44:05 2026
From: Li hongliang <1468888505@139.com>
Date: Tue, 31 Mar 2026 15:36:59 +0800
Subject: nvme: fix admin queue leak on controller reset
To: gregkh@linuxfoundation.org, stable@vger.kernel.org, ming.lei@redhat.com
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org, yi.zhang@redhat.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me, hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org
Message-ID: <20260331073659.3136206-1-1468888505@139.com>

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b84bb7bd913d8ca2f976ee6faf4a174f91c02b8d ]

When nvme_alloc_admin_tag_set() is called during a controller reset,
a previous admin queue may still exist. Release it properly before
allocating a new one to avoid orphaning the old queue.

This fixes a regression introduced by commit 03b3bcd319b3 ("nvme: fix
admin request_queue lifetime").

Cc: Keith Busch <kbusch@kernel.org>
Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime").
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Li hongliang <1468888505@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4287,6 +4287,13 @@ int nvme_alloc_admin_tag_set(struct nvme
 	if (ret)
 		return ret;
 
+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (ctrl->admin_q)
+		blk_put_queue(ctrl->admin_q);
+
 	ctrl->admin_q = blk_mq_init_queue(set);
 	if (IS_ERR(ctrl->admin_q)) {
 		ret = PTR_ERR(ctrl->admin_q);


Patches currently in stable-queue which might be from 1468888505@139.com are

queue-6.6/nvme-fix-admin-queue-leak-on-controller-reset.patch

