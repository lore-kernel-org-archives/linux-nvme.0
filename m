Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3701DCA0EE4
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XS7+GV2RkpfpXQCCQWs19kWJiga7BQll43I9ak8T6ss=; b=FiR0KRL3GwReV3Gi2RTpLVm1Lm
	Z4iY8usLI/1ZAQD7ntqn+BkvbESIgZkXrFV1kAmqu6ZczkCh0PQWYINgCBuKDmiwNc47krhalz++F
	l2SadohngWin58zCKSf5eTSz4qbcDNvBHC4wiqupCvTGQrmnQYrUxD3Pt1GPkXgqxRujkI7phgYma
	CDYYPsxdoWlQDOk/dI8h+zCJo+UomjPn/cHVrb8Fyyja193TSZLNfn1UfoPObbZoCCbd/zU+2kDf/
	49zdkpaIHc7va+65g7L/S6Av7fieA7fzw5V2hLqUBOKZr6RlTlZqjRON90u78OuTcWpQeefJM4812
	nm8gylvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo8IR-00000008pgl-0Wla;
	Mon, 18 Aug 2025 22:25:43 +0000
Received: from out-178.mta0.migadu.com ([91.218.175.178])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo7H9-00000008hcS-2PVb
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 21:20:21 +0000
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755552016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS7+GV2RkpfpXQCCQWs19kWJiga7BQll43I9ak8T6ss=;
	b=qjbhtzNtYArFfyLJniwM9+d4q2aGuf7I1GONVIlMYFZ07i8uuP8Uu5IUUc6KbVdcI9NiNz
	nE3no1ZIpnEQew9ebQPcdszgCsNd4cde4EsHkRl9b4v8lVLxKZ3lJjgVx0lphIGrthxx8Q
	UxqE9t3Oyo3C0STZR4RCKBPDIXooXpgcDeSX/dp+cz4Wb18zUUC7M7ptgxcnrYA+paLu5L
	yXGEubmWIIEIhKCOCdGJhtS2bzQODTKhb4qrTgFtk6BXV3DQssXzjBCH4r2dialzksYGT1
	q0qUv0xOG0PGfj4IgTHSXDsauF8aZfQ6wQwY+gGRlmiw/PYYlqshz1mis8lNig==
Content-Type: multipart/signed;
 boundary=f5a3337a4ddd79f69b97f3302687a1b89b63238d5c33cb848fb830109345;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 18 Aug 2025 23:20:00 +0200
Message-Id: <DC5V8VGBDFQ8.3SZ2OASX2W75E@cknow.org>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Diederik de Haas" <didi.debian@cknow.org>
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Keith Busch" <kbusch@kernel.org>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
 <aKCFjzai3Y0RcGHP@kbusch-mbp> <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>
 <aKN30RVeM3p5NJm1@kbusch-mbp> <DC5UKZ9F6CQZ.2NDFY4S322T2G@cknow.org>
In-Reply-To: <DC5UKZ9F6CQZ.2NDFY4S322T2G@cknow.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_142019_826227_1ECBAE08 
X-CRM114-Status: GOOD (  17.27  )
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

--f5a3337a4ddd79f69b97f3302687a1b89b63238d5c33cb848fb830109345
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Aug 18, 2025 at 10:48 PM CEST, Diederik de Haas wrote:
> On Mon Aug 18, 2025 at 8:58 PM CEST, Keith Busch wrote:
>> On Sat, Aug 16, 2025 at 04:11:00PM +0200, Diederik de Haas wrote:
>>> On Sat Aug 16, 2025 at 3:20 PM CEST, Keith Busch wrote:
>>>=20
>>> The other kernel warning is this:
>>>=20
>>>   nvme nvme0: using unchecked data buffer
>>>=20
>>> The SUBNQN message appears every time, this one appears often, but not
>>> always.
>>
>> That one means you've sent a user space passthrough command to a device
>> that doesn't support SGL DMA. Without that, the nvme protocol uses
>> implicitly sized DMA that the driver can't be sure is accurate. The user
>> could theoretically provide a short buffer that can corrupt memory if
>> done by accident, or be used as an attack vector if done by malicious
>> software.
>>
>> This is also not something to worry about unless you run malicious or
>> buggy software.
>
> I would be surprised if I was running malicious software, but pretty
> much all software has bugs, so that's ofc possible.
> ...
>
> Uninstalled the 3 programs from R5S that showed up the most around the
> warning message and it's still there.=20
> Would 'dyndbg' be helpful to determine what program is buggy?
 =20
Looks like I found the 'winner': udisks2 (package)

I uninstalled that and in the 10 boots after that, I did not see the
message. Installed it again (without Recommends) and it was back on the
first (re)boot.

Thanks!

Cheers,
  Diederik

--f5a3337a4ddd79f69b97f3302687a1b89b63238d5c33cb848fb830109345
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKOZCAAKCRDXblvOeH7b
bvlxAP9OjZ2a9vOVVf9jUCjeLoX2b1h1ZPtA6pVUfgGRKEx2JQEAhzTpzmfiuU85
rMxVDHRZfDaHjgVp1YoYZZLYJEOp9wE=
=EcQA
-----END PGP SIGNATURE-----

--f5a3337a4ddd79f69b97f3302687a1b89b63238d5c33cb848fb830109345--

