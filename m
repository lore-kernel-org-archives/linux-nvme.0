Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A6CC87FCF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 03:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dTadTqrG8iNwOc+yT0n1n8HObBfxydvZi6TVc/fADw8=; b=zRh3BBbi4PaP4sWW7f96KIJFmi
	VJ0p4rdeE38n0U+tgTflvypvPLjhpIGZsGECV/ynKxiyOirsu5nwLndXyV17EOU1jJwPH7irJrQ9x
	eZgHG9r3WnY41wN0Q9on7l9voqhqCH/PrnFgZuCGhNkmIKzv27tLiyLMgRQa92ep/i0c2tah3AWMN
	7O6bGEiQ88GZ+7o/mR5DNLZNQTCZnO+NFhE9wYEPqzEutj3VAglVpsTJn29aYoJdLunxf5UN4EEqv
	5XdIAH0x7qOaTmY8Fb/7MKH5u+CtIUsA+MaKaqbWR00uNA0ytKp38FQsIF/pkPXW3LmA4DulDuK7o
	eoQ7NFmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrBA-0000000HCAn-3kjr;
	Thu, 07 Aug 2025 03:20:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrB6-0000000HCAM-3hQb
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 03:20:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754536826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTadTqrG8iNwOc+yT0n1n8HObBfxydvZi6TVc/fADw8=;
	b=SvHr4LAA9JTXXs0YFWhLBYzvKI5N7Cvd/obrAob33X5Lks+MN815EXSWFq/wF/db5ZSTWR
	18XPRpcialyrv6D2GE1qTHz+I8H6Drg+fAMDDCySLM3mM2V1yuHzDPNB5AfD7KzkbYKLK2
	2BvOaF6Rm4xy6f+wWnhCKBwt8Dt/pPA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-mDBG3_eUMQiRGVd4WYZ_4A-1; Wed, 06 Aug 2025 23:20:23 -0400
X-MC-Unique: mDBG3_eUMQiRGVd4WYZ_4A-1
X-Mimecast-MFC-AGG-ID: mDBG3_eUMQiRGVd4WYZ_4A_1754536822
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3323287983bso3716901fa.3
        for <linux-nvme@lists.infradead.org>; Wed, 06 Aug 2025 20:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754536822; x=1755141622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTadTqrG8iNwOc+yT0n1n8HObBfxydvZi6TVc/fADw8=;
        b=uWDUPXZN0qj4IjttVZ8uZvMqq7UPXfvrAsJjO0+qcVS9axnX7gHJrUP4tX9F8+OOOK
         +sLMrU/xE56iFbda31mtpSwkTSOz83vW5tybtsljOxLbaUOGdaB7dYLwUhv8f3pM3sQc
         81xGBCriikY5B0Ef3AOQvjt9ACjty3j+MNld2UiHX6M8K+Kf+VG+NVhD9VkRynVls7xA
         Ow8A339Mj3v1SFEng5wEQQC0PJFwtjl/C3CwdgHarew5ru4Y/TBHRpXZV5kVbu8jsK64
         DPAklT89r5fyFbVQDESclrz6RdMBX7Ni5gn6tioeYNsoaePjE3+DNbkgXLHZHLaGHywi
         ZWyw==
X-Forwarded-Encrypted: i=1; AJvYcCXU0uldxYRw+fFr4lzKfDjtCv69Ek0yVrsvznNGgfiLGDWX3OaDpyFnYnJ9gjOmkt/rvIpTtO5b6tNM@lists.infradead.org
X-Gm-Message-State: AOJu0YxkxY2NKVqCDH7VrrVAxQd1zTjCCsPDIaMn0/u1CADo4vGMO8yk
	2Vs8K/zjBvWb2cqocNqV7ZkSC+vOnZbyRX871OzZTrywg/qGsbLwOzHsCWCqgvYgLbzlcX6YuTc
	9F2GJ3yBE/9icdv6pbjkb7xhM97Be11vYts+3AXxnxVRdM8ULrmtXvy4vaSX8VBUWucLA3kvzKN
	iwdFMj34FCLqFKtmgMH6VqXjjTTD/BrAmhaa8Bmx/KeGg=
X-Gm-Gg: ASbGncvbDpmemx1UGIALv5WjoE+tYpXxPX0ahZht6glT4bFrR1oDX7I6pMeNsic/1XK
	D2MMPB0GJb/0vKBbMWAm1/y7eP7EngVO+XU3LnhPkENsFJogygGQwi/8PifJ/h7L8NHME90I705
	QD0a543ndBH06ZP/rnpMfDRQ==
X-Received: by 2002:a05:651c:4098:b0:332:625e:c8ff with SMTP id 38308e7fff4ca-3338e9f8933mr2175861fa.34.1754536821855;
        Wed, 06 Aug 2025 20:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqoH2qeCEWvqpRj+dUrTq2UQg2n7vBLXFTyHrCs7NNbXfiOBhpHUQiIA8nOK1vwdsd3RAN/Dm3tg2U3dFHXHs=
X-Received: by 2002:a05:651c:4098:b0:332:625e:c8ff with SMTP id
 38308e7fff4ca-3338e9f8933mr2175791fa.34.1754536821298; Wed, 06 Aug 2025
 20:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com>
In-Reply-To: <CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 7 Aug 2025 11:20:08 +0800
X-Gm-Features: Ac12FXyfuXbjN26YxB7rXc_DBSnELdCR8b_KAFCtcZ5AimSl0r9lZMhze4EXQwg
Message-ID: <CAHj4cs-8kE-zBZF6smU4YfxaV7M7BoRG_7m6UE175HLYB_ZubQ@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/005 lead kernel panic on
 the latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Maurizio Lombardi <mlombard@redhat.com>, Jens Axboe <axboe@kernel.dk>, mkhalfella@purestorage.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4nblMo2YGKKEC3Slq0iOWd0Nh-GG06ASN_NBt4GnavQ_1754536822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_202028_996571_858F0F39 
X-CRM114-Status: GOOD (  15.47  )
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

I just reviewed the recent commits merged to linux-block/for-next,
seems it was introduced from the below commit:

528589947c18 nvmet: initialize discovery subsys after debugfs is initialize=
d

On Wed, Aug 6, 2025 at 11:49=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hello
>
> I found this panic issue on the latest linux-block/for-next, please
> help check it and let me know if you need any info/testing for it,
> thanks
>
> commit: 20c74c073217 (HEAD -> for-next, origin/for-next) Merge branch
> 'block-6.17' into for-next
> reproducer: blktests nvme/loop or nvme/tcp nvme/005
>
> console log:
> [  341.092092] loop: module loaded
> [  341.246981] run blktests nvme/005 at 2025-08-06 15:32:53
> [  341.537716] loop0: detected capacity change from 0 to 2097152
> [  341.594066] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  341.679693] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  341.931127] nvmet: Created nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  341.959026] nvme nvme1: creating 80 I/O queues.
> [  342.105359] nvme nvme1: mapped 80/0/0 default/read/poll queues.
> [  342.256079] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420, hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [  342.850745] nvmet: Created nvm controller 2 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  342.858886] nvme nvme1: creating 80 I/O queues.
> [  343.254225] nvme nvme1: mapped 80/0/0 default/read/poll queues.
> [  343.539107] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [  343.711101] block nvme1n1: no available path - failing I/O
> [  343.711476] block nvme1n1: no available path - failing I/O
> [  343.711691] Buffer I/O error on dev nvme1n1, logical block 262143,
> async page read
> [  348.367529] Unable to handle ker
> ** replaying previous printk message **
> [  348.367529] Unable to handle kernel paging request at virtual
> address dfff800000000032
> [  348.367589] KASAN: null-ptr-deref in range
> [0x0000000000000190-0x0000000000000197]
> [  348.367593] Mem abort info:
> [  348.367595]   ESR =3D 0x0000000096000005
> [  348.367597]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [  348.367601]   SET =3D 0, FnV =3D 0
> [  348.367603]   EA =3D 0, S1PTW =3D 0
> [  348.367606]   FSC =3D 0x05: level 1 translation fault
> [  348.367608] Data abort info:
> [  348.367610]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> [  348.367612]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [  348.367615]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [  348.367618] [dfff800000000032] address between user and kernel address=
 ranges
> [  348.367758] Internal error: Oops: 0000000096000005 [#1]  SMP
> [  348.444121] Modules linked in: loop nvmet(-) rfkill sunrpc mlx5_ib
> ib_uverbs macsec mgag200 acpi_ipmi ib_core ipmi_ssif arm_spe_pmu
> i2c_algo_bit mlx5_fwctl fwctl ipmi_devintf ipmi_msghandler arm_cmn
> arm_dmc620_pmu vfat fat arm_dsu_pmu cppc_cpufreq fuse xfs mlx5_core
> nvme nvme_core mlxfw nvme_keyring ghash_ce tls sbsa_gwdt nvme_auth
> hpwdt psample pci_hyperv_intf i2c_designware_platform xgene_hwmon
> i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod [last
> unloaded: nvmet_tcp]
> [  348.486730] CPU: 53 UID: 0 PID: 7580 Comm: modprobe Not tainted
> 6.16.0+ #3 PREEMPT_{RT,(full)}
> [  348.495418] Hardware name: HPE ProLiant RL300 Gen11/ProLiant RL300
> Gen11, BIOS 1.60 03/07/2024
> [  348.504018] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  348.510969] pc : kasan_byte_accessible+0xc/0x20
> [  348.515492] lr : __kasan_check_byte+0x20/0x70
> [  348.519839] sp : ffff8000c07679d0
> [  348.523142] x29: ffff8000c07679d0 x28: ffff0800b09d29b0 x27: 000000000=
0000190
> [  348.530269] x26: ffffd1b95babfe28 x25: 0000000000000000 x24: 000000000=
0000002
> [  348.537395] x23: 0000000000000001 x22: 0000000000000000 x21: ffffd1b95=
b1e89dc
> [  348.544521] x20: 0000000000000190 x19: 0000000000000190 x18: 000000000=
0000000
> [  348.551647] x17: ffffd1b922a23714 x16: ffffd1b95bc6e288 x15: ffffd1b95=
b2e9248
> [  348.558773] x14: ffffd1b922a236a8 x13: ffffd1b95d7d5c2c x12: ffff70001=
80ecf1b
> [  348.565900] x11: 1ffff000180ecf1a x10: ffff7000180ecf1a x9 : 000000000=
0000035
> [  348.573026] x8 : ffff07ffdb8e0000 x7 : 0000000000000000 x6 : ffffd1b95=
babfe28
> [  348.580152] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 000000000=
0000000
> [  348.587278] x2 : 0000000000000000 x1 : dfff800000000000 x0 : 000000000=
0000032
> [  348.594405] Call trace:
> [  348.596840]  kasan_byte_accessible+0xc/0x20 (P)
> [  348.601361]  lock_acquire.part.0+0x5c/0x2b8
> [  348.605536]  lock_acquire+0x9c/0x190
> [  348.609102]  down_write_nested+0x70/0xc0
> [  348.613015]  __simple_recursive_removal+0x80/0x4b8
> [  348.617797]  simple_recursive_removal+0x1c/0x30
> [  348.622317]  debugfs_remove+0x60/0x90
> [  348.625971]  nvmet_debugfs_subsys_free+0x3c/0x60 [nvmet]
> [  348.631289]  nvmet_subsys_free+0x50/0x108 [nvmet]
> [  348.635995]  nvmet_subsys_put+0x8c/0x100 [nvmet]
> [  348.640614]  nvmet_exit_discovery+0x20/0x38 [nvmet]
> [  348.645492]  nvmet_exit+0x1c/0x68 [nvmet]
> [  348.649502]  __do_sys_delete_module.constprop.0+0x298/0x548
> [  348.655065]  __arm64_sys_delete_module+0x38/0x58
> [  348.659672]  invoke_syscall.constprop.0+0x78/0x1f0
> [  348.664455]  do_el0_svc+0x164/0x1e0
> [  348.667933]  el0_svc+0x54/0x180
> [  348.671065]  el0t_64_sync_handler+0xa0/0xe8
> [  348.675239]  el0t_64_sync+0x1ac/0x1b0
> [  348.678892] Code: d65f03c0 d343fc00 d2d00001 f2fbffe1 (38616800)
> [  348.684976] ---[ end trace 0000000000000000 ]---
> [  348.689583] Kernel panic - not syncing: Oops: Fatal exception
> [  348.695319] SMP: stopping secondary CPUs
> [  348.699383] Kernel Offset: 0x51b8daeb0000 from 0xffff800080000000
> [  348.705465] PHYS_OFFSET: 0x80000000
> [  348.708941] CPU features: 0x10000,00002e00,048098a1,0441720b
> [  348.714590] Memory Limit: none
> [  348.892994] ---[ end Kernel panic - not syncing: Oops: Fatal exception=
 ]---
>
>
> --
> Best Regards,
>   Yi Zhang



--
Best Regards,
  Yi Zhang


