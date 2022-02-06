Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31913C433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Feb 2022 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A+z3oN4E3UJJcIxPlvMAb2RfwUM6I0IhcMqDqBWQecU=; b=KVlLSOv87v94spDzv/ePvPlro8
	4Fd1RPht7BorZXltObI/eRDYbbqgyTxvsF2c52PF1dKfvomqoWysmmDKIun6QjejWz7lInRdGhGrE
	RDcpV6R370T56cqj1LefwCm0ORMbeeZRW8HHHOBozpdO7tq2uYWW1wsu5HbeYQ52x2CAkiOR2Y29W
	ut9JTjKeWWVoavnaY8giHs9nEj+/feuaavoGYIsRQxs3akyX8c24mO+LwA3P4R9/7AMaPYfmpr3GR
	6pUXNXQYNI/1IYYedzj9fUPkSMbmprGNYRf7EcGLdfybnH/UDN7alkGLYLiHbOr+wZQ6CCzESmtQw
	vmiVphTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGgE7-00893F-U7; Sun, 06 Feb 2022 12:01:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGgE4-00892r-AS
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 12:01:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 41D1660F3D;
 Sun,  6 Feb 2022 12:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53196C340E9;
 Sun,  6 Feb 2022 12:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1644148862;
 bh=rth3cmOyaWcbPKyB6/2bsHwrPhc7jBHEkXiq3SACh4Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1/2k6hhWulUz8f33TAybzgLxCRu9xDYbjQhM/QFsQtiP5MhzJegrMJyboVRyNbl05
 5/d3IYLopZ+kBIX8vvZaY3wBgEAA25Q346l0ZNx5qrne9aEwkxxHs6W5ygyGnpyJc0
 eB9rUOR3DGbiosSLZ+hUqe5sZxqYaecKLAafMxqg=
Date: Sun, 6 Feb 2022 13:00:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 rafael@kernel.org, charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Message-ID: <Yf+4enHefqPXQx5t@kroah.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <YfzZmxPrtXwavoRZ@kroah.com>
 <93a3faf5-2e97-cd27-63ae-ea37293d5e54@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a3faf5-2e97-cd27-63ae-ea37293d5e54@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_040104_428810_488891AD 
X-CRM114-Status: GOOD (  26.40  )
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

On Sun, Feb 06, 2022 at 10:54:54AM +0200, Sagi Grimberg wrote:
> Hey Greg,
> 
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index b5e452aa3c0e..4e3db5ec3924 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -2990,6 +2990,9 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
> > >   	ctrl->max_namespaces = le32_to_cpu(id->mnan);
> > >   	ctrl->ctratt = le32_to_cpu(id->ctratt);
> > > +	ctrl->cntrltype = id->cntrltype;
> > > +	ctrl->dctype = id->dctype;
> > > +
> > >   	if (id->rtd3e) {
> > >   		/* us -> s */
> > >   		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
> > > @@ -3115,6 +3118,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
> > >   			return ret;
> > >   	}
> > > +	ret = device_update_groups(ctrl->device);
> > > +	if (ret)
> > > +		return ret;
> > 
> > Why is this needed here?  How did the class or type just change?  That
> > should never change over the lifespan of a device.  If it does, you need
> > to tear down the old device and create a new one as something really
> > wrong just happened.
> 
> The class and type do not change. The fundamental need here is to update
> visible attributes of the device.

Then change the attributes and issue a uevent of KOBJECT_CHANGE like
other objects do today.  But be aware that userspace might have problems
with this.  Please test your tools to verify this works or not.

> In nvme, we create the device node with its sysfs attributes and next
> comes a process where we interrogate it for capabilities/personality.

That feels wrong, just delay, there's no rush.

> In this example, the attributes cntrltype and dctype are learned from
> the device identification, and the desire is that dctype will only be
> visible for specific cntrltype (i.e. cntrltype is I/O controllers vs.
> discovery controllers and dctype is the discovery controller type).
> 
> So perhaps a more narrowed interface to update attributes
> visibility of the controller would be more appropriate instead?
> 
> Something like:
> --
> 	ret = device_update_visibility(ctrl->device->groups);
> --

Again, suffers from the same issue where userspace is not notified.

Again, just delay and create the real object when you know what you
have.

thanks,

greg k-h

