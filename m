Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EABCC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 14:20:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3459216FD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wKbDwX8W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="16H0NNM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3459216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wi0NSYRCzDqOj4L/VXU2xHN/J2Y6JFpROa3BhxKE3Gk=; b=wKbDwX8W/ZNjQMKf6zjKl3QN3
	1QH/3kUX0e/3KVQg9o5FzoUxXPu4bCi4XSW7lyh3qM49H+Dn7lC3Ohf28HeZuwU/qWhJxxjejVj86
	GIwUJJwIQ0dA08txefxSUWa9Bn/o9U3P67jFb730hH6kEXp6AoIeoSfowXkQPgfxbFh7QPcylpHuk
	bcePEUEwEx0EEDrMWc8NzSSCnOuhj1ZS/npd4Hc/oxFtcpq1vZBmSOw+c3TRasqAxlHC/sGcMwAxs
	YNFZg3srEF86AtfkEn2G4rlyI1genQ7MjxXhGAn6+Sx8hH+cWmzVQpOLfUFnYlpaWZLThjN99KUH2
	DmGY9bYpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdDSh-0002A2-C6; Thu, 12 Nov 2020 14:20:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdDSe-00028b-06
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 14:20:28 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6AF9521D40;
 Thu, 12 Nov 2020 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605190827;
 bh=UknmcBHv1OZQwbbc2C9LMYEYqVXzSKVAhq9Z/7YiCsE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=16H0NNM4X2oijwrsQdP7z2eCGwCYFBZFmubLWSiFUbNKugRinMbM/sHbztzdm4Brs
 imumncCKNAMnMEkloJvy29jntiexgQVYV72ZVuqmAQSdpCe5NWQpRV5eJknZp1GhPS
 lTKs6znc6+tXFOf6wV7HAhu4glnlBhKI3kqyoGZU=
Date: Thu, 12 Nov 2020 06:20:24 -0800
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201112142024.GB2573679@dhcp-10-100-145-180.wdc.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201111191920.GA2573679@dhcp-10-100-145-180.wdc.com>
 <a2e50a52-49bf-9a69-5897-d471db5054b0@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2e50a52-49bf-9a69-5897-d471db5054b0@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_092028_187741_D8DDFAB0 
X-CRM114-Status: GOOD (  23.76  )
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

On Wed, Nov 11, 2020 at 08:26:12PM -0800, Bart Van Assche wrote:
> On 11/11/20 11:19 AM, Keith Busch wrote:
> > On Sat, Nov 07, 2020 at 08:09:03PM -0800, Bart Van Assche wrote:
> >> The following two issues have been introduced by commit 1811977568e0
> >> ("nvme/pci: Use async_schedule for initial reset work"):
> >> - The boot process waits until all NVMe controllers have been probed
> >>   instead of only waiting until the boot controller has been probed.
> >>   This slows down the boot process.
> >> - Some of the controller probing work happens asynchronously without
> >>   the device core being aware of this.
> >>
> >> Hence this patch that makes all probing work happen from nvme_probe()
> >> and that tells the device core to probe multiple NVMe controllers
> >> concurrently by setting PROBE_PREFER_ASYNCHRONOUS.
> > 
> > I am finding that this setting probes devices in parallel on boot up,
> > but serially for devices added after boot. That's making this a rather
> > unappealing patch.
> 
> Hi Keith,
> 
> Thanks for having verified this. However, to me it is unexpected that my
> patch results in serial probing of NVMe devices added after boot. It
> would be appreciated if more information could be shared about how that
> test was run. I'm wondering whether the serialization perhaps was the
> result of how the test was run? My understanding of the driver core is
> that the decision whether or not to probe concurrently is taken inside
> __driver_attach() and also that PROBE_PREFER_ASYNCHRONOUS should trigger
> a call of the following code:
> 
> 		async_schedule_dev(__driver_attach_async_helper, dev);
> 
> I expect that calling the above code should result in concurrent probing.

The easiest check is something like this (as long as you're not actively
using your nvme namespaces):

  # echo 1 | tee /sys/class/nvme/nvme*/device/remove
  # echo 1 > /sys/bus/pci/rescan

The subsequent probes don't go through the async_schedule. They have
this stack instead:

[   44.528906] Call Trace:
[   44.530512]  dump_stack+0x6d/0x88
[   44.532373]  nvme_probe+0x2f/0x59b [nvme]
[   44.534466]  local_pci_probe+0x3d/0x70
[   44.536471]  pci_device_probe+0x107/0x1b0
[   44.538562]  really_probe+0x1be/0x410
[   44.540564]  driver_probe_device+0xe1/0x150
[   44.542733]  ? driver_allows_async_probing+0x50/0x50
[   44.545170]  bus_for_each_drv+0x7b/0xc0
[   44.547172]  __device_attach+0xeb/0x170
[   44.549163]  pci_bus_add_device+0x4a/0x70
[   44.551182]  pci_bus_add_devices+0x2c/0x70
[   44.553229]  pci_rescan_bus+0x25/0x30
[   44.555126]  rescan_store+0x61/0x90
[   44.556975]  kernfs_fop_write+0xcb/0x1b0
[   44.558940]  vfs_write+0xbe/0x200
[   44.560710]  ksys_write+0x5f/0xe0
[   44.562483]  do_syscall_64+0x2d/0x40
[   44.564354]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
