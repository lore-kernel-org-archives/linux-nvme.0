Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9D7C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 18:16:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B700610CA
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 18:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B700610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kLTRqGPQabn+0M1z8/pBrLDKgmFrkpJte/C0Bdbaqf4=; b=h6QEnDf91H+UYPi0K/cG5jSzX
	uy0yx1sxH5uVVef5+7UN4dMyfONrPrOszTlWTpuO4dQiUn4LF8igDPthCEd36KmQ5WHkCFwOz5i7p
	2C/nwV4OSO55Q5zaf/t21bJadCtU283mSSxI/hSZA71GXIfc6KeMsKq1ClIALNwb7P0iSnPKkYWW5
	HHfAtdF8gtqB9Rw1E4J/+haJCcb1vo2PabF93XMGDNUgaMG0X1PeYnlB4YVbvqlHvJiHje3ObT4n2
	af5vC7+EktQ9CV4rT3bZh9aBMEcIp7v4AoCjFiVjYNmj9HZ8B0HfrEgP+sRikLRT1ToYw3MVeYILJ
	kvX24LYzg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUZCE-008szr-VL; Thu, 08 Apr 2021 18:16:03 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUZCA-008szM-Na
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 18:16:01 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210408181555euoutp0143c3f8ba3be4b172203e5a8cda926ced~z9LZxyDOa1007110071euoutp01X
 for <linux-nvme@lists.infradead.org>; Thu,  8 Apr 2021 18:15:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210408181555euoutp0143c3f8ba3be4b172203e5a8cda926ced~z9LZxyDOa1007110071euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617905755;
 bh=0uyvun3hXjGOfRclQCyL0vzuaCp8dE6ZPnjosni0owM=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=CUZ+/5colCvLRakvBXUESt05s8jUXdinutFToDZPmEBp3Js/BADOh/tC+DSIeqFKe
 jZWrYRghlq/2UBKhtKZA8K5nHHKqSwXnZNYL0B3D3o7CZW/W5rDySI7koOJObD6NHF
 eazYyciHjeMfqcN84ZPryVvSp5vt+Ksg1LHhf5cU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210408181555eucas1p2d4828728c4dd724e0b278ffd29dec9f5~z9LZpebNO0213002130eucas1p29;
 Thu,  8 Apr 2021 18:15:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id A1.85.09452.B584F606; Thu,  8
 Apr 2021 19:15:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210408181554eucas1p25a1785a238c47011c0986c63284dfc92~z9LZG2BiN0213102131eucas1p2y;
 Thu,  8 Apr 2021 18:15:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210408181554eusmtrp1877280da06aba8f7f73402b7cd719466~z9LZGDcLw2528825288eusmtrp1L;
 Thu,  8 Apr 2021 18:15:54 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-55-606f485b67c1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 8C.6A.08696.A584F606; Thu,  8
 Apr 2021 19:15:54 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210408181554eusmtip108693558663ceb8597dd8399ff28df5e~z9LY4sYuK1990619906eusmtip1s;
 Thu,  8 Apr 2021 18:15:54 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 8 Apr 2021 19:15:53 +0100
Date: Thu, 8 Apr 2021 20:15:53 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Dmitry Monakhov
 <dmtrmonakhov@yandex-team.ru>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210408181553.jlqsq664av2vs65u@mpHalley.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408121538.GA12948@lst.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87rRHvkJBhO/CFnMuv2axeLum/cs
 FitXH2WymHToGqPF5V1z2CzmL3vK7sDmsWlVJ5vH5iX1HrtvNrB5fN4k59F+oJvJ49XF9ewB
 bFFcNimpOZllqUX6dglcGa+Xf2Iq+MdbcfPbYvYGxlbuLkZODgkBE4l9v/4ydTFycQgJrGCU
 uDzjOzOE84VRYsvyJYwQzmdGiWvHNzHBtKz/MReqZTmjxOFrjaxwVZOuTAerEhLYwigxe20O
 iM0ioCJx5+plVhCbTcBe4tKyW8wgtoiAksTTV2fBVjALbGOUeHLgLTtIQlggVuLH1BNgDbwC
 ThJ3pq9kgrAFJU7OfMICYjMLWEl0fmgCquEAsqUllv/jgAjLSzRvnQ02n1NAR+L8kfvsICUS
 AsoSy6f7QjxQK7H22Bl2kLUSAl84JJaee8oMkXCR2Ns1lxHCFpZ4dXwLO4QtI3F6cg8LREMz
 o8SZNVeYIZweRok/k1YwQmywlug7kwPR4Cix9cw8Nogwn8SNt4IQt/FJTNo2nRkizCvR0SY0
 gVFlFpLHZiF5bBbCY7OQPLaAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYAo6/e/4
 px2Mc1991DvEyMTBeIhRgoNZSYR3R292ghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeVbPXxAsJ
 pCeWpGanphakFsFkmTg4pRqYXDe2navU5m/rtOeyjInlcvcpXO4ZHj3PJk/0q97H5+LTu75m
 Llfr5LyZGrze5YRk6YI71pv1VLxb8k8f1uWWYlVbufPEbDfnExtc1d7EZsnf2uiyZRvj75fT
 PfpbxK9vXhCtETahKzX9rYuA4pM5G9Qy+ZXM5iyXf3Hk17VvJz9u6P6qPVM9Tdlf/q1aUdOa
 2HU/Tl6/vZc7LeITS/9a4U9xAnKP9y37N6/5o+nFCTwzJi7f3u1YbHRWPGGa4Zquq3zPVqTd
 vC0tXf9MSiNZ1yg3Youm0bpDJ2VahcrvKNQuY9jtszPTQOllQo+6/MP0iBQHi6cXvneZCGil
 n3nRP2mtsvxCngn7LdsKFUqVWIozEg21mIuKEwHwsgrqsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7pRHvkJBvdX6FnMuv2axeLum/cs
 FitXH2WymHToGqPF5V1z2CzmL3vK7sDmsWlVJ5vH5iX1HrtvNrB5fN4k59F+oJvJ49XF9ewB
 bFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Ga+X
 f2Iq+MdbcfPbYvYGxlbuLkZODgkBE4n1P+YydTFycQgJLGWUeNl3lhUiISPx6cpHdghbWOLP
 tS42iKKPjBL7ji5lgXC2MErMuDqRDaSKRUBF4s7Vy2DdbAL2EpeW3WIGsUUElCSevjrLCNLA
 LLCNUeLJgbdgY4UFYiV+TD0B1sAr4CRxZ/pKqDtuMkt0XOqHSghKnJz5hAXEZhawkJg5/zzQ
 JA4gW1pi+T8OiLC8RPPW2WDLOAV0JM4fuc8OUiIhoCyxfLovxAe1Eq/u72acwCgyC8nQWUiG
 zkIYOgvJ0AWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY3TbsZ9bdjCufPVR7xAjEwfj
 IUYJDmYlEd4dvdkJQrwpiZVVqUX58UWlOanFhxhNgUE0kVlKNDkfmCTySuINzQxMDU3MLA1M
 Lc2MlcR5TY6siRcSSE8sSc1OTS1ILYLpY+LglGpgMvX389K8dLfmxKJ529YpCVro90pODjcJ
 uxfTbGbLpiP9z0XzYH2U06u7OfmXpjMwWYhd0py+74v4kq0Mp1nD/MIap8tledj8YF3Zuo3X
 ItrJx2Cb7Rq/C7PVpV6cmnTo4ds5S+bqNTu/U//8uWPLQf2jpU72384v2ZlVF/bjy0smlZk/
 txVZPHauer1Ze6/iV5ugoz4+l44ES6YyRgltj5n5cOP3Tx8uV3AJycy4dWwGH9P+3YYrZ7KL
 sy7pf3x2qpbM8cWCn2b6qIi7BG5ksREXenzzf5NE5dv2uT4X7RdulXnA+O/XnhipGQmH5ZZu
 /3eY4dXzCUwucZYvnfnTLtx2F4ie+mV5qtzqVW7LipVYijMSDbWYi4oTAftm+mBaAwAA
X-CMS-MailID: 20210408181554eucas1p25a1785a238c47011c0986c63284dfc92
X-Msg-Generator: CA
X-RootMTR: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
References: <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
 <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
 <20210311104712.GA16218@lst.de>
 <CGME20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2@eucas1p1.samsung.com>
 <20210323083749.r272grolxozf3w2f@mpHalley.local>
 <20210323123121.GA31105@lst.de>
 <20210323124322.qchyk7boyzklwv3v@mpHalley.local>
 <20210408103016.5girhv5ctkucovmd@mpHalley.local>
 <20210408121538.GA12948@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_191559_437960_0D78BA7B 
X-CRM114-Status: GOOD (  20.49  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDguMDQuMjAyMSAxNDoxNSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5PbiBUaHUsIEFw
ciAwOCwgMjAyMSBhdCAxMjozMDoxNlBNICswMjAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+
Pj4+IEFsaWduaW5nIHRvIE1EVFMgaXMgb3VyIGN1cnJlbnQgYmVoYXZpb3IsIGFsdGhvdWdoIGFs
bCBrZXJuZWxzIHVwIHRvCj4+Pj4gNS4xMSBoYWQgYSBidWcgaW4gdGhlIGNhbGN1bGF0aW9uLgo+
Pj4KPj4+IEkgc2VlLiBMZXQgbWUgY2hlY2sgaW50ZXJuYWxseSBhbmQgc2VlIHdoYXQncyBnb2lu
ZyBvbiB3aXRoCj4+PiB3cml0ZS16ZXJvZXMgb24gdGhpcyBtb2RlbC4KPj4KPj4gV2Ugc3RpbGwg
bmVlZCB0byBjb25maXJtLCBidXQgaXQgc2VlbXMgbGlrZSBNRFRTIGZvciB3cml0ZS16ZXJvZXMg
aXMKPj4gcmVwb3J0ZWQgd3JvbmcgaW4gdGhlIEZXIHRoYXQgRG1pdHJ5IGlzIHVzaW5nLiBXZSBj
YW4gYXQgbGVhc3QgcmVwcm9kdWNlCj4+IGl0Lgo+Pgo+PiBXb3VsZCBpdCBiZSBhIHBvc3NpYmls
aXR5IHRvIGFkZCBxdWlyayBpbmZyYXN0cnVjdHVyZSB0byBoYXJkY29kZSBNRFRTCj4+IGZvciBG
VyB2ZXJzaW9ucyBwcmlvciBUUDQwNDA/Cj4+Cj4+IEFub3RoZXIgcG9zc2liaWxpdHkgaXMgdG8g
YWRkIHF1aXJrcyB0byB0aGUgVFA0MDQwIHN1cHBvcnQgcGF0Y2hlcyB0bwo+PiBlbmFibGUgdGhp
cyAtIGl0IG1pZ2h0IGFsc28gaGVscCByZWR1Y2UgdGhlIGxpc3Qgb2YgbW9kZWxzIGN1cnJlbnRs
eQo+PiBibGFja2xpc3RlZCBmb3Igd3JpdGUtemVyb2VzLgo+Cj5JJ20gbm90IHN1cmUgSSB1bmRl
cnN0YW5kIHlvdS4gIEJlZm9yZSBUUDQwNDAgdGhlcmUgaXMgb25seSB0aGUgTURUUywKPndoaWNo
IG9ubHkgYXBwbGllcyB0byBkYXRhIHRyYW5zZmVyIGNvbW1hbmRzLCBhbHRob3VnaCB3ZSBhbHNv
Cj4idm9sdW5hcmlseSIgYXBwbHkgaXQgdG8gV3JpdGUgWmVyb2VzLiAgSWYgTURUUyBpcyB3cm9u
ZyB0aGlzIHdvdWxkCj5hbHNvIGFmZmVjdCBub3JtYWwgSS9PLCBzbyB3ZSByZWFsbHkgZWl0aGVy
IG5lZWQgYSBmaXJtd2FyZSB1cGRhdGUKPm9yIGEgcXVpcmsuICBPciBpcyB0aGUgV3JpdGUgWmVy
b2VzIGxpbWl0IGV2ZW4gc21hbGxlciB0aGFuIE1URFM/CgpUaGUgbGF0dGVyLiBUaGUgV3JpdGUg
WmVyb2VzIGxpbWl0IGlzIHNtYWxsZXIgdGhhbiBNRFRTLgoKPkknZCByYXRoZXIgbm90IGFkZCBh
bm90aGVyIHF1aXJrIHdpdGggYSBzcGVjaWZpYyBsaW1pdCBpbiB0aGF0IGNhc2UsCj5hcyB3ZWxs
IGdyb3cgd2F5IHRvbyBtYW55IG9mIHRob3NlLgoKVGhpcyBpcyB3aGF0IEkgaGFkIGluIG1pbmQg
LSBhIHN0cnVjdHVyZSB3aXRoIHRoZSBxdWlya3MgdGhhdCB3b3VsZCBzZXQKdGhlIHdyaXRlIHpl
cm9lcyBsaW1pdCBmb3IgdGhlIGNhc2VzIHByaW9yIHRvIFRQNDA0MCBhbmQgd2hlcmUgdGhpcyBp
cwpsb3dlciB0aGFuIE1EVFMuIEJ1dCBmYWlyIGVub3VnaDsgSSBjYW4gc2VlIGhvdyBwYWluZnVs
IGl0IGNhbiBiZSB0bwptYWludGFpbiB0aGlzLgoKPlRQNDA0MCBpcyB0aGUgd2F5IHRvIGdvIGZv
ciB0aGF0IGNhc2UuCgpJIGFncmVlIFRQNDA0MCBpcyB0aGUgd2F5IHRvIG1vdmUgZm9yd2FyZC4K
CkhlcmUgSSBoYXZlIG9uZSBxdWVzdGlvbjogSG93IGRvIHlvdSBlbnZpc2lvbiBhZGRpbmcgc3Vw
cG9ydCBmb3IgRlcKdXBkYXRlcyB0aGF0IGFkZCBUUDQwNDAgc3VwcG9ydCAob3IgZml4IE1EVFMp
IHdpdGggcmVnYXJkcyB3aXRoIGV4aXN0aW5nCnF1aXJrcy4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
