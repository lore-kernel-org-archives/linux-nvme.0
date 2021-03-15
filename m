Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8955EC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 11:20:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8A864DDF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 11:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8A864DDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Lt2AjEWeJ9V1//+KFvQZZTbwYeKiFg+7YhJ10qhf/CM=; b=Eozxsp9xS79xxYERS0O3Lq0rX
	+imamtxYi7M0fVQOw0L+2LCmGLh2mOiM8vdGGejHowjl4CmKkeDLS2zFqWARnQ1q+ukL25wrXNANP
	s/CiPDw98HZYTsbiEw3GY/1Fkb8bnVpiihFx7xNwa3BAAJKHiRFYF0+f4HCPVEXxfPJ8BykEWtfQk
	hXZQBwf8g0WUboy3qYsTQrnZ5IzQTRE9NkAmqDuzX/pDuy4wLq7sNR8tVMU6JOQF6grAC27y2c3vb
	xIyJkxn/L2G6hCxHV3wDGCOZKUuo72hx0NBg8ZJ657CR1dseIIOlJj6mh4mMbRP/5z3Ur+7ZH2pgX
	kCkOclSYg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLlGU-00FeS3-QP; Mon, 15 Mar 2021 11:20:03 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLlGD-00FePx-BM
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 11:19:56 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 618341763;
 Mon, 15 Mar 2021 07:19:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 15 Mar 2021 07:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=1yhy3maK4fxTbkge2fiYpL318eK
 QWW7BaceuI5SbPvQ=; b=SN4sD+ihLiZ96HDqrPhWoHFNsJzL0Rc8zpE264wQnLW
 noYYsyO4aUERGBvGBRb0zDjRtzaXBpv7aQ2DwOyrhjfsdhnlopDHhtswZmUpnyuS
 CG0r1S6puJjhH7YuuEtTp8zxFUe9qXACX2nqosShKeh52PR1R/MC1YwS33veauyn
 JGnikfIDdM+u7H28eIVA7TJpJyHpWywEE32ar/PxKlvONHJn4eiG08DrVUdeAPnC
 0ruEZ84DVYEma1Sq0zSpkFbcQU1eP+KoxeIyYOzQmB1KBKsdj5AP+2nnoWmOrFIC
 nd6N+4qKLZ7yBvLhfjLPHLgvDzowDLbpCvYCMg6GbRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1yhy3m
 aK4fxTbkge2fiYpL318eKQWW7BaceuI5SbPvQ=; b=FzB1oCnCA+n2Gu6qCG9KvS
 paGlOfErK0/vHdAgc0S+/FAz55Lc4HpK6o90Blhn8L2yHE3MUBbBoyKwyxPCIRKB
 YW/hp3JCVLiCkWvs5HNZJmJ1os6ehvrPCNixq2O1ZEECsgSPxK5dmKWHn4FYVJuw
 AjamzdTxIDcWqM42IzRUYMkzSprJWKJpaYD3FdTldJ1TPBF1rRgt7tEYboC7+YSp
 pWJPLvLIkt5rpjiVhSfruqMq1W3LmpAHvOliuB0qk7YAdUc49IGtZb9PjIQpdCgF
 ZeBHilbgtsFvzjmc32cy2z+Po9lNA879YpntiOnFsCjU4+onAtgaWIMrvM5hf9OQ
 ==
X-ME-Sender: <xms:xkJPYLOPqaDskzwMKQWgjA2wY18mJIw2iuK-PmC1pj5Ran2K13eAeA>
 <xme:xkJPYF8dR7plLrmGtqhndtOAXuj9m8Pp6biB7gGDmqrYaDFsJIupSxTE3DSF4fleH
 B-QOWbSfYV5mkQi0ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledgvdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:xkJPYKQzn6HgB3PBec4nCIZQitEYvLLISl4C0GtxsRkJ-XZmTecNPQ>
 <xmx:xkJPYPvAQfHadpcyNH-7p5TY8hGvhYYf7NwlQYPyZKvZ3VwXeZW3uA>
 <xmx:xkJPYDdxCJp6EeduUYPsVajZl8Dms1vs0B4JisN79ZNiyzpxyLsRpA>
 <xmx:yEJPYErOJVxSadTakec_a1u2lNFYW0WmMMSXS7DdigUdOmp9Qk1ieQ>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2DC7D240054;
 Mon, 15 Mar 2021 07:19:34 -0400 (EDT)
Date: Mon, 15 Mar 2021 12:19:32 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: keith.busch@wdc.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix Write Zeroes limitations
Message-ID: <YE9CxMtczo1mY6gN@apples.localdomain>
References: <20210315093438.66082-1-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20210315093438.66082-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_111953_109007_A2E98CB5 
X-CRM114-Status: GOOD (  24.84  )
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
Content-Type: multipart/mixed; boundary="===============7829133179792560536=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============7829133179792560536==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wi8+hlvAixRArCBo"
Content-Disposition: inline


--Wi8+hlvAixRArCBo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 15 10:34, Christoph Hellwig wrote:
> We voluntarily limit the Write Zeroes sizes to the MDTS value provided by
> the hardware, but currently get the units wrong, so fix that.
>=20
> Fixes: 6e02318eaea5 ("nvme: add support for the Write Zeroes command")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 82ad5eef9d0c30..1bd18d7f53b316 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1964,30 +1964,18 @@ static void nvme_config_discard(struct gendisk *d=
isk, struct nvme_ns *ns)
>  		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
>  }
> =20
> -static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_n=
s *ns)
> +/*
> + * Even though NVMe spec explicitly states that MDTS is not applicable t=
o the
> + * write-zeroes, we are cautious and limit the size to the controllers
> + * max_hw_sectors value, which is based on the MDTS field and possibly o=
ther
> + * limiting factors.
> + */
> +static void nvme_config_write_zeroes(struct request_queue *q,
> +		struct nvme_ctrl *ctrl)
>  {
> -	u64 max_blocks;
> -
> -	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
> -	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
> -		return;
> -	/*
> -	 * Even though NVMe spec explicitly states that MDTS is not
> -	 * applicable to the write-zeroes:- "The restriction does not apply to
> -	 * commands that do not transfer data between the host and the
> -	 * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
> -	 * In order to be more cautious use controller's max_hw_sectors value
> -	 * to configure the maximum sectors for the write-zeroes which is
> -	 * configured based on the controller's MDTS field in the
> -	 * nvme_init_identify() if available.
> -	 */
> -	if (ns->ctrl->max_hw_sectors =3D=3D UINT_MAX)
> -		max_blocks =3D (u64)USHRT_MAX + 1;
> -	else
> -		max_blocks =3D ns->ctrl->max_hw_sectors + 1;
> -
> -	blk_queue_max_write_zeroes_sectors(disk->queue,
> -					   nvme_lba_to_sect(ns, max_blocks));
> +	if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
> +	    !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
> +		blk_queue_max_write_zeroes_sectors(q, ctrl->max_hw_sectors);
>  }
> =20
>  static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
> @@ -2159,7 +2147,7 @@ static void nvme_update_disk_info(struct gendisk *d=
isk,
>  	set_capacity_and_notify(disk, capacity);
> =20
>  	nvme_config_discard(disk, ns);
> -	nvme_config_write_zeroes(disk, ns);
> +	nvme_config_write_zeroes(disk->queue, ns->ctrl);
> =20
>  	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
>  		test_bit(NVME_NS_FORCE_RO, &ns->flags));
> --=20
> 2.30.1
>=20

LGTM.

Tested-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--Wi8+hlvAixRArCBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmBPQrQACgkQTeGvMW1P
DenCXgf9HIUj/qCpUCVscoD31kQjuaEZDhvaZuRffPUq63J16hViJihCcC156EDc
dpAC9xhts1RgYyHyU8jttxRVlibNNnjE2fl3rtlKdjBHte4gfrVXLlx1GgrqX5n9
QyU1sEjh+0Kw1kF/Q1uqsRIjVwMeUP45+fY+/vSfUMZVToOLuBWek0syPDaad4k0
k1CdEmA/hsDqaDx2pBXf9WubAZEwIxpR0Y7WwLFvSvvspnV4hZpZ2RiZPNP7+kBu
3p6eYxIazGMKk1NUmwQaJjv7p5+tPm8UNg/fxS42gL2+QY1mNZ8YRB1JeWt0Ij7R
czFTwhxj6FTLlr8EHn41LYd2a0NkUg==
=V2+8
-----END PGP SIGNATURE-----

--Wi8+hlvAixRArCBo--


--===============7829133179792560536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7829133179792560536==--

