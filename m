Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65CAC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 00:35:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A507E207BB
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 00:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VvIYvEPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A507E207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wKSwXgy9AQ2u8uMI1TlWuIoJkK/YYXbB8Pg7+1WD7mw=; b=VvIYvEPXQk/E2pBirKtGMAILy
	3XCP4UwTj0J8wGRIst4Iv3h2gc4fv8cVVcSVX7PGzDzqoL/dh2HkjW2D8yrR4itAYnFWgnJNvqZVX
	9a+1beXMviJnG/eR7TghqjuyXrwB8T8Ac6wEcPNTpNunm3QLRiLPZ+CaPzAtJUGpGr3tAlLVvG/Ot
	KJBHa9hTM6j7h4OPRaUQqaqDgX9vTfSxsccoDJuTirIEe0AsrZimoTQ516Kc6GcD8zZzeqWxfrU3f
	1l1syODuHDH5GrPKDC07MEISMwuWoW0jNxHQYi3u57mIoYQvfRTrmquF2C4AouXIeVPbtcE0H+FDq
	cWQSdTV6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8C4l-0004iE-Jh; Wed, 19 Aug 2020 00:35:35 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8C4j-0004hn-9Y
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 00:35:34 +0000
Received: by mail-pf1-f196.google.com with SMTP id y206so10769588pfb.10
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 17:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ypTE8f9+5Lgz4RmVt4n4k2oCHx3aU6I6JbuniMh35j0=;
 b=D3S80PfbIuCXxGb6QUC3GbAEz1m0yYrXEW4ZhChgwOlVPZ/V66W5LPrIIqSHtkJB2E
 5Geg56ysPTbhUt1FdSnpU/sRm5Oa3aXCz9N4VppHqJKmu9MkZ1vpwB92tQX+Umme2FK0
 RpKAs0XOjpsMgKt0m7t3GV9w7E4o19GCGXip3yzbZOa334cMLp34x/kcGYtXu122JKp+
 X+q+oEv3gyMrDyNWuU9CH12T7tUh6Ka6BvhRPYSNoMIfqynw0sad1LYlM9hebK3NGrtp
 2B5bVNqMj5JF7YWr7Hp6PZpRHhkUDb1PFEsNcUxkjyjOLTg4/0qCRuDs21EhDOjMmdoM
 N5Mg==
X-Gm-Message-State: AOAM5304fJ6o73sArAPGdaxfIFP0H5eKKCUrKGBL8iwQbVnF315H2V/l
 8CfKJxiQhs4ebvdNAiX3wmI=
X-Google-Smtp-Source: ABdhPJxkQ74ccpq2rzGJm/8Y5b7gL/jwwHHLwZVkDkqraneCCqeHoYhVw5TGPO6/ACD8VM/14Dm81Q==
X-Received: by 2002:a65:4808:: with SMTP id h8mr15232500pgs.113.1597797332097; 
 Tue, 18 Aug 2020 17:35:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bcd0:fda9:d34d:a3ab?
 ([2601:647:4802:9070:bcd0:fda9:d34d:a3ab])
 by smtp.gmail.com with ESMTPSA id c143sm26751662pfb.84.2020.08.18.17.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 17:35:31 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] nvme-rdma: serialize controller teardown sequences
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-7-sagi@grimberg.me>
 <7c3b10ab-6176-92d8-f2eb-45498f903778@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5f022114-9924-3b71-8746-72cc8457ddf7@grimberg.me>
Date: Tue, 18 Aug 2020 17:35:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7c3b10ab-6176-92d8-f2eb-45498f903778@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_203533_389368_5C522DC1 
X-CRM114-Status: GOOD (  27.95  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzE0LzIwIDI6MTIgUE0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IAo+IAo+IE9uIDgvNi8y
MDIwIDEyOjExIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+PiBJbiB0aGUgdGltZW91dCBoYW5k
bGVyIHdlIG1heSBuZWVkIHRvIGNvbXBsZXRlIGEgcmVxdWVzdCBiZWNhdXNlIHRoZQo+PiByZXF1
ZXN0IHRoYXQgdGltZWQgb3V0IG1heSBiZSBhbiBJL08gdGhhdCBpcyBhIHBhcnQgb2YgYSBzZXJp
YWwgc2VxdWVuY2UKPj4gb2YgY29udHJvbGxlciB0ZWFyZG93biBvciBpbml0aWFsaXphdGlvbi4g
SW4gb3JkZXIgdG8gY29tcGxldGUgdGhlCj4+IHJlcXVlc3QsIHdlIG5lZWQgdG8gZmVuY2UgYW55
IG90aGVyIGNvbnRleHQgdGhhdCBtYXkgY29tcGV0ZSB3aXRoIHVzCj4+IGFuZCBjb21wbGV0ZSB0
aGUgcmVxdWVzdCB0aGF0IGlzIHRpbWluZyBvdXQuCj4+Cj4+IEluIHRoaXMgY2FzZSwgd2UgY291
bGQgaGF2ZSBhIHBvdGVudGlhbCBkb3VibGUgY29tcGxldGlvbiBpbiBjYXNlCj4+IGEgaGFyZC1p
cnEgb3IgYSBkaWZmZXJlbnQgY29tcGV0aW5nIGNvbnRleHQgdHJpZ2dlcmVkIGVycm9yIHJlY292
ZXJ5Cj4+IGFuZCBpcyBydW5uaW5nIGluZmxpZ2h0IHJlcXVlc3QgY2FuY2VsbGF0aW9uIGNvbmN1
cnJlbnRseSB3aXRoIHRoZQo+PiB0aW1lb3V0IGhhbmRsZXIuCj4+Cj4+IFByb3RlY3QgdXNpbmcg
YSBjdHJsIHRlYXJkb3duX2xvY2sgdG8gc2VyaWFsaXplIGNvbnRleHRzIHRoYXQgbWF5Cj4+IGNv
bXBsZXRlIGEgY2FuY2VsbGVkIHJlcXVlc3QgZHVlIHRvIGVycm9yIHJlY292ZXJ5IG9yIGEgcmVz
ZXQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+
Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgfCA2ICsrKysrKwo+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4gaW5kZXggNDRj
NzZmZmJiMjY0Li5hYmMzMTg3MzdmMzUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L3JkbWEuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4gQEAgLTEyMiw2ICsx
MjIsNyBAQCBzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBzb2Nr
YWRkcl9zdG9yYWdlIHNyY19hZGRyOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2N0cmzCoMKg
wqAgY3RybDsKPj4gK8KgwqDCoCBzdHJ1Y3QgbXV0ZXjCoMKgwqDCoMKgwqDCoCB0ZWFyZG93bl9s
b2NrOwo+PiDCoMKgwqDCoMKgIGJvb2zCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVzZV9pbmxpbmVf
ZGF0YTsKPj4gwqDCoMKgwqDCoCB1MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvX3F1ZXVlc1tI
Q1RYX01BWF9UWVBFU107Cj4+IMKgIH07Cj4+IEBAIC05OTcsNiArOTk4LDcgQEAgc3RhdGljIGlu
dCBudm1lX3JkbWFfY29uZmlndXJlX2lvX3F1ZXVlcyhzdHJ1Y3QgCj4+IG52bWVfcmRtYV9jdHJs
ICpjdHJsLCBib29sIG5ldykKPj4gwqAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX3RlYXJkb3duX2Fk
bWluX3F1ZXVlKHN0cnVjdCBudm1lX3JkbWFfY3RybCAqY3RybCwKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGJvb2wgcmVtb3ZlKQo+PiDCoCB7Cj4+ICvCoMKgwqAgbXV0ZXhfbG9jaygmY3RybC0+dGVh
cmRvd25fbG9jayk7Cj4+IMKgwqDCoMKgwqAgYmxrX21xX3F1aWVzY2VfcXVldWUoY3RybC0+Y3Ry
bC5hZG1pbl9xKTsKPj4gwqDCoMKgwqDCoCBudm1lX3JkbWFfc3RvcF9xdWV1ZSgmY3RybC0+cXVl
dWVzWzBdKTsKPj4gwqDCoMKgwqDCoCBpZiAoY3RybC0+Y3RybC5hZG1pbl90YWdzZXQpIHsKPj4g
QEAgLTEwMDcsMTEgKzEwMDksMTMgQEAgc3RhdGljIHZvaWQgCj4+IG52bWVfcmRtYV90ZWFyZG93
bl9hZG1pbl9xdWV1ZShzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4+IMKgwqDCoMKgwqAg
aWYgKHJlbW92ZSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJsa19tcV91bnF1aWVzY2VfcXVldWUo
Y3RybC0+Y3RybC5hZG1pbl9xKTsKPj4gwqDCoMKgwqDCoCBudm1lX3JkbWFfZGVzdHJveV9hZG1p
bl9xdWV1ZShjdHJsLCByZW1vdmUpOwo+PiArwqDCoMKgIG11dGV4X3VubG9jaygmY3RybC0+dGVh
cmRvd25fbG9jayk7Cj4+IMKgIH0KPj4gwqAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX3RlYXJkb3du
X2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBib29sIHJlbW92ZSkKPj4gwqAgewo+PiArwqDCoMKgIG11dGV4X2xvY2soJmN0cmwtPnRl
YXJkb3duX2xvY2spOwo+PiDCoMKgwqDCoMKgIGlmIChjdHJsLT5jdHJsLnF1ZXVlX2NvdW50ID4g
MSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9zdGFydF9mcmVlemUoJmN0cmwtPmN0cmwp
Owo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9zdG9wX3F1ZXVlcygmY3RybC0+Y3RybCk7Cj4+
IEBAIC0xMDI1LDYgKzEwMjksNyBAQCBzdGF0aWMgdm9pZCBudm1lX3JkbWFfdGVhcmRvd25faW9f
cXVldWVzKHN0cnVjdCAKPj4gbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG52bWVfc3RhcnRfcXVldWVzKCZjdHJsLT5jdHJsKTsKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIG52bWVfcmRtYV9kZXN0cm95X2lvX3F1ZXVlcyhjdHJsLCByZW1vdmUpOwo+PiDC
oMKgwqDCoMKgIH0KPj4gK8KgwqDCoCBtdXRleF91bmxvY2soJmN0cmwtPnRlYXJkb3duX2xvY2sp
Owo+PiDCoCB9Cj4+IMKgIHN0YXRpYyB2b2lkIG52bWVfcmRtYV9mcmVlX2N0cmwoc3RydWN0IG52
bWVfY3RybCAqbmN0cmwpCj4+IEBAIC0yMjc4LDYgKzIyODMsNyBAQCBzdGF0aWMgc3RydWN0IG52
bWVfY3RybCAKPj4gKm52bWVfcmRtYV9jcmVhdGVfY3RybChzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPj4gwqDCoMKgwqDC
oCBjdHJsLT5jdHJsLm9wdHMgPSBvcHRzOwo+PiDCoMKgwqDCoMKgIElOSVRfTElTVF9IRUFEKCZj
dHJsLT5saXN0KTsKPj4gK8KgwqDCoCBtdXRleF9pbml0KCZjdHJsLT50ZWFyZG93bl9sb2NrKTsK
Pj4gwqDCoMKgwqDCoCBpZiAoIShvcHRzLT5tYXNrICYgTlZNRl9PUFRfVFJTVkNJRCkpIHsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIG9wdHMtPnRyc3ZjaWQgPQo+IAo+IExvb2tzIGdvb2QgLSBidXQu
Li4uCj4gCj4gSSBoaXQgdGhpcyBzYW1lIGlzc3VlIG9uIEZDIC0gSSB3aWxsIG5lZWQgdG8gcG9z
dCBhIHNpbWlsYXIgcGF0aC4gTXkgCj4gcHJvYmxlbSB3YXMgdGhhdCB0aGUgcmVzZXQvdGVhcmRv
d24gcGF0aCBkdWUgdG8gdGhlIHRpbWVvdXQgdGhlbiByYWNlZCAKPiB3aXRoIHRoZSBlcnJvciB0
aGF0IHRoZSBjb25uZWN0IHBhdGggc2F3IGZvciBpdHMgaW8gdGhhdCBkcm9wcGVkIGludG8gCj4g
dGhlIHBhcnRpYWwtdGVhcmRvd24gc3RlcHMgYXMgY29ubmVjdCBiYWNrZWQtb3V0LsKgwqAgU28g
SSByZWNvbW1lbmQgCj4gbG9va2luZyBhdCBudm1lX3JkbWFfc2V0dXBfY3RybCgpIGFuZCBhbnkg
b2YgaXQncyB0ZWFyZG93biBwYXRocyB0aGF0IAo+IGRvbid0IGhhdmUgdGhlIG11dGV4IGFuZCBt
YXkgcmFjZSB3aXRoIGNhc2VzIHRoYXQgYXJlIHRha2luZyB0aGUgbXV0ZXguCgpHb29mIHBvaW50
LgoKVGhlIHN5bmNocm9uaXphdGlvbiBpcyBub3QgcmVhbGx5IHJlcXVpcmVkIGZvciB0aGUgZW50
aXJlIHRlYXJkb3duIHBhdGgsCmJlY2F1c2UgdGhlIGRlbGV0ZV93b3JrIGFuZCBmbHVzaGluZyB0
aGUgY29ubmVjdF93b3JrLCBhbmQgc3RhdGUgbWFjaGluZQpkb2Vzbid0IGFsbG93IHJlc2V0IGFu
ZCByZWNvbm5lY3QgdG8gY29tcGV0ZS4gU28gdGhpcyBzeW5jaHJvbml6YXRpb24gaXMKcmVhbGx5
IGp1c3QgYWdhaW5zdCB0aGUgdGltZW91dCBoYW5kbGVyLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
