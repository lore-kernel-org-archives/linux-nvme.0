Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7607EC388F9
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 02:35:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF50206D8
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 02:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XDlZgxrf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4PHycfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF50206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ynd4evw/NUmx/+8h9H59wORphFid62LI08uAnM3i+ds=; b=XDlZgxrfwlgYNyE/0aCUWuL4I
	9telONNATG+H3DdfEdFKHuERbg/zUWrNiEtNE7luyMLdDhqPUIci73YPwncxtKw0/ZmxvrUBMXJIo
	113DMgMWcrNCFvIb1srQq5egx3G40kUHSQ2lWRR352xoQKiw081N/CJDOBDG1HrqHZk88Y5zfp0cJ
	OJPDMa3pydQBke8ag8l5OPLTgR42HvNMzA1odd8keMSx2LlJJQh83Zj2q/dJdPut23IfHfnjBFMLa
	oT5ln7T33W2SAFx7N3NreT3yokt92AHRyw76Bh4ui5czrsGgujaVQlYeKOu8AVneLC/W8D5nwp0/j
	BZ3DsBiXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbx28-00061R-Ul; Mon, 09 Nov 2020 02:35:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbx23-00060d-Fl
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 02:35:50 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E5FB3206D8;
 Mon,  9 Nov 2020 02:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604889346;
 bh=QitXbsd3yVEDmhHNW/3EmJZgMTKKWh4dOQzyIMDeZhI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z4PHycfVQC6o46CfTG6wucBHjD4p8E5cxkw0NMYKVZpyBBdXvJoKxYD33v+sr1XnI
 2Tf3cngiiyGfNqL7MHpKM7m4/euF0EbNThhSHdw6UNLiaa6PojI23LUBIW44y0QCC0
 6f/Hj1BANWcgP8bdLMdGCmnGletdq+NkZ4sa+HaM=
Date: Sun, 8 Nov 2020 18:35:44 -0800
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201109023544.GB2219646@dhcp-10-100-145-180.wdc.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201108082403.GB40741@kroah.com>
 <20201108223152.GA2219646@dhcp-10-100-145-180.wdc.com>
 <8ee7a7b0-5be4-99a3-7314-77d784e2ebb7@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8ee7a7b0-5be4-99a3-7314-77d784e2ebb7@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_213547_693581_2D3A4AA7 
X-CRM114-Status: GOOD (  22.05  )
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

On Sun, Nov 08, 2020 at 03:35:27PM -0800, Bart Van Assche wrote:
> On 11/8/20 2:31 PM, Keith Busch wrote:
> > On Sun, Nov 08, 2020 at 09:24:03AM +0100, Greg KH wrote:
> >> On Sat, Nov 07, 2020 at 08:09:03PM -0800, Bart Van Assche wrote:
> >>> The following two issues have been introduced by commit 1811977568e0
> >>> ("nvme/pci: Use async_schedule for initial reset work"):
> >>> - The boot process waits until all NVMe controllers have been probed
> >>>   instead of only waiting until the boot controller has been probed.
> >>>   This slows down the boot process.
> >>> - Some of the controller probing work happens asynchronously without
> >>>   the device core being aware of this.
> >>>
> >>> Hence this patch that makes all probing work happen from nvme_probe()
> >>> and that tells the device core to probe multiple NVMe controllers
> >>> concurrently by setting PROBE_PREFER_ASYNCHRONOUS.
> >>>
> >>> Cc: Mikulas Patocka <mpatocka@redhat.com>
> >>> Cc: Keith Busch <keith.busch@intel.com>
> >>> Cc: Greg KH <gregkh@linuxfoundation.org>
> >>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >>> ---
> >>
> >> A fixes: tag?
> > 
> > Why? Whether this is an improvement or not, the current code isn't
> > broken.
> 
> Hi Keith,
> 
> My understanding is that the device driver core generates a 'bind'
> uevent after nvme_probe() returns (see also driver_bound() in
> drivers/base/dd.c). Do you agree that emitting KOBJ_BIND while
> nvme_reset_work() is in progress triggers a race condition between
> nvme_reset_work() and udev rules that depend on the result of code in
> nvme_reset_work(), e.g. NVMe queue creation or nvme_init_identify()?

The only user space visible artifact the driver creates on bind is the
controller character device, and access to that during a reset is
handled by the driver's state machine.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
