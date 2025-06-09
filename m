Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56154C61DB2
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 09:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R2iT7iF2nHxwIVe6zuobE+mx4y8wK3yKHq9Y8EsWumM=; b=iaQ+/tSNGJCAMuUF7nEWOItQQO
	oRbCO/hgPNidCi1Md7VmhIWEDwLaRZjkd6Y8XbMZ+aYqvg/kj8Iuq12ab16iQqB16xNusf1Hy1eGJ
	mVRV/SgZ7nbWenyUWR5WYrW3TjDg/4T/hR8xLCJ9o9IxNqe7+qIG/80kIVVGD3t+g8rAfADV0ckKQ
	IIFCfV9OyCZRsG5BrSCiiEHyqwmHP7Tx24uGL/rwqlBVthumqrqJ6pR8+A2DHVKivbLtUaPAkn2bC
	nev7BTaBQPz1ojgcBmy9fkkYgK6bMpl/BvrKY+JTlIljNNVtaJJSQfeBVHjH86xykbe9UjUZtQxlp
	JqsmttgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOYga-00000003knZ-00ZP;
	Mon, 09 Jun 2025 09:20:56 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOYaI-00000003k5l-2sAp
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 09:14:36 +0000
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so4331640a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Jun 2025 02:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749460465; x=1750065265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2iT7iF2nHxwIVe6zuobE+mx4y8wK3yKHq9Y8EsWumM=;
        b=ikdzSs0sOtvxe7z1NN5sNmEJMv5OSommrIwAZXdruKmohmCMmroVc/3sW3F/iFXgYl
         I8xGBXss7grcX3XEjV8gtf6WznDxhrTd1j9hMdksmcMIJS8nXRDXw5g72ariblpPuivM
         9wH+fABtMm1XCMy/kRAB/JRl5KJ/lFHAGYdI1agTdE0B6uMrXMEeiNYrhClYTRTei7NM
         skZBMITCBxPGVE5BKiphyMPR0fCDjzxT4cCO1LRACqmMcJiFiLEAWpEXI3X7FuLpIwJg
         uRfUmmwIwPvddQ3BZy1UWJEIQ3tR1lXjogWc06W85kFH1TX9iA97CcHv76zq+h05cOmS
         gnSw==
X-Forwarded-Encrypted: i=1; AJvYcCVr3eO2OoE9GYHIoKbucbpbTa9uyMNxcsbwVkFMGqpR9TsWBsQYX3BAjrTVouFAa1OdeR8w6092B2Lu@lists.infradead.org
X-Gm-Message-State: AOJu0YwWMB4UaFyoqUdgTgI2PUXmN4nBTKYD4zxqlZKmThzOQ7ScEWEb
	ARgW/8oeUpDHqFq/2SQSRwvElgsr6QdK6WdjMSNoN1SvGAcNFMLephMn
X-Gm-Gg: ASbGncsGgYzmUbCzT64DKO0MbwqEmCIpMxUcUbwJeDUY6EARTfb+wLcdct5lPuSp3qB
	zWewyNaeXwlG/qFHiHR8d4P5zbXUzmPNMDnUyxjhkmsGn9Hb4ZnHH+8e4c627eZ8rN5pgQVX0bm
	e1dn09RJo4Ep83hKLFXsAO4Wv7D9a6Y29lmc0MhSFzpEHxI3UfPl7g92JeT+G7b2kuGLO5I8ho+
	MLEYKNuyMVztHt8ktNOLG8fKyA6LmuB4x90RmeQa2EKzfzdlcnFKlFh5xvH25o68VTA8LexGpKA
	etmtrDhrd7h/qC7l2lWU51ek0BtfCuDXiATfLKMmsA==
X-Google-Smtp-Source: AGHT+IEIEm4lkJ8D/XEv6ZKn8LexNHcO68JjMgPfSUTspNQS+bWq9F6yp+mQXlfmwvf5P8NqFrR+Zg==
X-Received: by 2002:a05:6402:50d0:b0:605:878:3557 with SMTP id 4fb4d7f45d1cf-60773fc9addmr11099080a12.16.1749460464839;
        Mon, 09 Jun 2025 02:14:24 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6077836ff6csm4482848a12.1.2025.06.09.02.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:14:24 -0700 (PDT)
Date: Mon, 9 Jun 2025 02:14:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	axboe@kernel.dk
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aEal7hIpLpQSMn8+@gmail.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_021426_728771_8F67AE9A 
X-CRM114-Status: GOOD (  10.23  )
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

On Fri, Jun 06, 2025 at 11:31:06AM +0800, Yi Zhang wrote:
> Hello
> 
> The following WARNING was triggered by blktests nvme/fc nvme/012,
> please help check and let me know if you need any info/test, thanks.
> 
> commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
> 'block-6.16' into for-next

I am seeing a similar issue on Linus' recent tree as e271ed52b344
("Merge tag 'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").
CCing Jens.

This is my stack, in case it is useful.

           WARNING: CPU: 33 PID: 1865 at block/genhd.c:146 bdev_count_inflight_rw+0x334/0x3b0
           Modules linked in: sch_fq(E) tls(E) act_gact(E) tcp_diag(E) inet_diag(E) cls_bpf(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) mlx5_ib(E) iTCO_wdt(E) iTCO_vendor_support(E) xhci_pci(E) evdev(E) irqbypass(E) acpi_cpufreq(E) ib_uverbs(E) ipmi_si(E) i2c_i801(E) xhci_hcd(E) i2c_smbus(E) ipmi_devintf(E) wmi(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)
           CPU: 33 UID: 0 PID: 1865 Comm: kworker/u144:14 Kdump: loaded Tainted: G S          E    N  6.15.0-0_fbk701_debugnightly_rc0_upstream_12426_ge271ed52b344 #1 PREEMPT(undef) 
           Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE, [N]=TEST
           Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
           Workqueue: writeback wb_workfn (flush-btrfs-1)
           RIP: 0010:bdev_count_inflight_rw+0x334/0x3b0
           Code: 75 5c 41 83 3f 00 78 22 48 83 c4 40 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 41 0f b6 06 84 c0 75 54 41 c7 07 00 00 00 00 eb bb <0f> 0b 48 b8 00 00 00 00 00 fc ff df 0f b6 04 03 84 c0 75 4e 41 c7
           RSP: 0018:ffff8882ed786f20 EFLAGS: 00010286
           RAX: 0000000000000000 RBX: 1ffff1105daf0df3 RCX: ffffffff829739f7
           RDX: 0000000000000024 RSI: 0000000000000024 RDI: ffffffff853f79f8
           RBP: 0000606f9ff42610 R08: ffffe8ffffd866a7 R09: 1ffffd1ffffb0cd4
           R10: dffffc0000000000 R11: fffff91ffffb0cd5 R12: 0000000000000024
           R13: 1ffffffff0dd0120 R14: ffffed105daf0df3 R15: ffff8882ed786f9c
           FS:  0000000000000000(0000) GS:ffff88905fd44000(0000) knlGS:0000000000000000
           CR2: 00007f904bc6d008 CR3: 0000001075c2b001 CR4: 00000000007726f0
           PKRU: 55555554
           Call Trace:
            <TASK>
            bdev_count_inflight+0x28/0x50
            update_io_ticks+0x10f/0x1b0
            blk_account_io_start+0x3a0/0x690
            blk_mq_submit_bio+0xc7e/0x1940
            __submit_bio+0x125/0x3c0
            ? lock_release+0x4a/0x3c0
            submit_bio_noacct_nocheck+0x3cf/0xa30
            btree_write_cache_pages+0x5eb/0x870
            do_writepages+0x307/0x4d0
            ? rcu_is_watching+0xf/0xa0
            __writeback_single_inode+0x106/0xd10
            writeback_sb_inodes+0x53d/0xd60
            wb_writeback+0x368/0x8d0
            wb_workfn+0x3aa/0xcf0
            ? rcu_is_watching+0xf/0xa0
            ? trace_irq_enable+0x64/0x190
            ? process_scheduled_works+0x959/0x1450
            process_scheduled_works+0x9fe/0x1450
            worker_thread+0x8fd/0xd10
            kthread+0x50c/0x630
            ? rcu_is_watching+0xf/0xa0
            </TASK>
           irq event stamp: 0
           hardirqs last disabled at (0): [<ffffffff81401f85>] copy_process+0x655/0x32d0
           softirqs last  enabled at (0): [<ffffffff81401f85>] copy_process+0x655/0x32d0

