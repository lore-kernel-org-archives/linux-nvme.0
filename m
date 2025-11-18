Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45C2CEBF97
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/MoauCRfLYO5Dez7eEYptynQmFWWWyY0g081OZ7TYhc=; b=X9TAWcn51Xu/U+CfgOvoKFjTAU
	GklFvOE9Xpa0Y+YSX9BySYWwSPaNnl59IlweQiiEBze3Si0t/A1Qbb+156h0TvnvtaBuDKjtdJggf
	aiigCBw/Ih0CxFQGKUY5Ze7nWEYbGJtlZfYg2ZYvm6x6CCHh/Z3owpuP4g3wnyPk/oMzGXVLXeB9G
	kRccMdoffFFdShGdANNEysGSKUAkBAK1jEe9Ap1SD6VxLe2iCyEPznGxX/QtwiLE9u2W1NHk1L3qa
	9HbLzAWuzLCPsgVZ2eAOW3Wl3KK4YYsazrwN+obILXUpIc6+vJN2qjuLW/RRwEXr/W9E/NSIL21l7
	9PKHiQQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLN9G-00000000aes-42ao;
	Tue, 18 Nov 2025 14:57:38 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLN9E-00000000ae6-1NdN
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 14:57:38 +0000
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-949042bca69so95045139f.1
        for <linux-nvme@lists.infradead.org>; Tue, 18 Nov 2025 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763477855; x=1764082655; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MoauCRfLYO5Dez7eEYptynQmFWWWyY0g081OZ7TYhc=;
        b=uYU5w0zQCFe5nJCh9OFUCWeWoOG2kyvYwatfps85t1FJ4wXDqkPfNmAlaKto8SZYx3
         7w4LF9NMSU9cK/T8yh8WUHsql6bc+fXSh/++Z83m+9KSpkfvJ7RPvfm2SG9/B4HvLIxl
         8oQnquLE6oKTlH8F/QShdfIuqS3yRYaI83y+lLJy33z8KUNSKr0jKDqZgUHp0wMB0rFi
         JsT08LMLP3JBXbcLrVugDw8D5bNsvsiHjmW9mGZVStQhdn0qL0v3UTjvWQBtwdrjk7+F
         QvyFZDjm+uXu1Xgce+ygG39JvPHTRWeGuCxL8KwupYWJEMq5/pxrYwRGXqnqz38XGPoi
         wzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763477855; x=1764082655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MoauCRfLYO5Dez7eEYptynQmFWWWyY0g081OZ7TYhc=;
        b=guRvltRQ/40ZDxYzh3Fei7zGR39B2Jnrn3wtERMyDnvdsQvxHFgb+TthjkaWFBMb0B
         kSbSteMUHSiBdqKGY8b8Mk6r2Ssvre+xdy63Bt3bZNWDJpN7qWzXyqnfQaFhbmzZP1WU
         f1gHJFiWoLKyb0XxIFPEXzxAfX1UmYxEhJsa781stBlhy/Y6nS/eud/szWCIDMK+IaNU
         VwTVUw7+jphDqPKaJ32Oi4b+Q950qw55yuWBcKsHXrApkignE7FiizIlW52YcOcKO/bl
         LsYM7SKGTe16zYTBfwd52N4ww5TaOCiOsmc0GfE99HLVbMZmsLRNOtXCdHdBdOc15euK
         ryDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4hB8Uk3Sf06Q/sDTRKgqEUafXTK2HhfA4Gamssd7xfliinDpiy2TvsWs31hOr3e/ZqBCiN7B5GrF5@lists.infradead.org
X-Gm-Message-State: AOJu0YxUDIF5BHYnxbOU6UbXFdMajAM5ID8pNbek4Zhq4sjFAIbdroxV
	if10GoOj510xspe1k4YHz8qiFUJDHJfunjoRH6+LVSQdG+IRGrl38t4G67CzMgxqm26x1r03gYq
	FmuUv
X-Gm-Gg: ASbGncvKbAJP7fymhTSK81Nmly0HKTUSfWdqktTo3dNW6olhu2WZa2cJQX9uUzHKLJz
	t47fVbrzOI2UzpukdIeccQe5HgUdLP1vTV7XuUMgQ/oq0Av6e2AE4lN9xEE1DMtd2NQvUXBJUTV
	PRRSKjSMjwBG6JtqDWtOyoQulrEy1Rozx1rOZX331YTpzhM0wnrL/G/Rh8ykl6szzIRRR7VDFk2
	TGKGwAqVI4hiFMXanVsozzGJl1NoxV7p0oaAU74yTKhfk8UM1XqS6COv0PaS0lmi3UhOzWXZ/tZ
	oYomUTHGEp3fHvgXQ/gXpVRYoUkrw/h/V1ILiM+v4WlKuXTfc30H2CagJvprw/96Dy7Mm8zqfh9
	4SlDBc4Q9NrF1tFi4yRzRoaT1xdrZ12W8VCCVhakqB8FWr0R82IloTYccVNSoh9T/T4xNAM+dGD
	ARYcSs6Sv2
X-Google-Smtp-Source: AGHT+IHVKNvRBtckIiXM0gaT/8QtYpjsvXPxl94snzgFqlaCWZHALGwo/eaBgGMaqePgyLIzGMASnA==
X-Received: by 2002:a02:6f5a:0:b0:5b7:bacb:803 with SMTP id 8926c6da1cb9f-5b7c9a5c2b4mr9995594173.0.1763477855151;
        Tue, 18 Nov 2025 06:57:35 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd24e285sm6161081173.8.2025.11.18.06.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:57:34 -0800 (PST)
Message-ID: <05281713-80b3-4199-8e76-672e84fcc33e@kernel.dk>
Date: Tue, 18 Nov 2025 07:57:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kernel BUG at mm/hugetlb.c:5868! triggered by
 blktests nvme/tcp nvme/029
To: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs9Ez5f+SsHMcbYVeKGScuL9vq71i57kRgu2KneRtXRwmw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHj4cs9Ez5f+SsHMcbYVeKGScuL9vq71i57kRgu2KneRtXRwmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_065736_378160_7DE57FBE 
X-CRM114-Status: GOOD (  14.41  )
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

On 11/18/25 7:51 AM, Yi Zhang wrote:
> Hi
> 
> The following BUG was triggered during CKI tests. Please help check it
> and let me know if you need any info/test for it. Thanks.
> 
> commit: for-next - 5674abb82e2b
> 
> [ 1486.502840] run blktests nvme/029 at 2025-11-17 21:34:13
> [ 1486.551942] loop0: detected capacity change from 0 to 2097152
> [ 1486.563593] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1486.580648] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 1486.627702] nvmet: Created nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 1486.631269] nvme nvme0: creating 32 I/O queues.
> [ 1486.639689] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> [ 1486.655324] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420, hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [ 1487.242297] ------------[ cut here ]------------
> [ 1487.242945] kernel BUG at mm/hugetlb.c:5868!
> [ 1487.243628] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [ 1487.243923] CPU: 3 UID: 0 PID: 56899 Comm: nvme Not tainted
> 6.18.0-rc5 #1 PREEMPT(lazy)
> [ 1487.244450] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/14/2018
> [ 1487.244807] RIP: 0010:__unmap_hugepage_range+0x79b/0x7f0
> [ 1487.245098] Code: 89 ef 48 89 c6 e8 25 90 ff ff 48 8b 3c 24 e8 fc
> c3 df 00 e9 d0 fb ff ff 0f 0b 49 8b 50 30 48 f7 d2 4c 85 e2 0f 84 ec
> f8 ff ff <0f> 0b 0f 0b 65 48 8b 05 f1 4e 10 03 48 8b 10 f7 c2 00 00 00
> 10 74
> [ 1487.246461] RSP: 0018:ffffd4108e577a20 EFLAGS: 00010206
> [ 1487.246784] RAX: 0000000000400000 RBX: 0000000000000000 RCX: 0000000000000009
> [ 1487.247559] RDX: 00000000001fffff RSI: ffff8ca241389800 RDI: ffffd4108e577b98
> [ 1487.248566] RBP: ffffffffffffffff R08: ffffffff963c0658 R09: 0000000000200000
> [ 1487.249340] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 00007f6ee0a05000
> [ 1487.250191] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: ffffd4108e577b40
> [ 1487.250962] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000)
> knlGS:0000000000000000
> [ 1487.251416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1487.252127] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 00000000000406f0
> [ 1487.252933] Call Trace:
> [ 1487.253094]  <TASK>
> [ 1487.253638]  ? unmap_page_range+0x257/0x400
> [ 1487.253876]  unmap_vmas+0xa6/0x180
> [ 1487.254482]  exit_mmap+0xf0/0x3b0
> [ 1487.255095]  __mmput+0x3e/0x140
> [ 1487.255713]  exit_mm+0xaf/0x110
> [ 1487.256328]  do_exit+0x1ad/0x450
> [ 1487.256905]  ? filemap_map_pages+0x27e/0x3d0
> [ 1487.257540]  do_group_exit+0x30/0x80
> [ 1487.257789]  __x64_sys_exit_group+0x18/0x20
> [ 1487.258008]  x64_sys_call+0x14fa/0x1500
> [ 1487.258251]  do_syscall_64+0x84/0x800
> [ 1487.258472]  ? do_read_fault+0xf5/0x220
> [ 1487.258687]  ? do_fault+0x156/0x280
> [ 1487.259260]  ? __handle_mm_fault+0x55c/0x6b0
> [ 1487.259911]  ? count_memcg_events+0xdd/0x1b0
> [ 1487.260555]  ? handle_mm_fault+0x220/0x340
> [ 1487.260784]  ? do_user_addr_fault+0x2c3/0x7f0
> [ 1487.261419]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1487.261712] RIP: 0033:0x7f6ee1a7cd08
> [ 1487.261954] Code: Unable to access opcode bytes at 0x7f6ee1a7ccde.
> [ 1487.262691] RSP: 002b:00007ffdb391b628 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000e7
> [ 1487.263484] RAX: ffffffffffffffda RBX: 00007f6ee1ba7fc8 RCX: 00007f6ee1a7cd08
> [ 1487.264266] RDX[ 1487.359221] R10: 00007ffdb391b420 R11:
> 0000000000000206 R12: 0000000000000001
> [ 1487.365268] R13: 0000000000000001 R14: 00007f6ee1ba6680 R15: 00007f6ee1ba7fe0
> [ 1487.366071]  </TASK>
> [ 1487.366251] Modules linked in: nvmet_tcp nvmet nvme_tcp
> nvme_fabrics nvme nvme_core nvme_keyring nvme_auth rtrs_core rdma_cm
> iw_cm ib_cm ib_core hkdf rfkill sunrpc amd64_edac edac_mce_amd
> ipmi_ssif acpi_power_meter acpi_ipmi ipmi_si ipmi_devintf kvm
> irqbypass i2c_piix4 ipmi_msghandler hpilo tg3 acpi_cpufreq i2c_smbus
> fam15h_power k10temp pcspkr loop fuse nfnetlink zram lz4hc_compress
> lz4_compress xfs ata_generic pata_acpi polyval_clmulni
> ghash_clmulni_intel hpsa mgag200 serio_raw i2c_algo_bit
> scsi_transport_sas hpwdt sp5100_tco pata_atiixp i2c_dev [last
> unloaded: nvmet]
> [ 1487.369378] ---[ end trace 0000000000000000 ]---
> [ 1487.373697] ERST: [Firmware Warn]: Firmware does not respond in time.
> [ 1487.374212] pstoreffff R08: ffffffff963c0658 R09: 0000000000200000
> [ 1487.775150] R10: 00007f6ee0c05000 R11: ffff8ca4772ec000 R12: 00007f6ee0a05000
> [ 1487.776024] R13: ffffd4108e577b98 R14: ffff8ca241389800 R15: ffffd4108e577b40
> [ 1487.776853] FS:  00007f6ee1bfa840(0000) GS:ffff8ca6a1838000(0000)
> knlGS:0000000000000000
> [ 1487.777313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1487.778210] CR2: 00007f6ee1a7ccf0 CR3: 0000000441bcf000 CR4: 00000000000406f0
> [ 1487.778978] Kernel panic - not syncing: Fatal exception
> [ 1487.779714] Kernel Offset: 0x11a00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 1487.814610] ---[ end Kernel panic - not syncing: Fatal exception ]---
> [-- MARK -- Mon Nov 17 21:35:00 2025]

The usual:

1) is it reproducible just re-running the test?
2) if so, please bisect

-- 
Jens Axboe


