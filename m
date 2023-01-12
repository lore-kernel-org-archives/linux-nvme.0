Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C530C63797
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=88IbgdoygxiZ8V51zLRl8kdavaSe5LS4nWnj4hLR7fo=; b=DG5UVETaDVp5HvOgI1KV8G+/Gk
	na0z50sn8+GxRFH2k0MP5JmQRtNFo61DXBtkPaeW+LZtLEuN4L5NjeLAZXsLUbgj+sKQ6K9O8vPgA
	tO/+sQTeNzSBB9WTI/vaLbdFF94x+MiZcDVDUctM24Uu2/UHFGh5PhQAJtUzrSkJA7Eqed/e0UBx+
	rh7VcF9n8qQnWv4hSECDd/hJjQlaEmVdEZQiWRWMhuG2Hv8ntspL1idvqABmHJ4WPh1Mw23WFtT9B
	RTm7hrnpNImXVYKUcfpQ0xGIStNl9URJwQQerkw34QmyPT5Y4pb416DCe1Bz/hNEn60qYsH9+QFDs
	9rod6slQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG0ec-00FuI8-Lt; Thu, 12 Jan 2023 16:42:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG0eZ-00FuEw-SE
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 16:42:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 33E166208E;
	Thu, 12 Jan 2023 16:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE85C433EF;
	Thu, 12 Jan 2023 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673541726;
	bh=F609UnYf0WMG5QfHIvhOUjsUndJBWWCnct0nm6EhNSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OPsjwdv4nwXuXqDGZ+Grn5wxcXDYn9RTtehvqMpkLU44l/jIIjLHEeLJglh3X32Vw
	 zk40TZLH73wxhMWeRaB7cwvF8cyRdMfmc1R5gDhcH0keIHTS5CNYEEuWIkc82okltr
	 hizJFSnMs8oyj3vSvvwBJ/giPdIuMoRLIrM+LipXifeGxnnYKEZK2U4fvjsq4TmSyG
	 /IvtdslpbWYDh4o6Rw0bCq3GcVflqAKEBxOkt96H8Ss/38ALdrOzhY+PNappYNAVFh
	 SNGAuGpcMsrpwHp3a/KayLg8FoowcfN1tbkgGVPBPDW3A12rbOdVid5+7T0IU8WqVW
	 Oy3o9fbvnfJjg==
Date: Thu, 12 Jan 2023 10:42:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Julian =?iso-8859-1?Q?Gro=DF?= <julian.g@posteo.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Message-ID: <20230112164204.GA1768006@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d46a35f-5830-9761-ca2c-eaa640e9cc86@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_084212_027618_9116D101 
X-CRM114-Status: GOOD (  28.11  )
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

On Thu, Jan 12, 2023 at 03:48:46PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> ...
> On 11.01.23 23:11, Julian Groß wrote:
> > Dear Maintainer,
> > 
> > when running Linux Kernel version 6.0.12, 6.0.10, 6.0-rc7, or 6.1.4, my
> > system seemingly randomly freezes due to the file system being set to
> > read-only due to an issue with my NVMe controller.
> > The issue does *not* appear on Linux Kernel version 5.19.11 or lower.
> > 
> > Through network logging I am able to catch the issue:
> > ```
> > Jan  8 14:50:16 x299-desktop kernel: [ 1461.259288] nvme nvme0:
> > controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> > Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Does
> > your device have a faulty power saving mode enabled?
> > Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Try
> > "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
> > Jan  8 14:50:16 x299-desktop kernel: [ 1461.331360] nvme 0000:01:00.0:
> > enabling device (0000 -> 0002)
> > ...
> > 
> > I have tried the suggestion in the log without luck.
> > 
> > Attached is a log that includes two system freezes, as well as a list of
> > PCI(e) devices created by Debian reportbug.
> > The first freeze happens at "Jan  8 04:26:28" and the second freeze
> > happens at "Jan  8 14:50:16".
> > 
> > Currently, I am using git bisect to narrow down the window of possible
> > commits, but since the issue appears seemingly random, it will take many
> > months to identify the offending commit this way.
> > 
> > The original Debian bug report is here:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1028309

For some reason the log [1] has very little of the kernel dmesg log.
It does seem like the freeze is partial (I see messages for hundreds
or thousands of seconds after the nvme reset), but requires a reboot
to recover.

The lspci information [2] shows the 00:1b.0 Root Port leading to the
01:00.0 NVMe device.

Is it possible to collect lspci output after the nvme freeze?  If so,
please save the output of:

  sudo lspci -vv -s00:1b.0
  sudo lspci -vv -s01:00.0

Make sure to run lspci as root so we can see the error logging
registers for these devices.

If you can collect more of the dmesg log after the freeze, e.g., via
the "dmesg" command, that might be helpful, too.

Bjorn

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1028309;filename=x299-desktop_crash.log.xz;msg=5
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=0;bug=1028309;msg=5

