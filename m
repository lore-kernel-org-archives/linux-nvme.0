Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AA0C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CcYYNtaDxHlH75DVzktS520/qEGVSpcAU/4xvgOpO10=; b=2QkLccnFwHhsbMLpBuIaT9i5dc
	Wr6sakz7GyBAyAZUTxHafiTEmkzCWe2Fg9KdM5sRPEoUUCJ+PPt9BHnG2dh6w0jRtJOacyC8vcyT+
	dNzxjPSHBTWW7WAsUzGN+sDkfqIknnB7673W9a5Vr0RoERofu/uoN53ZmFw8MQdmLYXiQlDl2iQ4y
	Lx2azM4e58yIeALYuPT1PcfzPywFBlQuoSCJ9borYaqOr8uE1mDW8QvKDeAcr0mz7jybfcfPiyB2f
	NwBk0q9ql2ELufMO83MiIMuj+6AiE2mSOMO8FRInfDloXjYcpyZr7fZfgJ30qpDhUxdXpElOW9GkU
	vD82gNEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmYAh-002izN-0M;
	Wed, 12 Apr 2023 10:57:51 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmYAd-002ixG-0G
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 10:57:49 +0000
Received: by mail-pl1-x631.google.com with SMTP id 21so2776427plg.12
        for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681297064; x=1683889064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcYYNtaDxHlH75DVzktS520/qEGVSpcAU/4xvgOpO10=;
        b=i7rneX3b+KZfC/JY42g2UXg/jZCIZugN68wJy4Z1KJD193cGw8Hvs83yWHdvOw/+UL
         aG/7ZWotaY8dLOMOpf4a0a686XIq39aTHAcIHh/CvI3HFIdbAyhOn4xStHo4rWx6Ggvi
         vK6C/I8B5vgGMw3Srm4uHGrhYlUjPiG8Pu6IV6iFjHT3wsHHnNiNlXkSGus7uNW0HoyM
         ZG+cxWGWtAbKYuYEACTajY+7NMa97FLZFNImMvXsGAi6DRdiD2F1VDBCRy9Vt8YZCVtc
         mUik5AMV9ASbCmU8NuTKGrfP7mhSeQZC3OTuCvQ8s3Kf2iXdAVN49BBRoNCmYRvgDaB/
         T2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681297064; x=1683889064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcYYNtaDxHlH75DVzktS520/qEGVSpcAU/4xvgOpO10=;
        b=X7FW+HxH8EjJSQhnmN+JBh9KKVL+plXQWorWxqAOxVi4CCe//ZSuReyFEZvsQt0aFZ
         2Nh95n90OsEwRaE60YRsdkxjPD6GmaA4tW5FIM5HoxGFFkSbEBYXfReB2mrcVrglm69q
         RIL5tfJvUI8fH/KuXMolkGWWgtYXhkKinWv5sb+Af2Dr2EOkuCRSrHgFxtbPWAF965jz
         /ellMgszr0Fn1mPTS6ixst4zFpa5/KespjdHN1KKuJxxltABDdhXQiuvWV0Q/A2O6hzP
         eVF6xuMg78fwd8jMeXTQ4X5nYV1BXpHgpkbTXejbEBntWGVeRh2lxwpSv4IClSWCiS4n
         2q3Q==
X-Gm-Message-State: AAQBX9fT/e4GRWZkJpK0xXFKgXzae5Yy6sCz81/+paSTFDm8wTQ6h8uO
	H7fwbLUY19xfNFqA18+DI/ZytA==
X-Google-Smtp-Source: AKy350b6VhmArfjtfG5hPTUB1cljJ9QaEx7TyP53/04DDnKkbVZXFIF0jKcWKxQnKxuBsS2tM1Ls6A==
X-Received: by 2002:a17:902:fa05:b0:1a6:3af1:9c3a with SMTP id la5-20020a170902fa0500b001a63af19c3amr9987792plb.22.1681297063711;
        Wed, 12 Apr 2023 03:57:43 -0700 (PDT)
Received: from localhost.localdomain ([124.123.191.81])
        by smtp.gmail.com with ESMTPSA id p10-20020a1709026b8a00b001a6467cfbeasm4942246plk.53.2023.04.12.03.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 03:57:43 -0700 (PDT)
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
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	kirill.shutemov@linux.intel.com,
	willy@infradead.org,
	mkoutny@suse.com,
	roman.gushchin@linux.dev,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	yuzhao@google.com,
	zokeefe@google.com,
	lkft-triage@lists.linaro.org
Subject: [PATCH v6 00/18] Use block pr_ops in LIO
Date: Wed, 12 Apr 2023 16:27:34 +0530
Message-Id: <20230412105734.293024-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230407200551.12660-1-michael.christie@oracle.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_035747_138299_BDECC0FC 
X-CRM114-Status: GOOD (  10.44  )
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
the next-20230406 and the following kernel panic noticed on qemu-x86_64.


Lore link: https://lore.kernel.org/linux-block/20230407200551.12660-1-michael.christie@oracle.com/


cpuset_inherit 31 TPASS: mem_exclusive: Inherited information is right!
cpuset_inherit 33 TPASS: mem_hardwall: Inherited information is right!
<4>[ 1234.875309] int3: 0000 [#1] PREEMPT SMP PTI
<4>[ 1234.875748] CPU: 1 PID: 32990 Comm: umount Not tainted 6.3.0-rc5-next-20230406 #1
<4>[ 1234.875946] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
<4>[ 1234.876062] RIP: 0010:__alloc_pages+0xdf/0x310
<4>[ 1234.876666] Code: 4c 89 45 b0 83 3d b8 1c cb 01 00 0f 85 a2 01 00 00 44 89 f0 c1 e8 03 83 e0 03 89 75 a0 89 45 c0 be 01 00 00 00 4c 89 45 98 0f <1f> 44 00 00 4d 89 c5 44 89 f0 44 89 75 a4 41 f7 c6 00 04 00 00 74
<4>[ 1234.876885] RSP: 0000:ffff8b9305f47c10 EFLAGS: 00000202
<4>[ 1234.877418] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
<4>[ 1234.877433] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000140cca
<4>[ 1234.877446] RBP: ffff8b9305f47c78 R08: 0000000000000000 R09: 0000000000000000
<4>[ 1234.877460] R10: 0000000000100cca R11: 0000000000000000 R12: 0000000000000003
<4>[ 1234.877472] R13: ffff88d28b753b00 R14: 0000000000140cca R15: ffff88d2ffffb300
<4>[ 1234.877518] FS:  0000000000000000(0000) GS:ffff88d2fbd00000(0000) knlGS:0000000000000000
<4>[ 1234.877547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 1234.877568] CR2: 0000000000408ee0 CR3: 0000000111432000 CR4: 00000000000006e0
<4>[ 1234.877662] Call Trace:
<4>[ 1234.877828]  <TASK>
<4>[ 1234.877954]  __folio_alloc+0x1e/0x50
<4>[ 1234.878051]  vma_alloc_folio+0x4af/0x520
<4>[ 1234.878066]  ? _raw_spin_unlock+0x1a/0x40
<4>[ 1234.878079]  ? do_wp_page+0x164/0xdd0
<4>[ 1234.878093]  ? trace_preempt_on+0x1e/0x80
<4>[ 1234.878105]  ? preempt_count_sub+0x63/0x80
<4>[ 1234.878118]  do_wp_page+0x3cb/0xdd0
<4>[ 1234.878129]  ? handle_mm_fault+0x739/0x19e0
<4>[ 1234.878142]  ? _raw_spin_lock+0x23/0x50
<4>[ 1234.878159]  handle_mm_fault+0x770/0x19e0
<4>[ 1234.878170]  ? up_write+0x52/0xe0
<4>[ 1234.878196]  do_user_addr_fault+0x4d4/0x6c0
<4>[ 1234.878210]  ? trace_hardirqs_off_finish+0x38/0x90
<4>[ 1234.878222]  exc_page_fault+0x80/0x1d0
<4>[ 1234.878234]  asm_exc_page_fault+0x2b/0x30
<4>[ 1234.878291] RIP: 0033:0x7f3f910e65f6
<4>[ 1234.878542] Code: 2f 0a 00 00 e8 5b 23 ff ff 48 89 85 60 fd ff ff 48 8b 85 88 fd ff ff 48 8b 80 e8 00 00 00 48 85 c0 74 0b 48 8b 9d 68 fd ff ff <48> 89 58 08 48 8b 85 68 fd ff ff c7 40 18 01 00 00 00 e8 43 2b fe
<4>[ 1234.878552] RSP: 002b:00007fff6f8dce50 EFLAGS: 00000206
<4>[ 1234.878563] RAX: 0000000000408ed8 RBX: 00007f3f910fe0d8 RCX: 00007f3f910c6270
<4>[ 1234.878569] RDX: 0000000000000000 RSI: 00007f3f910fe2a0 RDI: 00007fff6f8dcf10
<4>[ 1234.878575] RBP: 00007fff6f8dd110 R08: 0000000000000000 R09: 0000000000000007
<4>[ 1234.878581] R10: 0000000000000000 R11: 0000000000000008 R12: 0000000000000000
<4>[ 1234.878585] R13: 00007f3f910fe2a0 R14: 00007fff6f8dced0 R15: 0000000000000000
<4>[ 1234.878636]  </TASK>
<4>[ 1234.878693] Modules linked in:
<4>[ 1234.894886] ---[ end trace 0000000000000000 ]---
<4>[ 1234.895879] RIP: 0010:__alloc_pages+0xdf/0x310
<4>[ 1234.895921] Code: 4c 89 45 b0 83 3d b8 1c cb 01 00 0f 85 a2 01 00 00 44 89 f0 c1 e8 03 83 e0 03 89 75 a0 89 45 c0 be 01 00 00 00 4c 89 45 98 0f <1f> 44 00 00 4d 89 c5 44 89 f0 44 89 75 a4 41 f7 c6 00 04 00 00 74
<4>[ 1234.895936] RSP: 0000:ffff8b9305f47c10 EFLAGS: 00000202
<4>[ 1234.895956] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
<4>[ 1234.895966] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000140cca
<4>[ 1234.895977] RBP: ffff8b9305f47c78 R08: 0000000000000000 R09: 0000000000000000
<4>[ 1234.895985] R10: 0000000000100cca R11: 0000000000000000 R12: 0000000000000003
<4>[ 1234.895993] R13: ffff88d28b753b00 R14: 0000000000140cca R15: ffff88d2ffffb300
<4>[ 1234.896003] FS:  0000000000000000(0000) GS:ffff88d2fbd00000(0000) knlGS:0000000000000000
<4>[ 1234.896016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 1234.896026] CR2: 0000000000408ee0 CR3: 0000000111432000 CR4: 00000000000006e0
<0>[ 1234.896379] Kernel panic - not syncing: Fatal exception in interrupt
<0>[ 1234.900046] Kernel Offset: 0x8800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Links:
https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230407200551_12660-1-michael_christie_oracle_com/testrun/16172098/suite/log-parser-test/test/check-kernel-panic/log
https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230407200551_12660-1-michael_christie_oracle_com/testrun/16172061/suite/log-parser-test/test/check-kernel-panic/log

https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230407200551_12660-1-michael_christie_oracle_com/testrun/16172098/suite/log-parser-test/tests/
https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230407200551_12660-1-michael_christie_oracle_com/testrun/16172061/suite/log-parser-test/tests/


Steps to reproduce:
-------------------

# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.41.0
#
# See https://tuxrun.org/ for complete documentation.

tuxrun   \
 --runtime podman   \
 --device qemu-x86_64   \
 --kernel https://storage.tuxsuite.com/public/linaro/anders/builds/2OGpdVeBBG4Gj6aACnSdSGva2LN/bzImage   \
 --modules https://storage.tuxsuite.com/public/linaro/anders/builds/2OGpdVeBBG4Gj6aACnSdSGva2LN/modules.tar.xz   \
 --rootfs https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2OFRZUnV2Q9jOFdE3gH3Gq2v692/images/intel-corei7-64/lkft-tux-image-intel-corei7-64-20230410193144.rootfs.ext4.gz   \
 --parameters SKIPFILE=skipfile-lkft.yaml   \
 --parameters SHARD_NUMBER=10   \
 --parameters SHARD_INDEX=10   \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f   \
 --tests ltp-controllers   \
 --timeouts boot=15 ltp-controllers=80



--
Linaro LKFT
https://lkft.linaro.org


