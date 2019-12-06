Return-Path: <SRS0=+LKq=Z4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B626C43603
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 00:38:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BE72464E
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 00:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UXcbHH1K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y5YrvcNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BE72464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ztW3UqAbVYjnsTjif34tHlAEyxC9Lp6gr1Ir+PULYcQ=; b=UXcbHH1KHv5gD77ZSHFhh8q/+
	qXaQ2IxI2lTEWsdZwh6/qxL5IGJ9i4OsO36tvz4Ya5ACCAoq1qH9NLQExAqSh4voBvfWJ0z83A8cg
	GmaCfV9TPhUWjrAEsjkNup2xGIaIyGFGywUCuc97dblS7utkLeyg66VSNZepoazCI1Vh4i1msYAt1
	atDu6Hxbvq8DhcWk8aJ+UVxzu/6zY+hsox7JnD+RGp9FzjPALNXmFC3CrvnAY5s0FpeGQdrSLWhKh
	5dxcWuzVO9JtA6lx6kd4tnK0eA0yP4cTMIt0cAHbZ6BMN8jTMNUItvzNRya6Y6Vs1Wvu7JRYY5xf+
	/WfIR7KoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1id1dk-0005vq-Tl; Fri, 06 Dec 2019 00:38:36 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1id1di-0005vV-TQ
 for linux-nvme@lists.infradead.org; Fri, 06 Dec 2019 00:38:36 +0000
Received: by mail-wm1-x342.google.com with SMTP id b11so6019965wmj.4
 for <linux-nvme@lists.infradead.org>; Thu, 05 Dec 2019 16:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=XFM4j4MhbGHFVvdDi8+i5MFtgapuLB1vui6Mf01HNkk=;
 b=Y5YrvcNr9Ldh3Hg/7C7vP76TEKp0ViJv2whFIQFWuNSCCPqsU8z2IDPHz9itwnuqT4
 EmZI/Wwa3cO74eycjF6oECCZx8jEV/1WElxseWkIl+aGExzGS6HJDy9J1iDJ0QlmKqM+
 SUpVe6NqlD/IDd4g7z9+Valwkm1parcEu1d90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XFM4j4MhbGHFVvdDi8+i5MFtgapuLB1vui6Mf01HNkk=;
 b=F4y52LC7aAOnAdy4OXAJUf+N3XwsB6iAaoxuquLi8IvbPmxUGfY3HKrFBSMyWZm9mt
 juwkbGWZ4hl+qpMFfFt6wYuKhI0nB6ls1CC1sD+NmiCTUmQQTI7NM8AX/ok+XlaFk9AI
 gB0+x308krZo7RQBKXPPIVlk47rk37pKLU22R+8S567Jr2BBbH2MzjRfA9Q6nbAl7JuG
 wg1Ja1vH/o35SIMwJ6DbicPG/fO1MZtlzWMux1fA4Q4DCnyyxkByNKS0rx127X/RpZNA
 ma4XHuAczH+p/fiCnbUVvFUByFUzBkDLdjhq0BluQ7w7JlcNj5NEmUH2Z3FC5+2HO7l+
 Hwow==
X-Gm-Message-State: APjAAAVysd+kC2K16av/eh7CSoyDy+e0BU/Ff2925NECfDYb2QpODw6A
 739+jL0V/X8NLt64a09gFCDSwizr0ZzPjxz7WAeqxvwiYKs/W638CDrdxy9GpheMlcYDBkgWtkU
 n5C+QAoEJF9gbVp2UM7EV9Ln/fQgXzC5SUHlgl1zhmi8iX6uB0R94q3puWswLZEtjsQTFBuH1eV
 R2tE/BXg==
X-Google-Smtp-Source: APXvYqwvrffHhrEjNRb7luA/tt2esNyDap6UEjtzOd/shzuEnazZVvEowDtJE+XoUANJXZHLxMpP6w==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr7786540wmi.70.1575592710963;
 Thu, 05 Dec 2019 16:38:30 -0800 (PST)
Received: from [10.69.49.110] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id i5sm4074026wrv.34.2019.12.05.16.38.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Dec 2019 16:38:30 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <2caa40133c444771b706406b928ad88a@kioxia.com>
 <78d980de-b2b8-bd47-fc3f-20314653598e@broadcom.com>
 <c625b332ee124b038da1ae59b02f4e21@kioxia.com>
 <9a73a895-7d6b-21e9-9008-816117be1ff4@broadcom.com>
 <ac9b5d7192fb49ac9bdf19dd35be0ab2@kioxia.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <4963e813-0d99-4890-804a-cd4c9c660607@broadcom.com>
Date: Thu, 5 Dec 2019 16:38:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <ac9b5d7192fb49ac9bdf19dd35be0ab2@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191205_163834_951693_4D080A37 
X-CRM114-Status: GOOD (  16.82  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxMi80LzIwMTkgMTI6MjggQU0sIFZpY3RvciBHbGFka292IHdyb3RlOgo+IE9uIDEyLzAz
LzIwMTkgMDY6MTkgUE0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+PiBPbiAxMi8zLzIwMTkgMjowNCBB
TSwgVmljdG9yIEdsYWRrb3Ygd3JvdGU6Cj4+PiBPbiAxMi8wMy8yMDE5IDAwOjQ3IEFNLCBKYW1l
cyBTbWFydCB3cm90ZToKPj4+PiBPCj4+Pj4gVGhlIGNvbnRyb2xsZXItbG9zcy10aW1lb3V0IHNo
b3VsZCBub3QgYWZmZWN0IElPIHRpbWVvdXQgcG9saWN5LCB0aGVzZSBhcmUKPj4gdHdvIGRpZmZl
cmVudCBwb2xpY2llcy4KPj4gT2sgLSB3aGljaCBzYXlzIHdoYXQgZG9lcyBtYWtlIHNlbnNlIHRv
IGFkZCBpcyB0aGUgcG9ydGlvbjoKPj4KPj4gICAgICEoY3RybC0+c3RhdGUgPT0gTlZNRV9DVFJM
X0NPTk5FQ1RJTkcgJiYgKChrdGltZV9nZXRfbnMoKSAtIHJxLT5zdGFydF90aW1lX25zKSA+IGpp
ZmZpZXNfdG9fbnNlY3MocnEtPnRpbWVvdXQpKSkKPj4KPj4KPj4gQnV0IEkgZG9uJ3QgdGhpbmsg
d2UgbmVlZCB0aGUgZmFpbGZhc3QgZmxhZy4KPj4KPj4gLS0gamFtZXMKPiBPSy4gSSB0aGluaywg
aXQncyBnb29kIGVub3VnaC4KPgo+IFRoaXMgaXMgdXBkYXRlZCBwYXRjaDoKPgo+IC0tLQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgYi9kcml2ZXJzL252bWUvaG9z
dC9mYWJyaWNzLmMKPiBpbmRleCA3NGI4ODE4Li5iNThhYmMxIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3Mu
Ywo+IEBAIC01NDksNiArNTQ5LDggQEAgYmxrX3N0YXR1c190IG52bWZfZmFpbF9ub25yZWFkeV9j
b21tYW5kKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsCj4gICB7Cj4gICAgICAgICAgaWYgKGN0cmwt
PnN0YXRlICE9IE5WTUVfQ1RSTF9ERUxFVElORyAmJgo+ICAgICAgICAgICAgICBjdHJsLT5zdGF0
ZSAhPSBOVk1FX0NUUkxfREVBRCAmJgo+ICsgICAgICAgICAgICEoY3RybC0+c3RhdGUgPT0gTlZN
RV9DVFJMX0NPTk5FQ1RJTkcgJiYKPiArICAgICAgICAgICAgKChrdGltZV9nZXRfbnMoKSAtIHJx
LT5zdGFydF90aW1lX25zKSA+IGppZmZpZXNfdG9fbnNlY3MocnEtPnRpbWVvdXQpKSkgJiYKPiAg
ICAgICAgICAgICAgIWJsa19ub3JldHJ5X3JlcXVlc3QocnEpICYmICEocnEtPmNtZF9mbGFncyAm
IFJFUV9OVk1FX01QQVRIKSkKPiAgICAgICAgICAgICAgICAgIHJldHVybiBCTEtfU1RTX1JFU09V
UkNFOwo+CgpEaWQgeW91IHRlc3QgdGhpcyB0byBlbnN1cmUgaXQncyBkb2luZyB3aGF0IHlvdSBl
eHBlY3QuIEknbSBub3Qgc3VyZSAKdGhhdCBhbGwgdGhlIHRpbWVycyBhcmUgc2V0IHJpZ2h0IGF0
IHRoaXMgcG9pbnQuIE1vc3QgSS9PJ3MgdGltZW91dCBmcm9tIAphIGRlYWRsaW5lIHRpbWUgc3Rh
bXBlZCBhdCBibGtfbXFfc3RhcnRfcmVxdWVzdCgpLiBCdXQgdGhhdCByb3V0aW5lIGlzIAphY3R1
YWxseSBjYWxsZWQgYnkgdGhlIHRyYW5zcG9ydHMgcG9zdCB0aGUgCm52bWZfY2hlY2tfcmVhZHkv
ZmFpbF9ub25yZWFkeSBjYWxscy7CoCBFLmcuIHRoZSBpbyBpcyBub3QgeWV0IGluIGZsaWdodCwg
CnRodXMgcXVldWVkLCBhbmQgdGhlIGJsay1tcSBpbnRlcm5hbCBxdWV1aW5nIGRvZXNuJ3QgY291
bnQgYWdhaW5zdCB0aGUgCmlvIHRpbWVvdXQuwqAgSSBjYW4ndCBzZWUgYW55dGhpbmcgdGhhdCBn
dWFyYW50ZWVzIHN0YXJ0X3RpbWVfbnMgaXMgc2V0LgoKLS0gamFtZXMKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlz
dApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
