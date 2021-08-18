Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C26C432BE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 06:01:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E847461076
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 06:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E847461076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NWChNwzcjZY9bmCFZlxuqpSRZ3MfvDi/tTKpG+Y68bk=; b=FIp8ThAnROHb37WDxk6Af8zXlD
	l2wftQf7dlSD8xoxKr/Ggqveg7UYoG7rxdJ+nB8hkFlIp2KESGqD10zExjKlyturoii5vK0MUVHHG
	9MXKTWHFotG2JAcxVJ/9puyxLi+jLiGp89kILXh0A+VyUDPvU3HTNDd4c0jHlPTfePlNEoWJi2XnB
	3pY7GE4aC/GpjHySUa2rQW0uQgCz5p4YUd1OOl0U2hX/O73wMrhAKXLUZQ8pcdA7Bt2sY4hUVcZSg
	eipMFI1zsUHXyb1LFdY7PL+CIZqxE++z7ocJm8LOn1eSzJ7bpwi+1/LeWWXtJusqvtcxU/nQSWVJS
	ayJWBXQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGEdg-004IDQ-3H; Wed, 18 Aug 2021 06:01:24 +0000
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGEdZ-004IAC-3J
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 06:01:21 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.west.internal (Postfix) with ESMTP id F3EB32B011E3;
 Wed, 18 Aug 2021 02:01:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Wed, 18 Aug 2021 02:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=heM2TvNxsotfnc7hjjKhOEZ+cx1
 fs+9CFsdet+NE/Jc=; b=JRTVrJs4Zt+i5KQpZQtt2zNjggqxVqnj3gdZTzj9RGP
 nKGXsh8/CQSFVy1xIT/g+13EkeacYUPEXjPW444JF/tGIizIGS+AYQGdkrrFkz4U
 7QboNMSPig+2CILSge64nwuWXuEMrTYBkg3acmhwEHSuW8WaqTJNPGukSBy8d4O3
 aCIw38JzTnbQR9XSgBcp6HopyPlTvOFE1tlUizbIzc69dCAZUoTD4pp98QJcn1TX
 BRmW2SHk7ijtHeo8Ja3aEVd4p8UFKGBBfrnef/AwPQrsaiGCFYi0rjDrGFnUZZqm
 ixOjeKnn9wxLeRQyNFtAEUS+1r94jdoWHICQsd3h+gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=heM2Tv
 Nxsotfnc7hjjKhOEZ+cx1fs+9CFsdet+NE/Jc=; b=lyImZxs8On0ebRnevB2Q8h
 msChRzzoDMCWOYMxmv3HLAqD0Xnvu0s2nxc3cUau8voRRB9O4M0Mg2heGcaPdoVo
 m5wQ4EnUCCHSjFBrudtfi8bC8gJXQ5pE/8RVREh78kwiGLQhTiISdimEhi4YBaXP
 8l76Gg+Psgum5AMoN8s3QZSwtM5qOWRHV6KI3LKz7kUeN5tWGIXRLLd0INykF2hd
 UAFRx1DhOrBia6XynlZuLfoSkgPGMRBshEb9Ynnj9FGC3yzBZppDJuB3ZDWAdpPw
 pg1HnwSHOQ82eY6W7XDiHc5dcHDknLrZT4UYHBCj3tNQxHx9vCg25iJJdp75xeRw
 ==
X-ME-Sender: <xms:JKIcYeMn-Flxis_Beg5uf69n-wrVz8g6nI6uEIXPnMe27g6i9tVwsQ>
 <xme:JKIcYc8JuSngoPZAwN6aaUrPj995gLUQoiTuJ4TmPrPSnCy_zKTx-bEE35bp-aSf7
 eNbTxxRhK5eFGmyGqk>
X-ME-Received: <xmr:JKIcYVR_zYZ5Es_U8kcZK4Y1va3OZL4mwVwvwaRSAC-VAiy7MofXGzVqz_rvGi5hj5d61zfmeKpexHD-w2dszTwkJ180x9WpBt6cY3mpJ_2Uhe-oLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeggdellecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:JKIcYesaOISqVT5aurYvHd_XHkN1h8oPgbDtld2N_Uea7ck45ialoQ>
 <xmx:JKIcYWdc-orv7uxjh9K4PevQCRHwKej6iSt7zB73WzYdxnKUmOx0HQ>
 <xmx:JKIcYS1-eB0bLwoeWL5NcU2xrNknUC78Z1nLx1EcvT9VV6a2rEM7zQ>
 <xmx:JaIcYZuO3hnfG5CzqPpeIAcvsanBYxfmDkQgYWkI3_PI9QffKxRbc1E9c98>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 02:01:05 -0400 (EDT)
Date: Wed, 18 Aug 2021 08:01:03 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, stefanha@redhat.com,
 fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, linux-nvme@lists.infradead.org,
 k.jensen@samsung.com, javier.gonz@samsung.com,
 mohit.kap@samsung.com, d.palani@samsung.com, prakash.v@samsung.com,
 jg123.choi@samsung.com, u.kishore@samsung.com, arun.kka@samsung.com
Subject: Re: [RFC PATCH: v3 1/2] add mi device in qemu
Message-ID: <YRyiH7aLzBh/Cko5@apples.localdomain>
References: <CGME20210803080737epcas5p1c9bd6ecde8700d1194748533a3812db6@epcas5p1.samsung.com>
 <1627975487-1640-1-git-send-email-p.kalghatgi@samsung.com>
MIME-Version: 1.0
In-Reply-To: <1627975487-1640-1-git-send-email-p.kalghatgi@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_230117_402152_39D0CCC5 
X-CRM114-Status: GOOD (  19.08  )
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
Content-Type: multipart/mixed; boundary="===============3259391329447826698=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============3259391329447826698==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zk20PYG4ooyImfh6"
Content-Disposition: inline


--zk20PYG4ooyImfh6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug  3 12:54, Padmakar Kalghatgi wrote:
> From: padmakar <p.kalghatgi@samsung.com>
>=20
> This patch contains the implementation of certain commands=20
> of nvme-mi specification.The MI commands are useful to
> manage/configure/monitor the device.Eventhough the MI commands
> can be sent via the inband NVMe-MI send/recieve commands, the idea=20
> here is to emulate the sideband interface for MI.
>=20
> The changes here includes the interface for i2c/smbus=20
> for nvme-mi protocol. We have used i2c address of 0x15
> using which the guest VM can send and recieve the nvme-mi
> commands. Since the nvme-mi device uses the I2C_SLAVE as
> parent, we have used the send and recieve callbacks by
> which the nvme-mi device will get the required notification.
> With the callback approach, we have eliminated the use of=20
> threads.=20
>=20
> One needs to specify the following command in the launch to
> specify the nvme-mi device, link to nvme and assign the i2c address.
> <-device nvme-mi,nvme=3Dnvme0,address=3D0x15>
>=20
> This module makes use of the NvmeCtrl structure of the nvme module,
> to fetch relevant information of the nvme device which are used in
> some of the mi commands. Eventhough certain commands might require
> modification to the nvme module, currently we have currently refrained
> from making changes to the nvme module.
>=20
> cmd-name                              cmd-type
> *************************************************
> read nvme-mi ds                        nvme-mi
> configuration set                      nvme-mi
> configuration get                      nvme-mi
> vpd read                               nvme-mi
> vpd write                              nvme-mi
> controller Health Staus Poll           nvme-mi
> nvme subsystem health status poll      nvme-mi
> identify                               nvme-admin
> get log page                           nvme-admin
> get features                           nvme-admin
>=20
> Signed-off-by: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
> Reviewed-by: Klaus Birkelund Jensen <k.jensen@samsung.com>
> Reviewed-by: Jaegyu Choi <jg123.choi@samsung.com>
>=20

My Reviewed-by here was added by mistake. I've not given it my formal
R-b, but I'll provide a proper review on-list ASAP.

But just glossing over it, I like this approach a lot better than v1
(vsock).

--zk20PYG4ooyImfh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmEcohsACgkQTeGvMW1P
DekCcAf/e3ez63dluPzli+KxhybVCfNu8rppjSI/dA9t2ZHcKrU75W23S0h8d9vc
QF5I3rbdpuJe0Umc2J44nAhyE5y8QhB3FClHGaFIjvMAQLtnSY0m46Bk4/iyF3hA
4pfdWVHKHhbxZvFs4Y2nCOcjKGvPKuJOHLI0TXIq9UaTCmFFbOOT7yUqnUscrOW3
sDcqd+ieQ/sQeZQ0OMDLQVWbD8B91Vq6KDiXQOFUWAbwVZVVSu5CLnngpIrAvVxz
QiTPkmmqf4oOO/jU/nL/qYdgd7PYXm6iXBfUtOgwUfZtOZXbc9z7uYLd8WHK89DB
tjj2p3oCeMwWZ5gYYVUtonB6Kdkr0w==
=p25e
-----END PGP SIGNATURE-----

--zk20PYG4ooyImfh6--


--===============3259391329447826698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============3259391329447826698==--

