Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1053CF8861
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Nov 2025 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/DBuFuEeU4Ln5JYb/VlS9Gj6ZvFxtBQYRD+tG3PsHE=; b=v2B9JYLql5I4akCLNYc57Vp8kU
	ugJjnVq7IRlYoAiq1giR09R2X1zBRGOTRn1XDdkpjp/gnjLLaATrNfFMiq2gqGbAYB03q/2DUvGFj
	6gGDkeWeYRaX7WL0Aa3P1YcA+Ku3Uz1pRvjogQzQd8C+3ho2plR8lOW4D9z22Ocmq/D32DVL8yUIc
	g+sKvDQSu47tfaW7etzcmvUpgl7aVBxOMMghB8xDdSxiyiMmIG9d5Xk3QI2b3tjHFgwVu8howychS
	VIQ9hRlAHhJF6Qwc3pwNZlreJ4AIpQM2FigRi75KEsJKtPTW2ltiULrPdEczxoiBGdRGfe5TTwvIT
	pBHSS4Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM6Qk-00000006u7A-3AuV;
	Thu, 20 Nov 2025 15:18:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM6Qf-00000006u4Z-133o
	for linux-nvme@lists.infradead.org;
	Thu, 20 Nov 2025 15:18:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763651909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/DBuFuEeU4Ln5JYb/VlS9Gj6ZvFxtBQYRD+tG3PsHE=;
	b=SO6S2mK8dZ0zf4rNSR9Mz/K+iW4IjzJwUbiIgXbNwjJnxS8kdYRDYyEptrE439ILELutC8
	tlAvqRMmekLvD6Efs/NsPyFXL6v3TzGLjmPpdMhN+rtVzfJu0g6PKCpqlrJ1dYTuo3zvX1
	P7MhCvU4vjXL8qD1xYtgGhewsQYp4Zk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ms7zzCn-MqCBwnRSnvL13w-1; Thu, 20 Nov 2025 10:18:28 -0500
X-MC-Unique: ms7zzCn-MqCBwnRSnvL13w-1
X-Mimecast-MFC-AGG-ID: ms7zzCn-MqCBwnRSnvL13w_1763651907
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-37bbe387942so4452241fa.3
        for <linux-nvme@lists.infradead.org>; Thu, 20 Nov 2025 07:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651906; x=1764256706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/DBuFuEeU4Ln5JYb/VlS9Gj6ZvFxtBQYRD+tG3PsHE=;
        b=AG4/qFcruZQO0/FYjBpOA0XwVYdj6EfDh8X6Bg4IeWzSQaThb43LcyuY7MNZd/wrg+
         jqfVKxFQAMcLzDKzxWr9wFy3ZwMEJ2JcqHOfj8z5Mos1PJfr3VVvB4HZdZSuHwXy2uqG
         UsOKY+56SlOuCbmcLBSxCw9rpNQB6UfiLaL2zw6bcH/5jTkf5fr/Bn8+q7lqmgLnJHu/
         jb47yQ65bCf85Y7wgLr6ZwYQUgGSxlcPBhZojNNVJdPRGaGwqokwga8lNJevow45BRwt
         /loe5aWI4/6bP1Kkh1/6uxFxFfeFMpawyRrHJQAGVew3Sugoovo6u+7ObTEOoFqgW0PL
         Mq+w==
X-Forwarded-Encrypted: i=1; AJvYcCVd0eXxm0CKLWl5lQSH0AIYa3s/JyzYvLhw7yaCUXzG2GGKYqeS2+qmwqANqQ+FpWiEqDaUbVF+Ymtn@lists.infradead.org
X-Gm-Message-State: AOJu0Yzf5RgFrAXchMvGIcpIvGUBVdATNWYtJCrFmTfrSkxYZMSuSHIw
	T9+Bs9ULNoEZYu7O+JDS8Iyd+GYIIqXRGyHHIhLTyftnC16EhEI/+4J5gys/iqVwdFZRZKWbw45
	8X86V95nz4SAixFDOeJ1kCEn1WYVIoXp+vfE3Eai6VYscPJdDd8d1S33d1rA5uPOCQrbuRQ7hE/
	SahQ4nNsMQuYYCrsdOYCBrl19pj5Jgw3rJ6FDHw7PAHfA=
X-Gm-Gg: ASbGncvgCma+MmZQ+yLEibBETfMve4cwqZsApxkiSptiTRjXykg4rxRkLIMo9s+e5ed
	EPgaYpUe9eVP9w1Rs5Mr+pz270O9cYkSgS6NzSXKeuOLPwQJFxVAqjPpevRDqGyz+NAnFzTx++7
	ATxsy1bZp6Uc9TD1Xn+ZlTcK/QVuHOqfpjV5SqzB8e4hqUCO1i2LIQce883bYPqYGXgOA=
X-Received: by 2002:a2e:9209:0:b0:37a:c4d:8215 with SMTP id 38308e7fff4ca-37cceb2edb8mr4803251fa.12.1763651906404;
        Thu, 20 Nov 2025 07:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/QXSYEr8zjhFJja3V/qsM8jFGpizqpwnMepZ5xakR7ic+7TqyNguPWx5BvZoUaapKGIXPh2MfsbFXg4JHjjE=
X-Received: by 2002:a2e:9209:0:b0:37a:c4d:8215 with SMTP id
 38308e7fff4ca-37cceb2edb8mr4803141fa.12.1763651905893; Thu, 20 Nov 2025
 07:18:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs9Ez5f+SsHMcbYVeKGScuL9vq71i57kRgu2KneRtXRwmw@mail.gmail.com>
 <05281713-80b3-4199-8e76-672e84fcc33e@kernel.dk> <CAHj4cs8+Xgz1qgf3H0sDMFhVAmzb9EsVmuJoRLBOgP7bQymodw@mail.gmail.com>
 <CAHj4cs_4-5g5oW-Wx7KwceALy8F-Ku4cxQGMZ88ARpvZN4HRjg@mail.gmail.com>
In-Reply-To: <CAHj4cs_4-5g5oW-Wx7KwceALy8F-Ku4cxQGMZ88ARpvZN4HRjg@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 20 Nov 2025 23:18:13 +0800
X-Gm-Features: AWmQ_bkUdXERIRrPOQWm_LMpjJEfqegXV6_49YcCcOJPRyZLCjd-ClSXzkb73s8
Message-ID: <CAHj4cs9AUA94ntY0uhDDAmoWTMA3kxpSCArKG9MHcgkVASJfAg@mail.gmail.com>
Subject: Re: [bug report] kernel BUG at mm/hugetlb.c:5868! triggered by
 blktests nvme/tcp nvme/029
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, 
	Ming Lei <ming.lei@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vyFYVplG3o3kcGpp1LtieNIl6qlpdTfhbcM1H8zHwRg_1763651907
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_071837_366305_61B36AD2 
X-CRM114-Status: GOOD (  27.65  )
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

I did more testing today, and found that this issue cannot be
reproduced if I don't set the nr_hugepages

https://github.com/linux-blktests/blktests/blob/master/tests/nvme/029#L71


On Wed, Nov 19, 2025 at 3:49=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> HI Jens
>
> It's not one regression issue, I just found I already reported it on
> Jun this year, and the BUG was triggered during "nvme write"
> operation[1].
>
> [1]
> + test_user_io /dev/nvme0n1 511 1024
> + local disk=3D/dev/nvme0n1
> + local start=3D511
> + local cnt=3D1024
> + local bs size img img1
> ++ blockdev --getss /dev/nvme0n1
> + bs=3D512
> + size=3D524288
> ++ mktemp /tmp/blk_img_XXXXXX
> + img=3D/tmp/blk_img_4aWO9O
> ++ mktemp /tmp/blk_img_XXXXXX
> + img1=3D/tmp/blk_img_mFMZKv
> + dd if=3D/dev/urandom of=3D/tmp/blk_img_4aWO9O bs=3D512 count=3D1024 sta=
tus=3Dnone
> + (( cnt-- ))
> + nvme write --start-block=3D511 --block-count=3D1023 --data-size=3D52428=
8
> --data=3D/tmp/blk_img_4aWO9O /dev/nvme0n1
> failed to read data buffer from input file Bad address
>
> [2]
> https://lore.kernel.org/linux-block/CAHj4cs-C76gc67PhHGAE5dak-9AO4gAmRO=
=3DyEReWcm7Y+u6kHA@mail.gmail.com/
>
>
> On Wed, Nov 19, 2025 at 10:42=E2=80=AFAM Yi Zhang <yi.zhang@redhat.com> w=
rote:
> >
> > On Tue, Nov 18, 2025 at 10:57=E2=80=AFPM Jens Axboe <axboe@kernel.dk> w=
rote:
> > >
> > > On 11/18/25 7:51 AM, Yi Zhang wrote:
> > > > Hi
> > > >
> > > > The following BUG was triggered during CKI tests. Please help check=
 it
> > > > and let me know if you need any info/test for it. Thanks.
> > > >
> > > > commit: for-next - 5674abb82e2b
> > > >
> > > > [ 1486.502840] run blktests nvme/029 at 2025-11-17 21:34:13
> > > > [ 1486.551942] loop0: detected capacity change from 0 to 2097152
> > > > [ 1486.563593] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
> > > > [ 1486.580648] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > > > [ 1486.627702] nvmet: Created nvm controller 1 for subsystem
> > > > blktests-subsystem-1 for NQN
> > > > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de34=
9.
> > > > [ 1486.631269] nvme nvme0: creating 32 I/O queues.
> > > > [ 1486.639689] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> > > > [ 1486.655324] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", ad=
dr
> > > > 127.0.0.1:4420, hostnqn:
> > > > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de34=
9
> > > > [ 1487.242297] ------------[ cut here ]------------
> > > > [ 1487.242945] kernel BUG at mm/hugetlb.c:5868!
> > > > [ 1487.243628] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> > > > [ 1487.243923] CPU: 3 UID: 0 PID: 56899 Comm: nvme Not tainted
> > > > 6.18.0-rc5 #1 PREEMPT(lazy)
> > > > [ 1487.244450] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/=
14/2018
> > > > [ 1487.244807] RIP: 0010:__unmap_hugepage_range+0x79b/0x7f0
> > > > [ 1487.245098] Code: 89 ef 48 89 c6 e8 25 90 ff ff 48 8b 3c 24 e8 f=
c
> > > > c3 df 00 e9 d0 fb ff ff 0f 0b 49 8b 50 30 48 f7 d2 4c 85 e2 0f 84 e=
c
> > > > f8 ff ff <0f> 0b 0f 0b 65 48 8b 05 f1 4e 10 03 48 8b 10 f7 c2 00 00=
 00
> > > > 10 74
> > > > [ 1487.246461] RSP: 0018:ffffd4108e577a20 EFLAGS: 00010206
> > > > [ 1487.246784] RAX: 0000000000400000 RBX: 0000000000000000 RCX: 000=
0000000000009
> > > > [ 1487.247559] RDX: 00000000001fffff RSI: ffff8ca241389800 RDI: fff=
fd4108e577b98
> > > > [ 1487.248566] RBP: ffffffffffffffff R08: ffffffff963c0658 R09: 000=
0000000200000
> > > > [ 1487.249340] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 000=
07f6ee0a05000
> > > > [ 1487.250191] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: fff=
fd4108e577b40
> > > > [ 1487.250962] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000=
)
> > > > knlGS:0000000000000000
> > > > [ 1487.251416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [ 1487.252127] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 000=
00000000406f0
> > > > [ 1487.252933] Call Trace:
> > > > [ 1487.253094]  <TASK>
> > > > [ 1487.253638]  ? unmap_page_range+0x257/0x400
> > > > [ 1487.253876]  unmap_vmas+0xa6/0x180
> > > > [ 1487.254482]  exit_mmap+0xf0/0x3b0
> > > > [ 1487.255095]  __mmput+0x3e/0x140
> > > > [ 1487.255713]  exit_mm+0xaf/0x110
> > > > [ 1487.256328]  do_exit+0x1ad/0x450
> > > > [ 1487.256905]  ? filemap_map_pages+0x27e/0x3d0
> > > > [ 1487.257540]  do_group_exit+0x30/0x80
> > > > [ 1487.257789]  __x64_sys_exit_group+0x18/0x20
> > > > [ 1487.258008]  x64_sys_call+0x14fa/0x1500
> > > > [ 1487.258251]  do_syscall_64+0x84/0x800
> > > > [ 1487.258472]  ? do_read_fault+0xf5/0x220
> > > > [ 1487.258687]  ? do_fault+0x156/0x280
> > > > [ 1487.259260]  ? __handle_mm_fault+0x55c/0x6b0
> > > > [ 1487.259911]  ? count_memcg_events+0xdd/0x1b0
> > > > [ 1487.260555]  ? handle_mm_fault+0x220/0x340
> > > > [ 1487.260784]  ? do_user_addr_fault+0x2c3/0x7f0
> > > > [ 1487.261419]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > [ 1487.261712] RIP: 0033:0x7f6ee1a7cd08
> > > > [ 1487.261954] Code: Unable to access opcode bytes at 0x7f6ee1a7ccd=
e.
> > > > [ 1487.262691] RSP: 002b:00007ffdb391b628 EFLAGS: 00000206 ORIG_RAX=
:
> > > > 00000000000000e7
> > > > [ 1487.263484] RAX: ffffffffffffffda RBX: 00007f6ee1ba7fc8 RCX: 000=
07f6ee1a7cd08
> > > > [ 1487.264266] RDX[ 1487.359221] R10: 00007ffdb391b420 R11:
> > > > 0000000000000206 R12: 0000000000000001
> > > > [ 1487.365268] R13: 0000000000000001 R14: 00007f6ee1ba6680 R15: 000=
07f6ee1ba7fe0
> > > > [ 1487.366071]  </TASK>
> > > > [ 1487.366251] Modules linked in: nvmet_tcp nvmet nvme_tcp
> > > > nvme_fabrics nvme nvme_core nvme_keyring nvme_auth rtrs_core rdma_c=
m
> > > > iw_cm ib_cm ib_core hkdf rfkill sunrpc amd64_edac edac_mce_amd
> > > > ipmi_ssif acpi_power_meter acpi_ipmi ipmi_si ipmi_devintf kvm
> > > > irqbypass i2c_piix4 ipmi_msghandler hpilo tg3 acpi_cpufreq i2c_smbu=
s
> > > > fam15h_power k10temp pcspkr loop fuse nfnetlink zram lz4hc_compress
> > > > lz4_compress xfs ata_generic pata_acpi polyval_clmulni
> > > > ghash_clmulni_intel hpsa mgag200 serio_raw i2c_algo_bit
> > > > scsi_transport_sas hpwdt sp5100_tco pata_atiixp i2c_dev [last
> > > > unloaded: nvmet]
> > > > [ 1487.369378] ---[ end trace 0000000000000000 ]---
> > > > [ 1487.373697] ERST: [Firmware Warn]: Firmware does not respond in =
time.
> > > > [ 1487.374212] pstoreffff R08: ffffffff963c0658 R09: 00000000002000=
00
> > > > [ 1487.775150] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 000=
07f6ee0a05000
> > > > [ 1487.776024] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: fff=
fd4108e577b40
> > > > [ 1487.776853] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000=
)
> > > > knlGS:0000000000000000
> > > > [ 1487.777313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [ 1487.778210] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 000=
00000000406f0
> > > > [ 1487.778978] Kernel panic - not syncing: Fatal exception
> > > > [ 1487.779714] Kernel Offset: 0x11a00000 from 0xffffffff81000000
> > > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > > [ 1487.814610] ---[ end Kernel panic - not syncing: Fatal exception=
 ]---
> > > > [-- MARK -- Mon Nov 17 21:35:00 2025]
> > >
> > > The usual:
> > >
> >
> > I did a 1000-cycle run for blktests nvme/029, but with no luck to
> > reproduce it, I will try to find one reliable reproducer for it.
> > Thanks.
> >
> > > 1) is it reproducible just re-running the test?
> > > 2) if so, please bisect
> > >
> > > --
> > > Jens Axboe
> > >
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



--
Best Regards,
  Yi Zhang


