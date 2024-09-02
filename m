Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC782CD13CF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ML2r9oHuvQzb/j/88TCxTgNI5iHNK8wVCf86vDlj0k0=; b=Cu/il5Ahvie2Ox2VPX/+8G2YeS
	OUFOBfRMm2kK6zpQrai05PIKL+cHRC13J1gO5yJl5zhzu4i0tY8/DBgKU609nK5ylYJ7r66TR+Hkv
	uL6l7l6HhQgMatgx/BeoeLApf6r4UU4YS6DEsjHxvvX5iabyTPoANJclm6Qz/ot60EpNAOIu6hnew
	33xQfHCaYCQkL34NEVlHscEAQsIfKYU2Vh7vuOp5BD7DNsD1G4qehgz1SLgrhDbSIq68FLR/+/Fum
	HaRjNOjVZVg3XwwLoWuKewDzP4aMeopzrjNEau0zT5BMhayPO1LiuNHrTgGeosVk06GE9gISz+dE2
	yYJuKMvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl6na-0000000ERQw-1uyh;
	Mon, 02 Sep 2024 13:08:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl6nY-0000000ERPt-0Jwj
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 13:08:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBF781FBAD;
	Mon,  2 Sep 2024 13:08:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98C6313A7C;
	Mon,  2 Sep 2024 13:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qsKzI9241WZwHAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 02 Sep 2024 13:08:45 +0000
Message-ID: <c0e8dbad380d687dc8ab12ed69133de043dd4ed6.camel@suse.com>
Subject: Re: [PATCH 3/3] nvme: freeze both the ns and multipath queues whe
 updating queue limits
From: Martin Wilck <mwilck@suse.com>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Date: Mon, 02 Sep 2024 15:08:45 +0200
In-Reply-To: <084602a4-2625-4d9b-b67f-d1bcd175d59f@suse.de>
References: <20240829063142.2048109-1-hch@lst.de>
	 <20240829063142.2048109-4-hch@lst.de>
	 <69bb27d4-1ea6-4554-9a1d-e19e4e9079c1@suse.de>
	 <084602a4-2625-4d9b-b67f-d1bcd175d59f@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CBF781FBAD
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_060848_380002_B775C63C 
X-CRM114-Status: GOOD (  30.70  )
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

On Mon, 2024-09-02 at 12:36 +0200, Hannes Reinecke wrote:
> On 8/29/24 16:34, Hannes Reinecke wrote:
> > On 8/29/24 08:31, Christoph Hellwig wrote:
> > > We really should not have any I/O outstanding while updating the
> > > queue
> > > limits, as that could introduce inconsistencies between the
> > > multipath
> > > and underlying nodes.=C2=A0 So always freeze the multipath node first
> > > and then
> > > the underlying one, matching the order in nvme_passthru_start.
> > >=20
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > > =C2=A0 drivers/nvme/host/core.c | 41 ++++++++++++++++++++++++++++----=
-
> > > -------
> > > =C2=A0 1 file changed, 29 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 81d2a09dd00f30..0f01a0bf976fd3 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> [=C2=A0 .. ]
> > > @@ -2254,7 +2272,9 @@ static int nvme_update_ns_info_block(struct
> > > nvme_ns *ns,
> > > =C2=A0 done:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_disk_ro(ns->disk, nvme_ns_is_reado=
nly(ns, info));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(NVME_NS_READY, &ns->flags);
> > > -=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze_queue(ns->disk->queue);
> > > +=C2=A0=C2=A0=C2=A0 if (nvme_ns_head_multipath(ns->head))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nvme_update_ns_in=
fo_mpath(ns, info, unsupported);
> > > +=C2=A0=C2=A0=C2=A0 nvme_ns_unfreeze(ns);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (blk_queue_is_zoned(ns->queue)) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D blk_re=
validate_disk_zones(ns->disk);
> >=20
> > While we're shuffling things around; doesn't the mean that we
> > unfreeze=20
> > the queue (and allow I/O) before we've validated all zones?
> > Wouldn't it be better if we validate zoned before unfreezing
> > queues?
> >=20
> > Otherwise it looks good; I'll give it a spin on my map/unmap
> > testcases.
> >=20
> Hmm. Turns out we're not quite there yet.
> We call 'set_capacity_and_notify()' unconditionally a few lines up,=20
> before setting the namespace to 'READY'. And then we're doing another
> call to 'set_capacity_and_notify()' (from
> nvme_update_ns_info_mpath()).
> In my map/unmap tests I've seen a stall with udev, where the initial
> scanning process it stuck in device_add_disk() trying to read the=20
> partition table (and waiting for the uptodate bit to clear), and the=20
> udev process closing the bdev and waiting on
> 'truncate_filemap_range').

I don't understand how the udev stall came to pass. The path device
(ns->disk) is hidden, thus the set_capacity_and_notify() call for it
doesn't trigger an uevent.

>=20
> With this patch:
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fdd67a55a477..8858e5bf49de 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2258,8 +2258,6 @@ static int nvme_update_ns_info_block(struct=20
> nvme_ns *ns,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_capacity_and_notify(ns->disk, c=
apacity);
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Only set the DEA=
C bit if the device guarantees that reads
> from
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * deallocated data=
 return zeroes.=C2=A0 While the DEAC bit does
> not
> @@ -2274,6 +2272,8 @@ static int nvme_update_ns_info_block(struct=20
> nvme_ns *ns,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(NVME_NS_READY, &=
ns->flags);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nvme_ns_head_multipa=
th(ns->head))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nvme_update_ns_info_mpath(ns, info,
> unsupported);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 set_capacity_and_notify(ns->disk, capacity);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_ns_unfreeze(ns);
>=20

If the capacity actually changes, this would mean that we don't call
set_capacity() any more for ns->disk. Which means that
bdev_nr_sectors(ns->disk->part0) will not be updated, and that the
later call to set_capacity_and_notify() for the multipath device will
use the outdated value, as it uses the path device's capacity to update
the multipath device's:

	set_capacity_and_notify(disk, get_capacity(ns->disk));

Regards,
Martin


