Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F9AC636D4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DRjna533//Ef8pqtxeLH/YWs68nSu8n21Vi0ra3uQ+M=; b=rlAisgXUn+cZ5FK/Ol6417MIcS
	g6I2hi+Sj/IktSHbNtGOnAOgq+x7zS3iz03xcrt+ceBo59Iqa2G7yaSOhofy9wd9jwrlxQeoSf6fV
	aZC5HgTqjTiuKbSgCfa9pZ27mhsxhVCAlbV8P8K0YbPPcdSnCIASvHIqCYO9ngpYxFQcQoUpGyCn4
	upzmOGy6/rMHV6UPtY1xmoIQt3EQ9mKRp0mZOX+iZKMD4No9DMhuTaOXTrTYV4mEvKKZykaMG9G8i
	oXPtbwLdM/ACQfN3lf/hxLQQtbxh7CozIuSUn/jEFqX+fQGbdSS0ipgS+HcyCpsnG9RBLJYsryxCK
	grax1eaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSO06-0073O7-Ha; Wed, 15 Feb 2023 20:03:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSO02-0073Lw-GA
	for linux-nvme@lists.infradead.org; Wed, 15 Feb 2023 20:03:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676491407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DRjna533//Ef8pqtxeLH/YWs68nSu8n21Vi0ra3uQ+M=;
	b=WNWxtHQeIjYXoyj/LCaQaRfeqzFgm0IhPghGEH21D7UHqFmQ2HGNEUqwd8BxX+wHXi9/Jz
	l0JBplMCuAB7KIQYY9HEAqC91GFH09PzoR2eo9kTOBTt4H3iElupkKon/sNR/0tI2E0G0K
	hA88PoEKeXankG4q+Q2HXdsNQS3QFEU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-TyJAMSBfM4Kx-eWqQlCuSQ-1; Wed, 15 Feb 2023 15:03:22 -0500
X-MC-Unique: TyJAMSBfM4Kx-eWqQlCuSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1C5A1C06ECE;
	Wed, 15 Feb 2023 20:03:21 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EF971400AFC;
	Wed, 15 Feb 2023 20:03:20 +0000 (UTC)
Date: Wed, 15 Feb 2023 10:51:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: How to look up an ns cdev from block maj:min?
Message-ID: <Y+z/hvxHnk4edQvg@fedora>
References: <Y+v8x4m3lm8QU7Ov@fedora>
 <7f958c6d-d6e6-2346-a680-875c7fafe7e5@grimberg.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+uJ7QUADVhIxE9Xw"
Content-Disposition: inline
In-Reply-To: <7f958c6d-d6e6-2346-a680-875c7fafe7e5@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_120330_631777_77EC6734 
X-CRM114-Status: GOOD (  28.35  )
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


--+uJ7QUADVhIxE9Xw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 10:41:08AM +0200, Sagi Grimberg wrote:
>=20
> > Hi,
> > Is there an official way for userspace to look up an ns cdev from a
> > block maj:min?
> >=20
> > For example, how should a userspace program determine that /dev/ng0n1 is
> > the corresponding ns cdev when given just the block device node
> > /dev/nvme0n1?
> >=20
> > Parsing the filename is an obvious option but it makes assumptions about
> > the naming convention of both the block device node and the character
> > device node.
> >=20
> > Is there a better way via sysfs? (I couldn't find it.)
>=20
> Not that I can see... It follows the same rules as the
> normal namespace, which means that it takes the subsystem or ctrl
> instance number (depending if multipathing is enabled) and it will have
> the same namespace instance number.
>=20
> In other words, every namespace nvmeXnY will present an 'nvme generic'
> chardev in the form of ngXnY.

Thanks for confirming!

Stefan

>=20
> Looks like nvme-cli is missing the generic representation in the json
> output as well. Perhaps that is the best tool to use (once fixed with
> the json output with the below):
>=20
> --
> diff --git a/nvme-print-json.c b/nvme-print-json.c
> index df5616e88119..489e9e15c3b5 100644
> --- a/nvme-print-json.c
> +++ b/nvme-print-json.c
> @@ -2507,6 +2507,7 @@ static void json_detail_list(nvme_root_t r)
>                                         uint64_t nuse =3D
> nvme_ns_get_lba_util(n) * lba;
>=20
>=20
> json_object_add_value_string(jns, "NameSpace", nvme_ns_get_name(n));
> + json_object_add_value_string(jns, "Generic", nvme_ns_get_generic_name(n=
));
>                                         json_object_add_value_int(jns,
> "NSID", nvme_ns_get_nsid(n));
>=20
> json_object_add_value_uint64(jns, "UsedBytes", nuse);
>=20
> json_object_add_value_uint64(jns, "MaximumLBA", nvme_ns_get_lba_count(n));
> @@ -2565,15 +2566,18 @@ static struct json_object *json_list_item(nvme_ns=
_t
> n)
>  {
>         struct json_object *jdevice =3D json_create_object();
>         char devname[128] =3D { 0 };
> +       char genname[128] =3D { 0 };
>=20
>         int lba =3D nvme_ns_get_lba_size(n);
>         uint64_t nsze =3D nvme_ns_get_lba_count(n) * lba;
>         uint64_t nuse =3D nvme_ns_get_lba_util(n) * lba;
>=20
>         nvme_dev_full_path(n, devname, sizeof(devname));
> +       nvme_generic_full_path(n, genname, sizeof(genname));
>=20
>         json_object_add_value_int(jdevice, "NameSpace",
> nvme_ns_get_nsid(n));
>         json_object_add_value_string(jdevice, "DevicePath", devname);
> +       json_object_add_value_string(jdevice, "GenericPath", genname);
>         json_object_add_value_string(jdevice, "Firmware",
> nvme_ns_get_firmware(n));
>         json_object_add_value_string(jdevice, "ModelNumber",
> nvme_ns_get_model(n));
>         json_object_add_value_string(jdevice, "SerialNumber",
> nvme_ns_get_serial(n));
> diff --git a/nvme-print.c b/nvme-print.c
> index fee9aabfc176..ec98fe304c4b 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -5108,7 +5108,7 @@ void nvme_dev_full_path(nvme_ns_t n, char *path,
> size_t len)
>         snprintf(path, len, "%s", nvme_ns_get_name(n));
>  }
>=20
> -static void nvme_generic_full_path(nvme_ns_t n, char *path, size_t len)
> +void nvme_generic_full_path(nvme_ns_t n, char *path, size_t len)
>  {
>         int head_instance;
>         int instance;
> diff --git a/nvme-print.h b/nvme-print.h
> index ab11774daa28..7a4ceeea5131 100644
> --- a/nvme-print.h
> +++ b/nvme-print.h
> @@ -149,6 +149,7 @@ const char *nvme_feature_to_string(enum nvme_features=
_id
> feature);
>  const char *nvme_register_to_string(int reg);
>=20
>  void nvme_dev_full_path(nvme_ns_t n, char *path, size_t len);
> +void nvme_generic_full_path(nvme_ns_t n, char *path, size_t len);
>  char *zone_type_to_string(__u8 cond);
>  char *zone_state_to_string(__u8 state);
>  const char *nvme_pel_event_to_string(int type);
> --
>=20

--+uJ7QUADVhIxE9Xw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPs/4YACgkQnKSrs4Gr
c8g6hgf/YRMpvhzl9bVx0z7mzsv2nuwsa6DVnA/B7Jn6Np5NiUl1S4S/GbxuUWRP
WHl1nIN2ugFIlFf/LT5SpcKEEmqM/LC45afp+6BM8UYeggS+rsbHZ5UTW2tidGC8
PZNhOYzmFcJic/KfKOOW3zNyboxC0dCwg97tYSgQxOs9hxklLPNi95wkHzT8skQl
05rko1mZ6Un8ZoH1ms42lqhAEzLvaqetq4wRukvtFKheGsGBWCEnfdWIJ3wjMNhF
0lebI3U16hUMBNSHnutVricn26h7vIJ4NhjYQuWZMgTA9JwiMSqsC5Nhx9SfOY4e
AO/8Z1Utz5Fqbvk/vtbwfPa8pzdkHA==
=ICdy
-----END PGP SIGNATURE-----

--+uJ7QUADVhIxE9Xw--


