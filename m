Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC96CA0EE6
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Aug 2025 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gXOtsIBUt5Q8GjGEEyrG9hdfarb8U4iDDYTRYZfEMLE=; b=g2CdNZLOmO252Q2UIFgj68jKS+
	rlG5r+jesi5/JLbOPQxJRKOWfLMbxuDnELrZs6XhBRQpYWTxjIC+eyPSq12OKHPs4mTHsKYLf3qx4
	uDsiq4WlNMzcCJHsKzO/WYf5fkKiB28Uww9rhEh2YeP65JDAn/BmiQlConuYsmVZY7yzXLFvnwYjs
	og8YqwqdWqLV/BSoyD8UyrLzy9EuL/emUQcDJYcKdOIGdzcdsQvMrTMMibS6l3SULQn9422K38fAB
	yAtQo/WLzxNQocY+aKibVtrNeLr2R/RWO33looz/QgOXVqEjmxVVM4jLv+ZWjGkODMM7eJQk94Msp
	ZaCiqqZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unHdA-00000004kJS-3jZh;
	Sat, 16 Aug 2025 14:11:36 +0000
Received: from out-182.mta1.migadu.com ([2001:41d0:203:375::b6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unHd7-00000004kJ8-3dq0
	for linux-nvme@lists.infradead.org;
	Sat, 16 Aug 2025 14:11:35 +0000
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755353490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXOtsIBUt5Q8GjGEEyrG9hdfarb8U4iDDYTRYZfEMLE=;
	b=USFgHKsWMRwclD+dOKPvxw3L05Nmw54SaqWFKKCtdtAgcAPvQDBugNjn1H6Dj/nyOVx7Ii
	dDfeXXVAs53e4Flkqlt+Lkc6BzbZaGKZ8HIQBtJFOhEKJ//Q8n2mkIJcYzMPrUw/Ft0vC8
	8dF8y2opMvnRH4gqEIxKI795X7uwwRuOzKruPKzEYNVkcr/UtFpeNYV56zsww3xakszOGo
	uFuy+WwLD+Fme6BfIdK0i40jECgainadzECXo5gMem8cfi5iW6+ill1TUNXOrMej3BTVfR
	gWZ8JwV8oHXCK6aZFdE5NIKahpbAYov4LAWFSf23Go1tihYRQZW39eSeuPGQmQ==
Content-Type: multipart/signed;
 boundary=ce84aeca85d13a394e424f78243a774da427df6c7723bf1acd3cf4638e4c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 16 Aug 2025 16:11:00 +0200
Message-Id: <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Diederik de Haas" <didi.debian@cknow.org>
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Keith Busch" <kbusch@kernel.org>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
 <aKCFjzai3Y0RcGHP@kbusch-mbp>
In-Reply-To: <aKCFjzai3Y0RcGHP@kbusch-mbp>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250816_071134_305553_4640F7DD 
X-CRM114-Status: GOOD (  18.11  )
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

--ce84aeca85d13a394e424f78243a774da427df6c7723bf1acd3cf4638e4c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat Aug 16, 2025 at 3:20 PM CEST, Keith Busch wrote:
> On Sat, Aug 16, 2025 at 01:40:44PM +0200, Diederik de Haas wrote:
>> I have a Samsung 970 EVO 2TB SSD and I see these kernel warnings:
>
> ...=20
> =20
>> I wonder if something can be done to fix those warnings.
>
> Are you talking about this message?
>
>    nvme nvme0: missing or invalid SUBNQN field
>
> You can't do anything about it, but I wouldn't worry about it either.

That's indeed one of them; good to know it's not to worry about.

> If you want to see what the driver is reacting to, you can check the
> subnqn from command line:
>
>   # nvme id-ctrl /dev/nvme0 | grep subnqn
>
> It'll probably be all zeros. The field has been required by spec, but
> the driver tolerates ones that don't implement it.

root@nanopi-r5s:~# nvme id-ctrl /dev/nvme0 | grep subnqn
subnqn    :

So it seems to be just empty?

> It's just a message that the device isn't spec compliant, but
> otherwise perfectly operational.

But still worthy of a warning (instead of info) msg?

The other kernel warning is this:

  nvme nvme0: using unchecked data buffer

The SUBNQN message appears every time, this one appears often, but not
always.

When researching this/these issues, I discovered the nvme-cli package
(with the nvme command) and via its manpage I found this command:

  nvme get-feature /dev/nvme0 -f 3

I didn't even know NVMe's had namespaces, but this didn't look good:

  The namespace or the format of that namespace is invalid(0x200b)

... without actually understanding what it means and/or what its
consequences are. It could be harmless and/or normal though.

Cheers,
  Diederik

--ce84aeca85d13a394e424f78243a774da427df6c7723bf1acd3cf4638e4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKCRiwAKCRDXblvOeH7b
bsMOAP467UvBdOwLTCTyaNzSEfLdNs09O66h8luJumIRs2fs2wEAgmhYVurmWFBA
TqpVQhTLqv4KBJri3VBLPBP7uamUAAI=
=23W7
-----END PGP SIGNATURE-----

--ce84aeca85d13a394e424f78243a774da427df6c7723bf1acd3cf4638e4c--

