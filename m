Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32138C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:Cc:To:From:Date:References:In-Reply-To:Message-Id:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2FN67gw0JMHWLjpHnO3rxM4qEuoVfee8AmHb2Dcp/5Y=; b=k36DER3Sf5BiR4oqmW9a23Bh73
	0XL5jgMm+MkjppwPZAMhyk4VLTxy6sJ4CB5ePwkpC9LIx3dypW8rLKmiiJFf1BFJNBUit+xyDvAsB
	5TGVgJIU0S5rJWfzf2A1gLo9slV877JJ4HqcflYp/yQuewL/o9a0GdffI5M5Df3ocPwbfPpmhwrIx
	cqiuqJoNBLiPbZzc1Qd88UMKYo5oyxMpqNqKGq83DPvcROrZCYya+xATWxAb93h5Zyb8JndJRyODF
	npO9kbSUwUUf5/hlKG8y48EEZSV0xl7+0L0PJ0ydY3LtVYPRWIaC8sV1xKbWHHQxfhiGj3Q+xyS/x
	84Mc95uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nciu8-00FTu9-4d; Fri, 08 Apr 2022 07:19:36 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nciu4-00FTpa-A3
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 07:19:34 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 178A23200B8B;
 Fri,  8 Apr 2022 03:19:26 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
 by compute4.internal (MEProxy); Fri, 08 Apr 2022 03:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; bh=2FN67gw0JMHWLj
 pHnO3rxM4qEuoVfee8AmHb2Dcp/5Y=; b=Wk73X+GpcGqlPAYU0ZDKESMYA8U2Zr
 9MJdeLVKkmL9WRsl0E5PyXYoadGgCXJKY5vgfJ0Mqb1Kwz1wxzI18i1raDco/Sav
 MWRRD6YIapxOVIH30e2aERS0+RscX4Cq17peKPsKmUcZqHaPOxp282ifkPt0PWJu
 dQohxkuu+T9S5Uf9zNYSuvRRsMDjyBVSlxr/rZnQ11Q7FCuHy/Xw65TrK+U7dhND
 rY+rMZxdPenZomrvaICY7UrxxZ/1pPJEcGzTziezKcLuVp+AhvccbK+uMdgVk/lW
 s0tdY88FIad5+5wlNmL8xj7xsEHfuyLkkH0lfS2yFwbiW/bel0LQPycA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=2FN67gw0JMHWLjpHnO3rxM4qEuoVfee8AmHb2Dcp/
 5Y=; b=UXs3nkHV6epdn4P3Dq7F9eg9t0xfdXo2mjBaXEfZYpKGzhRJJ4+YiZ2ru
 FN0AYgZwrqg0pJr2ZL6LggLz+EJV9eIa1QY5zz+SQVIBwnpjiKS/MQOhlVAn1hLy
 OOlr5l63nboX3Uo6rCfVT2jruonxVVZ6bIQjK5NxYPkNwpDRslRsziPw1LjkbAJr
 N+XmpkWl+fH8b7gJJwBY+Zw9Fha+SrIJ9J0Ua9g9/IjmKxavVfSgknYPCyD9yBIw
 /DefXdBApfRh2I06XmPc27RNACEQOb3vKS+jn/eJq4SsshVf5veLXEuXpaXOmcOQ
 ngEuE83IflsxuGENA/PhpnG8PzKeA==
X-ME-Sender: <xms:_eFPYn1Flrgybb-2ZbVpSPSF4Mc9JZQKNjWZgVkuprIL7rVlPFIXHw>
 <xme:_eFPYmEAnFfSZceancRZyCmei2x4QMe7VFXBNaAdhQk86hgFPQKjPfjKASxo0I2qQ
 tVYK46z-l2oPoTncqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejledgudduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
 lhgruhhsucflvghnshgvnhdfuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecugg
 ftrfgrthhtvghrnheptdffjeevgeeggefgueehiedttdelkeetleevtedvteelvefhieek
 feefteelgfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:_eFPYn6nj-Q5FVYtUz6IbdlCIaogjlLhe0zd6WsOV071POEWrI0f4g>
 <xmx:_eFPYs3wsFL-4nTTa5rosDT3J-YjuCcW5eu9DxmUnjyHRu7Ao63p8Q>
 <xmx:_eFPYqF57iyO-FTxH719_cSoTeW0mhfrYZEv0y77QQTXM1qw8qS4tw>
 <xmx:_eFPYvS5WDiv1C097TZUY8JZtZrLj4NkLbKbpFY-qnXd2wJGzsQXYg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 4FA021EE007B; Fri,  8 Apr 2022 03:19:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-386-g4174665229-fm-20220406.001-g41746652
Mime-Version: 1.0
Message-Id: <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
In-Reply-To: <20220408052907.GA31990@lst.de>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
Date: Fri, 08 Apr 2022 09:19:04 +0200
From: "Klaus Jensen" <its@irrelevant.dk>
To: "Christoph Hellwig" <hch@lst.de>, "Luis Chamberlain" <mcgrof@kernel.org>
Cc: "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_001933_195004_47450669 
X-CRM114-Status: GOOD (  36.18  )
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



On Fri, Apr 8, 2022, at 07:29, Christoph Hellwig wrote:
> On Thu, Apr 07, 2022 at 06:04:59PM -0700, Luis Chamberlain wrote:
>> On Thu, Feb 24, 2022 at 08:28:45PM +0100, Christoph Hellwig wrote:
>> > Add a check to verify that the unique identifiers are unique global=
ly
>> > in addition to the existing check that verifies that they are unique
>> > inside a single subsystem.
>> >=20
>> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>> > ---
>> >  drivers/nvme/host/core.c | 38 ++++++++++++++++++++++++++++++++++++=
--
>> >  1 file changed, 36 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> > index cece987ba1691..f8084ded69e50 100644
>> > --- a/drivers/nvme/host/core.c
>> > +++ b/drivers/nvme/host/core.c
>> > @@ -3810,12 +3810,45 @@ static struct nvme_ns_head *nvme_alloc_ns_h=
ead(struct nvme_ctrl *ctrl,
>> >  	return ERR_PTR(ret);
>> >  }
>> > =20
>> > +static int nvme_global_check_duplicate_ids(struct nvme_subsystem *=
this,
>> > +		struct nvme_ns_ids *ids)
>> > +{
>> > +	struct nvme_subsystem *s;
>> > +	int ret =3D 0;
>> > +
>> > +	/*
>> > +	 * Note that this check is racy as we try to avoid holding the gl=
obal
>> > +	 * lock over the whole ns_head creation.  But it is only intended=
 as
>> > +	 * a sanity check anyway.
>> > +	 */
>> > +	mutex_lock(&nvme_subsystems_lock);
>> > +	list_for_each_entry(s, &nvme_subsystems, entry) {
>> > +		if (s =3D=3D this)
>> > +			continue;
>> > +		mutex_lock(&s->lock);
>> > +		ret =3D nvme_subsys_check_duplicate_ids(s, ids);
>> > +		mutex_unlock(&s->lock);
>> > +		if (ret)
>> > +			break;
>> > +	}
>> > +	mutex_unlock(&nvme_subsystems_lock);
>> > +
>> > +	return ret;
>> > +}
>> > +
>> >  static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>> >  		struct nvme_ns_ids *ids, bool is_shared)
>> >  {
>> >  	struct nvme_ctrl *ctrl =3D ns->ctrl;
>> >  	struct nvme_ns_head *head =3D NULL;
>> > -	int ret =3D 0;
>> > +	int ret;
>> > +
>> > +	ret =3D nvme_global_check_duplicate_ids(ctrl->subsys, ids);
>> > +	if (ret) {
>> > +		dev_err(ctrl->device,
>> > +			"globally duplicate IDs for nsid %d\n", nsid);
>>=20
>> So what sort of meachanisms would break in nvme if we don't (as it was
>> before this patch)?
>
> The most directly visible problem is that this breaks the
> /dev/disk/by-id/ links - all devices would have to point to the same
> one, and which one actually shows up is somewhat random.  This basical=
ly
> means random corruption if people actually use the links or the uuid
> functionality in any other way.
>
> Note that we have alredy checked for this inside a controller for a
> long time, the commit just extended it across controllers.
>
>
>> The reason I ask is that it would seem tons of
>> instantiated qemu guests used the default, and don't set the UUID,
>> and so this is auto-generated as per the documentation [0]. However,
>> I'm suspecting the auto-generation may just be... a single value:
>
> Odd.  All my qemu VM don't show a UUID unless specifically set.
>

Odd indeed. With =E2=80=9Clegacy/single namespace=E2=80=9D setup (drive =
parameter directly on the nvme device), the uuid, eui64 and nguid should=
 be zeroed.

Using the new -device nvme-ns, QEMU will randomize the uuid. However the=
 eui64 will be more static and only differ with the namespace id so it w=
ill not be unique across subsystems (this needs fixing in QEMU).

In any case, with -device nvme-ns, uuid and eui64 can be set explicitly =
with device parameters and that should be used if predictable behavior i=
s required.

>>=20
>> root@kdevops ~ # cat
>> /sys/devices/pci0000:00/0000:00:08.0/nvme/nvme0/nvme0n1/uuid
>> 00000001-0000-0000-0000-000000000000
>
> And the 1 really seems like a bug in your particular set.  What qemu
> version is this?  Does it have any local or distro patches applied?

I cannot reproduce the 1 either, but QEMU might have spliced the maid in=
to the uuid at some point in the past, can=E2=80=99t remember.

