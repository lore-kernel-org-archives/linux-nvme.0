Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1736C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:34:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730B1611BE
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730B1611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:Date:From:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=k91megvpbVNJbmldrEEcWanDEHorX/lKoLnt/KM7d3M=; b=CZvtTj7omcV7r1QszjfChyv8J
	cl7Bfa3B1fLnK6MQVjGl0gkqjkcgH1J5LrCnMa/E0pmETt51h3Mn1FXzYlA+nTGeqyBxzced/Oujv
	u81WRJhm2n+c5Otq1cbWaUd1VVUZDWKuXcU+guKzurMeqWI0Blshuh2FY75im2SSCX6v5nQyVUQw3
	UvyRrl+MPJdsRrKSgd3vEZ0RIjmeno0T4JCiul61PG3Bqxor7NUvzRyWOM7LIJsyB2NA88LZSIkbv
	rz1VJQecHJepQ0xWdwJYyiziX98lhfpv3iLC0CdSKKja6AO3jehwY6UOWdNjYPOQ8V6bQDJeerFtO
	ifXYtdHgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUnWt-000G34-Ma; Fri, 09 Apr 2021 09:34:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUnWc-000FwE-Pi
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 09:34:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1C4B61108;
 Fri,  9 Apr 2021 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1617960840;
 bh=sKXvk6kWXx0fFt0jgeQMcRZlxIkxpntTRkgkmJnLync=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=ztSwoYoZQYzCmAKeiNWmLST8QSJSccn25LO1udPnhV0+sYcjfh18cARSrCs4MxA18
 Pwvj9jxzCFAe/GIRtKVjwXG1HKa4C/aPUxy4vmCw3jZALvBp0GTRZV93ZWFalo8Oo3
 wFJrl9HqS1yxWbm1SRXJ5FqApTiZsruT6WuQeFR0=
Subject: Patch "nvme-mpath: replace direct_make_request with
 generic_make_request" has been added to the 5.4-stable tree
To: gregkh@linuxfoundation.org, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 Apr 2021 11:33:57 +0200
In-Reply-To: <20210402200841.347696-1-sagi@grimberg.me>
Message-ID: <161796083719102@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_103403_921131_B15BDE1E 
X-CRM114-Status: GOOD (  22.02  )
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


This is a note to let you know that I've just added the patch titled

    nvme-mpath: replace direct_make_request with generic_make_request

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     nvme-mpath-replace-direct_make_request-with-generic_make_request.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From sagi@grimberg.me  Fri Apr  9 11:33:14 2021
From: Sagi Grimberg <sagi@grimberg.me>
Date: Fri,  2 Apr 2021 13:08:41 -0700
Subject: nvme-mpath: replace direct_make_request with generic_make_request
To: <stable@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Message-ID: <20210402200841.347696-1-sagi@grimberg.me>

From: Sagi Grimberg <sagi@grimberg.me>

The below patches caused a regression in a multipath setup:
Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")

These patches on their own are correct because they fixed a controller reset
regression.

When we reset/teardown a controller, we must freeze and quiesce the namespaces
request queues to make sure that we safely stop inflight I/O submissions.
Freeze is mandatory because if our hctx map changed between reconnects,
blk_mq_update_nr_hw_queues will immediately attempt to freeze the queue, and
if it still has pending submissions (that are still quiesced) it will hang.
This is what the above patches fixed.

However, by freezing the namespaces request queues, and only unfreezing them
when we successfully reconnect, inflight submissions that are running
concurrently can now block grabbing the nshead srcu until either we successfully
reconnect or ctrl_loss_tmo expired (or the user explicitly disconnected).

This caused a deadlock [1] when a different controller (different path on the
same subsystem) became live (i.e. optimized/non-optimized). This is because
nvme_mpath_set_live needs to synchronize the nshead srcu before requeueing I/O
in order to make sure that current_path is visible to future (re)submisions.
However the srcu lock is taken by a blocked submission on a frozen request
queue, and we have a deadlock.

In recent kernels (v5.9+) direct_make_request was replaced by submit_bio_noacct
which does not have this issue because it bio_list will be active when
nvme-mpath calls submit_bio_noacct on the bottom device (because it was
populated when submit_bio was triggered on it.

Hence, we need to fix all the kernels that were before submit_bio_noacct was
introduced.

[1]:
Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
Call Trace:
 __schedule+0x293/0x730
 schedule+0x33/0xa0
 schedule_timeout+0x1d3/0x2f0
 wait_for_completion+0xba/0x140
 __synchronize_srcu.part.21+0x91/0xc0
 synchronize_srcu_expedited+0x27/0x30
 synchronize_srcu+0xce/0xe0
 nvme_mpath_set_live+0x64/0x130 [nvme_core]
 nvme_update_ns_ana_state+0x2c/0x30 [nvme_core]
 nvme_update_ana_state+0xcd/0xe0 [nvme_core]
 nvme_parse_ana_log+0xa1/0x180 [nvme_core]
 nvme_read_ana_log+0x76/0x100 [nvme_core]
 nvme_mpath_init+0x122/0x180 [nvme_core]
 nvme_init_identify+0x80e/0xe20 [nvme_core]
 nvme_tcp_setup_ctrl+0x359/0x660 [nvme_tcp]
 nvme_tcp_reconnect_ctrl_work+0x24/0x70 [nvme_tcp]

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/multipath.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -330,7 +330,7 @@ static blk_qc_t nvme_ns_head_make_reques
 		trace_block_bio_remap(bio->bi_disk->queue, bio,
 				      disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
-		ret = direct_make_request(bio);
+		ret = generic_make_request(bio);
 	} else if (nvme_available_path(head)) {
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 


Patches currently in stable-queue which might be from sagi@grimberg.me are

queue-5.4/nvme-mpath-replace-direct_make_request-with-generic_make_request.patch

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
