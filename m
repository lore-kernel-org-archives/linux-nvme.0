Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A9EEDF17D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9RzRfvwbSgpAAn+57L/twMbK6THI0fSwkzw1UKZRes=; b=kUI/SbluLSHtTLo47wGHyvNw7m
	zceabgg/b6kdsR4YyiN7RqomrRSiETe1nwkO3CrsSJaZLZ26+9+Uuqb0EW6obtp+siFKUN/UVex+i
	Vimk18kQ3OQQVsrDCtsNchoOqtIVr71VNhPkrQ2/5Ke0dYcYDTXpPY6uhx4fLsaFlC5l12C9FXng8
	KJV87u91BS62m1648MkTS+KAFtnhAwDRnwoosbebVSOQM/Hgf6MMK7r5ih2k3Rmmfw+DeqC2UHON3
	fA95clTqgQV08rPClG++0JkIUFLi0X1UBkJKYuvcRtwYtE8/B9eBGlk1NOb42X1TP9MMUjII0TqmF
	I9vLMyow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqxDB-00000003lL6-3EsJ;
	Fri, 13 Feb 2026 17:44:13 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqxD8-00000003lKl-20hY
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 17:44:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fCKKj6mlFzlgqwF;
	Fri, 13 Feb 2026 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771004648; x=1773596649; bh=t9RzRfvwbSgpAAn+57L/twMb
	K6THI0fSwkzw1UKZRes=; b=QzNyeC+78j+FCizjBSZLWJPixMNPatJ8HNzEwubp
	yRQdiq+UcNG4TgXbrCcSBO+1U5RLvQF2JDPAWNVvrEr9kjznYAo+foAHwGGzPjK2
	8iNettCMNTrcbNYGdjuD6pbrRwHvT07kkG+TTiCX6wWnUDwHG+0J+H4goOL9P1lh
	ey4fyk4jg112tX+f2Ac+RqUjOivwmP4IltVmK6Fk1BvJjCIe418yhhV7GOZV7IK0
	GF7K2kY2+RDX9ynJ2WTrhSKVHXX2gD16iDiIbiXGi7BvEh0+Zgid3FSsfUv10bFq
	Snt3Pp7CNxP2zBTqV4ydz3FCoyDTnnOozvhyQU0r7U2m/A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8XnJ08o8QUxG; Fri, 13 Feb 2026 17:44:08 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fCKKg1FjCzlfgPZ;
	Fri, 13 Feb 2026 17:44:06 +0000 (UTC)
Message-ID: <5157497a-3536-4187-883e-19a54167955a@acm.org>
Date: Fri, 13 Feb 2026 09:44:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.19 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <aY7ZBfMjVIhe_wh3@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aY7ZBfMjVIhe_wh3@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_094410_540783_52F76299 
X-CRM114-Status: UNSURE (   9.93  )
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

On 2/12/26 11:57 PM, Shinichiro Kawasaki wrote:
> [5] kmemleak at nvme/061 wiht rdma transport and siw driver
> 
> unreferenced object 0xffff888114792600 (size 32):
>    comm "kworker/2:1H", pid 66, jiffies 4295489358
>    hex dump (first 32 bytes):
>      c2 f6 83 05 00 ea ff ff 00 00 00 00 00 10 00 00  ................
>      00 b0 fd 60 81 88 ff ff 00 10 00 00 00 00 00 00  ...`............
>    backtrace (crc 3dbac61d):
>      __kmalloc_noprof+0x62f/0x8b0
>      sgl_alloc_order+0x74/0x330
>      0xffffffffc1b73433
>      0xffffffffc1bc1f0d
>      0xffffffffc1bc8064
>      __ib_process_cq+0x14f/0x3e0 [ib_core]
>      ib_cq_poll_work+0x49/0x160 [ib_core]
>      process_one_work+0x868/0x1480
>      worker_thread+0x5ee/0xfd0
>      kthread+0x3af/0x770
>      ret_from_fork+0x55c/0x810
>      ret_from_fork_asm+0x1a/0x30

There are no sgl_alloc() calls in the RDMA subsystem. I think the above
indicates a memory leak in either the RDMA NVMe target driver or in the
NVMe target core.

> [7] kmemleak at zbd/009
> 
> unreferenced object 0xffff88815f1f1280 (size 32):
>    comm "mount", pid 1745, jiffies 4294866235
>    hex dump (first 32 bytes):
>      6d 65 74 61 64 61 74 61 2d 74 72 65 65 6c 6f 67  metadata-treelog
>      00 93 9c fb af bb ae 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 2ee03cc2):
>      __kmalloc_node_track_caller_noprof+0x66b/0x8c0
>      kstrdup+0x42/0xc0
>      kobject_set_name_vargs+0x44/0x110
>      kobject_init_and_add+0xcf/0x140
>      btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
>      create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
>      create_space_info+0x247/0x320 [btrfs]
>      btrfs_init_space_info+0x143/0x1b0 [btrfs]
>      open_ctree+0x2eed/0x43fe [btrfs]
>      btrfs_get_tree.cold+0x90/0x1da [btrfs]
>      vfs_get_tree+0x87/0x2f0
>      vfs_cmd_create+0xbd/0x280
>      __do_sys_fsconfig+0x64f/0xa30
>      do_syscall_64+0x95/0x540
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff888128d80000 (size 16):
>    comm "mount", pid 1745, jiffies 4294866237
>    hex dump (first 16 bytes):
>      64 61 74 61 2d 72 65 6c 6f 63 00 4b 96 f6 48 82  data-reloc.K..H.
>    backtrace (crc 1598f702):
>      __kmalloc_node_track_caller_noprof+0x66b/0x8c0
>      kstrdup+0x42/0xc0
>      kobject_set_name_vargs+0x44/0x110
>      kobject_init_and_add+0xcf/0x140
>      btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
>      create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
>      create_space_info+0x211/0x320 [btrfs]
>      open_ctree+0x2eed/0x43fe [btrfs]
>      btrfs_get_tree.cold+0x90/0x1da [btrfs]
>      vfs_get_tree+0x87/0x2f0
>      vfs_cmd_create+0xbd/0x280
>      __do_sys_fsconfig+0x64f/0xa30
>      do_syscall_64+0x95/0x540
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e

Please report the above to the BTRFS maintainers.

Thanks,

Bart.

