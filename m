Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D96D13591
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 01:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8VvtiYtGYdDCtsH5Qj3l5fJP/xiC7kebR/FhdekrSuI=; b=Ll/SWUaJYW1nIo90IjtAC1AYtT
	TiK1W7RTE/QR8aPQU92ckY9XeBciEu2hkaJ+2tfvPWdoDk5FzcbFxnO+qKiOxkY/mQG7m9UvmPWWG
	obDlAlzX9wsiI0AZeIhRjW46zjR9hvd/MnjhR4Qz2dW4oLpq9v5xtZTAlEpXb78N7qhLPsJ6SKj5U
	mHVOXEuEUG6AjQBPMs9JxzU+0YirTKRLKIE8Eos0qLJQ9R2DEbHQbuuQEpTIMkcPR8Tlmk+zCj5fM
	RCWASdexM9W4ElXJ3lYz0+uu3gkA6jhsyerCYGnbjy/DVikvTaIK8gsSovxeAwmweLmGGQv1S+vbG
	/NsHmZZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5F24-00000009Fcr-15xV;
	Mon, 28 Oct 2024 01:59:00 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5F20-00000009Fbw-00W2
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 01:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730080731; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8VvtiYtGYdDCtsH5Qj3l5fJP/xiC7kebR/FhdekrSuI=;
	b=noQp8iXvpqvaWHLAq2FE7T3BMWWPmGP0Jr6tbXifXxYlAgRk76TeiL36RXjTEugJ638EmBrbpbMyfQk+jHKBXFAQY1pFGArEYoig1YZC1jKdlWSe87lnXVZvyG73lRmDPMfkglaUSp4TW6aJ4TlbvvRf4EVqUQ+z3F3CEgg+HHM=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHywgj4_1730080724 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 09:58:49 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	d.bogdanov@yadro.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v19 0/2] Implement the NVMe reservation feature
Date: Mon, 28 Oct 2024 09:58:42 +0800
Message-ID: <20241028015844.111210-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_185856_590437_500CFBBE 
X-CRM114-Status: GOOD (  28.06  )
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

Changes from v18 to v19:
- Fix the compile error when lockdep is open, remove including lockdep.h.
- Fix a bug in __nvmet_req_complete(), before calling queue_response() hook,
get the pc_ref first, and then put the ref.

Changes from v17 to v18:
- Use semaphore to replace mutex pr_lock for async aborting.

Changes from v16 to v17:
- Put nvmet_pr_do_abort() into workqueue to not block the the transport thread.
- Fix a bug in nvmet_pr_get_ns_pc_ref(), we should set req->pc_ref after
percpu_ref_tryget_live() scucess, otherwise the pc_ref may be decremented
one extra.

Changes from v15 to v16:
- Fix kerenl message print "INFO: trying to register non-static key",
when the namespace is not enable reservation.
- Fix the race condition between nvmet_ctrl_init_pr() and nvmet_ns_enable()
by putting nvmet_ctrl_init_pr() and nvmet_ctrl_destroy_pr() into the brace
of mutex_lock(&subsys->lock). Avoid the double init of per-controller percpu
ref.

Changes from v14 to v15:
- Change first patch commit message.

Changes from v13 to v14:
- Fix some grammatical mistake in commit message.
- Add two characters to bulleted lists in commit message to make it
more readble.
- Adjust some tab indent.

Changes from v12 to v13:
- Set regctl to the number of all registrants instead of reported when
reporting.

Changes from v11 to v12:
- Change patch to fit newest 6.12-rc2.
- Fix possible out-of-bounds access in nvmet_execute_pr_report.
- Use sysfs_emit instead of printf in nvmet_ns_resv_enable_show.
- Add struct rcu_head to nvmet_pr_registrant to free.
- Introduce a helper nvmet_pr_parse_ignore_key.
- Use NVME_CNTLID_DYNAMIC when report cntlid.
- Fix some over long line.
- Add more details to commit body.
- Separate out the include/linux/nvme.h changes to a single patch.
- Add a nvmetcli patch to support resv_enable configuration.

Changes from v10 to v11:
- Remove the cntlid from struct nvmet_pr_registrant. And add hostid to
  nvmet_pr_per_ctrl_ref to set the correct ctrl to do abort.
- Report all registrants, and report cntlid 0xffff.
- Change nvmet_req's flags to pc_ref.

Changes from v9 to v10:
- Fix the misjudgement in nvmet_pr_unregister_one.
- Fix the non-atomicity problem in nvmet_pr_preempt, now we set the new
  holder first before unregistering, this can not only make sure that during
  unregistering other host can not access, but also ensure that
  nvmet_pr_unregister_one will not unregiter the new holder(In
  nvmet_pr_unreg_all_others_by_prkey, I exclude current host).
- Remove the pr_abort in nvmet_ctrl, instead kill the per-controller percpu ref
  first and then wait to zero at the end of preempt_and_abort.
- Fix some spelling mistakes.

Changes from v8 to v9:
- Remove the maintianer request.

- Support "preemt and abort" by adding a per-controller percpu ref to ns,
  doing wait per-controller percpu ref to zero when a controller's reservation
  or registration is preempt and the racqa == "preempt and abort".
  Currently add per-controller percpu ref only when nvmet_pr_check_cmd_access
  success, others are not cared.

- Report ns support reservation when resv is enabled.

- Report ctrl support reservation.

- Change the log level to info when log lost.

- Fix the UAF issue in nvmet_pr_unreg_by_prkey, and change nvmet_pr_unreg_by_prkey
  to nvmet_pr_unreg_all_host_by_prkey.

- Dont unregister the host when ctrl is destroyed for keep the reservation info
  when reconnect.

- Remove the rcu lock and mutex lock when free ns's pr info.

- Fix the situation of log.count is zero.

- Move the rtype check to the start of preemtion, Dmitry suggests that:
    1.4.1.6 reserved
    Receipt of reserved coded values in defined fields in
    commands shall be reported as an error. 
  Look forward the suggestions.
  And also, this avoid the non-atomic change of unregister and set new holder.

- Fix the compile error when close CONFIG_LOCKDEP.

- Change nvmet_pr_send_event_by_hostid to nvmet_pr_send_event_to_host.

- Change nvmet_pr_unreg_by_prkey_except_hostid to nvmet_pr_unreg_all_others_by_prkey.

- Change nvmet_pr_unreg_by_prkey to nvmet_pr_unreg_all_host_by_prkey.

Changes from v7 to v8:
- Add me as the new file pr.c's maintainer.

Changes from v6 to v7:
- Handle "reservation notification mask" feature command to mask reservation
log.

- Add all the registrants that need to be freed to a temporary list fist,
and then after calling synchronize_rcu(), release all the registrants on the
temporary list.

- Fix the resv log page is random when there is no resv log page.

- Change nvmet_is_host_still_connected() to nvmet_is_host_connected().

- Remove nvmet_pr_set_rtype_and_holder() and change nvmet_pr_create_new_resv()
to nvmet_pr_create_new_reservation().

- Change nvmet_pr_find_registrant_by_hostid() to nvmet_pr_find_registrant().

- Change nvmet_pr_send_resv_released() to nvmet_pr_resv_released().

- Change __nvmet_pr_unregister_one() to nvmet_pr_unregister_one().

- In nvmet_pr_unreg_by_prkey(), nvmet_pr_unreg_by_prkey_except_hostid() and
nvmet_pr_unreg_except_hostid(), first do unregistering and then do event sending.


Changes from v5 to v6:
- Use synchronize_rcu() and kfree() to free registrant instead of kfree_rcu().

- Remove nvmet_pr_register_check_rkey(), put the check into pr_lock warp.
And refactor the nvmet_pr_register().

- Add the print fmt to the head.

- Add lockdep_is_held(&pr->pr_lock) condition to list_for_each_entry_rcu.

- Fix the bug in nvmet_pr_update_reg_attr(), when the change_attr hook
return fail, we should not replace the holder. 

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

- Change the function calling alignment style to:
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
  And also handle the reservation log page available event and send get
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
patches.

Guixin Liu (2):
  nvme: add reservation command's defines
  nvmet: support reservation feature

 drivers/nvme/target/Makefile      |    2 +-
 drivers/nvme/target/admin-cmd.c   |   24 +-
 drivers/nvme/target/configfs.c    |   27 +
 drivers/nvme/target/core.c        |   62 +-
 drivers/nvme/target/fabrics-cmd.c |    4 +-
 drivers/nvme/target/nvmet.h       |   65 +-
 drivers/nvme/target/pr.c          | 1156 +++++++++++++++++++++++++++++
 include/linux/nvme.h              |   68 ++
 8 files changed, 1396 insertions(+), 12 deletions(-)
 create mode 100644 drivers/nvme/target/pr.c

-- 
2.43.0


