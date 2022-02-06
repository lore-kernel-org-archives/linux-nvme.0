Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EDCC433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Feb 2022 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=phAEtt3rvtrDSiX5zfRC9b5TUDPSnFql1yj7iif1O18=; b=VqzAUGJGUWz4goJ95bW5naXi6P
	Muqi21zpPKE/uvCdOoy5Tyad+WArq7kD8NL7sa6+ERE2OBeydmDRhsdv3sFFXIDa+8zCK5H3EAUe+
	Hms8/Jxfwj8HsgwCXqdcvCXj+vAkI6xBuZczUXpIHe5qL0QTuOxfAeTPYsQE+mGnS334loEnhtXk2
	OyMkdVvEczOCniFErZiRD9gNjTrzn2nDjT3HV4oCrVtHjREIy3GN9m7eOuJAv5HvaZ4HzRFWOVT+r
	aIdgLSZ/QgTrksyG8qQ7wDF3cLPHnqMh6DxX5NEsan5JvRjoxzxqM28Nuh7937i36q0qV1kwR8nsU
	9YWKUCqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGgFQ-00898q-MD; Sun, 06 Feb 2022 12:02:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGgFO-00898M-7V
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 12:02:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C049D60F79;
 Sun,  6 Feb 2022 12:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAD9C340E9;
 Sun,  6 Feb 2022 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1644148945;
 bh=ebd8zUR/cSqbmFOsR0WViGFu/uUmc84I/3p/dYOE4ic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VAmc2hwJxFfJ+HGbJbf4n4phLFnVv7HQhLtqvshT3L6W6jva4ABBMGxwhjTcMt2Yu
 FbeHowsVNpHVkLL9HBiXFZ4U2oIBf1+fBqzXsvZF56H4fQH+/LhspcxzggKQJPliZj
 LHClxWLa3VjL+ob82M+ImKo4fqtQWaqWi8qGnEfs=
Date: Sun, 6 Feb 2022 13:02:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "hare@suse.de" <hare@suse.de>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "rafael@kernel.org" <rafael@kernel.org>,
 "Rose, Charles" <Charles.Rose@dell.com>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Message-ID: <Yf+4zhofzutXLVih@kroah.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <YfzZmxPrtXwavoRZ@kroah.com>
 <SJ0PR19MB4544F6472AE13C8634E9AB9BF2299@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <Yf0yq3wXzvkPf5Wa@kroah.com>
 <b10f199e-83eb-7088-f9ea-44057b59b6cc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b10f199e-83eb-7088-f9ea-44057b59b6cc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_040226_372570_49E885CD 
X-CRM114-Status: GOOD (  34.38  )
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

On Sun, Feb 06, 2022 at 11:09:40AM +0200, Sagi Grimberg wrote:
> 
> > > Hannes suggested that we combine both attributes into a single one that would take the values: "io", "discovery-none", "discovery-ddc", "discovery-cdc", "discovery-reserved", and "admin". But Sagi did not like this proposal and instead proposed the changes that you see here. Basically, we want to be able to re-execute the is_visible() method after we have identified the controller so that we can determine whether the dctype should be exposed.
> 
> Just to note that the same fundamental issue exists in both approaches,
> having the "combined" string change after the controller is identified
> is equivalent to having the separated attribute appear after the device
> is initialized.
> 
> > Nope, that's not how the driver model works and you break all userspace
> > tools by doing this as it only scans the list of attributes when the
> > device is created and announced to userspace.
> > 
> > By changing the files and types and such afterward no one ever notices
> > and so userspace is "blind" to the change unless you want it to
> > constantly walk all of sysfs all the time to find this out (hint, you
> > don't want that...)
> 
> The idea was to add a separate udev announcement that would tell
> userspace that these attributes are stable (it actually serves
> a different purpose, but it does come after that point).

like KOBJECT_CHANGE is there for?

> > So there's a reason you are being forced to add a driver-core change
> > like this, because it's not something you should do :)
> 
> I do agree that its a bit backwards to do this update. But the device
> even today is not fully usable when it is created, so we know no
> userspace program relies on the creation announcement.
> 
> > > So now I'm in a bit of a pickle. Sagi suggested this current patch set, but from what you're saying this is not a good approach. If you could suggest a solution that would satisfy all parties, I would greatly appreciate it.
> > 
> > Wait to create the device when you know the device type.
> 
> The initial proposal was to defer the device creation to after the
> device is fully initialized. That though is a heavier lift because the
> device initialization is something that happens on every reset or
> reconnection after connectivity loss,

That's fine, what's wrong with tearing it all down and bringing it back
up then?  That's what the hardware just did, don't fake things out by
not conveying the same stuff to userspace.

> so if we move the device creation there we have to now check if this
> is the first time we are doing this or not, and also error recovery
> becomes more opinionated...

I still think you should not create anything until you know what it is.

thanks,

greg k-h

