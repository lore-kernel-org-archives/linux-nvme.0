Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D43CF9C71
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A2C8tC2gATvVAroAAzpsvXEwsWxPEM98KRkQGTwqc7E=; b=hNlHXt+Whtrb+x8NQqB7iiDhY7
	uBHNFmKrUPvW3Em4rjEbFJfVBHmS2KHbacOIqf0V2oBbfCSQ0mEQOIpim4Nrrahym791aXw45DjQK
	K3bFBgRarraUOFJ6EwlSWBnmsTLmMxr8BcUNXbAdahBSh9yH9G+mgeIcfq+K6WjObWXepe+3qjOX0
	gR9j8U3rcfBzOkfEdt4q460HyC5m9peT1MwcEGcDYfpqkxESXVWyrB7S/+RId020pZUvFBEdf1u9V
	VO0/dBCwkLwYsqf/Sl37d7gu5vpPc/Qr8z3qP7aks6G4knmXVwzKtbaqGT7SC34e1LsiT0+hbzg3d
	2Cwnd3OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st1t4-00000001oCE-2xTJ;
	Tue, 24 Sep 2024 09:31:14 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st1m5-00000001mhX-2H0b
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 09:24:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4F152A40BDF;
	Tue, 24 Sep 2024 09:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B77C4CEC4;
	Tue, 24 Sep 2024 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727169840;
	bh=zHnhnNw50/GZkwB5R09yISn41wHHH7beW/kuu6jT2gg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=d9WS/icWwOQs7cnEcZQt1AM2tN3uzB/0WuXjHFdjBVh+2MnPshixayinVzkxgtNVb
	 5fWjCS2o4u7z46w9GJevwlJdzlvJVPU1S2WHrv83hqN6yWerL5uF4MEeHChlRimpkm
	 CfePTGPnjY9mrBg2CTKUJ1lyFYrUAOOGGIoJdmlU=
Date: Tue, 24 Sep 2024 11:23:54 +0200
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
Message-ID: <2024092440-embattled-magical-64bc@gregkh>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <ZvHUn1Q2R8FumZ20@skv.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvHUn1Q2R8FumZ20@skv.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_022401_728926_921A0C67 
X-CRM114-Status: GOOD (  29.22  )
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

On Mon, Sep 23, 2024 at 11:50:39PM +0300, Andrey Skvortsov wrote:
> Hi Stuart,
> 
> On 24-08-22 15:28, Stuart Hayes wrote:
> > Add code to allow asynchronous shutdown of devices, ensuring that each
> > device is shut down before its parents & suppliers.
> > 
> > Only devices with drivers that have async_shutdown_enable enabled will be
> > shut down asynchronously.
> > 
> > This can dramatically reduce system shutdown/reboot time on systems that
> > have multiple devices that take many seconds to shut down (like certain
> > NVMe drives). On one system tested, the shutdown time went from 11 minutes
> > without this patch to 55 seconds with the patch.
> > 
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > ---
> >  drivers/base/base.h           |  4 +++
> >  drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
> >  include/linux/device/driver.h |  2 ++
> >  3 files changed, 59 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 0b53593372d7..aa5a2bd3f2b8 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -10,6 +10,7 @@
> >   * shared outside of the drivers/base/ directory.
> 
> This change landed in linux-next and I have problem with shutdown on
> ARM Allwinner A64 device. Device usually hangs at shutdown.
> git bisect pointed to "driver core: shut down devices asynchronously"
> as a first bad commit.
> 
> I've tried to debug the problem and this is what I see:
> 
> 1) device 'mmc_host mmc0' processed in device_shutdown. For this device
> async_schedule_domain is called (cookie 264, for example).
> 
> 2) after that 'mmcblk mmc0:aaaa' is processed. For this device
> async_schedule_domain is called (cookie 296, for example).
> 
> 3) 'mmc_host mmc0' is parent of 'mmcblk mmc0:aaaa' and
> parent->p->shutdown_after is updated from 263 to 296.
> 
> 4) After sometime shutdown_one_device_async is called for 264
> (mmc_host mmc0), but dev->p->shutdown_after was updated to 296 and the
> code calls first async_synchronize_cookie_domain for 297.
> 
> 264 can't finish, because it waits for 297. shutdown process can't continue.
> 
> The problem is always with a MMC host controller.

If you take the patch here:
	https://lore.kernel.org/r/20240919043143.1194950-1-stuart.w.hayes@gmail.com
does it solve the problem?

thanks,

greg k-h

