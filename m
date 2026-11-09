Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E3606A33C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=so1XSmeL;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W0KJRvO7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mvajMTdREyKd3ELQIABUMwhErvHcplpwM/gO9EWJ908=; b=so1XSmeLFgq19C
	w4cK65FqnsYmtBnZ2/Le8Fszgra27+Jb8BzCyWm1I/Pi9BPos94Bk0uFVJbExRPcSZCf+R+/N/KbX
	8WJAdBNWqWByT76G2ksmp1aIwiL3yZBGwDwPoy1meWDI7dATSwI6KyD7W28xo+KwTJumtFGu1gzpr
	E5Hrvh8ogI89hPGr+5mM2I3FEjiJhgY7HZLdU7mNRuaphcFjrjDPT79k/1HpjPxdgdg9p5t+uLv9g
	LB0M0bmH10aVzYua60melP5rCIyswnWbsdFHEeQElMlpc/QrjK6iDWDnX6M8Q6mMGZTqYrJMOtWVN
	Ovzr0p2G12mfpQsFJ7oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF69-0000000H7gf-0jyq;
	Mon, 09 Nov 2026 02:27:06 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF64-0000000H7d5-3Juo
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 02:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794191216; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mvajMTdREyKd3ELQIABUMwhErvHcplpwM/gO9EWJ908=;
	b=W0KJRvO7IaZLc0WwS/UAHt6D6lM7+5KNXlIxl+YDM/8b4+AYdml6bMxaQYgtrQDbESjXBudjpeks6PcqTaLM2C5GzvAddvQ7gCjMcEie9mVHmNOEi4znWqHMM/EqasCPnReVOP5B93OdIm2s2c1RVsP6yGDjV7Pb2MYUy7xJtZ8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEI5jq5_1794191215;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEI5jq5_1794191215 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 10:26:55 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 4/5] nvmet: take subsys->lock in nvmet_subsys_attr_tbkas_store()
Date: Mon,  9 Nov 2026 10:26:45 +0800
Message-ID: <20261109022646.290792-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261109022646.290792-1-kanie@linux.alibaba.com>
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_182700_986998_90BA0BD5 
X-CRM114-Status: GOOD (  11.50  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tbkas store handler walks subsys->ctrls to force every controller
to reconnect, but it holds only nvmet_config_sem for write.
subsys->ctrls is protected by subsys->lock: nvmet_alloc_ctrl() adds an
entry under subsys->lock, and nvmet_ctrl_free() removes it under
subsys->lock with list_del() + kfree(). A concurrent controller
teardown can therefore corrupt the walk.

This is the same bug fixed for nvmet_subsys_attr_qid_max_store() in
commit 9f426f140511 ("nvmet: take subsys->lock while
force-reconnecting in nvmet_subsys_attr_qid_max_store()"), which
missed this second instance of the pattern. Take subsys->lock around
the list_for_each_entry() loop. ->delete_ctrl() only queues
asynchronous controller teardown, so it does not re-enter subsys->lock
under the loop.

Fixes: e98e45e9465b ("nvmet: Add traffic based keep alive support to configfs")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3a5242d06f9..c17f2c8ab2df 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1466,8 +1466,10 @@ static ssize_t nvmet_subsys_attr_tbkas_store(struct config_item *item,
 	subsys->tbkas = tbkas;
 
 	/* Force reconnect */
+	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		ctrl->ops->delete_ctrl(ctrl);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
 	return count;
-- 
2.43.7


