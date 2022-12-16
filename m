Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8278C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Dec 2022 14:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0s1vkC4npafRchIGCLMH+cYc3bwKYSyxFblxBv9w+o=; b=GSvf7rN8st6ogIWIM0hWIwAz/m
	/J09n7kD+rjMqWEQclW2uahoS+aS8LjZzidagpH5wVfkDQXaLkjqEqYNpMVlFehGlGC/U48zL1UQj
	7vHYrczHrOfHzv5zZaU7Ao518DYpWGdQa5RlhlnQw75GbKv3B0kQXsy/HO6RyhrGARTID9H8xxcuZ
	Y5CziP25p0GUJF6X1Q37jFNFG2yjrUeUohytOYhk9uoERKQGuldbniqC2GnFOfx4DWv+Siz3f6TMD
	Pg6WM9qj/cvCS8JsuaG5Iw7Rae32tyFg0GzRL5kBjP+QBU73qMvSPhv1tfzvdy3P8rzYI1sJAaE/e
	RaEg6qnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6C19-00FqU4-Ov; Fri, 16 Dec 2022 14:48:55 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6C15-00FqRY-QN
	for linux-nvme@lists.infradead.org; Fri, 16 Dec 2022 14:48:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D61D4B81C34;
	Fri, 16 Dec 2022 14:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FFCC433EF;
	Fri, 16 Dec 2022 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671202126;
	bh=V74lffnRer++JPYlRULneaAzG/TpNhmfuUnnddHF114=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaxInCmuq/4179iowoF2CxVu7EuT1R2GV+Qq2ze1Ve9qoQspRMKijWK/LC057QXZM
	 xnRsXCdG8dBXUMWQ35bIIHNboV2Z3o3EEpfSv+HhoW6sPbbi+J917JMKQjij4yT2EW
	 EMwrwVt9pOaJbrTG60rSNca1vG5UOXSVu5EHxqcwrI55k2UvESxIcFe4Kk20efjcLU
	 JKBgKiA3AdY0tYlJYGxrAtmyElaiTB5tmQwQ+4eGJspifdnX33KYtKUEuc0jAtDDNt
	 b0GQzZDJpoANqUm2nMSjYUKbYhCRSQ4xmatl/ARERn0aFdZHWyKf5ZtJ/1dbWj0GbZ
	 bt+60fzocrg2w==
Date: Fri, 16 Dec 2022 07:48:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nick Neumann <nick@pcpartpicker.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Consumer SSD listing namespace as nvme0c0n1 instead of nvme0n1
 in /sys/class/ ?
Message-ID: <Y5yFSzhcXydajQtZ@kbusch-mbp.dhcp.thefacebook.com>
References: <CADqNVTrUOw1VSZLctBeeJpKYe2b1wsLOLvitqejfDDv=Q7rHbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqNVTrUOw1VSZLctBeeJpKYe2b1wsLOLvitqejfDDv=Q7rHbQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221216_064852_036032_BD964694 
X-CRM114-Status: GOOD (  17.83  )
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

On Thu, Dec 15, 2022 at 03:27:59PM -0600, Nick Neumann wrote:
> As part of being careful to not get bit by namespaces whose name
> format doesn't match their device
> (https://github.com/linux-nvme/nvme-cli/issues/510), I look in
> /sys/class/nvme/nvme0 to find the namespaces that belong to /dev/nvme0
> .
> 
> This has worked well on a ton of consumer NVME devices, and the
> namespace has always been of the pattern nvme0n1 . But I recently ran
> into a consumer NVME device that listed a namespace of nvme0c0n1 in
> /sys/class/nvme/nvme0, and no nvme0n1 .
> 
> Running "nvme list" returns the nvme0n1 pattern namespace, and
> attempts to use nvme0c0n1 with various tools complain that no such
> device exists.Using nvme0n1 as the namespace works.
> 
> I've tried reading articles on DM vs native multipathing but it's
> still a bit over my head. Is the way this device is presenting itself
> incorrect, or is it just an uncommon way of doing things?

This is how it will look since your namespace is reporting multipathing
capabilities, and your kernel enabled native nvme multipathing.

The block names with the "c<#>" pattern are hidden from direct use.
These represent a path to visible block handle.

You can check the relationship among these in sysfs:

  # ls -l /sys/block/nvme0n1/device
  lrwxrwxrwx 1 root root 0 Dec 16 06:40 /sys/block/nvme0n1/device -> ../../nvme-subsys0/

  # ls -l /sys/block/nvme0n1/device/nvme*
  lrwxrwxrwx 1 root root 0 Dec 16 06:39 /sys/block/nvme0n1/device/nvme0 -> ../../../pci0000:00/0000:00:05.0/nvme/nvme0/

  # ls -l /sys/block/nvme0n1/device/nvme0/ | grep nvme
  drwxr-xr-x 8 root root    0 Dec 16 06:39 nvme0c0n1/

This shows the visible block handle, nvme0n1, is attached to
nvme-subsys0, which contains exactly one controller, nvme0, and that
controller is providing exactly one namespace path: nvme0c0n1.

