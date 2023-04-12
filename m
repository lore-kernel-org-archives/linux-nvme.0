Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E03C77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hEe8hBiVZGVRUXUAkMcCqAaNuITvRlmRpl8r5dCVshg=; b=OZdyDUBoqUbDSKa7n27JhB1iEV
	+sJH0ubiuVmSC+rgRbo03847Zco1WzPqf1vPQ3SULRHrMeSiyNGbZVEyp7Do+9g/zNesoWLcRNl0V
	BXQpHPmqgHGaaT7e7lt8+aD3KIy/g16qctNHsKoyijbntLO0ByZEDw/6MEJKCo5/U+NXWfy3RRH9B
	yttQrhsF4Ct76G8kkmeqPM1pobXm8vS2XrnqiCHA6k4+LHCUGbXdzXzuGqXoj8mJ3l/XaaxWoCfmN
	D9iyHg393XnGwzxhdGCfZscrKGbOtFCTgMNd6vG5pFBszkRf9YajeoUUeVOkPXNDmz5gt4+uQXqtl
	jnDzrMIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmWu4-002PmG-2r;
	Wed, 12 Apr 2023 09:36:36 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmWu0-002Pkp-2d
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 09:36:34 +0000
Received: by mail-pl1-x62e.google.com with SMTP id o2so10756827plg.4
        for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681292190; x=1683884190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEe8hBiVZGVRUXUAkMcCqAaNuITvRlmRpl8r5dCVshg=;
        b=PzgdQoD7GRwakzmnius/pVnn/MEJkpuxqLlcv4YI5JxwsM5o94j/w79dq+SXJjGnnn
         qiYW/G2J2ECCalgKPZ2Gti5Yk7bHuZ/o7BMWGqjVeMjAySBujXkOp4czKaXJGHGQlh5V
         Pqkuvzyndfb676K7q4qm5PykjXhTIdI8H8grnDSjsAVQ8ltgn1q0eOOUF1tiqWC3biE/
         fRyE1wAPLTldTBykEqHWg38KZQBhPlFgh5IJyog9NoggDVYjkKCji2wf7GHAkNk1zPCo
         QhZYnTVeZlEvcoOVlfQizqxoi4/qi7gIz+BTrTQQEMM9XwRCCcogvLFdwvNSqstlLwQK
         t7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681292190; x=1683884190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEe8hBiVZGVRUXUAkMcCqAaNuITvRlmRpl8r5dCVshg=;
        b=1UTeJfErQoY/6/QSp3Bdo6wFj/ujZXjZFzLqbLh2J7xDIrs7r653D9837YBg8+UTFL
         LSTuaf9ovVpYHzzoh8KyubTysYwQ7TMIIbDL/VPa8T4CLQ8UNtX05BGMLG7lKqzJuKxP
         v6W1XLyuzKx5FXVDWGLGPgSJlXpexnB6spSATMWiapDpu1cjg5nev0+xveHytixMrwt9
         WkBYqEbR0GWv5IMePJrku5lls1zT78cUMgaVoqR1ENCmJWKGJOmCEhwljgUHZm3dIbfJ
         pS4fp66rpUKR9s52K0Jar+42i6vukX55UEffnR5yAKEbPCfspARcNUxM0FgnMMogLM4p
         W1Iw==
X-Gm-Message-State: AAQBX9dvHlTz40PYFQ5HwIgUX2JYfpLb1PFbJTbQdaxNsKD3cZrjV84R
	duiph1x/vHD+zjP3+0z6WNhfyw==
X-Google-Smtp-Source: AKy350Yuyqi9PvDH0Vwd39k3KHlVJ83Rk7wT+lEZyICoZ0hcAReJ0KiGRGXsrOp6YBiITphPH0p+sQ==
X-Received: by 2002:a17:90a:5b:b0:233:feb4:895f with SMTP id 27-20020a17090a005b00b00233feb4895fmr18452539pjb.44.1681292189750;
        Wed, 12 Apr 2023 02:36:29 -0700 (PDT)
Received: from localhost.localdomain ([124.123.191.81])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001a183ade911sm11109741plt.56.2023.04.12.02.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 02:36:29 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: michael.christie@oracle.com
Cc: axboe@kernel.dk,
	bvanassche@acm.org,
	chaitanyak@nvidia.com,
	dm-devel@redhat.com,
	hch@lst.de,
	james.bottomley@hansenpartnership.com,
	kbusch@kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com,
	snitzer@kernel.org,
	target-devel@vger.kernel.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	halbuer@sra.uni-hannover.de,
	keescook@chromium.org,
	akpm@linux-foundation.org,
	kirill.shutemov@linux.intel.com,
	willy@infradead.org,
	mkoutny@suse.com,
	roman.gushchin@linux.dev,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	yuzhao@google.com,
	zokeefe@google.com
Subject: [PATCH v6 00/18] Use block pr_ops in LIO
Date: Wed, 12 Apr 2023 15:06:17 +0530
Message-Id: <20230412093617.285177-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230407200551.12660-1-michael.christie@oracle.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_023632_860637_C089CB8F 
X-CRM114-Status: GOOD (  10.77  )
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

[sorry for the adding you in CC]

While running LTP controllers test suite on this patch set applied on top of
the next-20230406 and the following kernel panic noticed on qemu-i386.

crash log:
---------
pids 1 TINFO: timeout per run is 0h 25m 0s
pids 1 TINFO: test starts with cgroup version 1
pids 1 TINFO: Running testcase 6 with 10 processes
pids 1 TINFO: set a limit that is smaller than current number of pids
<6>[  782.211806] cgroup: fork rejected by pids controller in /ltp/test-2724
pids 1 TPASS: fork failed as expected
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2760 Killed                  pids_task2
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2761 Killed                  pids_task2
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2762 Killed                  pids_task2
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2763 Killed                  pids_task2
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2764 Killed                  pids_task2
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2765 Killed                  pids_task2
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2766 Killed                  pids_task2
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2767 Killed                  pids_task2
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2768 Killed                  pids_task2
/opt/ltp/testcases/bin/tst_test.sh: line 150:  2769 Killed                  pids_task2
<4>[  782.594441] int3: 0000 [#1] PREEMPT SMP
<4>[  782.594783] CPU: 1 PID: 2724 Comm: pids.sh Not tainted 6.3.0-rc5-next-20230406 #1
<4>[  782.594915] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
<4>[  782.595168] EIP: get_page_from_freelist+0x157/0xccc
<4>[  782.595745] Code: 48 04 8d 43 08 85 c9 0f 85 fe 07 00 00 3b 73 0c 0f 82 f5 07 00 00 89 45 c8 8b 45 c8 8b 00 89 45 e0 85 c0 0f 84 fc 07 00 00 3e <8d> 74 26 00 8b 45 cc 80 78 14 00 0f 84 90 05 00 00 8b 45 e0 8b 58
<4>[  782.595850] EAX: 00000000 EBX: c7ab5ce4 ECX: 00000800 EDX: 00000000
<4>[  782.595889] ESI: 00400dc0 EDI: 00000000 EBP: c7ab5c78 ESP: c7ab5c04
<4>[  782.595928] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000297
<4>[  782.596017] CR0: 80050033 CR2: 086d1d54 CR3: 06eaa000 CR4: 000006d0
<4>[  782.596188] Call Trace:
<4>[  782.596503]  ? exc_int3+0x10/0x130
<4>[  782.596630]  ? __irq_exit_rcu+0x15/0xcc
<4>[  782.596655]  ? sysvec_call_function+0x3c/0x3c
<4>[  782.596677]  ? __irq_exit_rcu+0x15/0xcc
<4>[  782.596694]  ? irqentry_exit+0x26/0x58
<4>[  782.596733]  __alloc_pages+0x156/0xf50
<4>[  782.596783]  ? handle_exception+0x133/0x133
<4>[  782.596817]  ? __rcu_read_unlock+0x1e/0x30
<4>[  782.596843]  ? sysvec_call_function+0x3c/0x3c
<4>[  782.596880]  ? __irq_exit_rcu+0x15/0xcc
<4>[  782.596903]  pte_alloc_one+0x23/0x88
<4>[  782.596928]  __pte_alloc+0x21/0xb0
<4>[  782.596981]  ? trace_hardirqs_on+0x2c/0x88
<4>[  782.597002]  copy_page_range+0x67d/0xb40
<4>[  782.597049]  ? mas_wr_modify+0x10e/0x364
<4>[  782.597069]  ? mod_objcg_state+0x99/0x378
<4>[  782.597103]  ? mas_wr_store_entry.isra.0+0x10c/0x534
<4>[  782.597127]  ? mas_store+0x45/0xb0
<4>[  782.597160]  copy_process+0x1de6/0x1f9c
<4>[  782.597179]  ? lockref_get_not_dead+0x2c/0x38
<4>[  782.597246]  kernel_clone+0xc1/0x3dc
<4>[  782.597279]  __ia32_sys_clone+0x71/0x8c
<4>[  782.597320]  __do_fast_syscall_32+0x4c/0xb8
<4>[  782.597340]  do_fast_syscall_32+0x32/0x74
<4>[  782.597361]  do_SYSENTER_32+0x15/0x24
<4>[  782.597381]  entry_SYSENTER_32+0x98/0xf1
<4>[  782.597484] EIP: 0xb7f3e579
<4>[  782.597838] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
<4>[  782.597856] EAX: ffffffda EBX: 01200011 ECX: 00000000 EDX: 00000000
<4>[  782.597876] ESI: 00000000 EDI: b7f398e8 EBP: b7f01e3c ESP: bfa4599c
<4>[  782.597889] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000286
<4>[  782.598167] Modules linked in:
<4>[  782.616852]  ---[ end trace 0000000000000000 ] ---
<4>[  782.616998] EIP: get_page_from_freelist+0x157/0xccc
<4>[  782.617213] Code: 48 04 8d 43 08 85 c9 0f 85 fe 07 00 00 3b 73 0c 0f 82 f5 07 00 00 89 45 c8 8b 45 c8 8b 00 89 45 e0 85 c0 0f 84 fc 07 00 00 3e <8d> 74 26 00 8b 45 cc 80 78 14 00 0f 84 90 05 00 00 8b 45 e0 8b 58
<4>[  782.617234] EAX: 00000000 EBX: c7ab5ce4 ECX: 00000800 EDX: 00000000
<4>[  782.617247] ESI: 00400dc0 EDI: 00000000 EBP: c7ab5c78 ESP: c7ab5c04
<4>[  782.617260] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000297
<4>[  782.617276] CR0: 80050033 CR2: 086d1d54 CR3: 06eaa000 CR4: 000006d0
<0>[  782.617472] Kernel panic - not syncing: Fatal exception in interrupt
<0>[  782.619115] Kernel Offset: disabled


Crash log details,
https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230404140835_25166-1-sergei_shtepa_veeam_com/testrun/16171777/suite/log-parser-test/test/check-kernel-panic/details/
https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230404140835_25166-1-sergei_shtepa_veeam_com/testrun/16171777/suite/log-parser-test/test/check-kernel-panic/log

Build artifacts links,
https://storage.tuxsuite.com/public/linaro/anders/builds/2OGpRflnb14kT3aJdPte4NdjKoT/
vmlinux: https://storage.tuxsuite.com/public/linaro/anders/builds/2OGpRflnb14kT3aJdPte4NdjKoT/vmlinux.xz
System.map: https://storage.tuxsuite.com/public/linaro/anders/builds/2OGpRflnb14kT3aJdPte4NdjKoT/System.map


steps to reproduce:
# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.41.0
#
# See https://tuxrun.org/ for complete documentation.

tuxrun   \
 --runtime podman   \
 --device qemu-i386   \
 --kernel https://storage.tuxsuite.com/public/linaro/anders/builds/2OGpRflnb14kT3aJdPte4NdjKoT/bzImage   \
 --modules https://storage.tuxsuite.com/public/linaro/anders/builds/2OGpRflnb14kT3aJdPte4NdjKoT/modules.tar.xz   \
 --rootfs https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2OFRZUbhWDZYvEcYrKKj1AJ618K/images/intel-core2-32/lkft-tux-image-intel-core2-32-20230410193126.rootfs.ext4.gz   \
 --parameters SKIPFILE=skipfile-lkft.yaml   \
 --parameters SHARD_NUMBER=10   \
 --parameters SHARD_INDEX=10   \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f   \
 --tests ltp-controllers   \
 --timeouts boot=15 ltp-controllers=80


--
Linaro LKFT
https://lkft.linaro.org


