Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED0DC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 10:26:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CFD61166
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 10:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CFD61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2IYgf9JlYxv8HCuT+nkTIsYL3vIB1WfCkah+6U1h87I=; b=QzwyVbPjTzQ3mwjET6/gj9bN7
	wU/PyRDBKbAgumcenKq/9kmdmzIOc7zr2lnyFf6ZrG2GZNScsMis+xGjOT66Tr1Y37HYwOJ0NVf5J
	txasMjJ/7iE9lm3cDi2LpUQ/M2tqpO0RSrNbRPwTXpx0cEnCYL75z84/7sP5QI/Rm8ydXMROGCF+J
	J/y2qDQEsPa+RTB++M86+oHKloVG9mQ3oaCk6e+sizO28GHHv3ypC0sDOLw/gUIlpr3SUuo74aKt8
	q7IP6zNebqU1JHJnOLkD9LL91IrMAHB2QFd3p7uFB4cOJXbeanJKS8PxgbUF6CwyH4mXZwMamipF7
	38YMdGz5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lURrv-007dTz-NW; Thu, 08 Apr 2021 10:26:35 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lURrq-007dSg-Lk
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 10:26:33 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210408102628euoutp01abf524ef93d591218c716ecd0df731c6~z2xg9hV300705807058euoutp01d
 for <linux-nvme@lists.infradead.org>; Thu,  8 Apr 2021 10:26:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210408102628euoutp01abf524ef93d591218c716ecd0df731c6~z2xg9hV300705807058euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617877588;
 bh=sZDTFk2njFul5OxyU9cQX7yi1wCVXm0i4rHXI5nwrAE=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=JSDxgxyORmTK17KpKsmxRG4zVwOMmlJrkNZPLVjIaDWTyxaaDjZenEzlcKsO1g7Qk
 cSrG2GftrUabcLeomP8BDYx3ALHVXJqzHqhMGgKhdvU6xlk9BUZ0w/cuXECT3vfwgr
 QBHAdPMulB4pS0w5WDqL1sT7y+EGb8MBjovmdxpk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210408102627eucas1p1604fc974035296e91e18403ecf2f4906~z2xgpQS090655906559eucas1p1E;
 Thu,  8 Apr 2021 10:26:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 14.70.09452.35ADE606; Thu,  8
 Apr 2021 11:26:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210408102627eucas1p14545c123f0dfcb2a2eec3e35d6342f89~z2xgFxnuO0585505855eucas1p1K;
 Thu,  8 Apr 2021 10:26:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210408102627eusmtrp2db30f43ba797918f37e1cd1a32f6df96~z2xgE5uUf0664906649eusmtrp2Y;
 Thu,  8 Apr 2021 10:26:27 +0000 (GMT)
X-AuditID: cbfec7f2-ab7ff700000024ec-77-606eda531b20
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 73.50.08705.35ADE606; Thu,  8
 Apr 2021 11:26:27 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210408102627eusmtip2ef492218be0e6bf561a2f99e599fc070~z2xf7Nm302538825388eusmtip2h;
 Thu,  8 Apr 2021 10:26:27 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 8 Apr 2021 11:26:26 +0100
Date: Thu, 8 Apr 2021 12:26:25 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
 <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210408102625.2u6sarhs2qss35ft@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408072641.GA24793@lst.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87rBt/ISDO69N7P4v+cYm8XK1UeZ
 LM6/PcxkMenQNUaL+cueslv86uS2WPf6PYsDu8fE5nfsHjtn3WX3OH9vI4vHplWdbB6bl9R7
 7L7ZwBbAFsVlk5Kak1mWWqRvl8CVMffIVdaC1RwVF661MTcw3mHrYuTkkBAwkXj8/gRjFyMX
 h5DACkaJiad2MkM4XxglZqycB+V8ZpT4OHM2E0zL/MfXWCASyxkl2n+/YIer2rT5GCuEs4VR
 4lTDJ6AMBweLgIrE/rn8IN1sAvYSl5bdYgaxRQSUJJ6+Ogu2nFngAqPEv5mbwa4SFvCUODrj
 I9g6XgEbiaVztjBC2IISJ2c+YQGxmQWsJDo/NLGCzGcWkJZY/o8DIiwv0bx1Nth8TgEdiZb7
 u9hASiQElCWWT/eFeKBWYu2xM+wQdjOnxIMjaRC2i0TbpYmsELawxKvjW6BqZCT+75zPBHIm
 UD2jxJk1V5ghnB5GiT+TVjBCLLCW6DuTA9HgKHH/yUKovXwSN94KQpzGJzFp23RmiDCvREeb
 0ARGlVlI/pqF5K9ZCH/NQvLXAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIGp6PS/
 4592MM599VHvECMTB+MhRgkOZiUR3h292QlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVfNXhMv
 JJCeWJKanZpakFoEk2Xi4JRqYJp38pFlicpOdkEN6TOLw5be+aogalRXtHhudH7pCs687z+F
 rvxxvjWhd+s0jqMrVjAb9VSvULiSckE5boFddebb+n+rciKvztLM+HY5+1l41XrNWz/38qdc
 5zG9Z201446Rouayp1p7srUjhRvSZbb9ubl1lutn0QUhIQ+Wn/7Sydt8+bbqufzCvKZ9W24d
 tplm+iN2po/1TXMbKeb13O7b1KtLLBZkr7kewZMroDUp3mJ1fhpjc9KiWS69bovsL30y/8T4
 REJ0fRzPmS/MkVXuxXkKT45ebf1y8AL7qZUmzusE3Yy0nxQvC5Lx31piOzXE0Ez1i+sOhScH
 566Jn2HlyylRtn0V19HJ3ybav1JiKc5INNRiLipOBAB1e87ftAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7rBt/ISDBasFLT4v+cYm8XK1UeZ
 LM6/PcxkMenQNUaL+cueslv86uS2WPf6PYsDu8fE5nfsHjtn3WX3OH9vI4vHplWdbB6bl9R7
 7L7ZwBbAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
 l6CXMffIVdaC1RwVF661MTcw3mHrYuTkkBAwkZj/+BpLFyMXh5DAUkaJN1ca2SESMhKfrnyE
 soUl/lzrYoMo+sgosW/6fmYIZwujxL1ry4AyHBwsAioS++fygzSwCdhLXFp2ixnEFhFQknj6
 6iwjSD2zwAVGiX8zN4OtFhbwlDg64yMTiM0rYCOxdM4WRoih65glOnZNYoNICEqcnPmEBcRm
 FrCQmDn/PCPIMmYBaYnl/zggwvISzVtngy3jFNCRaLm/C+weCQFlieXTfSEeqJV4dX834wRG
 kVlIhs5CMnQWwtBZSIYuYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERir24793LyDcd6r
 j3qHGJk4GA8xSnAwK4nw7ujNThDiTUmsrEotyo8vKs1JLT7EaAoMoYnMUqLJ+cBkkVcSb2hm
 YGpoYmZpYGppZqwkzrt17pp4IYH0xJLU7NTUgtQimD4mDk6pBqag6OMT0mcUXfecrpCd/v9X
 yP+W+PhNc/ulrYJ+5n2oNPATF104kaNiB4sh43P74ofnn01X/75738S32Yk7zrK2cc3509rP
 3pf79+45q0svD0rmsS/u/708h2tuW8+RKmfFGTV8e7Z5T3/cEhpwbf2Ujw/tFJ6+WRTwXvKI
 ZqtAxK/Jatcy173XMvxy7mgK0BXP8h5psZf+9FEzndJg06u5NenZm5Q65Q3Gj3POWPq+mDvF
 tdfkTcCxEDd+OxHX7OBvV9Kj7L667VJZePOd9YwV3W5RAjsWeXo/dQqs0ppYuKuhYrEHs9yT
 uAs9106uevxS4OCZfvHly+78tD+w7/qJI6JWK7j3PLQLmJLw540SS3FGoqEWc1FxIgAJR0kJ
 XgMAAA==
X-CMS-MailID: 20210408102627eucas1p14545c123f0dfcb2a2eec3e35d6342f89
X-Msg-Generator: CA
X-RootMTR: 20210407171407eucas1p2e8bf869cecf13d6810d797515afff126
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210407171407eucas1p2e8bf869cecf13d6810d797515afff126
References: <20210407141128.GB2805@localhost>
 <20210407142152.GA20466@lst.de> <20210407153536.GA8667@localhost>
 <20210407154730.GC8667@localhost> <20210407164818.GA31878@lst.de>
 <20210407170905.GB9994@localhost>
 <CGME20210407171407eucas1p2e8bf869cecf13d6810d797515afff126@eucas1p2.samsung.com>
 <20210407171400.GA32592@lst.de>
 <20210408071128.pps76zydao3oufqn@mpHalley.localdomain>
 <20210408072641.GA24793@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_112631_206568_E6A92674 
X-CRM114-Status: GOOD (  12.52  )
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

T24gMDguMDQuMjAyMSAwOToyNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5PbiBUaHUsIEFw
ciAwOCwgMjAyMSBhdCAwOToxMToyOEFNICswMjAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+
PiBUaGlzIHdvdWxkIGJlIHVzZWZ1bCBmb3IgZGV2aWNlcyB3aXRoIG1ldGFkYXRhIHRoYXQgaXMg
bm90IHN1cHBvcnRlZCBieQo+PiB0aGUgYmxvY2sgbGF5ZXIsIGkuZS4sIG52bWVfY29uZmlndXJl
X21ldGFkYXRhKCkuCj4KPllvdSBtZWFuIGluIG52bWVfdXBkYXRlX2Rpc2tfaW5mbz8gIEl0IHdv
dWxkIGJlIHRoZSByaWdodCB0aGluZyB0byBkbywKPmJ1dCBiYWNrIGluIHRoZSBkYXkgdGhlIG1h
aW50YWluZXJzIG9wdGVkIGZvciB0aGUgemVybyBjYXBhY2l0eQo+YmxvY2sgZGV2aWNlIGhhY2su
ICBBdCBsZWFzdCB3ZSBub3cgaGF2ZSB0aGUgY2hhciBkZXZpY2UgYXMgd2VsbC4KClllcy4gVGhp
cyBwYXRoIHN0YXJ0cyBpbiBudm1lX3VwZGF0ZV9uc19pbmZvKCkgYW5kIHBhcnQgb2YgaXQgaXMK
bnZtZV9jb25maWd1cmVfbWV0YWRhdGEoKSwgd2hpY2ggbWlnaHQgZmFpbCBpcyB0aGUgbWV0YWRh
dGEgaXMgbm90CnN1cHBvcnRlZC4KCkluIHRoaXMgY2FzZSwgSSBiZWxpZXZlIHdlIHNob3VsZCBz
dGlsbCBjcmVhdGUgdGhlIGNoYXIgZGV2aWNlIHNvIHRoYXQKYW55IE9NRS1zcGVjaWZpYyBOVk1l
IGRldmljZSBjYW4gc3RpbGwgYmUgdXNlZCBmcm9tIHVzZXItc3BhY2Ugd2l0aG91dApyZXF1aXJp
bmcgU1BESyBhbmQgYSBQQ0kgZGV0YWNoLgoKRG9lcyB0aGlzIHNvdW5kIGdvb2QgdG8geW91PwoK
UmVnYXJkaW5nIHRoZSBjdXJyZW50IGxvZ2ljLCBJIHdvdWxkIG5vdCBtaW5kIHRoYXQgdGhlIGJs
b2NrIGRldmljZQpzdGlsbCBhcHBlYXJzIGFzIGEgemVybyBjYXBhY2l0eSB0b28uIFdlIGNhbiB0
aGluayBvZiByZW1vdmluZyB0aGlzIGluCnRoZSBmdXR1cmUgYXMgdGhpcyBwYXRoIGJlY29tZXMg
bW9yZSBzdGFibGUuIEl0IHJlcXVlcmllcyBLYW5jaGFuJ3Mgd29yawpvbiBpb191cmluZyB0byBi
ZSB1c2FibGUgZm9yIEkvTy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
