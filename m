Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231A5C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Nov 2022 00:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NRnjdwy4q/rC7EfchU6ozNrwG5Ch1IJiLDHlOz3WFDM=; b=3D8ReT03l8XKRJiGk4QD4H2XRh
	484cEV98rpahJfA7h+nTDQ8xxJE8nSBeGzCLB0UcLgRLc3oT5VKrauaqiDAuEY+jv2tNy8P88Jars
	XgwGlkj5DNGwruKQ1HWct2VzjwtHhB8WgGUwebDIXgQ/IBlMPL4QPsPSC7WzyNL3G0Qbtvz/n3xPs
	J6OpX+kN+QAJJcZO/nTA4yliMaOmLD+a7gcocrzaY/YVrFYKdfC1ks0MVG4d3hFOQ/6CUicv21Ujv
	RPgJ2+zrTBCvjPhiBBbvuwgR45CYs0ttbGqWJHY/UUHUX4RBd9jLuvnPrDLSESyuIEGGpesJUWUUa
	zogwqqcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxzqz-0031PD-C3; Thu, 24 Nov 2022 00:12:33 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxzqv-0031OD-Ng
	for linux-nvme@lists.infradead.org; Thu, 24 Nov 2022 00:12:32 +0000
Received: by mail-io1-xd2d.google.com with SMTP id r81so272043iod.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Nov 2022 16:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NRnjdwy4q/rC7EfchU6ozNrwG5Ch1IJiLDHlOz3WFDM=;
        b=V8KEdoPxaKYzy/MCPicIumM2hNXshq57wuspdkv9V03cGonKdNlSqBFGJkpjJOpHeh
         BbR9OLtJ/kL3bim6DXb7Hys7lK1CdRLcj1p3NXMoBVDhlqrguOsbh6o/NMU7IWBtt3T1
         wdOKQn5g6opbYy34m3yOrH2h6yJUe2dZldVgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRnjdwy4q/rC7EfchU6ozNrwG5Ch1IJiLDHlOz3WFDM=;
        b=77SS2l8ZHKTrmlcaGaNzyKKldM8l1J+qs2UWBQd4eSnHJI1+b8kW78kGlfiUxD2wMp
         6Zhsf50YaKtQ6EkSnqbtg5am+i4/mGiaDBypmQwzEPvW9RnhDwrB0v/2bedaE6P06v4Q
         ZfaYf4gvjlD6s2mFPq0RezNEEKnk3OjR59uY3N7NKkSQe8qIWAoQRLYEW6JoLVcTgfmF
         83otavvXEWaE0Xmpl38lnrhMp5C6iY/L2d8ZycaK4ugTKW6eiTdxrJBE0VaM+/liRd8f
         vtyqf0WxFxYsL2+mzT746rwOr2FXh7a/eBoNn3eXhscbCwcxB1eZnW2vMaNiwhlXrzD2
         18mQ==
X-Gm-Message-State: ANoB5pngdDBi93x6MCGSObzwug5RQxfo8lhM2dnbq9c3Xqe0YKC/bjO/
	SF/4mn0o37Uiva0u4Tnm/SJDBNoItPzeclAVhOfZ/g==
X-Google-Smtp-Source: AA0mqf65P/8YhuTIzB5uOtVFB/e5B8K82sjfNMuq3STcy75R+2yf1SLivtkeBUcBKbJjdIFHznw4OxMAJliDGgQmaHM=
X-Received: by 2002:a02:2ace:0:b0:363:a77e:369e with SMTP id
 w197-20020a022ace000000b00363a77e369emr14055792jaw.53.1669248745942; Wed, 23
 Nov 2022 16:12:25 -0800 (PST)
MIME-Version: 1.0
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
 <20221121074039.GA24507@lst.de> <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
 <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1> <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
 <b42a8825-a263-22fc-9f86-5c3dada173f1@grimberg.me> <20221122121449.GA3888@lst.de>
 <6a72cb78-8f23-a612-adab-10f4fe2a2174@grimberg.me>
In-Reply-To: <6a72cb78-8f23-a612-adab-10f4fe2a2174@grimberg.me>
From: Caleb Sander <csander@purestorage.com>
Date: Wed, 23 Nov 2022 16:12:15 -0800
Message-ID: <CADUfDZpv43JmNiriEVQ_mFxZVS8QAcmbJaG3rK5KoUBaC9s17g@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, paulmck@kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_161229_872353_ACB410F4 
X-CRM114-Status: GOOD (  36.10  )
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

On Tue, Nov 22, 2022 at 7:08 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> 3. removes ns from head sibling list + synchronize rcu
> >>     -> this should fence non-sleeping traversals (like revalidate_paths)
> >
> > Well, non-sleeping would only matter if those non-sleeping travesals
> > are under rcu_read_lock(), but they are not.  They are either part of
> > a longer srcu critical section because other code can sleep, or in
> > case of revalidate_paths unprotected at all (which this patch fixes).
>
> The original patch comment was that rcu_read_lock/unlock would be
> sufficient and we don't need to touch nvme_ns_remove()
>
> >
> >> Maybe it is OK to have it also srcu locked and just accept that
> >> nshead sibling list is srcu protected. In that case, your patch
> >> needs to extend the srcu also the clearing of current_head pointer.
> >
> > I don't see how nvme_mpath_clear_current_path needs (S)RCU protection.
> > It never dereferences the current_path, it just checks is for pointer
> > equality and if they match clears it to NULL.  (I wonder if it should
> > use cmpxchg though).
>
> Agree. it can stay out. because at this point it does not compete with
> concurrent submissions due to prior synchronizations. The list traversal
> needs to be under rcu lock.
>
>
> >
> >> But looking again at your bug report, you mention that there are
> >> concurrent scans, one removing the ns and another accessing it.
> >> That cannot happen due to the scan_lock held around this section afaict.
> >>
> >> I guess it can be that in general ns removal can compete with a scan
> >> if due to some controller behavior that failed an identify command
> >> transiently in a prior scan, and a subsequent scan finds it? worth
> >> pinning down exactly what happened in the race you got because maybe we
> >> have a different issue that may manifest in other issues.
> >
> > So scanning itself should be single threaded as it only happens from
> > the workqueue.  But nvme_ns_remove can be called from
> > nvme_remove_namespaces in in 6.1 and earlier from the passthrough
> > handler.
>
> The original patch report did not include any sequence that removes all
> namespaces, and given that it came from RockyLinux 8.6 kernel, it is not
> 6.1... Hence I think that we need to understand how a namespace removal
> happened at the same time that the namespace is being scanned. Maybe
> something else is broken.

We can reliably cause the panic by sending a "NS Changed" AEN
from multiple controllers at the same time, resulting in multiple scan works
running concurrently for the same namespace heads.
In our test, we have 4 controllers for the same subsystem, with 9 namespaces
that are added one at a time, resulting in many AENs for each controller.
We can see from the dmesg logs that the controllers' scan works overlap:
[37311.530367] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping down
[37311.530398] nvme nvme0: creating 32 I/O queues.
[37311.819883] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[37311.828129] nvme nvme0: new ctrl: NQN
"nqn.2010-06.com.purestorage:flasharray.7896f4eca47b4dea", addr
192.168.1.110:4420
[37311.924908] nvme nvme1: queue_size 128 > ctrl sqsize 32, clamping down
[37311.924935] nvme nvme1: creating 32 I/O queues.
[37312.298561] nvme nvme1: mapped 32/0/0 default/read/poll queues.
[37312.306296] nvme nvme1: new ctrl: NQN
"nqn.2010-06.com.purestorage:flasharray.7896f4eca47b4dea", addr
192.168.3.110:4420
[37312.400143] nvme nvme2: queue_size 128 > ctrl sqsize 32, clamping down
[37312.400180] nvme nvme2: creating 32 I/O queues.
[37312.671861] nvme nvme2: mapped 32/0/0 default/read/poll queues.
[37312.678318] nvme nvme2: new ctrl: NQN
"nqn.2010-06.com.purestorage:flasharray.7896f4eca47b4dea", addr
192.168.2.110:4420
[37312.760833] nvme nvme3: queue_size 128 > ctrl sqsize 32, clamping down
[37312.760860] nvme nvme3: creating 32 I/O queues.
[37313.123490] nvme nvme3: mapped 32/0/0 default/read/poll queues.
[37313.130407] nvme nvme3: new ctrl: NQN
"nqn.2010-06.com.purestorage:flasharray.7896f4eca47b4dea", addr
192.168.4.110:4420
[37313.654120] nvme nvme3: rescanning namespaces.
[37313.654152] nvme nvme2: rescanning namespaces.
[37313.654867] nvme0n1: detected capacity change from 0 to 11811160064
[37313.654876] nvme0n1: detected capacity change from 0 to 11811160064
[37313.655573] nvme nvme0: rescanning namespaces.
[37313.655694] nvme nvme1: rescanning namespaces.
[37313.656405] nvme0n1: detected capacity change from 0 to 11811160064
[37313.656445] nvme0n1: detected capacity change from 0 to 11811160064
[37313.897745] nvme nvme3: rescanning namespaces.
[37313.897748] nvme nvme2: rescanning namespaces.
[37313.898614] nvme0n2: detected capacity change from 0 to 11811160064
[37313.907348] nvme nvme0: rescanning namespaces.
[37313.907409] nvme nvme1: rescanning namespaces.
[37314.191586] nvme nvme2: rescanning namespaces.
[37314.191589] nvme nvme3: rescanning namespaces.
[37314.193241] nvme nvme0: rescanning namespaces.
[37314.193303] nvme nvme1: rescanning namespaces.
[37314.205965] nvme0n3: detected capacity change from 0 to 11811160064
[37314.206026] nvme0n3: detected capacity change from 0 to 11811160064
[37314.206036] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000050
[37314.206036] nvme0n3: detected capacity change from 0 to 11811160064

I don't see any mechanism to prevent scan work from running concurrently.
scan_lock is per-controller, but there are 4 controllers in our test.
I'm not very familiar with work queues in Linux, but it looks like they can run
multiple pieces of work concurrently.
The nvme-wq appears not CPU bound and has a high max concurrency:
$ cat /sys/bus/workqueue/devices/nvme-wq/per_cpu
0
$ cat /sys/bus/workqueue/devices/nvme-wq/max_active
256

At the end of the scan, nvme_remove_invalid_namespaces() is called,
which I think explains how we end up with namespace removals during the scans.

Thanks,
Caleb

