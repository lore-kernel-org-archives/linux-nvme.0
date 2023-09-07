Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B48EC8742
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Sep 2023 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeOCI4aINKlUle4Z4caiMqwno7CVtpizI5fPp9sr6Is=; b=EaJIYHwLEL0czzqMM4h0XBcRNQ
	9GFxASwdI/qoFZB9+kVA6fhFYd2+aKWZMKeoU2gxSHIpO2Yjw4nYUdoaV5cNca78WkSlPd0THSQ8X
	SdpFtyncg2k+PjJi78gM5m1DrpPpnX+knFDV+7lODnu/kKF9eD4VMvKPVExxkLfQcX+0wAFAyXOhK
	XgTmSe3ydOINPBLOog6Wh7xVMY414qMHd+iAQAL0jYFlqlA9R0FtmVl+A6nUNF1jRZONSfCpGhPEg
	Yg7IWG88dqA8B/xt49GjdEbYwatc3DDwteUnLFPz3LR8L4bQtyJrEJb1wmvVyfot+wQ4V/CG5EIT4
	xtl/somw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeJ92-00CVOm-39;
	Thu, 07 Sep 2023 17:50:20 +0000
Received: from mail.archlinux.org ([2a01:4f9:c010:3052::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeJ8y-00CVN5-2c
	for linux-nvme@lists.infradead.org;
	Thu, 07 Sep 2023 17:50:19 +0000
Message-ID: <64c88fce-9745-4dfa-be65-75994b05817f@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1694109011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zeOCI4aINKlUle4Z4caiMqwno7CVtpizI5fPp9sr6Is=;
	b=QE3/5KpHC4ojsekfrzjhkIdM7mLk9ilq9G8r3IlTF4bxfjh1OpS+VHNT7hw+xQ0pvUDQAn
	pr+Pnhjf/7llofa/8VNhQCyMRDCHNFt+5Zj94dePR1gRIxERExmjUW6YEJr0Jsf3gqC7iH
	ASK3zKmFjPU5MOlA5kYSRBKV8p6DasdR0EuYOWMAWRyElF0jRy4mREcGmA20gVvNiPD5Cu
	II2a7xbGEz9hKaAFBGIbqqa1CnHuVcIebkv3LqUQCjmsHHkLNLI3wohwr/+ZOjWOjZpXWp
	xG+lVDCQZdnUorDlJR05tymGBnmkG+kz8zex2bX85CN3kZ6ySKlSZSc94A9FsWvTroBa1B
	6rQFqzg68PUgsNBAM1gR/o1HMBZkJicLkLSIrApYSt+9ZMgfWvqO4RkOw/lwTHv37H4Znl
	AEQJTsY3Qz+LQuOL6nq+mxHSbTRV8Fushy9EqFF5lQYixi2F7ln3edReitoVpADXZGmnQT
	E8rs8XBbkHNeF+tFCF96wU4Cr/crm0MOAl7hB82AMLEYi4SxpwgO+ZRmcagwZUSSYm8jQW
	b8p42vmGzZJGdYzQEzzIX+exDGHlwlb3rEkdnxhZJT5aBpdo/Qp5THIKtO6Cj6LyVn/MrQ
	ZYYLIivAhkelR8I80SMvCYBkc8BiA24oUzfVGTkWgkpIFgEPL+2bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1694109011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zeOCI4aINKlUle4Z4caiMqwno7CVtpizI5fPp9sr6Is=;
	b=06OBVLGnaG2mqpaU1CxyjlruJJVmVI6UTEEypHu1CHoTgKU8fxsszBZMmefEi6GlLZztBS
	5dl1TL0tUy//t5CA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date: Thu, 7 Sep 2023 20:50:06 +0300
MIME-Version: 1.0
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
To: Bagas Sanjaya <bagasdotme@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Claudio Sampaio <patola@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Linux Stable <stable@vger.kernel.org>
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Content-Language: en-US-large
From: Felix Yan <felixonmars@archlinux.org>
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
In-Reply-To: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ajTduOLHYKtpl0ajI1PCNmk0"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_105017_773929_4124723A 
X-CRM114-Status: GOOD (  13.05  )
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ajTduOLHYKtpl0ajI1PCNmk0
Content-Type: multipart/mixed; boundary="------------Ofy8W1ZH5w46U0oq8rGhaOMo";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Claudio Sampaio <patola@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Linux Stable <stable@vger.kernel.org>
Message-ID: <64c88fce-9745-4dfa-be65-75994b05817f@archlinux.org>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
In-Reply-To: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>

--------------Ofy8W1ZH5w46U0oq8rGhaOMo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS80LzIzIDE0OjA3LCBCYWdhcyBTYW5qYXlhIHdyb3RlOg0KPiBIaSwNCj4gDQo+IEkg
bm90aWNlIGEgcmVncmVzc2lvbiByZXBvcnQgb24gQnVnemlsbGEgWzFdLiBRdW90aW5nIGZy
b20gaXQ6DQo+IA0KPj4gSSBib3VnaHQgYSBuZXcgNCBUQiBMZXhhciBOTTc5MCBhbmQgSSB3
YXMgdXNpbmcga2VybmVsIDYuMy4xMyBhdCB0aGUgdGltZS4gSXQgd2Fzbid0IHJlY29nbml6
ZWQsIHdpdGggdGhlc2UgbWVzc2FnZXMgaW4gZG1lc2c6DQo+Pg0KPj4gWyAzNTguOTUwMTQ3
XSBudm1lIG52bWUwOiBwY2kgZnVuY3Rpb24gMDAwMDowNjowMC4wDQo+PiBbIDM1OC45NTgz
MjddIG52bWUgbnZtZTA6IERldmljZSBub3QgcmVhZHk7IGFib3J0aW5nIGluaXRpYWxpc2F0
aW9uLCBDU1RTPTB4MA0KDQpIaSwNCg0KVGhpcyBsb29rcyB2ZXJ5IG11Y2ggdGhlIHNhbWUg
YXMgdGhlIG90aGVyIE1BWElPIE1BUDE2MDIgaXNzdWUgbWVudGlvbmVkIA0KaW46IA0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC83Y2Q2OTNkZC1hNmQ3LTRhYWItYWVmMC03NmE4
MzY2Y2VlZTZAYXJjaGxpbnV4Lm9yZy8gDQphbmQgTGV4YXIgTk03OTAgaXMgaW5kZWVkIGFs
c28gdXNpbmcgdGhlIHNhbWUgY29udHJvbGxlci4NCg0KQW5kIGFzIEkgaGF2ZSBtZW50aW9u
ZWQgdGhlcmUsIDYuMSBMVFMga2VybmVscyB3b3JrIHdpdGhvdXQgYSBwcm9ibGVtIA0KYmVj
YXVzZSB0aGVyZSBhcmUgc29tZSBkaWZmZXJlbmNlcyBhdCBjYWxjdWxhdGluZyB0aGUgcmVz
dWx0aW5nIHRpbWVvdXQgDQp2YWx1ZS4gTGF0ZXN0IGtlcm5lbHMgaW5jbHVkaW5nIHRoZSA2
LjUueCBicmFuY2ggbWFrZXMgdGhlIGVuZGluZyByZXN1bHQgDQp6ZXJvIGFuZCBicmVha3Mg
YWxsIDQgVGlCIFNTRHMgd2l0aCB0aGlzIGNvbnRyb2xsZXIgYXMgZmFyIGFzIEkga25vdy4N
Cg0KLS0gDQpSZWdhcmRzLA0KRmVsaXggWWFuDQoNCg==

--------------Ofy8W1ZH5w46U0oq8rGhaOMo--

--------------ajTduOLHYKtpl0ajI1PCNmk0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmT6DU4FAwAAAAAACgkQeGxj8zDXy5Kg
wA/+KUKz9G1U2JqA2jAoiwr4SE+IHiFlRkcjA0dtR/u01rfKnPMPBqttkJjEsD8NEoSE3+c7OgS5
0hlvx6Hb2UmsUI29H7aZLmj6lInQVbzs0ZpCODWhttQY9Ao1lGf1HKevLJ/HbvuaO2uiJ9d7qDYK
7f4gkA2TLhrbLakrsdWQkPXFkxFzXuFT/QeUM8C2RQ2HMXou/k2qEuaJu171NPb+UAIvbPSmb9sK
BI7HY/Ym0JvHLxi7wQdsmYKjo4Y3RC8k5fhPXNVuNMMt+vzrnWmSOYmCyiBTfYfRvvmFKB6sB9kK
nbyoNSDmUh4pd/rmp4x6Ybs5XA+XOfOJzSTYHLlJCxVImHrDSGcAUHMSbQ0tuNzwuL4PSHkushmn
HtJwZa09EoSPINL4xNdFsICcPSQOTyXYxf6afkx+mmMKuexB3yAxB/Kvs2cXOymh0LldcDJdJ3Gr
t8dn/8AwIj/qrPwB2GKFqn9IonH3Cb8vsgx8J69D6/qI3r4DMzPz3gWGJSXzM73gu2aLCleo5eU5
kLUTLDkcMMC8k+gZksGwb761M0UNJiBn512B79gbwVVE/xzv8G0c8pLPgAeowPv2Kk0FRRtZaAgO
sFoAGXFv8pUYndnXrLh/hU3lPF8AlRt4GuMTLPfRtlMJnwCQkdTBWjQ4OPU1fX/eWN8f9FnD+QId
71k=
=nJc6
-----END PGP SIGNATURE-----

--------------ajTduOLHYKtpl0ajI1PCNmk0--

