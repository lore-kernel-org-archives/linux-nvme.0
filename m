Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EDAC4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:06:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075EE2075F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ejB+Bb+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075EE2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=djBBVDPX8Y8k6LJvORSPxRp3pYntw7nhG8qx+adOQ2M=; b=ejB+Bb+RJ0hHPamPie3JtTEN5
	MWayAphl8gASQ0cXwP00SKEYrel2navILAt+aXDRM+jM9RoITFS8fetmVbIb7FEU1PCiYlS4aXXar
	O/oT3FSIxo7Akx0/ugEVXr1zGGiOHI1y53nEF2gKpHOeYLE8YKyOq6FVF6dxo3pY9QX4dzVcQdgjx
	Q2MFUJ3H+LVUEsdaXQcUZrhCE5reJN7/hgE07UWDsBrA4sqli/ewd89I4VIDLCavmMKZlXJVWqJFD
	1k3LzwdCWPHDsxU4DEyXFmaforR60abrUmeHlfdK/cJ1x+BSw77D47u8t0Bxj1zbKI9UNTjzudqkd
	TyYZXG7iQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNAe0-00076a-GL; Tue, 29 Sep 2020 08:05:52 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNAdt-000747-G1
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:05:49 +0000
Received: by mail-pf1-f196.google.com with SMTP id k8so3760457pfk.2
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OOp2eggwr+MEptGPvHxUDM/tqKOqHF+SL8awGBW+QEc=;
 b=qloDTKngk5r4mbUr6vUSHoi8BGKkND4BpPMKRDGHWbQwGGLd7GwVrskxPoXqcPY74Z
 H2yrnCLxi94lDvY6B9AhyoMg7sreDHGEf1NIaJPWwQ/GaqpSa/3VtvINemXNcdLAGhX+
 0JgDfRXPgr8Gg6FkwgtS7NWUMp/ZC5TMuncsA8SReMwpJ4dSxgnnB0uc4wvD6Zx0rrwy
 XFu7VgdxRPT5WimTlTcmYP0Eij+D66fUUcucjXP/1Pxw+TtHPf02p1VnDGvHMk0x/VK9
 QOrovr9WhQke5TDmYh+wxs3mYV88znx3T7Wa7m8jveV3hehkY+Q1KO1XNNMna2UGeoaV
 9jBQ==
X-Gm-Message-State: AOAM533eUjeIEKekQvcmkF71sdOYSlD6QruADY/6UCTssT5/r23YeRS2
 YaL50/ZmFH3GEENwymstYqI=
X-Google-Smtp-Source: ABdhPJx4zz9t6V0NDHgJwTeA7wEubhI2NpmYngAPDu8xwZDwHYAXYdVNxv2+ULrG7v5JNpfK/Ju3+w==
X-Received: by 2002:a17:902:aa85:b029:d0:cbe1:e70d with SMTP id
 d5-20020a170902aa85b02900d0cbe1e70dmr3412225plr.27.1601366742184; 
 Tue, 29 Sep 2020 01:05:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id a14sm3621871pju.30.2020.09.29.01.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:05:41 -0700 (PDT)
Subject: Re: Kernel panic is seen while running iozone over multiple ports and
 toggling the link on TOT kernel
To: Dakshaja Uppalapati <dakshaja@chelsio.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>
References: <MW2PR12MB2587F8718D081D98B5E3D37BDD350@MW2PR12MB2587.namprd12.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <27ed95ad-4238-603c-da06-17a797308ff3@grimberg.me>
Date: Tue, 29 Sep 2020 01:05:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MW2PR12MB2587F8718D081D98B5E3D37BDD350@MW2PR12MB2587.namprd12.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_040545_571713_DC675D74 
X-CRM114-Status: GOOD (  16.58  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi all,
> I observed the following trace with TOT linux kernel while running NVMF over multiple ports and toggling the link/interface. Issue is observed very intermittently.

What is TOT linux kernel?

> Attached is the target configuration on actual disks.
> 
> On host, started iozone then toggling the multiport interface1 for 5 seconds and interface2 for 8 seconds one after the other in a loop
> Observed the below kernel panic after couple of hours.
> 
> [142799.524961] BUG: kernel NULL pointer dereference, address: 0000000000000198
> [142799.524965] #PF: supervisor write access in kernel mode
> [142799.524966] #PF: error_code(0x0002) - not-present page
> [142799.524967] PGD 0 P4D 0
> [142799.524970] Oops: 0002 [#1] SMP PTI
> [142799.524973] CPU: 1 PID: 16 Comm: ksoftirqd/1 Kdump: loaded Tainted: G S      W         5.9.0-rc6 #1
> [142799.524974] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0 01/28/2016
> [142799.524980] RIP: 0010:blk_mq_free_request+0x80/0x110
> [142799.524982] Code: 00 00 00 00 8b 53 18 b8 01 00 00 00 84 d2 74 0b 31 c0 81 e2 00 08 06 00 0f 95 c0 48 83 84 c5 80 00 00 00 01 f6 43 1c 40 74 08 <f0> 41 ff 8d 98 01 00 00 8b 05 5a 4a c4 01 85 c0 75 5e 49 8b 7c 24
> [142799.524983] RSP: 0018:ffffbb96c0123dc0 EFLAGS: 00010202
> [142799.524984] RAX: 0000000000000000 RBX: ffff9e6b70f60280 RCX: 0000000000000018
> [142799.524986] RDX: 0000000000000000 RSI: 000000000000000a RDI: ffff9e6b70f60280
> [142799.524987] RBP: ffffdb96be8fd400 R08: 0000000000000000 R09: 0000000000000000
> [142799.524988] R10: 00513cf381a1baf1 R11: 0000000000000000 R12: ffff9e6b590f7698
> [142799.524989] R13: 0000000000000000 R14: 0000000000000004 R15: ffffffff948050c0
> [142799.524990] FS:  0000000000000000(0000) GS:ffff9e6befc40000(0000) knlGS:0000000000000000
> [142799.524992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [142799.524993] CR2: 0000000000000198 CR3: 00000001d6a0a001 CR4: 00000000003706e0
> [142799.524994] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [142799.524995] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [142799.524995] Call Trace:
> [142799.525006]  nvme_keep_alive_end_io+0x15/0x70 [nvme_core]
> [142799.525011]  nvme_rdma_complete_rq+0x68/0xc0 [nvme_rdma]
> [142799.525014]  ? set_next_entity+0xae/0x1f0
> [142799.525016]  blk_done_softirq+0x95/0xc0
> [142799.525021]  __do_softirq+0xde/0x2ec
> [142799.525025]  ? sort_range+0x20/0x20
> [142799.525029]  run_ksoftirqd+0x1a/0x20
> [142799.525031]  smpboot_thread_fn+0xc5/0x160
> [142799.525034]  kthread+0x116/0x130
> [142799.525036]  ? kthread_park+0x80/0x80
> [142799.525040]  ret_from_fork+0x22/0x30
> 
> Keepalive request structure is freed and is accessed by nvme_keep_alive_end_io. looks like a probable race to me.
> 
> Thanks,
> Dakshaja
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
