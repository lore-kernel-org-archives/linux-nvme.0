Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1277E7718B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2024 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X5xB/lPzXkSANJaPVnqHd+ZSXf5Kcq85JyVswTMNoro=; b=dfrSpUt1t/TObGqkZCdUXS5iqU
	d0ZqZWXUp6i3jUN73n/SKLSsRQznizUt515v7ittJKFK7x3G+oFbc36FbxK3HLM/ByKRtsUoQMvD3
	gVYle2lHbED1tgSQXKkmz6mfrMKHvOviVZBJpzvpAMV3j09+pwdiz9RVbDFN7CPB1zC2kDuZXI2w3
	mnL4oCWHlaeBoN3Fy660d44eiE8H8bGNvJKo7nZ9Cp7hg4ank3oZl0drh8b9I19Ds+mBfjc0cuZ5O
	nFxo8ZjpUNXXvrKeRXTH3vZW92YKGxEagilvn6eVV6tm+JbX4jXKUXz3gF4zpPjpJhXlbYynx02eG
	w1IIG2NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPp7W-0000000AhXR-07Nm;
	Mon, 23 Dec 2024 20:33:42 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPp7S-0000000AhWX-3Ra8
	for linux-nvme@lists.infradead.org;
	Mon, 23 Dec 2024 20:33:40 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-219f8263ae0so12603425ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Dec 2024 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734986017; x=1735590817; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5xB/lPzXkSANJaPVnqHd+ZSXf5Kcq85JyVswTMNoro=;
        b=m/0UxgIvM0HOuIQO4zcMmkIxxoml76LdmFQ/Rf88eU/M/k++E8JJEqHqfvPw3FJKEG
         hTjVARWGIA9zaPr+S+lVrUdsdggalbuFMgOXR/CIdKJu3t+7hu5we/CxSChoNXnIncqE
         cmL0BEcyjXi5Y1NAQm3uFIQ8zBG+XRaF/DOsCdqtcxAfLzN4kBpV7ooY0dltmEasatrZ
         mu961BfLOmnWVThbd8h3bTAMofjlQNlf9D1co85ACdPg088PIFMFyyMgxOLq2sr3tTqR
         9eKV0z5IPl2zzBZafbkZvX3vMUnzWl2Vc2dWRgmAKY8CR126mlmSPQLZ4PmX6hBSxmQr
         UOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734986017; x=1735590817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5xB/lPzXkSANJaPVnqHd+ZSXf5Kcq85JyVswTMNoro=;
        b=qLcOmdI5ZXhzIzWoh3WevXFvie7eTWh2RqHq4AtHoM8+l+0pMq+rUthOeyQGkw1I1W
         XitZy5tvIvlL0DR9IZgxTB//VBvvD2xeTYTJPuXsP4UlbcFrWDHNhis58pGsw8FkFprH
         Sl43/BAl4w7/meBmamXL6Bu59NXDuZWEqYezbNQMWUus3cIxoqfnYPZk2IHY072ZxP83
         uGMT8rUCudVzsZku1/RuX9/iuPqNmQkXRQR63lNdOdBWqqTI9xsbYUqgOiSzPapiXHi/
         hVockqCeF9Ja23gRlHM8PxsBUCfj6WsTec6q0jBf8YYeVD5hPQgK9uqAsi2KvGnZUzue
         YKOw==
X-Forwarded-Encrypted: i=1; AJvYcCWUfRQR2QhlaB3okLHJQcEjd59/0UEgWryuD4P8wZCagIWS8vsKw84i1FeKyYbpLdorZ5WDMSd2e92r@lists.infradead.org
X-Gm-Message-State: AOJu0YyXZJfbBJJePk+yBBu88l8AN7+RFZxMZOCQ14fT5NHlU1ICxoG+
	daiaVUNkAVy/9xSAyZBGijx8PL1aKsaTwtwy/KbCOf4qGcKBqRioiqmskkDQzGk=
X-Gm-Gg: ASbGncvQXTUKf1hA9XUNKf1SnsIDslRDDR8ynUdmEa4tIyQL+Pni6pnY0BysYUAY0Zt
	nFeciU/W9uFyYMQE6ygLLDEHiEEKV51ptONnYans0WBj820lc459R/hTKYeuwWpALSDTq1rZJcE
	RnKaQKgWxU0fRRY3iiivSsy9K3RBbP6K3D2e76rULDq/bj8BPH4LXVVHlFeiRj6VTTGExPB8knY
	DTC0kdAr91MlPWXKdoy6gVonf7Iw8sjLqWOQEsQJOqFd8KezlVfMQ==
X-Google-Smtp-Source: AGHT+IHHPgNkcEyopkQEOR5NoyLQMpPpv1BV3Gs14V00OVQd+cDI1fAJi1/NVwhH43JVvC0b92EMuA==
X-Received: by 2002:a17:903:32c5:b0:215:bb50:6a05 with SMTP id d9443c01a7336-219e6e894f4mr208295875ad.9.1734986017134;
        Mon, 23 Dec 2024 12:33:37 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b229c48fsm6462928a12.26.2024.12.23.12.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 12:33:36 -0800 (PST)
Message-ID: <2f80272f-6cab-489d-ba2b-c1d545ac3485@kernel.dk>
Date: Mon, 23 Dec 2024 13:33:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] BUG: unable to handle kernel NULL pointer
 dereference in percpu_ref_put_many
To: syzbot <syzbot+3dcac84cc1d50f43ed31@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
References: <6769bf7b.050a0220.226966.0041.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6769bf7b.050a0220.226966.0041.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_123339_094767_4F5324F8 
X-CRM114-Status: GOOD (  10.48  )
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

On 12/23/24 12:52 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    eabcdba3ad40 Merge tag 'for-6.13-rc3-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10871f44580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
> dashboard link: https://syzkaller.appspot.com/bug?extid=3dcac84cc1d50f43ed31
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141bccf8580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135f7730580000

I ran this one but his this instead:

==================================================================
BUG: KASAN: slab-out-of-bounds in nvmet_root_discovery_nqn_store+0x110/0x180
Write of size 256 at addr ffff000009e71180 by task refcrash/775

CPU: 0 UID: 0 PID: 775 Comm: refcrash Not tainted 6.13.0-rc4 #2
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x1c/0x30 (C)
 __dump_stack+0x24/0x30
 dump_stack_lvl+0x60/0x80
 print_address_description+0x88/0x220
 print_report+0x4c/0x60
 kasan_report+0x94/0xf0
 kasan_check_range+0x248/0x288
 __asan_memset+0x30/0x60
 nvmet_root_discovery_nqn_store+0x110/0x180
 configfs_write_iter+0x220/0x2e8
 do_iter_readv_writev+0x2e0/0x458
 vfs_writev+0x220/0x728
 do_writev+0xf8/0x1a8
 __arm64_sys_writev+0x80/0x98
 invoke_syscall+0x7c/0x258
 el0_svc_common+0x108/0x1d0
 do_el0_svc+0x4c/0x60
 el0_svc+0x4c/0xa0
 el0t_64_sync_handler+0x70/0x100
 el0t_64_sync+0x170/0x178

Allocated by task 1:
 kasan_save_track+0x2c/0x60
 kasan_save_alloc_info+0x3c/0x48
 __kasan_kmalloc+0x80/0x98
 __kmalloc_node_track_caller_noprof+0x2f0/0x590
 kstrndup+0x4c/0xb8
 nvmet_subsys_alloc+0x1c4/0x498
 nvmet_init_discovery+0x20/0x48
 nvmet_init+0x18c/0x1c0
 do_one_initcall+0x1a4/0x718
 do_initcall_level+0x178/0x348
 do_initcalls+0x58/0xa0
 do_basic_setup+0x7c/0x98
 kernel_init_freeable+0x268/0x380
 kernel_init+0x24/0x148
 ret_from_fork+0x10/0x20

The buggy address belongs to the object at ffff000009e71180
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 allocated 37-byte region [ffff000009e71180, ffff000009e711a5)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x49e71
anon flags: 0x3ffe00000000000(node=0|zone=0|lastcpupid=0x1fff)
page_type: f5(slab)
raw: 03ffe00000000000 ffff0000070028c0 fffffdffc0523d80 dead000000000005
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000009e71080: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff000009e71100: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>ffff000009e71180: 00 00 00 00 05 fc fc fc fc fc fc fc fc fc fc fc
Zero length message leads to an empty skb
                               ^
 ffff000009e71200: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff000009e71280: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================
Disabling lock debugging due to kernel taint

which makes me think something else is the culprit here. The test case
doesn't do much outside of creating two rings, it doesn't actually use
them.

CC'ing likely suspects on the nvme front. This is on 6.13-rc4 fwiw.

-- 
Jens Axboe

