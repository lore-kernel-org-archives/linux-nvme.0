Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FC0C48BC3
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Feb 2024 02:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DTp2I+hfK1xgHVv2dZoEaXsmy3pCLUHgfP51PVdxgs=; b=HRbieRVtIoqitWj17G543Lgih4
	7vBgY1mMmY6Ygk7ROa8/iJhWCTIs7xNyvSVrHPK76Qtgha3KeiqHAJ2uuvZguG6RsVYsNT49zJ6SP
	1JhUEkwWN/PJqqQ89MRaut9Ix2sNI5S7cLzrgGukcN85rRbmU/myg7WosWcxi09VkrSSVqsKAoYeB
	v9fwkyYaThCMQUkfhuB811wbWb6uqHIodGfmWE57Haoul0o9aF6atYSBnqc3brcBoFoljrNEVt54X
	QCv71/nxu5H/fwwI1HjSUdDxogr4RdPHDszYVbCN9o+3Y72LgpozZfSJtbL+b0sam8ScyRvIWy4z+
	54m/+JOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbWfZ-00000006myY-31Nl;
	Sun, 18 Feb 2024 02:12:41 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbWfT-00000006mxa-0Dl4
	for linux-nvme@lists.infradead.org;
	Sun, 18 Feb 2024 02:12:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708222347; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=8DTp2I+hfK1xgHVv2dZoEaXsmy3pCLUHgfP51PVdxgs=;
	b=X0QtmkgrYxK71b4FAxzDa8xe7GHKb+BEUK+IJpjweIp7YIYzx4pDSJKZHm4vwMwGGsXsRWaP5yeG9UG9qLP6oHV7LBmAzP4pMgbBSHMvicjlAGVh3vSCazmPhsyCaPqTarOBRTneLSpYXSQXXx777QBHcSA9ozsTiLVepDjy/Mg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W0kJBqG_1708222343;
Received: from 30.178.83.160(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W0kJBqG_1708222343)
          by smtp.aliyun-inc.com;
          Sun, 18 Feb 2024 10:12:24 +0800
Message-ID: <af0c5068-fec7-453a-a1e2-b5c0d7e8e308@linux.alibaba.com>
Date: Sun, 18 Feb 2024 10:12:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/1] Implement the NVMe reservation feature
From: Guixin Liu <kanie@linux.alibaba.com>
To: sagi@grimberg.me, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
Content-Language: en-GB
In-Reply-To: <20240201023207.112007-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240217_181235_984167_E42CAC3E 
X-CRM114-Status: GOOD (  29.36  )
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

Hi,

     Gentle ping...

Best regards.

Guixin Liu

在 2024/2/1 10:32, Guixin Liu 写道:
> Hi guys,
>      I've implemented the NVMe reservation feature. Please review it, all
> comments are welcome as usual.
>
> Changes from v6 to v7:
> - Handle "reservation notification mask" feature command to mask reservation
> log.
>
> - Add all the registrants that need to be freed to a temporary list fist,
> and then after calling synchronize_rcu(), release all the registrants on the
> temporary list.
>
> - Fix the resv log page is random when there is no resv log page.
>
> - Change nvmet_is_host_still_connected() to nvmet_is_host_connected().
>
> - Remove nvmet_pr_set_rtype_and_holder() and change nvmet_pr_create_new_resv()
> to nvmet_pr_create_new_reservation().
>
> - Change nvmet_pr_find_registrant_by_hostid() to nvmet_pr_find_registrant().
>
> - Change nvmet_pr_send_resv_released() to nvmet_pr_resv_released().
>
> - Change __nvmet_pr_unregister_one() to nvmet_pr_unregister_one().
>
> - In nvmet_pr_unreg_by_prkey(), nvmet_pr_unreg_by_prkey_except_hostid() and
> nvmet_pr_unreg_except_hostid(), first do unregistering and then do event sending.
>
>
> Changes from v5 to v6:
> - Use synchronize_rcu() and kfree() to free registrant instead of kfree_rcu().
>
> - Remove nvmet_pr_register_check_rkey(), put the check into pr_lock warp.
> And refactor the nvmet_pr_register().
>
> - Add the print fmt to the head.
>
> - Add lockdep_is_held(&pr->pr_lock) condition to list_for_each_entry_rcu.
>
> - Fix the bug in nvmet_pr_update_reg_attr(), when the change_attr hook
> return fail, we should not replace the holder.
>
> Changes from v4 to v5:
>
> - Use rculist macros to handle registration_list instead of list macros
> regardless of in mutex lock or not.
>
> - Use goto statement instead of return in nvmet_is_host_still_connected
> and __nvmet_pr_unregister_one.
>
> - Add lockdep_assert_held and rcu_read_lock_held assert to many functions,
> if it's necessary.
>
> - Add a comment to nvmet_execute_get_log_page_resv to explain how lost_count
> works.
>
> - In nvmet_pr_clear, we should set holder to NULL first, I fixed this.
>
> - Unify nvmet_pr_update_holder_rtype and __nvmet_pr_do_replace to
> nvmet_pr_update_reg_attr.
>
> - Fix wrong nr_pages in nvmet_execute_get_log_page_resv.
>
> - Fix the deadlock issue of nvmet_pr_exit_ns, put it out of the subsys lock.
>
>
> Changes from v3 to v4:
> - Use kfifo to handle resv log page instead of list, and also limit the
> resv log queue to 64.
>
> - Change the function calling alignment style to:
>      nvmet_pr_send_event_by_hostid(pr, hostid,
>              NVME_PR_LOG_RESERVATOPM_PREEMPTED);
>
> - Put kmalloc out of rcu_read_lock in nvmet_execute_pr_report().
>
> - Remove the goto in __nvmet_pr_unregister_one().
>
> - Change generation to atomic_t, and remove nvmet_pr_inc_generation().
>
> - In addtion, the number2 patch "nvmet: unify aer type enum" is not
> relate with this patch, so I will send it separately.
>
>
> Changes from v2 to v3:
> - Use rcu instead of rwlock to make IO path run faster, and put the rtype
> into the struct nvmet_pr_registrant.
>
> - Limit the resv_log_list to 128.
>
> - Change generation to atomic64.
>
> - Put register rkey check to a warpper.
>
> - Change nr_avl_pages to nr_pages.
>
> - Use NVME_SC_SUCCESS instead of 0.
>
> - Change kmalloc param to let it not sleep in mutex lock.
>
>
> Changes from v1 to v2:
> - Implement the reservation notification report, includes registration
> preempted, reservation released and reservation preempted.
>    And also handle the reservation log page available event and send get
> reservation log page command to clear log page at host.
>
> - Put the reservation check access after validate opcode. And remove
> opcodes which nvmet not implement yet check.
>    Now there is no admin opcode nvmet implemented needs reservation check,
> so I dont add reservation check to admin command path.
>    Next we need to do reservation check includes the situation of nsid is
> 0xffffffff at each admin command path, if it is needed.
>
> - Add reservation commands support in nvmet_get_cmd_effects_nvm().
>
> - From Chaitanya, change the local variable tree style to make it cleaner,
> and add some comments about NVMe spec.
>    And also change others advice from chaitanya.
>
> - Put the nvmet_pr_check_cmd_access and nvmet_parse_pr_cmd into reservation
> enable check warp.
>
> - Remove kmem_cache instead to use kmalloc and kfree.
>
> - Change others advice from Sagi.
>
> - Add a blktest test case, this patch will be sent before these series of
> patches.
>
> Guixin Liu (1):
>    nvmet: support reservation feature
>
>   drivers/nvme/target/Makefile    |    2 +-
>   drivers/nvme/target/admin-cmd.c |   20 +-
>   drivers/nvme/target/configfs.c  |   27 +
>   drivers/nvme/target/core.c      |   51 +-
>   drivers/nvme/target/nvmet.h     |   36 ++
>   drivers/nvme/target/pr.c        | 1041 +++++++++++++++++++++++++++++++
>   include/linux/nvme.h            |   54 ++
>   7 files changed, 1224 insertions(+), 7 deletions(-)
>   create mode 100644 drivers/nvme/target/pr.c
>

