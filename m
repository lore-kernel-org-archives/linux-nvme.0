Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C59C47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 13:57:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D457B6101E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 13:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D457B6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ZVnK4YWYpuCqoWvuKiC4mQxjQ1HKa5bQeD5yYStdQs=; b=ajBXZvw2M/Vxmi
	6OcvmZ2PSyvNQicpdK2jdWGEeDfA1QaUXBE8U7SAqEUiavy1vk+d0Xmq4NibXo8RwhJW40OLg/GiK
	VNBtjs3Wl53g4OgRgIxZYNWi2wBH+NEf/yyePCl/tqvi+A7mJfF9V9/iKQdsMcr9BwiZ7pN2pR+VW
	d79al5SjpkKCfh2UgoXOBBmDj2udd5wGk1nz/GLMY3byQ3asMne7/AJyq5LWmjLHDf3ZHiAKgWdbh
	aGXE1R3UMsGsoa+vp042uC4PvdojKI2HduWg8J+cMX/4ntczWA5c5jAlXJexJfq/qWMckQXXkXZ+E
	FfgQGAzvhBJQA2kpmh7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llu1X-00Edqn-FS; Wed, 26 May 2021 13:56:39 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llsOD-00DrQe-Hy
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 12:11:58 +0000
Received: from mail-lf1-f72.google.com ([209.85.167.72])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>) id 1llsOA-0006cq-Q1
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 12:11:54 +0000
Received: by mail-lf1-f72.google.com with SMTP id
 p10-20020a19f10a0000b02901d675ef8fb8so572778lfh.16
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 05:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t4iEXWHzNZUnU66UdlOFVaCkSN/bmGsjDThaNffoTfk=;
 b=GhB50KI3RoL8KPuNbY2eQJ5Bx9x6i9ZPTHrWMxfr0E0AIJ3BCCXbNhFuf8P8C4l3x4
 4YcoYL3teHDQ+8tibrO8L8nDeDsrJ/OSCDmCWg0FTjTKjKhu9iXz2d9FRtopoYDkbCF4
 WZcyqyX6xT6n29WdjUmjeYpwPfoiFH2goift5LphMthmBhgOOZG4qQVfAejpS4HlY7rl
 O5mapgHstJXYp0OfZHxZY0p5DI3F640pqbkPJFQ3yLYeXHQ+1lVV/UJNCiwML2zLHGlO
 vt4N0eI04jOsUMPBcNZ6jd2fUg6HPWia00oBEUL8eRLr2mwgrxQHWURVdffMhW3t2+Uy
 OGMg==
X-Gm-Message-State: AOAM531YO/4NZDpi4GyWN/N1vHmZ1GclgWxD5tj51FHrkVKe8v/xHljw
 4w9bQASi7aSqL1XYO3Mc6AyOsYuoToyy7gqGs2ebd4O+Ogz0nNW5BlZi8wfCM+2AEKR3xrv9pn+
 urNRVxspNlzXysCqBJ31xbmROWQs9n6wMAVXdnh9E7xkSvKEvS/J3MNL3kxFS
X-Received: by 2002:a05:651c:3c9:: with SMTP id
 f9mr2040017ljp.403.1622031114141; 
 Wed, 26 May 2021 05:11:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvrYi6Me7vN2V1qsIo5OzULYPjkA+wU86ikFoE6Ao6vMy4kDVnkEo/WlqK9jtIZJwOy55Hwtp3SiuyfSz11wI=
X-Received: by 2002:a05:651c:3c9:: with SMTP id
 f9mr2040007ljp.403.1622031113922; 
 Wed, 26 May 2021 05:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de>
 <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
 <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 26 May 2021 20:11:41 +0800
Message-ID: <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
To: Keith Busch <kbusch@kernel.org>
Cc: Koba Ko <koba.ko@canonical.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_051157_633709_7BE02CC0 
X-CRM114-Status: GOOD (  16.49  )
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

On Wed, May 26, 2021 at 10:49 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, May 26, 2021 at 10:02:27AM +0800, Koba Ko wrote:
> > On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > > > After resume, host can't change power state of the closed controller
> > > > from D3cold to D0.
> > >
> > > Why?
> > As per Kai-Heng said, it's a regression introduced by commit
> > b97120b15ebd ("nvme-pci:
> > use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.
>
> That really doesn't add up. The mentioned commit restores the driver
> behavior for HMB drives that existed prior to d916b1be94b6d from kernel
> 5.3. Is that NVMe device broken in pre-5.3 kernels, too?

Quite likely. The system in question is a late 2020 Ice Lake laptop,
so it was released after 5.3 kernel.

Kai-Heng

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
