Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF5EC388F9
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 19:17:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08DD20731
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 19:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WHyTyjhU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G91EyXH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08DD20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WHFKutFzPEL7bZxelJXB+EVTSJmHOC9vtV0ZufgkX7c=; b=WHyTyjhUPbjNDMhTI2htBZ4MH
	RA/AZP+8R4oOXR0rAxS/haSmLOC47BOZ0SuZUFa8pw2+fzucKxoN5JlbtZ245FB1I+DGLlGiAdJ5B
	2dzxusA0/pHM+D1jmv7lV6c5NefRQLjkrFydU4v+nzxZ3WJSW0VLQhHbCV96hWyp4p8uuVzhky+oY
	7rGn538e79SnWz96Fs9sGXLdubKdMaIsOrxL/6XN2CyQnx6dyv2nd+xsjSwy+atICmFsy+l0AAfE7
	bjwMhR1/WxikoipFo7BFNr4uvCYVcaBBv/xysDNQOvlnpdHdV3jw5ymRZHBY63pK0uiHju8y6ryPE
	BoHKLwJFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbqBy-0007ri-Rd; Sun, 08 Nov 2020 19:17:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbqBw-0007qY-Cj
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 19:17:33 +0000
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8D30A206ED;
 Sun,  8 Nov 2020 19:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604863049;
 bh=fO1I/0/MePOvV5dnP7OrtcTdgBpIj6A3YMc14Pa/boc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G91EyXH+ykckGzPXvQsDA5Xx2PE56O1Px78yx8yctxK+eg1zCA3K+SvsIjskUxuZN
 RHH0GxgFdnbpvBG/GsPN6NL1ICAhYVDWxMx0KYGT4YmfAeVlJb3Z6UVbbUb67ayvMi
 B+kLmRV3NZJylQFcYZ3hYQ14HyZTXZS5QG2oPA0k=
Date: Sun, 8 Nov 2020 20:18:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201108191831.GA601832@kroah.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <da5be7f4-fa7e-3896-fd1e-8d2c0d80565a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <da5be7f4-fa7e-3896-fd1e-8d2c0d80565a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_141732_504062_ACFB688F 
X-CRM114-Status: GOOD (  19.72  )
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
Cc: Keith Busch <keith.busch@intel.com>, Mikulas Patocka <mpatocka@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Nov 08, 2020 at 11:13:11AM -0800, Sagi Grimberg wrote:
> 
> > The following two issues have been introduced by commit 1811977568e0
> > ("nvme/pci: Use async_schedule for initial reset work"):
> > - The boot process waits until all NVMe controllers have been probed
> >    instead of only waiting until the boot controller has been probed.
> >    This slows down the boot process.
> > - Some of the controller probing work happens asynchronously without
> >    the device core being aware of this.
> > 
> > Hence this patch that makes all probing work happen from nvme_probe()
> > and that tells the device core to probe multiple NVMe controllers
> > concurrently by setting PROBE_PREFER_ASYNCHRONOUS.
> 
> This would make the controller instance inconsistent across reboots
> which is annoying for some users.

Then they should use persistent device names, as that is what they are
there for :)

Bus naming persistance is not a thing, we have BIOSes that love to
renumber PCI busses every other boot quite frequently.  If you have such
whacky hardware, fix this in userspace which is where it has been done
for a while now.

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
