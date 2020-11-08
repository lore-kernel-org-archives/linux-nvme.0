Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D903C388F2
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 08:24:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDD3206F4
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 08:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2NXIZH0Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEaTNN1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDD3206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ENEZx6YHcGHtNgZuLpgBzf1RBU+bRtcKqR9J8SWZ/h0=; b=2NXIZH0ZcZ7dSHXuRjQXWLPrL
	7uBBY58KlTIifMVqEeu3XpaVcywGX/E8jNw/bTgTNJ3qfw/WqCZJZyZUrwfWnJ1Nvwnbu/upCcatr
	Ap/O91weRBve3XphZ9apQZCvnyUlmfxJfwbJ/UB5mCYkEfgXVaDBFbzNPWi2RxYA5pf/YYJCORBSW
	hAe0zUju8WYhkJmto6RraVOBF8+MArpJ0M1Rz3RzH0mJELureMacoJZ6WjaF9RXzBbZwvu5pKi2iD
	5ZQvct0cCdBj5PoAuUv4SFDbK8z3kSvxb+JB4yWPbSLaEKxKouAY9u70Add5QcWIdu9h3lxGZSxIT
	R687tsDrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbfzg-0001Gb-TF; Sun, 08 Nov 2020 08:24:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbfzd-0001Fz-Hd
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 08:24:10 +0000
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 83392206F4;
 Sun,  8 Nov 2020 08:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604823847;
 bh=YyQQL03P9nUnKmQiFVbUDoD5d9naT5F0lbwPPUAXxcM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hEaTNN1godJ8RxWeYXKBYWYJtgpvSno8Wtu0jI4iOqg7gr/j2sUgXieTESgWg88bf
 u5ULsFRZtpLdqRHCbQVm38jr/iGZ5Y/NOs8OGJnzfq0LlofZObu5/68nlTBiH91VWc
 iOjJbMEUsEcO5zaZ0bCcalEoYRsRuKVOdrmgUJi0=
Date: Sun, 8 Nov 2020 09:24:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201108082403.GB40741@kroah.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201108040903.8185-1-bvanassche@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_032409_675932_5E4BC5DC 
X-CRM114-Status: GOOD (  15.81  )
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
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Nov 07, 2020 at 08:09:03PM -0800, Bart Van Assche wrote:
> The following two issues have been introduced by commit 1811977568e0
> ("nvme/pci: Use async_schedule for initial reset work"):
> - The boot process waits until all NVMe controllers have been probed
>   instead of only waiting until the boot controller has been probed.
>   This slows down the boot process.
> - Some of the controller probing work happens asynchronously without
>   the device core being aware of this.
> 
> Hence this patch that makes all probing work happen from nvme_probe()
> and that tells the device core to probe multiple NVMe controllers
> concurrently by setting PROBE_PREFER_ASYNCHRONOUS.
> 
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

A fixes: tag?

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
