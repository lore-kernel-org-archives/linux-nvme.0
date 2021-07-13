Return-Path: <SRS0=tkdf=MF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54156C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 09:37:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1116E61158
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 09:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1116E61158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lzd9Zn7rbQ3uToe75Z32HnHNr8mlawJVadiRefOQ/oc=; b=HX51p50yMQurB7YI8cmpEv03fq
	Nup8pN9e0UnQfL7ZfwMhtT90PxEX9MNW84JwcCG92B5c81h6XuVkDcmRjcH+3hm9M8EQNl4CN9/DZ
	RMEJpthUEttoO3iHDPTr0P5Ma+7ErlqM2+WInpx1u7eyoVh9nhnUa/1WTNAlsAp2z8ObFsoeJHZOG
	vraMAQRYv394Qg/KtsheTYSgFXvsYxASAXdN/Izqbr581/sAlqOtDFsH1ql0X+h3p6259Y/MhSwhg
	gMPIAZRlbW71wMw5voqZh3B6HxgrUE6QbF1hw6KcOMZ+s7jZmCBxEXXQafgQVtjtXlWvwar2T6mad
	+Wjdd3aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m3ErA-009fNA-FZ; Tue, 13 Jul 2021 09:37:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3Er6-009fMY-Sw
 for linux-nvme@lists.infradead.org; Tue, 13 Jul 2021 09:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626169051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=it6nM0iF7koh3EMA7FXN3eVf57VsIKnjsjicOcJLfM8=;
 b=WlchUUCKSyRyME0K1mQc//W1Afy8K28Es0/2LDs3Ab+fSKVViuOuVwuUoDLQvv9ETEhoS4
 LBCHAGHYRX8XLc8aUSJqypMzvXta5+gsqL3msnmAC087b99B/hDliJs/AxCXSG8et3YtKX
 cx/1mBfIR+vfjdzBT8PlOROV78ckV0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-3arSOKjpPhe0hSFdoFPcnQ-1; Tue, 13 Jul 2021 05:37:27 -0400
X-MC-Unique: 3arSOKjpPhe0hSFdoFPcnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12645802C80;
 Tue, 13 Jul 2021 09:37:25 +0000 (UTC)
Received: from localhost (ovpn-113-192.ams2.redhat.com [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 454F95D9CA;
 Tue, 13 Jul 2021 09:37:24 +0000 (UTC)
Date: Tue, 13 Jul 2021 10:37:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
 Padmakar Kalghatgi <p.kalghatgi@samsung.com>, its@irrelevant.dk
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, fam@euphon.net,
 kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 linux-nvme@lists.infradead.org, k.jensen@samsung.com,
 javier.gonz@samsung.com, prakash.v@samsung.com,
 d.palani@samsung.com, u.kishore@samsung.com, mohit.kap@samsung.com,
 jg123.choi@samsung.com
Subject: Re: [RFC PATCH 1/2] hw/nvme: add mi device
Message-ID: <YO1e01ex1yOvy0SB@stefanha-x1.localdomain>
References: <CGME20210709135651epcas5p1c544dec5377413bfa4b2eeab6ee43f26@epcas5p1.samsung.com>
 <20210709135545.GA11148@test-zns>
 <YOwhf59Xb/9IkZ9K@stefanha-x1.localdomain>
 <YO0k9JFO93EMaFIj@infradead.org>
MIME-Version: 1.0
In-Reply-To: <YO0k9JFO93EMaFIj@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210713_023733_094537_5102B8E9 
X-CRM114-Status: GOOD (  25.21  )
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
Content-Type: multipart/mixed; boundary="===============8954033354215295407=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============8954033354215295407==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FJ3AFhudtxOv0ink"
Content-Disposition: inline

--FJ3AFhudtxOv0ink
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 06:30:28AM +0100, Christoph Hellwig wrote:
On Tue, Jul 13, 2021 at 06:30:28AM +0100, Christoph Hellwig wrote:
> On Mon, Jul 12, 2021 at 12:03:27PM +0100, Stefan Hajnoczi wrote:
> > Why did you decide to implement -device nvme-mi as a device on
> > TYPE_NVME_BUS? If the NVMe spec somehow requires this then I'm surprise=
d
> > that there's no NVMe bus interface (callbacks). It seems like this coul=
d
> > just as easily be a property of an NVMe controller -device
> > nvme,mi=3Don|off or -device nvme-subsys,mi=3Don|off? I'm probably just =
not
> > familiar enough with MI and NVMe architecture...
>=20
> I'm too far away from qemu these days to understand what TYPE_NVME_BUS
> is.  Bt NVMe-MI has tree possible transports:
>=20
>  1) out of band through smbus.  This seems something that could be
>     trivially modelled in qemu
>  2) out of band over MCTP / PCIe VDM.
>  3) in band using NVMe admin commands that pass through MI commands

Thanks for explaining!

Common NVMe-MI code can be shared by -device nvme-mi-smbus, in-band NVMe
MI commands (part of -device nvme), a vsock transport, etc. This patch
has nvme_mi_admin_command() as the entry point to common MI code, so not
much needs to be done to achieve this.

My question about why -device nvme-mi was because this "device" doesn't
implement any bus interface (callbacks). The bus effectively just serves
as an owner of this device. The guest does not access the device via the
bus. So I'm not sure a -device is appropriate, it's an usual device.

If the device is kept, please name it -device nvme-mi-vsock so it's
clear this is the NVMe-MI vsock transport. I think the device could be
dropped and instead an -device nvme,mi-vsock=3Don|off property could be
added to enable the MI vsock transport on a specific NVMe controller.
This raises the question of whether the port number should be
configurable so multiple vsock Management Endpoints can coexist.

I don't have time to explore the architectural model, but here's the
link in case anyone wants to think through all the options for NVMe MI
Management Endpoints and how QEMU should model them:
"1.4 NVM Subsystem Architectural Model"
https://nvmexpress.org/wp-content/uploads/NVM-Express-Management-Interface-=
1.2-2021.06.02-Ratified.pdf

Stefan

--FJ3AFhudtxOv0ink
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDtXtMACgkQnKSrs4Gr
c8inEQf/U6sSy1v1hoDbepdDfWRZaQqji0O3DrFd0KLoR342ayiCqDhuFpxXTtI/
iIYgOwTEOgq75oa99+5kO+U++Z+U6fcRGnlIqDpt1eekJEYP9YC0i8k1iaRJnkyf
HSuUqZnZ1JGiNoZehu94Cc0h3+e4gKq18I1P/fuwiSQGTecSUCxG+OqAiaCE+9IL
HxRSjqTCZ5J8P/DZ9RqbHuhLvbqDqwdP9z2ECcks0iqRdiQTg9aTbMSWbNEY7+1J
QGquZTO1i/ZClSD0cytLjbGA2oy/2nGlQDPoaFG2RlF4Q4oyW6eaFdI9DOFRXX44
DVABjgPOEnmHLffsU79r+ovVU8L4Ig==
=2984
-----END PGP SIGNATURE-----

--FJ3AFhudtxOv0ink--



--===============8954033354215295407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============8954033354215295407==--


