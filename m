Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB10DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6948261884
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 07:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6948261884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ii4O6zDAldGlTs+GqFwc0+zkv8fQ95BBBZj3l/PDPNo=; b=uv7KMMvJDdp2F1
	A5IM0/CXS7BOAvICtXFL4j1ujsazk1anQtJRT0u/0IS3Hh/LcAL4OIFSHHoSc/f9J5CUUCNwy6t4U
	BEKAB0R3W2Dtj3u60TMtL5ll42vEs9ITGcXFIIBWFHmj4N1NXMFJse43yHMqZVbksItQ1MdD2XkXf
	I82lQpgwuKMl1+Wi/vzENOh2FaljbSc7iQ4NFuIesWQEOn9FG2mQShlLUagWvGRp2e5abKWYxbRdb
	PrJAImi+3ezZvo0elnsGGV60oblj13RUIGDGkY47vp92xfCwLyAtcWYi66QwUwrYT/pT6vDSb0b7X
	+Pd6IQgo4zukGEY2PpEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVqGH-00DA2a-Dd; Thu, 30 Sep 2021 07:13:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVqGE-00DA21-HD
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 07:13:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632986021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hSxe5z1vrwMIT45Io44Wwi3lTYoCCfxXd5xSIIubdvU=;
 b=I6mqOtdFnx7dV00PxxhuYbZ08UPmYW1kiq7YvS5a5hpY0V+os4l8cANsIExada0gOQ9DtI
 dCWIJmxHnhPcFf4rmoRJkxqRtiazQlmLVVag1fuvItgqbiePDxpVkyBTotu7nxBx2ZSZgq
 T5L/vjdEiC3VH+tgb76jp9SFxrIrzK0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-loI7FBj6NvuKS5E1kq9GNw-1; Thu, 30 Sep 2021 03:13:36 -0400
X-MC-Unique: loI7FBj6NvuKS5E1kq9GNw-1
Received: by mail-yb1-f200.google.com with SMTP id
 b5-20020a251b05000000b005b575f23711so7160537ybb.4
 for <linux-nvme@lists.infradead.org>; Thu, 30 Sep 2021 00:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hSxe5z1vrwMIT45Io44Wwi3lTYoCCfxXd5xSIIubdvU=;
 b=eVvzWnnfZxf8bNgLbVDY6HTaI2avaifqn0RO3m/eh0H37xZsmdT+3AKlg4N0L7kHHp
 gn2xK+xR6e7FFaS8VIJG58m1IzX+58YR3DjKC6nbLqFgw7z/8lJpL6+WGYsSQohl1Kjv
 bgIOx6k8OxJU0k/JBdeUokmCNY/A95pU7MVo8A+cqjz7zVXsDou6QkIpA6Q3tP6dw2hR
 NNG/9vyOeTPSshERvtIJ9UuIaN9WnD+XuFagqd67iN5MB3NYRvYbJZrXI2TC5OOmgxiK
 GooILCWQ0y83MTXJahnIVZs3YaOKaodMCCHT5Rx1m1jL6cvTC+bl/ANFSX4zNe5YlaWd
 oETQ==
X-Gm-Message-State: AOAM533RzcoVQF7zs8oFy5WID1/25UWVxZRvLicfrWJ+KWR8GMRvzKWB
 GXPsK2ts+LK2g4HgfSUn+111rNeZO3WHY8aYc5mDADmItnfUdZ7huB7Ea1fkMp4kl36QJawurHq
 hNgc/ZH6yccpEEM5POBgdblCWFBRSTI75DHjw6rA0+1E=
X-Received: by 2002:a25:2208:: with SMTP id i8mr5023400ybi.86.1632986016194;
 Thu, 30 Sep 2021 00:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5TFFKY7QX6eb5NMtV0hkkn9/aLe2/KBt4g0ywh59oBI40XqHWqS9RNqBk/sTRlIQnpCKyoHIGFjIdyunA72Y=
X-Received: by 2002:a25:2208:: with SMTP id i8mr5023378ybi.86.1632986015937;
 Thu, 30 Sep 2021 00:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
In-Reply-To: <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 30 Sep 2021 15:13:23 +0800
Message-ID: <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_001342_667245_54B12708 
X-CRM114-Status: GOOD (  12.07  )
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

On Thu, Sep 30, 2021 at 3:04 PM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 9/29/21 10:59 PM, Yi Zhang wrote:
> > Hello
> >
> > Below kmemleak was triggered with blktests nvme-tcp on latest
> > 5.15.0-rc3, pls check it.
> >
>
> Please share the test number and the frequency to reproduce this...
>

Hi
I'm running the full blktests nvme-tcp[1] and it's 100% reproduced.

[1]
# nvme_trtype=tcp ./check nvme/

> > unreferenced object 0xffff8882bc8d6668 (size 8):
> >    comm "kworker/u26:2", pid 82, jiffies 4295107562 (age 2911.554s)
> >    hex dump (first 8 bytes):
> >      6e 67 31 6e 31 00 7b 7c                          ng1n1.{|
> >    backtrace:
> >      [<0000000046e1c456>] __kmalloc_track_caller+0x129/0x260
> >      [<00000000a8f7a3a1>] kvasprintf+0xa7/0x120
> >      [<0000000076a54cc5>] kobject_set_name_vargs+0x41/0x110
> >      [<00000000a569a16a>] dev_set_name+0x9b/0xd0
> >      [<00000000f793cc3d>] nvme_mpath_set_live+0x322/0x430 [nvme_core]
> >      [<000000001f948cbb>] nvme_mpath_add_disk+0x3ef/0x6a0 [nvme_core]
> >      [<00000000d405af45>] nvme_alloc_ns+0xeb1/0x1ae0 [nvme_core]
> >      [<000000002fd9b34d>] nvme_validate_or_alloc_ns+0x170/0x350 [nvme_core]
> >      [<000000009762df74>] nvme_scan_work+0x2dc/0x4b0 [nvme_core]
> >      [<000000007be5c512>] process_one_work+0x9a8/0x16b0
> >      [<000000002ae51314>] worker_thread+0x87/0xbf0
> >      [<0000000034c41079>] kthread+0x371/0x440
> >      [<0000000020c3a70f>] ret_from_fork+0x22/0x30
> > unreferenced object 0xffff8882d1509800 (size 512):
> >    comm "kworker/u26:2", pid 82, jiffies 4295107562 (age 2911.554s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> >      ff ff ff ff ff ff ff ff c0 b6 b7 97 ff ff ff ff  ................
> >    backtrace:
> >      [<00000000d6c8d6f1>] kmem_cache_alloc_trace+0x10b/0x220
> >      [<00000000e6493d28>] device_add+0xe08/0x1d10
> >      [<00000000aa40e6ce>] cdev_device_add+0xf1/0x150
> >      [<00000000142436f1>] nvme_cdev_add+0xf8/0x160 [nvme_core]
> >      [<00000000d948ccab>] nvme_mpath_set_live+0x347/0x430 [nvme_core]
> >      [<000000001f948cbb>] nvme_mpath_add_disk+0x3ef/0x6a0 [nvme_core]
> >      [<00000000d405af45>] nvme_alloc_ns+0xeb1/0x1ae0 [nvme_core]
> >      [<000000002fd9b34d>] nvme_validate_or_alloc_ns+0x170/0x350 [nvme_core]
> >      [<000000009762df74>] nvme_scan_work+0x2dc/0x4b0 [nvme_core]
> >      [<000000007be5c512>] process_one_work+0x9a8/0x16b0
> >      [<000000002ae51314>] worker_thread+0x87/0xbf0
> >      [<0000000034c41079>] kthread+0x371/0x440
> >      [<0000000020c3a70f>] ret_from_fork+0x22/0x30
> >
> >
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
