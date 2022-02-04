Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DE3C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zKEj55arNHtpLs16mohAZWaHkJzeY/Fv1Bx3DbPZSAU=; b=Na1NcIY56h5Rc7PSjuMA2dKxn6
	4mYkz0Wb0UIKyYg+dhQvV9Bd2ERRenhjUbKqwdfZzF8+u0/iAaPgjnMw3sxBtiTAnlL5p2KWrX4o+
	mufNgwPmNCIGbIDFttm5lHfpXAkhPUpQv998G8NGB3H3mObsWV8kmUD8DiqPFde3cZbMFFEaG1ioI
	yFT7YZTmTj/TedD5Oo5FYAy7EsvuuY1QImGQz5yFTtu6zXyap7PwC0wIMdQefzk4XVHrGuErNyLgD
	vIiFQlcAfCUDQPppiiF/+9V+H0f9SCEwfQ1zGEN6RXn8FK1SS7EQHLgaomeBk+yVLjjjmXzNQIlCx
	+YQONXmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFzEf-004Vr5-46; Fri, 04 Feb 2022 14:06:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFzEb-004VpV-FW
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 14:06:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 50BEA60ADC;
 Fri,  4 Feb 2022 14:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C453C004E1;
 Fri,  4 Feb 2022 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1643983603;
 bh=8l1Yss4IJiGe8wTPkWwtsIB9Xbq4Z5TINK8Xt8hy2OY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=etZB+ilvr8sBBn+mWnxYGosw0QGxzDOtaVfSJ99VDnPC/Do4dOyVfZ7kTFDP9YFYx
 ECgM465lCzUI9rZV3qETSq99JElk6YDC8vz8FWp6E0G3sPAQEPmhdYYynmumVDqZuO
 xNgC1Pi6kEgkcAH5r0CfAyAoeIv3bzNc5NxK/ZMI=
Date: Fri, 4 Feb 2022 15:05:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "hare@suse.de" <hare@suse.de>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "Rose, Charles" <Charles.Rose@dell.com>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Message-ID: <Yf0yq3wXzvkPf5Wa@kroah.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <YfzZmxPrtXwavoRZ@kroah.com>
 <SJ0PR19MB4544F6472AE13C8634E9AB9BF2299@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB4544F6472AE13C8634E9AB9BF2299@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220204_060645_646621_88AB8BCB 
X-CRM114-Status: GOOD (  39.45  )
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

On Fri, Feb 04, 2022 at 01:51:27PM +0000, Belanger, Martin wrote:
> > On Thu, Feb 03, 2022 at 04:17:48PM -0500, Martin Belanger wrote:
> > > From: Martin Belanger <martin.belanger@dell.com>
> > >
> > > TP8010 introduces the Discovery Controller Type attribute (dctype).
> > > The dctype is returned in the response to the Identify command. This
> > > patch exposes the dctype through the sysfs. Since the dctype depends
> > > on the Controller Type (cntrltype), another attribute of the Identify
> > > response, the patch also exposes the cntrltype as well. The dctype
> > > will only be displayed for discovery controllers.
> > >
> > > Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> > > ---
> > >  drivers/nvme/host/core.c | 45
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  drivers/nvme/host/nvme.h |  3 +++
> > >  include/linux/nvme.h     | 10 ++++++++-
> > >  3 files changed, 57 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index
> > > b5e452aa3c0e..4e3db5ec3924 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -2990,6 +2990,9 @@ static int nvme_init_identify(struct nvme_ctrl
> > *ctrl)
> > >  	ctrl->max_namespaces = le32_to_cpu(id->mnan);
> > >  	ctrl->ctratt = le32_to_cpu(id->ctratt);
> > >
> > > +	ctrl->cntrltype = id->cntrltype;
> > > +	ctrl->dctype = id->dctype;
> > > +
> > >  	if (id->rtd3e) {
> > >  		/* us -> s */
> > >  		u32 transition_time = le32_to_cpu(id->rtd3e) /
> > USEC_PER_SEC; @@
> > > -3115,6 +3118,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
> > >  			return ret;
> > >  	}
> > >
> > > +	ret = device_update_groups(ctrl->device);
> > > +	if (ret)
> > > +		return ret;
> > 
> > Why is this needed here?  How did the class or type just change?  That should
> > never change over the lifespan of a device.  If it does, you need to tear down
> > the old device and create a new one as something really wrong just
> > happened.
> 
> Hi Greg,
> I need to expose 2 nvme attributes through the sysfs. There is the controller type (cntrltype), which can take the values "io", "discovery", "admin", and "reserved". And there is the Discovery Controller Type (dctype), which takes the values "none", "ddc", "cdc", and "reserved". Note that the dctype is only meaningful for Discovery Controllers (i.e. cntrltype=discovery).

/me handes you some '\n' characters...

That's fine, this should not have anything to do with the groups
associated with a device as this type is known at creation, right?

> In my first iteration of this patch, I plainly exposed both attributes for all types of controllers. However, Sagi asked me to only expose the dctype if we're dealing with a Discovery Controller. Unfortunately, both cntrltype and dctype are not known at object creation. This means that when the is_visible method (i.e. nvme_dev_attrs_are_visible) is called, it is still not known whether dctype should be exposed. The value s for cntrltype and dctype are only known after a connection has been established with the controller and we have completed the Identify command.

How can this not be known at creation?  Why not figure it out first
before you create the device?  Why not wait?

> Hannes suggested that we combine both attributes into a single one that would take the values: "io", "discovery-none", "discovery-ddc", "discovery-cdc", "discovery-reserved", and "admin". But Sagi did not like this proposal and instead proposed the changes that you see here. Basically, we want to be able to re-execute the is_visible() method after we have identified the controller so that we can determine whether the dctype should be exposed.

Nope, that's not how the driver model works and you break all userspace
tools by doing this as it only scans the list of attributes when the
device is created and announced to userspace.

By changing the files and types and such afterward no one ever notices
and so userspace is "blind" to the change unless you want it to
constantly walk all of sysfs all the time to find this out (hint, you
don't want that...)

So there's a reason you are being forced to add a driver-core change
like this, because it's not something you should do :)

> So now I'm in a bit of a pickle. Sagi suggested this current patch set, but from what you're saying this is not a good approach. If you could suggest a solution that would satisfy all parties, I would greatly appreciate it.

Wait to create the device when you know the device type.

thanks,

greg k-h

