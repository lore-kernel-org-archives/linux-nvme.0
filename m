Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FA0C87FD2
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 04:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vlQLgpMIPslnn3hQtJTPn0usG3F027Ib7OnTFoeFLBA=; b=1ICGXX6gtzf5mZ6n21fCZ7rUrJ
	AkzjiVN7VivDUrEY5B4+4eL9Xp5PZzzKhgiiSRhmSQahH2CQd+PeQBysbABZwhZtW3muXQvfupFcb
	JZKV2oHvT4b9ngtztxCHkl9xuGc/X0YrYBDqk0hTm1kWIwUhHreAmSoqcaMuwoVvn1TrTsGiBR0+/
	Z1Mxawm+FDJdEMar9vghHcZxevN7DbGE1OJQzIzQeDIQpQfMEqUSHga8T+Mr4h8VbuEBXxORP1GGX
	lAYtfE5a+8eOy5+2sFpgMGQo1CQ9qk71puJ3GoKQUiXm1OVESTAaOqnCoZGuJ9wmsGAEmvZCLs5GO
	AMJnMjhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujsX8-0000000HGVW-3Xxt;
	Thu, 07 Aug 2025 04:47:18 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujsX6-0000000HGVA-2rKS
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 04:47:17 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so717947a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 06 Aug 2025 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754542035; x=1755146835; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vlQLgpMIPslnn3hQtJTPn0usG3F027Ib7OnTFoeFLBA=;
        b=WVroc6LlFZnfMHgFpkswu0qVmgP1vDQk+F+PVgir43l+N8ST5qfxhJF0ST03e/gdC6
         ixSl1B5FJuaw8xp1t0l/0lWeyjTPSQ5lL8TEnqw9loq1ZUvP0Dxev8j80NoTcV0lPtom
         8lfse1KrIeUmJUvl4Lwf6BCJxr0+OpnYPKXD+pIV31Idd5CIIKSF22aEQwn5btnhjXNT
         xIgTvuBw1NnpqgUXgR5YMYUgv2xkd01sBUTSxSTiJ7NKDu/mIz8qoE0AwD6RDLrvvklO
         PHwDMFw0KUotvzY3tNhFI82ZF4Z/X6rXfV7SfZ4YorQrIwQxqmN4cHET5o2EGS4vlNkX
         0p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754542036; x=1755146836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlQLgpMIPslnn3hQtJTPn0usG3F027Ib7OnTFoeFLBA=;
        b=PY2GMl26KYQ2RoHZ373KQjbdLSdZnUdjD+tnn9hg8WfR0XSU9xz1dXGJ7OVtfgoe8O
         CSXTdtff+QDPdG6GinxNQCOIV9NeB1/eK4vwc5bdQwoexYSMH1IvghF/+xh3wSAVxyMN
         m32GF4q0wAC1BjLA2MLNFeTZXKadDWu7OV+ArmRZmoHqbUsJRar7aQGnqkLSFAlkCve7
         IcwNEGGn4FXKdLRFr9N80ch6Ajqobd7vyk1XFuTCxjX3LwZKkvMF22F1lo1ECpCPZc2x
         1v9WEelPUMwmaF+5jtY2z255n+BEK1gGVpOIaRfhxfUB8U/o9aBzM0H9vCSCfNyI+HMS
         kFhw==
X-Forwarded-Encrypted: i=1; AJvYcCXuYAd8n/qn4dvcR9fLh8ZNEiilJoWm0q1VVdJzPOe5vHXBtsbE0ZPadAorhwzQ8hjgwP6woB2HaTvn@lists.infradead.org
X-Gm-Message-State: AOJu0YwNX1T2rbo2A7jfDzM2331Y9uyR8jh01fDWTQRARtiRp8qZT7YP
	R9Ppsyx9LMtM5mhE0xAOjoLb8iVK2JxAqg3EG108Zbu6VZuLr1C1kj5G68qpp7KLik0=
X-Gm-Gg: ASbGnctzto9u+tgv5360GKIKbpjfh6UKPLOIcbVmJ+l/lH3NeewMJMvx+/yJfhFV//3
	LRQICY5xkCJawefStuIMWZamz5pk0D3R982oP/KLUQ+hgZ6OS681WcwNQS5Fc/2qo3L7piylPjA
	/IdFoUYmL97kSgOdRJZGjut2o2uKvaalfTiqbwTTNKEGN7coNOxGVZrDXWBsP0O7DuUDLGf3feS
	z+oSy/beyd2ppIZXKyjkqU5NkofpnmDb0Y9ExfIdBtAFkiPfstzfMsRWNv+Hmlwj3zKHA8rFG7o
	vG+j6hCn+m9llY5Hq5Fa/+M+A7Lw4T9IC1ZUVgZyXpjAwZkmnwFeQytSAuMs5kd+DFRpiOBdRJw
	FwbwQGvIX1qSjPiVcvMRHNgBLx40=
X-Google-Smtp-Source: AGHT+IFUP7dlE4sVpZ3v1ufrrSMy4+GgZPUi/DJ1NHLKMRVCNAZX52noXuplhuquSE1VrGT/nCVhDg==
X-Received: by 2002:a17:90b:3e86:b0:31e:c8fc:e62a with SMTP id 98e67ed59e1d1-32167593e1emr7326656a91.35.1754542035514;
        Wed, 06 Aug 2025 21:47:15 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::eb28])
        by smtp.googlemail.com with UTF8SMTPSA id 41be03b00d2f7-b422bb0a4b0sm14744943a12.59.2025.08.06.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 21:47:14 -0700 (PDT)
Date: Wed, 6 Aug 2025 21:47:13 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [bug report][regression] blktests nvme/005 lead kernel panic on
 the latest linux-block/for-next
Message-ID: <20250807044713.GA1064239-mkhalfella@purestorage.com>
References: <CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com>
 <CAHj4cs-8kE-zBZF6smU4YfxaV7M7BoRG_7m6UE175HLYB_ZubQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHj4cs-8kE-zBZF6smU4YfxaV7M7BoRG_7m6UE175HLYB_ZubQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_214716_781071_088A3858 
X-CRM114-Status: GOOD (  21.01  )
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

Hello Yi,

Thank you for reporting this issue. Looks like this is a regression
introduced by 528589947c180 ("nvmet: initialize discovery subsys after
debugfs is initialized") as you pointed out. nvmet_exit() should exit
discovery subsystem first before destroying debugfs. I will send a patch
with the fix shortly.

Thank,
Mohamed Khalfella

On 2025-08-07 11:20:08 +0800, Yi Zhang wrote:
> I just reviewed the recent commits merged to linux-block/for-next,
> seems it was introduced from the below commit:
> 
> 528589947c18 nvmet: initialize discovery subsys after debugfs is initialized
> 
> On Wed, Aug 6, 2025 at 11:49 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > Hello
> >
> > I found this panic issue on the latest linux-block/for-next, please
> > help check it and let me know if you need any info/testing for it,
> > thanks
> >
> > commit: 20c74c073217 (HEAD -> for-next, origin/for-next) Merge branch
> > 'block-6.17' into for-next
> > reproducer: blktests nvme/loop or nvme/tcp nvme/005
> >
> > console log:
> > [  341.092092] loop: module loaded
> > [  341.246981] run blktests nvme/005 at 2025-08-06 15:32:53
> > [  341.537716] loop0: detected capacity change from 0 to 2097152
> > [  341.594066] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [  341.679693] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > [  341.931127] nvmet: Created nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > [  341.959026] nvme nvme1: creating 80 I/O queues.
> > [  342.105359] nvme nvme1: mapped 80/0/0 default/read/poll queues.
> > [  342.256079] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
> > 127.0.0.1:4420, hostnqn:
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > [  342.850745] nvmet: Created nvm controller 2 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > [  342.858886] nvme nvme1: creating 80 I/O queues.
> > [  343.254225] nvme nvme1: mapped 80/0/0 default/read/poll queues.
> > [  343.539107] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> > [  343.711101] block nvme1n1: no available path - failing I/O
> > [  343.711476] block nvme1n1: no available path - failing I/O
> > [  343.711691] Buffer I/O error on dev nvme1n1, logical block 262143,
> > async page read
> > [  348.367529] Unable to handle ker
> > ** replaying previous printk message **
> > [  348.367529] Unable to handle kernel paging request at virtual
> > address dfff800000000032
> > [  348.367589] KASAN: null-ptr-deref in range
> > [0x0000000000000190-0x0000000000000197]
> > [  348.367593] Mem abort info:
> > [  348.367595]   ESR = 0x0000000096000005
> > [  348.367597]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [  348.367601]   SET = 0, FnV = 0
> > [  348.367603]   EA = 0, S1PTW = 0
> > [  348.367606]   FSC = 0x05: level 1 translation fault
> > [  348.367608] Data abort info:
> > [  348.367610]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> > [  348.367612]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [  348.367615]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [  348.367618] [dfff800000000032] address between user and kernel address ranges
> > [  348.367758] Internal error: Oops: 0000000096000005 [#1]  SMP
> > [  348.444121] Modules linked in: loop nvmet(-) rfkill sunrpc mlx5_ib
> > ib_uverbs macsec mgag200 acpi_ipmi ib_core ipmi_ssif arm_spe_pmu
> > i2c_algo_bit mlx5_fwctl fwctl ipmi_devintf ipmi_msghandler arm_cmn
> > arm_dmc620_pmu vfat fat arm_dsu_pmu cppc_cpufreq fuse xfs mlx5_core
> > nvme nvme_core mlxfw nvme_keyring ghash_ce tls sbsa_gwdt nvme_auth
> > hpwdt psample pci_hyperv_intf i2c_designware_platform xgene_hwmon
> > i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod [last
> > unloaded: nvmet_tcp]
> > [  348.486730] CPU: 53 UID: 0 PID: 7580 Comm: modprobe Not tainted
> > 6.16.0+ #3 PREEMPT_{RT,(full)}
> > [  348.495418] Hardware name: HPE ProLiant RL300 Gen11/ProLiant RL300
> > Gen11, BIOS 1.60 03/07/2024
> > [  348.504018] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [  348.510969] pc : kasan_byte_accessible+0xc/0x20
> > [  348.515492] lr : __kasan_check_byte+0x20/0x70
> > [  348.519839] sp : ffff8000c07679d0
> > [  348.523142] x29: ffff8000c07679d0 x28: ffff0800b09d29b0 x27: 0000000000000190
> > [  348.530269] x26: ffffd1b95babfe28 x25: 0000000000000000 x24: 0000000000000002
> > [  348.537395] x23: 0000000000000001 x22: 0000000000000000 x21: ffffd1b95b1e89dc
> > [  348.544521] x20: 0000000000000190 x19: 0000000000000190 x18: 0000000000000000
> > [  348.551647] x17: ffffd1b922a23714 x16: ffffd1b95bc6e288 x15: ffffd1b95b2e9248
> > [  348.558773] x14: ffffd1b922a236a8 x13: ffffd1b95d7d5c2c x12: ffff7000180ecf1b
> > [  348.565900] x11: 1ffff000180ecf1a x10: ffff7000180ecf1a x9 : 0000000000000035
> > [  348.573026] x8 : ffff07ffdb8e0000 x7 : 0000000000000000 x6 : ffffd1b95babfe28
> > [  348.580152] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> > [  348.587278] x2 : 0000000000000000 x1 : dfff800000000000 x0 : 0000000000000032
> > [  348.594405] Call trace:
> > [  348.596840]  kasan_byte_accessible+0xc/0x20 (P)
> > [  348.601361]  lock_acquire.part.0+0x5c/0x2b8
> > [  348.605536]  lock_acquire+0x9c/0x190
> > [  348.609102]  down_write_nested+0x70/0xc0
> > [  348.613015]  __simple_recursive_removal+0x80/0x4b8
> > [  348.617797]  simple_recursive_removal+0x1c/0x30
> > [  348.622317]  debugfs_remove+0x60/0x90
> > [  348.625971]  nvmet_debugfs_subsys_free+0x3c/0x60 [nvmet]
> > [  348.631289]  nvmet_subsys_free+0x50/0x108 [nvmet]
> > [  348.635995]  nvmet_subsys_put+0x8c/0x100 [nvmet]
> > [  348.640614]  nvmet_exit_discovery+0x20/0x38 [nvmet]
> > [  348.645492]  nvmet_exit+0x1c/0x68 [nvmet]
> > [  348.649502]  __do_sys_delete_module.constprop.0+0x298/0x548
> > [  348.655065]  __arm64_sys_delete_module+0x38/0x58
> > [  348.659672]  invoke_syscall.constprop.0+0x78/0x1f0
> > [  348.664455]  do_el0_svc+0x164/0x1e0
> > [  348.667933]  el0_svc+0x54/0x180
> > [  348.671065]  el0t_64_sync_handler+0xa0/0xe8
> > [  348.675239]  el0t_64_sync+0x1ac/0x1b0
> > [  348.678892] Code: d65f03c0 d343fc00 d2d00001 f2fbffe1 (38616800)
> > [  348.684976] ---[ end trace 0000000000000000 ]---
> > [  348.689583] Kernel panic - not syncing: Oops: Fatal exception
> > [  348.695319] SMP: stopping secondary CPUs
> > [  348.699383] Kernel Offset: 0x51b8daeb0000 from 0xffff800080000000
> > [  348.705465] PHYS_OFFSET: 0x80000000
> > [  348.708941] CPU features: 0x10000,00002e00,048098a1,0441720b
> > [  348.714590] Memory Limit: none
> > [  348.892994] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
> 
> 
> 
> --
> Best Regards,
>   Yi Zhang
> 

