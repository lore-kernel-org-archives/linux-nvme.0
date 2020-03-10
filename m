Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E8AC10F27
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 16:44:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB74222C3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 16:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TwlA1BaD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ISM4lbEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB74222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2DNI7KVynCmNRF//y7CVYMybwNzn6QFS63K76QHN95s=; b=TwlA1BaDb6ir/T3mpdsVf3EcL
	JMTigmBoRSZ6JS4tKWVDOPaao3J5El2AdPbuPheOE1b3sMXMckFjohzWAdxnXQEecDbweJd++7som
	FldpoXSD7RXi8dxM/TqiPYXRRMPjr8Eo3JDmF2A/1rT+3WcafWTIE5/kXkqk6TgK45RVSU7TYm7cP
	a48WKtsqyfFOLfaY/9GtgqV9nmV/phlAp4SgeCeVut88uhowthxachD6pkqD+brl1nJcER5mNrJy0
	tiC3f++vuCkwivn/uq4uq6LW5BI8I7aeTja3Hka21Usmoy6zz2tivklGs748PSuvMtG0OHUgK07RV
	aPd5+NAFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBhzO-00055R-2F; Tue, 10 Mar 2020 16:44:18 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBhzM-00054s-2P
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 16:44:17 +0000
Received: by mail-wm1-x344.google.com with SMTP id a141so2163783wme.2
 for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2020 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=DoNAYDktZbJno5FdeShW9YSQJ4KKHAnUH6JzeKVZXAY=;
 b=ISM4lbEaB+kVxMhUCJq/NDvCKIykEXsZcL3sxQWn407LUvFjSGIQD2YqJhsxgejmo1
 ZpdDGnn9iNo702APzAO5vS1+afAN9Dz9j9HJ5Ht2zYyHt26i6Us6Y7UFSqlT4G4pFjf1
 kmbfJXVUfntoIIrOQ0th92efi8nBhU5oRMRjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DoNAYDktZbJno5FdeShW9YSQJ4KKHAnUH6JzeKVZXAY=;
 b=nEXvNnjcJ8UFyn19BmyMRvtBl90DQb6qsEoJl2jiFuWfcb6yFhzqgV6dsdh4+dGzwF
 PFVqZ5IfB7CLTi5S0Evcmjv5zUkqil1QOhu5TS2cP0QOuIrQeYmwK/B+IDVRmcTisBGr
 UEJ4F+RbuqkT280nrqrnciTtxNtyfUeD1J8WHpqblN09eqmVPHlS1sqkotyRw/iO4Z6x
 4T1Djp2YLwhCql6CvFg8eDOixY0L+vv3gI7Lw+hl0BrBNVIjhOLgBVJV8q18eYAc+0kK
 TExLBTaztsnjUSdtIbCeo/cML17mVVl+lAs3W1eghdBngQ36o8s1HZMal2H4+pbVP3u+
 7hwg==
X-Gm-Message-State: ANhLgQ3cSA60lq9uvBoOKf2pOv+8/6xAF+qcb7HyNv5xhnFI4ICxGP3F
 fOH9KOr3FSc3BqcDENURfYtNmHkwiU05okkyG4IiydPs93vMmewgaIuG8MCHEgHmsrchBvqeOBV
 uX5dnEEO3H4UYV8jK9nIlX+y72A7m9RezCAGTNOtT8/YlzCNip+znLerenuGXt+0jGZYssN/TLj
 7cKaYoFQ==
X-Google-Smtp-Source: ADFU+vtD24GpntfOdCj7C/e1zNjlVn+LOHbc7bgIZosSg1yrP4PhKYjVMSlPqTDlFpTR54eazVPT/A==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr3174378wmh.168.1583858653662; 
 Tue, 10 Mar 2020 09:44:13 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b203sm5019076wmc.45.2020.03.10.09.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 09:44:12 -0700 (PDT)
Subject: Re: [PATCH RFC] nvme/fc: sq flow control
To: Hannes Reinecke <hare@suse.de>, Keith Busch <keith.busch@wdc.com>
References: <20200225235956.28475-1-hare@suse.de>
 <f3d3dc5e-f7d0-b33a-db59-c303a57d343a@broadcom.com>
 <cec299ab-bf39-bdcf-96e9-6380c151cba1@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <9b18e2d9-5362-ceae-a6d4-70934f02ec1d@broadcom.com>
Date: Tue, 10 Mar 2020 09:44:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cec299ab-bf39-bdcf-96e9-6380c151cba1@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_094416_112224_79C6E7EC 
X-CRM114-Status: GOOD (  19.61  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 John Meneghini <john.meneghini@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAzLzkvMjAyMCAxMTo1NSBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IE9uIDMvOS8y
MCAxMDo1OSBQTSwgSmFtZXMgU21hcnQgd3JvdGU6Cj4+Cj4+IE9uIDIvMjUvMjAyMCAzOjU5IFBN
LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+PiBBcyBwZXIgTlZNZS1vRiBzcGVjIHNxIGZsb3cg
Y29udHJvbCBpcyBhY3R1YWxseSBtYW5kYXRvcnksIGFuZCB3ZSBzaG91bGQKPj4+IGJlIGltcGxl
bWVudGluZyBpdCB0byBhdm9pZCB0aGUgY29udHJvbGxlciB0byByZXR1cm4gYSBmYXRhbCBzdGF0
dXMKPj4+IGVycm9yLCBhbmQgdHJ5IHRvIHBsYXkgbmljZWx5IHdpdGggY29udHJvbGxlcnMgdXNp
bmcgc3EgZmxvdyBjb250cm9sCj4+PiB0byBpbXBsZW1lbnQgUW9TLgo+Pj4KPj4+IFNpZ25lZC1v
ZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+Pj4gLS0tCj4+PiAgwqAgZHJp
dmVycy9udm1lL2hvc3QvZmMuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4+
PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2ZjLmMKPj4+IGluZGV4IGExOWRkYjYxMDM5ZC4uNjI4Mzk3YmQ1MDY1IDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3Qv
ZmMuYwo+Pj4gQEAgLTEyLDYgKzEyLDcgQEAKPj4+ICDCoCDCoCAjaW5jbHVkZSAibnZtZS5oIgo+
Pj4gIMKgICNpbmNsdWRlICJmYWJyaWNzLmgiCj4+PiArI2luY2x1ZGUgInRyYWNlLmgiCj4+PiAg
wqAgI2luY2x1ZGUgPGxpbnV4L252bWUtZmMtZHJpdmVyLmg+Cj4+PiAgwqAgI2luY2x1ZGUgPGxp
bnV4L252bWUtZmMuaD4KPj4+ICDCoCAjaW5jbHVkZSA8c2NzaS9zY3NpX3RyYW5zcG9ydF9mYy5o
Pgo+Pj4gQEAgLTM0LDcgKzM1LDggQEAgc3RydWN0IG52bWVfZmNfcXVldWUgewo+Pj4gIMKgwqDC
oMKgwqAgc2l6ZV90wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbW5kX2NhcHN1bGVfbGVuOwo+Pj4g
IMKgwqDCoMKgwqAgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxbnVtOwo+Pj4gIMKgwqDCoMKg
wqAgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXFubzsKPj4+IC0KPj4+ICvCoMKgwqAgaW50
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcV9oZWFkOwo+Pj4gK8KgwqDCoCBpbnTCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNxX3RhaWw7Cj4+PiAgwqDCoMKgwqDCoCB1NjTCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbm5lY3Rpb25faWQ7Cj4+PiAgwqDCoMKgwqDCoCBhdG9taWNfdMKgwqDCoMKgwqDC
oMKgIGNzbjsKPj4+ICDCoCBAQCAtMTY3MSw2ICsxNjczLDggQEAgbnZtZV9mY19mY3Bpb19kb25l
KHN0cnVjdCBudm1lZmNfZmNwX3JlcSAqcmVxKQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY3FlLT5jb21tYW5kX2lkKTsKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGRvbmU7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqDCoMKg
wqDCoCBXUklURV9PTkNFKHF1ZXVlLT5zcV9oZWFkLCBjcHVfdG9fbGUxNihjcWUtPnNxX2hlYWQp
KTsKPj4+ICvCoMKgwqDCoMKgwqDCoCB0cmFjZV9udm1lX3NxKHJxLCBjcWUtPnNxX2hlYWQsIHF1
ZXVlLT5zcV90YWlsKTsKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzdWx0ID0gY3FlLT5yZXN1
bHQ7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IGNxZS0+c3RhdHVzOwo+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+IEBAIC0yMTc3LDYgKzIxODEsMTggQEAgbnZtZV9m
Y191bm1hcF9kYXRhKHN0cnVjdCBudm1lX2ZjX2N0cmwgKmN0cmwsCj4+PiBzdHJ1Y3QgcmVxdWVz
dCAqcnEsCj4+PiAgwqDCoMKgwqDCoCBmcmVxLT5zZ19jbnQgPSAwOwo+Pj4gIMKgIH0KPj4+ICDC
oCArc3RhdGljIGludCBudm1lX2ZjX3VwZGF0ZV9zcV90YWlsKHN0cnVjdCBudm1lX2ZjX3F1ZXVl
ICpxdWV1ZSwgaW50Cj4+PiBpbmNyKQo+Pj4gK3sKPj4+ICvCoMKgwqAgaW50IG9sZF9zcXRsLCBu
ZXdfc3F0bDsKPj4+ICsKPj4+ICvCoMKgwqAgZG8gewo+Pj4gK8KgwqDCoMKgwqDCoMKgIG9sZF9z
cXRsID0gcXVldWUtPnNxX3RhaWw7Cj4+PiArwqDCoMKgwqDCoMKgwqAgbmV3X3NxdGwgPSAob2xk
X3NxdGwgKyBpbmNyKSAlIHF1ZXVlLT5jdHJsLT5jdHJsLnNxc2l6ZTsKPj4+ICvCoMKgwqAgfSB3
aGlsZSAoY21weGNoZygmcXVldWUtPnNxX3RhaWwsIG9sZF9zcXRsLCBuZXdfc3F0bCkgIT0KPj4+
ICvCoMKgwqDCoMKgwqDCoMKgIG9sZF9zcXRsKTsKPj4+ICvCoMKgwqAgcmV0dXJuIG5ld19zcXRs
Owo+Pj4gK30KPj4+ICsKPj4+ICDCoCAvKgo+Pj4gIMKgwqAgKiBJbiBGQywgdGhlIHF1ZXVlIGlz
IGEgbG9naWNhbCB0aGluZy4gQXQgdHJhbnNwb3J0IGNvbm5lY3QsIHRoZQo+Pj4gdGFyZ2V0Cj4+
PiAgwqDCoCAqIGNyZWF0ZXMgaXRzICJxdWV1ZSIgYW5kIHJldHVybnMgYSBoYW5kbGUgdGhhdCBp
cyB0byBiZSBnaXZlbiB0byB0aGUKPj4+IEBAIC0yMjE5LDYgKzIyMzUsMTQgQEAgbnZtZV9mY19z
dGFydF9mY3Bfb3Aoc3RydWN0IG52bWVfZmNfY3RybCAqY3RybCwKPj4+IHN0cnVjdCBudm1lX2Zj
X3F1ZXVlICpxdWV1ZSwKPj4+ICDCoMKgwqDCoMKgIGlmICghbnZtZV9mY19jdHJsX2dldChjdHJs
KSkKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEJMS19TVFNfSU9FUlI7Cj4+PiAgwqAg
K8KgwqDCoCBpZiAoIWN0cmwtPmN0cmwub3B0cy0+ZGlzYWJsZV9zcWZsb3cpIHsKPj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAobnZtZV9mY191cGRhdGVfc3FfdGFpbChxdWV1ZSwgMSkgPT0KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJFQURfT05DRShxdWV1ZS0+c3FfaGVhZCkpIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfZmNfdXBkYXRlX3NxX3RhaWwocXVldWUsIC0xKTsK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBCTEtfU1RTX1JFU09VUkNFOwo+Pj4g
K8KgwqDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqAgfQo+Pj4gKwo+Pj4gIMKgwqDCoMKgwqAgLyog
Zm9ybWF0IHRoZSBGQy1OVk1FIENNRCBJVSBhbmQgZmNwX3JlcSAqLwo+Pj4gIMKgwqDCoMKgwqAg
Y21kaXUtPmNvbm5lY3Rpb25faWQgPSBjcHVfdG9fYmU2NChxdWV1ZS0+Y29ubmVjdGlvbl9pZCk7
Cj4+PiAgwqDCoMKgwqDCoCBjbWRpdS0+ZGF0YV9sZW4gPSBjcHVfdG9fYmUzMihkYXRhX2xlbik7
Cj4+PiBAQCAtMjI4NCw2ICsyMzA4LDkgQEAgbnZtZV9mY19zdGFydF9mY3Bfb3Aoc3RydWN0IG52
bWVfZmNfY3RybCAqY3RybCwKPj4+IHN0cnVjdCBudm1lX2ZjX3F1ZXVlICpxdWV1ZSwKPj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcXVldWUtPmxsZGRfaGFu
ZGxlLCAmb3AtPmZjcF9yZXEpOwo+Pj4gIMKgIMKgwqDCoMKgwqAgaWYgKHJldCkgewo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGlmIChjdHJsLT5jdHJsLm9wdHMtPmRpc2FibGVfc3FmbG93KQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9mY191cGRhdGVfc3FfdGFpbChxdWV1ZSwgLTEpOwo+
Pj4gKwo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogSWYgdGhlIGxsZCBmYWlscyB0byBzZW5kIHRoZSBjb21tYW5kIGlzIHRoZXJlIGFuIGlzc3Vl
IHdpdGgKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHRoZSBjc24gdmFsdWU/wqAgSWYgdGhl
IGNvbW1hbmQgdGhhdCBmYWlscyBpcyB0aGUgQ29ubmVjdCwKPj4gZnlpIC0gSSBOQUsnZCB0aGlz
IHBhdGNoIG1haW5seSBhcyBpdCB3YXNuJ3Qgb3JkZXJpbmcgRVJTUCdzIGJlZm9yZQo+PiBwcm9j
ZXNzaW5nIFNRSEQuCj4+Cj4gSSBrbm93Lgo+Cj4gSSdtIHdvcmtpbmcgb24gVjIsIGFzIEkndmUg
Zm91bmQgdGhhdCBJJ2xsIG5lZWQgdG8gbW9kaWZ5IG52bWV0LCB0b28KPiAod2hpY2ggY3VycmVu
dGx5IGRvZXNuJ3Qgc2VuZCBTUUhEIHVwZGF0ZXMgYXQgYWxsKQo+IEFuZCB0aGUgJ1AnIGJpdCBo
YW5kbGluZyBpcyBtaXNzaW5nIGNvbXBsZXRlbHkuCj4KPiBDaGVlcnMsCj4KPiBIYW5uZXMKCnRo
YXQgc2hvdWxkbid0IGJlIHRydWUuIEkgYWRkZWQgdGhlIHNxaGQgdXBkYXRlczrCoMKgIGNvbW1p
dCAKZjljZjJhNjQ5MTJkNsKgwqAgIm52bWV0OiBzeW5jaHJvbml6ZSBzcWhkIHVwZGF0ZSIKCkFu
ZCAiU1EgSWRlbnRpZmllciBhbmQgUGhhc2UgVGFnIGZpZWxkcyBhcmUgcmVzZXJ2ZWQgYmVjYXVz
ZSB0aGV5IGFyZSAKbm90IHVzZWQgaW4gTlZNZSBvdmVyIEZhYnJpY3MuIgoKLS0gamFtZXMKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1l
IG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
