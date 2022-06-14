Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD3BCCA47B
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 02:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TPbGUC3VfVNBFHI3r6bvJ5JItLokENWXnLxLJiVWwHc=; b=lKc916YsOqD8LFtCk3sK+ng10Y
	ac1nDvCHRWnRA6w/5fGSsYDfN9AMevJr9mJQ8RhOLUWns0nJ+B4yYJ/54XtL0L1Fma1JZroyO7/VU
	iyfM6QVaHnYoAqk8kRoWA4De5WMXz9mKMLvFfhNGFKRKQZuI+mS7pk28gzwe7dqFTP3jE9DA5NWot
	xiobiz25BTyQwu+XxDRvYqYHMirm+ekiu5g+AjaHKbARANWCGtBIFYGZcjwnwgzCeeqqCU7Ss6YWh
	X/qgXKSVmKVgrsYGjkV6NntYvQbu0SJr/q3FJ27TtUBijak++YNTsvWpdog4LXITSdxt3nurZ+F/3
	2/TuT1VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0wDX-006kGD-V5; Tue, 14 Jun 2022 02:23:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0wDW-006kFm-2o
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 02:23:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6F93560AEC;
	Tue, 14 Jun 2022 02:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43116C34114;
	Tue, 14 Jun 2022 02:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655173420;
	bh=2JdpeLCcSB+EkvAsWhfjyJ3Yq+6ICihCOSoee4FwUcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVjARZi0H5LFS8bhfKScyQVBoSEzNU+8aBH6w34TAaQnKjP+eyQtJA8doYV0+0VaH
	 hu/J6hoKUDKk7djV8XqOM63HxSrVP+I83gjyRqIZPc0Vdpjx4O61iDPlJ/M3ORtQo5
	 wFH0R9tzirOAOeoy6ZkmGZKUkoyRTYEH85Hud28eO/L7sXKp3/RA1hO/TNntlAzNZH
	 WzWgdBDUibYMB1X8NsQA0p4us7MSncByO2y3RHpRf2l1JmsUsuTbDqvr8ajCWiorDI
	 B8I2m8FusgQOy3xGUxrUpwcq/1js8hok7vstbhGMItiYioOdI43j6Xo/xNBuc68BCZ
	 Ll4BDqx6YYKQg==
Date: Mon, 13 Jun 2022 20:23:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"mstowe@redhat.com" <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <YqfxKanxbZNN7Kfw@kbusch-mbp.dhcp.thefacebook.com>
References: <20220609235329.4jbz4wr3eg2nmzqa@shindev>
 <717734c9-c633-fb48-499e-7e3e15113020@nvidia.com>
 <19d09611-42cc-5a81-d676-c5375865c14c@nvidia.com>
 <20220610122517.6pt5y63hcosk5mes@shindev>
 <YqNZiMw+rH5gyZDI@kbusch-mbp.dhcp.thefacebook.com>
 <CAHj4cs9G0WDrnSS6iVZJfgfOcRR0ysJhw+9yqcbqE=_8mkF0zw@mail.gmail.com>
 <20220614010907.bvbrgbz7nnvpnw5w@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614010907.bvbrgbz7nnvpnw5w@shindev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_192342_200311_2EF5F1A5 
X-CRM114-Status: GOOD (  22.47  )
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

On Tue, Jun 14, 2022 at 01:09:07AM +0000, Shinichiro Kawasaki wrote:
> (CC+: linux-pci)
> On Jun 11, 2022 / 16:34, Yi Zhang wrote:
> > On Fri, Jun 10, 2022 at 10:49 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > And I am not even sure this is real. I don't know yet why this is showing up
> > > only now, but this should fix it:
> > 
> > Hi Keith
> > 
> > Confirmed the WARNING issue was fixed with the change, here is the log:
> 
> Thanks. I also confirmed that Keith's change to add __ATTR_IGNORE_LOCKDEP to
> dev_attr_dev_rescan avoids the fix, on v5.19-rc2.
> 
> I took a closer look into this issue and found The deadlock WARN can be
> recreated with following two commands:
> 
> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/rescan
> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/remove
> 
> And it can be recreated with PCI devices other than NVME controller, such as
> SCSI controller or VGA controller. Then this is not a storage sub-system issue.
> 
> I checked function call stacks of the two commands above. As shown below, it
> looks like ABBA deadlock possibility is detected and warned.

Yeah, I was mistaken on this report, so my proposal to suppress the warning is
definitely not right. If I run both 'echo' commands in parallel, I see it
deadlock frequently. I'm not familiar enough with this code to any good ideas
on how to fix, but I agree this is a generic pci issue.

