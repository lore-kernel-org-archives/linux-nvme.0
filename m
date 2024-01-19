Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B617CC47DAF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 22:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mbnDyIiVf5E50dfFktZEEA5wjQCTaxqYRqmmy0cjVgM=; b=qlxlP7hhdmnvSF9QzKvFqHeflk
	aGLrBTgPMZcSILlfQB2YnRxgQDlrGhZUl8H1FFRzuoC3RS5hudGByo2u7N3RJOyw1XJlnf1JBrMi8
	GpnUPtIbx0VWZKphCoulU0h3RVq+bNPc9rQWU522Fo9mE90F7/Ex5J0CIKxW6FQc44sgf9YE0PA4z
	FASDGPhEfO9HikVxSQSNy4K49zluOpp64Sqq1mEtb6ZwH3esIM43hBYJ0YWxm5w4MfSgI1FAulF9i
	o6ZPy1nmHmFGnOSRkyVG5bMfREMvScWTlggs+v1t9A1W3Kx8r/NMYiMccrCBRUxXSqAHF2n+A9Ttk
	xfztEHWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQxEB-006m4E-27;
	Fri, 19 Jan 2024 22:20:43 +0000
Received: from redpilled.dev ([195.201.122.22])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQxE8-006m3o-1X
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 22:20:42 +0000
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redpilled.dev;
	s=mail; t=1705702833;
	bh=mbnDyIiVf5E50dfFktZEEA5wjQCTaxqYRqmmy0cjVgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MWZC+UuTt38VN3GTbHaTX9BX9UlKHSC67V0tcchpS+6KGHkeOXX1sCEhvIaf4rogY
	 +G1qrEm8TD2CWMgWdR0ntG4R0IFEBxBd0g/u2x3A8bVFn84U8a/ufjBzOD2Oqjt2li
	 Rxr/Fp1GVqIcD5PDZ0UyklZgjqvT77Rd37iJs9xo=
Date: Fri, 19 Jan 2024 22:20:32 +0000
From: Mia Kanashi <chad@redpilled.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcachefs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [BUG] I/O timeouts and system freezes on Kingston A2000 NVME with
 BCACHEFS
In-Reply-To: <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
References: <54fcc150f287216593b19271f443bf13@redpilled.dev>
 <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
Message-ID: <7d9c23450fb3fca7e3820c317c24b112@redpilled.dev>
X-Sender: chad@redpilled.dev
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_142040_702264_A702DEDC 
X-CRM114-Status: GOOD (  25.72  )
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

On 2024-01-19 21:22, Jens Axboe wrote:
> On 1/19/24 5:25 AM, Mia Kanashi wrote:
>> This issue was originally reported here: 
>> https://github.com/koverstreet/bcachefs/issues/628
>> 
>> Transferring large amounts of files to the bcachefs from the btrfs
>> causes I/O timeouts and freezes the whole system. This doesn't seem to
>> be related to the btrfs, but rather to the heavy I/O on the drive, as
>> it happens without btrfs being mounted. Transferring the files to the
>> HDD, and then from it to the bcachefs on the NVME sometimes doesn't
>> make the problem occur. The problem only happens on the bcachefs, not
>> on btrfs or ext4. It doesn't happen on the HDD, I can't test with
>> other NVME drives sadly. The behaviour when it is frozen is like this:
>> all drive accesses can't process, when not cached in ram, so every app
>> that is loaded in the ram, continues to function, but at the moment it
>> tries to access the drive it freezes, until the drive is reset and
>> those abort status messages appear in the dmesg, after that system is
>> unfrozen for a moment, if you keep copying the files then the problem
>> reoccurs once again.
>> 
>> This drive is known to have problems with the power management in the
>> past:
>> https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting
>> But those problems where since fixed with kernel workarounds /
>> firmware updates. This issue is may be related, perhaps bcachefs does
>> something different from the other filesystems, and workarounds don't
>> apply, which causes the bug to occur only on it. It may be a problem
>> in the nvme subsystem, or just some edge case in the bcachefs too, who
>> knows. I tried to disable ASPM and setting latency to 0 like was
>> suggested, it didn't fix the problem, so I don't know. If this is
>> indeed related to that specific drive it would be hard to reproduce.
> 
> From a quick look, looks like a broken drive/firmware. It is suspicious
> that all failed IO is 256 blocks. You could try and limit the transfer
> size and see if that helps:
> 
> # echo 64 > /sys/block/nvme0n1/queue/max_sectors_kb
> 
> Or maybe the transfer size is just a red herring, who knows. The error
> code seems wonky:
> 
>> [  185.384762] nvme0n1: I/O Cmd(0x2) @ LBA 105272408, 256 blocks, I/O 
>> Error (sct 0x3 / sc 0x71)

Changing max_sectors_kb to 64 does indeed seem to fix the issue at the 
first glance, default value is 128.
Also tried changing bcachefs flags during the format 
--btree_node_size=64k --bucket=64k
thought maybe that is related, but that didn't help.
It is really weird that this problem only occurs on bcachefs.

