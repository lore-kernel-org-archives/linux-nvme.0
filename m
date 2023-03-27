Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7E5C76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 22:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=BhG7ZUadKolOuqRUFlFU8Mi1nNYMds91PdR84DuN3dI=; b=iZnmhKXOAwsSbQ
	gE5aVJejCh0P4HB2SarH0db7qkdPjEG1wEAOx9uvmeNeOSRcD0vmhi0YB4X+5u0z7DgFQolv7XSLr
	NDfMUpxiDrb3JoGmprInCzp9sJodl561B+uaPGBnSqj0yYs40kSd/2ARxmg0u2QE+LaHX9tKqqZqC
	YQ7TYiCGOW7f2U1Yzqb6tXVyr2NGJQaQlGObw49BpmtKrAxr8bgyp5a0JiS+d5QZGupq55NaGoP/I
	Nahzh8ylVoEYz8A1fIT3XdhkTHSyE51rrOPQHQOoBv7isVsYALPK8NwBMwS8TqQGFkz8bbg8y6BDR
	kUJHcoT48+QpF7V87ViA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgvTU-00CaJ4-0C;
	Mon, 27 Mar 2023 22:38:00 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgvTP-00CaI9-33
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 22:37:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3B851B81900;
	Mon, 27 Mar 2023 22:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB77C433EF;
	Mon, 27 Mar 2023 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679956673;
	bh=1if43ofgC9kxf3iYz7Cwwx2xe1GO6f2A+/K/yppDoB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V5stfdgS5SB9T2aCNjNxc787XGu0UHW2Yjcxry6AiYOk2AjfNgKZRSmvJ2XNzdnQJ
	 9wUPZcA+vnIMA1uRFTXkA0YxA6n6VlMHHzyKxDSoQ7rc4eC2COVi+Av1XkiwmJEV8c
	 +9L/vwdZ/2mufCy0WbHu2VIdbROdZhMWd88cJMemF6WKRgv+6MciuyFkYZ3cMwGxNX
	 L+yBPC0/EX8nJFuFjfW5/FkhH+KnlrSAHK2hlmq8FJHIN7x+dZBqG80Vl4Pp2kgyJz
	 169aPEmhjItSjwH789Jibd4RdoGhYvZA68vAo8t83ow2rj20G/n/o4+7CI2fd+6e6+
	 G1Mqi9W1qvE9w==
Date: Mon, 27 Mar 2023 17:37:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	"Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
	Aleksander Trofimowicz <alex@n90.eu>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
Message-ID: <20230327223750.GA2860671@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975cc790-7dd9-4902-45c1-c69b4be9ba3a@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_153756_288956_9D31141B 
X-CRM114-Status: GOOD (  27.80  )
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

[+cc Aleksander, original report at
https://lore.kernel.org/r/975cc790-7dd9-4902-45c1-c69b4be9ba3a@linux.intel.com]

On Thu, Mar 09, 2023 at 07:34:18PM +0530, Rajat Khandelwal wrote:
> On 3/9/2023 7:31 PM, Rajat Khandelwal wrote:
> > Hi,
> > I am seeking some help regarding an issue I encounter sporadically
> > with Samsung Portable TBT SSD X5.
> > 
> > Right from the thunderbolt discovery to the PCIe enumeration, everything
> > is fine, until 'NVME_REG_CSTS' is tried to be read in 'nvme_reset_work'.
> > Precisely, 'readl(dev->bar + NVME_REG_CSTS)' fails.

> > I handle type-C, thunderbolt and USB4 on Chrome platforms, and currently
> > we are working on Intel Raptorlake systems.
> > This issue has been witnessed from ADL time-frame and now is seen
> > on RPL as well. I would really like to get to the bottom of the problem
> > and close the issue.
> > 
> > I have tried 5.10 and 6.1.15 kernels.

It's intermittent, but happens on both v5.10 and v6.1.15.  So we have
no reason to think this is a regression, right?

And you see it on ADL and RPL?  Do you see it on any other platforms?
Have you tried any others?

> > During the issue:
> > Contents of BAR-0: <garbage> 00000004 (dumped using setpci)
> > Contents of kernel PCI resource-0: 0x83000000 (matches with the mem allocation)
> > Issue: nvme nvme1: Removing after probe failure status: -19

How exactly did you use setpci and what was "<garbage>"?  Can you
include the entire transcript, e.g.,

  $ setpci -G -s 01:00.0 BASE_ADDRESS_0.L
  Trying method linux-sysfs......using /sys/bus/pci...OK
  Decided to use linux-sysfs
  ec000000

What does "lspci -vvxxx" show in this case?

I guess "kernel PCI resource-0: 0x83000000" means the following from
your dmesg log, right?

  pci 0000:03:00.0: BAR 0: assigned [mem 0x83000000-0x83003fff 64bit]

I think the first access to the device should be here (same as what
Keith said):

  nvme_probe
    nvme_pci_enable
      pci_enable_device_mem
      pci_set_master
      readl(dev->bar + NVME_REG_CSTS)

But you mention nvme_reset_work() above.  How did you figure that out?

Maybe there's a race where we reset the device (which clears the BARs)
and do MMIO accesses before the BARs are restored.

Or maybe some PCI error happens and nvme_reset_work() is invoked as
part of recovery?  I see some *corrected* AER errors in your log, but
none look related to your NVMe device at 03:00.0.

I assume reading the BAR with setpci happens in "slow user time" so we
have to assume that's the steady state of the BAR after nvme_probe()
fails with -19.

> > During a working case:
> > Contents of BAR-0: 83000004 (dumped using setpci)
> > 
> > Seems like, the kernel PCIe resource contents don't change (which results in a
> > successful ioremap), but somehow the BAR-0 dumps garbage.
> > 
> > The logs for the scenario: (apologies if this is not the way to attach a log in
> > the mailing list as I have never done that :)).

> > ... (see original report at
> > https://lore.kernel.org/r/975cc790-7dd9-4902-45c1-c69b4be9ba3a@linux.intel.com)

Bjorn

