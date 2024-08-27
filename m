Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B3FC5472F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2jJVru0l4gCySv7rMg42Ji096t9ns13XO/8Wb853iIo=; b=4ywWbFx7W+sqgH9zhjceYoYXPn
	D73kOAs2a1LaNWTDclvXexAwF69S1VtMBoe86srpqgKr+H8KEhnolJGe/YSxxQThBp2Er252j5x8I
	tAzkVp3R9pX8kqxgUXWVCH/xW4rdpvcyDWn9qH3e6JLlyiZr9KTti6ixzWJcEB0AgEV5TDweeZ4QF
	Gjp6GiNmiyR2dTWjSCQzYb2F7gCo2nARdz90mQO3iDE/8b3qrvyhlY04NNFzJtFdwvU9oeYL5CVK8
	7o+0M1IuNIJ35mIbYNxejQp2fapo8zLSYBFF+NMQ8gQST9BIRSSAf35oPZnbPND7j3ImWNsL4vy00
	G3rhpJBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siyMA-0000000BvvR-3q7P;
	Tue, 27 Aug 2024 15:43:42 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siyLP-0000000Bvlb-2YwZ
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 15:43:42 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C4ED21AF8;
	Tue, 27 Aug 2024 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724773373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jJVru0l4gCySv7rMg42Ji096t9ns13XO/8Wb853iIo=;
	b=gzshdyu4xTZ4prWztZZ2w9kisiQ7Vx3jVXT7JeGUi7ahFdxg0XORcC4D89Che6dSqhWo8a
	201dXsUCseWoGLvNMWMsQdsedSern0eltd89J70q1VpIEpxpKyXQouJBs1Pl2LBYd70EYu
	1lnC6iEGNYo35yTowNVncAx7TN4iFdI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gzshdyu4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724773373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jJVru0l4gCySv7rMg42Ji096t9ns13XO/8Wb853iIo=;
	b=gzshdyu4xTZ4prWztZZ2w9kisiQ7Vx3jVXT7JeGUi7ahFdxg0XORcC4D89Che6dSqhWo8a
	201dXsUCseWoGLvNMWMsQdsedSern0eltd89J70q1VpIEpxpKyXQouJBs1Pl2LBYd70EYu
	1lnC6iEGNYo35yTowNVncAx7TN4iFdI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53AD113A44;
	Tue, 27 Aug 2024 15:42:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3/PLEv3zzWb1KQAAD6G6ig
	(envelope-from <mwilck@suse.com>); Tue, 27 Aug 2024 15:42:53 +0000
Message-ID: <41331f243b0b3172cfdcf0ef33b8ed34e813bac2.camel@suse.com>
Subject: Re: [PATCH v3] nvme: core: shorten duration of multipath namespace
 rescan
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi
 Grimberg <sagi@grimberg.me>, Niklas Cassel <cassel@kernel.org>, Hannes
 Reinecke <hare@suse.de>,  Daniel Wagner <dwagner@suse.de>, Stuart Hayes
 <stuart.w.hayes@gmail.com>, linux-nvme@lists.infradead.org
Date: Tue, 27 Aug 2024 17:42:52 +0200
In-Reply-To: <20240827063332.GA11773@lst.de>
References: <20240826163951.68078-1-mwilck@suse.com>
	 <20240827063332.GA11773@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9C4ED21AF8
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,grimberg.me,suse.de,gmail.com,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_084255_882731_729D610B 
X-CRM114-Status: GOOD (  24.58  )
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

On Tue, 2024-08-27 at 08:33 +0200, Christoph Hellwig wrote:
> > +	/*
> > +	 * The controller queue is going to be frozen in
> > +	 * nvme_update_ns_info_{generic,block}(). Every freeze
> > implies waiting
> > +	 * for an RCU grace period to pass. For multipath devices,
> > we
> > +	 * need to freeze the multipath queue, too. Start freezing
> > the
> > +	 * multipath queue now, lest we need to wait for two grace
> > periods.
> > +	 */
> > +	if (nvme_ns_head_multipath(ns->head))
> > +		blk_freeze_queue_start(ns->head->disk->queue);
>=20
> I really don't like how we keep this state around the calls into
> the command set specific nvme_update_ns_info_* calls, and how it
> feels very open coded.
>=20
> And while looking at it, I think we might even want the multipath
> queue frozen over the actual update as well, as there is no point
> in sending the I/O even to other paths while we are updating the
> information, as they'll probably fail.
>=20
> Here is what might make sense:
>=20
> =C2=A01) move the code past the csi switch statement in
> nvme_update_ns_info
> =C2=A0=C2=A0=C2=A0 into a new nvme_update_ns_info_common helper and all t=
hat
> =C2=A0=C2=A0=C2=A0 from nvme_update_ns_info_block and nvme_update_ns_info=
_generic.
> =C2=A0=C2=A0=C2=A0 Maybe having another helper just for the multipath upd=
ates might
> =C2=A0=C2=A0=C2=A0 also be worthwhile.
> =C2=A02) add new nvme_freeze_ns helpers that freeze the ns and nshead
> =C2=A0=C2=A0=C2=A0 queues and use those in nvme_update_ns_info_block and
> =C2=A0=C2=A0=C2=A0 nvme_update_ns_info_generic over the entire update

Not sure if I understood you correctly, but a single helper for
unfreezing both the path and the multipath queues won't work.The
following code block

        if (blk_queue_is_zoned(ns->queue)) {
                ret =3D blk_revalidate_disk_zones(ns->disk);
                if (ret && !nvme_first_scan(ns->disk))
                        goto out;
        }

must be called from nvme_update_ns_info_block() after unfreezing the
path queue, but its result is used in the code that must run with the
multipath queue still frozen. So we can freeze both queues at the same
time, but we must unfreeze them separately.

Still trying to work this out.

Martin


