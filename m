Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA98606A31B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tYZ0wC3Z;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LQyMZyst
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Xbnm5bKJs84055F6ZV+v2ymo8yBxk78v3qq8w1XWB40=; b=tYZ0wC3ZdIRbxZCSrCqykw/L0l
	QKpNXxIzwEu8eq9BkvWswijhKpSQNapk6Dbh+u6em0XnGQhfRowj+2Gyi5tvmcwGyBCXjbRPhIGIl
	xqjJwZTudJYoFwHq5eYXRCr9dZNNFFVVPTMta1/gDTwz7a/0m4iElKHP5YcZ5RtaOVzFMnGQNMVmb
	vXJLnx0s697No8Utg0WPxlDJWRReqWNYRYAJJYsPIIPX3xvMLUsKThxbVqg2TjuhuVPTzwX5Dvwz/
	cBlpV5Uvg5pdhjle79ZQi26Nd0212yYlTY1ZZ7zdSX5wI3jtzULmH1AKzkB4hXAZzvp6Jwmk1k8zn
	n3UAyVzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9ED-0000000B1DD-182G;
	Fri, 06 Nov 2026 01:58:53 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9EA-0000000B1By-2QXv
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 01:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793930328; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Xbnm5bKJs84055F6ZV+v2ymo8yBxk78v3qq8w1XWB40=;
	b=LQyMZystpjpJoDuhPDkX4TJSQdwOQK9oYOqDP+vbA33Dzf4n7lg6A1mHD+YIuJsKliLXaAooW12nVmBHA7a/auQ7FH5PyUImc2UcekyHG+gXT5FfDQ+T3rhRYMRMpRrBizKTFxp1peP0OSDZ81UggGY1yhPCrwEtWJbBqrsydw4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA2CPz_1793930326;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA2CPz_1793930326 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:58:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 0/6] nvme: fabrics and target fixes
Date: Fri,  6 Nov 2026 09:58:36 +0800
Message-ID: <20261106015842.3534898-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_175850_792896_A9BB6630 
X-CRM114-Status: GOOD (  13.48  )
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
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Six fixes found by code inspection of the nvme host and target drivers:

 - a reconnect_delay of 0 is accepted through sysfs and makes the
   ctrl_loss_tmo store divide by zero; reproduced on an unfixed
   kernel, rejected on the patched one
 - list_for_each_entry_safe() in nvme_fc_match_disconn_ls() cannot
   tolerate the rport lock drop inside the loop: the cached next
   entry may be freed in the window, so the loop switches back to a
   plain iterator, which is safe because the reference taken on the
   current entry pins it on the list; reproduced under KASAN through
   fcloop with an amplified lock-drop window
 - a data race on ctrl->transaction between concurrent per-queue
   DH-HMAC-CHAP exchanges
 - nvmet_subsys_attr_tbkas_store() walks subsys->ctrls without
   subsys->lock, the same bug fixed for qid_max_store() in patch 4
   of this series
 - nvmet_install_queue() leaks a controller reference and permanently
   wedges the queue on its error paths
 - needless GFP_ATOMIC allocations in the nvmet persistent reservation
   code

All fixes are verified on an initiator/target VM pair running the
patched kernel: 30 connect/IO/disconnect cycles, tbkas toggles racing
connection churn, persistent reservation operations across all six
reservation types, and a full DH-HMAC-CHAP authenticated session with
I/O.  The nvme-fc fix is additionally exercised through fcloop with
three controllers on one remote port, where the modified
nvme_fc_match_disconn_ls() path ran on every host- and target-initiated
association teardown, including 15 tbkas force-reconnect cycles that
send Disconnect Association LSs into the multi-entry list walk.

Guixin Liu (6):
  nvme: reject a reconnect_delay of 0 through sysfs
  nvme-fc: fix iterator over rport->ctrl_list in nvme_fc_match_disconn_ls()
  nvme-auth: fix data race on ctrl->transaction
  nvmet: take subsys->lock in nvmet_subsys_attr_tbkas_store()
  nvmet: fix controller reference leak in nvmet_install_queue() error paths
  nvmet: use GFP_KERNEL for PR allocations

 drivers/nvme/host/auth.c          | 2 +-
 drivers/nvme/host/fc.c            | 4 ++--
 drivers/nvme/host/nvme.h          | 2 +-
 drivers/nvme/host/sysfs.c         | 3 +++
 drivers/nvme/target/configfs.c    | 2 ++
 drivers/nvme/target/fabrics-cmd.c | 5 +++++
 drivers/nvme/target/pr.c          | 4 ++--
 7 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.43.7


