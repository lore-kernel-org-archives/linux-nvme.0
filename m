Return-Path: <SRS0=ZTQI=NK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EA7C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:33:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F996112D
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 14:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 32F996112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+gPZR9ANeRwZpTQU7I1PjJryXNnRk/Rx9gdicob7M8=; b=u+xl1RNMIaaTGRKFBQuGkNZP+x
	aF4DTaUJ+BwPSUTM9pTmrCAcQr12SSdKcYScyUxc7JfuUWuONRq0HFV4a6hdoH9oWcWUNd9hRjjvu
	DuFuBrV2Oo/qJA8GwkoSISfDTYLvlN5BZQe12+/vCPqvWxRopBiq4wxCtOC2oUc50z5arTDYPs8sK
	iEjFUWbjPSpA99iDbIycXbzHb8tajhgR8y0nxFOxRSFjeO70ESTGka1dpbY3cmiQiU34pGiojSqST
	dj0A9IbgSGiv7rWD+zAVZfyrtW2ZwjRI2vyLiNS2TeoYKOzvYC4fMMY4RzDRtXksKUn0+3YJpyW15
	WhNb6C0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGj6U-008f6G-GU; Thu, 19 Aug 2021 14:33:10 +0000
Received: from new2-smtp.messagingengine.com ([66.111.4.224])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGj6O-008f4c-Bk
 for linux-nvme@lists.infradead.org; Thu, 19 Aug 2021 14:33:09 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 553C8580A24;
 Thu, 19 Aug 2021 10:33:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 19 Aug 2021 10:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=TFpBk3d70DReYz8r6I46rFbHUZF
 XUKYL87UuOG/gfR8=; b=LOGcQW9sdPtZr6FkBZs0237Zek2erMmPAgrPLpRImLC
 THaYqxW5sKGKSLyrwWXx5ZQeVcPkABDk/KZcS1UhB4NQxZBNHBD0NgPyloAz40Bk
 bfiZGuuxRsQjR40QzlTzZnGnu6747SnuQhLQO2X85GbT7DljvpFF59l/RGxOnr1q
 S0XDrDxAoocSMGC2NCAALWrdi7kscYs4yPbzGNPi6yAC5Psg7ngs0Tu5JUQB/uAX
 MeBvsy9pe6bxEwaN+q0V8KVfax9hOk8LikGpkk4yeM6oFdqKR5LwkLYufjs/UalC
 zPVsmZinRFlV6HORQj/eI9ACt5iX6zQuvce7Zvc+a9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TFpBk3
 d70DReYz8r6I46rFbHUZFXUKYL87UuOG/gfR8=; b=BzqIEVsdTW+GLPpMRcc6F9
 Qiabz4669M/ZF3KDa+oVL2mIndEHAdoRehva2y4mvNiYv12rBbMdh2ZC1ZBskG/q
 /caIvvuZ35JVouvP4kXn4ss06NkdFcBheMCjuCDHFL7EoqG2OksvZDFyzho+/Ajh
 M/1vrwUORx1VgL/mTEEawIKI4uO7ZUnLDtOnx8rNy0BSydA8ij/UtSOKazVw9MDG
 fG8BX8D1hIgsDLPtsy8jBQnZQvafmwfjqRXkYL8cLzaPJUTn21STjMn7mV9zTkqh
 Wo60Od32E7AONFIr6+rbnYv4lBiJKfS64kv6cvh0r0Tbkhl44jUKYpd+efVmcVxw
 ==
X-ME-Sender: <xms:mWseYcoBfj10nFZq8PxwT8y-CfxNKqsybz_f-2D0LnznQGkZU8MFmg>
 <xme:mWseYSpbcH4WodktpTo09dfneAIumTaWfMLnGo8B3QVBCnRL6zUnX724pnL5ipglM
 5EKtTdKqkeykEOU19E>
X-ME-Received: <xmr:mWseYRPl1jVxX6pD4odOa3-03giqtKDEDGpTRxCE0lCTOgfOoRLXpgfO7iJSmAm4GCljwbQubWP_x7w4479__U514FpLAUVUWsBzi-IjTTbst5XZvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdejhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:mWseYT4Htupkxfd0a4d7pKn7qbqD9Pq-a_U1fnR4b3QYvvA7ZoYeSw>
 <xmx:mWseYb6NbieljA7WhRZHIGTOkTB74qNnN0VZOJo1puObOxeCCijqbw>
 <xmx:mWseYTiqeQ2dlwnQEvEeJhzi_dvlGzxVMLqNAzUktwhnoVN915OUxA>
 <xmx:nGseYfoyGtxfBqaj9rSXS1uqndEY4tneyV1i9FMdX8rfpVspNgbDpg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 10:32:55 -0400 (EDT)
Date: Thu, 19 Aug 2021 16:32:52 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Naveen Nagar <naveen.n1@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, stefanha@redhat.com,
 fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, linux-nvme@lists.infradead.org,
 k.jensen@samsung.com, p.kalghatgi@samsung.com,
 raphel.david@samsung.com, d.palani@samsung.com,
 prakash.v@samsung.com, jg123.choi@samsung.com,
 anuj.singh@samsung.com, anaidu.gollu@samsung.com
Subject: Re: [RFC PATCH v2] hw/nvme:Adding Support for namespace management
Message-ID: <YR5rlHYZNRLa5Sxl@apples.localdomain>
References: <CGME20210819135248epcas5p1fcc9f399f16a5336e6af004170a0eea4@epcas5p1.samsung.com>
 <1629378597-30480-1-git-send-email-naveen.n1@samsung.com>
MIME-Version: 1.0
In-Reply-To: <1629378597-30480-1-git-send-email-naveen.n1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210819_073304_723213_E3550534 
X-CRM114-Status: GOOD (  16.84  )
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
Content-Type: multipart/mixed; boundary="===============5674632554187927519=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============5674632554187927519==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4CwuXjTjluigJgOL"
Content-Disposition: inline


--4CwuXjTjluigJgOL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 19 18:39, Naveen Nagar wrote:
> From: Naveen <naveen.n1@samsung.com>
>=20
> This patch supports namespace management : create and delete operations.
>=20
> Since v1:
> - Modified and moved nvme_ns_identify_common in ns.c file=20
> - Added check for CSI field in NS management
> - Indentation fix in namespace create
>=20
> This patch has been tested with the following command and size of image
> file for unallocated namespaces is taken as 0GB. ns_create will look into
> the list of unallocated namespaces and it will initialize the same and=20
> return the nsid of the same. A new mandatory field has been added called
> tnvmcap and we have ensured that the total capacity of namespace created
> does not exceed tnvmcap
>=20
> -device nvme-subsys,id=3Dsubsys0,tnvmcap=3D8
> -device nvme,serial=3Dfoo,id=3Dnvme0,subsys=3Dsubsys0
> -device nvme,serial=3Dbar,id=3Dnvme1,subsys=3Dsubsys0
> -drive id=3Dns1,file=3Dns1.img,if=3Dnone
> -device nvme-ns,drive=3Dns1,bus=3Dnvme0,nsid=3D1,zoned=3Dfalse,shared=3Dt=
rue
> -drive id=3Dns2,file=3Dns2.img,if=3Dnone
> -device nvme-ns,drive=3Dns2,bus=3Dnvme0,nsid=3D2,zoned=3Dfalse,shared=3Dt=
rue
> -drive id=3Dns3,file=3Dns3.img,if=3Dnone
> -device nvme-ns,drive=3Dns3,bus=3Dnvme0,nsid=3D3,zoned=3Dfalse,shared=3Dt=
rue
> -drive id=3Dns4,file=3Dns4.img,if=3Dnone
> -device nvme-ns,drive=3Dns4,bus=3Dnvme0,nsid=3D4,zoned=3Dfalse,shared=3Dt=
rue
>=20
> Please review and suggest if any changes are required.
>=20
> Signed-off-by: Naveen Nagar <naveen.n1@samsung.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>  =20

Woops.

Looks like you sent it to the wrong mailing list - I'd be happy to
comment on this on qemu-{block,devel} instead :)

--4CwuXjTjluigJgOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmEea5EACgkQTeGvMW1P
Del6vwf9Ge4UvU3bKf3BL7Ffk2sA9rrzQ8X9bUp7/72q6a0oph5h3cyFSKiMIqvm
TscMd06/stsNhi7o6/+UyTVRo/hlK7UG9c9847Aonow7xL0wsd2+zBwQCl2DogBk
61h8cEdUfSQ+UTJBUCWrTcxVu8EzqSubJhhNdrV69QvytuFxMXHPTssGkh59TFyY
A4o8Y2xoR9Tkfhr+TsNVR5x1Qciyn1AQJgJjgTmXziP/6qXr2IuHMmHVEHZfMVGJ
1yew5kJOJ2zgRmPlW70CEURcbRrH88lFCZISMQTtHp/IQnAZoL7FjYXgBU0apxsG
lwFnw5hriqP+D7T3Ow0Qdc/jeqsW+Q==
=7GE0
-----END PGP SIGNATURE-----

--4CwuXjTjluigJgOL--


--===============5674632554187927519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============5674632554187927519==--

