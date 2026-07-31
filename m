Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C59C55174
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xATEhxPNQxKXaG8sP+LX++AZXbUnFoZsLWamigGd8LI=; b=3K/YLMdV8Onmxpk8PMbSBtbp34
	/3UUNyctSjFlBUh8qyY4SPC4qkYbOMYRqS+36OikWGhlhrFxogKtNsgW9RrgHivGtTL1e5nC4LRA1
	cICm4pDrOzL9n+su6zyqdqwJV82qX9VDbSd2/Gl4hH6f19F7tg1TFrZebtpV4NLVJ/A6ahkp9gfEP
	gmCPiGZJ91VkLMpBaRY4/rteajvful1YIPEX0ptTsMbecmx9JKCElK7QDPXJuawzemneTwrFWDrBF
	/GO45MXNowSO3756/TVldc0cMSY0lDu7dTEdy8YX7GaYDGztsxrqsxgSErHOV8pBHF7JNmsTPexaA
	VdpxwjTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpu6g-0000000DZE9-0luh;
	Fri, 31 Jul 2026 20:45:26 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpu6Z-0000000DZDf-0Lam
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 20:45:20 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-902fc790cd5so9687646d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785530717; x=1786135517; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xATEhxPNQxKXaG8sP+LX++AZXbUnFoZsLWamigGd8LI=;
        b=JscC2ziBqIdppF6OCRgR4bBQ7FmfaCKBsaWkxbArG6ddz8UhzQS6rMUm3iI/+flpKs
         XRQqYROxh/q9+FtDSXAg2BxVPRSpEJlvJn9F8WFj8O1p5CgnnzibCBeR0V5ncctYP2eV
         BrlaI4rGdcaILmkozPkAwDyHC3s6+n6jmTQz7hxGjBC/tnsYhKrPG6HU4Dqg3LFF3dGz
         SD1KnEqLXSN5WqODfeOugJ/0hGGC4ahiCtUq5Mmi/1W/sILw4ed4VGfycI0B6x/B5som
         EHjVfeV76WFk41Aq55XQBFAqj7GeWwP/8wTCTjc8CrZBvmxxhRCLtdegtNtEjB865WqI
         OOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785530717; x=1786135517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xATEhxPNQxKXaG8sP+LX++AZXbUnFoZsLWamigGd8LI=;
        b=AzE6QUNFpl/1PmfgLcVzRQx45SdWfPY23omRZrtjQMmdhKXPVrYJa0XEdg8g3oY/Nd
         x+hrWv92hdOpCfTTqJp0Q644kvulXlPckjl44eGd9u6zC9rOscGVM5DsL2wkLT8WKrWH
         y9PltoLZmwMepqZysa60fD6Z+8NsV3HKS8gmnF/n394RLVAU3oVVwIRKeZ/Tx12C2PUO
         tNzz5s6w6IMCqSPXg+ZgbHZBbZlpuckLIVyKWw3ilabtSon4Sj/SbbKknZ0IhE7DqhVn
         uFeH0FkuGi34SQnmQNsK/N1Wro74Katov52KZsIba+CuVBcbw26ZFmTDgyHcaaB8BN/Q
         JVuQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4KsBUZvTOQ1ByTszJCpHbvSConaveVp6y6GBToONOLogcmj3WZ8Cp6DUp11OXVTa5SAvPZ5Mw1e3o@lists.infradead.org
X-Gm-Message-State: AOJu0YzWzzpyQyxDKrMZswWVXDUGiZ39huHjCed4i/ubC3Sr0hhhxCAb
	lNh+md6FU/oF6Fk0GePbOMUtymZFfnwuRjDiDAjsPvYGPkUjzuQq8fM8
X-Gm-Gg: AR+sD10kY8eMMaIYotDlDDuPXbI9Eh/+gXZr5R21Hl5em2cLfS/vn/rsxCPS54fZNcy
	CNWPt/gh7NRV/WDnarP/tS5ks2JhUnPCgELx45cP3smuC0rE2Z1EYJVCFWtcEvNc5X0wgX30dp/
	wGQjQggVo3ZmmHfyh0Aff24kQaY0QKGCTGENK9ngFDf54OHAc6JZ+aRqpbM2EkhCx5EL8kuRGX4
	6DiqjtWlSQecBluyQktJpZBUooH2h7Am49F+F0/qlHWT3iERwwi6iIELo14KGg74uNjtF48v3Fw
	b31IL67SaUpuMexQEcsS4pzbzfOL4O38lfUSjDL4S4raV4tfjyTKDLz0ySRl6SC30QwXZYMFOLe
	pyP8yRCfHuzCbxzE2oOS6f5p2ppqFFlWSdeRaRqtYpz5yRgT+uTH6K62c1uB0ElKEXeEFIbuAku
	DkM8ndXL3XtnGZ8ITiL2bOlUJ6P70NnPeJSkwWZgMaE8JveYoJiCbnfevlNgxn9vUufTUrKFmaa
	5+4C44FsHkQA3CwBg==
X-Received: by 2002:ad4:5944:0:b0:8f1:323a:fc45 with SMTP id 6a1803df08f44-908495fbc7dmr21340776d6.15.1785530717136;
        Fri, 31 Jul 2026 13:45:17 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435def8fsm18173676d6.38.2026.07.31.13.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 13:45:16 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] nvmet-fc: KASAN: slab-use-after-free in nvmet_fc_handle_ls_rqst_work
Date: Fri, 31 Jul 2026 16:44:47 -0400
Message-ID: <20260731204504.2396434-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_134519_130835_1D368FD0 
X-CRM114-Status: UNSURE (   8.00  )
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

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in nvmet_fc_handle_ls_rqst_work

on commit: 0d6269a4f6059d185d9f7e3efe7b58f8c0d9faf3 (2026-07-27)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds a delay and a printk.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/47cf6fb1b80e28f3c30a372333d1151e

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  405.999314][ T1167] BUG: KASAN: slab-use-after-free in nvmet_fc_handle_ls_rqst_work (drivers/nvme/target/fc.c:193 drivers/nvme/target/fc.c:1841 drivers/nvme/target/fc.c:1995 drivers/nvme/target/fc.c:2021)
[  406.000605][ T1167] Read of size 8 at addr ffff888179f1b000 by task kworker/u9:2/1167
[  406.001734][ T1167]
[  406.002128][ T1167] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  406.002134][ T1167] Workqueue: nvmet-wq nvmet_fc_handle_ls_rqst_work
[  406.002165][ T1167] Call Trace:
[  406.002182][ T1167]  <TASK>
[  406.002187][ T1167]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  406.002201][ T1167]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  406.002220][ T1167]  kasan_report (mm/kasan/report.c:595)
[  406.002232][ T1167]  nvmet_fc_handle_ls_rqst_work (drivers/nvme/target/fc.c:193 drivers/nvme/target/fc.c:1841 drivers/nvme/target/fc.c:1995 drivers/nvme/target/fc.c:2021)
[  406.002238][ T1167]  process_scheduled_works (kernel/workqueue.c:3322 kernel/workqueue.c:3405)
[  406.002250][ T1167]  worker_thread (kernel/workqueue.c:3486)
[  406.002280][ T1167]  kthread (kernel/kthread.c:436)
[  406.002296][ T1167]  ret_from_fork (archkernel/process.c:158)
[  406.002320][ T1167]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  406.002328][ T1167]  </TASK>
[  406.002330][ T1167]
[  406.020787][ T1167] Freed by task 1167 on cpu 0 at 405.998150s:
[  406.021660][ T1167]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  406.022343][ T1167]  kasan_save_free_info (mm/kasan/generic.c:584)
[  406.023069][ T1167]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  406.023749][ T1167]  kfree (include/linux/kasan.h:235 mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
[  406.024312][ T1167]  nvmet_fc_handle_ls_rqst_work (drivers/nvme/target/fc.c:1808 drivers/nvme/target/fc.c:1995 drivers/nvme/target/fc.c:2021)
[  406.025172][ T1167]  process_scheduled_works (kernel/workqueue.c:3322 kernel/workqueue.c:3405)
[  406.025972][ T1167]  worker_thread (kernel/workqueue.c:3486)
[  406.026653][ T1167]  kthread (kernel/kthread.c:436)
[  406.027248][ T1167]  ret_from_fork (archkernel/process.c:158)
[  406.027931][ T1167]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  406.028638][ T1167]
[  406.028989][ T1167] The buggy address belongs to the object at ffff888179f1b000
[  406.028989][ T1167]  which belongs to the cache kmalloc-2k of size 2048
[  406.031005][ T1167] The buggy address is located 0 bytes inside of
[  406.031005][ T1167]  freed 2048-byte region [ffff888179f1b000, ffff888179f1b800)


Best,
Shuangpeng

