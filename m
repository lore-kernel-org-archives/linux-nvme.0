Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2445DC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g3nB/YPH+4tQfs79Od+5OZ1d3O1m+a3hoofdte7zHSg=; b=K2eFkk3NmMjcetimoQM8EWez3X
	xvJ+zuFwaaVWGENn60cBN8Iw16jVZXmEM6jnPFYLOMIcSGnXbCyZXmSjyRK85rmG+XiOpjjp/jMBL
	jQaE7ohQnNJVQKZd7qXRo8q1eH7HakYmMHaX376+7cvvgW0H9QJukVF2k1MouYi6yz9jKG0Sis6NU
	AhwBnjdXHpKbaOOtJue7dwUaujbd2PfYfa5La/3cAWgQ6aZjvuKxtj+YzFMHBzCe2TZg97NIfW7F1
	Msili2bsUrUMvEVMQWN8OEqlR2AiNoXo8TaYRKIDEeDy1S2BV6c3LnIlA2rvPy88fnTl2VddBkE93
	uyG6HfXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o67ot-005a0F-16; Tue, 28 Jun 2022 09:47:43 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o67op-005ZxF-Gl
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 09:47:42 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220628094728euoutp019d71b489acf529901d43ce39540338ac~8v8ykRAon1125911259euoutp01y;
	Tue, 28 Jun 2022 09:47:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220628094728euoutp019d71b489acf529901d43ce39540338ac~8v8ykRAon1125911259euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1656409648;
	bh=g3nB/YPH+4tQfs79Od+5OZ1d3O1m+a3hoofdte7zHSg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uTunGLwqTR1VVmr+rjX5jQmDTe8S9vFuQydTiJ5BY1iuMNLv1dySgici7LHhbVolb
	 uNrSfZHXygcfNbt/9ROdDyKUrAZKXMgAK6rvKfi0/tVdgfy3XY2ZpChs0+Fj/WI7t9
	 bNFw8f6vFFkQzR4B7/2cgNbV7OogWlnunOfY4pHk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220628094728eucas1p199c5fefac50a45269c38650522ac26a2~8v8yStIlw2429324293eucas1p1e;
	Tue, 28 Jun 2022 09:47:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 7D.9B.10067.03ECAB26; Tue, 28
	Jun 2022 10:47:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220628094727eucas1p1b1eef2bd4820ae8d8a598115cad57684~8v8x2lFtr2655426554eucas1p14;
	Tue, 28 Jun 2022 09:47:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220628094727eusmtrp24c9975af12a09193a2c9e9781b0e4b5d~8v8x14ty82805728057eusmtrp2K;
	Tue, 28 Jun 2022 09:47:27 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-9d-62bace30fde2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.5C.09095.F2ECAB26; Tue, 28
	Jun 2022 10:47:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220628094727eusmtip20e4fb9e0363dc86eaae778de841e5783~8v8xpVYzP2924729247eusmtip2-;
	Tue, 28 Jun 2022 09:47:27 +0000 (GMT)
Received: from localhost (106.210.248.99) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 28 Jun 2022 10:47:26 +0100
Date: Tue, 28 Jun 2022 11:47:24 +0200
From: Joel Granados <j.granados@samsung.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: <hch@lst.de>, <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
	<joshi.k@samsung.com>, <gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: Re: [PATCH v3 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <20220628094724.usxu2iyehabysqqj@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="z5bqyyhidcotd24b"
Content-Disposition: inline
In-Reply-To: <87909773-4430-e44f-bd8e-81d4c32b8704@grimberg.me>
X-Originating-IP: [106.210.248.99]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7oG53YlGVw6zm+xcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAliiuGxSUnMyy1KL9O0SuDKuzVAs
	aAyruL63h6mB8bhLFyM7h4SAicRd6S5GLg4hgRWMEnP/PWfpYuQEcr4wSuy+rQOR+Mwo8b33
	ETNIAqR+3o537BCJ5YwSi9pPscJVTT49ixmifQujRPPfvC5GDg4WAVWJG6+cQcJsAjoS59/c
	YQYJiwioSLx5kwvSyiwwgVHi47G/rCA1wgJJEj8b2thBbF4Bc4nrR86xQdiCEidnPgG7jlmg
	QmLGwiNsIHOYBaQllv/jAAlzCthLfN20hgXiTiWJcw3NTBB2rcSpLbeYQHZJCPznkNh3+jfU
	My4Sfdu+sUPYwhKvjm+BsmUk/u+cD9WcLbFzyi6o+gKJWSengu2VELCW6DuTAxF2lFh56xET
	RJhP4sZbQYgr+SQmbZvODBHmlehoE4KoVpPY0bSVcQKj8iwkf81C8tcshL8gwjoSC3Z/whTW
	lli28DUzhG0rsW7de5YFjOyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxApPS6X/Hv+xg
	XP7qo94hRiYOxkOMKkDNjzasvsAoxZKXn5eqJMK78MzOJCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1MZr3RV351RAgs27PT9GHsqor3oo5S62w6ZOTV
	lnqUFh3vVr6f5n469qPWOckJe+QVkwuXSntu0Ps2YT3bKb4J5WfWv9xgM38b//T1qT36MXNa
	W6b5OJjx7npy1NXjtdWGSad6Ps3yfDVT/OWWq8rKhqWiLKY3PFbEBC8458uqM9f9Ulb/Q0aH
	F1fuTlq7b06CuG7brcJK2dduf/3EFyWna0+aOqHM7Wht05ct2frNZ+fEXSp5P/GK1Il9F/rs
	uVbd6Zsf4rAxduMZrerL7Vs0bvwyr7/ukHPj1sH2T3qbuoSSd2ht70mr2fAxUvvTrS+hKzc9
	+WfzviNyRauuq3XQtpeVzxIjcvl6TmVZTVzCpsRSnJFoqMVcVJwIAI05iBrFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7r653YlGTRf0rZYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlzWzeyF/wPrfiyI7uB8ahLFyMnh4SA
	icS8He/Yuxi5OIQEljJKzD78jBEiISPx6cpHdghbWOLPtS42iKKPjBKHPp9kgXC2MEq0zf0L
	VMXBwSKgKnHjlTNIA5uAjsT5N3eYQcIiAioSb97kgpQzC0xglPh47C8rSI2wQJLEz4Y2sAW8
	AuYS14+cg1rwi1Hi4tdlzBAJQYmTM5+wgNjMAmUSLd+awXYxC0hLLP/HARLmFLCX+LppDQvE
	oUoS5xqamSDsWonPf58xTmAUnoVk0iwkk2YhTIIIa0nc+PeSCUNYW2LZwtfMELatxLp171kW
	MLKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzTbcd+bt7BOO/VR71DjEwcjIcYVYA6H21Y
	fYFRiiUvPy9VSYR34ZmdSUK8KYmVValF+fFFpTmpxYcYTYGBOJFZSjQ5H5hA8kriDc0MTA1N
	zCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamAobwrTZZxt4JFmrBnwoy/g04/m3
	Zay2JSmf11gunb9I1VXotsKF4IDzjHc/1rxsEC9esL8oJi3M2GHJiwa+O4LJwS86eu4Hi0xt
	crmw8cPpaVf15t5d5mK//9PqE0X2/q1tHAvKNZ53T9q165UMQ6LdJLY8brem5L4vPJKK7tmz
	e/41OBY8ZCwXXHj0+nPxEwor32a9n724VSHivbG3x+ePu27zOyQuuG4Scdm3i+/w3sii7I9T
	hIpiOr8+eGL+3HDTkrQbP56de79x8wKPgsAdTVdDTk61m9qu/bk491TEAQefI6vW3JPODEzY
	Zvj0H9fdJan/zWxycj7vNJzz3fNqQdyN6ieTXD8nTjLX/qjEUpyRaKjFXFScCACV4T4FaAMA
	AA==
X-CMS-MailID: 20220628094727eucas1p1b1eef2bd4820ae8d8a598115cad57684
X-Msg-Generator: CA
X-RootMTR: 20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7
References: <20220622135556.2185991-1-j.granados@samsung.com>
	<CGME20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7@eucas1p1.samsung.com>
	<20220622135556.2185991-3-j.granados@samsung.com>
	<87909773-4430-e44f-bd8e-81d4c32b8704@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_024740_029402_37EAD63F 
X-CRM114-Status: GOOD (  39.19  )
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

--z5bqyyhidcotd24b
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 26, 2022 at 04:53:32PM +0300, Sagi Grimberg wrote:
>=20
>=20
> On 6/22/22 16:55, Joel Granados wrote:
> > Extend nvme_alloc_ns() and nvme_validate_ns() for unknown command-set as
> > well. Both are made to use a new helper (nvme_update_ns_info_cs_indep)
> > which is similar to nvme_update_ns_info but performs fewer operations
> > to get the generic interface up.
> >=20
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > ---
> >   drivers/nvme/host/core.c | 132 +++++++++++++++++++++++++++------------
> >   1 file changed, 93 insertions(+), 39 deletions(-)
> >=20
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 0fd6127da8d1..03ba3d0f4d3a 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1908,6 +1908,34 @@ static void nvme_set_chunk_sectors(struct nvme_n=
s *ns, struct nvme_id_ns *id)
> >   	blk_queue_chunk_sectors(ns->queue, iob);
> >   }
> > +static int nvme_update_ns_info_cs_indep(struct nvme_ns *ns,
> > +					struct nvme_id_ns_cs_indep *id)
> > +{
> > +	blk_mq_freeze_queue(ns->disk->queue);
> > +	nvme_set_queue_limits(ns->ctrl, ns->queue);
> > +	set_disk_ro(ns->disk, (id->nsattr & NVME_NS_ATTR_RO) ||
> > +		test_bit(NVME_NS_FORCE_RO, &ns->flags));
> > +	blk_mq_unfreeze_queue(ns->disk->queue);
> > +
> > +	if (nvme_ns_head_multipath(ns->head)) {
> > +		blk_mq_freeze_queue(ns->head->disk->queue);
> > +		set_disk_ro(ns->head->disk,
> > +			    (id->nsattr & NVME_NS_ATTR_RO) ||
> > +				    test_bit(NVME_NS_FORCE_RO, &ns->flags));
> > +		nvme_mpath_revalidate_paths(ns);
> > +		blk_stack_limits(&ns->head->disk->queue->limits,
> > +				 &ns->queue->limits, 0);
> > +		ns->head->disk->flags |=3D GENHD_FL_HIDDEN;
> > +		blk_mq_unfreeze_queue(ns->head->disk->queue);
> > +	}
>=20
> We can probably share this code with the existing update_ns_info ?

There are three differences in the multipath section of these two functions:
1. The command-set-indep does not call nvme_update_disk_info
2. The command-set-indep does not call disk_update_readahead
3. The command-set-indep hides the device "GENHD_FL_HIDDEN" at the end

I'll add a function that gathers the three common lines.
Something like this:

static inline void nvme_update_ns_mpath_info_general(struct nvme_ns *ns, __=
u8 nsattr)
{
  set_disk_ro(....)
  nvme_mpath_revalidate_paths(...)
  blk_stack_limits(...)
}

>=20
> > +
> > +	/* Hide the block-interface for these devices */
> > +	ns->disk->flags |=3D GENHD_FL_HIDDEN;
> > +	set_bit(NVME_NS_READY, &ns->flags);
> > +
> > +	return 0;
> > +}
> > +
> >   static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns =
*id)
> >   {
> >   	unsigned lbaf =3D nvme_lbaf_index(id->flbas);
> > @@ -3951,15 +3979,29 @@ static void nvme_ns_add_to_ctrl_list(struct nvm=
e_ns *ns)
> >   }
> >   static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> > -		struct nvme_ns_ids *ids)
> > +		struct nvme_ns_ids *ids, struct nvme_id_ns_cs_indep *indep_id)
> >   {
> > +	int ret =3D 0;
> >   	struct nvme_ns *ns;
> >   	struct gendisk *disk;
> > -	struct nvme_id_ns *id;
> > +	struct nvme_id_ns *id =3D NULL;
> >   	int node =3D ctrl->numa_node;
> > +	__u8 *nmic;
> > +	__le32 *anagrpid;
> > -	if (nvme_identify_ns(ctrl, nsid, ids, &id))
> > -		return;
> > +	switch (ids->csi) {
> > +	case NVME_CSI_NVM:
> > +	case NVME_CSI_ZNS:
> > +		if (nvme_identify_ns(ctrl, nsid, ids, &id))
> > +			return;
> > +		nmic =3D &id->nmic;
> > +		anagrpid =3D &id->anagrpid;
> > +		break;
> > +	default:
> > +		nmic =3D &indep_id->nmic;
> > +		anagrpid =3D &indep_id->anagrpid;
> > +		break;
> > +	}
> >   	ns =3D kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
> >   	if (!ns)
> > @@ -3984,7 +4026,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl,=
 unsigned nsid,
> >   	ns->ctrl =3D ctrl;
> >   	kref_init(&ns->kref);
> > -	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
> > +	if (nvme_init_ns_head(ns, nsid, ids, *nmic & NVME_NS_NMIC_SHARED))
> >   		goto out_cleanup_disk;
> >   	/*
> > @@ -4010,7 +4052,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl=
, unsigned nsid,
> >   			ns->head->instance);
> >   	}
> > -	if (nvme_update_ns_info(ns, id))
> > +	switch (ids->csi) {
> > +	case NVME_CSI_NVM:
> > +	case NVME_CSI_ZNS:
> > +		ret =3D nvme_update_ns_info(ns, id);
> > +		break;
> > +	default:
> > +		ret =3D nvme_update_ns_info_cs_indep(ns, indep_id);
> > +		break;
> > +	}
> > +	if (ret)
> >   		goto out_unlink_ns;
> >   	down_write(&ctrl->namespaces_rwsem);
> > @@ -4024,11 +4075,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctr=
l, unsigned nsid,
> >   	if (!nvme_ns_head_multipath(ns->head))
> >   		nvme_add_ns_cdev(ns);
> > -	nvme_mpath_add_disk(ns, id->anagrpid);
> > +	nvme_mpath_add_disk(ns, *anagrpid);
> >   	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
> > -	kfree(id);
> > -	return;
> > +	goto out_free_id;
> >    out_cleanup_ns_from_list:
> >   	nvme_put_ctrl(ctrl);
> > @@ -4106,29 +4156,32 @@ static void nvme_ns_remove_by_nsid(struct nvme_=
ctrl *ctrl, u32 nsid)
> >   	}
> >   }
> > -static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *i=
ds)
> > +static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *i=
ds,
> > +			     struct nvme_id_ns_cs_indep *indep_id)
> >   {
> > -	struct nvme_id_ns *id;
> > +	struct nvme_id_ns *id =3D NULL;
> >   	int ret =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
> >   	if (test_bit(NVME_NS_DEAD, &ns->flags))
> >   		goto out;
> > -	ret =3D nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
> > -	if (ret)
> > -		goto out;
> > -
> > -	ret =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
> > -	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
> > -		dev_err(ns->ctrl->device,
> > -			"identifiers changed for nsid %d\n", ns->head->ns_id);
> > -		goto out_free_id;
> > +	switch (ids->csi) {
> > +	case NVME_CSI_NVM:
> > +	case NVME_CSI_ZNS:
> > +		if (nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id))
> > +			goto out;
> > +		if (!nvme_ns_ids_equal(&ns->head->ids, ids))
> > +			dev_err(ns->ctrl->device,
> > +				"identifiers changed for nsid %d\n", ns->head->ns_id);
> > +		else
> > +			ret =3D nvme_update_ns_info(ns, id);
> > +		kfree(id);
> > +		break;
> > +	default:
> > +		ret =3D nvme_update_ns_info_cs_indep(ns, indep_id);
> > +		break;
> >   	}
> > -	ret =3D nvme_update_ns_info(ns, id);
> > -
> > -out_free_id:
> > -	kfree(id);
> >   out:
> >   	/*
> >   	 * Only remove the namespace if we got a fatal error back from the
> > @@ -4143,36 +4196,34 @@ static void nvme_validate_ns(struct nvme_ns *ns=
, struct nvme_ns_ids *ids)
> >   static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigne=
d nsid)
> >   {
> >   	struct nvme_ns_ids ids =3D { };
> > -	struct nvme_id_ns_cs_indep *id;
> > +	struct nvme_id_ns_cs_indep *id_indep;
> >   	struct nvme_ns *ns;
> > -	bool ready =3D true;
> >   	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
> >   		return;
> > +	if (nvme_identify_ns_cs_indep(ctrl, nsid, &id_indep))
> > +		return;
> > +
>=20
> Is it ok to issue this without checking that the namespace is ready?

This is a great question. Gave TP4084 a read and this is what I
understand (please correct me if I'm wrong):
* For the first controller ready mode (Controller ready with media), once
  the controller is ready the namespaces are required to process admin
  commands. Which basically means commands are not allowed to be aborted
  with "namespace not ready" status code. In this case it is OK to issue
  without checking NS ready.
* For the second controller ready mode (Controller ready independent of
  media), the identify command is not allowed to abort with
  "namespace not ready" status code  In this case it is OK to issue
  without checking NS ready.
* In the case that the command set indep identify NS is NOT supported we
  ignore the returned error and continue with validation in the
  expectation that the controller just forgot to implement the indep
  identify (08h) but actually supports the normal identify namespace
  command (00h).

All this is contained in my V4 which I'll post as soon as I have tested

Thx for the review

>=20
> >   	/*
> >   	 * Check if the namespace is ready.  If not ignore it, we will get an
> >   	 * AEN once it becomes ready and restart the scan.
> >   	 */
> > -	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) &&
> > -	    !nvme_identify_ns_cs_indep(ctrl, nsid, &id)) {
> > -		ready =3D id->nstat & NVME_NSTAT_NRDY;
> > -		kfree(id);
> > +	if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
> > +		if (!(id_indep->nstat & NVME_NSTAT_NRDY))
> > +			goto free_id_indep;
> >   	}
> > -	if (!ready)
> > -		return;
> > -
> >   	ns =3D nvme_find_get_ns(ctrl, nsid);
> >   	if (ns) {
> > -		nvme_validate_ns(ns, &ids);
> > +		nvme_validate_ns(ns, &ids, id_indep);
> >   		nvme_put_ns(ns);
> > -		return;
> > +		goto free_id_indep;
> >   	}
> >   	switch (ids.csi) {
> >   	case NVME_CSI_NVM:
> > -		nvme_alloc_ns(ctrl, nsid, &ids);
> > +		nvme_alloc_ns(ctrl, nsid, &ids, id_indep);
> >   		break;
> >   	case NVME_CSI_ZNS:
> >   		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> > @@ -4187,13 +4238,16 @@ static void nvme_validate_or_alloc_ns(struct nv=
me_ctrl *ctrl, unsigned nsid)
> >   				nsid);
> >   			break;
> >   		}
> > -		nvme_alloc_ns(ctrl, nsid, &ids);
> > +		nvme_alloc_ns(ctrl, nsid, &ids, id_indep);
> >   		break;
> >   	default:
> > -		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
> > -			ids.csi, nsid);
> > +		/* required to enable char-interface for unknown command sets*/
> > +		nvme_alloc_ns(ctrl, nsid, &ids, id_indep);
> >   		break;
> >   	}
> > +
> > +free_id_indep:
> > +	kfree(id_indep);
> >   }
> >   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,

--z5bqyyhidcotd24b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmK6ziQACgkQupfNUreW
QU+uegv+IxAgw2IdqOaMK6Lp4FJILOCdmBSxalyB0m8c07+sO8RnnMdULCcGA42Y
GYQU5M51aq+vts3XrE7I64nnVoiE+XT5dvGJz0vQVYTlWdA9ubHTIxhlEyG04+iT
4m3Tm62b3PTYdXrip9VjwTYMjpClTr+wud/gfgkEAwW4+nc9ngzQ19lxk+XpgIM8
ERPz80SrlU77DtLdpeCQeWfsjcCBkTtryTWdOT2AR/2zuHwQP/UVk8hDsnss9tI+
CdKx9vQICpyPx7P7vSqb3YjtzVzitxCZvRJaz9G/lYvQAx6YL+Zwzj8kickjltAu
0xIDLg7FugAN9DGCrCNdWV/81o3aCWXC7Qoi+EinFPh0ek8LdRT+YGarAvw2biqs
xvIDgGHgZmTxggU3X8t5hyxVGMAXuv4EfoiQ+SYVZfvtNNzq+IaKJ17jKdIb5rXK
YEMRgdjLNZFiX9ZElqs61drCwp2o7fWanfRNzImmOdztDXHei0VlVba3s/KUy4Jx
cKCELChb
=vhD5
-----END PGP SIGNATURE-----

--z5bqyyhidcotd24b--

