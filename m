Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA6EC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:23:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0525860C41
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0525860C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q9gBtYXoIG61LJGl5bG9zjBNihbQe7XhMANRTvYrvLo=; b=BPOy14qt7cIB9AuzYTbDhZnXY
	GN1kUPhgfJxA44LC2znUdh2YXjrs+8DP98ovMsbnXgggveFtiMaCcE/avYpE8AEhULHYvEktqDCSd
	DOxzHeyN5D59dQdTkK38Q03KfIR1mE79jOy1M4hUx2JVMR0HFYwSvZNegtlwpxXrLWvZAqZmvtcIh
	5YiqAA8ZRapx06v1L9+fxnf+1R2IQ/9iN7MDcZWDtT0xE8WBXYh7ggxK0vkeSzhSQ52sX22sQasWu
	X8/g3mP8+v679gIFeVl+NU3vcbpolGoKu/RJ07Kwn00yFAczDVWU1PsmiCyFdpXkARgYavm05N14v
	+uYev7qLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5IVh-0000HC-8j; Fri, 29 Jan 2021 01:23:41 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5IVd-0000Ga-Nk
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 01:23:39 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DRfhf2GvjzY2nX;
 Fri, 29 Jan 2021 09:22:26 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 09:23:32 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 09:23:32 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
Date: Fri, 29 Jan 2021 09:23:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_202338_275407_AE42512B 
X-CRM114-Status: GOOD (  17.01  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/28 17:40, Daniel Wagner wrote:
> On Thu, Jan 28, 2021 at 05:18:56PM +0800, Chao Leng wrote:
>> It is impossible to return NULL for nvme_next_ns(head, old).
> 
>   block nvme0n1: no usable path - requeuing I/O
>   block nvme0n1: no usable path - requeuing I/O
>   block nvme0n1: no usable path - requeuing I/O
>   block nvme0n1: no usable path - requeuing I/O
>   block nvme0n1: no usable path - requeuing I/O
>   block nvme0n1: no usable path - requeuing I/O
>   BUG: kernel NULL pointer dereference, address: 0000000000000068
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 8000000ff67bc067 P4D 8000000ff67bc067 PUD ff9ac9067 PMD 0
>   Oops: 0000 [#1] SMP PTI
>   CPU: 23 PID: 15759 Comm: dt.21.15 Kdump: loaded Tainted: G            E       5.3.18-0.gc9fe679-default #1 SLE15-SP2 (unreleased)
>   Hardware name: FUJITSU PRIMERGY RX2540 M2/D3289-B1, BIOS V5.0.0.11 R1.18.0 for D3289-B1x                    02/06/2018
>   RIP: 0010:nvme_ns_head_make_request+0x1d1/0x430 [nvme_core]
>   Code: 54 24 10 0f 84 c9 01 00 00 48 8b 54 24 10 48 83 ea 30 0f 84 ba 01 00 00 48 39 d0 0f 84 01 02 00 00 31 ff eb 05 48 39 d0 74 67 <48> 8b 72 68 83 e6 04 75 13 48 8b 72 68 83 e6 01 75 0a 48 8b 72 10
>   RSP: 0018:ffffa69d08017af8 EFLAGS: 00010246
>   RAX: ffff92f261d87800 RBX: ffff92fa555b0010 RCX: ffff92fa555bc570
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>   RBP: 0000000000000001 R08: 0000000000001000 R09: 0000000000001000
>   R10: ffffa69d080179a8 R11: ffff92f264f0c1c0 R12: ffff92f264f7f000
>   R13: ffff92fa555b0000 R14: 0000000000000001 R15: 0000000000000000
>   FS:  00007f3962bae700(0000) GS:ffff92f29ffc0000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000068 CR3: 0000000fd69a2002 CR4: 00000000003606e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    generic_make_request+0x121/0x300
>    ? submit_bio+0x42/0x1c0
>    submit_bio+0x42/0x1c0
>    ext4_io_submit+0x49/0x60 [ext4]
>    ext4_writepages+0x625/0xe90 [ext4]
>    ? do_writepages+0x4b/0xe0
>    ? ext4_mark_inode_dirty+0x1d0/0x1d0 [ext4]
>    do_writepages+0x4b/0xe0
>    ? __generic_file_write_iter+0x192/0x1c0
>    ? __filemap_fdatawrite_range+0xcb/0x100
>    __filemap_fdatawrite_range+0xcb/0x100
>    ? ext4_file_write_iter+0x128/0x3c0 [ext4]
>    file_write_and_wait_range+0x5e/0xb0
>    __generic_file_fsync+0x22/0xb0
>    ext4_sync_file+0x1f7/0x3c0 [ext4]
>    do_fsync+0x38/0x60
>    __x64_sys_fsync+0x10/0x20
>    do_syscall_64+0x5b/0x1e0
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> You can't see exactly where it dies but I followed the assembly to
> nvme_round_robin_path(). Maybe it's not the initial nvme_next_ns(head,
> old) which returns NULL but nvme_next_ns() is returning NULL eventually
> (list_next_or_null_rcu()).
So there is other bug cause nvme_next_ns abormal.
I review the code about head->list and head->current_path, I find 2 bugs
may cause the bug:
First, I already send the patch. see:
https://lore.kernel.org/linux-nvme/20210128033351.22116-1-lengchao@huawei.com/
Second, in nvme_ns_remove, list_del_rcu is before
nvme_mpath_clear_current_path. This may cause "old" is deleted from the
"head", but still use "old". I'm not sure there's any other
consideration here, I will check it and try to fix it.
> 
> And I have positive feedback, this patch fixes the above problem.
Although adding check ns can fix the crash. There may still be other problems
such as in __nvme_find_path which use list_for_each_entry_rcu.
> 
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
