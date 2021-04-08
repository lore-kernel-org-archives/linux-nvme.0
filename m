Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8707C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 10:30:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C58661168
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 10:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C58661168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DLNTeGPNEPv9omfFDRjHznAd5oZ/5uMRjwJijvhAjB8=; b=LWdGVQubjB00MJI/A3F4w4Ix+
	m/JuYedX1m3X4ylVnDSWI/rVead6DAXemYNe1WDOLhL//vYj7gF0by9KhEBiZk/+nt6ttDzVw32rD
	vukosfT4qhJjjZwhDfVzS4B1WB+4u3Pv4z9pbaboVx/gyYSmiTjZTddn4KsVZFOctLNoCJBOV2ebP
	wwb3+mNlW+aC0zjzWsLrNAqcjDNcHIeQjC8hb8brtyuRnar9x5XzFDOCfagNBrqE8u4Uk2iaAWDcg
	J++ymlSBfvujc7Dolk2Azr6fystKrBnPnJ6JPD+LfXRO1cHrwfZyWrp+AylMSBwo2b0KtGKt7/eho
	/EX8YI/Ow==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lURvg-007eB4-LJ; Thu, 08 Apr 2021 10:30:28 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lURvb-007e9x-JJ
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 10:30:26 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20210408103018euoutp02d34c7949ceccfa850cc2731d5343eb6e~z203meEKp0248902489euoutp02k
 for <linux-nvme@lists.infradead.org>; Thu,  8 Apr 2021 10:30:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20210408103018euoutp02d34c7949ceccfa850cc2731d5343eb6e~z203meEKp0248902489euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617877818;
 bh=Wawn+jC2hksX05vj35MLNFZB6CXJZrElC2FBihBKOn8=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=fyrUi767TI4Mowsd+xLtllYPf2aUy/qeNm84o7xfa05Qt4kGv8jCidXv2ovVWo4ap
 6/kL63gBi40DcZjKzmjMVynFBNn9VGCmiJkjDnRWqXlRa4lDolsn1BJL9Z+H6n5Rnw
 x9WQpCKa5J5m7Ja2HCcgXlDUTV97+iHK9FXgygSY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210408103018eucas1p18da90f664d02ec502f772b58be72301d~z203V62j82828328283eucas1p1f;
 Thu,  8 Apr 2021 10:30:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.21.09452.A3BDE606; Thu,  8
 Apr 2021 11:30:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210408103018eucas1p2a390b6a21fb277c4657878967566df4a~z2027OUvj1880618806eucas1p2O;
 Thu,  8 Apr 2021 10:30:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210408103018eusmtrp1968fb8fa4294c2f9691810c512417f03~z2026lXIX2517025170eusmtrp1F;
 Thu,  8 Apr 2021 10:30:18 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-6a-606edb3aa99f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.80.08696.93BDE606; Thu,  8
 Apr 2021 11:30:17 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210408103017eusmtip25d2c6e428d220e29e75ea26af5b9f138~z202yd2tR0680506805eusmtip2b;
 Thu,  8 Apr 2021 10:30:17 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 8 Apr 2021 11:30:17 +0100
Date: Thu, 8 Apr 2021 12:30:16 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Dmitry Monakhov
 <dmtrmonakhov@yandex-team.ru>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210408103016.5girhv5ctkucovmd@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323124322.qchyk7boyzklwv3v@mpHalley.local>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7pWt/MSDN7Pl7aYdfs1i8XdN+9Z
 LFauPspkMenQNUaLy7vmsFnMX/aU3YHNY9OqTjaPzUvqPXbfbGDz+LxJzqP9QDeTx6uL69kD
 2KK4bFJSczLLUov07RK4Mm5emcZe8Jy94l/LN6YGxpVsXYwcHBICJhLrHtd2MXJyCAmsYJRY
 ddegi5ELyP7CKNHdcJIRwvnMKDH33GU2kCqQhvNz/zJDJJYzSsx6d4wJrurw2q9QzhZGiWfX
 LjKBtLAIqEi0XjrFCGKzCdhLXFp2ixnEFhFQknj66izYDmaBbYwSTw68ZQdJCAvESvyYeoIV
 xOYVsJE4+msiM4QtKHFy5hMWEJtZwEqi80MTK8gTzALSEsv/cUCE5SWat85mBglzCthK3P9S
 AfGmssTy6b4QD9RKrD12hh1kq4TADw6Jll/tLBAJF4m1B46xQtjCEq+Ob2GHsGUkTk/uYYFo
 aGaUOLPmCjOE08Mo8WfSCkaIDdYSfWdyIBocJbaemQcNXz6JG28FIU7jk5i0bTozRJhXoqNN
 aAKjyiwkf81C8tcshL9mIflrASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMD0c/rf
 8U87GOe++qh3iJGJg/EQowQHs5II747e7AQh3pTEyqrUovz4otKc1OJDjNIcLErivKtmr4kX
 EkhPLEnNTk0tSC2CyTJxcEo1MHUrZB3gnbBGt/zmgd8bZwizXz3FJPyKoSdI/Y3/8iidTzdX
 n2apSshfPvvK5jP+n/f/5p639kfr+ffW3/IVHSwCrHboBzDMmHKp27X4vPHsKS6femZrlBZZ
 mmsckTq5SCyHOfDwHMvF2d9Win1UXLpq/sYzKt6GnZU+Ie8frjwVKMQXJlNTKtD38riEY8dZ
 e836p8/ffDtm9OCpYf7xgFffBesiexy4Ns89v1FCKuBDzpL/U5fWvpRTu/HnprBQfXiiUznf
 cuEd1zfOvrVu6e9Z7+8H6+d8LP6sdp2769xsBSnHFgOGTpU/li7mL04EMXya7d0+N+fk16de
 MadD2pS6pj543OnbzH1R/s4ajbNKLMUZiYZazEXFiQCc4vSxrgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7qWt/MSDI7vsbGYdfs1i8XdN+9Z
 LFauPspkMenQNUaLy7vmsFnMX/aU3YHNY9OqTjaPzUvqPXbfbGDz+LxJzqP9QDeTx6uL69kD
 2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mm5e
 mcZe8Jy94l/LN6YGxpVsXYycHBICJhLn5/5l7mLk4hASWMoo8WDyWlaIhIzEpysf2SFsYYk/
 17rAGoQEPjJK3F6VAWFvYZSYPzEGxGYRUJFovXSKEcRmE7CXuLTsFjOILSKgJPH01VlGkAXM
 AtsYJZ4ceAs2VFggVuLH1BNgy3gFbCSO/poIdcVRZom7Kw8wQSQEJU7OfMICYjMLWEjMnH8e
 aBIHkC0tsfwfB0RYXqJ562xmkDCngK3E/S8VIKaEgLLE8um+EOfXSry6v5txAqPILCQzZyGZ
 OQth5iwkMxcwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjM5tx35u2cG48tVHvUOMTByM
 hxglOJiVRHh39GYnCPGmJFZWpRblxxeV5qQWH2I0BYbQRGYp0eR8YHrIK4k3NDMwNTQxszQw
 tTQzVhLnNTmyJl5IID2xJDU7NbUgtQimj4mDU6qBqeXZpYW6qht2VUlkv6hmvzJVTCq96EDu
 n77IF6cemP+WaDEX2umeHvbU5q+HhuEngSntW+9cypXcXnT1Z+rL3N4O8YrIF6IzhY+1enQw
 KeQcfCt0QEMiOGKuzBLVP7sVzm91P+nnVdtp/v+AdfP8r+/VLK79vvCxX19PRf2gZ6+xXtac
 vqYt39xTNE5tLuk3kNpQHbhSNPV3efVk/5cHt9pP+2m06Gf+kmk3A6bveDb5mOV7/jZZ5jWd
 tz4HuWZE3b3z/Z3UyeWbd7KpCrJ3//LeqLHkUapD9n4ulfNyFycfn764I+ipt2XtmZUfL1w9
 mrzolMSyCVPaV5uqrDja4La9qDrqCfPuGTe5/jzLd1NiKc5INNRiLipOBABtl10FVwMAAA==
X-CMS-MailID: 20210408103018eucas1p2a390b6a21fb277c4657878967566df4a
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
 <20210323124322.qchyk7boyzklwv3v@mpHalley.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_113023_744466_51C49627 
X-CRM114-Status: GOOD (  13.87  )
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

T24gMjMuMDMuMjAyMSAxMzo0MywgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPk9uIDIzLjAzLjIw
MjEgMTM6MzEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pk9uIFR1ZSwgTWFyIDIzLCAyMDIx
IGF0IDA5OjM3OjQ5QU0gKzAxMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+PlF1aWNrIHF1
ZXN0aW9uLiBJdCBzZWVtcyBsaWtlIHRoZSBjdXJyZW50IHF1aXJrIHNpbXBseSBkaXNhYmxlcwo+
Pj53cml0ZS16ZXJvZXMuIFdvdWxkIHlvdSBiZSBvcGVuIGZvciBhIHF1aXJrIHRoYXQgYWxpZ25z
IHdpdGggTURUUyBmb3IKPj4+bW9kZWxzIHRoYXQgaW1wbGVtZW50ZWQgaXQgdGhpcyB3YXkgYmVm
b3JlIFRQNDA0MD8KPj4KPj5BbGlnbmluZyB0byBNRFRTIGlzIG91ciBjdXJyZW50IGJlaGF2aW9y
LCBhbHRob3VnaCBhbGwga2VybmVscyB1cCB0bwo+PjUuMTEgaGFkIGEgYnVnIGluIHRoZSBjYWxj
dWxhdGlvbi4KPgo+SSBzZWUuIExldCBtZSBjaGVjayBpbnRlcm5hbGx5IGFuZCBzZWUgd2hhdCdz
IGdvaW5nIG9uIHdpdGgKPndyaXRlLXplcm9lcyBvbiB0aGlzIG1vZGVsLgoKV2Ugc3RpbGwgbmVl
ZCB0byBjb25maXJtLCBidXQgaXQgc2VlbXMgbGlrZSBNRFRTIGZvciB3cml0ZS16ZXJvZXMgaXMK
cmVwb3J0ZWQgd3JvbmcgaW4gdGhlIEZXIHRoYXQgRG1pdHJ5IGlzIHVzaW5nLiBXZSBjYW4gYXQg
bGVhc3QgcmVwcm9kdWNlCml0LgoKV291bGQgaXQgYmUgYSBwb3NzaWJpbGl0eSB0byBhZGQgcXVp
cmsgaW5mcmFzdHJ1Y3R1cmUgdG8gaGFyZGNvZGUgTURUUwpmb3IgRlcgdmVyc2lvbnMgcHJpb3Ig
VFA0MDQwPwoKQW5vdGhlciBwb3NzaWJpbGl0eSBpcyB0byBhZGQgcXVpcmtzIHRvIHRoZSBUUDQw
NDAgc3VwcG9ydCBwYXRjaGVzIHRvCmVuYWJsZSB0aGlzIC0gaXQgbWlnaHQgYWxzbyBoZWxwIHJl
ZHVjZSB0aGUgbGlzdCBvZiBtb2RlbHMgY3VycmVudGx5CmJsYWNrbGlzdGVkIGZvciB3cml0ZS16
ZXJvZXMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
