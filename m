Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5CBC47DDF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 04:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d9nO40yt5FkjWV5on4Ees45M6M6M1hv1uiwriO0xcxw=; b=ppPR4Xt+g1zDEnsuGGskvJ6nSt
	GGSEVlFlUvyQp0HCzXI2WpGqmLK7kvVP2kzhQuh/YzZ/osQ5anCKLAunrfGG7ZW+qcejOUZvZe7rz
	yJTaOL/DuctAEB9NlKUltnG8y92XGfqaXLv5IdI7LC9TyypgH+LyySfYhWGway5c0caZJ/W81NCxr
	gOmWE0MXgWLpNLY8bPVn2IEyGKhCkMjsk3YAPzmkfuO1bYZtGKXZnbS/uQDOJwOgwUMz96yE62t45
	aE0k1mo6JMN6kxyPfFS3A1ubeyIDKE7muJsV7jVZATL4Suwc1mgORGU9M4giqRGQ0PsRz7X/Sj0Ab
	Ikjq8YrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUIqF-0000000BBNP-3GZb;
	Mon, 29 Jan 2024 04:01:51 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUIqC-0000000BBLP-3WYq
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 04:01:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706500903; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=d9nO40yt5FkjWV5on4Ees45M6M6M1hv1uiwriO0xcxw=;
	b=Z26xhYCw6/sVDO2fmBeQAGx0LWoi0wQhhcDMottgynndiEucFjNJlzF3effOlypnMqrSsxukwv0nOrFWQo2NGAoETLx/dyq/w7Utqm68rqsRtFMxTcRtR8tLjWuehP1RFy07gD66boSCUvoZXkfVNGEoHqC/l1Wsa1Hppfv5U4k=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.UKt3D_1706500896;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.UKt3D_1706500896)
          by smtp.aliyun-inc.com;
          Mon, 29 Jan 2024 12:01:42 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH V5 0/1] *** Implement the NVMe reservation feature ***
Date: Mon, 29 Jan 2024 12:01:35 +0800
Message-ID: <20240129040136.86393-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_200149_407519_942E1418 
X-CRM114-Status: GOOD (  19.75  )
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

Hi Sagi,
    I have not receive your reply yet, so I put my reply of v4 here:
- About adding synchronize_rcu after rcu_assign_pointer, rcu_assign_pointer
ensures that all reads after it will see the new value, we only need to ensure
that there are no reads before the old value free, the kfree_rcu can make sure
that.
  And using synchronize_rcu and free is same as kfree_rcu, could you plz explain
detailly why should we use synchronize_rcu after rcu_assign_pointer?

- About the lock I use, I use pr->pr_lock to protect pr->registrant_list and
pr->holder writing, and both of holder and registrant_list are rcu protected,
so they can be read lightly in nvmet_pr_check_cmd_access.
  I was misled by the __dev_exception_clean() into thinking that if I added
a mutex lock, I wouldn't have to use the rculist marcros anymore, I will 
change this in v5, sorry for the trouble...


Changes from v4 to v5:

- Use rculist macros to handle registration_list instead of list macros
regardless of in mutex lock or not.

- Use goto statement instead of return in nvmet_is_host_still_connected 
and __nvmet_pr_unregister_one.

- Add lockdep_assert_held and rcu_read_lock_held assert to many functions,
if it's necessary.

- Add a comment to nvmet_execute_get_log_page_resv to explain how lost_count
works.

- In nvmet_pr_clear, we should set holder to NULL first, I fixed this.

- Unify nvmet_pr_update_holder_rtype and __nvmet_pr_do_replace to 
nvmet_pr_update_reg_attr.

- Fix wrong nr_pages in nvmet_execute_get_log_page_resv.

- Fix the deadlock issue of nvmet_pr_exit_ns, put it out of the subsys lock.


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
 drivers/nvme/target/core.c      |  51 +-
 drivers/nvme/target/nvmet.h     |  35 ++
 drivers/nvme/target/pr.c        | 968 ++++++++++++++++++++++++++++++++
 include/linux/nvme.h            |  48 ++
 7 files changed, 1138 insertions(+), 7 deletions(-)
 create mode 100644 drivers/nvme/target/pr.c

-- 
2.43.0


