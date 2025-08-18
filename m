Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3DECA0EED
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ByNT5QgUCDMMaAGJVbx79L00vBRPCMUQu0+uv6XCpzM=; b=euyHmy60gNG+rdfsyjf20VsuuF
	QlTzQDJLKslWH/3vdye4FsBNNUr0xz5cN1k2HFw3wL8p2XgqmxxOMnWsp/G6Lj+SJ6rU7fbdaBmop
	zzFR3JAiv2coS1nTHuye7tS25IDfmueVeB8up5n40bJero55Cd3auI+iNlfpliBhOuIvOJlo+9uZu
	Cwmjs1EgOFCFmliyzVqP4O0Fz84fUgqRAJ/cMfpVOyaZ+E50XoIuignRfICzra6ru2bPPe577DQDV
	lWSze9Ndk0Feilrnkeqcj7Q/YkzfHuiTzDohfVunEXvJxgRgCs0BwAatvbNFVHL7rg16SxzqM50LL
	2dLxIL3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo7QR-00000008k28-2z6S;
	Mon, 18 Aug 2025 21:29:55 +0000
Received: from out-172.mta1.migadu.com ([2001:41d0:203:375::ac])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo6os-00000008fAu-0iww
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 20:51:10 +0000
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755550140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByNT5QgUCDMMaAGJVbx79L00vBRPCMUQu0+uv6XCpzM=;
	b=QoR529jaPqvL6O3cMXGkjzv6jK29vWphwfTy0I0w3aVwBQt22E0Tm0v0vrTHjX5XQSw2kR
	+P5fqG6y/3FZ7GsiQtIGhmQlJyc5YA77rh3eSfOunxMi4Pc8owbe56z4BBUwb2n/i0hfSn
	v2JzPcZXUMHoNe7Tqz4gSgggb0Xs3f++FIj2J56x/ifbXB76xIvFkKbL17paawt2/mTK6S
	YSsU18tnzZyU4VCZ8Ba2Ndju41HaXB0/WjkHoantOiP27Q11vzPRIzf+w4PESmXSJWNhHm
	nsvthBu4BLSQXTjliGmm96ngTXVZJjoqkdmJhsqJvumiaBWyzPw1OCheD6u5tg==
Content-Type: multipart/signed;
 boundary=74404bb997a85f20169c389c59a45f42fa781e52e1caa9a2b257d66156fa;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 18 Aug 2025 22:48:48 +0200
Message-Id: <DC5UKZ9F6CQZ.2NDFY4S322T2G@cknow.org>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Diederik de Haas" <didi.debian@cknow.org>
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Keith Busch" <kbusch@kernel.org>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
 <aKCFjzai3Y0RcGHP@kbusch-mbp> <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>
 <aKN30RVeM3p5NJm1@kbusch-mbp>
In-Reply-To: <aKN30RVeM3p5NJm1@kbusch-mbp>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_135107_248898_9F0006A1 
X-CRM114-Status: GOOD (  28.08  )
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

--74404bb997a85f20169c389c59a45f42fa781e52e1caa9a2b257d66156fa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

First of all: thanks for taking the time to answer my questions :)

On Mon Aug 18, 2025 at 8:58 PM CEST, Keith Busch wrote:
> On Sat, Aug 16, 2025 at 04:11:00PM +0200, Diederik de Haas wrote:
>> On Sat Aug 16, 2025 at 3:20 PM CEST, Keith Busch wrote:
>>=20
>> > If you want to see what the driver is reacting to, you can check the
>> > subnqn from command line:
>> >
>> >   # nvme id-ctrl /dev/nvme0 | grep subnqn
>> >
>> > It'll probably be all zeros. The field has been required by spec, but
>> > the driver tolerates ones that don't implement it.
>>=20
>> root@nanopi-r5s:~# nvme id-ctrl /dev/nvme0 | grep subnqn
>> subnqn    :
>>=20
>> So it seems to be just empty?
>
> They, it's interpreted as a string. All 0's would be an empty string.

Ah yes, makes sense.

>> The other kernel warning is this:
>>=20
>>   nvme nvme0: using unchecked data buffer
>>=20
>> The SUBNQN message appears every time, this one appears often, but not
>> always.
>
> That one means you've sent a user space passthrough command to a device
> that doesn't support SGL DMA. Without that, the nvme protocol uses
> implicitly sized DMA that the driver can't be sure is accurate. The user
> could theoretically provide a short buffer that can corrupt memory if
> done by accident, or be used as an attack vector if done by malicious
> software.
>
> This is also not something to worry about unless you run malicious or
> buggy software.

I would be surprised if I was running malicious software, but pretty
much all software has bugs, so that's ofc possible.
(I run Debian Testing or Unstable on pretty much all my devices)

I thought it was a HW problem as the problem seemed to disappear from my
PC when I removed the NVMe drive from it. And when put in my NanoPi R5S
it appeared again on that device.
Seemed, as I just found out it happened on my PC as well (with Samsung=20
960 PRO 1TB) this boot (but not the 20 boots prior).

Uninstalled the 3 programs from R5S that showed up the most around the
warning message and it's still there.=20
Would 'dyndbg' be helpful to determine what program is buggy?
=20
>> When researching this/these issues, I discovered the nvme-cli package
>> (with the nvme command) and via its manpage I found this command:
>>=20
>>   nvme get-feature /dev/nvme0 -f 3
>>=20
>> I didn't even know NVMe's had namespaces, but this didn't look good:
>>=20
>>   The namespace or the format of that namespace is invalid(0x200b)
>>=20
>> ... without actually understanding what it means and/or what its
>> consequences are. It could be harmless and/or normal though.
>
> The feature you're requesting is the LBA range, which is namespace
> scoped. You need to specify a namespace id, either by opening the
> namespace's block device (/dev/nvme0n1) instead of the admin handle
> (/dev/nvme0), or you can manually specify the namespace with paramters
> "--namespace-id=3D1" or just "-n1".

Adding "-n1" does show normal (AFAICT) output. It's all zeros though.
And now the error message makes sense too :-)
The nvme-cli man page could/should have a better (ie working) example,
but that's not a kernel problem.

Thanks for your help and reassurances :-)

Cheers,
  Diederik

--74404bb997a85f20169c389c59a45f42fa781e52e1caa9a2b257d66156fa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaKORtAAKCRDXblvOeH7b
bpB0AQDnJ4HcRvflUUhFeXsj+tfNwP2JOCXKBs0eHuFJ03qZiAEAisV8mhu5Uwfo
IDyywKOQTyFNwS+aKWk3T5OKt61hKg0=
=4lmg
-----END PGP SIGNATURE-----

--74404bb997a85f20169c389c59a45f42fa781e52e1caa9a2b257d66156fa--

