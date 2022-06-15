Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D98DC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 19:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=Ofy52AdQOTzj/kbO1MIwaDwY/PucFMJxaj3tve4g9LI=; b=eO1p5VEdveilQE
	YJ1upbWV2rQQmyFkHRNE6lhorx9m96oPRtAVKCyA3iQqAHrAx0wvshwCbv6RmlOYHB6zfzLLvkGZv
	4u9FX3aaoTfAGukwEDDdgx/9UjI6bmzfR9R6ArFphSrSoUl2Gdm8eby7p97WUeJrZGZAl5ne9BvE9
	20XsCzz8WrIiq2yfXs/w9wuDnSb3brMA14Z2hsaIv1DeXv4LUVmlQE+HYdfQ4pBHe5JAKWVfqwBlW
	b1yrKLsmcd5me/qqnZbEbsu9WPPHnuU/N74p9ZLLOMeGO1cqAwnBVW0vrZPT1DbVYe2DZSUkUlIrj
	B7qqWCAMrMFUgIjoxUMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1YzE-00G7pt-Kr; Wed, 15 Jun 2022 19:47:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1YzC-00G7pG-ID
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 19:47:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E4B3160C32;
	Wed, 15 Jun 2022 19:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294CFC3411F;
	Wed, 15 Jun 2022 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655322449;
	bh=JSAZG6VVbEmLFwyoQO3PWN18odfJR3UCi5LMy1uYvfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CtVvrckVarhPo7oTjYmAW3NHC9L/7f4Le+mupFetN5dvRZfQzha8MoPmmEIBEtNsN
	 7Z4E7YTO+RyuE2Ikz85uyf4oImzzt+kc+3iS9gytL4vrmtcm3oBLCBOcWfA05us8rW
	 iMtSwouoWnuBNksnQWmRVkWP2VgdjSXUSAk5ZUUyVrIyFg6xzOd/JtoCoCOb09Nnfj
	 y1uHJcxAvwTl6EZ1ViLhdv88GqoH6DkDil/xYNYBoD+JgwdDMElXToSErUPEydaEAv
	 meRSoAXvlwMpqywG1NS5QueUyZjK6JrRYHi6lti7t0MD0/vJ1mAtKgZwN052IElMPZ
	 OX+PErleg9eww==
Date: Wed, 15 Jun 2022 14:47:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"mstowe@redhat.com" <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <20220615194727.GA1022614@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614040044.rypyclhqfv5w4xy7@shindev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_124730_719870_432A1920 
X-CRM114-Status: GOOD (  31.03  )
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

On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> On Jun 14, 2022 / 02:38, Chaitanya Kulkarni wrote:
> > Shinichiro,
> > 
> > On 6/13/22 19:23, Keith Busch wrote:
> > > On Tue, Jun 14, 2022 at 01:09:07AM +0000, Shinichiro Kawasaki wrote:
> > >> (CC+: linux-pci)
> > >> On Jun 11, 2022 / 16:34, Yi Zhang wrote:
> > >>> On Fri, Jun 10, 2022 at 10:49 PM Keith Busch <kbusch@kernel.org> wrote:
> > >>>>
> > >>>> And I am not even sure this is real. I don't know yet why
> > >>>> this is showing up only now, but this should fix it:
> > >>>
> > >>> Hi Keith
> > >>>
> > >>> Confirmed the WARNING issue was fixed with the change, here is
> > >>> the log:
> > >>
> > >> Thanks. I also confirmed that Keith's change to add
> > >> __ATTR_IGNORE_LOCKDEP to dev_attr_dev_rescan avoids the fix, on
> > >> v5.19-rc2.
> > >>
> > >> I took a closer look into this issue and found The deadlock
> > >> WARN can be recreated with following two commands:
> > >>
> > >> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/rescan
> > >> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/remove
> > >>
> > >> And it can be recreated with PCI devices other than NVME
> > >> controller, such as SCSI controller or VGA controller. Then
> > >> this is not a storage sub-system issue.
> > >>
> > >> I checked function call stacks of the two commands above. As
> > >> shown below, it looks like ABBA deadlock possibility is
> > >> detected and warned.
> > > 
> > > Yeah, I was mistaken on this report, so my proposal to suppress
> > > the warning is definitely not right. If I run both 'echo'
> > > commands in parallel, I see it deadlock frequently. I'm not
> > > familiar enough with this code to any good ideas on how to fix,
> > > but I agree this is a generic pci issue.
> > 
> > I think it is worth adding a testcase to blktests to make sure
> > these future releases will test this.
> 
> Yeah, this WARN is confusing for us then it would be valuable to
> test by blktests not to repeat it. One point I wonder is: which test
> group the test case will it fall in? The nvme group could be the
> group to add, probably.
> 
> Another point I wonder is other kernel test suite than blktests.
> Don't we have more appropriate test suite to check PCI device
> rescan/remove race ? Such a test sounds more like a PCI bus
> sub-system test than block/storage test.

I'm not aware of such a test, but it would be nice to have one.

Can you share your qemu config so I can reproduce this locally?

Thanks for finding and reporting this!

Bjorn

