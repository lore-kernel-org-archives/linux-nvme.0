Return-Path: <SRS0=IqcX=ME=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C307C07E99
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 16:55:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE82E610FA
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 16:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE82E610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VvaiQ0A/5nNiig4gFnST7B+EYaQ2ZASc/sIMF5cj70E=; b=yLgGnL/qv+yX6NawIYEhWdJaDw
	skL0Ws7v3EkP+LK/md5YI3xXCKeVXHFn+9JAyE2WkhheDPkJDgy4jrhwVX/1rr6aNcjEGz6Q03YUd
	0clSAhegvSypT6es6FVfniC0qGHJy0EGV61XyvpkUPr794cIW7EjEnGT2svdPyfMRYstcwkazE/Yd
	OXX+ddRTWKkD/sFJABlG/2D62dskNuP8wVwUgvNe672ShAnR3iWlL5e5NbBrm1g3FLt5aNm4gHGTt
	7srs7WvfV6eLCwxvzgEY/V4YuNgMVLlPRwljo/ZtDhJPRa0X0UyDrzP9sN8o5U/pDOSVFjrWNwUTC
	/zM0omCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m2zCs-0080E9-Lo; Mon, 12 Jul 2021 16:54:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2zCp-0080D3-PY
 for linux-nvme@lists.infradead.org; Mon, 12 Jul 2021 16:54:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626108893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4rqCahuOn+ddAKhoLcUdRBsflU+yYlrCTa/RXig28Y4=;
 b=dmxJKskyhiR+bmiUOSThuzCKvQRUwqIKXZD87kgXIt/NmL25VWL5Fi5yitwR6MDxvpM90d
 tDja1hzjtP+rBBaVx/UtD5Ou3U5A+XYNou9Jw1M9gWfAGuWV4hAU7PCXo2WgdMQEqmhtcC
 Qu53OdMn9UWQt+upn70cdUCIJBAJqvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-AuH17rr6MPOH6N5WlpzmLg-1; Mon, 12 Jul 2021 12:54:49 -0400
X-MC-Unique: AuH17rr6MPOH6N5WlpzmLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83D00800C78;
 Mon, 12 Jul 2021 16:54:47 +0000 (UTC)
Received: from localhost (ovpn-112-230.ams2.redhat.com [10.36.112.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09F741970E;
 Mon, 12 Jul 2021 16:54:46 +0000 (UTC)
Date: Mon, 12 Jul 2021 12:03:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, its@irrelevant.dk,
 fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, linux-nvme@lists.infradead.org,
 k.jensen@samsung.com, javier.gonz@samsung.com,
 prakash.v@samsung.com, d.palani@samsung.com, u.kishore@samsung.com,
 mohit.kap@samsung.com, jg123.choi@samsung.com
Subject: Re: [RFC PATCH 1/2] hw/nvme: add mi device
Message-ID: <YOwhf59Xb/9IkZ9K@stefanha-x1.localdomain>
References: <CGME20210709135651epcas5p1c544dec5377413bfa4b2eeab6ee43f26@epcas5p1.samsung.com>
 <20210709135545.GA11148@test-zns>
MIME-Version: 1.0
In-Reply-To: <20210709135545.GA11148@test-zns>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210712_095455_947472_B400DB41 
X-CRM114-Status: GOOD (  29.00  )
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
Content-Type: multipart/mixed; boundary="===============7600250722394515342=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============7600250722394515342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IMpYdEGnbZt5/SdV"
Content-Disposition: inline

--IMpYdEGnbZt5/SdV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 09, 2021 at 07:25:45PM +0530, Padmakar Kalghatgi wrote:
> The enclosed patch contains the implementation of certain
> commands of nvme-mi specification.The MI commands are useful
> to manage/configure/monitor the device.Eventhough the MI commands
> can be sent via the inband NVMe-MI send/recieve commands, the idea here i=
s
> to emulate the sideband interface for MI.
>=20
> Since the nvme-mi specification deals in communicating
> to the nvme subsystem via. a sideband interface, in this
> qemu implementation, virtual-vsock is used for making the
> sideband communication, the guest VM needs to make the
> connection to the specific cid of the vsock of the qemu host.
>=20
> One needs to specify the following command in the launch to
> specify the nvme-mi device, cid and to setup the vsock:
> -device nvme-mi,bus=3D<nvme bus number>
> -device vhost-vsock-pci, guest-cid=3D<vsock cid>
>=20
> The following commands are tested with nvme-cli by hooking
> to the cid of the vsock as shown above and use the socket
> send/recieve commands to issue the commands and get the response.
>=20
> we are planning to push the changes for nvme-cli as well to test the
> MI functionality.

Is the purpose of this feature (-device nvme-mi) testing MI with QEMU's
NVMe implementation?

My understanding is that instead of inventing an out-of-band interface
in the form of a new paravirtualized device, you decided to use vsock to
send MI commands from the guest to QEMU?

> As the connection can be established by the guest VM at any point,
> we have created a thread which is looking for a connection request.
> Please suggest if there is a native/better way to handle this.

QEMU has an event-driven architecture and uses threads sparingly. When
it uses threads it uses qemu_create_thread() instead of
pthread_create(), but I suggest using qemu_set_fd_handler() or a
coroutine with QIOChannel to integrate into the QEMU event loop instead.

I didn't see any thread synchronization, so I'm not sure if accessing
NVMe state from the MI thread is safe. Changing the code to use QEMU's
event loop can solve that problem since there's no separate thread.

> This module makes use of the NvmeCtrl structure of the nvme module,
> to fetch relevant information of the nvme device which are used in
> some of the mi commands. Eventhough certain commands might require
> modification to the nvme module, currently we have currently refrained
> from making changes to the nvme module.

Why did you decide to implement -device nvme-mi as a device on
TYPE_NVME_BUS? If the NVMe spec somehow requires this then I'm surprised
that there's no NVMe bus interface (callbacks). It seems like this could
just as easily be a property of an NVMe controller -device
nvme,mi=3Don|off or -device nvme-subsys,mi=3Don|off? I'm probably just not
familiar enough with MI and NVMe architecture...

Stefan

--IMpYdEGnbZt5/SdV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDsIX8ACgkQnKSrs4Gr
c8jXkwf9HuFYHIhF3iAVsVtP9f9yvG+qxjBlU0+Uk8I1m8PfAu6BIefddWrvSMxV
eGzRPe2PCAYs8uQpoCSXQ05W9luzLJJF6o8Qk6ojekXCcG/VSszvMj6o9F3NpWBx
EGxifEtCjCH60HjLUZH+rVoT9GpVmY8lAp1PRjS6NCHUc0M/gwF9OZKA/f0IvT3C
ZY1RsjmHNXT1hk2F7u5t4q8wE2uWIHe8lXL6oAAHQd76OJN3Mrgq+1rpuVvsAGbN
zQAjDJAN0C9BSrEUnKF3MCAHB2CdGaM+mEMJOmPTgAmctqAR39O88acFnZbm1w3c
jp3Jaz0+zy4GjLbi4mog6d2CfIRxWw==
=rx62
-----END PGP SIGNATURE-----

--IMpYdEGnbZt5/SdV--



--===============7600250722394515342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7600250722394515342==--


