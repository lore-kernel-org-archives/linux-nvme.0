Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855CCC4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ERu+dgv49RdmKImwdEZt6GklclOdRP0JwwwvQGIkEOM=; b=ouOzJ2VqNK2BFvt423fF50nXk8
	XkkMCAXq6BOYCE3ulZWNevj7t7TjQQwZuMFwe8vLxoZX6d9xShAurbRLeBa0xHYwa4S4WiO7BruuW
	rZjtZ95ulrpHtu3Z3MIF12GOL4SxnPBgfdDpsXEhd5niBysMpCBtWjJheuPXqZrxoonyj0WTwVv5F
	WrBQx+bANfr8nUOyOMsgY94oeKnF+valGBf7kX4rKq6J7XhTSvDbfUnTLG8rsv6b0e6fYbRtzT3im
	A3eZ/MMPU3zjzmiSIW+uUEVLGWMBY8NbD/+cJx1AtasepJ64IAqWlZSQOElI+il41ohHpD6H5FsbN
	vTdF2qww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQRrX-002lyg-1W;
	Thu, 18 Jan 2024 12:51:15 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQRrT-002lwA-0L
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 12:51:13 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W-sqh.Q_1705582257;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-sqh.Q_1705582257)
          by smtp.aliyun-inc.com;
          Thu, 18 Jan 2024 20:51:02 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: sagi@grimberg.me,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH V4 0/1] *** Implement the NVMe reservation feature ***
Date: Thu, 18 Jan 2024 20:50:56 +0800
Message-ID: <20240118125057.56200-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_045111_332259_081712FF 
X-CRM114-Status: GOOD (  14.25  )
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

Hi guys,
    I've implemented the NVMe reservation feature. Please review it, all 
comments are welcome as usual.

Changes from v3 to v4:
- Use kfifo to handle resv log page instead of list, and also limit the
resv log queue to 64.

- Change the function calling aligment style to:
    nvmet_pr_send_event_by_hostid(pr, hostid,
            NVME_PR_LOG_RESERVATOPM_PREEMPTED); 

- Put kmalloc out of rcu_read_lock in nvmet_execute_pr_report().

- Remove the goto in __nvmet_pr_unregister_one().

- Change generation to atomic_t, and remove nvmet_pr_inc_generation().

- In addtion, the number2 patch "nvmet: unify aer type enum" is not
relate with this patch, so I will send it separately.


Changes from v2 to v3:
- Use rcu instead of rwlock to make IO path run faster, and put the rtype
into the struct nvmet_pr_registrant.

- Limit the resv_log_list to 128.

- Change generation to atomic64.

- Put register rkey check to a warpper.

- Change nr_avl_pages to nr_pages.

- Use NVME_SC_SUCCESS instead of 0.

- Change kmalloc param to let it not sleep in mutex lock.


Changes from v1 to v2:
- Implement the reservation notification report, includes registration
preempted, reservation released and reservation preempted.
  And also handle the reservation log page avaliable event and send get
reservation log page command to clear log page at host.

- Put the reservation check access after validate opcode. And remove
opcodes which nvmet not implement yet check.
  Now there is no admin opcode nvmet implemented needs reservation check,
so I dont add reservation check to admin command path.
  Next we need to do reservation check includes the situation of nsid is
0xffffffff at each admin command path, if it is needed.

- Add reservation commands support in nvmet_get_cmd_effects_nvm().

- From Chaitanya, change the local variable tree style to make it cleaner,
and add some comments about NVMe spec.
  And also change others advice from chaitanya.

- Put the nvmet_pr_check_cmd_access and nvmet_parse_pr_cmd into reservation
enable check warp.

- Remove kmem_cache instead to use kmalloc and kfree.

- Change others advice from Sagi.

- Add a blktest test case, this patch will be sent before these series of
pathes.

Guixin Liu (1):
  nvmet: support reservation feature

 drivers/nvme/target/Makefile    |   2 +-
 drivers/nvme/target/admin-cmd.c |  14 +-
 drivers/nvme/target/configfs.c  |  27 +
 drivers/nvme/target/core.c      |  50 +-
 drivers/nvme/target/nvmet.h     |  35 ++
 drivers/nvme/target/pr.c        | 956 ++++++++++++++++++++++++++++++++
 include/linux/nvme.h            |  48 ++
 7 files changed, 1125 insertions(+), 7 deletions(-)
 create mode 100644 drivers/nvme/target/pr.c

-- 
2.43.0


