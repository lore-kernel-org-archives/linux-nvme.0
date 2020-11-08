Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A409C388F9
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 22:32:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C582206DB
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 22:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I+SToH+d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikACOm9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C582206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7IyEo5FqtIj5pMw5HrtBrToogATOc781JchZjMDb6Os=; b=I+SToH+dE6cq1X/AM42F6irvw
	UzXnygmEiUwZNnVQjwB61P5Zg+DfK9H7AcgyHnuKBl0B6bMRlRMOG1Ap9VZCqkk9poNG03gvjZcVB
	v+8CwGhl+9oJb/WBEMbWhADYq1y+ZW83gwv4X6Thfc0T+1qAokfddG3YPsplaZFir48HpHwwL4JKA
	zfbPJ35GVLhRWOn4pDAiCalXRBvlqkkjQkLW1ivKN8GOpq3GQJElVGGNJnYDHuw4187KjspPVuA5D
	C++eaCWA5JNqC/pao9pRAyfBy/fEHhcWdCIo2k6VZBPhLSJDSnTbM6bRNVrvkBBQbe3aArt76I79h
	pCVokTfww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbtEA-000279-BN; Sun, 08 Nov 2020 22:32:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbtE5-00026g-P7
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 22:31:58 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B984B206D8;
 Sun,  8 Nov 2020 22:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604874715;
 bh=Uea94Uo5nr46mnVHHJr1pt0sXzz1NWuf141IHDDT2PI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ikACOm9ZHGpfADkQ29nZNdzCOmG2dCLoTCEDePM2yTJIZP5vuj2zMQV/K1+MwX1FZ
 e3BJPQil/FGnkoyB/tTNlq3dnzUoorItrW5RWeuD35RXpQ3gXBlNxs2S/hwADgeyGf
 4bwX1M7swvw544SOqB25Bdg4fb1jTWe4t4bXs5Zg=
Date: Sun, 8 Nov 2020 14:31:52 -0800
From: Keith Busch <kbusch@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201108223152.GA2219646@dhcp-10-100-145-180.wdc.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201108082403.GB40741@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201108082403.GB40741@kroah.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_173157_968270_F21A26FB 
X-CRM114-Status: GOOD (  19.28  )
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
Cc: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Mikulas Patocka <mpatocka@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Nov 08, 2020 at 09:24:03AM +0100, Greg KH wrote:
> On Sat, Nov 07, 2020 at 08:09:03PM -0800, Bart Van Assche wrote:
> > The following two issues have been introduced by commit 1811977568e0
> > ("nvme/pci: Use async_schedule for initial reset work"):
> > - The boot process waits until all NVMe controllers have been probed
> >   instead of only waiting until the boot controller has been probed.
> >   This slows down the boot process.
> > - Some of the controller probing work happens asynchronously without
> >   the device core being aware of this.
> > 
> > Hence this patch that makes all probing work happen from nvme_probe()
> > and that tells the device core to probe multiple NVMe controllers
> > concurrently by setting PROBE_PREFER_ASYNCHRONOUS.
> > 
> > Cc: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> 
> A fixes: tag?

Why? Whether this is an improvement or not, the current code isn't
broken.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
