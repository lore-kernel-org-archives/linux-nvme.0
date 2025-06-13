Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27967C71135
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 03:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2sVl5jx0h+BMadOKLHURkZ56DnF1L5LelaTOu5zbSWY=; b=VWxUytgj9FORkde+T368+QNSIt
	YctzbOtHEtWsRVyPsv6a+YQGe+QvW818ZJnanDZd+F7HyIiGi4ffR3qXuq6avT0PZZ38bvNIAdML4
	iAIsI38F5G25BuAa1lzt//LniKGapv1bGhxMMYSWhfOLQ7HaxpH8v5RREurndchWWMml63nZTTHWY
	S46Mav+gZsyagUtw3ZlOFreJBZPXu0uDzFAXtUeiWudlNrdlXn9PmHoHpIKaIO0XxGSRnkOXSGnjv
	eA//rvsPvVktkHeN4GO/gBe7O4Msw6qoLYhb6Atpo8qYYcap4i1zesG4Q61hWpicwwbXN8m2WDWea
	KRcQZCDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPvRJ-0000000FHAi-0D8m;
	Fri, 13 Jun 2025 03:50:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPvNM-0000000FGtW-3v4U
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 03:46:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749786403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sVl5jx0h+BMadOKLHURkZ56DnF1L5LelaTOu5zbSWY=;
	b=QOb/JofxTwnsjpiXvVK4uGssaFyqscec1wkV12T/yqEQsRphknq5mMRSLnsdIeVpj1y9N8
	OtH4GWgJPb4cT7RV3dfceeVIMC4+uQf3UsKspv4TKUPmBSMQIjECZ9t8M8s02RP3I9fcfo
	qWLaGJ9LiB0Kxe72Hrkb6pB6WjRi2RY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-bUwOwciyN4CmIJdzGqI--A-1; Thu, 12 Jun 2025 23:46:41 -0400
X-MC-Unique: bUwOwciyN4CmIJdzGqI--A-1
X-Mimecast-MFC-AGG-ID: bUwOwciyN4CmIJdzGqI--A_1749786400
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32b40be4525so766661fa.2
        for <linux-nvme@lists.infradead.org>; Thu, 12 Jun 2025 20:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749786398; x=1750391198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sVl5jx0h+BMadOKLHURkZ56DnF1L5LelaTOu5zbSWY=;
        b=gjF9IlLgUPvq+hVbAw5Nyw/XB9ggkgbDALFMRWdYAVCtngvN+nNNAfvf+dhQJy335v
         Ug2A22t7zr4bGGm86f5KCVKLnCiOnHDaZLtHvJ8Q/l4FGU0GCsUCGv5ht2kPZ1diWvy7
         qdcA/MzWMYtn6xof2JphEy+hDJQ47eNZ42lUGiz/Csm3gFsZ/xDS1seu9MiOwoexa28U
         PC8o1EnVsg/9sAXCdnUjQxNTtiLJXeCyJ5Wxg9rYZYQYDhepPBsff9WsZ1gcZ2wiNDqH
         ejb6ECpoM76N2EKbU/xhqM8ROCOwK2kX/RMC0XiDNxrG49iLajT9FBVSoe52Gppd6iB5
         dL8Q==
X-Gm-Message-State: AOJu0Yy312Gj46ZO66tygXKeX7QDvYkfL3awJn4Rh/qF1dSPLSYEjwH6
	oPp620Teao+7eVZnSp9oK6hBgyoH7E17Qjllk6mH7KoTpepJSX+/DpqLhS0rlcZY4Z2wp+7Dghd
	RJABhGY6tYhr2n+jDrXgx6kYOx2U/e5O+l5yhDeqwln56ch6z/H0q5EB4WpW8wCj6ANC+AXnW1v
	c93sOQTqE9erlD/gEKPw8cI5rINgediZooaQNZ4OmClAIx3hlwwE+8ro8f
X-Gm-Gg: ASbGncucn5hArk8FX1JmHeLYE+5w69mcG4hEaSRUDXj4X++AxSsv2Fgzr5jYlchppjm
	vv0pNs4foTly3urIO0YJglP/Sik9MElBQTnW2g+5yQjTPRSl7pJAj9wOBpHac52D70hMXsVJBpA
	Z5w0ud
X-Received: by 2002:a2e:beac:0:b0:32a:8c7a:832b with SMTP id 38308e7fff4ca-32b3ea1451dmr2541101fa.4.1749786398280;
        Thu, 12 Jun 2025 20:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAmhirLhEaFjNFdBOeUwR2l0Ms/AnqxqSZfn3MaZC3kI+hqNul25u4hNWWNkn3rBO81bFYKohdN+yNNUOXp4U=
X-Received: by 2002:a2e:beac:0:b0:32a:8c7a:832b with SMTP id
 38308e7fff4ca-32b3ea1451dmr2541011fa.4.1749786397705; Thu, 12 Jun 2025
 20:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com>
In-Reply-To: <CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 13 Jun 2025 11:46:25 +0800
X-Gm-Features: AX0GCFteARp0C-oqCshw9G74M_UNv4gIkp4FexSuMhDUqjShyRdlA9p-gl_75UM
Message-ID: <CAHj4cs_D6++rCEnxL2TNa-pMKx0Yz_La02dRLKK4b75uAWaG5A@mail.gmail.com>
Subject: Re: [bug report][bisected] sysfs: cannot create duplicate filename '/devices/virtual/nvme-subsystem'
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, nilay@linux.ibm.co
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Daniel Wagner <dwagner@suse.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i1iPFfQr8jDNhcuIaEj4p8ygabrLoB3K_hU8drOSYTU_1749786400
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_204645_117535_06CCF8C9 
X-CRM114-Status: GOOD (  14.11  )
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

Hi

I did bisecting, seems the issue was introduced by this commit:

62188639ec16 nvme-multipath: introduce delayed removal of the
multipath head node

On Tue, Jun 10, 2025 at 9:22=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi
>
> I reproduced this issue on the latest linux-block/for-next with
> blktests nvme/fc nvme/061, please help check it and let me know if you
> need any info/test, thanks.
>
> commit: 38f4878b9463 (HEAD, origin/for-next) Merge branch 'block-6.16'
> into for-next
>
> [ 4810.793156] run blktests nvme/061 at 2025-06-10 08:52:48
> [ 4811.164767] loop0: detected capacity change from 0 to 2097152
> [ 4811.254997] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 4811.746222] nvme nvme0: NVME-FC{0}: create association : host wwpn
> 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
> "blktests-subsystem-1"
> [ 4811.750328] (NULL device *): {0:0} Association created
> [ 4811.751363] nvmet: Created nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 4811.754969] sysfs: cannot create duplicate filename
> '/devices/virtual/nvme-subsystem'
> [ 4811.755435] CPU: 18 UID: 0 PID: 14937 Comm: kworker/u290:0 Tainted:
> G        W           6.15.0+ #1 PREEMPT(voluntary)
> [ 4811.755451] Tainted: [W]=3DWARN
> [ 4811.755455] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
> Gen9, BIOS P89 10/05/2016
> [ 4811.755462] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
> [ 4811.755495] Call Trace:
> [ 4811.755500]  <TASK>
> [ 4811.755507]  dump_stack_lvl+0xac/0xc0
> [ 4811.755531]  sysfs_warn_dup+0x72/0x90
> [ 4811.755549]  sysfs_create_dir_ns+0x1f2/0x260
> [ 4811.755561]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
> [ 4811.755570]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 4811.755591]  ? kobject_add_internal+0x218/0x890
> [ 4811.755605]  ? do_raw_spin_unlock+0x55/0x1f0
> [ 4811.755617]  kobject_add_internal+0x272/0x890
> [ 4811.755630]  kobject_add+0x11f/0x1f0
> [ 4811.755641]  ? __pfx_kobject_add+0x10/0x10
> [ 4811.755652]  ? __kmalloc_cache_noprof+0x3b6/0x4e0
> [ 4811.755667]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 4811.755686]  get_device_parent+0x325/0x430
> [ 4811.755700]  ? __pfx_klist_children_put+0x10/0x10
> [ 4811.755717]  device_add+0x203/0x10f0
> [ 4811.755727]  ? lockdep_init_map_type+0x51/0x270
> [ 4811.755738]  ? __pfx_device_add+0x10/0x10
> [ 4811.755748]  ? __init_waitqueue_head+0xcb/0x150
> [ 4811.755768]  nvme_init_subsystem+0xa5d/0x1470 [nvme_core]
> [ 4811.755857]  ? __pfx_nvme_identify_ctrl+0x10/0x10 [nvme_core]
> [ 4811.755912]  ? __pfx_nvme_init_subsystem+0x10/0x10 [nvme_core]
> [ 4811.755965]  ? blk_mq_run_hw_queue+0x35e/0x530
> [ 4811.755986]  ? rcu_is_watching+0x11/0xb0
> [ 4811.756002]  nvme_init_identify+0x21c/0x2290 [nvme_core]
> [ 4811.756057]  ? rcu_is_watching+0x11/0xb0
> [ 4811.756064]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 4811.756075]  ? blk_mq_hw_queue_need_run+0x271/0x3a0
> [ 4811.756084]  ? rcu_is_watching+0x11/0xb0
> [ 4811.756092]  ? trace_irq_enable.constprop.0+0x14a/0x1b0
> [ 4811.756107]  ? rcu_is_watching+0x11/0xb0
> [ 4811.756113]  ? blk_mq_run_hw_queue+0x2e3/0x530
> [ 4811.756121]  ? percpu_ref_put_many.constprop.0+0x7b/0x1b0
> [ 4811.756130]  ? rcu_is_watching+0x11/0xb0
> [ 4811.756138]  ? __pfx_nvme_init_identify+0x10/0x10 [nvme_core]
> [ 4811.756192]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
> [ 4811.756201]  ? __nvme_submit_sync_cmd+0x1e6/0x330 [nvme_core]
> [ 4811.756255]  ? nvmf_reg_read32+0xd1/0x1e0 [nvme_fabrics]
> [ 4811.756276]  ? __pfx_nvmf_reg_read32+0x10/0x10 [nvme_fabrics]
> [ 4811.756291]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
> [ 4811.756305]  ? nvme_wait_ready+0x13f/0x2d0 [nvme_core]
> [ 4811.756359]  nvme_init_ctrl_finish+0x1c8/0x810 [nvme_core]
> [ 4811.756414]  ? __pfx_nvme_init_ctrl_finish+0x10/0x10 [nvme_core]
> [ 4811.756472]  ? nvme_enable_ctrl+0x3e6/0x620 [nvme_core]
> [ 4811.756523]  ? __pfx_nvme_enable_ctrl+0x10/0x10 [nvme_core]
> [ 4811.756575]  ? nvme_fc_connect_admin_queue.constprop.0+0xa1a/0xd20 [nv=
me_fc]
> [ 4811.756596]  nvme_fc_create_association+0x880/0x1b60 [nvme_fc]
> [ 4811.756618]  ? __pfx_debug_object_deactivate+0x10/0x10
> [ 4811.756630]  ? __pfx_nvme_fc_create_association+0x10/0x10 [nvme_fc]
> [ 4811.756649]  ? rcu_is_watching+0x11/0xb0
> [ 4811.756660]  nvme_fc_connect_ctrl_work+0x1d/0xb0 [nvme_fc]
> [ 4811.756676]  ? rcu_is_watching+0x11/0xb0
> [ 4811.756684]  process_one_work+0x8cd/0x1950
> [ 4811.756704]  ? __pfx_process_one_work+0x10/0x10
> [ 4811.756720]  ? assign_work+0x16c/0x240
> [ 4811.756732]  worker_thread+0x58d/0xcf0
> [ 4811.756748]  ? __pfx_worker_thread+0x10/0x10
> [ 4811.756759]  kthread+0x3d8/0x7a0
> [ 4811.756770]  ? __pfx_kthread+0x10/0x10
> [ 4811.756781]  ? rcu_is_watching+0x11/0xb0
> [ 4811.756789]  ? __pfx_kthread+0x10/0x10
> [ 4811.756799]  ret_from_fork+0x406/0x510
> [ 4811.756810]  ? __pfx_kthread+0x10/0x10
> [ 4811.756819]  ret_from_fork_asm+0x1a/0x30
> [ 4811.756843]  </TASK>
> [ 4811.786652] kobject: kobject_add_internal failed for nvme-subsystem
> with -EEXIST, don't try to register things with the same name in the
> same directory.
> [ 4811.787439] nvme nvme0: failed to register subsystem device.
> [ 4811.788282] nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id
> 428489c9c100000 ret -17
> [ 4811.788849] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (-=
17)
> [ 4811.789259] nvme nvme0: NVME-FC{0}: Reconnect attempt in 1 seconds
> [ 4811.790106] nvme nvme0: NVME-FC{0}: new ctrl: NQN
> "blktests-subsystem-1", hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [ 4811.819765] (NULL device *): {0:0} Association deleted
> [ 4811.835407] (NULL device *): {0:0} Association freed
> [ 4811.835791] (NULL device *): Disconnect LS failed: No Association
> [ 4812.216419] nvme nvme1: NVME-FC{1}: create association : host wwpn
> 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [ 4812.220686] (NULL device *): {0:0} Association created
> [ 4812.221710] nvmet: Created discovery controller 1 for subsystem
> nqn.2014-08.org.nvmexpress.discovery for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 4812.225298] sysfs: cannot create duplicate filename
> '/devices/virtual/nvme-subsystem'
> [ 4812.225791] CPU: 3 UID: 0 PID: 10479 Comm: kworker/u289:13 Tainted:
> G        W           6.15.0+ #1 PREEMPT(voluntary)
> [ 4812.225808] Tainted: [W]=3DWARN
> [ 4812.225811] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
> Gen9, BIOS P89 10/05/2016
> [ 4812.225817] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
> [ 4812.225848] Call Trace:
> [ 4812.225852]  <TASK>
> [ 4812.225859]  dump_stack_lvl+0xac/0xc0
> [ 4812.225880]  sysfs_warn_dup+0x72/0x90
> [ 4812.225896]  sysfs_create_dir_ns+0x1f2/0x260
> [ 4812.225908]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
> [ 4812.225918]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 4812.225936]  ? kobject_add_internal+0x218/0x890
> [ 4812.225949]  ? do_raw_spin_unlock+0x55/0x1f0
> [ 4812.225962]  kobject_add_internal+0x272/0x890
> [ 4812.225975]  kobject_add+0x11f/0x1f0
> [ 4812.225986]  ? __pfx_kobject_add+0x10/0x10
> [ 4812.225997]  ? __kmalloc_cache_noprof+0x3b6/0x4e0
> [ 4812.226010]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 4812.226029]  get_device_parent+0x325/0x430
> [ 4812.226042]  ? __pfx_klist_children_put+0x10/0x10
> [ 4812.226058]  device_add+0x203/0x10f0
> [ 4812.226067]  ? lockdep_init_map_type+0x51/0x270
> [ 4812.226079]  ? __pfx_device_add+0x10/0x10
> [ 4812.226089]  ? __init_waitqueue_head+0xcb/0x150
> [ 4812.226107]  nvme_init_subsystem+0xa5d/0x1470 [nvme_core]
> [ 4812.226191]  ? __pfx_nvme_identify_ctrl+0x10/0x10 [nvme_core]
> [ 4812.226245]  ? __pfx_nvme_init_subsystem+0x10/0x10 [nvme_core]
> [ 4812.226298]  ? blk_mq_run_hw_queue+0x35e/0x530
> [ 4812.226310]  ? rcu_is_watching+0x11/0xb0
> [ 4812.226325]  nvme_init_identify+0x21c/0x2290 [nvme_core]
> [ 4812.226380]  ? rcu_is_watching+0x11/0xb0
> [ 4812.226386]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 4812.226398]  ? blk_mq_hw_queue_need_run+0x271/0x3a0
> [ 4812.226407]  ? rcu_is_watching+0x11/0xb0
> [ 4812.226414]  ? trace_irq_enable.constprop.0+0x14a/0x1b0
> [ 4812.226430]  ? rcu_is_watching+0x11/0xb0
> [ 4812.226436]  ? blk_mq_run_hw_queue+0x2e3/0x530
> [ 4812.226444]  ? percpu_ref_put_many.constprop.0+0x7b/0x1b0
> [ 4812.226452]  ? rcu_is_watching+0x11/0xb0
> [ 4812.226461]  ? __pfx_nvme_init_identify+0x10/0x10 [nvme_core]
> [ 4812.226514]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
> [ 4812.226523]  ? __nvme_submit_sync_cmd+0x1e6/0x330 [nvme_core]
> [ 4812.226576]  ? nvmf_reg_read32+0xd1/0x1e0 [nvme_fabrics]
> [ 4812.226595]  ? __pfx_nvmf_reg_read32+0x10/0x10 [nvme_fabrics]
> [ 4812.226610]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
> [ 4812.226623]  ? nvme_wait_ready+0x13f/0x2d0 [nvme_core]
> [ 4812.226677]  nvme_init_ctrl_finish+0x1c8/0x810 [nvme_core]
> [ 4812.226732]  ? __pfx_nvme_init_ctrl_finish+0x10/0x10 [nvme_core]
> [ 4812.226791]  ? nvme_enable_ctrl+0x3e6/0x620 [nvme_core]
> [ 4812.226842]  ? __pfx_nvme_enable_ctrl+0x10/0x10 [nvme_core]
> [ 4812.226893]  ? nvme_fc_connect_admin_queue.constprop.0+0xa1a/0xd20 [nv=
me_fc]
> [ 4812.226914]  nvme_fc_create_association+0x880/0x1b60 [nvme_fc]
> [ 4812.226936]  ? __pfx_debug_object_deactivate+0x10/0x10
> [ 4812.226949]  ? __pfx_nvme_fc_create_association+0x10/0x10 [nvme_fc]
> [ 4812.226968]  ? rcu_is_watching+0x11/0xb0
> [ 4812.226979]  nvme_fc_connect_ctrl_work+0x1d/0xb0 [nvme_fc]
> [ 4812.226995]  ? rcu_is_watching+0x11/0xb0
> [ 4812.227002]  process_one_work+0x8cd/0x1950
> [ 4812.227022]  ? __pfx_process_one_work+0x10/0x10
> [ 4812.227038]  ? assign_work+0x16c/0x240
> [ 4812.227050]  worker_thread+0x58d/0xcf0
> [ 4812.227066]  ? __pfx_worker_thread+0x10/0x10
> [ 4812.227077]  kthread+0x3d8/0x7a0
> [ 4812.227088]  ? __pfx_kthread+0x10/0x10
> [ 4812.227098]  ? rcu_is_watching+0x11/0xb0
> [ 4812.227107]  ? __pfx_kthread+0x10/0x10
> [ 4812.227117]  ret_from_fork+0x406/0x510
> [ 4812.227131]  ? __pfx_kthread+0x10/0x10
> [ 4812.227140]  ret_from_fork_asm+0x1a/0x30
> [ 4812.227163]  </TASK>
> [ 4812.256970] kobject: kobject_add_internal failed for nvme-subsystem
> with -EEXIST, don't try to register things with the same name in the
> same directory.
> [ 4812.257789] nvme nvme1: failed to register subsystem device.
> [ 4812.258585] nvme nvme1: NVME-FC{1}: create_assoc failed, assoc_id
> 5a306fd184770000 ret -17
> [ 4812.259155] nvme nvme1: NVME-FC{1}: reset: Reconnect attempt failed (-=
17)
> [ 4812.259560] nvme nvme1: NVME-FC{1}: Reconnect attempt in 2 seconds
> [ 4812.260436] nvme nvme1: NVME-FC{1}: new ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery", hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [ 4812.281759] (NULL device *): {0:0} Association deleted
> [ 4812.301381] (NULL device *): {0:0} Association freed
> [ 4812.301771] (NULL device *): Disconnect LS failed: No Association
> [ 4812.823776] nvme nvme0: NVME-FC{0}: create association : host wwpn
> 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
> "blktests-subsystem-1"
> [ 4812.827820] (NULL device *): {0:0} Association created
> [ 4812.828831] nvmet: Created nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 4812.832443] sysfs: cannot create duplicate filename
> '/devices/virtual/nvme-subsystem'
> [ 4812.832925] CPU: 18 UID: 0 PID: 14937 Comm: kworker/u290:0 Tainted:
> G        W           6.15.0+ #1 PREEMPT(voluntary)
> [ 4812.832941] Tainted: [W]=3DWARN
> [ 4812.832945] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
> Gen9, BIOS P89 10/05/2016
> [ 4812.832951] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
> [ 4812.832980] Call Trace:
> [ 4812.832985]  <TASK>
> [ 4812.832992]  dump_stack_lvl+0xac/0xc0
> [ 4812.833011]  sysfs_warn_dup+0x72/0x90
> [ 4812.833026]  sysfs_create_dir_ns+0x1f2/0x260
> [ 4812.833039]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
> [ 4812.833048]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 4812.833064]  ? kobject_add_internal+0x218/0x890
> [ 4812.833077]  ? do_raw_spin_unlock+0x55/0x1f0
> [ 4812.833089]  kobject_add_internal+0x272/0x890
> [ 4812.833103]  kobject_add+0x11f/0x1f0
> [ 4812.833113]  ? __pfx_kobject_add+0x10/0x10
> [ 4812.833124]  ? __kmalloc_cache_noprof+0x3b6/0x4e0
> [ 4812.833137]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 4812.833156]  get_device_parent+0x325/0x430
> [ 4812.833168]  ? __pfx_klist_children_put+0x10/0x10
> [ 4812.833183]  device_add+0x203/0x10f0
> [ 4812.833193]  ? lockdep_init_map_type+0x51/0x270
> [ 4812.833205]  ? __pfx_device_add+0x10/0x10
> [ 4812.833215]  ? __init_waitqueue_head+0xcb/0x150
> [ 4812.833232]  nvme_init_subsystem+0xa5d/0x1470 [nvme_core]
> [ 4812.833308]  ? __pfx_nvme_identify_ctrl+0x10/0x10 [nvme_core]
> [ 4812.833363]  ? __pfx_nvme_init_subsystem+0x10/0x10 [nvme_core]
> [ 4812.833416]  ? blk_mq_run_hw_queue+0x35e/0x530
> [ 4812.833427]  ? rcu_is_watching+0x11/0xb0
> [ 4812.833440]  nvme_init_identify+0x21c/0x2290 [nvme_core]
> [ 4812.833495]  ? rcu_is_watching+0x11/0xb0
> [ 4812.833502]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> [ 4812.833514]  ? blk_mq_hw_queue_need_run+0x271/0x3a0
> [ 4812.833523]  ? rcu_is_watching+0x11/0xb0
> [ 4812.833530]  ? trace_irq_enable.constprop.0+0x14a/0x1b0
> [ 4812.833545]  ? rcu_is_watching+0x11/0xb0
> [ 4812.833551]  ? blk_mq_run_hw_queue+0x2e3/0x530
> [ 4812.833559]  ? percpu_ref_put_many.constprop.0+0x7b/0x1b0
> [ 4812.833567]  ? rcu_is_watching+0x11/0xb0
> [ 4812.833575]  ? __pfx_nvme_init_identify+0x10/0x10 [nvme_core]
> [ 4812.833629]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
> [ 4812.833638]  ? __nvme_submit_sync_cmd+0x1e6/0x330 [nvme_core]
> [ 4812.833692]  ? nvmf_reg_read32+0xd1/0x1e0 [nvme_fabrics]
> [ 4812.833711]  ? __pfx_nvmf_reg_read32+0x10/0x10 [nvme_fabrics]
> [ 4812.833725]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
> [ 4812.833739]  ? nvme_wait_ready+0x13f/0x2d0 [nvme_core]
> [ 4812.833793]  nvme_init_ctrl_finish+0x1c8/0x810 [nvme_core]
> [ 4812.833848]  ? __pfx_nvme_init_ctrl_finish+0x10/0x10 [nvme_core]
> [ 4812.833906]  ? nvme_enable_ctrl+0x3e6/0x620 [nvme_core]
> [ 4812.833958]  ? __pfx_nvme_enable_ctrl+0x10/0x10 [nvme_core]
> [ 4812.834009]  ? nvme_fc_connect_admin_queue.constprop.0+0xa1a/0xd20 [nv=
me_fc]
> [ 4812.834030]  nvme_fc_create_association+0x880/0x1b60 [nvme_fc]
> [ 4812.834052]  ? __pfx_debug_object_deactivate+0x10/0x10
> [ 4812.834064]  ? __pfx_nvme_fc_create_association+0x10/0x10 [nvme_fc]
> [ 4812.834083]  ? rcu_is_watching+0x11/0xb0
> [ 4812.834094]  nvme_fc_connect_ctrl_work+0x1d/0xb0 [nvme_fc]
> [ 4812.834110]  ? rcu_is_watching+0x11/0xb0
> [ 4812.834117]  process_one_work+0x8cd/0x1950
> [ 4812.834137]  ? __pfx_process_one_work+0x10/0x10
> [ 4812.834154]  ? assign_work+0x16c/0x240
> [ 4812.834165]  worker_thread+0x58d/0xcf0
> [ 4812.834182]  ? __pfx_worker_thread+0x10/0x10
> [ 4812.834193]  kthread+0x3d8/0x7a0
> [ 4812.834204]  ? __pfx_kthread+0x10/0x10
> [ 4812.834215]  ? rcu_is_watching+0x11/0xb0
> [ 4812.834223]  ? __pfx_kthread+0x10/0x10
> [ 4812.834233]  ret_from_fork+0x406/0x510
> [ 4812.834245]  ? __pfx_kthread+0x10/0x10
> [ 4812.834255]  ret_from_fork_asm+0x1a/0x30
> [ 4812.834277]  </TASK>
> [ 4812.862781] kobject: kobject_add_internal failed for nvme-subsystem
> with -EEXIST, don't try to register things with the same name in the
> same directory.
> [ 4812.863540] nvme nvme0: failed to register subsystem device.
> [ 4812.864338] nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id
> d8c1d294d6f70000 ret -17
> [ 4812.864873] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (-=
17)
> [ 4812.865226] nvme nvme0: NVME-FC{0}: Reconnect attempt in 1 seconds
> [ 4812.879761] (NULL device *): {0:0} Association deleted
> [ 4812.896413] (NULL device *): {0:0} Association freed
> [ 4812.896821] (NULL device *): Disconnect LS failed: No Association
> [ 4813.911770] nvme nvme0: NVME-FC{0}: create association : host wwpn
> 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
> "blktests-subsystem-1"
> [ 4813.916771] (NULL device *): {0:0} Association created
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


