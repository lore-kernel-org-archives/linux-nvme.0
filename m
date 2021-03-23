Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5070C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 12:43:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F98619B2
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 12:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F98619B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jXcAAWCXlCvgF9UhQfUYl8DjHOqVD86TDAdmCfTsg+Q=; b=QRyg8zaPUM5kk8krfETeD0+FE
	pPOu5JzA2M+w3fbq4cHhZsFkWt2YHVan+Yk/OYnwFe16kjUcRmR+s5nUOkCrghXMLCaXSKF8fERIk
	AhpVoWQJdiGOrCaWQro6CfLKbc9j8K/YZKeSKqS534FVLeVwNX/csBopGUgAqeNKvWLIehd3Ruz7O
	Yh8MHHvMnrmFxqaiXmCWtG+OCoe8aqR/j4f48fE562QpZZRacHgY/VORDEvkTsURmng7ebnHZ7qHU
	FmlGrE36kTehh5x1t5oz4wmfkpPEFJTtlNY533ZvsTNEDEHDGqtLXN3CaZErYhF3q03d0xjsKxYhb
	h63Y5m+5w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOgNf-00EynT-Uk; Tue, 23 Mar 2021 12:43:32 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOgNa-00Eymv-QE
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 12:43:29 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210323124324euoutp01626e5b44d54b602929124c78ea887932~u_Ug76-Xu2163221632euoutp01S
 for <linux-nvme@lists.infradead.org>; Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210323124324euoutp01626e5b44d54b602929124c78ea887932~u_Ug76-Xu2163221632euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1616503404;
 bh=F9YbOt2z/GtVDoNDHvqo1d0D7rtuPi/FENivTe2yq7I=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=i8zgQ84PpqmMFvUjV6LX12JWdVr1wUbUhTWdKuRB3MOT0PCI6n2569Qsmaf9ZtGE0
 ipqLJ2UZCchqMi/oTZM9rTdOZnHr11R+LZck2CmuyujdmrcSbJqFOctBfbYg7BR2RK
 tUQvl/K40EENW5erIsTVV1mYoGxjbGJV+o02iubY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210323124324eucas1p23464d80e834a0702735d1e473b58c08d~u_UgzpKGS2660126601eucas1p2B;
 Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 68.17.09452.C62E9506; Tue, 23
 Mar 2021 12:43:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210323124324eucas1p1b36ca121137d41e9c20cf8e9a684256d~u_UgemILe1361913619eucas1p1S;
 Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210323124324eusmtrp168be8b4e8b7cd6c057ee36b9fb4e2250~u_Ugd6_je1369713697eusmtrp1T;
 Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-9f-6059e26c3269
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.11.08696.C62E9506; Tue, 23
 Mar 2021 12:43:24 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210323124324eusmtip132a8513fcbd6ed470cb4a3fd9a1448ec~u_UgU6BZR1267512675eusmtip1t;
 Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 23 Mar 2021 12:43:23 +0000
Received: from localhost (106.110.32.47) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 12:43:23 +0000
Date: Tue, 23 Mar 2021 13:43:22 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Dmitry Monakhov
 <dmtrmonakhov@yandex-team.ru>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210323124322.qchyk7boyzklwv3v@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323123121.GA31105@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87o5jyITDFat0LKYdfs1i8XdN+9Z
 LFauPspkMenQNUaLy7vmsFnMX/aU3YHNY9OqTjaPzUvqPXbfbGDz+LxJzqP9QDeTx6uL69kD
 2KK4bFJSczLLUov07RK4Mk5Om85S0MxS8W3zFNYGxgXMXYycHBICJhI/Pn9jB7GFBFYwSlw/
 Ld/FyAVkf2GUeHfyESuE85lRYnrbPrYuRg6wjofNfhDx5YwSh48sY4MrOtXYxQzhnGGUaL+3
 lwnC2cso8XbVIlaQJSwCqhILHq1mArHZBOwlLi27BXaIiICSxNNXZxlBGpgFtjFKPDnwFuwq
 YYFYiR9TT4A18wrYSPRemMMMYQtKnJz5hAXEZhawkuj80MQKch+zgLTE8n8cEGF5ieats8HK
 OQV0JDoWnwC7TkLgA4fE/yszmCH+cZGY/DcBEhjCEq+Ob2GHsGUkTk/uYYGob2aUOLPmClRz
 D6PEn0krGCGarSX6zuRANDhKbD0zDxpGfBI33gpC3MAnMWnbdKhVvBIdbUIQ1WoSO5q2Mk5g
 VJ6F5JlZSJ6ZhfDMLCTPLGBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYgk7/O/5p
 B+PcVx/1DjEycTAeYpTgYFYS4W0Jj0gQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkzrtq9pp4IYH0
 xJLU7NTUgtQimCwTB6dUA1OWQgW3ulBT1GTVG70btCsr1+61eFsgeGSGUOdpLt3or/+7ZGdf
 m31e6qP72lOfLpZq/TCvSLx70S568Y3roZrxzE/zdZsNNgtw8t4L//inLeLg3oWGhpurtz/q
 O9YRZ95sb5kx7YdtS9OsI+fM+e6G7ij2sIz+E2X85/Ztt5SDXTZZkgfsdk+8e+K72tuAD13+
 OgIxi8KSTjCvfZdTNklxaunUut0JHLufK9q5vbpTvf5prMoS9XT1qGezzWZZLQmf3PX8lsrn
 0vDSorYf4sujW31NHc0ffzy+Wl1wV8Mkyw5ZhjlSU/8Jek57s2kq34WKK4Et7y7uy8v5u62E
 bQe7t+Czh1tSbbbwnLexdVBiKc5INNRiLipOBAAawunZsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7o5jyITDJafFrGYdfs1i8XdN+9Z
 LFauPspkMenQNUaLy7vmsFnMX/aU3YHNY9OqTjaPzUvqPXbfbGDz+LxJzqP9QDeTx6uL69kD
 2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mk5O
 m85S0MxS8W3zFNYGxgXMXYwcHBICJhIPm/26GLk4hASWMkr8vrSeqYuREyguI/Hpykd2CFtY
 4s+1LjaIoo+MEmuW7mYDSQgJnGGUOLvQGiKxl1Fizpo5jCAJFgFViQWPVoNNYhOwl7i07BYz
 iC0ioCTx9NVZRpAGZoFtjBJPDrwFWyEsECvxY+oJVhCbV8BGovfCHGaIqROYJe5tPcgMkRCU
 ODnzCQuIzSxgITFz/nlGkB+YBaQllv/jgAjLSzRvnQ1WzimgI9Gx+ATzBEbhWUi6ZyHpnoXQ
 PQtJ9wJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBsbjt2M8tOxhXvvqod4iRiYPxEKME
 B7OSCG9LeESCEG9KYmVValF+fFFpTmrxIUZTYFhMZJYSTc4HJoO8knhDMwNTQxMzSwNTSzNj
 JXFekyNr4oUE0hNLUrNTUwtSi2D6mDg4pRqYmuesCrqmsWsZz+fMF/PvbmwqPzhr+Txfi+cf
 J5joefTXi5x+EFJ9TENvyp8ljZp8SRM+vLm030Pnw9Kec3KfcqYvvrljUZaZM6O8crbt+uh0
 3i67XWaT/3zdyL6EP7j77qYXp56ouyaHuute2GnlXuQSupVTaPOdzTOlVj5tDpwyWcwtbe+0
 B3/Pf7jvfvoyy8LNSonX1AUNdAqjPDebeFj5Xki7enDz/e4Te5/OzNJWZ7Wy7z1upNWloGdu
 tYgvWW91bbNJfpjN6a9uJ2Lmze3ZXlNr7ZW5bdaheToxj1xOan6Ys0hxslr+25MWiZzO38Md
 ElyNn25x3lb16ruo1VfLqhvblHbe2T5DRMS1Q4mlOCPRUIu5qDgRAGZDw+pOAwAA
X-CMS-MailID: 20210323124324eucas1p1b36ca121137d41e9c20cf8e9a684256d
X-Msg-Generator: CA
X-RootMTR: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
 <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
 <20210311104712.GA16218@lst.de>
 <CGME20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2@eucas1p1.samsung.com>
 <20210323083749.r272grolxozf3w2f@mpHalley.local>
 <20210323123121.GA31105@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_124326_939859_242E759C 
X-CRM114-Status: GOOD (  11.44  )
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

T24gMjMuMDMuMjAyMSAxMzozMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5PbiBUdWUsIE1h
ciAyMywgMjAyMSBhdCAwOTozNzo0OUFNICswMTAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+
PiBRdWljayBxdWVzdGlvbi4gSXQgc2VlbXMgbGlrZSB0aGUgY3VycmVudCBxdWlyayBzaW1wbHkg
ZGlzYWJsZXMKPj4gd3JpdGUtemVyb2VzLiBXb3VsZCB5b3UgYmUgb3BlbiBmb3IgYSBxdWlyayB0
aGF0IGFsaWducyB3aXRoIE1EVFMgZm9yCj4+IG1vZGVscyB0aGF0IGltcGxlbWVudGVkIGl0IHRo
aXMgd2F5IGJlZm9yZSBUUDQwNDA/Cj4KPkFsaWduaW5nIHRvIE1EVFMgaXMgb3VyIGN1cnJlbnQg
YmVoYXZpb3IsIGFsdGhvdWdoIGFsbCBrZXJuZWxzIHVwIHRvCj41LjExIGhhZCBhIGJ1ZyBpbiB0
aGUgY2FsY3VsYXRpb24uCgpJIHNlZS4gTGV0IG1lIGNoZWNrIGludGVybmFsbHkgYW5kIHNlZSB3
aGF0J3MgZ29pbmcgb24gd2l0aAp3cml0ZS16ZXJvZXMgb24gdGhpcyBtb2RlbC4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
