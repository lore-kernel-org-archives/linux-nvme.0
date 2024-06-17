Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF48EC27C6E
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6AX3By5ALInu2k2xHW96hZyvzPFm5n2pW8o2Mv602JQ=; b=ZOhzOeeB8cWs7MQYR2uBaU3Apw
	+zO0Kl2fBqP4HhEDiq8eSbsugxuCgBTqMNPLtIiqECIYd62hPGz7u4Ihn8slU8vZ8CzKTw279dfG9
	x6dXZXews26eN0YGGkbjU7/pi54AxPIZzEyp/Mqnb6P+ILY0VuDbN4K+9VwRFAQu7PyOj2iFiP/kE
	hQSJz0CiAlhf1dzsZC0oSSzc3XprMgxUoxdpDqn1NI6HCg4ykKbs2eC6jFdF9VZ/bB1Om45jW6cIE
	qs5El43LdJ8xH16HVLi5uJWcpXjCEFeOtj0F5g8oK6XjPWJnzmryUveFpYbTZcHNqAnLSrY0aiIpq
	CTFooIHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ8Zt-0000000A1YJ-1Ycl;
	Mon, 17 Jun 2024 09:23:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ8Zq-0000000A1WU-1TK0
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 09:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718616178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6AX3By5ALInu2k2xHW96hZyvzPFm5n2pW8o2Mv602JQ=;
	b=RTWKfFCvAL8RJGfbN1VQXqT+Yat2zJQX2Xq4TAgN+DwJhdhh1BZ7/6zIuMB+jjVecXVSE+
	muFXTAO2CHxjHiTXCFmPLlZGdVDaQrFCXDX3nrr7lJ7Gr0gfsK+ewhO2P6Qy2MjQasVXy9
	Nroe4z5U1ccA2ZxfbA6VDSZjakWC2HE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-hj_7fCJYM-2ml_NcrtCsgg-1; Mon, 17 Jun 2024 05:22:57 -0400
X-MC-Unique: hj_7fCJYM-2ml_NcrtCsgg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7024261bb31so3986247b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Jun 2024 02:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616175; x=1719220975;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AX3By5ALInu2k2xHW96hZyvzPFm5n2pW8o2Mv602JQ=;
        b=PxMT88T2qvShFux3n90UIgFoW3a5ulg8zkYjuCIjJJkpqu2flxcNtAa/6Xl3WDU40E
         Afk+nYFaJH8askyZU+bGFw+IjsrdS5H3BRlniaiZrlgZsUPI7Of7Nx19U7tOwtcMf7/Q
         VDcNMHNwnRCztdZBlehNJoocePsK1/1+GV7eicMU/HYYPgxwzdBDlj9DsadnMqDinQpv
         kN61XM79EYEG9JIplqDoELwlTqWQKnwiWBC7EfH+7q4Nze8cOqo4OIg3gcQe4TTrJd8K
         HozKEwQKCtCbgXenvJBA7MqfVPrES8ia1buqdFGlSzK702o7RAJ5Wdv8cn3sxPENWrpP
         p2Kg==
X-Gm-Message-State: AOJu0YwvRqbZ6Zg8LM/2Cwkfx/cZLN9o9uIlrTp2snv8Q8e0GX4DFPgP
	Lx0Mglc1zY3+fboHA+KIp7rf0hAUy2MOs/6HvHJ/Ptb108EFI1Wbf3hbshBm/eiyF1GUICSrf4f
	ywOrUVwVfyW6RTY5NTFp88sWAhA/BfwsWDKtX8ffcuiseVMIiRLmR21TiKcWBb8vxfQzRF+eg21
	OGVSnFZb4TasCqIj2bbwVzsKM6WcbOJg5/fUAuZsy0Y679VWIibf1q
X-Received: by 2002:a05:6a20:9150:b0:1b6:dd1e:da3c with SMTP id adf61e73a8af0-1bae7b953dbmr10899047637.0.1718616175056;
        Mon, 17 Jun 2024 02:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz8Z+9aroONe0tTFX6B5cL7fBwrYCdja71DrTusNmlaIeFyOpxeEPRM6ax8ukBqIh0c21Ua+M7y9jMyfm8J+w=
X-Received: by 2002:a05:6a20:9150:b0:1b6:dd1e:da3c with SMTP id
 adf61e73a8af0-1bae7b953dbmr10899029637.0.1718616174506; Mon, 17 Jun 2024
 02:22:54 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 17 Jun 2024 17:22:42 +0800
Message-ID: <CAHj4cs_o_8hhGK9PUhqX-OV3SqE2i0y0j4f5x2LVuWWx_cHJ2w@mail.gmail.com>
Subject: [bug report] Oops: general protection fault at RIP:
 0010:__nvmet_fc_free_assocs+0xbe/0x450 [nvmet_fc]
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Daniel Wagner <dwagner@suse.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_022302_497651_E4FAC861 
X-CRM114-Status: UNSURE (   8.23  )
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

I reproduced this Oops with the latest linux-block/for-next, please
help check it, thanks.

Reproducer:
1. start blktests nvme/fc nvme/010
#NVMET_TRTYPES="fc"   NVMET_BLKDEV_TYPES="device file" ./check nvme/010
2. remove nvme-fcloop module during step 1
#modprobe -fr nvme-fcloop

[root@storageqe-36 ~]# [  379.825335] run blktests nvme/010 at
2024-06-17 05:07:56
[  380.086109] loop0: detected capacity change from 0 to 2097152
[  380.133663] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  380.291299] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN
"blktests-subsystem-1"
[  380.306046] (NULL device *): {0:0} Association created
[  380.313109] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  380.341490] nvme nvme0: NVME-FC{0}: controller connect complete
[  380.347581] nvme nvme0: NVME-FC{0}: new ctrl: NQN
"blktests-subsystem-1", hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  380.533175] nvme nvme1: NVME-FC{1}: create association : host wwpn
0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[  380.548056] (NULL device *): {0:1} Association created
[  380.553539] nvmet: creating discovery controller 2 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
[  380.572058] nvme nvme1: NVME-FC{1}: controller connect complete
[  380.578020] nvme nvme1: NVME-FC{1}: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", hostnqn:
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333
[  380.601163] nvme nvme1: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[  380.628574] (NULL device *): {0:1} Association deleted
[  380.650886] (NULL device *): {0:1} Association freed
[  380.655990] (NULL device *): Disconnect LS failed: No Association
[  384.696520] nvme nvme0: NVME-FC{0}: io failed due to lldd error 6
[  384.696654] I/O error, dev nvme0c0n1, sector 1155648 op 0x1:(WRITE)
flags 0x2008800 phys_seg 1 prio class 0
[  384.703449] nvme nvme0: NVME-FC{0}: transport association event:
transport detected io error
[  384.703516] I/O error, dev nvme0c0n1, sector 300760 op 0x1:(WRITE)
flags 0x2008800 phys_seg 1 prio class 0
[  384.712717] I/O error, dev nvme0c0n1, sector 61648 op 0x1:(WRITE)
flags 0x2008800 phys_seg 1 prio class 0
[  384.721176] nvme nvme0: NVME-FC{0}: resetting controller
[  384.730918] I/O error, dev nvme0c0n1, sector 1578936 op 0x1:(WRITE)
flags 0x2008800 phys_seg 1 prio class 0
[  384.755598] block nvme0n1: no usable path - requeuing I/O
[  384.761125] block nvme0n1: no usable path - requeuing I/O
[  384.766630] block nvme0n1: no usable path - requeuing I/O
[  384.772129] block nvme0n1: no usable path - requeuing I/O
[  384.777589] block nvme0n1: no usable path - requeuing I/O
[  384.783045] block nvme0n1: no usable path - requeuing I/O
[  384.788497] block nvme0n1: no usable path - requeuing I/O
[  384.793945] block nvme0n1: no usable path - requeuing I/O
[  384.799397] block nvme0n1: no usable path - requeuing I/O
[  384.804855] block nvme0n1: no usable path - requeuing I/O
[  384.812886] (NULL device *): {0:0} Association deleted
[  384.829079] nvme nvme0: NVME-FC{0}: create association : host wwpn
0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN
"blktests-subsystem-1"
[  384.842123] (NULL device *): queue 0 connect admin queue failed (-111).
[  384.848762] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (-111)
[  384.855671] nvme nvme0: NVME-FC{0}: Reconnect attempt in 2 seconds
[  384.929756] (NULL device *): {0:0} Association freed
[  384.934768] (NULL device *): Disconnect LS failed: No Association
[  384.936317] nvme nvme0: NVME-FC{0}: controller connectivity lost.
Awaiting Reconnect
[  385.186846] nvme nvme0: NVME-FC{0}: transport unloading: deleting ctrl
[  385.193712] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[  385.201319] block nvme0n1: no available path - failing I/O
[  385.206970] block nvme0n1: no available path - failing I/O
[  385.212548] block nvme0n1: no available path - failing I/O
[  385.218115] block nvme0n1: no available path - failing I/O
[  385.223642] block nvme0n1: no available path - failing I/O
[  385.229172] block nvme0n1: no available path - failing I/O
[  385.234689] block nvme0n1: no available path - failing I/O
[  385.240210] block nvme0n1: no available path - failing I/O
[  385.245732] block nvme0n1: no available path - failing I/O
[  385.251262] block nvme0n1: no available path - failing I/O
[  385.266448] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  385.273767] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  385.280951] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  385.288134] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  385.295313] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  385.302487] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  385.309907]  nvme0n1: unable to read partition table
[  385.325784] Buffer I/O error on dev nvme0n1, logical block 262128,
async page read
[  385.510642] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000019: 0000 [#1] PREEMPT SMP KASAN
NOPTI
[  385.522546] KASAN: null-ptr-deref in range
[0x00000000000000c8-0x00000000000000cf]
[  385.530111] CPU: 30 PID: 5507 Comm: rm Kdump: loaded Not tainted
6.10.0-rc3+ #1
[  385.537418] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.21.2 02/19/2024
[  385.544982] RIP: 0010:__nvmet_fc_free_assocs+0xbe/0x450 [nvmet_fc]
[  385.551171] Code: e8 67 01 4d d8 5a 85 c0 0f 85 b8 02 00 00 48 8d
83 c8 00 00 00 48 89 c2 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 48
c1 ea 03 <80> 3c 02 00 0f 85 71 03 00 00 48 8b 83 c8 00 00 00 48 8d 68
d8 48
[  385.569915] RSP: 0018:ffffc900045cf940 EFLAGS: 00010202
[  385.575140] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffffffff36da9c2
[  385.582275] RDX: 0000000000000019 RSI: ffffffff9ad8a620 RDI: ffffffff9b6d4e10
[  385.589406] RBP: 0000000000000246 R08: 0000000000000000 R09: 0000000000000001
[  385.596540] R10: ffffffff9e7a30e7 R11: 0000000000000001 R12: ffff88810308cba0
[  385.603671] R13: ffff88810308cba8 R14: ffffffffc20ab220 R15: ffffffffc20ab220
[  385.610803] FS:  00007fecfb82a740(0000) GS:ffff888e3f800000(0000)
knlGS:0000000000000000
[  385.618888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  385.624635] CR2: 00005589ddf71068 CR3: 000000039e44c003 CR4: 00000000007706f0
[  385.631767] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  385.638901] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  385.646033] PKRU: 55555554
[  385.648745] Call Trace:
[  385.651200]  <TASK>
[  385.653305]  ? show_trace_log_lvl+0x1b0/0x2f0
[  385.657663]  ? show_trace_log_lvl+0x1b0/0x2f0
[  385.662027]  ? nvmet_fc_remove_port+0x1b7/0x240 [nvmet_fc]
[  385.667517]  ? __die_body.cold+0x8/0x12
[  385.671355]  ? die_addr+0x46/0x70
[  385.674675]  ? exc_general_protection+0x14f/0x250
[  385.679385]  ? asm_exc_general_protection+0x26/0x30
[  385.684271]  ? __nvmet_fc_free_assocs+0xbe/0x450 [nvmet_fc]
[  385.689850]  ? do_raw_spin_trylock+0xb4/0x180
[  385.694209]  ? __pfx___nvmet_fc_free_assocs+0x10/0x10 [nvmet_fc]
[  385.700216]  ? mark_held_locks+0x94/0xe0
[  385.704142]  ? _raw_spin_unlock_irqrestore+0x57/0x80
[  385.709109]  nvmet_fc_remove_port+0x1b7/0x240 [nvmet_fc]
[  385.714419]  nvmet_disable_port+0x11e/0x1b0 [nvmet]
[  385.719316]  nvmet_port_subsys_drop_link+0x239/0x2f0 [nvmet]
[  385.724994]  ? __pfx_nvmet_port_subsys_drop_link+0x10/0x10 [nvmet]
[  385.731190]  configfs_unlink+0x383/0x7a0
[  385.735116]  vfs_unlink+0x299/0x810
[  385.738607]  ? lookup_one_qstr_excl+0x23/0x150
[  385.743054]  do_unlinkat+0x485/0x600
[  385.746631]  ? __pfx_do_unlinkat+0x10/0x10
[  385.750732]  ? 0xffffffff97c00000
[  385.754051]  ? __might_fault+0x9d/0x120
[  385.757890]  ? strncpy_from_user+0x75/0x240
[  385.762076]  ? getname_flags.part.0+0xb7/0x440
[  385.766523]  __x64_sys_unlinkat+0x109/0x1e0
[  385.770707]  do_syscall_64+0x92/0x180
[  385.774372]  ? do_syscall_64+0x9e/0x180
[  385.778211]  ? lockdep_hardirqs_on+0x78/0x100
[  385.782572]  ? do_syscall_64+0x9e/0x180
[  385.786414]  ? do_user_addr_fault+0x447/0xac0
[  385.790779]  ? reacquire_held_locks+0x213/0x4e0
[  385.795311]  ? do_user_addr_fault+0x447/0xac0
[  385.799673]  ? find_held_lock+0x34/0x120
[  385.803596]  ? local_clock_noinstr+0xd/0xe0
[  385.807783]  ? __lock_release.isra.0+0x4ac/0x9e0
[  385.812402]  ? __pfx___lock_release.isra.0+0x10/0x10
[  385.817366]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  385.822159]  ? __up_read+0x1f8/0x730
[  385.825739]  ? __pfx___up_read+0x10/0x10
[  385.829666]  ? do_user_addr_fault+0x4c5/0xac0
[  385.834023]  ? do_user_addr_fault+0x4c5/0xac0
[  385.838385]  ? rcu_is_watching+0x15/0xb0
[  385.842309]  ? clear_bhb_loop+0x25/0x80
[  385.846146]  ? clear_bhb_loop+0x25/0x80
[  385.849987]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  385.855040] RIP: 0033:0x7fecfb9311eb
[  385.858619] Code: 77 05 c3 0f 1f 40 00 48 8b 15 41 ac 0d 00 f7 d8
64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 07 01 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 15 ac 0d 00 f7 d8 64 89
01 48
[  385.877365] RSP: 002b:00007ffce2247cf8 EFLAGS: 00000206 ORIG_RAX:
0000000000000107
[  385.884929] RAX: ffffffffffffffda RBX: 00005589ddf70e10 RCX: 00007fecfb9311eb
[  385.892063] RDX: 0000000000000000 RSI: 00005589ddf6fbf0 RDI: 00000000ffffff9c
[  385.899193] RBP: 00007ffce2247dd0 R08: 00005589ddf6fbf0 R09: 00007ffce2247e3c
[  385.906327] R10: 00005589ddf6c010 R11: 0000000000000206 R12: 00005589ddf6fb60
[  385.913459] R13: 0000000000000000 R14: 00007ffce2247e40 R15: 0000000000000000
[  385.920596]  </TASK>
[  385.922783] Modules linked in: nvmet_fc nvmet nvme_keyring
nvme_fabrics nvme_core nvme_auth rfkill sunrpc intel_rapl_msr
intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
isst_if_common skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel kvm mgag200 rapl ipmi_ssif vfat dell_smbios intel_cstate
iTCO_wdt iTCO_vendor_support fat dcdbas dell_wmi_descriptor wmi_bmof
intel_uncore i2c_algo_bit pcspkr tg3 mei_me i2c_i801 mei i2c_smbus
lpc_ich intel_pch_thermal nd_pmem ipmi_si dax_pmem nd_btt
acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler fuse loop
nfnetlink xfs sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ahci
libahci ghash_clmulni_intel megaraid_sas libata wmi nfit libnvdimm
dm_mirror dm_region_hash dm_log dm_mod [last unloaded: nvme_fc]

-- 
Best Regards,
  Yi Zhang


