Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D43CC47422
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 08:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8b2GPs5FNdPK5Au0PY2xdXfZutgXuSPjivcXZLgID8=; b=jiMQ9Ww1b9J2tg55JsYtBgCfHA
	Qbr4H1g+sJJFMCD2cQxbABUf8NwSGZ+Mi1jW4+wZZjCn/rKd9Ong3zuxl1jUP8BMqCPxASEPvQZhR
	+h3c4LVMTyss6ae14zC7+oyfv/MEjqMuim4LDs1qclW0jwt1CvMx27+r9LVxYUQyxfBCplRa0Hehz
	Ia2dRgzpYgrDB6d4KPM+MgNV/d/tOPwafjOK4YvP50KQeJx5lem9fGJJBay7Tvya+JffDJ8nv78JW
	OGnbWzyJcv+SosnQ/0FKBBtJE0g4z07Fn0KNJ2XwPE3tZCL+l/BpssDa2uxaA8B3/vuIV13SsaD7o
	Uxu2v2qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ1C0-00EreV-22;
	Wed, 17 Jan 2024 08:22:36 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ1Bx-00Ercf-0h
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 08:22:35 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-ojF-S_1705479747;
Received: from 30.178.83.127(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-ojF-S_1705479747)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 16:22:28 +0800
Message-ID: <66eb0dc5-26e9-416b-9e9f-efceb66a7b97@linux.alibaba.com>
Date: Wed, 17 Jan 2024 16:22:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] *** Implement the NVMe reservation feature ***
Content-Language: en-GB
From: Guixin Liu <kanie@linux.alibaba.com>
To: sagi@grimberg.me, hch@lst.de, kch@nvidia.com, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20240117081512.89635-1-kanie@linux.alibaba.com>
In-Reply-To: <20240117081512.89635-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_002233_400265_5D0AA246 
X-CRM114-Status: GOOD (  20.33  )
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

The version is wrong, please ignore this.

Best regards,

Guixin Liu

在 2024/1/17 16:15, Guixin Liu 写道:
> Hi guys,
>      I've implemented the NVMe reservation feature. Please review it, all
> comments are welcome as usual.
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
>    And also handle the reservation log page avaliable event and send get
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
> pathes.
>
> Guixin Liu (2):
>    nvmet: support reservation feature
>    nvmet: unify aer type enum
>
>   drivers/nvme/target/Makefile    |   2 +-
>   drivers/nvme/target/admin-cmd.c |  14 +-
>   drivers/nvme/target/configfs.c  |  27 +
>   drivers/nvme/target/core.c      |  53 +-
>   drivers/nvme/target/discovery.c |   2 +-
>   drivers/nvme/target/nvmet.h     |  33 ++
>   drivers/nvme/target/pr.c        | 979 ++++++++++++++++++++++++++++++++
>   include/linux/nvme.h            |  54 +-
>   8 files changed, 1148 insertions(+), 16 deletions(-)
>   create mode 100644 drivers/nvme/target/pr.c
>

