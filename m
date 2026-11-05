Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8F606A328
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O+aE4Mwd;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vh5fl/Yy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=0bN7uhLa7OVo5L/3rnz301II+Wiu5rTixdbsegWalVI=; b=O+aE4Mwd3JeSu8917zdyMIby2h
	8/6GMyAvu+rfheuvPbqkFACrLEt47AhlrlEH/M5HJI7ImOQN5eIPgwpBOgEay0Lbtrf0emrLel6xR
	sqZ0TxKjb1fufIprdKwKRd46WIrj4aea+sIK9Fls/ds0Y63Zaegg+FIdlYdmt5LwmH+ewykbVZs0X
	J62f4g9Jr5fSHK24opRIkQ+U+SQHFi8M8f6zD47A9WUZSuM83StcGkTUbH1QetDMoLWdbkxuYNBcm
	nrrgjkQ9+5P3FAH6Civn+15j89X6ITS0FBbVjDBBX4Yylag9o/Ktnuj4rZgxUQ+aPSlaUzJkOmShO
	3u6NI5TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwV-00000007XOR-1o7Q;
	Thu, 05 Nov 2026 02:11:07 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwS-00000007XLP-0Uul
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 02:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793844658; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0bN7uhLa7OVo5L/3rnz301II+Wiu5rTixdbsegWalVI=;
	b=vh5fl/YyECZlvhJGpe9xHrCod1VqL0j3gdwvyf6br1FUKxf9rRbKh6lV3dkUJ+jVFrA8+ymmdlpThLsRkxgwZdwYKwrf0anSTTmgU0ufVsky9yUyOITSuiCyUz/6aypRHI0f8TUVaHk71klPtkmGe4qJmMWZS1GrMqFP0wOMm2o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XE7BnJm_1793844657;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XE7BnJm_1793844657 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 10:10:58 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 0/9] nvme: dead code cleanups
Date: Thu,  5 Nov 2026 10:10:42 +0800
Message-ID: <20261105021051.1667222-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_181104_657075_187C6D98 
X-CRM114-Status: GOOD (  11.11  )
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

A round of dead code removals in the nvme host and target drivers,
all found by code inspection. Every patch stands on its own and can
be picked individually:

 - the NVMEQ_DELETE_ERROR flag lost its only reader in 2020 and is
   now write-only; dropping it also removes the nvme_del_cq_end()
   wrapper, which degenerates to nvme_del_queue_end() without it
 - struct fields never referenced since they were introduced:
   nvme_fc_queue.seqno, nvme_dhchap_queue_context.entry,
   nvmet_fc_ls_iod.fcpreq and nvmet_fc_tgt_queue.ninetypercent
 - a hostnqn already-assigned check that can never fire because
   opts->host is only set after the option parsing loop
 - the reconnect_delay "off" case, copied from fast_io_fail_tmo but
   unreachable for an unsigned value the parser bounds to positive
   values
 - an address family map entry that both show and store skip, an
   unreachable break in the passthru feature handling, and a drain
   of an SQ list that is never populated

Guixin Liu (9):
  nvme-pci: remove write-only NVMEQ_DELETE_ERROR flag
  nvme-fc: remove dead seqno field in nvme_fc_queue
  nvme-auth: remove dead entry field in nvme_dhchap_queue_context
  nvme-fabrics: remove dead hostnqn already-assigned check
  nvme: drop unreachable "off" case in reconnect_delay_show()
  nvmet-fc: remove dead fields in nvmet_fc_ls_iod and nvmet_fc_tgt_queue
  nvmet: remove unreachable "pcie" entry from the address family map
  nvmet: passthru: remove unreachable break statements
  nvmet-pci-epf: don't drain the never-populated SQ list

 drivers/nvme/host/auth.c       |  1 -
 drivers/nvme/host/fabrics.c    |  6 ------
 drivers/nvme/host/fc.c         |  1 -
 drivers/nvme/host/pci.c        | 20 +-------------------
 drivers/nvme/host/sysfs.c      |  2 --
 drivers/nvme/target/configfs.c |  5 ++---
 drivers/nvme/target/fc.c       |  3 ---
 drivers/nvme/target/passthru.c |  2 --
 drivers/nvme/target/pci-epf.c  |  2 --
 9 files changed, 3 insertions(+), 39 deletions(-)

-- 
2.43.7


