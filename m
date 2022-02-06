Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BF1C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Feb 2022 13:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rtRnoEiq5/bk15AHT7nHTjsDFpo3E92snyN2Dq+IwNU=; b=fnR1qgSNNsicbWbWz7CMZmE4bL
	rbknLIOtoB6aLNCpPYlAzxHfdsmcFllHgdJ4YqmLi/qcv/rOLBlhPHkOsbZNtgZSBrvfhBLDxyHfE
	BgVpknlLHE1izch5EmrFXD53hb5wm+aEwREdW3ANzsmt4AE4oYlkH0wM04DJ9/B4QK5Jhedy98kIT
	h0w4OIhY7aBmC5y2nRNhjjRMjJ6MgNTTVclvxHh7Ql7YvhGPaHr8YK62IARVvrJ8eRLMCayrmmBeA
	qX5BOZpJ0QO3yBDGeIYIoBzpqw2DDjfBEu4SUu+ESM5NuUMyOY43wjI/BzRkAZaurYihHFIB5ZpcX
	w6NesrUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGhNq-008Dw3-MZ; Sun, 06 Feb 2022 13:15:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGhNn-008DvB-6b
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 13:15:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2592960FD6;
 Sun,  6 Feb 2022 13:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3DFC340E9;
 Sun,  6 Feb 2022 13:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1644153310;
 bh=W6+/Pyuzf8IsRwGWak8iP+MA3bU83GsNoxh+JHi5IQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sARmYLe7VbfC8Zxn6xYB5xH/8EimnvQMDWjAx/kX9/3KD3fdtkw6VCqZWM3um/FSY
 ouEZDqVoiPsuqHMHFM9j7yzO+ZY3fOnNhMbv2b4UTReuXFDM+Szs0ZxWn6gScxyY+t
 jndPvRTc4NdMVSmY38jKZ6cKbKCVAV3c2yxngOEQ=
Date: Sun, 6 Feb 2022 14:15:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Martin Belanger <nitram_67@hotmail.com>,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, rafael@kernel.org, charles_rose@dell.com,
 stuart_hayes@dell.com, Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Message-ID: <Yf/J234IdB5/vIfb@kroah.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <YfzZmxPrtXwavoRZ@kroah.com>
 <93a3faf5-2e97-cd27-63ae-ea37293d5e54@grimberg.me>
 <17c95ce8-49f2-da6f-ff6c-71dfbb57cb66@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17c95ce8-49f2-da6f-ff6c-71dfbb57cb66@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_051511_343908_0B08339E 
X-CRM114-Status: GOOD (  31.58  )
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

On Sun, Feb 06, 2022 at 02:08:32PM +0100, Hannes Reinecke wrote:
> On 2/6/22 09:54, Sagi Grimberg wrote:
> > Hey Greg,
> > 
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index b5e452aa3c0e..4e3db5ec3924 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -2990,6 +2990,9 @@ static int nvme_init_identify(struct
> > > > nvme_ctrl *ctrl)
> > > >       ctrl->max_namespaces = le32_to_cpu(id->mnan);
> > > >       ctrl->ctratt = le32_to_cpu(id->ctratt);
> > > > +    ctrl->cntrltype = id->cntrltype;
> > > > +    ctrl->dctype = id->dctype;
> > > > +
> > > >       if (id->rtd3e) {
> > > >           /* us -> s */
> > > >           u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
> > > > @@ -3115,6 +3118,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
> > > >               return ret;
> > > >       }
> > > > +    ret = device_update_groups(ctrl->device);
> > > > +    if (ret)
> > > > +        return ret;
> > > 
> > > Why is this needed here?  How did the class or type just change?  That
> > > should never change over the lifespan of a device.  If it does, you need
> > > to tear down the old device and create a new one as something really
> > > wrong just happened.
> > 
> > The class and type do not change. The fundamental need here is to update
> > visible attributes of the device.
> > 
> > In nvme, we create the device node with its sysfs attributes and next
> > comes a process where we interrogate it for capabilities/personality.
> > In this example, the attributes cntrltype and dctype are learned from
> > the device identification, and the desire is that dctype will only be
> > visible for specific cntrltype (i.e. cntrltype is I/O controllers vs.
> > discovery controllers and dctype is the discovery controller type).
> > 
> > So perhaps a more narrowed interface to update attributes
> > visibility of the controller would be more appropriate instead?
> > 
> > Something like:
> > -- 
> >      ret = device_update_visibility(ctrl->device->groups);
> > -- 
> 
> I guess it can be even simpler; to my reading the prime objection is that we
> change attributes (and attribute visibility) without informing userspace
> that we did so, thus udev and the device configuration driven by uevents
> won't work as expected.
> 
> Which means that everything should be okay if we issue an KOBJ_CHANGE uevent
> after we modify the visibility of attributes, no?

Maybe.  It depends on what you want userspace to do here.  Most
KOBJ_CHANGE uevents are not watched by the normal userspace rules as
they are used to only watching for add/remove events.  change events are
much more rare and device-specific.

So I would strongly recommend you not use them unless you know your
userspace tools can handle them and will do the right thing.

thanks,

greg k-h

