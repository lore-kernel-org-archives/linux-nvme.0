Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEBFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:06:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B5761175
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54B5761175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SXGj2qfgzbokKrM5aRk7VyxARNhGGx7TrxtfTCH30As=; b=TksBv2AKGH8Pz1US1+symhA/E9
	xx8euk7J2+6TeJ2YzJ2eF8LjIhngNKZn11lXXYdO7qoLaXrjp/xE4T4kpl4XnqEGQsjddMBlp2+Af
	tfzuzZc+Jpk842AWuLqiFvZjLdH7NGQLY5d7f3/EGVVAFMVyHZ80EBxPsrH7R3G3rQyELiwZ14mLV
	oEBvs2wmNNyssJDTEhPLAENAvSI97EwOUFTxxxu13M9zhxAmS6jDV9NN/Ah8qQTytUdpUVa0DovEj
	ZOwuUbMsdnEdFTDEuwwr8FFgAOEXS1zqM2yKmbvSkKWmArVPGQlGzSzY8Y1bjInMOHg28uwNEuEf4
	0muNUM9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcqh7-001czC-Fm; Tue, 19 Oct 2021 15:06:25 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcqh4-001cyK-F0
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 15:06:23 +0000
Received: by mail-wm1-f52.google.com with SMTP id v127so12265482wme.5
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 08:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SXGj2qfgzbokKrM5aRk7VyxARNhGGx7TrxtfTCH30As=;
 b=oyYvc2xQoQeYQn5Z11fM+5wnscSUeTN9a+xZkAPGIrnSs5N1RBou+7A3kuuShWUXYn
 8swzZM0Co2dSxIQ69J0WQkFMj46EOh25B5BLByuFlpeJcLgdhGO6FWrP3KhcjDQt+Qvd
 tf04GhtsE413k4yH0YQdxlUItUYQHawb3sbnPShNtMSZ9/HsQ3axeGFKNGah5vUvSaUE
 cde1S/v719Hh+HdURChbYC02Qx9wAVUoFn/Vo8heaW3e8HqFWzzUkCYFP4fjp3/3P8Jh
 FYRc41yu8VnRN/xbKKWZ5E8/3F60Fq1Z54ylUXnhas7jwJnnM+18ZTcF3F+bQKnI8R62
 b1Ig==
X-Gm-Message-State: AOAM5311Kvrpv7lKn2CRLCQSYA1Ieo7RZk4snK/3JE8JhRLL/g+L4rhf
 qZJKo/Q+cwskLZ2GWYLVbBY=
X-Google-Smtp-Source: ABdhPJwHHJzjD5uGahWaYLKOQiJK/Z1xzTSmelIsbXk0yaOklGd/iJKpeicx6owWRUaYvPvcUuGlAw==
X-Received: by 2002:a05:600c:ac2:: with SMTP id
 c2mr6634758wmr.194.1634655979284; 
 Tue, 19 Oct 2021 08:06:19 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n7sm9821895wrp.17.2021.10.19.08.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 08:06:18 -0700 (PDT)
Subject: Re: Deadlock on failure to read NVMe namespace
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>
References: <87df4b26-19e7-6cc5-e973-23b6e98f4e19@suse.de>
 <e13114d1-b204-b89a-12bc-53ae049dfaa7@grimberg.me>
 <ce39fdb3-d60f-4e62-f70d-c433145dc68f@suse.de>
 <f5a43c7e-608b-5191-dd73-11c6c8dc1953@grimberg.me>
Message-ID: <8ff377bd-4d04-9fc7-66af-a48c7cdd7399@grimberg.me>
Date: Tue, 19 Oct 2021 18:06:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f5a43c7e-608b-5191-dd73-11c6c8dc1953@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_080622_541083_E5775019 
X-CRM114-Status: GOOD (  16.96  )
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



On 10/19/21 5:27 PM, Sagi Grimberg wrote:
> 
>>>> 481:~ # cat /proc/15761/stack
>>>> [<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
>>>> [<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
>>>> [<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
>>>> [<0>] nvme_sysfs_delete+0x42/0x60 [nvme_core]
>>>> [<0>] kernfs_fop_write_iter+0x12f/0x1a0
>>>> [<0>] new_sync_write+0x122/0x1b0
>>>> [<0>] vfs_write+0x1eb/0x250
>>>> [<0>] ksys_write+0xa1/0xe0
>>>> [<0>] do_syscall_64+0x3a/0x80
>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> c481:~ # cat /proc/14965/stack
>>>> [<0>] do_read_cache_page+0x49b/0x790
>>>> [<0>] read_part_sector+0x39/0xe0
>>>> [<0>] read_lba+0xf9/0x1d0
>>>> [<0>] efi_partition+0xf1/0x7f0
>>>> [<0>] bdev_disk_changed+0x1ee/0x550
>>>> [<0>] blkdev_get_whole+0x81/0x90
>>>> [<0>] blkdev_get_by_dev+0x128/0x2e0
>>>> [<0>] device_add_disk+0x377/0x3c0
>>>> [<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
>>>> [<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
>>>> [<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
>>>> [<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
>>>> [<0>] nvme_scan_work+0x168/0x310 [nvme_core]
>>>> [<0>] process_one_work+0x231/0x420
>>>> [<0>] worker_thread+0x2d/0x3f0
>>>> [<0>] kthread+0x11a/0x140
>>>> [<0>] ret_from_fork+0x22/0x30

...

> I think this sequence is familiar and was addressed by a fix from Anton
> (CC'd) which still has some pending review comments.
> 
> Can you lookup and try:
> [PATCH] nvme/mpath: fix hang when disk goes live over reconnect

Actually, I see the trace is going from nvme_alloc_ns, no the ANA
update path, so that is unlikely to address the issue.

Looking at nvme_mpath_clear_ctrl_paths, I don't think it should
take the scan_lock anymore. IIRC the reason why it needed the
scan_lock in the first place was the fact that ctrl->namespaces
was added and then sorted in scan_work (taking the namespaces_rwsem
twice).

But now that ctrl->namespaces is always sorted, and accessed with
namespaces_rwsem, I think that scan_lock is no longer needed
here and namespaces_rwsem is sufficient.

Thoughts?

