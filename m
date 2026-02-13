Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CF2EF99E9
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 23:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G0u/IuCNWvSJPlla9QPP4kMmxoVzieNBHkIWAmPtgRc=; b=SzTWvwOV1x72lxh0foZVisFBIX
	7n/z3zwtZatUR5b/hYQF71NpWfvFb5uaCXo4yVyi6spX0A7lUV8p4q3GDvCKnlF4iwmXqmz2umt3i
	xAwBnr9U7+3Lr3gVCzIEI4wAIlt66Fn4dd0oO+FbMqXDGCuAXwaH2E7I4NazhzZoc1hCqjuoa25H1
	HvGR+nxjCSehVdGmc1ldWoS9o/CUAI8CHhqiAZYnulUA622zF1QqraKMHG7BfS3W8nkRLhmPeGSr1
	apU+GyxiJk1Ve6NEsGyLZRHmMKaOJ3CYyoPCGs4529+OOrGsBbm8hSZsBpytG5YG+x9F8y+2p5hO5
	2LbmO04A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr2jt-000000042ac-099n;
	Fri, 13 Feb 2026 23:38:21 +0000
Received: from out-189.mta0.migadu.com ([2001:41d0:1004:224b::bd])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr2jq-000000042Zg-0e00
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 23:38:19 +0000
Message-ID: <b8589b6b-504c-4fdb-b73b-83b9c97e65df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771025893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0u/IuCNWvSJPlla9QPP4kMmxoVzieNBHkIWAmPtgRc=;
	b=P7NNcXIdPcDZ58+AYdPbw5Z3ONI++aHW/pw1hK92qtUQMed4x8YZOqThUAXbMtzoF/5eoy
	JdtATkM0c7QB5T58X1JzqDFMmCFWJLc0kTEhJ/uJ8B9Lpi8Wd1Y44a+kyOPj6/Z1w7WCc2
	HR+DVY84GEc/kkzdnSO3Rs6ns34Rcvo=
Date: Fri, 13 Feb 2026 15:38:08 -0800
MIME-Version: 1.0
Subject: Re: blktests failures with v6.19 kernel
To: Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <aY7ZBfMjVIhe_wh3@shinmob>
 <5157497a-3536-4187-883e-19a54167955a@acm.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <5157497a-3536-4187-883e-19a54167955a@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_153818_404039_AE0D2B4C 
X-CRM114-Status: GOOD (  11.51  )
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

On 2/13/26 9:44 AM, Bart Van Assche wrote:
> On 2/12/26 11:57 PM, Shinichiro Kawasaki wrote:
>> [5] kmemleak at nvme/061 wiht rdma transport and siw driver
>>
>> unreferenced object 0xffff888114792600 (size 32):
>>    comm "kworker/2:1H", pid 66, jiffies 4295489358
>>    hex dump (first 32 bytes):
>>      c2 f6 83 05 00 ea ff ff 00 00 00 00 00 10 00 00  ................
>>      00 b0 fd 60 81 88 ff ff 00 10 00 00 00 00 00 00  ...`............
>>    backtrace (crc 3dbac61d):
>>      __kmalloc_noprof+0x62f/0x8b0
>>      sgl_alloc_order+0x74/0x330
>>      0xffffffffc1b73433
>>      0xffffffffc1bc1f0d
>>      0xffffffffc1bc8064
>>      __ib_process_cq+0x14f/0x3e0 [ib_core]
>>      ib_cq_poll_work+0x49/0x160 [ib_core]
>>      process_one_work+0x868/0x1480
>>      worker_thread+0x5ee/0xfd0
>>      kthread+0x3af/0x770
>>      ret_from_fork+0x55c/0x810
>>      ret_from_fork_asm+0x1a/0x30
> 
> There are no sgl_alloc() calls in the RDMA subsystem. I think the above
> indicates a memory leak in either the RDMA NVMe target driver or in the
> NVMe target core.

3a2c32d357db RDMA/siw: reclassify sockets in order to avoid false 
positives from lockdep
85cb0757d7e1 net: Convert proto_ops connect() callbacks to use 
sockaddr_unsized
0e50474fa514 net: Convert proto_ops bind() callbacks to use sockaddr_unsized

There are only three commits touching the siw driver between v6.18 and 
v6.19. I therefore suspect the issue is more likely in the NVMe side.

Best Regards,
Zhu Yanjun

> 
>> [7] kmemleak at zbd/009
>>
>> unreferenced object 0xffff88815f1f1280 (size 32):
>>    comm "mount", pid 1745, jiffies 4294866235
>>    hex dump (first 32 bytes):
>>      6d 65 74 61 64 61 74 61 2d 74 72 65 65 6c 6f 67  metadata-treelog
>>      00 93 9c fb af bb ae 00 00 00 00 00 00 00 00 00  ................
>>    backtrace (crc 2ee03cc2):
>>      __kmalloc_node_track_caller_noprof+0x66b/0x8c0
>>      kstrdup+0x42/0xc0
>>      kobject_set_name_vargs+0x44/0x110
>>      kobject_init_and_add+0xcf/0x140
>>      btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
>>      create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
>>      create_space_info+0x247/0x320 [btrfs]
>>      btrfs_init_space_info+0x143/0x1b0 [btrfs]
>>      open_ctree+0x2eed/0x43fe [btrfs]
>>      btrfs_get_tree.cold+0x90/0x1da [btrfs]
>>      vfs_get_tree+0x87/0x2f0
>>      vfs_cmd_create+0xbd/0x280
>>      __do_sys_fsconfig+0x64f/0xa30
>>      do_syscall_64+0x95/0x540
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> unreferenced object 0xffff888128d80000 (size 16):
>>    comm "mount", pid 1745, jiffies 4294866237
>>    hex dump (first 16 bytes):
>>      64 61 74 61 2d 72 65 6c 6f 63 00 4b 96 f6 48 82  data-reloc.K..H.
>>    backtrace (crc 1598f702):
>>      __kmalloc_node_track_caller_noprof+0x66b/0x8c0
>>      kstrdup+0x42/0xc0
>>      kobject_set_name_vargs+0x44/0x110
>>      kobject_init_and_add+0xcf/0x140
>>      btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
>>      create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
>>      create_space_info+0x211/0x320 [btrfs]
>>      open_ctree+0x2eed/0x43fe [btrfs]
>>      btrfs_get_tree.cold+0x90/0x1da [btrfs]
>>      vfs_get_tree+0x87/0x2f0
>>      vfs_cmd_create+0xbd/0x280
>>      __do_sys_fsconfig+0x64f/0xa30
>>      do_syscall_64+0x95/0x540
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Please report the above to the BTRFS maintainers.
> 
> Thanks,
> 
> Bart.


