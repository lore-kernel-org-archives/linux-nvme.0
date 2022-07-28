Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75560C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 06:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YMyfoN/w1kaLd0h5/43TdKT1pSNbLQaH0mMN/ZaIT3o=; b=Mb1Glo5pussMMZfy4siAsGMc5C
	rEnyJ/OPZRT2I51557DS3d7ql+8b7a9kS28pYdAks+4M92HmozXcXfUDbQEA11KAXY1Xd1jp0Ucds
	tqCmtx4yRb9dCFX44YIkkHfzFhohYMKui+mbWAdJe88jt5YuTXd6W3lQsH2qVW/SdUSklAEJtEh7T
	q8NyN9yYXbgjcm35K/Qz2mJwmyubPsO42iz0u8+CFaKGkshw6xOGhAjRHjZNujGCenmklGfHvfW/+
	HXKg+/9LmAJyt1WAUdQvE4gqnMwVI8+8GPIdOF2dsIX4TPoGyFYOssqUlg/7ssTwQfT8VYo4rMBZu
	ZY1k5wqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGxQV-005Efq-2f; Thu, 28 Jul 2022 06:55:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGxQQ-005Eca-6j
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 06:55:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658991309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YMyfoN/w1kaLd0h5/43TdKT1pSNbLQaH0mMN/ZaIT3o=;
	b=PyFcHDX2HR1bV9YY6AMsFyjMG9XI1QfFx8ihwqg8eObxseScn5fmYsEv3x0juU54/WMXaR
	sxhIEaU7pICOMwO6Wo8k0lo6F//EWVxvM5FTfB4auUNc+wBHtHgfUrUdUDPSLdRkuzz5Dd
	UiZhVuHoRgJ4HCanUt4uLtBoifMAIw0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-9jweXOorPe64kJZZWkkU4Q-1; Thu, 28 Jul 2022 02:55:07 -0400
X-MC-Unique: 9jweXOorPe64kJZZWkkU4Q-1
Received: by mail-ed1-f69.google.com with SMTP id h15-20020a056402280f00b0043bd8412fe0so534219ede.16
        for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 23:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YMyfoN/w1kaLd0h5/43TdKT1pSNbLQaH0mMN/ZaIT3o=;
        b=sWhUM+78BEM60oChyOUt0cHV47iMbxUwfo9MXrzTYCw1vygAqDze51ofhN/XyedRja
         1UdQqvUtCGToqx6rF9Ne9/UH70PgV1Zd8YGSRPg4p6wORg5el5pgkNepFwwL2wXUKRm2
         06cUuDTIsBTKeDLP/cLG9QSYUGzhjM/GLMw0UYeUXIiOf7bNp/jUyve0tVBJbZww3UL3
         jgfVVXZRmI2gjafCRn/9Uy6nYOx9Cy6lzqklpvzbY///e4OflhUExo2dlHcZjRSRLMCl
         H241TagF4Xh7yX5xo4rCjwMiFmP2yuld0hLqYKGEEEsCxfsu7igE/WbfGw5INYBZdwMR
         607g==
X-Gm-Message-State: AJIora+zhQcNdPdnyygu+8hvnGU3AuIhE9gZ5a8aXspKfJH588dc4LWd
	z7yJ0RhL8zanLMcSUe4uoKGGB1OnubOnvTgXjptcjWVkk12IVOrT/fPhUlycPKolMRB2VS+AjPX
	3nFXUf7V4xeUXgJl+1AiZVcD/ObihiwlEZR3liWYEP54=
X-Received: by 2002:a17:906:8a49:b0:72b:3b8d:31c3 with SMTP id gx9-20020a1709068a4900b0072b3b8d31c3mr20447495ejc.279.1658991305468;
        Wed, 27 Jul 2022 23:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slEHWU7T+1tLBRuQXX9IEEUOe8FM0dgHXiMbYUDY0mDP32jd0wA12cxsg6Llf1uSnWh/kKjtX9mwDX0eiuk/k=
X-Received: by 2002:a17:906:8a49:b0:72b:3b8d:31c3 with SMTP id
 gx9-20020a1709068a4900b0072b3b8d31c3mr20447480ejc.279.1658991305093; Wed, 27
 Jul 2022 23:55:05 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 28 Jul 2022 14:54:53 +0800
Message-ID: <CAHj4cs8noK6oDUOKHoHSXQe349E0dJR+ZRq30tpEtofDwdJMDA@mail.gmail.com>
Subject: [bug report] blktests nvme-tcp nvme/030 failed and triggered lock issue
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_235514_364938_4E721B7C 
X-CRM114-Status: UNSURE (   6.67  )
X-CRM114-Notice: Please train this message.
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

Hello

Bellow issue triggered during blktests nvme-tcp on latest
linux-block/for-next, pls help check it, feel free to let me know if
you need any info/test, thanks.

# ./check nvme/030
nvme/030 (ensure the discovery generation counter is updated
appropriately) [passed]
    runtime    ...  2.717s
[root@ampere-hr350a-06 blktests]# nvme_trtype=tcp ./check nvme/030
nvme/030 (ensure the discovery generation counter is updated appropriately)
nvme/030 (ensure the discovery generation counter is updated
appropriately) [failed]
    runtime  2.717s  ...  1.694scp device: nvme1
    --- tests/nvme/030.out 2022-07-27 20:43:10.704087377 -0400
    +++ /root/blktests/results/nodev/nvme/030.out.bad 2022-07-28
02:38:26.314557736 -0400
    @@ -1,2 +1,4 @@
     Running nvme/030
    +failed to lookup subsystem for controller nvme0
    +failed to lookup subsystem for controller nvme1
     Test complete

[  173.623853] run blktests nvme/030 at 2022-07-28 02:49:15
[  173.954656] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  173.992755] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  174.113099] nvmet: creating discovery controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:7750c346-08d6-11e9-b83c-3c18a00bfe14.
[  174.140412] nvme nvme0: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
[  174.162016] nvme nvme0: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[  174.193900] nvme (1193) used greatest stack depth: 19744 bytes left
[  174.288051] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
[  174.378921] nvmet: creating discovery controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:7750c346-08d6-11e9-b83c-3c18a00bfe14.
[  174.401303] nvme nvme0: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
[  174.442193] nvmet: creating discovery controller 2 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:7750c346-08d6-11e9-b83c-3c18a00bfe14.
[  174.464311] nvme nvme1: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
[  174.482869] nvme nvme1: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[  174.604969] nvmet: creating nvm controller 3 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:7750c346-08d6-11e9-b83c-3c18a00bfe14.
[  174.628813] nvme nvme1: creating 32 I/O queues.
[  174.683730] nvme nvme1: mapped 32/0/0 default/read/poll queues.
[  174.727577] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[  174.792044] nvmet: connect request for invalid subsystem
blktests-subsystem-2!
[  174.800088] nvme nvme2: Connect Invalid Data Parameter, subsysnqn
"blktests-subsystem-2"
[  174.808520] nvme nvme2: failed to connect queue: 0 ret=16770
[  174.851351] nvmet: connect request for invalid subsystem
blktests-subsystem-2!
[  174.858985] nvme nvme2: Connect Invalid Data Parameter, subsysnqn
"blktests-subsystem-2"
[  174.867554] nvme nvme2: failed to connect queue: 0 ret=16770
[  174.877528] nvme nvme0: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[  175.044575] nvmet: creating discovery controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:7750c346-08d6-11e9-b83c-3c18a00bfe14.
[  175.066739] nvme nvme0: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
[  175.084539] nvme nvme0: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[  175.148957] nvme nvme1: starting error recovery
[  175.157084] nvmet_tcp: queue 1 unhandled state 5
[  175.164749] nvmet_tcp: queue 5 unhandled state 5
[  175.169652] nvmet_tcp: queue 6 unhandled state 5
[  175.174614] nvmet_tcp: queue 7 unhandled state 5
[  175.179513] nvmet_tcp: queue 8 unhandled state 5
[  175.184572] nvmet_tcp: queue 9 unhandled state 5
[  175.189472] nvmet_tcp: queue 10 unhandled state 5
[  175.194574] nvmet_tcp: queue 11 unhandled state 5
[  175.199559] nvmet_tcp: queue 12 unhandled state 5
[  175.204661] nvmet_tcp: queue 13 unhandled state 5
[  175.209643] nvmet_tcp: queue 14 unhandled state 5
[  175.214689] nvmet_tcp: queue 15 unhandled state 5
[  175.216170] nvmet_tcp: queue 33 unhandled state 5
[  175.219778] nvmet_tcp: queue 16 unhandled state 5
[  175.224191] nvmet_tcp: queue 32 unhandled state 5
[  175.229243] nvmet_tcp: queue 17 unhandled state 5
[  175.233593] nvmet_tcp: queue 31 unhandled state 5
[  175.238676] nvmet_tcp: queue 18 unhandled state 5
[  175.243045] nvmet_tcp: queue 30 unhandled state 5
[  175.248161] nvmet_tcp: queue 19 unhandled state 5
[  175.252488] nvmet_tcp: queue 29 unhandled state 5
[  175.257557] nvmet_tcp: queue 20 unhandled state 5
[  175.261948] nvmet_tcp: queue 28 unhandled state 5
[  175.267055] nvmet_tcp: queue 21 unhandled state 5
[  175.271392] nvmet_tcp: queue 27 unhandled state 5
[  175.276501] nvmet_tcp: queue 22 unhandled state 5
[  175.280835] nvmet_tcp: queue 26 unhandled state 5
[  175.284154] nvme nvme0: failed to connect socket: -111
[  175.285911] nvmet_tcp: queue 23 unhandled state 5
[  175.290276] nvmet_tcp: queue 25 unhandled state 5
[  175.295789] nvmet_tcp: queue 24 unhandled state 5
[  175.311047] sched: DL replenish lagged too much
[  175.320352] nvme nvme1: Reconnecting in 10 seconds...
[  175.645447] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  175.651871] ------------[ cut here ]------------
[  175.656530] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[  175.656546] WARNING: CPU: 4 PID: 1276 at kernel/locking/mutex.c:582
__mutex_lock+0x2f0/0x840
[  175.669936] Modules linked in: loop nvmet_tcp nvmet nvme_tcp
nvme_fabrics nvme_core mlx4_ib ib_uverbs ib_core mlx4_en rfkill sunrpc
vfat fat mlx4_core igb cppc_cpufreq acpi_ipmi ipmi_ssif ipmi_devintf
ipmi_msghandler fuse zram xfs libcrc32c sr_mod cdrom ast i2c_algo_bit
drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm_ttm_helper ttm uas crct10dif_ce ghash_ce drm sha2_ce
usb_storage sha256_arm64 sha1_ce sbsa_gwdt i2c_designware_platform
ahci_platform gpio_dwapb i2c_designware_core i2c_xgene_slimpro
libahci_platform gpio_generic xgene_hwmon dm_mod
[  175.721147] CPU: 4 PID: 1276 Comm: nvme Not tainted 5.19.0-rc8+ #2
[  175.727322] Hardware name: Lenovo HR350A            7X35CTO1WW
/HR350A     , BIOS hve104q-1.14 06/25/2020
[  175.737140] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  175.744094] pc : __mutex_lock+0x2f0/0x840
[  175.748097] lr : __mutex_lock+0x2f0/0x840
[  175.752097] sp : ffff8000145376f0
[  175.755402] x29: ffff8000145376f0 x28: ffff800014537b48 x27: ffff80000d50b000
[  175.762537] x26: ffff80000b9bd000 x25: 0000000000000000 x24: 0000000000000000
[  175.769670] x23: ffff8000026b5e44 x22: 0000000000000002 x21: 1ffff000028a6ef0
[  175.776805] x20: ffff80000a341520 x19: ffff000960e80290 x18: 000000000000001d
[  175.783939] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  175.791071] x14: 0000000000000000 x13: 0000000000000001 x12: ffff6016ca8893aa
[  175.798204] x11: 1fffe016ca8893a9 x10: ffff6016ca8893a9 x9 : ffff80000848a5f0
[  175.805339] x8 : ffff00b654449d4b x7 : 0000000000000001 x6 : ffff6016ca8893a9
[  175.812473] x5 : ffff00b654449d48 x4 : 1fffe00122e89801 x3 : dfff800000000000
[  175.819607] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00091744c000
[  175.826740] Call trace:
[  175.829178]  __mutex_lock+0x2f0/0x840
[  175.832834]  mutex_lock_nested+0x64/0xd4
[  175.836751]  nvme_tcp_stop_queue+0x54/0xf4 [nvme_tcp]
[  175.841803]  nvme_tcp_teardown_io_queues.part.0+0x94/0x284 [nvme_tcp]
[  175.848242]  nvme_tcp_delete_ctrl+0x54/0xd0 [nvme_tcp]
[  175.853379]  nvme_do_delete_ctrl+0x108/0x120 [nvme_core]
[  175.858713]  nvme_sysfs_delete+0xf0/0xfc [nvme_core]
[  175.863699]  dev_attr_store+0x40/0x70
[  175.867359]  sysfs_kf_write+0xe4/0x130
[  175.871105]  kernfs_fop_write_iter+0x224/0x3c4
[  175.875544]  new_sync_write+0x1f8/0x390
[  175.879376]  vfs_write+0x3e0/0x54c
[  175.882771]  ksys_write+0xf4/0x1e0
[  175.886166]  __arm64_sys_write+0x70/0xa0
[  175.890082]  invoke_syscall.constprop.0+0xd8/0x1d0
[  175.894870]  el0_svc_common.constprop.0+0xc8/0x2ac
[  175.899656]  do_el0_svc+0x40/0x80
[  175.902966]  el0_svc+0x5c/0x140
[  175.906101]  el0t_64_sync_handler+0xec/0x11c
[  175.910366]  el0t_64_sync+0x174/0x178
[  175.914023] irq event stamp: 14761
[  175.917416] hardirqs last  enabled at (14761): [<ffff800009005c3c>]
__free_object+0x478/0xb0c
[  175.925937] hardirqs last disabled at (14760): [<ffff800009005d88>]
__free_object+0x5c4/0xb0c
[  175.934455] softirqs last  enabled at (14506): [<ffff8000081e0c5c>]
__do_softirq+0x9cc/0x1018
[  175.942973] softirqs last disabled at (14431): [<ffff80000831e4c0>]
__irq_exit_rcu+0x230/0x5e0
[  175.951579] ---[ end trace 0000000000000000 ]---
[  175.960165] nvme nvme1: Property Set error: 880, offset 0x14

-- 
Best Regards,
  Yi Zhang


