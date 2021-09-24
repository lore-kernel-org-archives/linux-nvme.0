Return-Path: <SRS0=ODQg=OO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0BFC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 19:16:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0B760F41
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 19:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C0B760F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:Content-ID:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I1ncOd8udAGtWjzsi/49UhCfpFM19VNUVYKvIgpy97s=; b=0cy3boimMtvPSy
	1tZDBN00DxxLr6SmrtRv+CsqnRZ0uNTi9RdmCT7IHtk2SqrucUT8ox1atf+l/UqnFPHtSKa0W1rNd
	4ZHvhr9MsqIxd7iU2EijJ9A60vcWzxJqPJzkLJ2PpAJnHOfXCNn8+UaC4G4cf5v7nvYEdsqmiTST8
	ZJt+ylVgeChcjGLabvDsljlzjyMGSIm+uGQ38eETyiWalaMrG0gz+I38pe+VWCNrE8vAwY/bJJcuf
	hI1kuB+P9+h0QGW2xkB6URua3JcfJX5YjGBt3gOdjbACKsYzPY8+8wIluX/cB4tJVuISSzzPhb35f
	+sGLnEJXjvvBxDpLlMIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTqgZ-00FO7u-TJ; Fri, 24 Sep 2021 19:16:39 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTqgK-00FO7P-7C
 for linux-nvme@lists.infradead.org; Fri, 24 Sep 2021 19:16:25 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20210924191622usoutp0292b6a748bbfb13a25ab5193d8e4ddd71~n2BbTkfoE1851118511usoutp02j;
 Fri, 24 Sep 2021 19:16:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20210924191622usoutp0292b6a748bbfb13a25ab5193d8e4ddd71~n2BbTkfoE1851118511usoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1632510982;
 bh=2ih2lNrllP/6n5kCsz5/pLTiCyzbiDDzQAWajaR69h0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=jbhkzmsoOiFFnBkKIdRpgMJGacan3uE9V2Uoua8vq2yAExiBkp2HMi1hXA5e6AmF0
 wBfy82fJ3Gqv13hHe93V8Koe6PK6JSE5f9mTBeFnLCwaK+bLb5s9tKiUW/KaW0+Tk6
 98vmG/81geZDF6HldkGZ62x15Pqdqz3tMSYMVyZg=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210924191622uscas1p12b43dfa7d260543f89a149957ae92dec~n2BbC8wXH0765707657uscas1p1I;
 Fri, 24 Sep 2021 19:16:22 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id F4.3F.03480.5042E416; Fri,
 24 Sep 2021 15:16:21 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210924191621uscas1p29ef87d42ea7c03fc2bd7ed11fb3591cd~n2BavSHsK0547105471uscas1p2j;
 Fri, 24 Sep 2021 19:16:21 +0000 (GMT)
X-AuditID: cbfec36f-ec7ff70000010d98-e9-614e24050fac
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id A2.20.56110.5042E416; Fri,
 24 Sep 2021 15:16:21 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2242.4; Fri, 24 Sep 2021 12:16:20 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::bc40:3104:26cd:107e]) by
 SSI-EX1.ssi.samsung.com ([fe80::bc40:3104:26cd:107e%7]) with mapi id
 15.01.2242.008; Fri, 24 Sep 2021 12:16:20 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Keith Busch" <kbusch@kernel.org>
Subject: Re: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
Thread-Topic: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
Thread-Index: AQHXr1Y/hb1jIdOeakeoCQAewLLBy6uyTfKAgAChxgCAARg7gA==
Date: Fri, 24 Sep 2021 19:16:20 +0000
Message-ID: <20210924191607.GA2611@bgt-140510-bm01>
In-Reply-To: <CAHj4cs_LDy2GWJFi9O2iaKJF8Ziw+Z1BzzL+QmCoTN1SbRnTMw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-ID: <26EF8377762DB343B04AD8EE1A6E5A89@ssi.samsung.com>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzreV1WFb9Eg+mPrSwmHbrGaDF/2VN2
 i+vnprE5MHtsWtXJ5rF5Sb3H+31X2QKYo7hsUlJzMstSi/TtErgy+javYC84w1fxa+Fb5gbG
 OXxdjJwcEgImEj+Pn2HuYuTiEBJYyShx/+gkFpCEkEArk8TyqY4wRRu2bmWEKFrLKPFn33R2
 COcjo8TzCX9YIZwDjBK3en6wgrSwCRhI/D6+kRnEFhFQkuhfMwFsLLNAlsTvu02MILawQKrE
 mj+XmCBq0iTOXF/EDmE7SZxa3gEWZxFQldi0chVYL6+AscT6pZfAZnIKBEp8fHwZbBejgJjE
 91NrmCDmi0vcejKfCeJsQYlFs/cwQ9hiEv92PWSDsBUl7n9/CbSLA6heU2L9Ln2IVjuJOUtm
 MEPYihJTuh+yQ6wVlDg58wkLRKukxMEVN1hA/pUQWMkhsfd3OxvIHAkBF4n9J/QhaqQlpq+5
 DFVzjVFi+aM5rBDOfUaJ1p6/jBBV1hIL/6xnmsCoMgvJ3bMQbpqF5KZZSG6aheSmBYysqxjF
 S4uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQJTzOl/h/N3MF6/9VHvECMTB+MhRgkOZiUR3s83
 vBKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8zJFTIwXEkhPLEnNTk0tSC2CyTJxcEo1MMkcvXN9
 It+kj8HWDvL9udJTfKqWstyqe3rlPsslV5Mtq7rLWnRXph/fc61W+fbmHMbO+acem5REWSqo
 3+Lp+dZ9x3LhXAZTTaEdPRUaHXLmLAZVd66Y1igfbD8/7cvf7rW/znYVPKsV+7zdyW+DnGX1
 xhdVIpGfd4flsSsxpZalX37spvpQILbyhaGfj3axXDRb0DXpkqXLt65b2f5SpTLn2L5i3lsr
 Oepe88xsnuPW8ERONf2pibjv6m1RxZsWCu1mKtKOb19QxRqzw85iAhfvGykPucTOoPO1IXY6
 s3VcN/VcChQrWapRefVmU/H1wCDux9v/3P/8/qjX1p+nBL7dNExdEbnDZMoq/kXmSizFGYmG
 WsxFxYkAP+jW+qADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWS2cA0SZdVxS/RYN9HDYtJh64xWsxf9pTd
 4vq5aWwOzB6bVnWyeWxeUu/xft9VtgDmKC6blNSczLLUIn27BK6Mvs0r2AvO8FX8WviWuYFx
 Dl8XIyeHhICJxIatWxm7GLk4hARWM0psOLKKFcL5yCjxZP5EFgjnAKPE6nsXWUFa2AQMJH4f
 38gMYosIKEn0r5kAVMTBwSyQJXHspxFIWFggVWLNn0tMECVpErNXbWSEsJ0kTi3vAIuzCKhK
 bFq5igXE5hUwlli/9BIzxK7pTBLbNywFK+IUCJT4+Pgy2F5GATGJ76fWgMWZBcQlbj2ZzwTx
 goDEkj3nmSFsUYmXj/+xQtiKEve/v2SHuE1TYv0ufYhWO4k5S2YwQ9iKElO6H7JD3CAocXLm
 ExaIVkmJgytusExglJiFZNsshEmzkEyahWTSLCSTFjCyrmIULy0uzk2vKDbOSy3XK07MLS7N
 S9dLzs/dxAiMztP/DsfsYLx366PeIUYmDsZDjBIczEoivJ9veCUK8aYkVlalFuXHF5XmpBYf
 YpTmYFES5/WInRgvJJCeWJKanZpakFoEk2Xi4JRqYDLmjdzt1/btwfzt6ySY9tR1KYh2V/Uk
 rfXcsDT/xvlf6rN4Zbvab/n5X9Xvk8k7oF3kNtVU0HBbHudRlRyDw4uPV39qKX2bz8/uuUj9
 g8HNx+4dTr+0HQXvRDD2bP+2uCK+UiI6qTKP+ePqvKRLxcu2pW+6nLD1c2XURd5bs7cWbGmd
 I33afkdXsf8UX+7Nn/J2LI+aICCtHOPvuPP5BZ0XH9hqPZPCltavur/K7e7KHYFcVmEzV4mw
 tOr+uGByqSF91VId84bXCRs2pRwyyVeJKBLZGSp5f/Zcvs0L2dYpJein9/RP9en0LbO769uz
 uFIkaNFmrymrNP84mpdsbTif0vzh/uzKJA6D2AfPlFiKMxINtZiLihMByhS0yj0DAAA=
X-CMS-MailID: 20210924191621uscas1p29ef87d42ea7c03fc2bd7ed11fb3591cd
CMS-TYPE: 301P
X-CMS-RootMailID: 20210922020425uscas1p22ca979458bbbb94c243af890bdca04b6
References: <CGME20210922020425uscas1p22ca979458bbbb94c243af890bdca04b6@uscas1p2.samsung.com>
 <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
 <20210923165410.GA489884@bgt-140510-bm01>
 <CAHj4cs_LDy2GWJFi9O2iaKJF8Ziw+Z1BzzL+QmCoTN1SbRnTMw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210924_121624_490005_E22ADB86 
X-CRM114-Status: GOOD (  25.25  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBTZXAgMjQsIDIwMjEgYXQgMTA6MzM6MTRBTSArMDgwMCwgWWkgWmhhbmcgd3JvdGU6
DQo+IE9uIEZyaSwgU2VwIDI0LCAyMDIxIGF0IDEyOjU4IEFNIEFkYW0gTWFuemFuYXJlcw0KPiA8
YS5tYW56YW5hcmVzQHNhbXN1bmcuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgU2VwIDIy
LCAyMDIxIGF0IDA5OjU2OjQ3QU0gKzA4MDAsIFlpIFpoYW5nIHdyb3RlOg0KPiA+ID4gSGVsbG8N
Cj4gPiA+DQo+ID4gPiBJIGZvdW5kIHRoaXMgaXNzdWUgZHVyaW5nIHRoZSBudm1lIHJlbW92YWwg
dGVzdCwgSSBkaWQgc29tZSBkZWJ1ZyBjb2RlDQo+ID4gPiBmb3VuZCBpdCB3YXMgZmFpbGVkIGR1
cmluZyBudm1lICJDU1RTIOKAkyBDb250cm9sbGVyIFN0YXR1cyIgcmVhZCwgY291bGQNCj4gPiA+
IGFueW9uZSBoZWxwIGNoZWNrIGlmIHRoaXMgaXMgb25lIEhXIG9yIFNXIGlzc3VlPw0KPiA+DQo+
ID4gSGVsbG8gWWksDQo+ID4NCj4gPiBXaGF0IGlzIHRoZSBudm1lIHJlbW92YWwgdGVzdD8gV2hl
biBJIGdldCBhY2Nlc3MgdG8gdGhlIHRlc3QgSSB3aWxsIHJ1biBpdCBvbg0KPiA+IHRoZSBIVyBv
biBteSBjdXJyZW50IG1hY2hpbmUgdG8gc2VlIHdoYXQgaGFwcGVucy4gSSBkb24ndCBoYXZlIHRo
ZSBzYW1lIFNTRCBpbg0KPiA+IG15IGN1cnJlbnQgdGVzdCBzeXN0ZW0sIGJ1dCBJIHdpbGwgbWFr
ZSBzdXJlIEkgYW0gYWJsZSB0byBydW4gdGhlIHRlc3Qgb24gdGhlDQo+ID4gc2FtZSBIVyB5b3Ug
YXJlIGhhdmluZyBpc3N1ZXMgd2l0aC4NCj4gPg0KPiBIaSBBZGFtDQo+IEhlcmUgaXMgdGhlIHN0
ZXBzLCBhbmQgdGhlIHNlcnZlciBJIHVzZWQgaXMgREVMTCBSNzMweGQgYW5kIERFTEwgUjY0MCwN
Cj4gZmVlbCBmcmVlIHRvIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIG1vcmUgaW5mbywgdGhhbmtz
Lg0KPiANCj4gIyBsc3BjaSB8IGdyZXAgLWkgbnZtZQ0KPiA4NzowMC4wIE5vbi1Wb2xhdGlsZSBt
ZW1vcnkgY29udHJvbGxlcjogU2Ftc3VuZyBFbGVjdHJvbmljcyBDbyBMdGQNCj4gTlZNZSBTU0Qg
Q29udHJvbGxlciBTTTk4MS9QTTk4MS9QTTk4Mw0KPiAjZWNobyAxID4vc3lzL2J1cy9wY2kvZGV2
aWNlcy8wMDAwXDo4N1w6MDAuMC9yZW1vdmUNCj4gI2VjaG8gMSA+L3N5cy9idXMvcGNpL3Jlc2Nh
bg0KDQpUaGlzIGlzIGVub3VnaCBpbmZvIGZvciBub3cuIEkgY2FuJ3QgcmVwcm9kdWNlIHRoZSBw
cm9ibGVtIG9uIHRoZSBwbGF0Zm9ybSANCkkgYW0gY3VycmVudGx5IHVzaW5nLiBJIHdpbGwgdHJ5
IHRvIHRyYWNrIGRvd24gdGhlIHNhbWUgaHcgYW5kIGZ3IHRoYXQgeW91IA0KYXJlIHVzaW5nLCBy
ZXRlc3QsIGFuZCBzZW5kIGFuIHVwZGF0ZS4NCg0KDQo+IA0KPiBUaGFua3MNCj4gWWkNCj4gCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
