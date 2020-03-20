Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ECEC4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 22:59:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C83B20663
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 22:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a6yfdwcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C83B20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FXmCStPJsAEt+FenbkR9gOqHaNdgxzziZJLjtEGhoQY=; b=a6yfdwcLa2YnZtEt8lkiVttqX
	uO4qq84LdwC1eyV2Eo1oon1vXi3EgcCGRkj1g8K63Jrz10Ai2QNzde9x+a78zCcQJwij5Gcr6Ttdg
	J6w8FclpBuXbO/l7l3MFKWH1C5teHbH5Wdo5BDhBKhWF6pW9/naqyD2N0jBI7B+JRPNNmleu5OGHj
	p5XMEVrBnvNcg9hB2Z60W0q2ztgE3YlknISEtRyYoJIlDqB7YHg61o/Sc2b8iPgeHXMBm+SGRtlxO
	VHiM50ka3OrkdhRjR0KJlAOWMfJPQrk+4lY5K30Se1o/0QqS0Mvud8JfIco9wERyYiUDFvIbMSumE
	/14LCtzlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFQbl-0006Pa-0r; Fri, 20 Mar 2020 22:59:17 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFQbi-0006Ov-5H
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 22:59:15 +0000
Received: by mail-wm1-f49.google.com with SMTP id 6so8196708wmi.5
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 15:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fjmy2Z3dDKqhs6UCoyKy28waGQsYoRpIQBh2PDEqnUk=;
 b=lso/FQZna9+Rd93islXKfp4ZLlmQAVrOZvhKhqGtsyITCNkVk2rgL7eqx4W0pf+wFI
 ZBXCw85MIBKg8ifSRCJVUxKoUzdHnleDJig7WPISZMY7F2UggIdP8JpTRY6qYo4cGvtZ
 Ga2jc82QuB41t4Xzz5mdDME82ZNPfY4SgaDSMsuoJj846l20P/Mj2QzVrWEXcEhkJ7zI
 m1+gWT/EpRSwFD1osYj+sowHfWrEoiL9O1Mp2XRvURxPr7uVgXgN7am7yH8josJfrToK
 fWF2+cnhp8jRHD4pQvgzpiHKo+0J4ELnV9K0aCsGtf9HS1WYa41GyLDQ9Y0sT5APYOdM
 e91Q==
X-Gm-Message-State: ANhLgQ1s6ZHr9zU1/ajfrofndlaXqBzHP0kmjP0cqMTWyoqnJUtmElKq
 eD91hRrL85awIWnqKjVvWkZWqfLK
X-Google-Smtp-Source: ADFU+vthn5b2mI6NvDYZjWk7lHu0qJ3y+lKOXnMqf9ELGv8URrK5tziuk5Rwuyp4GVfJWwPx1g8W4Q==
X-Received: by 2002:a7b:c94b:: with SMTP id i11mr4151000wml.113.1584745152393; 
 Fri, 20 Mar 2020 15:59:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b9e4:7d48:9c27:2b02?
 ([2601:647:4802:9070:b9e4:7d48:9c27:2b02])
 by smtp.gmail.com with ESMTPSA id f15sm10466150wru.83.2020.03.20.15.59.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Mar 2020 15:59:11 -0700 (PDT)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
From: Sagi Grimberg <sagi@grimberg.me>
To: tasleson@redhat.com, linux-nvme@lists.infradead.org
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
Message-ID: <f18d9173-b94e-69d6-022a-20603e8cb42b@grimberg.me>
Date: Fri, 20 Mar 2020 15:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_155914_201582_08CFD5AD 
X-CRM114-Status: GOOD (  10.49  )
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

Cj4gVGhhbmtzIFRvbmkgZm9yIHJlcG9ydGluZywKPiAKPj4gIyBta2ZzLmV4dDQgL2Rldi9udm1l
MG4xCj4+Cj4+IFvCoCAxMjUuMDMxMjU0XSBudm1lLWZhYnJpY3MgY3RsOiBGYWlsZWQgdG8gcmVh
ZCBzbWFydCBsb2cgKGVycm9yIC01KQo+PiBbwqAgMTI1LjAzMTUwOV0gbnZtZSBudm1lMDogbmV3
IGN0cmw6IE5RTgo+PiAibnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3MuZGlzY292ZXJ5IiwgYWRk
ciAxOTIuMTY4LjIuODA6ODAwOQo+PiBbwqAgMTI1LjAzNDEzM10gbnZtZSBudm1lMDogUmVtb3Zp
bmcgY3RybDogTlFOCj4+ICJucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkiCj4+
IFvCoCAxMjUuMjQ2ODI3XSBudm1lIG52bWUwOiBjcmVhdGluZyAxIEkvTyBxdWV1ZXMuCj4+IFvC
oCAxMjUuMjQ5MzU2XSBudm1lIG52bWUwOiBtYXBwZWQgMS8wLzAgZGVmYXVsdC9yZWFkL3BvbGwg
cXVldWVzLgo+PiBbwqAgMTI1LjI1MDc4OF0gbnZtZSBudm1lMDogbmV3IGN0cmw6IE5RTgo+PiAi
bnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6TlZNZjp1dWlkOjIzZDlkM2UwLWE4M2UtNDVkNy1h
OTAyLTNlODA2NzkzODVmOCIsIAo+Pgo+PiBhZGRyIDE5Mi4xNjguMi44MDo4MDA5Cj4+IFvCoCAx
MjUuMjU3MTE1XSBudm1lMG4xOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDM0
MzU5NzM4MzY4Cj4+IFvCoCAxNTMuMTg4NjIwXSBibGtfdXBkYXRlX3JlcXVlc3Q6IEkvTyBlcnJv
ciwgZGV2IG52bWUwYzBuMSwgc2VjdG9yCj4+IDY3MTA4NzM2IG9wIDB4OTooV1JJVEVfWkVST0VT
KSBmbGFncyAweDUwMDA4MDAgcGh5c19zZWcgMCBwcmlvIGNsYXNzIDAKPj4gW8KgIDE1My4xOTEz
OTVdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczoKPj4gMDAw
MDAwMDAwMDAwMDAwOAo+PiBbwqAgMTUzLjE5MTQ0MF0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNj
ZXNzIGluIGtlcm5lbCBtb2RlCj4+IFvCoCAxNTMuMTkxNDY4XSAjUEY6IGVycm9yX2NvZGUoMHgw
MDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UKPj4gW8KgIDE1My4xOTE0OTVdIFBHRCAwIFA0RCAwCj4+
IFvCoCAxNTMuMTkxNTEzXSBPb3BzOiAwMDAwIFsjMV0gU01QIFBUSQo+PiBbwqAgMTUzLjE5MTUz
NF0gQ1BVOiAwIFBJRDogMjM3IENvbW06IGt3b3JrZXIvMDoxSCBOb3QgdGFpbnRlZAo+PiA1LjUu
OS0yMDAuZmMzMS54ODZfNjQgIzEKPj4gW8KgIDE1My4xOTE1NzRdIEhhcmR3YXJlIG5hbWU6IGlu
bm90ZWsgR21iSCBWaXJ0dWFsQm94L1ZpcnR1YWxCb3gsIEJJT1MKPj4gVmlydHVhbEJveCAxMi8w
MS8yMDA2Cj4+IFvCoCAxNTMuMTkxNjE5XSBXb3JrcXVldWU6IG52bWVfdGNwX3dxIG52bWVfdGNw
X2lvX3dvcmsgW252bWVfdGNwXQo+PiBbwqAgMTUzLjE5MTY2MF0gUklQOiAwMDEwOm52bWVfdGNw
X2lvX3dvcmsrMHgzMDMvMHg3OTAgW252bWVfdGNwXQo+IAo+IENhbiB5b3Ugc2hhcmUgd2hpY2gg
bGluZSAqKG52bWVfdGNwX2lvX3dvcmsrMHgzMDMpIG1hcCB0bz8KCkFsc28sIGRvZXMgdGhpcyBy
ZXByb2R1Y2Ugd2l0aCBmaWxlIGJhY2tlbmQ/IEknbSBub3QgYWJsZSB0bwpyZXByb2R1Y2UgdGhp
cyBvbiBteSB2bXMgKHJ1bm5pbmcgS1ZNIHRob3VnaCkuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
