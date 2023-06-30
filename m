Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48225EB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JjudmYc+t4AhUeg8M5MES9aRhblFwTPNdMxP3nSzsE4=; b=eGbRWfAViaVrDB4tX1AMt+9G6E
	HyLXDFpJ79f7feUGEa+yacgQFXPu/QQJgURfKBi7ZtJI9ScRP4nLFIKR9RjUUD40C2aWtXIoB7uEU
	gqAn5VcQuyHZ+0UsFJfS0/bkT6rvEa/I90rNVfBTEN+byKLHQZGze960rgAs962o+8qXgXDG7beqg
	czSbRaRqZx1rj6uDB6zAh4txJ8zcPnzAZp2O/tDusLD9Fgj6Gn0Fdz10edtQbPTAHWlbJfazAlXIR
	vP6q4e69kr3lQpRhhLwXlQ3yhBlPHfb8mAOWs1CF03XLHXW52/POItmuS7WCiLx/7DPJTomkVZ34k
	wTu1dRhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFIpZ-004IhG-2e;
	Fri, 30 Jun 2023 18:26:53 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFIpW-004Ig4-0n
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 18:26:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B2F91F8C2;
	Fri, 30 Jun 2023 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1688149606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjudmYc+t4AhUeg8M5MES9aRhblFwTPNdMxP3nSzsE4=;
	b=jHBqhOoevdO4MK0tHEKrzcIFh/sNfQ/P1KGheod6Yvsqv2GYsCqzjwN0rRx9aS/Yol9wU2
	fHkniBSsYGU5FLUKRiUpwOdL1eF0SMh5eb9MSZ4u7sL3NQUwhpWx7QJUP+CVHoHJQjQUIQ
	zxwIDZ5XAnzUu7wL37HeFXtVz5eZUgs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65A85138F8;
	Fri, 30 Jun 2023 18:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pJDYF2Yen2TjaAAAMHmgww
	(envelope-from <mkoutny@suse.com>); Fri, 30 Jun 2023 18:26:46 +0000
Date: Fri, 30 Jun 2023 20:26:45 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ofir Gal <ofir.gal@volumez.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, cgroups@vger.kernel.org, 
	tj@kernel.org
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Message-ID: <vjb27jezj3j45l4gwcgge54st32xfoduvam6lu2irdg7xligea@erxg5rhvklr3>
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
 <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
 <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vsldarc2hw5fdqjn"
Content-Disposition: inline
In-Reply-To: <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_112650_451719_67790273 
X-CRM114-Status: GOOD (  13.38  )
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


--vsldarc2hw5fdqjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Jun 29, 2023 at 06:21:34PM +0300, Ofir Gal <ofir.gal@volumez.com> w=
rote:
> >>> Currently there is no way to throttle nvme targets with cgroup v2.
> >>
> >> How do you do it with v1?
> With v1 I would add a blkio rule at the cgroup root level. The bio's
> that the nvme target submits aren't associated to a specific cgroup,
> which makes them follow the rules of the cgroup root level.
>=20
> V2 doesn't allow to set rules at the root level by design.

I think you want to add a per-nvme port (device?) throttled-bandwidth
attribute (instead of param_associated_cgroup) to control this on the
client (whole host) side -- even without cgroups.
Associating ports with cgroups and then bios with cgroups looks
superfluous.
(But it is understandably tempting because then IO controller's
throttling implementaion may be reused.)


How are the nvmet_bdev_execute_rw() et al functions called? (Only via
kthreads without (uspace) process context? Or can the reqs be traced to
a user space process?)

Thanks,
Michal

--vsldarc2hw5fdqjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZJ8eYwAKCRAGvrMr/1gc
jhfgAP9NUZ0UHO1rcdmDFFxkaXaqqbBN5FcUsYD34VDU684djwD/RL9E71JMN1Fd
E1uJRAC4up2kwbfgkuuCGPhA2jx5nAE=
=+Y3/
-----END PGP SIGNATURE-----

--vsldarc2hw5fdqjn--

