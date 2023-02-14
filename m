Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C95C05027
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 21:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jDC3DNYBDMXCyTN1NYIfmr3zvcY5cJfv6r3q+2wlsFg=; b=a8ipcJD0LxjSc8hpTZNiFGMBMF
	p5IJmE3PJLz9WvPsTbQZ1ZrxVKaerCcZzDidh3miWTU7SwiaPPyysrP1HzyYc5xH54Il5SWxEh2jQ
	H5UvlXfXkMDlHWs2MgUC+4xZnVEVhyIR7XATLy72GGaN2Ayrx4vdggfKC0T1NjkisO4Xl5y9UNo/b
	95GkO1kuTwEqskxofXmmi5ckPUdAbt0CaQhxVs51M7781382/iWaUgCSzzDhmU5S2jU0zC+qNwQnK
	0XjaZkWELroBdq85YivTGh+Wl0umi28vCVGxuKqghbf1L2nLX1bjsUi8mkJ0RxCYj8PG5Wrw3XJto
	49GUhotA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS32W-003cu8-Gi; Tue, 14 Feb 2023 21:40:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS2tD-003Z9y-Jm
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 21:31:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676410261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=jDC3DNYBDMXCyTN1NYIfmr3zvcY5cJfv6r3q+2wlsFg=;
	b=Zs36DKKDGe42tRMjEd8wHIE0n7chOt+x0A33zhMVUPKfl5Ml2r1sv9Rcy5bCQkXz9v5IAo
	ViisLrda27Rgft3vvMNPgTEX7zTgtLuCNZAf/KT6oSHoYOipa47uj+sdkK0kb3TE502uM7
	3yVJW5uXfpGgt/SaPKQMuRPwIASww2c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-i3mM723ONASlk79Myw0CNA-1; Tue, 14 Feb 2023 16:27:37 -0500
X-MC-Unique: i3mM723ONASlk79Myw0CNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9131F1C06ECC
	for <linux-nvme@lists.infradead.org>; Tue, 14 Feb 2023 21:27:37 +0000 (UTC)
Received: from localhost (unknown [10.39.193.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 123B82166B26
	for <linux-nvme@lists.infradead.org>; Tue, 14 Feb 2023 21:27:36 +0000 (UTC)
Date: Tue, 14 Feb 2023 16:27:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: How to look up an ns cdev from block maj:min?
Message-ID: <Y+v8x4m3lm8QU7Ov@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZLGwsw6TzGA9hIRd"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_133103_839649_7D7949ED 
X-CRM114-Status: GOOD (  12.54  )
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


--ZLGwsw6TzGA9hIRd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Is there an official way for userspace to look up an ns cdev from a
block maj:min?

For example, how should a userspace program determine that /dev/ng0n1 is
the corresponding ns cdev when given just the block device node
/dev/nvme0n1?

Parsing the filename is an obvious option but it makes assumptions about
the naming convention of both the block device node and the character
device node.

Is there a better way via sysfs? (I couldn't find it.)

Thanks,
Stefan

--ZLGwsw6TzGA9hIRd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPr/McACgkQnKSrs4Gr
c8gc0QgAqvCcTyzQGaTXL3e1diWW/QXJ7CUTNYiC/l/eA0vKO0dWjD2fU1IxbcIJ
QRPCcZwy8CJrCFotuzQgb+F36BCl+W7FtOE9gAErq94RbptjYckz5IUlbkHU1e0G
dDDaIdhGmsNcpfVH+B/NRKseSVqeeDVK8nP36CrcHAf4UbzMWXlyjGix09L/2enk
8imKlxbU+8902qExllX5qrt0N5dEYsFodVvLaz7tQt0GEXiY/vFXaWPxdeq2sHuv
Pvx+y3gjXXio5Bz+cxGWpoZvnD1rVFg2zi25Qhjox0WTAXFBJ7Dby61sZjMN+48U
xiMK3Bn0YMhFCBvdQ8Npq9R8M9Dxzw==
=NJoS
-----END PGP SIGNATURE-----

--ZLGwsw6TzGA9hIRd--


