Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97BECEDD9A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nXl5A1LzIc3mraM+u+KCuIUN2D9cbOD/IWOomrXYJb8=; b=ba5KWUg4X8qPrOCP/4t7v+miS0
	Cv8q4LmkkNu+VQCOVV2ymGxaMDuCLbU+oRwvWTPOUQenLbi3sLBjCYTHkQ50fAmQe/GLQ1j7uIZw7
	8rSI7QBAd65cL7IVPY/yanLXQdNeGWsISvOGL9Z2JW/C7Wlhfp6U9mbEvFIRc1UWUY/V8cYMcxLaG
	9VbDFLhORGznD39yWzEZUbRgkdKxNrermoDdzxHSVr1TPpqITVsMwg7FVAKkjOG4zo/dTIdq35l5R
	0Mqx+RhdajDK2Ap0G2/d3a3QflHGvnnoySXHWLl0YO8tvI1YZuppXsdgs1MadA2n7GCiijO4I7jbp
	z3GB0D1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLN4C-00000000aK3-3sGz;
	Tue, 18 Nov 2025 14:52:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLN49-00000000aJi-2vL8
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 14:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763477540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nXl5A1LzIc3mraM+u+KCuIUN2D9cbOD/IWOomrXYJb8=;
	b=Yu33fR0Ygb+nl0/ZUhkil43EH0rHYBSrEk/0ZCOfvlwGYCEYVujUIqRICC4/wf9HrBRe6M
	WS9HY5EwFLJNGN5is9m580hvvA1grEwk5QYV5UTe7+tJD4nID1b+ixg9kzXSh+ubxuuif8
	X4pAGnpaFFALxb/RudYvK2gHY+GI5Tk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-ySMNVnsgNnyjo0luD-oq1A-1; Tue, 18 Nov 2025 09:52:02 -0500
X-MC-Unique: ySMNVnsgNnyjo0luD-oq1A-1
X-Mimecast-MFC-AGG-ID: ySMNVnsgNnyjo0luD-oq1A_1763477521
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-37a7ab6c1dcso30256451fa.3
        for <linux-nvme@lists.infradead.org>; Tue, 18 Nov 2025 06:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763477521; x=1764082321;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXl5A1LzIc3mraM+u+KCuIUN2D9cbOD/IWOomrXYJb8=;
        b=MMA896rKBnwBGM3An+PtbtOqWb+QcyawEUn7TpFvGeXr1wd9Qo2R7GkoLfg8Bjw56t
         SSLHD9gmJowTTQ7owwKM5Z2Kcj3WRqL66pnsA0vjtTlS9Lu3OGl94NbCO6EEbXhM6gzK
         V2JV2oR4EPb/0lU5gY846K4F91kH9d8n9RMF6vDfdV64AkcqCxUh/hCz/mehmpUaZt/e
         w1nFR9QPksnb15tVLfgKydGypqFcEcHKp1ojyXo/sI9whvxPmhnImgidHLKt2n3EkxJQ
         /O+VlbMa1i2QeDwnkij+DzlyMUe19LNrr8RPLxvJBxgVcfMDpZt+GhGpOKmpShpDNJYo
         U9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX+VoaYIGZKmZQCEDmYoXa1uGdaAHTvSaWkUxN7D8O4fcPdVwMUKPW5j5shpoU1M8ynBt64zO2sL5y+@lists.infradead.org
X-Gm-Message-State: AOJu0YxUquyXf+MJmJed3HTriGVdL7F4HHjjPjgKGdEAp2TlyUGWAKch
	jY/godLelpwhDYiZopdMTMk8Wq51AzY7X3fWuIZeKT/QHwwJCyNqBFOGQMyPh5pqTdc3TfbFsFi
	gXNn7EOP8cCoD5y+98VijB24rrcldNyp/5JDAjQk++R/4P5nuMp2/k3rNfc/fHxocU5CW3yyFQz
	WPIXB7/L4fkphdm0+5GUmePawZGev5hBP4T2Fq7FuIVp4=
X-Gm-Gg: ASbGnctERTQdh8HI5cTS2sgPHbV5V+KFsgJZikvY1TCUp7g6UneN7j9O/5vIiZZk3e3
	6v0gRX8VGgabrXaf/v9CX+r8U0TjxNN/Vlqg/E60DaHJInUgA56b7QDat7tKwppu4T8ylts45rv
	Fj2u/sLyv0RGloBhER/iVqFwlG9uz93daqMOkfhivg/24jznkHMikQ4hrqNs87QZaXwJM=
X-Received: by 2002:a2e:964b:0:b0:37b:9a1d:dee8 with SMTP id 38308e7fff4ca-37babbcc10emr36504891fa.15.1763477520681;
        Tue, 18 Nov 2025 06:52:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyZ3N04ZxpnfVzJf09np+5pwDccRdD1dMw6KLtuf4+C06OpBVgTUB3Yn/aySAd4cyXLVGoKEAi/qJf9VKVxXY=
X-Received: by 2002:a2e:964b:0:b0:37b:9a1d:dee8 with SMTP id
 38308e7fff4ca-37babbcc10emr36504791fa.15.1763477520210; Tue, 18 Nov 2025
 06:52:00 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 18 Nov 2025 22:51:45 +0800
X-Gm-Features: AWmQ_bmOuSLfPUtcCfBv7z24hH4u1afg_aOOLf4o3S4kLdKSu8mnBlOFDqSFZeg
Message-ID: <CAHj4cs9Ez5f+SsHMcbYVeKGScuL9vq71i57kRgu2KneRtXRwmw@mail.gmail.com>
Subject: [bug report] kernel BUG at mm/hugetlb.c:5868! triggered by blktests
 nvme/tcp nvme/029
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jens Axboe <axboe@kernel.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: idSuPyTxJ0yNfP1XupQMfLHIoyCRhnk6M4oaEcRg1sM_1763477521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_065221_807718_EFC1C1A4 
X-CRM114-Status: UNSURE (   9.61  )
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

Hi

The following BUG was triggered during CKI tests. Please help check it
and let me know if you need any info/test for it. Thanks.

commit: for-next - 5674abb82e2b

[ 1486.502840] run blktests nvme/029 at 2025-11-17 21:34:13
[ 1486.551942] loop0: detected capacity change from 0 to 2097152
[ 1486.563593] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1486.580648] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 1486.627702] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1486.631269] nvme nvme0: creating 32 I/O queues.
[ 1486.639689] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 1486.655324] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 1487.242297] ------------[ cut here ]------------
[ 1487.242945] kernel BUG at mm/hugetlb.c:5868!
[ 1487.243628] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[ 1487.243923] CPU: 3 UID: 0 PID: 56899 Comm: nvme Not tainted
6.18.0-rc5 #1 PREEMPT(lazy)
[ 1487.244450] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/14/2018
[ 1487.244807] RIP: 0010:__unmap_hugepage_range+0x79b/0x7f0
[ 1487.245098] Code: 89 ef 48 89 c6 e8 25 90 ff ff 48 8b 3c 24 e8 fc
c3 df 00 e9 d0 fb ff ff 0f 0b 49 8b 50 30 48 f7 d2 4c 85 e2 0f 84 ec
f8 ff ff <0f> 0b 0f 0b 65 48 8b 05 f1 4e 10 03 48 8b 10 f7 c2 00 00 00
10 74
[ 1487.246461] RSP: 0018:ffffd4108e577a20 EFLAGS: 00010206
[ 1487.246784] RAX: 0000000000400000 RBX: 0000000000000000 RCX: 0000000000000009
[ 1487.247559] RDX: 00000000001fffff RSI: ffff8ca241389800 RDI: ffffd4108e577b98
[ 1487.248566] RBP: ffffffffffffffff R08: ffffffff963c0658 R09: 0000000000200000
[ 1487.249340] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 00007f6ee0a05000
[ 1487.250191] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: ffffd4108e577b40
[ 1487.250962] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000)
knlGS:0000000000000000
[ 1487.251416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1487.252127] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 00000000000406f0
[ 1487.252933] Call Trace:
[ 1487.253094]  <TASK>
[ 1487.253638]  ? unmap_page_range+0x257/0x400
[ 1487.253876]  unmap_vmas+0xa6/0x180
[ 1487.254482]  exit_mmap+0xf0/0x3b0
[ 1487.255095]  __mmput+0x3e/0x140
[ 1487.255713]  exit_mm+0xaf/0x110
[ 1487.256328]  do_exit+0x1ad/0x450
[ 1487.256905]  ? filemap_map_pages+0x27e/0x3d0
[ 1487.257540]  do_group_exit+0x30/0x80
[ 1487.257789]  __x64_sys_exit_group+0x18/0x20
[ 1487.258008]  x64_sys_call+0x14fa/0x1500
[ 1487.258251]  do_syscall_64+0x84/0x800
[ 1487.258472]  ? do_read_fault+0xf5/0x220
[ 1487.258687]  ? do_fault+0x156/0x280
[ 1487.259260]  ? __handle_mm_fault+0x55c/0x6b0
[ 1487.259911]  ? count_memcg_events+0xdd/0x1b0
[ 1487.260555]  ? handle_mm_fault+0x220/0x340
[ 1487.260784]  ? do_user_addr_fault+0x2c3/0x7f0
[ 1487.261419]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1487.261712] RIP: 0033:0x7f6ee1a7cd08
[ 1487.261954] Code: Unable to access opcode bytes at 0x7f6ee1a7ccde.
[ 1487.262691] RSP: 002b:00007ffdb391b628 EFLAGS: 00000206 ORIG_RAX:
00000000000000e7
[ 1487.263484] RAX: ffffffffffffffda RBX: 00007f6ee1ba7fc8 RCX: 00007f6ee1a7cd08
[ 1487.264266] RDX[ 1487.359221] R10: 00007ffdb391b420 R11:
0000000000000206 R12: 0000000000000001
[ 1487.365268] R13: 0000000000000001 R14: 00007f6ee1ba6680 R15: 00007f6ee1ba7fe0
[ 1487.366071]  </TASK>
[ 1487.366251] Modules linked in: nvmet_tcp nvmet nvme_tcp
nvme_fabrics nvme nvme_core nvme_keyring nvme_auth rtrs_core rdma_cm
iw_cm ib_cm ib_core hkdf rfkill sunrpc amd64_edac edac_mce_amd
ipmi_ssif acpi_power_meter acpi_ipmi ipmi_si ipmi_devintf kvm
irqbypass i2c_piix4 ipmi_msghandler hpilo tg3 acpi_cpufreq i2c_smbus
fam15h_power k10temp pcspkr loop fuse nfnetlink zram lz4hc_compress
lz4_compress xfs ata_generic pata_acpi polyval_clmulni
ghash_clmulni_intel hpsa mgag200 serio_raw i2c_algo_bit
scsi_transport_sas hpwdt sp5100_tco pata_atiixp i2c_dev [last
unloaded: nvmet]
[ 1487.369378] ---[ end trace 0000000000000000 ]---
[ 1487.373697] ERST: [Firmware Warn]: Firmware does not respond in time.
[ 1487.374212] pstoreffff R08: ffffffff963c0658 R09: 0000000000200000
[ 1487.775150] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 00007f6ee0a05000
[ 1487.776024] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: ffffd4108e577b40
[ 1487.776853] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000)
knlGS:0000000000000000
[ 1487.777313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1487.778210] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 00000000000406f0
[ 1487.778978] Kernel panic - not syncing: Fatal exception
[ 1487.779714] Kernel Offset: 0x11a00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1487.814610] ---[ end Kernel panic - not syncing: Fatal exception ]---
[-- MARK -- Mon Nov 17 21:35:00 2025]

-- 
Best Regards,
  Yi Zhang


