Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE26BFEFB6E
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iG5lt5XxO/hh9xVt2TbhtRpf4Oxa4xmbAazMvGovJ3Q=; b=X569EK9ge6WSdNMGcieMpbSZ6j
	ogtcJnhBxGI6UnG2fq1SxAFln47MAQQUv1du05QsuZ5U0ruHV6TNTm1Sk4LhWggUbCSf6Kh4xFxD+
	LESBU/qfTLobTDbhSbGWdKA3oj4C3tijR/hNogHRMI7lf/C8mTL+1YhM0tubTRoUFt2JWArQAX7fz
	w83W5P2vBCwLhZa4Kl0fDWM/eCYREyXrJEQ/vi/1yucFkz4X3seR/DHvZvjED3bMw9CuPN/1y18fX
	torrmddn50syXsPu3LuhqU0tpcLmBSvObtd+DxgxbqvVixl1d0fyatoZ8VQDUJCMLehEgoUeQDmDL
	XWKyGXbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw2K5-00000008ttf-0QZu;
	Fri, 27 Feb 2026 18:12:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw2K1-00000008ttH-13Xs
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 18:12:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772215935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iG5lt5XxO/hh9xVt2TbhtRpf4Oxa4xmbAazMvGovJ3Q=;
	b=MALaEZhY29vAWYckYccUsguzBTWrlp7SbyVJHu++x19uWE8SI7NQEIHuybdQkLeUhg3H3H
	I5/26qUNr6ZPJSmoRz9FhpMRL7YRAIBUHeNDYSavL+hidn08eaO14ugrn8623GnrqlKP9W
	EiQLdW4gIjh3XreQ7CoYTc0Sr+9mI54=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-omPVtsOgMy-QsqCfcc6GHw-1; Fri,
 27 Feb 2026 13:12:09 -0500
X-MC-Unique: omPVtsOgMy-QsqCfcc6GHw-1
X-Mimecast-MFC-AGG-ID: omPVtsOgMy-QsqCfcc6GHw_1772215927
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFC28180025E;
	Fri, 27 Feb 2026 18:12:05 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FC081800286;
	Fri, 27 Feb 2026 18:12:04 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 61RIC3Le1740709
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 13:12:03 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 61RIC2001740708;
	Fri, 27 Feb 2026 13:12:02 -0500
Date: Fri, 27 Feb 2026 13:12:02 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, hch@lst.de, sagi@grimberg.me,
        axboe@fb.com, martin.petersen@oracle.com,
        james.bottomley@hansenpartnership.com, hare@suse.com,
        jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] libmultipath: Add PR support
Message-ID: <aaHecneNg9Q8EtiS@redhat.com>
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-10-john.g.garry@oracle.com>
 <aZ8Z7A4uOFfOTDeY@kbusch-mbp>
MIME-Version: 1.0
In-Reply-To: <aZ8Z7A4uOFfOTDeY@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: fSpzy0HR1uWU5JRjrcFWkFEFz6-pAnzybuoc7OdkXD0_1772215927
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_101217_396763_FBE670B4 
X-CRM114-Status: GOOD (  29.03  )
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

On Wed, Feb 25, 2026 at 08:49:00AM -0700, Keith Busch wrote:
> On Wed, Feb 25, 2026 at 03:32:21PM +0000, John Garry wrote:
> > +static int mpath_pr_register(struct block_device *bdev, u64 old_key,
> > +			u64 new_key, unsigned int flags)
> > +{
> > +	struct mpath_disk *mpath_disk = dev_get_drvdata(&bdev->bd_device);
> > +	struct mpath_head *mpath_head = mpath_disk->mpath_head;
> > +	struct mpath_device *mpath_device;
> > +	int srcu_idx, ret = -EWOULDBLOCK;
> > +
> > +	srcu_idx = srcu_read_lock(&mpath_head->srcu);
> > +	mpath_device = mpath_find_path(mpath_head);
> > +	if (mpath_device)
> > +		ret = mpath_head->mpdt->pr_ops->pr_register(mpath_device,
> > +				old_key, new_key, flags);
> > +	srcu_read_unlock(&mpath_head->srcu, srcu_idx);
> 
> Instead of having the lower layer define new mp template functions, why
> not use the existing pr_ops from mpath_device->disk->fops->pr_ops?

I don't think that's the right answer. The regular scsi persistent
reservation functions simply won't work on a multipath device. Even just
a simple reservation fails.

For example (with /dev/sda being multipath device 0):
# echo round-robin > /sys/class/scsi_mpath_device/0/iopolicy
# blkpr -c register -k 0x1 /dev/sda
# blkpr -c reserve -k 0x1 -t exclusive-access-reg-only /dev/sda
# dd if=/dev/sda of=/dev/null iflag=direct count=100
dd: error reading '/dev/sda': Invalid exchange
1+0 records in
1+0 records out
512 bytes copied, 0.00871312 s, 58.8 kB/s

Here are the kernel messages:
[ 3494.660401] sd 7:0:1:0: reservation conflict
[ 3494.661802] sd 7:0:1:0: [sda:1] tag#768 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[ 3494.664848] sd 7:0:1:0: [sda:1] tag#768 CDB: Read(10) 28 00 00 00 00 01 00 00 01 00
[ 3494.667092] reservation conflict error, dev sda:1, sector 1 op 0x0:(READ) flags 0x2800800 phys_seg 1 prio class 2

If you don't have a multipathed scsi device to try this on, you can run:

targetcli <<EOF
/backstores/ramdisk create mptest 1G
/loopback create naa.5001401111111111
/loopback create naa.5001402222222222
/loopback create naa.5001403333333333
/loopback create naa.5001404444444444
/loopback/naa.5001401111111111/luns create /backstores/ramdisk/mptest
/loopback/naa.5001402222222222/luns create /backstores/ramdisk/mptest
/loopback/naa.5001403333333333/luns create /backstores/ramdisk/mptest
/loopback/naa.5001404444444444/luns create /backstores/ramdisk/mptest
EOF

to create one.

Handling scsi Persistent Reservations on a multipath device is painful.
Here is a non-exhaustive list of the problems with trying to make a
multipath device act like a single scsi device for persistent
reservation purposes:

You need to register the key on all the I_T Nexuses. You can't just pick
a single path. Otherwise, when you set up the reservation, you will only
be able to do IO on one of the paths. That's what happened above.

If an path is down when you do the resevation, you might not be able to
register the key on that path. You certainly can't do it directly.
Using the All Target Ports bit (assuming the device supports it) could
let you extend a reservation from one target port to others, assuming
your path isn't down because of connection issue on the host side. But
in general, you have to be able to handle the case where you can't
register (or unregister) a key on your failed paths. If you don't do
that (un)registration when the path comes up, before it can get seleted
for handling IO, you will fail when accessing a path you should be
allowed allowed to access, or succeed in accessing a path that you are
should not be allowed to access.

The same is true when new paths are discovered. You need to register
them.

Except that a preempt can come and remove your registration at any time.
You can't register the new (or newly active) path if the key has been
preempted, and this preemption can happen at any moment, even after you
check if the other paths are still registered. If this isn't handled
correctly, paths can access storage that they should not be allowed to
access.

Changing the reservation type (for instance from
exclusive-access-reg-only to write-exclusive-reg-only) in scsi devices
is done by preempting the existing reservation. This will remove the
registered keys from every path except the one issuing the command. The
key needs to be reregistered on all the other paths again. If any IO
goes to these paths before they are reregistered, it will fail with a
reservation conflict, so IO needs to be suspended during this time.

The path that is holding the reservation might be down. In this case,
you aren't able to release the reservation from that path. The only way
I figured out to handle this in dm-mpath was for the device to preempt
it's own key, to move the reservation to a working path. This causes the
same issues as preempting key to change the reservation type, where you
need to reregister all the paths with IO suspended.

An actual preemption can come in from another machine while you are
doing this. In that case, you must not reregister the paths, and if you
already started, you must unregister them.

I can probably come up with more issues.

I think the best course of action for now is to just fail persistent
reservations as non-supported for scsi devices. IMHO Making them work
correctly (where mulitpath device IO won't fail when it should succeed,
and succeed when it should fail with a reservation conflict) dwarfs the
amount of work necessary to support ALUA.

dm-mpath previously did a pretty good job handling Persistent
Reservations. But recently it became much better, because it become very
clear that pretty good is not good enough for what people what to do
with Persistent Reservations and multipath devices.

-Ben


