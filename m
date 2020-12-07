Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EB3C4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 09:02:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A62A2333D
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 09:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A62A2333D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mz/1ZI0RILBCc5xkyUHUAsNwETpHheBDq6b67nRczKA=; b=Sc5GNoj+Sra1KN8fLiR6LZNDM
	idznjdlPF8yyIJIEqbjE5/04RRwvR3MN8Dja3X4l1b8TIyzOWoWxdnneayGVgrQjOZG8QzLAdkFj7
	UXKncWVfn9nO+QXAZwASxloUekBR5FXmNlRTsTrkLxW7PsJj1HiSF19vqXhv6fIh9oaZmHvdT0iGj
	0WLOmQJPEwCO6UzNKXj0ZoJGqJpBzZAhrlswM0W88fcWDTJvoHJ76hiVB92lPAlB5PLykn7wjKw+N
	vnpEGTBnC/ZIjEZ5NcA1nYYtLQeLZzWLVHZ2u6+CbV4knTSIMwo3WAsrGSGHd1Mcbe2jW09IHgFig
	zgDfEjNQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmCPu-00077q-08; Mon, 07 Dec 2020 09:02:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmCPr-00077P-3W
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 09:02:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1607331762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eoaV1NPwHD6WI0HBk9eoj2MU5zFUiUkyvNZPFYk2DUU=;
 b=vDgK3oIKGtSTrjDeI/K1u8SmaXMAe0BfFkDeCJoG7jWb/V4TW5JLyN5TdMZOPZQ++tBTDl
 8HcjNVeqGz58HAGhrBwGMKGjxXuCMA7DhnhVlUS6/L5l9LBuJStAC5OTWJ3O0jIZS91+mj
 Ts7BZSD2/MNhNX+bsfjLKqlOH5uv7AE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E04CFAD3F;
 Mon,  7 Dec 2020 09:02:41 +0000 (UTC)
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jason Andryuk <jandryuk@gmail.com>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?=
 <roger.pau@citrix.com>
References: <20201129035639.GW2532@mail-itl>
 <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
 <20201202000642.GJ201140@mail-itl> <20201204110847.GU201140@mail-itl>
 <20201204120803.GA20727@lst.de> <20201204122054.GV201140@mail-itl>
 <20201205082839.ts3ju6yta46cgwjn@Air-de-Roger>
 <CAKf6xpvdD-XJoRO91B+Lwc=0Sb6Luw2X8Y9sH_MQsAWhZmj+hw@mail.gmail.com>
 <7de66323-8a1f-fe95-c9d2-d2a5b1318d2f@suse.com>
Message-ID: <5150c139-b73d-ecdb-b19b-8755d5ecf631@suse.com>
Date: Mon, 7 Dec 2020 10:02:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <7de66323-8a1f-fe95-c9d2-d2a5b1318d2f@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_040243_423007_620502A2 
X-CRM114-Status: GOOD (  18.08  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 xen-devel <xen-devel@lists.xenproject.org>, Christoph Hellwig <hch@lst.de>
Content-Type: multipart/mixed; boundary="===============7293702365253134357=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7293702365253134357==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1IWo2WNrVXqSxZflEHhPUnV4N9cjri20Z"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1IWo2WNrVXqSxZflEHhPUnV4N9cjri20Z
Content-Type: multipart/mixed; boundary="Q2RT5Cd8uQaPQLruXibxaHlujkLkxbzKd";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jason Andryuk <jandryuk@gmail.com>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?=
 <roger.pau@citrix.com>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>, Christoph Hellwig <hch@lst.de>,
 xen-devel <xen-devel@lists.xenproject.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Message-ID: <5150c139-b73d-ecdb-b19b-8755d5ecf631@suse.com>
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
References: <20201129035639.GW2532@mail-itl>
 <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
 <20201202000642.GJ201140@mail-itl> <20201204110847.GU201140@mail-itl>
 <20201204120803.GA20727@lst.de> <20201204122054.GV201140@mail-itl>
 <20201205082839.ts3ju6yta46cgwjn@Air-de-Roger>
 <CAKf6xpvdD-XJoRO91B+Lwc=0Sb6Luw2X8Y9sH_MQsAWhZmj+hw@mail.gmail.com>
 <7de66323-8a1f-fe95-c9d2-d2a5b1318d2f@suse.com>
In-Reply-To: <7de66323-8a1f-fe95-c9d2-d2a5b1318d2f@suse.com>

--Q2RT5Cd8uQaPQLruXibxaHlujkLkxbzKd
Content-Type: multipart/mixed;
 boundary="------------8E61B34936BA4E7DF6D6DC5C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8E61B34936BA4E7DF6D6DC5C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 07.12.20 09:53, J=C3=BCrgen Gro=C3=9F wrote:
> Marek,
>=20
> On 06.12.20 17:47, Jason Andryuk wrote:
>> On Sat, Dec 5, 2020 at 3:29 AM Roger Pau Monn=C3=A9 <roger.pau@citrix.=
com>=20
>> wrote:
>>>
>>> On Fri, Dec 04, 2020 at 01:20:54PM +0100, Marek Marczykowski-G=C3=B3r=
ecki=20
>>> wrote:
>>>> On Fri, Dec 04, 2020 at 01:08:03PM +0100, Christoph Hellwig wrote:
>>>>> On Fri, Dec 04, 2020 at 12:08:47PM +0100, Marek=20
>>>>> Marczykowski-G=C3=B3recki wrote:
>>>>>> culprit:
>>>>>>
>>>>>> commit 9e2369c06c8a181478039258a4598c1ddd2cadfa
>>>>>> Author: Roger Pau Monne <roger.pau@citrix.com>
>>>>>> Date:=C2=A0=C2=A0 Tue Sep 1 10:33:26 2020 +0200
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 xen: add helpers to allocate unpopulated =
memory
>>>>>>
>>>>>> I'm adding relevant people and xen-devel to the thread.
>>>>>> For completeness, here is the original crash message:
>>>>>
>>>>> That commit definitively adds a new ZONE_DEVICE user, so it does lo=
ok
>>>>> related.=C2=A0 But you are not running on Xen, are you?
>>>>
>>>> I am. It is Xen dom0.
>>>
>>> I'm afraid I'm on leave and won't be able to look into this until the=

>>> beginning of January. I would guess it's some kind of bad
>>> interaction between blkback and NVMe drivers both using ZONE_DEVICE?
>>>
>>> Maybe the best is to revert this change and I will look into it when
>>> I get back, unless someone is willing to debug this further.
>>
>> Looking at commit 9e2369c06c8a and xen-blkback put_free_pages() , they=

>> both use page->lru which is part of the anonymous union shared with
>> *pgmap.=C2=A0 That matches Marek's suspicion that the ZONE_DEVICE memo=
ry is
>> being used as ZONE_NORMAL.
>>
>> memmap_init_zone_device() says:
>> * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
>> * and zone_device_data.=C2=A0 It is a bug if a ZONE_DEVICE page is
>> * ever freed or placed on a driver-private list.
>=20
> Could you test whether the two attached patches are helping?
>=20
> Only compile tested.

Oh, sorry, one patch missing.

I need to modify drivers/xen/unpopulated-alloc.c, too.


Juergen

--------------8E61B34936BA4E7DF6D6DC5C
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------8E61B34936BA4E7DF6D6DC5C--

--Q2RT5Cd8uQaPQLruXibxaHlujkLkxbzKd--

--1IWo2WNrVXqSxZflEHhPUnV4N9cjri20Z
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAl/N77EFAwAAAAAACgkQsN6d1ii/Ey8m
JAf9FhNQjBjAf0GFH5mKSCIdjE7daoeFdgRb2sju6KdRNHFhdAMNQqfxLCZM50N6ie90GsNYB+wO
aeK8diqMJfCJNtABA0JstQi6Lh9kMfWfMRTjoTK9U+O+2l+ziWYfiRhwEjpfXs+LZYkhzioqk8NB
RRnb9CzR6HirKDAbbbQxl50maMhvBY7bb1uLH6AtxalmDDolJU3jht25O7uf32ax2cYqlzhMM6hY
YQfjJduuU4zVCxufXkJUEe8jCm+QF24g2W9lxd/Tg6aEImdAXyU5yq+nJFTVyosEpUUVIjRkCcdd
buONYjMt7D2RVXfByX0SKSWQ6SjjEEfjm+8UqJJYLg==
=SUS1
-----END PGP SIGNATURE-----

--1IWo2WNrVXqSxZflEHhPUnV4N9cjri20Z--


--===============7293702365253134357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7293702365253134357==--

