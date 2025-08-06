Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7357FC87FD3
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1xYLpP2qyd+MRQOpf5NC9eS/MsXIl2qcFRd3haePg58=; b=m340i+wGdcHmQRvbtnChG4Ptiq
	HoUxVLVlFc2qSIRLEceJvSu+FWCkXZsFSMxjEzrexPNdXN+L/o/0hjR8TsT612RUHaDB4feyTlgh2
	mlJ5OZdrgSsDR77a+5dfkTQqD/58dOZ+A82lLAsJWoXfY9w5RVthzNqeXFQQFVSaTI4oSEQ9/ERI8
	CT/ifsowuQgH/EexE7pz4vrpRgp00nQXTnsPsnoeygROGd09XeKY0i0u2Xm5djJ+fiPY5IWN27jYY
	bCpR+p1emRUkxN8IahivY2yVVOw4cQ8HmTehiv8tpVujWDtvr/NT/nxIh9n5qT++5gELXZVKNuyCZ
	KvgXxLhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujgeX-0000000FiRK-0okk;
	Wed, 06 Aug 2025 16:06:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujgOK-0000000FfGr-3wrF
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 15:49:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754495363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1xYLpP2qyd+MRQOpf5NC9eS/MsXIl2qcFRd3haePg58=;
	b=DmN9KVV7Xt68cUz8qD196GZRvbDFABK5XJwbCd8hCWVKH3aA742M1WCCAzDBgnJY7O5XSq
	cGqkhLoM9HxcLwZ2WamuPAjihmRZc2IklgB5zdMIia/yDQ6xxtKERM+Us8V/tm3O6OWHBA
	SPhuQqqKqTkrcvDqVUMAm319kk/nztQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-ShZrqchQMsm23dPjHh5Kjw-1; Wed, 06 Aug 2025 11:49:22 -0400
X-MC-Unique: ShZrqchQMsm23dPjHh5Kjw-1
X-Mimecast-MFC-AGG-ID: ShZrqchQMsm23dPjHh5Kjw_1754495361
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55b995be1e8so10817e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 06 Aug 2025 08:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495361; x=1755100161;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xYLpP2qyd+MRQOpf5NC9eS/MsXIl2qcFRd3haePg58=;
        b=lcd9mw1sOI0tJqH9oUkh6au2GUAhuS+4cuJGS12aZG5MgIUerxU7LfViYXlq3M9Gmr
         x11PyYO5qeBBV3A1bbfPU6s7SbSvSsFPz5NtZynbbMPfhkVH/fctBPAB/KCUbcLtFkZL
         Bt9/PHJaBTGILNdHVhFchUuMxXSv9YqLMJvJKP3tx/IQrQjbBAHsZrYWxltFw3//ooY5
         Qk+EJ2/gVZCwVMQoyYXERXJrNps4I80GrdriG3cgQb9qArPgPvUl/bI86Lj5gEVyX6YB
         bUvpQKau1xBZMLu0nTvlwszLagx6pBruI4o3QCCv5a3cVCJkzQz9e+od8BHPiEqESkVA
         +tPA==
X-Forwarded-Encrypted: i=1; AJvYcCWvcYK72Aa1Ii97IEgZua0PT61dC86g/K7jt8q3pWBiWNU0KJtMejNOOFz49qReYABpTF/71HSaCIwc@lists.infradead.org
X-Gm-Message-State: AOJu0Ywcwdr47SJvLebX9aeCczQlD1rqC9lPLzjR8hImYc0e12cVH+KF
	Aw/g0FBNTnwtE6z77T56uGrjVWvgmXrQTO51iLICRdC2aRLyqlqFZCuxUEA1zd4iHDgWY+tlWA5
	I3NspUQ2K4EPhum+cB0td0z7z4XEQOMahXqj54LsJAGnZ0rUT1Pc2hRTiVxpIxcU2HtsHGrZ1iV
	8LbDRH+f5dFZeKSg6tB2LV8hG1tNiTznDUj3WEI4TTytc=
X-Gm-Gg: ASbGncvoD4kPp+dN6XCSCFFIdH3OmmxOQ8UYVQdAM6ezEfxALfKSuzh+tmnLpyFruFq
	ax+THkWwGITGp6G/Es0fTQnVDB3rMxqbVdB6/cmP8ieXKbJ4le3btAT9ArL7plibsVJWAmHozQc
	QJ2c3QgFJXSTwVbt3H93RVkw==
X-Received: by 2002:a05:651c:b0f:b0:310:81a0:64f7 with SMTP id 38308e7fff4ca-333813dd76fmr7985471fa.24.1754495360543;
        Wed, 06 Aug 2025 08:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Ps4UsBdSGMYTnGoiWrmm0YAe8TsSbYACYGHQihcEec+VGAXNFGyHViDPtF13nSur1Z1Q3ZXdXn97Y2qkIVc=
X-Received: by 2002:a05:651c:b0f:b0:310:81a0:64f7 with SMTP id
 38308e7fff4ca-333813dd76fmr7985351fa.24.1754495360059; Wed, 06 Aug 2025
 08:49:20 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 6 Aug 2025 23:49:07 +0800
X-Gm-Features: Ac12FXxBvb7dCz1aBB7yP7U4S3pII2LP0y0hOi4wSKLuoj1-ysd4Fbjpz21zYMQ
Message-ID: <CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com>
Subject: [bug report] blktests nvme/005 lead kernel panic on the latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L1ZEgn8lB3nbUKON8Rn9gbASVeVEmOnrmA3iJLp83lc_1754495361
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_084925_053723_1A572088 
X-CRM114-Status: UNSURE (   8.81  )
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

I found this panic issue on the latest linux-block/for-next, please
help check it and let me know if you need any info/testing for it,
thanks

commit: 20c74c073217 (HEAD -> for-next, origin/for-next) Merge branch
'block-6.17' into for-next
reproducer: blktests nvme/loop or nvme/tcp nvme/005

console log:
[  341.092092] loop: module loaded
[  341.246981] run blktests nvme/005 at 2025-08-06 15:32:53
[  341.537716] loop0: detected capacity change from 0 to 2097152
[  341.594066] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  341.679693] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  341.931127] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  341.959026] nvme nvme1: creating 80 I/O queues.
[  342.105359] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  342.256079] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  342.850745] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  342.858886] nvme nvme1: creating 80 I/O queues.
[  343.254225] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  343.539107] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  343.711101] block nvme1n1: no available path - failing I/O
[  343.711476] block nvme1n1: no available path - failing I/O
[  343.711691] Buffer I/O error on dev nvme1n1, logical block 262143,
async page read
[  348.367529] Unable to handle ker
** replaying previous printk message **
[  348.367529] Unable to handle kernel paging request at virtual
address dfff800000000032
[  348.367589] KASAN: null-ptr-deref in range
[0x0000000000000190-0x0000000000000197]
[  348.367593] Mem abort info:
[  348.367595]   ESR = 0x0000000096000005
[  348.367597]   EC = 0x25: DABT (current EL), IL = 32 bits
[  348.367601]   SET = 0, FnV = 0
[  348.367603]   EA = 0, S1PTW = 0
[  348.367606]   FSC = 0x05: level 1 translation fault
[  348.367608] Data abort info:
[  348.367610]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[  348.367612]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  348.367615]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  348.367618] [dfff800000000032] address between user and kernel address ranges
[  348.367758] Internal error: Oops: 0000000096000005 [#1]  SMP
[  348.444121] Modules linked in: loop nvmet(-) rfkill sunrpc mlx5_ib
ib_uverbs macsec mgag200 acpi_ipmi ib_core ipmi_ssif arm_spe_pmu
i2c_algo_bit mlx5_fwctl fwctl ipmi_devintf ipmi_msghandler arm_cmn
arm_dmc620_pmu vfat fat arm_dsu_pmu cppc_cpufreq fuse xfs mlx5_core
nvme nvme_core mlxfw nvme_keyring ghash_ce tls sbsa_gwdt nvme_auth
hpwdt psample pci_hyperv_intf i2c_designware_platform xgene_hwmon
i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod [last
unloaded: nvmet_tcp]
[  348.486730] CPU: 53 UID: 0 PID: 7580 Comm: modprobe Not tainted
6.16.0+ #3 PREEMPT_{RT,(full)}
[  348.495418] Hardware name: HPE ProLiant RL300 Gen11/ProLiant RL300
Gen11, BIOS 1.60 03/07/2024
[  348.504018] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  348.510969] pc : kasan_byte_accessible+0xc/0x20
[  348.515492] lr : __kasan_check_byte+0x20/0x70
[  348.519839] sp : ffff8000c07679d0
[  348.523142] x29: ffff8000c07679d0 x28: ffff0800b09d29b0 x27: 0000000000000190
[  348.530269] x26: ffffd1b95babfe28 x25: 0000000000000000 x24: 0000000000000002
[  348.537395] x23: 0000000000000001 x22: 0000000000000000 x21: ffffd1b95b1e89dc
[  348.544521] x20: 0000000000000190 x19: 0000000000000190 x18: 0000000000000000
[  348.551647] x17: ffffd1b922a23714 x16: ffffd1b95bc6e288 x15: ffffd1b95b2e9248
[  348.558773] x14: ffffd1b922a236a8 x13: ffffd1b95d7d5c2c x12: ffff7000180ecf1b
[  348.565900] x11: 1ffff000180ecf1a x10: ffff7000180ecf1a x9 : 0000000000000035
[  348.573026] x8 : ffff07ffdb8e0000 x7 : 0000000000000000 x6 : ffffd1b95babfe28
[  348.580152] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
[  348.587278] x2 : 0000000000000000 x1 : dfff800000000000 x0 : 0000000000000032
[  348.594405] Call trace:
[  348.596840]  kasan_byte_accessible+0xc/0x20 (P)
[  348.601361]  lock_acquire.part.0+0x5c/0x2b8
[  348.605536]  lock_acquire+0x9c/0x190
[  348.609102]  down_write_nested+0x70/0xc0
[  348.613015]  __simple_recursive_removal+0x80/0x4b8
[  348.617797]  simple_recursive_removal+0x1c/0x30
[  348.622317]  debugfs_remove+0x60/0x90
[  348.625971]  nvmet_debugfs_subsys_free+0x3c/0x60 [nvmet]
[  348.631289]  nvmet_subsys_free+0x50/0x108 [nvmet]
[  348.635995]  nvmet_subsys_put+0x8c/0x100 [nvmet]
[  348.640614]  nvmet_exit_discovery+0x20/0x38 [nvmet]
[  348.645492]  nvmet_exit+0x1c/0x68 [nvmet]
[  348.649502]  __do_sys_delete_module.constprop.0+0x298/0x548
[  348.655065]  __arm64_sys_delete_module+0x38/0x58
[  348.659672]  invoke_syscall.constprop.0+0x78/0x1f0
[  348.664455]  do_el0_svc+0x164/0x1e0
[  348.667933]  el0_svc+0x54/0x180
[  348.671065]  el0t_64_sync_handler+0xa0/0xe8
[  348.675239]  el0t_64_sync+0x1ac/0x1b0
[  348.678892] Code: d65f03c0 d343fc00 d2d00001 f2fbffe1 (38616800)
[  348.684976] ---[ end trace 0000000000000000 ]---
[  348.689583] Kernel panic - not syncing: Oops: Fatal exception
[  348.695319] SMP: stopping secondary CPUs
[  348.699383] Kernel Offset: 0x51b8daeb0000 from 0xffff800080000000
[  348.705465] PHYS_OFFSET: 0x80000000
[  348.708941] CPU features: 0x10000,00002e00,048098a1,0441720b
[  348.714590] Memory Limit: none
[  348.892994] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


-- 
Best Regards,
  Yi Zhang


