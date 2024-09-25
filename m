Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA0C369AB
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=icQUFoDn2Nmw3Z1dc+Q2BqtJwOnJupRstUSU00h9vrc=; b=POm8ftUKr/OZEtrzm1B//qJJ2n
	ZZAMeb8HrhkMxu247dmBCCIaeU5F2lcdLBedOA0waJK3+fEMlJ6N95uV5i9zdTybsbDpNJPxpJOpo
	a4KN6PtebA/qWDWlFPWRFDVMuc8fyUOGcDYjWDg6l20cpprP1LT7Fo387ZWhKvw455WOMwfxxp8Qw
	SS6kryuTLpcjd12Z3c8NXr6H82xjw+/DPuu1wwxsVL/6kIdKtthaSa1as4kHdRSbec1RpeDopgT7P
	gBRAVEs5+Tj40V6aSmXzPcuJKOvN+aSGyTBWwR1XD8JjkpDy7/YIQCk0eLH0as+0a6LkfG4hEBWyb
	s376z1+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stNoX-00000004YXC-3XjA;
	Wed, 25 Sep 2024 08:56:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stNoU-00000004YVX-1DBh
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 08:56:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6B4C9A43DAA;
	Wed, 25 Sep 2024 08:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C5DC4CEC3;
	Wed, 25 Sep 2024 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727254557;
	bh=7+7S9zD6lpVoFKZ0pyXfyfREtCkMjdiiF5aeStNWakA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=0T+3eflfCzR4ZTQPkFV0k7Qkmj3GH/Dpo2lZSoG+A4idYqHbKp0ocd2bkujdTOVMa
	 obQAPJrDaNI85A7qllYS7f+wEqt5YSI2+UB2OhqzGrucuyTJ0u/a1QC2hr7D/Wlopw
	 YIQQhYRXFJuxgrM/UtP5V5lleR74Cw3JtwnAm4Zo=
Date: Wed, 25 Sep 2024 10:55:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
Message-ID: <2024092509-unaired-runaround-dc9d@gregkh>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <ZvHUn1Q2R8FumZ20@skv.local>
 <2024092440-embattled-magical-64bc@gregkh>
 <ZvMkkhyJrohaajuk@skv.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvMkkhyJrohaajuk@skv.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_015558_474687_DBE5F4DE 
X-CRM114-Status: GOOD (  36.67  )
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

On Tue, Sep 24, 2024 at 11:44:02PM +0300, Andrey Skvortsov wrote:
> Hi,
> 
> On 24-09-24 11:23, Greg Kroah-Hartman wrote:
> > On Mon, Sep 23, 2024 at 11:50:39PM +0300, Andrey Skvortsov wrote:
> > > Hi Stuart,
> > > 
> > > On 24-08-22 15:28, Stuart Hayes wrote:
> > > > Add code to allow asynchronous shutdown of devices, ensuring that each
> > > > device is shut down before its parents & suppliers.
> > > > 
> > > > Only devices with drivers that have async_shutdown_enable enabled will be
> > > > shut down asynchronously.
> > > > 
> > > > This can dramatically reduce system shutdown/reboot time on systems that
> > > > have multiple devices that take many seconds to shut down (like certain
> > > > NVMe drives). On one system tested, the shutdown time went from 11 minutes
> > > > without this patch to 55 seconds with the patch.
> > > > 
> > > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > > ---
> > > >  drivers/base/base.h           |  4 +++
> > > >  drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
> > > >  include/linux/device/driver.h |  2 ++
> > > >  3 files changed, 59 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > > > index 0b53593372d7..aa5a2bd3f2b8 100644
> > > > --- a/drivers/base/base.h
> > > > +++ b/drivers/base/base.h
> > > > @@ -10,6 +10,7 @@
> > > >   * shared outside of the drivers/base/ directory.
> > > 
> > > This change landed in linux-next and I have problem with shutdown on
> > > ARM Allwinner A64 device. Device usually hangs at shutdown.
> > > git bisect pointed to "driver core: shut down devices asynchronously"
> > > as a first bad commit.
> > > 
> > > I've tried to debug the problem and this is what I see:
> > > 
> > > 1) device 'mmc_host mmc0' processed in device_shutdown. For this device
> > > async_schedule_domain is called (cookie 264, for example).
> > > 
> > > 2) after that 'mmcblk mmc0:aaaa' is processed. For this device
> > > async_schedule_domain is called (cookie 296, for example).
> > > 
> > > 3) 'mmc_host mmc0' is parent of 'mmcblk mmc0:aaaa' and
> > > parent->p->shutdown_after is updated from 263 to 296.
> > > 
> > > 4) After sometime shutdown_one_device_async is called for 264
> > > (mmc_host mmc0), but dev->p->shutdown_after was updated to 296 and the
> > > code calls first async_synchronize_cookie_domain for 297.
> > > 
> > > 264 can't finish, because it waits for 297. shutdown process can't continue.
> > > 
> > > The problem is always with a MMC host controller.
> > 
> > If you take the patch here:
> > 	https://lore.kernel.org/r/20240919043143.1194950-1-stuart.w.hayes@gmail.com
> > does it solve the problem?
> 
> Unfortunately not. I've applied the patch to next-20240920 and tested
> latest next-20240924 with patch integrated already. In both cases
> shutdown hangs.

Ugh.  Ok, this is making me very nervous so I'm going to go and revert
this series from my tree and let's take it again after -rc1 is out and
people can work through the issues there.

thanks,

greg k-h

