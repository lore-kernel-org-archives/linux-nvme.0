Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A945AC61CE8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 04:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFA0Dw4EcrxF9b2AwlWNMzYD/2NVYPgcLUlZsepajbo=; b=tUzdaJdr9ZucyvO/YHby47va/p
	rtGwiYLGENlhfcAYaREk367dPVK3LToxe12ZuThblYPuHI9hSU3onONHZmESA2LtEMfIiVaMe0rKh
	LvoGmiCjJpbrHYBXcL0ZDhNH8sTci4OWI0qgAg/MC2C/cGbBjTpE4Lc932V1ujPD7DLxXW1DjlP++
	HVpa8rCD8M4vNZeLJPETsu47tNDfWSRXzgrVgQZrAnJn1BUDFTia21P3C7PH5ZbVhtl1QEspNnkIF
	uRdNH+xQpHFzB1hB8BB31dAs5PbcY1prkXmqY84/CyAxoJyvSA3Wnzza+XzymydoI1NEjLbq/5yq3
	G2zZMp7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPZHg-0000000C7uU-31eH;
	Thu, 12 Jun 2025 04:11:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP0ql-00000007J5w-41zj
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 15:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749569118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFA0Dw4EcrxF9b2AwlWNMzYD/2NVYPgcLUlZsepajbo=;
	b=R4yWsXvij4+1UkUPOKa94AlHbEK2LjayxxN9BvTNOoguehgXS1piuqa6vQNhSVNo2IAIs5
	+2daq92ygrD/gfvFa8n6ygJGT28DM6rUWgW3GsZFGiueaeiRdDB/jXMlBW91B66B/qTm5O
	puDsZZH56B1v9CbFvlo60kHYx3Y2ZeY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-Ff7k_jKgODCxGeqvMdkcDA-1; Tue, 10 Jun 2025 11:25:12 -0400
X-MC-Unique: Ff7k_jKgODCxGeqvMdkcDA-1
X-Mimecast-MFC-AGG-ID: Ff7k_jKgODCxGeqvMdkcDA_1749569111
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32ade0bf4a8so16134611fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Jun 2025 08:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749569110; x=1750173910;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFA0Dw4EcrxF9b2AwlWNMzYD/2NVYPgcLUlZsepajbo=;
        b=VFsrMT3REDpTD82CM5BzXFfsXN6WGpYkwPhx5brcedQ88wLkfkdPrddDKn5AK9lAlD
         P9Fp1zi9FfG5khZbP9V+MgXe+2vrZTAPGSWOnqGtOeUjfFgp8XgGRCJPb9O4LT38X611
         2uI8NQ4rZorHa84vAec2Og3str7JDHpCgU3wGP5MYH02ueKpYRteEOf+Zn+dZz2J7h9e
         ydpSY8Zxvk9Z60e5YoPBg0RAM3LuEAKmr6+hP9FyM3JtBdus4nAa2BbS14IaJ5CLG9Hh
         dZgdj24yhmIHnprrRtEJZL6hk99HlB4abYz56iqLUyyf8k3gysvWdO51dpWhQZEzyPzo
         C2nw==
X-Gm-Message-State: AOJu0Yx8y3HJwDrgiLy8sWg1LO/GS9L9Hx3afmf2XlZ+pGmuijgp1jIL
	0XcHeQIRm77J54TAFbztgxxgDq9qCia4cd1vt+fW8VECHc4ycZ3ZGDfutbnRux82etQN+yKKeNf
	LGBEtxkBVMc1ACUF+KlD3M0/UlIncTiQDAAOe5b+JBA+iypfF34qG4vm6aqO42ASO7h2Cm/4y0R
	Ln0wwI3kpQhmBwajgUFUgdxOmkM8LVRBe9qBYinIc4EDyuu/xrWI74wg==
X-Gm-Gg: ASbGncs7vweOmrPSeTEA+2kJkMqK6uLIsnBXUiwcZN9lDwG3LB3zhqkJ79i5emEAsJR
	dydEsrRZruftkveaILpGKMiilUD1XzWql3nOyPxMBx4iK+BUsgOBnKwOuTbfZD5KkldanZsXxQi
	S4fGC4
X-Received: by 2002:a2e:968f:0:b0:32a:6c09:2d7a with SMTP id 38308e7fff4ca-32b20301a60mr691421fa.30.1749569109827;
        Tue, 10 Jun 2025 08:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwRtdiezZCOFqtCtshBNSph/MlXNO5vnahq8zG72XIRI7f6qs89cv/oUaTgzzdXePuDCKknOYLPoKs4D9VM8M=
X-Received: by 2002:a2e:968f:0:b0:32a:6c09:2d7a with SMTP id
 38308e7fff4ca-32b20301a60mr691281fa.30.1749569109053; Tue, 10 Jun 2025
 08:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com>
In-Reply-To: <CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 10 Jun 2025 23:24:55 +0800
X-Gm-Features: AX0GCFuvFPemKX5pgIQUnhGZTmXsbM_NE2baY0ZBiL-Tx_kcap-AdEaebLmPs0o
Message-ID: <CAHj4cs_h8uYXxmub5aZAGvRuV9nyyWsdokLRJCwbTk=Cj+RN=g@mail.gmail.com>
Subject: Fwd: [bug report] sysfs: cannot create duplicate filename '/devices/virtual/nvme-subsystem'
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oicnCU7lkPUWPI42F7GIs4_4TiCUKoati7KM_Al0UGo_1749569111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_082520_141570_187A0251 
X-CRM114-Status: UNSURE (   9.16  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 11 Jun 2025 21:11:18 -0700
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

Resent to linux-nvme maillist

---------- Forwarded message ---------
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, Jun 10, 2025 at 9:22=E2=80=AFPM
Subject: [bug report] sysfs: cannot create duplicate filename
'/devices/virtual/nvme-subsystem'
To: open list:NVM EXPRESS DRIVER <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>


Hi

I reproduced this issue on the latest linux-block/for-next with
blktests nvme/fc nvme/061, please help check it and let me know if you
need any info/test, thanks.

commit: 38f4878b9463 (HEAD, origin/for-next) Merge branch 'block-6.16'
into for-next

[ 4810.793156] run blktests nvme/061 at 2025-06-10 08:52:48
[ 4811.164767] loop0: detected capacity change from 0 to 2097152
[ 4811.254997] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 4811.746222] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 4811.750328] (NULL device *): {0:0} Association created
[ 4811.751363] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 4811.754969] sysfs: cannot create duplicate filename
'/devices/virtual/nvme-subsystem'
[ 4811.755435] CPU: 18 UID: 0 PID: 14937 Comm: kworker/u290:0 Tainted:
G        W           6.15.0+ #1 PREEMPT(voluntary)
[ 4811.755451] Tainted: [W]=3DWARN
[ 4811.755455] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
Gen9, BIOS P89 10/05/2016
[ 4811.755462] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
[ 4811.755495] Call Trace:
[ 4811.755500]  <TASK>
[ 4811.755507]  dump_stack_lvl+0xac/0xc0
[ 4811.755531]  sysfs_warn_dup+0x72/0x90
[ 4811.755549]  sysfs_create_dir_ns+0x1f2/0x260
[ 4811.755561]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[ 4811.755570]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 4811.755591]  ? kobject_add_internal+0x218/0x890
[ 4811.755605]  ? do_raw_spin_unlock+0x55/0x1f0
[ 4811.755617]  kobject_add_internal+0x272/0x890
[ 4811.755630]  kobject_add+0x11f/0x1f0
[ 4811.755641]  ? __pfx_kobject_add+0x10/0x10
[ 4811.755652]  ? __kmalloc_cache_noprof+0x3b6/0x4e0
[ 4811.755667]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 4811.755686]  get_device_parent+0x325/0x430
[ 4811.755700]  ? __pfx_klist_children_put+0x10/0x10
[ 4811.755717]  device_add+0x203/0x10f0
[ 4811.755727]  ? lockdep_init_map_type+0x51/0x270
[ 4811.755738]  ? __pfx_device_add+0x10/0x10
[ 4811.755748]  ? __init_waitqueue_head+0xcb/0x150
[ 4811.755768]  nvme_init_subsystem+0xa5d/0x1470 [nvme_core]
[ 4811.755857]  ? __pfx_nvme_identify_ctrl+0x10/0x10 [nvme_core]
[ 4811.755912]  ? __pfx_nvme_init_subsystem+0x10/0x10 [nvme_core]
[ 4811.755965]  ? blk_mq_run_hw_queue+0x35e/0x530
[ 4811.755986]  ? rcu_is_watching+0x11/0xb0
[ 4811.756002]  nvme_init_identify+0x21c/0x2290 [nvme_core]
[ 4811.756057]  ? rcu_is_watching+0x11/0xb0
[ 4811.756064]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 4811.756075]  ? blk_mq_hw_queue_need_run+0x271/0x3a0
[ 4811.756084]  ? rcu_is_watching+0x11/0xb0
[ 4811.756092]  ? trace_irq_enable.constprop.0+0x14a/0x1b0
[ 4811.756107]  ? rcu_is_watching+0x11/0xb0
[ 4811.756113]  ? blk_mq_run_hw_queue+0x2e3/0x530
[ 4811.756121]  ? percpu_ref_put_many.constprop.0+0x7b/0x1b0
[ 4811.756130]  ? rcu_is_watching+0x11/0xb0
[ 4811.756138]  ? __pfx_nvme_init_identify+0x10/0x10 [nvme_core]
[ 4811.756192]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
[ 4811.756201]  ? __nvme_submit_sync_cmd+0x1e6/0x330 [nvme_core]
[ 4811.756255]  ? nvmf_reg_read32+0xd1/0x1e0 [nvme_fabrics]
[ 4811.756276]  ? __pfx_nvmf_reg_read32+0x10/0x10 [nvme_fabrics]
[ 4811.756291]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
[ 4811.756305]  ? nvme_wait_ready+0x13f/0x2d0 [nvme_core]
[ 4811.756359]  nvme_init_ctrl_finish+0x1c8/0x810 [nvme_core]
[ 4811.756414]  ? __pfx_nvme_init_ctrl_finish+0x10/0x10 [nvme_core]
[ 4811.756472]  ? nvme_enable_ctrl+0x3e6/0x620 [nvme_core]
[ 4811.756523]  ? __pfx_nvme_enable_ctrl+0x10/0x10 [nvme_core]
[ 4811.756575]  ? nvme_fc_connect_admin_queue.constprop.0+0xa1a/0xd20 [nvme=
_fc]
[ 4811.756596]  nvme_fc_create_association+0x880/0x1b60 [nvme_fc]
[ 4811.756618]  ? __pfx_debug_object_deactivate+0x10/0x10
[ 4811.756630]  ? __pfx_nvme_fc_create_association+0x10/0x10 [nvme_fc]
[ 4811.756649]  ? rcu_is_watching+0x11/0xb0
[ 4811.756660]  nvme_fc_connect_ctrl_work+0x1d/0xb0 [nvme_fc]
[ 4811.756676]  ? rcu_is_watching+0x11/0xb0
[ 4811.756684]  process_one_work+0x8cd/0x1950
[ 4811.756704]  ? __pfx_process_one_work+0x10/0x10
[ 4811.756720]  ? assign_work+0x16c/0x240
[ 4811.756732]  worker_thread+0x58d/0xcf0
[ 4811.756748]  ? __pfx_worker_thread+0x10/0x10
[ 4811.756759]  kthread+0x3d8/0x7a0
[ 4811.756770]  ? __pfx_kthread+0x10/0x10
[ 4811.756781]  ? rcu_is_watching+0x11/0xb0
[ 4811.756789]  ? __pfx_kthread+0x10/0x10
[ 4811.756799]  ret_from_fork+0x406/0x510
[ 4811.756810]  ? __pfx_kthread+0x10/0x10
[ 4811.756819]  ret_from_fork_asm+0x1a/0x30
[ 4811.756843]  </TASK>
[ 4811.786652] kobject: kobject_add_internal failed for nvme-subsystem
with -EEXIST, don't try to register things with the same name in the
same directory.
[ 4811.787439] nvme nvme0: failed to register subsystem device.
[ 4811.788282] nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id
428489c9c100000 ret -17
[ 4811.788849] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (-17=
)
[ 4811.789259] nvme nvme0: NVME-FC{0}: Reconnect attempt in 1 seconds
[ 4811.790106] nvme nvme0: NVME-FC{0}: new ctrl: NQN
"blktests-subsystem-1", hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 4811.819765] (NULL device *): {0:0} Association deleted
[ 4811.835407] (NULL device *): {0:0} Association freed
[ 4811.835791] (NULL device *): Disconnect LS failed: No Association
[ 4812.216419] nvme nvme1: NVME-FC{1}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 4812.220686] (NULL device *): {0:0} Association created
[ 4812.221710] nvmet: Created discovery controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 4812.225298] sysfs: cannot create duplicate filename
'/devices/virtual/nvme-subsystem'
[ 4812.225791] CPU: 3 UID: 0 PID: 10479 Comm: kworker/u289:13 Tainted:
G        W           6.15.0+ #1 PREEMPT(voluntary)
[ 4812.225808] Tainted: [W]=3DWARN
[ 4812.225811] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
Gen9, BIOS P89 10/05/2016
[ 4812.225817] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
[ 4812.225848] Call Trace:
[ 4812.225852]  <TASK>
[ 4812.225859]  dump_stack_lvl+0xac/0xc0
[ 4812.225880]  sysfs_warn_dup+0x72/0x90
[ 4812.225896]  sysfs_create_dir_ns+0x1f2/0x260
[ 4812.225908]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[ 4812.225918]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 4812.225936]  ? kobject_add_internal+0x218/0x890
[ 4812.225949]  ? do_raw_spin_unlock+0x55/0x1f0
[ 4812.225962]  kobject_add_internal+0x272/0x890
[ 4812.225975]  kobject_add+0x11f/0x1f0
[ 4812.225986]  ? __pfx_kobject_add+0x10/0x10
[ 4812.225997]  ? __kmalloc_cache_noprof+0x3b6/0x4e0
[ 4812.226010]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 4812.226029]  get_device_parent+0x325/0x430
[ 4812.226042]  ? __pfx_klist_children_put+0x10/0x10
[ 4812.226058]  device_add+0x203/0x10f0
[ 4812.226067]  ? lockdep_init_map_type+0x51/0x270
[ 4812.226079]  ? __pfx_device_add+0x10/0x10
[ 4812.226089]  ? __init_waitqueue_head+0xcb/0x150
[ 4812.226107]  nvme_init_subsystem+0xa5d/0x1470 [nvme_core]
[ 4812.226191]  ? __pfx_nvme_identify_ctrl+0x10/0x10 [nvme_core]
[ 4812.226245]  ? __pfx_nvme_init_subsystem+0x10/0x10 [nvme_core]
[ 4812.226298]  ? blk_mq_run_hw_queue+0x35e/0x530
[ 4812.226310]  ? rcu_is_watching+0x11/0xb0
[ 4812.226325]  nvme_init_identify+0x21c/0x2290 [nvme_core]
[ 4812.226380]  ? rcu_is_watching+0x11/0xb0
[ 4812.226386]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 4812.226398]  ? blk_mq_hw_queue_need_run+0x271/0x3a0
[ 4812.226407]  ? rcu_is_watching+0x11/0xb0
[ 4812.226414]  ? trace_irq_enable.constprop.0+0x14a/0x1b0
[ 4812.226430]  ? rcu_is_watching+0x11/0xb0
[ 4812.226436]  ? blk_mq_run_hw_queue+0x2e3/0x530
[ 4812.226444]  ? percpu_ref_put_many.constprop.0+0x7b/0x1b0
[ 4812.226452]  ? rcu_is_watching+0x11/0xb0
[ 4812.226461]  ? __pfx_nvme_init_identify+0x10/0x10 [nvme_core]
[ 4812.226514]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
[ 4812.226523]  ? __nvme_submit_sync_cmd+0x1e6/0x330 [nvme_core]
[ 4812.226576]  ? nvmf_reg_read32+0xd1/0x1e0 [nvme_fabrics]
[ 4812.226595]  ? __pfx_nvmf_reg_read32+0x10/0x10 [nvme_fabrics]
[ 4812.226610]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
[ 4812.226623]  ? nvme_wait_ready+0x13f/0x2d0 [nvme_core]
[ 4812.226677]  nvme_init_ctrl_finish+0x1c8/0x810 [nvme_core]
[ 4812.226732]  ? __pfx_nvme_init_ctrl_finish+0x10/0x10 [nvme_core]
[ 4812.226791]  ? nvme_enable_ctrl+0x3e6/0x620 [nvme_core]
[ 4812.226842]  ? __pfx_nvme_enable_ctrl+0x10/0x10 [nvme_core]
[ 4812.226893]  ? nvme_fc_connect_admin_queue.constprop.0+0xa1a/0xd20 [nvme=
_fc]
[ 4812.226914]  nvme_fc_create_association+0x880/0x1b60 [nvme_fc]
[ 4812.226936]  ? __pfx_debug_object_deactivate+0x10/0x10
[ 4812.226949]  ? __pfx_nvme_fc_create_association+0x10/0x10 [nvme_fc]
[ 4812.226968]  ? rcu_is_watching+0x11/0xb0
[ 4812.226979]  nvme_fc_connect_ctrl_work+0x1d/0xb0 [nvme_fc]
[ 4812.226995]  ? rcu_is_watching+0x11/0xb0
[ 4812.227002]  process_one_work+0x8cd/0x1950
[ 4812.227022]  ? __pfx_process_one_work+0x10/0x10
[ 4812.227038]  ? assign_work+0x16c/0x240
[ 4812.227050]  worker_thread+0x58d/0xcf0
[ 4812.227066]  ? __pfx_worker_thread+0x10/0x10
[ 4812.227077]  kthread+0x3d8/0x7a0
[ 4812.227088]  ? __pfx_kthread+0x10/0x10
[ 4812.227098]  ? rcu_is_watching+0x11/0xb0
[ 4812.227107]  ? __pfx_kthread+0x10/0x10
[ 4812.227117]  ret_from_fork+0x406/0x510
[ 4812.227131]  ? __pfx_kthread+0x10/0x10
[ 4812.227140]  ret_from_fork_asm+0x1a/0x30
[ 4812.227163]  </TASK>
[ 4812.256970] kobject: kobject_add_internal failed for nvme-subsystem
with -EEXIST, don't try to register things with the same name in the
same directory.
[ 4812.257789] nvme nvme1: failed to register subsystem device.
[ 4812.258585] nvme nvme1: NVME-FC{1}: create_assoc failed, assoc_id
5a306fd184770000 ret -17
[ 4812.259155] nvme nvme1: NVME-FC{1}: reset: Reconnect attempt failed (-17=
)
[ 4812.259560] nvme nvme1: NVME-FC{1}: Reconnect attempt in 2 seconds
[ 4812.260436] nvme nvme1: NVME-FC{1}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 4812.281759] (NULL device *): {0:0} Association deleted
[ 4812.301381] (NULL device *): {0:0} Association freed
[ 4812.301771] (NULL device *): Disconnect LS failed: No Association
[ 4812.823776] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 4812.827820] (NULL device *): {0:0} Association created
[ 4812.828831] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 4812.832443] sysfs: cannot create duplicate filename
'/devices/virtual/nvme-subsystem'
[ 4812.832925] CPU: 18 UID: 0 PID: 14937 Comm: kworker/u290:0 Tainted:
G        W           6.15.0+ #1 PREEMPT(voluntary)
[ 4812.832941] Tainted: [W]=3DWARN
[ 4812.832945] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380
Gen9, BIOS P89 10/05/2016
[ 4812.832951] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
[ 4812.832980] Call Trace:
[ 4812.832985]  <TASK>
[ 4812.832992]  dump_stack_lvl+0xac/0xc0
[ 4812.833011]  sysfs_warn_dup+0x72/0x90
[ 4812.833026]  sysfs_create_dir_ns+0x1f2/0x260
[ 4812.833039]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[ 4812.833048]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 4812.833064]  ? kobject_add_internal+0x218/0x890
[ 4812.833077]  ? do_raw_spin_unlock+0x55/0x1f0
[ 4812.833089]  kobject_add_internal+0x272/0x890
[ 4812.833103]  kobject_add+0x11f/0x1f0
[ 4812.833113]  ? __pfx_kobject_add+0x10/0x10
[ 4812.833124]  ? __kmalloc_cache_noprof+0x3b6/0x4e0
[ 4812.833137]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 4812.833156]  get_device_parent+0x325/0x430
[ 4812.833168]  ? __pfx_klist_children_put+0x10/0x10
[ 4812.833183]  device_add+0x203/0x10f0
[ 4812.833193]  ? lockdep_init_map_type+0x51/0x270
[ 4812.833205]  ? __pfx_device_add+0x10/0x10
[ 4812.833215]  ? __init_waitqueue_head+0xcb/0x150
[ 4812.833232]  nvme_init_subsystem+0xa5d/0x1470 [nvme_core]
[ 4812.833308]  ? __pfx_nvme_identify_ctrl+0x10/0x10 [nvme_core]
[ 4812.833363]  ? __pfx_nvme_init_subsystem+0x10/0x10 [nvme_core]
[ 4812.833416]  ? blk_mq_run_hw_queue+0x35e/0x530
[ 4812.833427]  ? rcu_is_watching+0x11/0xb0
[ 4812.833440]  nvme_init_identify+0x21c/0x2290 [nvme_core]
[ 4812.833495]  ? rcu_is_watching+0x11/0xb0
[ 4812.833502]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 4812.833514]  ? blk_mq_hw_queue_need_run+0x271/0x3a0
[ 4812.833523]  ? rcu_is_watching+0x11/0xb0
[ 4812.833530]  ? trace_irq_enable.constprop.0+0x14a/0x1b0
[ 4812.833545]  ? rcu_is_watching+0x11/0xb0
[ 4812.833551]  ? blk_mq_run_hw_queue+0x2e3/0x530
[ 4812.833559]  ? percpu_ref_put_many.constprop.0+0x7b/0x1b0
[ 4812.833567]  ? rcu_is_watching+0x11/0xb0
[ 4812.833575]  ? __pfx_nvme_init_identify+0x10/0x10 [nvme_core]
[ 4812.833629]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
[ 4812.833638]  ? __nvme_submit_sync_cmd+0x1e6/0x330 [nvme_core]
[ 4812.833692]  ? nvmf_reg_read32+0xd1/0x1e0 [nvme_fabrics]
[ 4812.833711]  ? __pfx_nvmf_reg_read32+0x10/0x10 [nvme_fabrics]
[ 4812.833725]  ? percpu_ref_put_many.constprop.0+0x80/0x1b0
[ 4812.833739]  ? nvme_wait_ready+0x13f/0x2d0 [nvme_core]
[ 4812.833793]  nvme_init_ctrl_finish+0x1c8/0x810 [nvme_core]
[ 4812.833848]  ? __pfx_nvme_init_ctrl_finish+0x10/0x10 [nvme_core]
[ 4812.833906]  ? nvme_enable_ctrl+0x3e6/0x620 [nvme_core]
[ 4812.833958]  ? __pfx_nvme_enable_ctrl+0x10/0x10 [nvme_core]
[ 4812.834009]  ? nvme_fc_connect_admin_queue.constprop.0+0xa1a/0xd20 [nvme=
_fc]
[ 4812.834030]  nvme_fc_create_association+0x880/0x1b60 [nvme_fc]
[ 4812.834052]  ? __pfx_debug_object_deactivate+0x10/0x10
[ 4812.834064]  ? __pfx_nvme_fc_create_association+0x10/0x10 [nvme_fc]
[ 4812.834083]  ? rcu_is_watching+0x11/0xb0
[ 4812.834094]  nvme_fc_connect_ctrl_work+0x1d/0xb0 [nvme_fc]
[ 4812.834110]  ? rcu_is_watching+0x11/0xb0
[ 4812.834117]  process_one_work+0x8cd/0x1950
[ 4812.834137]  ? __pfx_process_one_work+0x10/0x10
[ 4812.834154]  ? assign_work+0x16c/0x240
[ 4812.834165]  worker_thread+0x58d/0xcf0
[ 4812.834182]  ? __pfx_worker_thread+0x10/0x10
[ 4812.834193]  kthread+0x3d8/0x7a0
[ 4812.834204]  ? __pfx_kthread+0x10/0x10
[ 4812.834215]  ? rcu_is_watching+0x11/0xb0
[ 4812.834223]  ? __pfx_kthread+0x10/0x10
[ 4812.834233]  ret_from_fork+0x406/0x510
[ 4812.834245]  ? __pfx_kthread+0x10/0x10
[ 4812.834255]  ret_from_fork_asm+0x1a/0x30
[ 4812.834277]  </TASK>
[ 4812.862781] kobject: kobject_add_internal failed for nvme-subsystem
with -EEXIST, don't try to register things with the same name in the
same directory.
[ 4812.863540] nvme nvme0: failed to register subsystem device.
[ 4812.864338] nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id
d8c1d294d6f70000 ret -17
[ 4812.864873] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (-17=
)
[ 4812.865226] nvme nvme0: NVME-FC{0}: Reconnect attempt in 1 seconds
[ 4812.879761] (NULL device *): {0:0} Association deleted
[ 4812.896413] (NULL device *): {0:0} Association freed
[ 4812.896821] (NULL device *): Disconnect LS failed: No Association
[ 4813.911770] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN
"blktests-subsystem-1"
[ 4813.916771] (NULL device *): {0:0} Association created

--
Best Regards,
  Yi Zhang


--=20
Best Regards,
  Yi Zhang


