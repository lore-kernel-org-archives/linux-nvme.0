Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA26AC677C4
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fvJjs6LBFVMLMH2akdhDOGez5t7X3T0VJCXiFy6y0Us=; b=bfm++zH4X/P4J3rp0grhPW/oYX
	VfPJxv8pr5hKFAXqI1DIwKFPW6y49bcbutdlRS9EmT86M1dkBXmyMNfJLeRR0kt3CwYkCiaVXI8zS
	e/LjP70IWNxgyuciBdH9+OGrIZEOT3mhpqRocz1vH4wkld6ETprwLnUIQUvrIsjM5rw3GDMQOHySM
	aDXgMEYfbLCrNKQM5y82tMjYYKx+lSxT3FiEpygc2VsYw72f8k8CQ8X+FnlGk+51SCONZ8kY8UUqY
	YiRDYx3mTu7eqt5A8ZoMRhkG6RpPE4IR8c9D+SinB7jFsLuEzvtn8loYc4NSOLRgJ/OMs/2RsJ+LC
	MpSk2imA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP4mi-00000007vvR-0zBU;
	Tue, 10 Jun 2025 19:37:24 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP1TP-00000007Pqd-0P8m
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 16:05:16 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so6643148a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Jun 2025 09:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571513; x=1750176313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvJjs6LBFVMLMH2akdhDOGez5t7X3T0VJCXiFy6y0Us=;
        b=p0KWtj5bUZrgd5oUn9t6icODkt8kEZ0VQTXh6wIMX3qWSoFHmJdPWFEZTOzM9m9p3h
         LAhCwvFRY57BGMn7RAReLBaSb/P8uObc6w/Hi97uzzkpSS88LGzUSfhtmjNT2JD53kmD
         SI3gjimi6qz72DJsuRV4mfHR/EkGrO3hYE+oGHOZcjMDPk2u074sMNeUiAJx+pTJMPON
         I1phCwdM9MFWOWxJfNPyJrT6aHB+k8Z89/ePghng5uPa0k9RfFEM5bEHSNo2IjN/WZKZ
         HZrWQzw3vLYnkDEEl68HVQCouhW0b8VrCA/tvpfHum2v1PWGnHDDm50fi6Gt9rVlk+Ra
         zbEg==
X-Forwarded-Encrypted: i=1; AJvYcCVs4nDWrHvn5hu+GE+z1V5u2vCUJoIQVCMPOk6Q4MvVNp9HqqFMyDwS6G1ckDNhauhW4RSd/tJY4K6t@lists.infradead.org
X-Gm-Message-State: AOJu0YwgvPvgZQbvTh/LkxWZLABSjA2OCbYYmULvBDkNnnyU0i1Od++D
	rmhm/qCUc6Vcp8M1tIkfX7rA656bvQAEJ0k+DJ6V4Iv1ux7bOic9id3d
X-Gm-Gg: ASbGncvYy10hFV6N5t2Z2S9KlCHm+s5iTGx5s1tbtTTLiHdLMfoRxB9ju2BOXU3IG6r
	pMb7oQPseBkpO5+ycjMW1sAfTkCZr/qSlMRlOOBynsuaodlgRFm85InxLa6EOKjivdPHT+b76BI
	A1DjxcGw3NTQmLpjEi9hg45iUusUKMj9unBgOCKHpp3fu7hic8imt9EaLGPu0Ji0+Ii3EsNcCcd
	RiVUCZd/G+VjAmN60jhXc2uHgXpeSqS5BD5ZT/pflTDEr9W5WPvdgiwOFcLNVTy/Mt1suAHpVpv
	kgJTHIFTuBVcWJb4FqBvmRS4RkmqBKF0XEguBYiqdHRJtZWbudzOKyg++pBfOr8=
X-Google-Smtp-Source: AGHT+IHQN6mmxC4dHUbaDYyYUFRlXAlJ0DovWuXCTrFjlt95FRM/5Laisua8CzaG6WLb83WsM4jdYA==
X-Received: by 2002:a17:906:478a:b0:ad8:9084:4ec0 with SMTP id a640c23a62f3a-ade7ace0d05mr307500066b.35.1749571513356;
        Tue, 10 Jun 2025 09:05:13 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7b202sm735813266b.161.2025.06.10.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:05:12 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:05:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	axboe@kernel.dk, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aEhXtsiN9MGMBLbC@gmail.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <738f680c-d0e8-b6c0-cfaa-5f420a592c4f@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_090515_137029_9ADED3C6 
X-CRM114-Status: GOOD (  17.78  )
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

On Tue, Jun 10, 2025 at 10:07:47AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/06/09 17:14, Breno Leitao 写道:
> > On Fri, Jun 06, 2025 at 11:31:06AM +0800, Yi Zhang wrote:
> > > Hello
> > > 
> > > The following WARNING was triggered by blktests nvme/fc nvme/012,
> > > please help check and let me know if you need any info/test, thanks.
> > > 
> > > commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
> > > 'block-6.16' into for-next
> > 
> > I am seeing a similar issue on Linus' recent tree as e271ed52b344
> > ("Merge tag 'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").
> > CCing Jens.
> > 
> > This is my stack, in case it is useful.
> > 
> >             WARNING: CPU: 33 PID: 1865 at block/genhd.c:146 bdev_count_inflight_rw+0x334/0x3b0
> >             Modules linked in: sch_fq(E) tls(E) act_gact(E) tcp_diag(E) inet_diag(E) cls_bpf(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) mlx5_ib(E) iTCO_wdt(E) iTCO_vendor_support(E) xhci_pci(E) evdev(E) irqbypass(E) acpi_cpufreq(E) ib_uverbs(E) ipmi_si(E) i2c_i801(E) xhci_hcd(E) i2c_smbus(E) ipmi_devintf(E) wmi(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)
> >             CPU: 33 UID: 0 PID: 1865 Comm: kworker/u144:14 Kdump: loaded Tainted: G S          E    N  6.15.0-0_fbk701_debugnightly_rc0_upstream_12426_ge271ed52b344 #1 PREEMPT(undef)
> >             Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE, [N]=TEST
> >             Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
> >             Workqueue: writeback wb_workfn (flush-btrfs-1)
> >             RIP: 0010:bdev_count_inflight_rw+0x334/0x3b0
> >             Code: 75 5c 41 83 3f 00 78 22 48 83 c4 40 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 41 0f b6 06 84 c0 75 54 41 c7 07 00 00 00 00 eb bb <0f> 0b 48 b8 00 00 00 00 00 fc ff df 0f b6 04 03 84 c0 75 4e 41 c7
> >             RSP: 0018:ffff8882ed786f20 EFLAGS: 00010286
> >             RAX: 0000000000000000 RBX: 1ffff1105daf0df3 RCX: ffffffff829739f7
> >             RDX: 0000000000000024 RSI: 0000000000000024 RDI: ffffffff853f79f8
> >             RBP: 0000606f9ff42610 R08: ffffe8ffffd866a7 R09: 1ffffd1ffffb0cd4
> >             R10: dffffc0000000000 R11: fffff91ffffb0cd5 R12: 0000000000000024
> >             R13: 1ffffffff0dd0120 R14: ffffed105daf0df3 R15: ffff8882ed786f9c
> >             FS:  0000000000000000(0000) GS:ffff88905fd44000(0000) knlGS:0000000000000000
> >             CR2: 00007f904bc6d008 CR3: 0000001075c2b001 CR4: 00000000007726f0
> >             PKRU: 55555554
> >             Call Trace:
> >              <TASK>
> >              bdev_count_inflight+0x28/0x50
> >              update_io_ticks+0x10f/0x1b0
> >              blk_account_io_start+0x3a0/0x690
> >              blk_mq_submit_bio+0xc7e/0x1940
> 
> So, this is blk-mq IO accounting, a different problem than nvme mpath.
> 
> What kind of test you're running, can you reporduce ths problem? I don't
> have a clue yet after a quick code review.

I have a bunch of machines running some Meta prod workloads on them,
and this one was running a webserver.

Unfortunately I don't have a reproducer.

