Return-Path: <SRS0=3azT=MH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC14C636CA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 21:40:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF24613C1
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 21:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF24613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XQTO/ojax8/sRbEZtGvL2I0C7NeCeAxKuUoOUElMJDo=; b=GzMuLG8Nxmccg1
	GG7jwkAaX9CZ5S0lrEFDgHexr1vkUQsjcD8w9JgNGfnRYO4S8yNdPWjVXP21GDAC/wYwLijuckUbD
	TesURtRHcwysTAen5mEK9l+TdSCuSzR3Co4Q7YiMxhMyx9M1eM5Nl9gkJLxK5LJiFACEXqORJetbS
	YnIsCyljs1AfEW0TgN0DZuHDgcWw1KdS2CaOnI0GLjulRGZHRdn4wXabaKH9mwNY9XrkzSoSBRjNU
	TTrPdXARp1QzCuJ/k7SZgWd7i53NyBaf3lt7Lc/7nrv0NOyeEBA4COPylLEvrwZ+OJAMVkzo+SwjG
	bBIBEkY4vVRJJJ7Jcx4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m495B-002NCM-4A; Thu, 15 Jul 2021 21:39:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4950-002NAc-V6
 for linux-nvme@lists.infradead.org; Thu, 15 Jul 2021 21:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626385173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQBeqmBNMUwfgzBu0mpPTBIzauoqHgyHlsJEPZhpQ0o=;
 b=eriyaXeLCgsbE0/K0e3KUsmVkOJpxfuoGlgBB+mLhB7yZWiZdRty7TY7Gzm2rMUZuWpBKl
 qhlKi0G3j6oqygVZ2bZdkyJW3RX6eyAOwlsmUNbtfV0tMYAnZMreu+x4l+LATIpQ6X60dG
 p2Y7HC9YLB4zcIWypOFow1rkL4Dd8CM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-a3QqYy35O3OCImZ3QSf_Cw-1; Thu, 15 Jul 2021 17:37:26 -0400
X-MC-Unique: a3QqYy35O3OCImZ3QSf_Cw-1
Received: by mail-qt1-f199.google.com with SMTP id
 61-20020aed21430000b029024e7e455d67so5028154qtc.16
 for <linux-nvme@lists.infradead.org>; Thu, 15 Jul 2021 14:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uQBeqmBNMUwfgzBu0mpPTBIzauoqHgyHlsJEPZhpQ0o=;
 b=rIp4fO60m/VEcb1muGLuolgWoM2gNkcCuZ97CEP8OMQqCTGMzmD/SmJz6tICVjTkbb
 Mdo4DES18PuroD+EXzGzYT241gH8iT3dvFzuDQgBl5CaHdqO+MeJ9XcAc/ZHjcMuzH4R
 +p8gd0S/H/jLR7RxRaX2d0qpx+eWGsMwM+1tOmNWmgHXU5/kYWPAW8AeT0kksEz5jRVy
 k95MKs3WNdgc+GOJMKtHrW23/vfmFZAwTBcOt45345Cdn5lgqNM3gNNnuEMsUScSuMwV
 7yoaS5njcQz8Iajb8QoysCLgcCg5VMS7MZ2br2uer5TprP6oTqiTfBMsikneqBaammhe
 piOQ==
X-Gm-Message-State: AOAM532Go+F0hYUefcxrDFd73MEo0oLwhazIXrZInT04Rg1rkZgyHPv9
 PkIfyhsslP0F3m7otacetX96P4RakckKImgz3CvpL3zi2zIBDC16YDxRBz39/P22iOzaM0VoxLO
 U421JqAs8uk0tu1uuFWD/qgGvyI4=
X-Received: by 2002:a05:622a:5cf:: with SMTP id
 d15mr5985004qtb.106.1626385044920; 
 Thu, 15 Jul 2021 14:37:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuG7jW7KpT3HD3Su7Y434tMxY//IcZ9Tt+B14lks4YZYpSCon4MG8kdd1atIZulGOYtoUsgQ==
X-Received: by 2002:a05:622a:5cf:: with SMTP id
 d15mr5984979qtb.106.1626385044650; 
 Thu, 15 Jul 2021 14:37:24 -0700 (PDT)
Received: from loberhel ([2600:6c64:4e7f:cee0:729d:61b6:700c:6b56])
 by smtp.gmail.com with ESMTPSA id x9sm2498487qtf.76.2021.07.15.14.37.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Jul 2021 14:37:24 -0700 (PDT)
Message-ID: <8b0023f5ba9ede85f6f75159847b4c185ab68f6f.camel@redhat.com>
Subject: Re: New warning in nvme_setup_discard
From: Laurence Oberman <loberman@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oleksandr Natalenko
 <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org,  David Jeffery <djeffery@redhat.com>, Ming
 Lei <ming.lei@redhat.com>, Paolo Valente <paolo.valente@linaro.org>,  Jan
 Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>, Keith Busch
 <kbusch@kernel.org>
Date: Thu, 15 Jul 2021 17:37:21 -0400
In-Reply-To: <YPBD8z+yqC0ShjrZ@kroah.com>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPBD8z+yqC0ShjrZ@kroah.com>
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7)
Mime-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=loberman@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_143939_635292_B02FB866 
X-CRM114-Status: GOOD (  29.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2021-07-15 at 16:19 +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 15, 2021 at 03:56:38PM +0200, Oleksandr Natalenko wrote:
> > Hello.
> > 
> > After a v5.13.2 massive update I encountered this:
> > 
> > ```
> > [19231.556665] ------------[ cut here ]------------
> > [19231.556674] WARNING: CPU: 20 PID: 502 at
> > drivers/nvme/host/core.c:850 
> > nvme_setup_discard+0x188/0x1f0
> > ...
> > [19231.556776] CPU: 20 PID: 502 Comm: kworker/20:1H Not tainted
> > 5.13.2 #1
> > [19231.556780] Hardware name: ASUS System Product Name/Pro WS X570-
> > ACE, BIOS 
> > 3601 05/26/2021
> > [19231.556784] Workqueue: kblockd blk_mq_run_work_fn
> > [19231.556789] RIP: 0010:nvme_setup_discard+0x188/0x1f0
> > [19231.556794] Code: 49 8b 44 24 10 4c 8b 90 40 0b 00 00 4c 2b 15
> > 8f 09 d8 00 
> > 49 c1 fa 06 49 c1 e2 0c 4c 03 15 90 09 d8 00 4d 89 d0 e9 b9 fe ff
> > ff <0f> 0b b8 
> > 00 00 00 80 49 01 c2 72 52 48 c7 c0 00 00 00 80 48 2b 05
> > [19231.556798] RSP: 0018:ffffaed2416efc00 EFLAGS: 00010287
> > [19231.556802] RAX: ffff8e67fb580000 RBX: ffff8e640bbe5240 RCX:
> > 0000000000000020
> > [19231.556805] RDX: ffff8e67fb580000 RSI: 000000000000001f RDI:
> > 0000000000000000
> > [19231.556808] RBP: ffff8e640bbe5388 R08: ffff8e677b580000 R09:
> > 0000000008abb800
> > [19231.556811] R10: ffff8e677b580000 R11: 0000000000000400 R12:
> > ffff8e6405999c00
> > [19231.556814] R13: 000000000000001f R14: ffff8e6405693000 R15:
> > ffff8e640bbaf800
> > [19231.556816] FS:  0000000000000000(0000)
> > GS:ffff8e6b0ef00000(0000) knlGS:
> > 0000000000000000
> > [19231.556819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [19231.556822] CR2: ffff888c76ece000 CR3: 000000047a184000 CR4:
> > 0000000000350ee0
> > [19231.556825] Call Trace:
> > [19231.556830]  nvme_setup_cmd+0x2d0/0x670
> > [19231.556834]  nvme_queue_rq+0x79/0xc90
> > [19231.556837]  ? __sbitmap_get_word+0x30/0x80
> > [19231.556842]  ? sbitmap_get+0x85/0x180
> > [19231.556846]  blk_mq_dispatch_rq_list+0x15c/0x810
> > [19231.556851]  ? list_sort+0x21d/0x2f0
> > [19231.556856]  __blk_mq_do_dispatch_sched+0x196/0x320
> > [19231.556860]  __blk_mq_sched_dispatch_requests+0x14d/0x190
> > [19231.556864]  blk_mq_sched_dispatch_requests+0x2f/0x60
> > [19231.556867]  blk_mq_run_work_fn+0x43/0xc0
> > [19231.556871]  process_one_work+0x24e/0x430
> > [19231.556876]  worker_thread+0x54/0x4d0
> > [19231.556880]  ? process_one_work+0x430/0x430
> > [19231.556883]  kthread+0x1b3/0x1e0
> > [19231.556886]  ? __kthread_init_worker+0x50/0x50
> > [19231.556889]  ret_from_fork+0x22/0x30
> > [19231.556895] ---[ end trace d9abdf019a56b4c7 ]---
> > [19231.556906] blk_update_request: I/O error, dev nvme1n1, sector
> > 632935424 op 
> > 0x3:(DISCARD) flags 0x0 phys_seg 31 prio class 0
> > ```
> > 
> > or, in code:
> > 
> > ```
> >  850     if (WARN_ON_ONCE(n != segments)) {
> >  851         if (virt_to_page(range) == ns->ctrl->discard_page)
> >  852             clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
> >  853         else
> >  854             kfree(range);
> >  855         return BLK_STS_IOERR;
> >  856     }
> > ```
> > 
> > BFQ scheduler is in use.
> > 
> > Something similar was already fixed by
> > a958937ff166fc60d1c3a721036f6ff41bfa2821, 
> > but I do not have a multipath device here, it's just 2 NVMe SSDs in
> > a soft 
> > RAID10 with LUKS and LVM.
> > 
> > Any idea what this might mean? v5.13.2 brought some commit into a
> > stable tree 
> > that are, as I still suspect, causing unreproducible panics [1]
> > [2]. 
> > Previously, I dropped that extra stuff from my kernel build and had
> > no issues. 
> > This time I also do not have any extra commits in the block layer,
> > only those 
> > that are in v5.13.2.
> > 
> > Thanks.
> > 
> > [1] https://lore.kernel.org/linux-block/3533087.dJKXTdksHR@spock/
> > [2] https://lore.kernel.org/linux-block/2957867.CS06ZTPI5V@spock/
> 
> Can you run 'git bisect' to find the offending patch?
> 
> thanks,
> 
> greg k-h
> 


Hello


[root@ml150 ~]# uname -a
Linux ml150 5.14.0-rc1+ #1 SMP Thu Jul 15 16:41:08 EDT 2021 x86_64
x86_64 x86_64 GNU/Linux

[root@ml150 ~]# nvme list
Node             SN                   Model                            
        Namespace Usage                      Format           FW Rev  
---------------- -------------------- -------------------------------
--------- --------- -------------------------- ---------------- -----
---
/dev/nvme0n1     CVCQ536300C9400AGN   INTEL
SSDPEDMW400G4                      1         400.09  GB /
400.09  GB    512   B +  0 B   8EV10135
/dev/nvme1n1     CVFT7383000W400BGN   INTEL
SSDPEDMD400G4                      1         400.09  GB /
400.09  GB    512   B +  0 B   8DV10171

fwiw

I built 5.14 and I have 2 nvme devices and I am not seeing this even
using them to build the kernel on.

Regards
Laurence Oberman


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
