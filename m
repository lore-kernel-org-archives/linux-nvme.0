Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543B2C47258
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x6JhBpAX5uvxMKyYVX416eONab197/3c1JcFW0hNjQs=; b=1Dft2XhE23zjysSr2OFm9FQI8o
	pe2ik7A7UrCQARS4EevL5a9SLS0zM0s/M3YravThG5MI57raNTxIYVnBDDe5bNsDTTKCjpSJJ05eS
	MnfXTVWPhBvG9Y3BT9myfnOMvwyeWBnzeG4X9UGUIZvQMpwvf22OmHJxLwT/Vbf8WCy47LTUExim5
	a7s1l2/GMnZF28pX4Vpw+QL/B+h4CtG+kf0BLib6T1eqWawit3kYoJ+Pi9rRrrHLDGDFcit26RILv
	+oGUwCvCg+vp6Eti/k/Y5y65VnjnrtM0+ufIJCMUzTfryWJmvocOVJRvt/bfPyKgEqizUQ14lObKP
	EzX6/AMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU66s-00000009dRC-47ly;
	Sun, 28 Jan 2024 14:26:10 +0000
Received: from mailout11.t-online.de ([194.25.134.85])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU66n-00000009dP6-0xs3
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jan 2024 14:26:09 +0000
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
	by mailout11.t-online.de (Postfix) with SMTP id 7CDBBF9E8;
	Sun, 28 Jan 2024 15:25:42 +0100 (CET)
Received: from [10.2.8.134] ([80.145.193.127]) by fwd86.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rU66N-2OO5IG0; Sun, 28 Jan 2024 15:25:40 +0100
Message-ID: <9a4d69f0b7a4fa923cf247823a9081df76662125.camel@t-online.de>
Subject: Re: Western Digital SSD freezes on power saving
From: Frank Tornack <f-tornack@t-online.de>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux NVMe <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>,  Guenter Roeck <linux@roeck-us.net>, Damien Le Moal
 <dlemoal@kernel.org>
Date: Sun, 28 Jan 2024 15:25:33 +0100
In-Reply-To: <ZbZe5OPlqhwi_erM@archie.me>
References: <dfe9213bb86939ca4502b5b3fdd3ab77ef1b6f1b.camel@t-online.de>
	 <ZbZe5OPlqhwi_erM@archie.me>
Autocrypt: addr=f-tornack@t-online.de; prefer-encrypt=mutual;
 keydata=mDMEYPp0PBYJKwYBBAHaRw8BAQdA9MoQWxT+PljXoionhEHpIAuLlhUME07Jht42EmJS9/K0f0ZyYW5rIEVja2hhcmQgVG9ybmFjayAodGhpcyBrZXkgaXMgdXNlZCBhZnRlciAyMy4wNy4yMDIxLiBBbiBhdHRlbXB0IHdhcyBtYWRlIHRvIGludmFsaWRhdGUgb3RoZXIga2V5cykgPGYtdG9ybmFja0B0LW9ubGluZS5kZT6JAoYEExYIAi4CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4ACGQFEFIAAAAAAEAArcHJvb2ZAYXJpYWRuZS5pZGh0dHBzOi8vdHViZS50Y2huY3MuZGUvYS9ib2xsZXJ3YWdlbnBpY2FyZC9iFIAAAAAAEgBHcHJvb2ZAbWV0YWNvZGUuYml6aHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vZnJhbmtlbnN0ZWluOTEvOGE2ZmEwNmMxM2ZiY2VlZjhhMjRmZDFiNmRlNzIyYmFFFIAAAAAAEgAqcHJvb2ZAbWV0YWNvZGUuYml6aHR0cHM6Ly9tYXN0b2RvbnRlY2guZGUvQEJvbGxlcndhZ2VuUGljYXJkqhSAAAAAABIAj3Byb29mQG1ldGFjb2RlLmJpem1hdHJpeDp1L0Bib2xsZXJ3YWdlbnBpY2FyZDp0Y2huY3MuZGU/b3JnLmtleW94aWRlLnI9IWRCZlFaeENvR1ZtU1R1amZpdjptYXRyaXgub3JnJm9yZy5rZXlveGlkZS5lPSRjWGVqcnQ3dWJ1RUF5aTNsaFVDeWFEUUlBa0lnRktHMnF3TF8yTXl6MDY0UxSAAAAAABIAOHByb29mQG1ldGFjb2RlLmJpemh0dHBzOi8vZ2l0LmdnYy1wcm9qZWN0LmRlL0JvbGxlcndhZ2VuUGljYXJkL2dpdGVhX3Byb29mFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmR3n
	hEFCQWlCuQACgkQVa3qmdMF6s3KvgD+O46flI8ye2GWKixgtdQz4aDS78b+LES2ROInCv7N9IwA/ihgH1BlnCypJ4oXSb4KoPmC2M/HLfjtN/kG8x9B6VAPtFBGcmFua2Vuc3RlaW45MSAoRGllcyBpc3QgbWVpbmUgU3BhbSBFLU1haWwpIDxmcmFua2Vuc3RlaW45MS5pbmZvQGdvb2dsZW1haWwuY29tPojQBBMWCAB4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAORSAAAAAABIAHnByb29mQG1ldGFjb2RlLmJpemh0dHBzOi8vbGljaGVzcy5vcmcvQC9NVExGcmFuaxYhBIqzlkn93enweqtxJlWt6pnTBerNBQJkd54XBQkFpQrkAAoJEFWt6pnTBerNBPYBAPQqJRcB3bXZBZMBkWvYRPf44BZeYZPikE0jWpzmvil7AP4372uJBCKvTDX/v3ONDVBxK5kDn96yKTMVmm1PsJZVCrRMRnJhbmtlbnN0ZWluOTEgPGZyYW5rZW5zdGVpbjkxLmluZm9AZ21haWwuY29tPiAoc2hvcnQgdmVyc2lvbiBvZiBHb29nbGVtYWlsKYiWBBMWCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmR3nhcFCQWlCuQACgkQVa3qmdMF6s3FegD9EF0ViEKoXrUtjeyxTNr7TZybm0C72s73E0cVLZnjfXYA/3XPhEYxgcKxLQ8Ee9vg20C7QwtumLf4dewXSjE+3jEJ
Organization: Privat
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 
MIME-Version: 1.0
X-TOI-EXPURGATEID: 150726::1706451940-2EFFAC95-657200C6/0/0 CLEAN NORMAL
X-TOI-MSGID: 45331d2a-dfe2-40c9-ae4e-fd1ca33388bc
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_062606_661794_EC657F74 
X-CRM114-Status: GOOD (  35.37  )
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
Reply-To: f-tornack@t-online.de
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi

I am trying to explain the bug, which I understand also existed with
other manufacturers and could be solved with an update for many
devices, but there was no update for my SSD.

As far as I know, the SSD does not wake up or wakes up too late after
the deepest APST sleep state. As far as I know, this could be because
the values in the firmware for the wake-up time are given to the OS too
optimistically or because the SSD does not wake up at all.

I found the same problem for Kingston
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D538e4a8c571efdf131834431e0c14808bcfb1004

And what I had used to get it working on my old device:
https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Controller_failure_=
due_to_broken_APST_support

Would you please describe what else confuses you? Then I'll try to
clarify it.

Am Sonntag, dem 28.01.2024 um 21:04 +0700 schrieb Bagas Sanjaya:
> On Sun, Jan 28, 2024 at 01:26:23PM +0100, Frank Tornack wrote:
> > Hash: SHA512
> >=20
> > Hello Linux kernel developers and experts,
> >=20
> > I have a question that I think is not tied to a specific
> > distribution
> > and goes pretty deep into the Linux kernel. I hope you can help me
> > without subscribing to the mailing list and remember to include me
> > in
> > the answer discussion.=20
> >=20
> > In my old notebook I used an nvme-ssd from WD (wds500g1b0c-00s6u0),
> > which is affected by a well-known bug. I currently use the
> > parameter
> > `nvme_core.default_ps_max_latency_us=3D0` to prevent the system from
> > freezing.=20
> >=20
>=20
> What well-known bug?
>=20
> > I would like to use a new SSD in my new notebook. However, as it is
> > difficult to sell used SSDs, I would like to continue using the old
> > SSD
> > affected by the bug. I plan to move the SSD to a Thunderbolt
> > enclosure
> > for this purpose. I think since Thunderbolt is based on PCIe, the
> > same
> > energy saving measures and the associated bugs will probably apply.
> >=20
> > In the hope that my new SSD doesn't have the same bug, I would
> > prefer
> > not to disable the Powersafe in the laptop. Is there a way to set
> > this
> > flag only for a specific SSD? By identifying it by name or serial
> > number?=20
> >=20
> > I apologise prophylactically if my question is completely out of
> > place
> > and thank you for your help. As a long-time Linux user, I would
> > also
> > like to thank you in general. If you have any follow-up questions,
> > please do not hesitate to contact me.
> >=20
>=20
> Confused...
>=20

- --=20
Frank Tornack <f-tornack@t-online.de>
Privat
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSKs5ZJ/d3p8HqrcSZVreqZ0wXqzQUCZbZj3QAKCRBVreqZ0wXq
zff8AP41lex8G8esRL+tIpXu1xVYO19r00riIAhX9IrydNSIjgEAlHgb/KuvrFvv
RLYITrfzXE5R+Iuh0cUtDVcIfD3xsgM=3D
=3Dw6Ge
-----END PGP SIGNATURE-----

