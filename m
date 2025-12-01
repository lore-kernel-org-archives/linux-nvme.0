Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7827BD116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0taldGU/p3RQUsqrVclk++ge/JmFmUsQeYAw3t0jxA0=; b=0jNPGEQSGvBbJ6BwNXt+FBLWgQ
	/CHApdjpoylzdm6DydkMR72r5WHUefoInbcb92/+PekZpWf2Zas48lkdkzYJJu2zleL/DXtuiuzFH
	AyIY2viGvKkZLV8gtpxoYIIGkNTaYy1B/rFkE9IoTOwkYlbl9tYdfomHRgOEG0ksCKIBVG9qHfZ07
	vcwDQtdtldwFPmZCvJxlCiDjoupDc1NbJ+jLggrb5GHMlDeycGh0m3bgD/uiQtYzrgGJUdTHUCRMU
	PCzurzjT5chLBRRfUrvymt264ExJ4s2f7k3s/76wzgEAoMgymSZTGvYOAfb57PUp3ewZw5C6iYGRq
	XojItTbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ5UN-000000049Xd-3Utl;
	Mon, 01 Dec 2025 15:06:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ5UI-000000049Wy-2FRR
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 15:06:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764601608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0taldGU/p3RQUsqrVclk++ge/JmFmUsQeYAw3t0jxA0=;
	b=Ms1e5StmQwwRI1eNZNnfvigDQ4J8k5iTZk5mTQNr9Cqhba4NFBBj2/qHZrhkfU07AeCTPD
	LbHzXm/NO0S9XUTz4whcwKMQqMMrLawU2Igd6IoBw4jaBMZFRObF1riNaVfgiZyDbA3ZDB
	SDoi8s3AaJz9xaa77gS1YRwMzX5RQ9U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-TodEzmINNRugQ6nx2slY1w-1; Mon,
 01 Dec 2025 10:06:43 -0500
X-MC-Unique: TodEzmINNRugQ6nx2slY1w-1
X-Mimecast-MFC-AGG-ID: TodEzmINNRugQ6nx2slY1w_1764601601
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 597B0195608F;
	Mon,  1 Dec 2025 15:06:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48F3830001A4;
	Mon,  1 Dec 2025 15:06:38 +0000 (UTC)
Date: Mon, 1 Dec 2025 10:06:36 -0500
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
Message-ID: <20251201150636.GA866564@fedora>
References: <20251126163600.583036-1-stefanha@redhat.com>
 <20251126163600.583036-4-stefanha@redhat.com>
 <cfd7cace-563b-4fcb-9415-72ac0eb3e811@suse.de>
 <89bdc184-363c-4d14-bad6-dd4ab65b80d9@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/C/EfXMAoYrl/InE"
Content-Disposition: inline
In-Reply-To: <89bdc184-363c-4d14-bad6-dd4ab65b80d9@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_070650_663678_4E4C8B3B 
X-CRM114-Status: GOOD (  21.64  )
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


--/C/EfXMAoYrl/InE
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
The documentation in cleanup.h says:

 * Given that the "__free(...) =3D NULL" pattern for variables defined at
 * the top of the function poses this potential interdependency problem
 * the recommendation is to always define and assign variables in one
       ^^^^^^^^^^^^^^
 * statement and not group variable definitions at the top of the
 * function when __free() is used.

This is a recommendation, not mandatory. It is also describing a
scenario that does not apply here.

There are many examples of existing users of __free() initialized to
NULL:

  $ git grep '__free(' | grep ' =3D NULL' | wc -l
  491

To me it seems like it is okay to use cleanup.h in this fashion. Did I
miss something?

Thanks,
Stefan

--/C/EfXMAoYrl/InE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmktrvwACgkQnKSrs4Gr
c8i7bAf9HNfOvXB6gX5exTG1f7E+v7bUNWhclZTjpR5u8BtEtSCbwk2zvR4o81B2
9ROH8bQvPQv+NeT+zqIcGdsoBC6rbfZmDSHlALtvCsGb51Y2nZ9sZhpH1EcycjsS
yIFFFCmSzkHRMf/oSNs5g+lS9oXs0sUW8mCZD6oofK8hSFv0Qa+BbgUhF36dAQO8
OSp+PGYyJgQ/GnBqxxJ2lhTBVxoX/k3p7rwUY1MuPAa8wMa+skIT5uCa8zIP+Li/
Uv6qRE1wUmmAMJJvyRHTo+fJAH8Si01hMa2hzw8efDv781qLxzLj4NKL9MpQDxbC
wb1TkzyzAqb7unNVO/A2XFcrzeIObw==
=mmRd
-----END PGP SIGNATURE-----

--/C/EfXMAoYrl/InE--


