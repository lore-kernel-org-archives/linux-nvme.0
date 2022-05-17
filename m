Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BA9C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Njo8FwDyM3Xya+mPHZw6tkWejVt96YVdge+Nj++wWgc=; b=zbdoDrtCRfHs/YtSv7ndSiw59C
	t2U8h5ryvyuPb9lj7WSjdTkQwuDEMDMbPZDxxMgm7E11oJ9Tx8w3xNX77GCKbAkD1IXW+1krQCCdz
	WGe3Ls33vOA1wADhR4qiE/QqQDRnjxZuxBNtXKOyUPOLlO97DLH59dplE3+o3c7GyI3jHa7PR9Anc
	9WQS7W7AdbfJnXTOF0U2Woij0FMG22yg1x2fiTzLXAElXnM39eS0y6jyT5o1xZLhNboI/uPL+K46l
	AIh+P12I/PvHpJwT+NhzAGGn8vPLD92IgUOuyaNU5SSN5UErW9dZnE2VAA613NPahpow7AvCdHiIw
	0ONCM9Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nquDD-00CyfB-LZ; Tue, 17 May 2022 10:13:55 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nquDA-00Cyd0-Ck
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 10:13:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A8770B8179C;
 Tue, 17 May 2022 10:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C545C385B8;
 Tue, 17 May 2022 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652782428;
 bh=pwPflkY6883sgamo1V6UO6qAd1DW0795Cg7hqZS4LZg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ykhO7ngSFIqUuUkptf+X/kohsqKTZ54ModnsOpD4KyVBRPnV3KZ5tnhFcybG2L3DY
 cYhO76EsdNFgojIIAqxdBJAMBXqfDMj53iZCT19Xv4sz0xbDgT9X3XwUzjtGW+QAvg
 lUn62ixjbTT4bKKKNvRnrEYbH5eETCMFNs3l07U0=
Date: Tue, 17 May 2022 12:13:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tanjore Suresh <tansuresh@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <YoN1VC0v4RNFC+0s@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com>
 <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
 <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
 <YmzqrqfVLQ9/4KXp@kroah.com>
 <CALVARr50MWexNpCf_PoZ4-pdnexiZiibz7Nd0PH+b-EVnBUN6w@mail.gmail.com>
 <CALVARr71u8VD0+zaWbm=6A-1_6gO=bYUm7OM4K5b6kOVz09XOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVARr71u8VD0+zaWbm=6A-1_6gO=bYUm7OM4K5b6kOVz09XOA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_031352_795971_4617A1CB 
X-CRM114-Status: GOOD (  44.12  )
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

On Wed, May 11, 2022 at 02:02:08PM -0700, Tanjore Suresh wrote:
> Greg
> 
> On Mon, May 2, 2022 at 12:13 PM Tanjore Suresh <tansuresh@google.com> wrote:
> >
> > On Sat, Apr 30, 2022 at 12:52 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > A: http://en.wikipedia.org/wiki/Top_post
> > > Q: Were do I find info about this thing called top-posting?
> > > A: Because it messes up the order in which people normally read text.
> > > Q: Why is top-posting such a bad thing?
> > > A: Top-posting.
> > > Q: What is the most annoying thing in e-mail?
> > >
> > > A: No.
> > > Q: Should I include quotations after my reply?
> > >
> > > http://daringfireball.net/2007/07/on_top
> > >
> > > On Fri, Apr 29, 2022 at 11:03:07AM -0700, Tanjore Suresh wrote:
> > > > Rafael,
> > > >
> > > > That is a good observation, however, many of the use cases in data
> > > > centers (deployment of devices in data centers) do not exploit device
> > > > power management. Therefore, I'm not sure that is the right way to
> > > > design this.
> > >
> > > Yes it is, enable device power management and use that interface please.
> > > Devices in data centers should of course be doing the same thing as
> > > everyone else, as it actually saves real money in power costs.  To not
> > > do so is very odd.
> > >
> >
> > I guess we are intermixing the  terminology of device power management
> > with shutdown.
> > My second, third reasoning in my previous e-mail, thought it brings
> > out that difference. Maybe not.
> > I will try one more time, my thought process on this one.
> >
> > This patch is only for shutdown. The shutdown can be done in a system
> > in various flavors,
> > (this may include a power being pulled from the system components when
> > all the devices
> > are quiescent and it can also be soft shutdown, where power is not
> > removed from the system, but system
> > could be attempting a reboot)
> >
> > The device power management allows the device to bring down any
> > devices that may be idle to various power states that
> > device may support in a selective manner & based on the transition
> > allowed by the device. Such a transition initiated by
> > the system can be achieved using the 'dpm' interface for runtime power
> > management (more for extending laptop battery life).
> > It can also be exploited for system sleep models (suspend and resume -
> > where state is preserved and restarted from where it left off
> > --> More applicable for laptops/desktops). That does not mean data
> > center devices cannot exploit, but they worry about slight latency
> > variation in any
> > I/O initiated to any device. Such power management could introduce
> > more latency when it transitions from one state to another.
> > Therefore, the use case is more apt for Laptops, in certain cases
> > desktops in my opinion or understanding.
> >
> > The shutdown entry point has been traditionally different and the
> > semantics is that the whole system is going down to a
> > quiescent state and power may be pulled or may not be, IMO, i am
> > seeing both are independent requirements, in my view.
> > Let me know if I am mistaken. I am not sure why we should break the
> > shutdown semantics as understood by driver developers and
> > overload it with dpm requirements?
> >
> 
> I have not seen additional comments, I request your help
> in moving this further, please. If i have missed something,
> Please let me know.

Please rebase and resubmit your series with the extra information you
have provided here in the changelog text so we can review it again.  The
patch series is long gone from my queue, sorry.

thanks,

greg k-h

