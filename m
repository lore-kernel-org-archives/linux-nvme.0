Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CCEC56201
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 20:18:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5655922242
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 20:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZQcnwynA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGgkDWPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5655922242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hY1Clc7vbnzG54+qHDkD3jFj9ufLsx8Fa+qUxbBt+Uo=; b=ZQcnwynA0857Cy1KVisiLnlzX
	/e6whBakvitbo83fbl9DcvFG75sStogXkl3Da6KNPE1K1rravUA/XL9qy4tS5BKDtLi2tZ2yzy8od
	JM18gQy9xsyV0pIzkP5SEMXNUcKrypcRIcJdZ3aWMVloeibIDuv8rm+gRBGnnjFvVRDamfeAd10dH
	YSfZqDMbmPkRRlJPiYaGUTf9luVtRTb8AZesWKWYu3+E5CIzj4LVx9phJhfX/I26h4ghR0wmJokmI
	+UJ4kbC7SqQckHCcLO9PPdgTstv5SD4yPg8B+xTz2vQ0b6M4P3aNnWtKuzG00zoqAogTNeCYPX82j
	IDg/89x1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfqNf-0002KD-WA; Thu, 19 Nov 2020 20:18:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfqNc-0002JR-UP
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 20:18:09 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B2BAB221FC;
 Thu, 19 Nov 2020 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605817087;
 bh=msVORNtmoVzwS5rfQ5EQAClijESE6cGzz8MADitK+eQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aGgkDWPrViJbO57OEy4JNXAOotMQJ2swId3u+lPsirlKCgNXqhf5c0lnTHPDW3UGT
 9PU4c70kR1q5v5COHjQd11d5bQ+8q3L/bnNJGfN/NzGNU4yhB9F6EAPzAcKBdsUCJg
 f8jOsDIwq1QWmws3lHxIMG5YdepOZNz6uSDfS9Zc=
Date: Thu, 19 Nov 2020 12:18:04 -0800
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201119201804.GA2855047@dhcp-10-100-145-180.wdc.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201111191920.GA2573679@dhcp-10-100-145-180.wdc.com>
 <a2e50a52-49bf-9a69-5897-d471db5054b0@acm.org>
 <20201112142024.GB2573679@dhcp-10-100-145-180.wdc.com>
 <fa3eb5e6-7864-ecce-df92-fd7a2b913f3a@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa3eb5e6-7864-ecce-df92-fd7a2b913f3a@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_151809_092513_7D352F9C 
X-CRM114-Status: GOOD (  16.08  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 18, 2020 at 07:08:49PM -0800, Bart Van Assche wrote:
> On 11/12/20 6:20 AM, Keith Busch wrote:
> > The easiest check is something like this (as long as you're not actively
> > using your nvme namespaces):
> > 
> >   # echo 1 | tee /sys/class/nvme/nvme*/device/remove
> >   # echo 1 > /sys/bus/pci/rescan
> > 
> > The subsequent probes don't go through the async_schedule. They have
> > this stack instead:
> > 
> > [   44.528906] Call Trace:
> > [   44.530512]  dump_stack+0x6d/0x88
> > [   44.532373]  nvme_probe+0x2f/0x59b [nvme]
> > [   44.534466]  local_pci_probe+0x3d/0x70
> > [   44.536471]  pci_device_probe+0x107/0x1b0
> > [   44.538562]  really_probe+0x1be/0x410
> > [   44.540564]  driver_probe_device+0xe1/0x150
> > [   44.542733]  ? driver_allows_async_probing+0x50/0x50
> > [   44.545170]  bus_for_each_drv+0x7b/0xc0
> > [   44.547172]  __device_attach+0xeb/0x170
> > [   44.549163]  pci_bus_add_device+0x4a/0x70
> > [   44.551182]  pci_bus_add_devices+0x2c/0x70
> > [   44.553229]  pci_rescan_bus+0x25/0x30
> > [   44.555126]  rescan_store+0x61/0x90
> > [   44.556975]  kernfs_fop_write+0xcb/0x1b0
> > [   44.558940]  vfs_write+0xbe/0x200
> > [   44.560710]  ksys_write+0x5f/0xe0
> > [   44.562483]  do_syscall_64+0x2d/0x40
> > [   44.564354]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Hi Keith,
> 
> Thanks for the feedback. I will look further into this but I wouldn't
> mind if someone else would come up with a solution before I have a
> solution ready.

I suppose you could just add the PROBE_PREFER_ASYNCHRONOUS probe_type,
and let nvme_probe() continue to attempt its own async initialization.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
