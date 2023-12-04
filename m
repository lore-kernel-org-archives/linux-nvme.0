Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C40AC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vnKGL9rVmaXJ0k7UQTGGb8qgGBw3yaFYXulmlj0ClVk=; b=00pTEcYh9Wtj1jdypLrlcyDQUL
	uaUq2Pyroq2l0IUBesKs5lCgNOCmYfjnzPi8vCDHp6ft8VEJnE9tW3NLTxYqfZTH3UQtIVgyPm4SI
	wnVDhHtTnokGJuspu3INBoYPD+eVYnNp9viRImB8MVDGNuCNLKJZ7P253UOxSRnoTtjtjBnY2Ho6l
	Cr+FIOzIabmvhqzr4QOnjnpwhhAeehHTAJnu0JFafGnnTV1AByRG203EEsQ797maorr+MMhrIl5f9
	8TmwXvihmu8F6e/LGNg1/ox3C2ZVHwLn2OE1X/cNs+kKJEEDq932v12ocriWL0w+tIaeXTt7xo3+5
	iG/80BkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rADXo-005HJy-0v;
	Mon, 04 Dec 2023 18:19:48 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rADLd-005Fs7-1D;
	Mon, 04 Dec 2023 18:07:15 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce416a74d5so907360b3a.2;
        Mon, 04 Dec 2023 10:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701713230; x=1702318030; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnKGL9rVmaXJ0k7UQTGGb8qgGBw3yaFYXulmlj0ClVk=;
        b=IXFPhSPbpMd0UxNP3NXiagf4a9aVO2/b3PSvue5g7OOUj/lIZwKkdFzSmHjH6MAHmJ
         Ga77NDIg/EDZ7YoZtfaJN1tg2xSWMHRkU84YNqUxZ0TFL7GxlrzrLWU3/z0Phgd6vxrY
         jDm58byStTN9pXHDEvDtVEY9janOFk9wZUQekjcyR0YmKBDLMyWxBUkodrrQ1Vc+ARL5
         kttqv9WK8RdjcSS448CmLshO5oNA3WYgRR1+M0Ygw2IGd3HHNmSWGieYkhCNTOwNajyn
         ZPwEdZHN2fjKR7rCDgiz+8mrunzfRTKOSHoUNREMoWPuWS/6qPefdNICcdlges44kI9d
         bx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713230; x=1702318030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnKGL9rVmaXJ0k7UQTGGb8qgGBw3yaFYXulmlj0ClVk=;
        b=BDbo+OrepZjkq6zQNZCFUrJHFC039bCloQ7M/xDGwbmaQlC9DS2p/oIjHfh3BxHUhc
         CEtWElHhyl7iz5GAOB85Um+XAcxcne1ydQdPJpUAisJwL8tPRzicqiQnNvTyQfWEuxvr
         nfu6RcBv0IGTDC8kU4+3miDfdbRjMuKoKy4izPJQ6X7GGMf+7QeSkj73EZDv2qQ8L7KW
         naNzXQQDax8v1Ay+MkIr2fhJGVV9y8jMObWP0CUsFYiRKdd4dxIvQCexBHFDMetNOr4J
         3kQhDknYHDXly/7Ti0wsgTPcnw7lcF/589vZob/9wfQ6TQl8/pxBJ73ln2kOS+XNEpiE
         w9cg==
X-Gm-Message-State: AOJu0YzMj242/W3AwBc55nKDXVr14AN0WmR/yQ1o0XrYxG3XmAmWfC1C
	6pK7QJy5W7E+pTq1N9wicyE=
X-Google-Smtp-Source: AGHT+IGDIGeeBa7UWPj4E4w2SIGHBjZgGz8oxGqwAWzNb+KD7mpnEvIno4bt3NIHORxil3wMtNwC4w==
X-Received: by 2002:a05:6a20:1448:b0:18c:374c:6e64 with SMTP id a8-20020a056a20144800b0018c374c6e64mr27716780pzi.36.1701713229690;
        Mon, 04 Dec 2023 10:07:09 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id u2-20020a056a00158200b006cdd507ca2esm7943470pfk.167.2023.12.04.10.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:07:09 -0800 (PST)
Date: Mon, 4 Dec 2023 08:07:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>,
	"open-iscsi@googlegroups.com" <open-iscsi@googlegroups.com>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>
Subject: Re: Performance drop due to alloc_workqueue() misuse and recent
 change
Message-ID: <ZW4VS3Z0auYCjg-W@slm.duckdns.org>
References: <dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_100713_439042_E27738C3 
X-CRM114-Status: GOOD (  30.40  )
X-Mailman-Approved-At: Mon, 04 Dec 2023 10:19:46 -0800
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

Hello,

On Mon, Dec 04, 2023 at 04:03:47PM +0000, Naohiro Aota wrote:
> Recently, commit 636b927eba5b ("workqueue: Make unbound workqueues to use
> per-cpu pool_workqueues") changed WQ_UNBOUND workqueue's behavior. It
> changed the meaning of alloc_workqueue()'s max_active from an upper limit
> imposed per NUMA node to a limit per CPU. As a result, massive number of
> workers can be running at the same time, especially if the workqueue user
> thinks the max_active is a global limit.
> 
> Actually, it is already written it is per-CPU limit in the documentation
> before the commit. However, several callers seem to misuse max_active,
> maybe thinking it is a global limit. It is an unexpected behavior change
> for them.

Right, and the behavior has been like that for a very long time and there
was no other way to achieve reasonable level of concurrency, so the current
situation is expected.

> For example, these callers set max_active = num_online_cpus(), which is a
> suspicious limit applying to per-CPU. This config means we can have nr_cpu
> * nr_cpu active tasks working at the same time.

Yeah, that sounds like a good indicator.

> fs/f2fs/data.c: sbi->post_read_wq = alloc_workqueue("f2fs_post_read_wq",
> fs/f2fs/data.c-                                          WQ_UNBOUND | WQ_HIGHPRI,
> fs/f2fs/data.c-                                          num_online_cpus());
> 
> fs/crypto/crypto.c:     fscrypt_read_workqueue = alloc_workqueue("fscrypt_read_queue",
> fs/crypto/crypto.c-                                              WQ_UNBOUND | WQ_HIGHPRI,
> fs/crypto/crypto.c-                                              num_online_cpus());
> 
> fs/verity/verify.c:     fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
> fs/verity/verify.c-                                               WQ_HIGHPRI,
> fs/verity/verify.c-                                               num_online_cpus());
> 
> drivers/crypto/hisilicon/qm.c:  qm->wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_MEM_RECLAIM |
> drivers/crypto/hisilicon/qm.c-                           WQ_UNBOUND, num_online_cpus(),
> drivers/crypto/hisilicon/qm.c-                           pci_name(qm->pdev));
> 
> block/blk-crypto-fallback.c:    blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
> block/blk-crypto-fallback.c-                                    WQ_UNBOUND | WQ_HIGHPRI |
> block/blk-crypto-fallback.c-                                    WQ_MEM_RECLAIM, num_online_cpus());
> 
> drivers/md/dm-crypt.c:          cc->crypt_queue = alloc_workqueue("kcryptd/%s",
> drivers/md/dm-crypt.c-                                            WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND,
> drivers/md/dm-crypt.c-                                            num_online_cpus(), devname);

Most of these work items are CPU bound but not completley so. e.g.
kcrypt_crypt_write_continue() does wait_for_completion(), so setting
max_active to 1 likely isn't what they want either. They mostly want some
reasonable system-wide concurrency limit w.r.t. the CPU count while keeping
some level of flexibility in terms of task placement.

The previous max_active wasn't great for this because its meaning changed
depending on the number of nodes. Now, the meaning doesn't change but it's
not really useful for the above purpose. It's only useful for avoiding
melting the system completely.

One way to go about it is to declare that concurrency level management for
unbound workqueue is on users but that seems not ideal given many use cases
would want it anyway.

Let me think it over but I think the right way to go about it is going the
other direction - ie. making max_active apply to the whole system regardless
of the number of nodes / ccx's / whatever.

> Furthermore, the change affects performance in a certain case.
> 
> Btrfs creates several WQ_UNBOUND workqueues with a default max_active =
> min(NRCPUS + 2, 8). As my machine has 96 CPUs with NUMA disabled, this
> max_active config allows running over 700 active works. Before the commit,
> it is limited to 8 if NUMA is disabled or limited to 16 if NUMA nodes is 2.
> 
> I reverted the workqueue code back to before the commit, and I ran the
> following fio command on RAID0 btrfs on 6 SSDs.
> 
> fio --group_reporting --eta=always --eta-interval=30s --eta-newline=30s \
>     --rw=write --fallocate=none \
>     --direct=1 --ioengine=libaio --iodepth=32 \
>     --filesize=100G \
>     --blocksize=64k \
>     --time_based --runtime=300s \
>     --end_fsync=1 \
>     --directory=${MNT} \
>     --name=writer --numjobs=32
> 
> By changing workqueue's max_active, the result varies.
> 
> - wq max_active=8   (intended limit by btrfs?)
>   WRITE: bw=2495MiB/s (2616MB/s), 2495MiB/s-2495MiB/s (2616MB/s-2616MB/s), io=753GiB (808GB), run=308953-308953msec
> - wq max_active=16  (actual limit on 2 NUMA nodes setup)
>   WRITE: bw=1736MiB/s (1820MB/s), 1736MiB/s-1736MiB/s (1820MB/s-1820MB/s), io=670GiB (720GB), run=395532-395532msec
> - wq max_active=768 (simulating current limit)
>   WRITE: bw=1276MiB/s (1338MB/s), 1276MiB/s-1276MiB/s (1338MB/s-1338MB/s), io=375GiB (403GB), run=300984-300984msec
> 
> The current performance is slower than the previous limit (max_active=16)
> by 27%, or it is 50% slower than the intended limit.  The performance drop
> might be due to contention of the btrfs-endio-write works. There are over
> 700 kworker instances were created and 100 works are on the 'D' state
> competing for a lock.
> 
> More specifically, I tested the same workload on the commit.
> 
> - At commit 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu pool_workqueues")
>   WRITE: bw=1191MiB/s (1249MB/s), 1191MiB/s-1191MiB/s (1249MB/s-1249MB/s), io=350GiB (376GB), run=300714-300714msec
> - At the previous commit = 4cbfd3de73 ("workqueue: Call wq_update_unbound_numa() on all CPUs in NUMA node on CPU hotplug")
>   WRITE: bw=1747MiB/s (1832MB/s), 1747MiB/s-1747MiB/s (1832MB/s-1832MB/s), io=748GiB (803GB), run=438134-438134msec
> 
> So, it is -31.8% performance down with the commit.
> 
> In summary, we misuse max_active, considering it is a global limit. And,
> the recent commit introduced a huge performance drop in some cases.  We
> need to review alloc_workqueue() usage to check if its max_active setting
> is proper or not.

Thanks a lot for the report. I think it's a lot more reasonable to assume
that max_active is global for unbound workqueues. The current workqueue
behavior is not very intuitive or useful. I'll try to find something more
reasonable. Thanks for the report and analysis. Much appreciated.

Thanks.

-- 
tejun

