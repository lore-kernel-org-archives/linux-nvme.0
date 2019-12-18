Return-Path: <SRS0=PPGx=2I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A0C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 22:20:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C35218AC
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 22:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AJO4Iaap";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XOFLz8Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C35218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l91jVRh6neIeV2k67LqcSnEsI1uPv3t8XiQ+rUEF/TA=; b=AJO4Iaap80PMsVQZJnMTPnMDZ
	/q+TfbeZtCbm7D3Z7TwIou9YaJ4lXYeNoqDtCi3pJ+xb3h/MRYvu0z4xk1lPkwy4MTM+N7mGOX1pX
	uPCieMoOIUYE8EiLchrmJwtZ3Bm3LivlJthreBUhtRTGBvqkVeXybHsPY4G/BVTxpbreaWeILobsE
	CCshFRHe5cJjSCJE3SDZQs0Jlo2bXz6P9l/XGCfEKBoO0eSyErOmJACjzWFEa2GHthM4HbzZctOzS
	lzbiwsAm7napJR9kTToY0D20hRsjhbn1ITYBEBeTDD55TL6Ph0qebdbhY2p0Cjq+vIja1jwLasWI3
	b8pjR/udg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ihhgT-0000mc-Ne; Wed, 18 Dec 2019 22:20:45 +0000
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihhgP-0000li-Pv
 for linux-nvme@lists.infradead.org; Wed, 18 Dec 2019 22:20:43 +0000
Received: by mail-pj1-x1042.google.com with SMTP id s94so1748714pjc.1
 for <linux-nvme@lists.infradead.org>; Wed, 18 Dec 2019 14:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=igt0beunPmNlRSplFvaKwK02QOjDxcme+4BX0HQ8c/E=;
 b=XOFLz8GptldKyvi/jwcppAzKVoYRJxNJXexI5FCi76ZJeZbRY/9njqbu1y4gcYqcV+
 QCh3dyS+Dqwgp7VBBB0IkgvTEHDC72Nk4qvFgji2v+vNFcb9hae8KM/Xr24uuRRSJDDJ
 VjvGTp0GCFPW4gR67/U8xkVse5m80P93JdxKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=igt0beunPmNlRSplFvaKwK02QOjDxcme+4BX0HQ8c/E=;
 b=ol5kO8QnXkDChjAaE4Kj7LAeResB5A57XEI4bH7Tg6yuQZBsgQ2GLFPxpPA47fhFJS
 7SKdlz/buGybR76V3VeIYOaxmQLzoBzTt2Ur6yXzQsPJVpHsi+hxZaEQbdKEKquygpqQ
 HDLV7qd/cw0vp3BoB9OxmUqAr9kb8aSyCNAUp1m/YB6+XpQ+IbzqdZ9ExuIjrnrZUPzU
 UydXY8/zca22JFMxEpIJRu0KEwxfUFZt/V3/B5ozvN9zIEmNJt1OYbl2E7oa/o5hV80X
 X3GX/sjQBjN9ATbjfr3BLrqVwcSUFhTBBRuKhW1MOjlx+RMiiLQBW3HW1dJY5ydEhwTw
 2AZQ==
X-Gm-Message-State: APjAAAWX9+EKFfg4auOwSGW6Fk/ZcWw5oGRphmR3dCV4qrx8+bvvqiu6
 UA3HLTLuFDp5xash7kDkSvKjtAdbpxpeT8k3RWZXMOXI9x68PN9BYhloP02s30cae/81bVRhWyu
 1bohftCcm75epnc4eRCk8NJTlU5q3BHe8HuFcW5Es79VJQ69nqqLAmGrWjrKs8VklzfyTRls28h
 M+xbtaCw==
X-Google-Smtp-Source: APXvYqyx5nQ5RPpxlIBTOG3HAdr8dBYwPHOa7/76ht36QSmybFMfytrnw6e/iZawDrytHO4izVfsxg==
X-Received: by 2002:a17:90a:f88:: with SMTP id 8mr3186349pjz.72.1576707640265; 
 Wed, 18 Dec 2019 14:20:40 -0800 (PST)
Received: from [10.230.29.90] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b4sm4696210pfd.18.2019.12.18.14.20.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 14:20:39 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: reject I/O to offline device
To: Sagi Grimberg <sagi@grimberg.me>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <2caa40133c444771b706406b928ad88a@kioxia.com>
 <78d980de-b2b8-bd47-fc3f-20314653598e@broadcom.com>
 <c625b332ee124b038da1ae59b02f4e21@kioxia.com>
 <9a73a895-7d6b-21e9-9008-816117be1ff4@broadcom.com>
 <ac9b5d7192fb49ac9bdf19dd35be0ab2@kioxia.com>
 <4963e813-0d99-4890-804a-cd4c9c660607@broadcom.com>
 <ae027c0c-45ab-d412-11f3-39dcf3217434@grimberg.me>
 <e009d8fe-74ec-8c87-30ec-b1ac657b2aa8@suse.de>
 <d7953accf06e418a893b9cc6017b981a@kioxia.com>
 <73006c25-b6a8-fc36-0789-772e3ea59a02@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <bef8f5a3-5dee-ba7d-7423-8ab130b1aa65@broadcom.com>
Date: Wed, 18 Dec 2019 14:20:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <73006c25-b6a8-fc36-0789-772e3ea59a02@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191218_142041_838374_44F23AEE 
X-CRM114-Status: GOOD (  21.58  )
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

CgpPbiAxMi8xNy8yMDE5IDE6NDYgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPgo+IE9uIDEy
LzkvMTkgNzozMCBBTSwgVmljdG9yIEdsYWRrb3Ygd3JvdGU6Cj4+IE9uIDEyLzgvMTkgMTQ6MTgg
UE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4+Cj4+PiBPbiAxMi82LzE5IDExOjE4IFBNLCBT
YWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4+Cj4+Pj4+PiAtLS0KPj4+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMKPj4+Pj4+IGIvZHJpdmVycy9udm1lL2hvc3QvZmFi
cmljcy5jIGluZGV4IDc0Yjg4MTguLmI1OGFiYzEgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9mYWJyaWNzLmMKPj4+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJp
Y3MuYwo+Pj4+Pj4gQEAgLTU0OSw2ICs1NDksOCBAQCBibGtfc3RhdHVzX3QgbnZtZl9mYWlsX25v
bnJlYWR5X2NvbW1hbmQoc3RydWN0Cj4+Pj4+PiBudm1lX2N0cmwgKmN0cmwsCj4+Pj4+PiDCoMKg
IHsKPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY3RybC0+c3RhdGUgIT0gTlZNRV9DVFJM
X0RFTEVUSU5HICYmCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsLT5zdGF0
ZSAhPSBOVk1FX0NUUkxfREVBRCAmJgo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgICEoY3Ry
bC0+c3RhdGUgPT0gTlZNRV9DVFJMX0NPTk5FQ1RJTkcgJiYKPj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICgoa3RpbWVfZ2V0X25zKCkgLSBycS0+c3RhcnRfdGltZV9ucykgPgo+Pj4+Pj4g
amlmZmllc190b19uc2VjcyhycS0+dGltZW91dCkpKSAmJgo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgIWJsa19ub3JldHJ5X3JlcXVlc3QocnEpICYmICEocnEtPmNtZF9mbGFncyAm
Cj4+Pj4+PiBSRVFfTlZNRV9NUEFUSCkpCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBCTEtfU1RTX1JFU09VUkNFOwo+Pj4+Pj4KPj4+Pj4KPj4+Pj4gRGlk
IHlvdSB0ZXN0IHRoaXMgdG8gZW5zdXJlIGl0J3MgZG9pbmcgd2hhdCB5b3UgZXhwZWN0LiBJJ20g
bm90IHN1cmUKPj4+Pj4gdGhhdCBhbGwgdGhlIHRpbWVycyBhcmUgc2V0IHJpZ2h0IGF0IHRoaXMg
cG9pbnQuIE1vc3QgSS9PJ3MgdGltZW91dAo+Pj4+PiBmcm9tIGEgZGVhZGxpbmUgdGltZSBzdGFt
cGVkIGF0IGJsa19tcV9zdGFydF9yZXF1ZXN0KCkuIEJ1dCB0aGF0Cj4+Pj4+IHJvdXRpbmUgaXMg
YWN0dWFsbHkgY2FsbGVkIGJ5IHRoZSB0cmFuc3BvcnRzIHBvc3QgdGhlCj4+Pj4+IG52bWZfY2hl
Y2tfcmVhZHkvZmFpbF9ub25yZWFkeSBjYWxscy7CoCBFLmcuIHRoZSBpbyBpcyBub3QgeWV0IGlu
Cj4+Pj4+IGZsaWdodCwgdGh1cyBxdWV1ZWQsIGFuZCB0aGUgYmxrLW1xIGludGVybmFsIHF1ZXVp
bmcgZG9lc24ndCBjb3VudAo+Pj4+PiBhZ2FpbnN0IHRoZSBpbyB0aW1lb3V0LsKgIEkgY2FuJ3Qg
c2VlIGFueXRoaW5nIHRoYXQgZ3VhcmFudGVlcwo+Pj4+PiBzdGFydF90aW1lX25zIGlzIHNldC4K
Pj4+Pgo+Pj4+IEknbSBub3Qgc3VyZSB0aGlzIGJlaGF2aW9yIGZvciBmYWlsaW5nIEkvTyBhbHdh
eXMgZGVzaXJlZD8gc29tZQo+Pj4+IGNvbnN1bWVycyB3b3VsZCBhY3R1YWxseSBub3Qgd2FudCB0
aGUgSS9PIHRvIGZhaWwgcHJlbWF0dXJlbHkgaWYgd2UKPj4+PiBhcmUgbm90IG11bHRpcGF0aGlu
Zy4uLgo+Pj4+Cj4+Pj4gSSB0aGluayB3ZSBuZWVkIGEgZmFpbF9mYXN0X3RtbyBzZXQgaW4gd2hl
biBlc3RhYmxpc2hpbmcgdGhlCj4+Pj4gY29udHJvbGxlciB0byBnZXQgaXQgcmlnaHQuCj4+Pj4K
Pj4+IEFncmVlZC4gVGhpcyB3aG9sZSBwYXRjaCBsb29rcyBsaWtlIHNvbWVvbmUgaXMgdHJ5aW5n
IHRvIHJlaW1wbGVtZW50Cj4+PiBmYXN0X2lvX2ZhaWxfdG1vIC8gZGV2X2xvc3NfdG1vLgo+Pj4g
QXMgd2UncmUgbW92aW5nIGludG8gdW5yZWxpYWJsZSBmYWJyaWNzIEkgZ3Vlc3Mgd2UnbGwgbmVl
ZCBhIHNpbWlsYXIgCj4+PiBtZWNoYW5pc20uCj4+Pgo+Pj4gQ2hlZXJzLAo+Pj4KPj4+IEhhbm5l
cwo+Pgo+Pgo+PiBGb2xsb3dpbmcgeW91ciBzdWdnZXN0aW9ucywgSSBhZGRlZCBhIG5ldyBzZXNz
aW9uIHBhcmFtZXRlciBjYWxsZWQgCj4+ICJmYXN0X2ZhaWxfdG1vIi4KPj4gVGhlIHRpbWVvdXQg
aXMgbWVhc3VyZWQgaW4gc2Vjb25kcyBmcm9tIHRoZSBjb250cm9sbGVyIHJlY29ubmVjdCwgYW55
IAo+PiBjb21tYW5kIGJleW9uZCB0aGF0IHRpbWVvdXQgaXMgcmVqZWN0ZWQuCj4+IFRoZSBuZXcg
cGFyYW1ldGVyIHZhbHVlIG1heSBiZSBwYXNzZWQgZHVyaW5nIOKAmGNvbm5lY3TigJksIGFuZCBp
dHMgCj4+IGRlZmF1bHQgdmFsdWUgaXMgMzAgc2Vjb25kcy4KPgo+IFRoZSBkZWZhdWx0IHNob3Vs
ZCBiZSBjb25zaXN0ZW50IHdpdGggdGhlIGV4aXN0aW5nIGJlaGF2aW9yLgo+Cj4+IEEgdmFsdWUg
b2YgLTEgbWVhbnMgbm8gdGltZW91dCAoaW4gc2ltaWxhciB0byBjdXJyZW50IGJlaGF2aW9yKS4K
Pj4KPj4gLS0tCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMKPj4gaW5kZXggNzRiODgxOC4uZWQ2YjkxMSAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2ZhYnJpY3MuYwo+PiBAQCAtNDA2LDYgKzQwNiw3IEBACj4+IMKgwqDCoMKgwqAg
fQo+Pgo+PiDCoMKgwqDCoMKgIGN0cmwtPmNudGxpZCA9IGxlMTZfdG9fY3B1KHJlcy51MTYpOwo+
PiArwqDCoMKgIGN0cmwtPnN0YXJ0X3JlY29ubmVjdF9ucyA9IGt0aW1lX2dldF9ucygpOwo+Pgo+
PiDCoCBvdXRfZnJlZV9kYXRhOgo+PiDCoMKgwqDCoMKgIGtmcmVlKGRhdGEpOwo+PiBAQCAtNDc0
LDggKzQ3NSwxMiBAQAo+PiDCoCBib29sIG52bWZfc2hvdWxkX3JlY29ubmVjdChzdHJ1Y3QgbnZt
ZV9jdHJsICpjdHJsKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgaWYgKGN0cmwtPm9wdHMtPm1heF9y
ZWNvbm5lY3RzID09IC0xIHx8Cj4+IC3CoMKgwqDCoMKgwqDCoCBjdHJsLT5ucl9yZWNvbm5lY3Rz
IDwgY3RybC0+b3B0cy0+bWF4X3JlY29ubmVjdHMpCj4+ICvCoMKgwqDCoMKgwqDCoCBjdHJsLT5u
cl9yZWNvbm5lY3RzIDwgY3RybC0+b3B0cy0+bWF4X3JlY29ubmVjdHMpewo+PiArwqDCoMKgwqDC
oMKgwqAgaWYoY3RybC0+bnJfcmVjb25uZWN0cyA9PSAwKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjdHJsLT5zdGFydF9yZWNvbm5lY3RfbnMgPSBrdGltZV9nZXRfbnMoKTsKPj4gKwo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4+ICvCoMKgwqAgfQo+Pgo+PiDCoMKgwqDC
oMKgIHJldHVybiBmYWxzZTsKPj4gwqAgfQo+PiBAQCAtNTQ5LDYgKzU1NCw4IEBACj4+IMKgIHsK
Pj4gwqDCoMKgwqDCoCBpZiAoY3RybC0+c3RhdGUgIT0gTlZNRV9DVFJMX0RFTEVUSU5HICYmCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsLT5zdGF0ZSAhPSBOVk1FX0NUUkxfREVBRCAmJgo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhKGN0cmwtPnN0YXRlID09IE5WTUVfQ1RSTF9DT05ORUNU
SU5HICYmIAo+PiBjdHJsLT5vcHRzLT5mYWlsX2Zhc3RfdG1vX25zID49IDAgJiYKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKChrdGltZV9nZXRfbnMoKSAtIGN0cmwtPnN0YXJ0X3JlY29ubmVj
dF9ucykgPsKgIAo+PiBjdHJsLT5vcHRzLT5mYWlsX2Zhc3RfdG1vX25zKSkgJiYKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgICFibGtfbm9yZXRyeV9yZXF1ZXN0KHJxKSAmJiAhKHJxLT5jbWRfZmxhZ3Mg
JiBSRVFfTlZNRV9NUEFUSCkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gQkxLX1NUU19S
RVNPVVJDRTsKPgo+IEkgY2Fubm90IGNvbXByZWhlbmQgd2hhdCBpcyBnb2luZyBvbiBoZXJlLi4u
Cj4KPiBXZSBzaG91bGQgaGF2ZSBhIGRlZGljYXRlZCBkZWxheWVkX3dvcmsgdGhhdCB0cmFuc2l0
aW9ucyB0aGUgY29udHJvbGxlcgo+IHRvIGEgRkFJTF9GQVNUIHN0YXRlIGFuZCBjYW5jZWxzIHRo
ZSBpbmZsaWdodCByZXF1ZXN0cyBhZ2Fpbi4gVGhpcwo+IHdvcmsgc2hvdWxkIGJlIHRyaWdnZXJl
ZCB3aGVuIHRoZSBlcnJvciBpcyBkZXRlY3RlZC4KCkkgaG9wZSB5b3UncmUgbm90IHN1Z2dlc3Rp
bmcgYSBGQUlMRkFTVCBzdGF0ZS7CoCBObyBuZXcgY29udHJvbGxlciBzdGF0ZSAKaXMgbmVlZGVk
LgoKSSBkbyBhZ3JlZSB0aGF0IG1hbmFnaW5nIHRoZSB0aW1lIHNpbmNlIHRyYW5zaXRpb25pbmcg
dG8gQ09OTkVDVElORyBjYW4gCmJlIGhhbmRsZWQgYmV0dGVyIGFuZCBjYW4gYWRkcmVzcyAiYWJv
cnQgYWxsIG5vdyIgcmF0aGVyIHRoYW4gd2FpdGluZyAKZm9yIHJldHJpZXMgdG8ga2ljayBpbi4K
CkluIG90aGVyIHdvcmRzOgpBZGQgYSBjb250cm9sbGVyIGZsYWcgb2YgImZhaWxmYXN0X2V4cGly
ZWQiCldoZW4gZW50ZXJpbmcgQ09OTkVDVElORywgc2NoZWR1bGUgYSBkZWxheWVkIHdvcmsgaXRl
bSBiYXNlZCBvbiBmYWlsZmFzdCAKdGltZW91dCB2YWx1ZS4KSWYgdHJhbnNpdGlvbiBvdXQgb2Yg
Q09OTkVDVElORywgdGVybWluYXRlIGRlbGF5ZWQgd29yayBpdGVtIGFuZCBlbnN1cmUgCmZhaWxm
YXN0X2V4cGlyZWQgaXMgZmFsc2UuCklmIGRlbGF5ZWQgd29yayBpdGVtIGV4cGlyZXM6IHNldCAi
ZmFpbGZhc3RfZXhwaXJlZCIgZmxhZyB0byB0cnVlLiBSdW4gCnRocm91Z2ggYWxsIGluZmxpZ2h0
IGlvcyBhbmQgY2FuY2VsIHRoZW0uClVwZGF0ZSBudm1mX2ZhaWxfbm9ucmVhZHlfY29tbWFuZCgp
IChhYm92ZSkgcGVyIGFib3ZlLCBidXQgd2l0aCBjaGVjayBvbiAKIiFjdHJsLT5mYWlsZmFzdF9l
eHBpcmVkIi4KCi0tIGphbWVzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
