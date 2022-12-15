Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FD8C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+HVvbFw8D+v+jhFr5miEbhT3XfrnbE2QwwtJC3dcjMI=; b=Czt8v55m99p7v/EiCe+awKd+uH
	H64CgJwE7270UMp0m1BWKCrJLX8BuQThHPqi1CTMu4eRXJS3CzIu/+TaYkSXh7wGEIlJBREeLO0t5
	9qIvZ00jJxKAU+oq+djul9t77UCk3QIeNk+ArxSPwdIvXGDayDYow6Imahks5CbrR/8Slso0Ypx3O
	jXoqofbifsRTPlTjpHztGBYbgymXL1+622vstN95wNLbs8MqhZHXJEuWYM25yhb08FasD3YgybnoL
	YilKSDjSrpvEUjSULNrqD39qUNcqNHaAeb5G4G8tCFSnYZCWNYj+h7CFD+kvJUn1zogb3gYDwqdOs
	fCVkJemQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5jWx-007epa-B4; Thu, 15 Dec 2022 08:23:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5jWv-007enL-BP
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 08:23:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 098E168AA6; Thu, 15 Dec 2022 09:23:45 +0100 (CET)
Date: Thu, 15 Dec 2022 09:23:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: "J. Hart" <jfhart085@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
	hch@lst.de, sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <20221215082344.GB3816@lst.de>
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_002349_553135_29174760 
X-CRM114-Status: GOOD (  22.80  )
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

On Thu, Dec 15, 2022 at 10:38:33AM +0900, J. Hart wrote:
> I am attempting to load an nvme device (nvme0n1) to use as main system 
> drive using the following command:
>
> rsync -axvH /. --exclude=/lost+found --exclude=/var/log.bu 
> --exclude=/usr/var/log.bu --exclude=/usr/X11R6/var/log.bu 
> --exclude=/home/jhart/.cache/mozilla/firefox/are7uokl.default-release/cache2.bu 
> --exclude=/home/jhart/.cache/thunderbird/7zsnqnss.default/cache2.bu 
> /mnt/root_new 2>&1 | tee root.log
>
> The total transfer would be approximately 50 GB.  This is being done at run 
> level 1, and only the kernel threads and the root shell are observed to be 
> active.
>
> The following log messages appear after a minute or so, and rsync hangs. 
> The nvme drive cannot be unmounted without a reboot.

Ok, this looks like the driver has firmware / hardware problems and
can't copy wit hthe load.

>
> dmesg reports the following:

nvme0 is the destination driver I guess?

>
> [Dec14 19:24] nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting

Can you enable CONFIG_NVME_VERBOSE_ERRORS so that we can see what
commands are hanging?

> I have also observed file system corruption on the source drive of the 
> transfer.  I would not normally think this to be related, except that after 
> the first time I observed it, I made certain that I corrected the file 
> content before any additional attempts, but have seen this again after 
> every attempt.  The modification dates and file sizes did not change, but 
> the file content on the source drive did.  I confirmed this using the 
> "diff" utility, and again using a rsync dry run with the check sum test 
> enabled.

Ok, that's really odd.  The only way I could think of that happening
is if the driver does stay DMAs, which would be really grave.

Do you have CONFIG_INTEL_IOMMU and CONFIG_INTEL_IOMMU_DEFAULT_ON enabled?
If not, it would be good to enable those to see if the iommu catches
any stray DMAs.

