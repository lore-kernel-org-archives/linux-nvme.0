Return-Path: <SRS0=Ft3w=2H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20684C43603
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2019 21:47:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD63D2082E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2019 21:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K7oaNows"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD63D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3fj9SmZkq+cr8NXJMkvw0o43csTN0ovPCk3vevR2Sz4=; b=K7oaNowsKycvDIyY5bllvbbis
	WFlhJkiYzR4wa7fVAfPsvEomDc+mcm03UB0n1L/bhZZYg9gachV0Mg5Z8ClHVpcz7DvG1gvyYaq7h
	1aooTy1lGvQDMUDX8hVSjArZyCjnk4/g0LheqlMHD8xPOkWYdm6kCf0QNzwTMYVC+f9yEemikXnT/
	os+dgXIb55XdlUoyyING/+4kkmtkwTqViDZQB17f9s/EGW+9LHl0GyQzVKxrr7OqHg3XSwW6I+mrt
	hOd2g/FZTU6pKlrbb4WxBuEMk4+ET1miNS62snLKd447o3NNDjnNEafZ2C9XMT6BCv5hJoSfpKr7L
	Fl9BUCbYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ihKgB-00069G-GT; Tue, 17 Dec 2019 21:46:55 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihKg9-00068H-23
 for linux-nvme@lists.infradead.org; Tue, 17 Dec 2019 21:46:54 +0000
Received: by mail-oi1-f195.google.com with SMTP id p67so1807865oib.13
 for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2019 13:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dJ7naCZOSeCbUFcTc+OKrQR8WSfTEX6YmuydtLkhcm8=;
 b=AHHIHdJSvXd0Ha6eLFYopKkb0GapZ3DzhWgh8VL43Y1ishWfTwATxe2UIedlqXivBW
 Yrpm8n7b56T1fVKShjgfpRx6EMznM1PjD+3V7KU1l0Oas3V+MB55ithAP7r6JMMep0WW
 qzePXNgj7sRWbAaQnJWuNJbY0dGWEE/934Oh5NxFOWSZyDIFryPYIZGgyGpNaUqiiD7V
 4Tm2qefnYcsQMDvdBLn9VP+5vaeWeoIG2wT2EnP4Qx4CIfvec5+31sX2quPGFwR/hhgY
 c4++GftHqWHXT2TIxS6mQH5fD16pZuX2s7B5+3hHYmxejxfusMQ+z9vfj56yTK8JAOf5
 cxww==
X-Gm-Message-State: APjAAAUTjfirITnsmarq8hHX4va2ziEA7boo6990zeYpO/T1WY4GCb9t
 rzODrQCjFo9XNw3TOo+Ibm8uUnN/
X-Google-Smtp-Source: APXvYqzICsZV3xoF9qIszJCliXWeR9GmeG9n1fl1kKBXNAY3olC1d/WQGLYFYCvrCtJ4mfwiQ7WW5Q==
X-Received: by 2002:aca:c715:: with SMTP id x21mr2733686oif.146.1576619208561; 
 Tue, 17 Dec 2019 13:46:48 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id w72sm24926oie.49.2019.12.17.13.46.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 13:46:47 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>, Hannes Reinecke
 <hare@suse.de>, James Smart <james.smart@broadcom.com>,
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
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <73006c25-b6a8-fc36-0789-772e3ea59a02@grimberg.me>
Date: Tue, 17 Dec 2019 13:46:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d7953accf06e418a893b9cc6017b981a@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191217_134653_100532_A839084D 
X-CRM114-Status: GOOD (  22.89  )
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

CgpPbiAxMi85LzE5IDc6MzAgQU0sIFZpY3RvciBHbGFka292IHdyb3RlOgo+IE9uIDEyLzgvMTkg
MTQ6MTggUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4KPj4gT24gMTIvNi8xOSAxMToxOCBQ
TSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4+Cj4+Pj4+IC0tLQo+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4+Pj4+IGIvZHJpdmVycy9udm1lL2hvc3QvZmFi
cmljcy5jIGluZGV4IDc0Yjg4MTguLmI1OGFiYzEgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMv
bnZtZS9ob3N0L2ZhYnJpY3MuYwo+Pj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNz
LmMKPj4+Pj4gQEAgLTU0OSw2ICs1NDksOCBAQCBibGtfc3RhdHVzX3QgbnZtZl9mYWlsX25vbnJl
YWR5X2NvbW1hbmQoc3RydWN0Cj4+Pj4+IG52bWVfY3RybCAqY3RybCwKPj4+Pj4gIMKgIHsKPj4+
Pj4gIMKgwqDCoMKgwqDCoMKgwqAgaWYgKGN0cmwtPnN0YXRlICE9IE5WTUVfQ1RSTF9ERUxFVElO
RyAmJgo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0cmwtPnN0YXRlICE9IE5WTUVf
Q1RSTF9ERUFEICYmCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAhKGN0cmwtPnN0YXRlID09
IE5WTUVfQ1RSTF9DT05ORUNUSU5HICYmCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgo
a3RpbWVfZ2V0X25zKCkgLSBycS0+c3RhcnRfdGltZV9ucykgPgo+Pj4+PiBqaWZmaWVzX3RvX25z
ZWNzKHJxLT50aW1lb3V0KSkpICYmCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWJs
a19ub3JldHJ5X3JlcXVlc3QocnEpICYmICEocnEtPmNtZF9mbGFncyAmCj4+Pj4+IFJFUV9OVk1F
X01QQVRIKSkKPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBC
TEtfU1RTX1JFU09VUkNFOwo+Pj4+Pgo+Pj4+Cj4+Pj4gRGlkIHlvdSB0ZXN0IHRoaXMgdG8gZW5z
dXJlIGl0J3MgZG9pbmcgd2hhdCB5b3UgZXhwZWN0LiBJJ20gbm90IHN1cmUKPj4+PiB0aGF0IGFs
bCB0aGUgdGltZXJzIGFyZSBzZXQgcmlnaHQgYXQgdGhpcyBwb2ludC4gTW9zdCBJL08ncyB0aW1l
b3V0Cj4+Pj4gZnJvbSBhIGRlYWRsaW5lIHRpbWUgc3RhbXBlZCBhdCBibGtfbXFfc3RhcnRfcmVx
dWVzdCgpLiBCdXQgdGhhdAo+Pj4+IHJvdXRpbmUgaXMgYWN0dWFsbHkgY2FsbGVkIGJ5IHRoZSB0
cmFuc3BvcnRzIHBvc3QgdGhlCj4+Pj4gbnZtZl9jaGVja19yZWFkeS9mYWlsX25vbnJlYWR5IGNh
bGxzLsKgIEUuZy4gdGhlIGlvIGlzIG5vdCB5ZXQgaW4KPj4+PiBmbGlnaHQsIHRodXMgcXVldWVk
LCBhbmQgdGhlIGJsay1tcSBpbnRlcm5hbCBxdWV1aW5nIGRvZXNuJ3QgY291bnQKPj4+PiBhZ2Fp
bnN0IHRoZSBpbyB0aW1lb3V0LsKgIEkgY2FuJ3Qgc2VlIGFueXRoaW5nIHRoYXQgZ3VhcmFudGVl
cwo+Pj4+IHN0YXJ0X3RpbWVfbnMgaXMgc2V0Lgo+Pj4KPj4+IEknbSBub3Qgc3VyZSB0aGlzIGJl
aGF2aW9yIGZvciBmYWlsaW5nIEkvTyBhbHdheXMgZGVzaXJlZD8gc29tZQo+Pj4gY29uc3VtZXJz
IHdvdWxkIGFjdHVhbGx5IG5vdCB3YW50IHRoZSBJL08gdG8gZmFpbCBwcmVtYXR1cmVseSBpZiB3
ZQo+Pj4gYXJlIG5vdCBtdWx0aXBhdGhpbmcuLi4KPj4+Cj4+PiBJIHRoaW5rIHdlIG5lZWQgYSBm
YWlsX2Zhc3RfdG1vIHNldCBpbiB3aGVuIGVzdGFibGlzaGluZyB0aGUKPj4+IGNvbnRyb2xsZXIg
dG8gZ2V0IGl0IHJpZ2h0Lgo+Pj4KPj4gQWdyZWVkLiBUaGlzIHdob2xlIHBhdGNoIGxvb2tzIGxp
a2Ugc29tZW9uZSBpcyB0cnlpbmcgdG8gcmVpbXBsZW1lbnQKPj4gZmFzdF9pb19mYWlsX3RtbyAv
IGRldl9sb3NzX3Rtby4KPj4gQXMgd2UncmUgbW92aW5nIGludG8gdW5yZWxpYWJsZSBmYWJyaWNz
IEkgZ3Vlc3Mgd2UnbGwgbmVlZCBhIHNpbWlsYXIgbWVjaGFuaXNtLgo+Pgo+PiBDaGVlcnMsCj4+
Cj4+IEhhbm5lcwo+IAo+IAo+IEZvbGxvd2luZyB5b3VyIHN1Z2dlc3Rpb25zLCBJIGFkZGVkIGEg
bmV3IHNlc3Npb24gcGFyYW1ldGVyIGNhbGxlZCAiZmFzdF9mYWlsX3RtbyIuCj4gVGhlIHRpbWVv
dXQgaXMgbWVhc3VyZWQgaW4gc2Vjb25kcyBmcm9tIHRoZSBjb250cm9sbGVyIHJlY29ubmVjdCwg
YW55IGNvbW1hbmQgYmV5b25kIHRoYXQgdGltZW91dCBpcyByZWplY3RlZC4KPiBUaGUgbmV3IHBh
cmFtZXRlciB2YWx1ZSBtYXkgYmUgcGFzc2VkIGR1cmluZyDigJhjb25uZWN04oCZLCBhbmQgaXRz
IGRlZmF1bHQgdmFsdWUgaXMgMzAgc2Vjb25kcy4KClRoZSBkZWZhdWx0IHNob3VsZCBiZSBjb25z
aXN0ZW50IHdpdGggdGhlIGV4aXN0aW5nIGJlaGF2aW9yLgoKPiBBIHZhbHVlIG9mIC0xIG1lYW5z
IG5vIHRpbWVvdXQgKGluIHNpbWlsYXIgdG8gY3VycmVudCBiZWhhdmlvcikuCj4gCj4gLS0tCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2ZhYnJpY3MuYwo+IGluZGV4IDc0Yjg4MTguLmVkNmI5MTEgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmlj
cy5jCj4gQEAgLTQwNiw2ICs0MDYsNyBAQAo+ICAgCX0KPiAKPiAgIAljdHJsLT5jbnRsaWQgPSBs
ZTE2X3RvX2NwdShyZXMudTE2KTsKPiArCWN0cmwtPnN0YXJ0X3JlY29ubmVjdF9ucyA9IGt0aW1l
X2dldF9ucygpOwo+IAo+ICAgb3V0X2ZyZWVfZGF0YToKPiAgIAlrZnJlZShkYXRhKTsKPiBAQCAt
NDc0LDggKzQ3NSwxMiBAQAo+ICAgYm9vbCBudm1mX3Nob3VsZF9yZWNvbm5lY3Qoc3RydWN0IG52
bWVfY3RybCAqY3RybCkKPiAgIHsKPiAgIAlpZiAoY3RybC0+b3B0cy0+bWF4X3JlY29ubmVjdHMg
PT0gLTEgfHwKPiAtCSAgICBjdHJsLT5ucl9yZWNvbm5lY3RzIDwgY3RybC0+b3B0cy0+bWF4X3Jl
Y29ubmVjdHMpCj4gKwkgICAgY3RybC0+bnJfcmVjb25uZWN0cyA8IGN0cmwtPm9wdHMtPm1heF9y
ZWNvbm5lY3RzKXsKPiArCQlpZihjdHJsLT5ucl9yZWNvbm5lY3RzID09IDApCj4gKwkJCWN0cmwt
PnN0YXJ0X3JlY29ubmVjdF9ucyA9IGt0aW1lX2dldF9ucygpOwo+ICsKPiAgIAkJcmV0dXJuIHRy
dWU7Cj4gKwl9Cj4gCj4gICAJcmV0dXJuIGZhbHNlOwo+ICAgfQo+IEBAIC01NDksNiArNTU0LDgg
QEAKPiAgIHsKPiAgIAlpZiAoY3RybC0+c3RhdGUgIT0gTlZNRV9DVFJMX0RFTEVUSU5HICYmCj4g
ICAJICAgIGN0cmwtPnN0YXRlICE9IE5WTUVfQ1RSTF9ERUFEICYmCj4gKyAgICAgICAgICAgICEo
Y3RybC0+c3RhdGUgPT0gTlZNRV9DVFJMX0NPTk5FQ1RJTkcgJiYgY3RybC0+b3B0cy0+ZmFpbF9m
YXN0X3Rtb19ucyA+PSAwICYmCj4gKyAgICAgICAgICAgICgoa3RpbWVfZ2V0X25zKCkgLSBjdHJs
LT5zdGFydF9yZWNvbm5lY3RfbnMpID4gIGN0cmwtPm9wdHMtPmZhaWxfZmFzdF90bW9fbnMpKSAm
Jgo+ICAgCSAgICAhYmxrX25vcmV0cnlfcmVxdWVzdChycSkgJiYgIShycS0+Y21kX2ZsYWdzICYg
UkVRX05WTUVfTVBBVEgpKQo+ICAgCQlyZXR1cm4gQkxLX1NUU19SRVNPVVJDRTsKCkkgY2Fubm90
IGNvbXByZWhlbmQgd2hhdCBpcyBnb2luZyBvbiBoZXJlLi4uCgpXZSBzaG91bGQgaGF2ZSBhIGRl
ZGljYXRlZCBkZWxheWVkX3dvcmsgdGhhdCB0cmFuc2l0aW9ucyB0aGUgY29udHJvbGxlcgp0byBh
IEZBSUxfRkFTVCBzdGF0ZSBhbmQgY2FuY2VscyB0aGUgaW5mbGlnaHQgcmVxdWVzdHMgYWdhaW4u
IFRoaXMKd29yayBzaG91bGQgYmUgdHJpZ2dlcmVkIHdoZW4gdGhlIGVycm9yIGlzIGRldGVjdGVk
LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
