Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2842C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 15:43:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC2D2074F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 15:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WhdHj1gF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GFGPy40K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC2D2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VnvWGYmfFmvYGprH++IdJxLAAhPguKtyhY/7rV0YLq4=; b=WhdHj1gFCvW5yvN1sMgVy8sQb
	iID5jie6xmOk/pDK7TDlktcnOS24geieV+7dmWALGqjvTFIkJVALmDG0HyekBhjPgceBmpsmn/cuO
	J8AKyDwzBZa8UPxmCSBJh6A2piwQ+sRoKJqw+TerxCtgAytGTn5q8JyTMuP8GT9FlfS5mM860dNBQ
	7t2giyHaaqGiHE8Vfw3S/FGtlWMjhVqixwGtjiOX7dub7aejr+4N7EQhRprT9pFxohD50SktZS+yM
	mlVjtL+tnlpX0l/5NUYmhOL42XZuGRhlfaRQ+uwzFAbsjpwRVhcg0YW3indcM82+PztQsiU8UGUUK
	tnZilISpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqIQC-0003yT-0G; Tue, 30 Jun 2020 15:43:44 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqIQ3-0003vM-UH
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 15:43:42 +0000
Received: by mail-pg1-x542.google.com with SMTP id p3so10133054pgh.3
 for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2020 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Czyj7qztvQ/ET90pA6Cgm802J9mg/c4CrHX1EyYszQQ=;
 b=GFGPy40KuPsHkZUJdbeyZcQSvGfgs5FvnkigPPk9SV7CG59Zt39VKpM1zlVSVXoRDt
 yCeVdinmT/3C3Jtmhrs/ytEmj7Wsnn2qAcbIAA0lgRJAkDSMH3qtVX2x5ups9P63e9d7
 P9x2xILnsZVnyM3LolHHJ5MFrhP7fYB+ZvvgJsDeODXoJ2PGrPKhFRUVpy4BweeZ7T88
 7TInXYSLaUF36rQyQh/ug2yeZtWjhx06VQWrVd2dOvf947KJmX/LErgbh6FwQ3ULFM07
 +NsZiEDxchja6NsLMdoWiv7fTvOttuxXSfOyaHVhHUidelj6tLF2XevCAgd1imXsny29
 D7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Czyj7qztvQ/ET90pA6Cgm802J9mg/c4CrHX1EyYszQQ=;
 b=jVLEhLYQ01B/UU6y16m2AnsBnuatzNPofrgpsy98OfEItDt0WAot6ecbIuarmDhqiH
 qfmoRNTmITpAwikoeQ6GVZgR4I570hdDCVT4wrhs14o6G0jeWZZB9dQJnAEKKkfxGStk
 ClWvlVSS4lGiAR4mVwZTcXnwGKiGdTYwEKILSH9LubZO/LWwhDip+SvN8a5HNNVfsfvD
 B7Ja1T6WU6yzPab2xC56N6Or1U3oRrfZG3ah20MFa8YzDYyUtr6h1avTjdydcLnj9k8P
 sno/j4i+WDLdHhDEPGaHkIUzTkPnRob6JGTpkxPLOUIBfFsRR6AYqZ5lW9ZLr3tkjhV6
 Kowg==
X-Gm-Message-State: AOAM5316Mx6n9zUwRBN8WDg9S+OIlc73JxbB5D7PuiK0JaTybN668y+R
 bc+dxGFKrb2uGxCZ/xt7+HZWGw==
X-Google-Smtp-Source: ABdhPJx6lEIGGyQAAazhh6sEGODM0EvGn2wcc8uAkFeSAVS9hqQhG93iUqi0nvo2CJcI+RwKQRfdOw==
X-Received: by 2002:a65:5a0f:: with SMTP id y15mr15197406pgs.6.1593531813542; 
 Tue, 30 Jun 2020 08:43:33 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b?
 ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
 by smtp.gmail.com with ESMTPSA id w68sm3185027pff.191.2020.06.30.08.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 08:43:32 -0700 (PDT)
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
 <bd1443c0-be37-115b-1110-df6f0e661a50@kernel.dk>
Message-ID: <6ddbe343-0fc2-58c8-3726-c4ba9952994f@kernel.dk>
Date: Tue, 30 Jun 2020 09:43:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bd1443c0-be37-115b-1110-df6f0e661a50@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200630_114336_057370_C15B93B6 
X-CRM114-Status: GOOD (  13.52  )
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
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/30/20 7:57 AM, Jens Axboe wrote:
> On 6/29/20 1:39 PM, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series moves the make_request_fn method into block_device_operations
>> with the much more descriptive ->submit_bio name.  It then also gives
>> generic_make_request a more descriptive name, and further optimize the
>> path to issue to blk-mq, removing the need for the direct_make_request
>> bypass.
> 
> Looks good to me, and it's a nice cleanup as well. Applied.

Dropped, insta-crashes with dm:

[   10.240134] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   10.241000] #PF: supervisor instruction fetch in kernel mode
[   10.241666] #PF: error_code(0x0010) - not-present page
[   10.242280] PGD 0 P4D 0 
[   10.242600] Oops: 0010 [#1] PREEMPT SMP
[   10.243073] CPU: 1 PID: 2110 Comm: systemd-udevd Not tainted 5.8.0-rc3+ #6655
[   10.243939] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[   10.245012] RIP: 0010:0x0
[   10.245322] Code: Bad RIP value.
[   10.245695] RSP: 0018:ffffc900002f7af8 EFLAGS: 00010246
[   10.246333] RAX: ffffffff81c83520 RBX: ffff8881b805dea8 RCX: ffff88819e844070
[   10.247227] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88819e844070
[   10.248112] RBP: ffffc900002f7b48 R08: ffff8881b6f38800 R09: ffff88818ff0ea58
[   10.248994] R10: 0000000000000000 R11: ffff88818ff0ea58 R12: ffff88819e844070
[   10.250077] R13: 00000000ffffffff R14: 0000000000000000 R15: ffff888107812948
[   10.251168] FS:  00007f5c3ed66a80(0000) GS:ffff8881b9c80000(0000) knlGS:0000000000000000
[   10.252161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.253189] CR2: ffffffffffffffd6 CR3: 00000001b2953003 CR4: 00000000001606e0
[   10.254157] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   10.255279] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   10.256365] Call Trace:
[   10.256781]  submit_bio_noacct+0x1f6/0x3d0
[   10.257297]  submit_bio+0x37/0x130
[   10.257780]  ? guard_bio_eod+0x2e/0x70
[   10.258418]  mpage_readahead+0x13c/0x180
[   10.259096]  ? blkdev_direct_IO+0x490/0x490
[   10.259654]  read_pages+0x68/0x2d0
[   10.260051]  page_cache_readahead_unbounded+0x1b7/0x220
[   10.260818]  generic_file_buffered_read+0x865/0xc80
[   10.261587]  ? _copy_to_user+0x6d/0x80
[   10.262171]  ? cp_new_stat+0x119/0x130
[   10.262680]  new_sync_read+0xfe/0x170
[   10.263155]  vfs_read+0xc8/0x180
[   10.263647]  ksys_read+0x53/0xc0
[   10.264209]  do_syscall_64+0x3c/0x70
[   10.264759]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   10.265200] RIP: 0033:0x7f5c3fcc9ab2
[   10.265510] Code: Bad RIP value.
[   10.265775] RSP: 002b:00007ffc8e0cf9c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   10.266426] RAX: ffffffffffffffda RBX: 000055d5eca76c68 RCX: 00007f5c3fcc9ab2
[   10.267012] RDX: 0000000000000040 RSI: 000055d5eca76c78 RDI: 0000000000000006
[   10.267591] RBP: 000055d5eca44890 R08: 000055d5eca76c50 R09: 00007f5c3fd99a40
[   10.268168] R10: 0000000000000008 R11: 0000000000000246 R12: 000000003bd90000
[   10.268744] R13: 0000000000000040 R14: 000055d5eca76c50 R15: 000055d5eca448e0
[   10.269319] Modules linked in:
[   10.269562] CR2: 0000000000000000
[   10.269845] ---[ end trace f09b8963e5a3593b ]---

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
