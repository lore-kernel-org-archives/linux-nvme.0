Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5DDD116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I6cvuay9TvcgzCSa2szhxoL8AXhyOhaVC4Nmz1aT7UM=; b=VnrBSpr8aXxvvxqeFenRqBaIpk
	N/RV2qQ2dbSUl+weWG105iX5jz0pLfxxkh8+aSCuun6OtS5NoP2zisY/He2gbGwVt7Y+b2732wxIz
	Slc2Oppoy3ubGCDGBAVdX5LHxS22yfcZXyTGRJS1tQK1FYB9oulEpJokzR/5LbvZuupSeBw1b2zMv
	MgLAhTOj+dskD2d4Ye4XE9oUtZyJ5DG79Oj56WG/9MmsdAlpv/DcwW5V2HsmKQXIaHoC4LYeM/elN
	bZ4eC172uqRHEIIUwGc9JLFw7ISu/yfCbHp7CywEh6UfcB8lC2JyadjyUyDKm9AsE5v/gJNbgHbdm
	9Eo0m/zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ5bl-00000004AA6-185K;
	Mon, 01 Dec 2025 15:14:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ5bi-00000004A9W-2kgN
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 15:14:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764602069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6cvuay9TvcgzCSa2szhxoL8AXhyOhaVC4Nmz1aT7UM=;
	b=GPFJtxKIpX0bDRXq15qENCjWa/tOl51Y/vbaZPrWmSDjKtfqTFx+LlR5hOpXxWu0tMIc2R
	TsCqHhdmW8NVCGqG2NkjL9RxJDS7fVaUD0H/TZdZW8ddFXWG/7hURWTtldyCcfocuMSxqR
	5c07VFVj1+M3dTj8uJzwAn65WNTD2gQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-2MHEfzbSMbqWxAszSp-yAQ-1; Mon,
 01 Dec 2025 10:14:24 -0500
X-MC-Unique: 2MHEfzbSMbqWxAszSp-yAQ-1
X-Mimecast-MFC-AGG-ID: 2MHEfzbSMbqWxAszSp-yAQ_1764602061
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F0F11800EF6;
	Mon,  1 Dec 2025 15:14:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A85B19560A7;
	Mon,  1 Dec 2025 15:14:19 +0000 (UTC)
Date: Mon, 1 Dec 2025 10:14:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] block: add IOC_PR_READ_KEYS ioctl
Message-ID: <20251201151418.GC866564@fedora>
References: <20251126163600.583036-1-stefanha@redhat.com>
 <20251126163600.583036-4-stefanha@redhat.com>
 <cfd7cace-563b-4fcb-9415-72ac0eb3e811@suse.de>
 <89bdc184-363c-4d14-bad6-dd4ab65b80d9@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rlrGdwHT0htf22pn"
Content-Disposition: inline
In-Reply-To: <89bdc184-363c-4d14-bad6-dd4ab65b80d9@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_071430_790646_47EBB6C3 
X-CRM114-Status: GOOD (  18.64  )
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


--rlrGdwHT0htf22pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 03:32:35PM +0100, Krzysztof Kozlowski wrote:
> On 27/11/2025 08:07, Hannes Reinecke wrote:
> >=20
> >> +	size_t keys_info_len =3D struct_size(keys_info, keys, inout.num_keys=
);
> >> +
> >> +	keys_info =3D kzalloc(keys_info_len, GFP_KERNEL);
> >> +	if (!keys_info)
> >> +		return -ENOMEM;
> >> +
> >> +	keys_info->num_keys =3D inout.num_keys;
> >> +
> >> +	ret =3D ops->pr_read_keys(bdev, keys_info);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Copy out individual keys */
> >> +	u64 __user *keys_ptr =3D u64_to_user_ptr(inout.keys_ptr);
> >> +	u32 num_copy_keys =3D min(inout.num_keys, keys_info->num_keys);
> >> +	size_t keys_copy_len =3D num_copy_keys * sizeof(keys_info->keys[0]);
> >=20
> > We just had the discussion about variable declarations on the ksummit=
=20
> > lists; I really would prefer to have all declarations at the start of=
=20
> > the scope (read: at the start of the function here).
>=20
> Then also cleanup.h should not be used here.

Hi Krzysztof,
Christoph Hellwig replied to the v2 series, also against using __free().
Regardless of the reply I just sent to you about whether cleanup.h may
or may not be used in code that forbids declarations midway through a
scope, I will be dropping it in v3.

Thanks,
Stefan

--rlrGdwHT0htf22pn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmktsMoACgkQnKSrs4Gr
c8jXyQf/Xb1N0Lry0quE06jBUyiqZo66ksdNXaM1ieTz8sh8NzXWrxSHKfVGwdZ9
wj6uj7sVEOKfWf7c0dPW/x1/2tzc7n2mhamEIWh7ExQxJ28165MkkmOOQ+0uttCz
H0gOYhEcUtDRs5TcD40sY8yFIb7xNCUC4U3xAEpE+9Oz/fdWLurBh+eioiGldhSD
OO+dCosy9BhTco9y9zU9MdJfX7/PeCtManlpKUV4d+9r83hp8I9fIxV+3faMzHfp
wdU3DR0PGdlIur7d8vHCE5oh4UEo0i63E8XFcBh2qQoTy8zoPgR4L8Zu7IJU4VoH
pVpBEcm32EFKLfFyeLkmkA6N2DtoSQ==
=+H1/
-----END PGP SIGNATURE-----

--rlrGdwHT0htf22pn--


