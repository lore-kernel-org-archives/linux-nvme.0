Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F82ACF2594
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 07:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OwdqLPD3KPseKavs2P/QmY30KtNo1Ub9Xd1UujozKIs=; b=S+/eWCIGJsAlBtTB4RfdpYg1m6
	c9QiB8dWWExKVcJ6y19EL7i2e5pycpljOa/N2zWv3F8FWNKZ5D+KuXlLgYx/qxMuAJ5alsfiCWhEf
	PpKvQ0JEGVfRYwxdFkPwFya8LwmhLiyt0wLOHAnrRP+GO/rmKqdrk6JsImK7SEj/Rptw1PW9qzQVJ
	UAyH7XXruaNYN0dog/dnG7ocF2N053ChQml2T3qPTpiPf8j+rKEqxaJCOJ6uNHF3eqnWmmQho57lf
	AZKXukaNudV/sTXuzuHmykOCFJ6LgV9mfsTdrIMqMVyeeY6ixZ5bUpJdoQyYU6tQ2+ho6mEFTP5Ml
	zO2WPvaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcwQ-00000002jxO-140G;
	Wed, 19 Nov 2025 07:49:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcwM-00000002jwf-0pgm
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 07:49:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwdqLPD3KPseKavs2P/QmY30KtNo1Ub9Xd1UujozKIs=;
	b=Q5OleoGkEEY878a/5Z4lqBPO4FYgZbZP0amHmYz0y3injheKHZ9H0r6cHmKytzg/gYR9HT
	St9JmE6qaReeHtAOI9ru5cE2cG5rRL06xzXKOyYQI6u/joVv2khMmEtiqlj0VchoWNTZGl
	Itp7++KX0oot/V4G591LSQ9UN+/CSFc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-hSyOUtEiPtWKKie-A0KoPw-1; Wed, 19 Nov 2025 02:49:17 -0500
X-MC-Unique: hSyOUtEiPtWKKie-A0KoPw-1
X-Mimecast-MFC-AGG-ID: hSyOUtEiPtWKKie-A0KoPw_1763538556
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-37ba41d5dd5so43159701fa.3
        for <linux-nvme@lists.infradead.org>; Tue, 18 Nov 2025 23:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538556; x=1764143356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OwdqLPD3KPseKavs2P/QmY30KtNo1Ub9Xd1UujozKIs=;
        b=MXB+Y65CJMl8fvzxZqSv9EIq/Hj5yeD5HsReP2CG74ioMi0N5LpwOmPWMeAFi0DcwH
         4YP84wkInTg20YvTJV5+XpzWb7GKgQCCyZC0lXg8tRPqDaBAo7ijXHYfXdSrpJ8fEFG3
         zLZ0eBuu87+4SdLDN+YBgSsv6Q5t2XHRfGKZv9bPm9SW14Q+Rvtup4XUCL8d6ncgbJVC
         UhJyia1cGNRORdumFBS5ZHfyuoPsdvY+7qybtq/MEtdBoCkZLZKLiC/iJtN8clhAX4x5
         fh6Q+/nkbyEBjIGi4Ri2w8URgkpjO1ZHKPn0kJGG+gIctP2AgVRHUYH4fG3PgCAy0wxS
         bOMA==
X-Forwarded-Encrypted: i=1; AJvYcCU+oJ4aJ6M+FVjVcdkVkl0KyORwwDFfknXbTx/Z9H58/2mRnV/ucRgZqgiY6UlbZF2cFjZIjWhymKwb@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4LR+8Fi3yUmdUQgbCiNSu+SvmRg3/LDj+yMJwu25/Bz9JyuB5
	FxiZKUFYcuMA8dwPL4Qmky6GqyEy9rWvH/bBe1QkcAHibbWfmhyaNaeiHURqxwJBPIW7vEh5L8a
	7/bbKGRif0kFfMrVGH1jJ4tgALkXnOvep4fbwK1AZBcYyRg6B15ciuXd2PbzHqJu+6Q/hE6Cc2M
	XxmSg6vGicXYouRyCV05beVF4QX5RKpWN4G5R6S14T1MI=
X-Gm-Gg: ASbGncsnURDwx6rBK15i6HM3CPBwAiJ6QrlhfFU6HoihzCwjtZsEq4pU2uIDK6XMQbT
	IhKWadD6WhB4iJnbGQOnSpemys3bd5zSEOyOFIR9tf0nc5WYnip+6arHgOn3gcDCmtOj+Ce1tkp
	fxHkoUJ3BjZBhsujXMxKPj5N79X9Ios0saMebodPUn1/gW4YSo6tozFYKpBUw/R/wOZwQ=
X-Received: by 2002:a05:651c:324f:b0:37a:e149:5632 with SMTP id 38308e7fff4ca-37babb5c5e8mr48637811fa.2.1763538556207;
        Tue, 18 Nov 2025 23:49:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4egAUet3QZf0dwRlUfRDOz3o7GYkufS1G5xDt97ErAQExciEeMYj78Y8byTYlqjjpMSeN/M1B1Gk8GD1ILLg=
X-Received: by 2002:a05:651c:324f:b0:37a:e149:5632 with SMTP id
 38308e7fff4ca-37babb5c5e8mr48637721fa.2.1763538555688; Tue, 18 Nov 2025
 23:49:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs9Ez5f+SsHMcbYVeKGScuL9vq71i57kRgu2KneRtXRwmw@mail.gmail.com>
 <05281713-80b3-4199-8e76-672e84fcc33e@kernel.dk> <CAHj4cs8+Xgz1qgf3H0sDMFhVAmzb9EsVmuJoRLBOgP7bQymodw@mail.gmail.com>
In-Reply-To: <CAHj4cs8+Xgz1qgf3H0sDMFhVAmzb9EsVmuJoRLBOgP7bQymodw@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 19 Nov 2025 15:49:01 +0800
X-Gm-Features: AWmQ_bnwOjrUz0F0v2cvhgZJGgiMqzdTh1wG5sP8lU5V8BdzBx-SLZqbcROOfKM
Message-ID: <CAHj4cs_4-5g5oW-Wx7KwceALy8F-Ku4cxQGMZ88ARpvZN4HRjg@mail.gmail.com>
Subject: Re: [bug report] kernel BUG at mm/hugetlb.c:5868! triggered by
 blktests nvme/tcp nvme/029
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, 
	Ming Lei <ming.lei@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 669HzL5nEPZBBQb3WzZl8pYyA8mTumx8-CZmgBKOKTY_1763538556
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_234922_316500_E3612571 
X-CRM114-Status: GOOD (  23.56  )
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

HI Jens

It's not one regression issue, I just found I already reported it on
Jun this year, and the BUG was triggered during "nvme write"
operation[1].

[1]
+ test_user_io /dev/nvme0n1 511 1024
+ local disk=3D/dev/nvme0n1
+ local start=3D511
+ local cnt=3D1024
+ local bs size img img1
++ blockdev --getss /dev/nvme0n1
+ bs=3D512
+ size=3D524288
++ mktemp /tmp/blk_img_XXXXXX
+ img=3D/tmp/blk_img_4aWO9O
++ mktemp /tmp/blk_img_XXXXXX
+ img1=3D/tmp/blk_img_mFMZKv
+ dd if=3D/dev/urandom of=3D/tmp/blk_img_4aWO9O bs=3D512 count=3D1024 statu=
s=3Dnone
+ (( cnt-- ))
+ nvme write --start-block=3D511 --block-count=3D1023 --data-size=3D524288
--data=3D/tmp/blk_img_4aWO9O /dev/nvme0n1
failed to read data buffer from input file Bad address

[2]
https://lore.kernel.org/linux-block/CAHj4cs-C76gc67PhHGAE5dak-9AO4gAmRO=3Dy=
EReWcm7Y+u6kHA@mail.gmail.com/


On Wed, Nov 19, 2025 at 10:42=E2=80=AFAM Yi Zhang <yi.zhang@redhat.com> wro=
te:
>
> On Tue, Nov 18, 2025 at 10:57=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wro=
te:
> >
> > On 11/18/25 7:51 AM, Yi Zhang wrote:
> > > Hi
> > >
> > > The following BUG was triggered during CKI tests. Please help check i=
t
> > > and let me know if you need any info/test for it. Thanks.
> > >
> > > commit: for-next - 5674abb82e2b
> > >
> > > [ 1486.502840] run blktests nvme/029 at 2025-11-17 21:34:13
> > > [ 1486.551942] loop0: detected capacity change from 0 to 2097152
> > > [ 1486.563593] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > > [ 1486.580648] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > > [ 1486.627702] nvmet: Created nvm controller 1 for subsystem
> > > blktests-subsystem-1 for NQN
> > > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > > [ 1486.631269] nvme nvme0: creating 32 I/O queues.
> > > [ 1486.639689] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> > > [ 1486.655324] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> > > 127.0.0.1:4420, hostnqn:
> > > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > > [ 1487.242297] ------------[ cut here ]------------
> > > [ 1487.242945] kernel BUG at mm/hugetlb.c:5868!
> > > [ 1487.243628] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> > > [ 1487.243923] CPU: 3 UID: 0 PID: 56899 Comm: nvme Not tainted
> > > 6.18.0-rc5 #1 PREEMPT(lazy)
> > > [ 1487.244450] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/14=
/2018
> > > [ 1487.244807] RIP: 0010:__unmap_hugepage_range+0x79b/0x7f0
> > > [ 1487.245098] Code: 89 ef 48 89 c6 e8 25 90 ff ff 48 8b 3c 24 e8 fc
> > > c3 df 00 e9 d0 fb ff ff 0f 0b 49 8b 50 30 48 f7 d2 4c 85 e2 0f 84 ec
> > > f8 ff ff <0f> 0b 0f 0b 65 48 8b 05 f1 4e 10 03 48 8b 10 f7 c2 00 00 0=
0
> > > 10 74
> > > [ 1487.246461] RSP: 0018:ffffd4108e577a20 EFLAGS: 00010206
> > > [ 1487.246784] RAX: 0000000000400000 RBX: 0000000000000000 RCX: 00000=
00000000009
> > > [ 1487.247559] RDX: 00000000001fffff RSI: ffff8ca241389800 RDI: ffffd=
4108e577b98
> > > [ 1487.248566] RBP: ffffffffffffffff R08: ffffffff963c0658 R09: 00000=
00000200000
> > > [ 1487.249340] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 00007=
f6ee0a05000
> > > [ 1487.250191] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: ffffd=
4108e577b40
> > > [ 1487.250962] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000)
> > > knlGS:0000000000000000
> > > [ 1487.251416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 1487.252127] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 00000=
000000406f0
> > > [ 1487.252933] Call Trace:
> > > [ 1487.253094]  <TASK>
> > > [ 1487.253638]  ? unmap_page_range+0x257/0x400
> > > [ 1487.253876]  unmap_vmas+0xa6/0x180
> > > [ 1487.254482]  exit_mmap+0xf0/0x3b0
> > > [ 1487.255095]  __mmput+0x3e/0x140
> > > [ 1487.255713]  exit_mm+0xaf/0x110
> > > [ 1487.256328]  do_exit+0x1ad/0x450
> > > [ 1487.256905]  ? filemap_map_pages+0x27e/0x3d0
> > > [ 1487.257540]  do_group_exit+0x30/0x80
> > > [ 1487.257789]  __x64_sys_exit_group+0x18/0x20
> > > [ 1487.258008]  x64_sys_call+0x14fa/0x1500
> > > [ 1487.258251]  do_syscall_64+0x84/0x800
> > > [ 1487.258472]  ? do_read_fault+0xf5/0x220
> > > [ 1487.258687]  ? do_fault+0x156/0x280
> > > [ 1487.259260]  ? __handle_mm_fault+0x55c/0x6b0
> > > [ 1487.259911]  ? count_memcg_events+0xdd/0x1b0
> > > [ 1487.260555]  ? handle_mm_fault+0x220/0x340
> > > [ 1487.260784]  ? do_user_addr_fault+0x2c3/0x7f0
> > > [ 1487.261419]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [ 1487.261712] RIP: 0033:0x7f6ee1a7cd08
> > > [ 1487.261954] Code: Unable to access opcode bytes at 0x7f6ee1a7ccde.
> > > [ 1487.262691] RSP: 002b:00007ffdb391b628 EFLAGS: 00000206 ORIG_RAX:
> > > 00000000000000e7
> > > [ 1487.263484] RAX: ffffffffffffffda RBX: 00007f6ee1ba7fc8 RCX: 00007=
f6ee1a7cd08
> > > [ 1487.264266] RDX[ 1487.359221] R10: 00007ffdb391b420 R11:
> > > 0000000000000206 R12: 0000000000000001
> > > [ 1487.365268] R13: 0000000000000001 R14: 00007f6ee1ba6680 R15: 00007=
f6ee1ba7fe0
> > > [ 1487.366071]  </TASK>
> > > [ 1487.366251] Modules linked in: nvmet_tcp nvmet nvme_tcp
> > > nvme_fabrics nvme nvme_core nvme_keyring nvme_auth rtrs_core rdma_cm
> > > iw_cm ib_cm ib_core hkdf rfkill sunrpc amd64_edac edac_mce_amd
> > > ipmi_ssif acpi_power_meter acpi_ipmi ipmi_si ipmi_devintf kvm
> > > irqbypass i2c_piix4 ipmi_msghandler hpilo tg3 acpi_cpufreq i2c_smbus
> > > fam15h_power k10temp pcspkr loop fuse nfnetlink zram lz4hc_compress
> > > lz4_compress xfs ata_generic pata_acpi polyval_clmulni
> > > ghash_clmulni_intel hpsa mgag200 serio_raw i2c_algo_bit
> > > scsi_transport_sas hpwdt sp5100_tco pata_atiixp i2c_dev [last
> > > unloaded: nvmet]
> > > [ 1487.369378] ---[ end trace 0000000000000000 ]---
> > > [ 1487.373697] ERST: [Firmware Warn]: Firmware does not respond in ti=
me.
> > > [ 1487.374212] pstoreffff R08: ffffffff963c0658 R09: 0000000000200000
> > > [ 1487.775150] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 00007=
f6ee0a05000
> > > [ 1487.776024] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: ffffd=
4108e577b40
> > > [ 1487.776853] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000)
> > > knlGS:0000000000000000
> > > [ 1487.777313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 1487.778210] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 00000=
000000406f0
> > > [ 1487.778978] Kernel panic - not syncing: Fatal exception
> > > [ 1487.779714] Kernel Offset: 0x11a00000 from 0xffffffff81000000
> > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > [ 1487.814610] ---[ end Kernel panic - not syncing: Fatal exception ]=
---
> > > [-- MARK -- Mon Nov 17 21:35:00 2025]
> >
> > The usual:
> >
>
> I did a 1000-cycle run for blktests nvme/029, but with no luck to
> reproduce it, I will try to find one reliable reproducer for it.
> Thanks.
>
> > 1) is it reproducible just re-running the test?
> > 2) if so, please bisect
> >
> > --
> > Jens Axboe
> >
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


