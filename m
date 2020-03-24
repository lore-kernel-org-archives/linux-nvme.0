Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C012C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 17:17:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63782051A
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 17:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aPCbUXZg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsbrGR1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63782051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7KANZ9+qnXw1TXsQMA8y5a8OR06KWV+M7PB8vF6bAx8=; b=aPCbUXZgOc5DEaQXXZwl7OsIf
	u9rHKj0HuEjKENUaibjxUu8MKxJI6Ayh4L/T5X0k7RQzdRgQzUj6z4GmZtHgYYwywmtuBwB1gkjOL
	sfqLiIxx1V+egGWsaqiUl+f3Ey9ZkJO02voNmEQLQB5AvhQWO0RLw2l6TrP/sC6gXuo72Rh9BmNfC
	PwEdZZXI/YWI1RIqcfHdRPkYZ8/tk2yuaVXUe4/+KER1OBw/ex0pBX5ze5jezM0y3pE6wv1RCOIYJ
	MAPe/IsxSxQ1E26RDiFZ7BkfMdFBVY13S+hUTIlofHYGi0LHOZU/1WdOYCYI1ULbLt4kRPmEFOJKB
	Ur6P5R+Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGnBE-00010U-6Q; Tue, 24 Mar 2020 17:17:32 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGnBB-0000zk-KG
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 17:17:31 +0000
Received: by mail-pj1-x1044.google.com with SMTP id jz1so1370441pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 24 Mar 2020 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ZGYRf7bljlV95062/kAIKLYYfvkZE5yLnQI9lCDJN/o=;
 b=CsbrGR1kakDt6gdEAN2mnN4rODtq3EuL3ugdMU8VFJU3a52q/D9r9aEung8lJYoe52
 vzM/Xc5d3U/CgEiqyLV8fsyyR46cz49XOLjdWRFwVy7svFnXzu9ScHHSrsoYiQ735jMl
 ceMOKstmieXXE3e1LyQf6rHu7ArbQMcmLLPPh2Hd2ON2J864s9CzBzCwIcj6bcFD9v69
 EnF7CQeF7vpnBmYbvhGVbFsKeQsVdPHqbZtUpTtEGP7t3mBfehpkLt12vPgg4BJHeRiD
 EzuUyEAMi25X59mGhwNHaEvkB3qoOfd5g2NBUDh204R4H9b0tKGELCTlUb+wnrn0+dIw
 IQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ZGYRf7bljlV95062/kAIKLYYfvkZE5yLnQI9lCDJN/o=;
 b=olmjlxtaLOHNjE1Vx8uvBzdBnCYCMW4PjgqTLJMahxgQ2ysjJvvbzmp1kb8K3kogjH
 qUWiskKJNYFituW+/qTrLg+E0fFvAJ+tC9BoYYcaxIu4uBBVtv8y9ZyMfnAUm76u7yYo
 24QC+rie/8meqq9uGz9Shm6tkNLdZ+VfWa1l7HKprDw93dmd1A7sx8nemnJsgx+qpI96
 imfg8G9auGxH/Jdp5TRmBdm4rCaSdVF4WpcYgGcUYLxTkzvPCxchi1LNk8W1X9VwQr49
 vFqexHKNngVLZwDvNv59LmzigfIuewagHl2PcTtiiZPEk8y2vCv+9NMPOZMvZ5plHpLD
 q43A==
X-Gm-Message-State: ANhLgQ3xtHW3dZA225Fyg1K6KY9ED2t8vBFIney+Q3hGQdvAJHPzQB7B
 Y0/8Q7H0AJjHeD54e6fcaHejKDDR
X-Google-Smtp-Source: ADFU+vuZIr/pgGhT1UOwU8wrrDA3p2As5Cza9affk2zUmovV5tMCSTipVd4R3F2K03PHkZyZ2ECVeg==
X-Received: by 2002:a17:90a:9f88:: with SMTP id
 o8mr6526752pjp.145.1585070248234; 
 Tue, 24 Mar 2020 10:17:28 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a?
 ([240b:10:2720:5510:a182:288:3ffa:432a])
 by smtp.gmail.com with ESMTPSA id 144sm6660646pgd.29.2020.03.24.10.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 10:17:27 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <2293733b-77d7-6fbb-a81a-b68c10656757@suse.de>
From: Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <5e296f02-27a4-5c6e-35a4-5bd6a53bef3c@gmail.com>
Date: Wed, 25 Mar 2020 02:17:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2293733b-77d7-6fbb-a81a-b68c10656757@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_101729_678297_714F8566 
X-CRM114-Status: GOOD (  16.52  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDIwMjAvMDMvMjQgMTY6MTYsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiAzLzIzLzIw
IDc6MjMgUE0sIFRva3Vub3JpIElrZWdhbWkgd3JvdGU6Cj4+IEN1cnJlbnRseSBkYXRhIGxlbmd0
aCBjYW4gYmUgc3BlY2lmaWVkIGFzIFVJTlRfTUFYIGJ1dCBmYWlsZWQuCj4+IFRoaXMgaXMgY2F1
c2VkIGJ5IHRoZSBtYXggc2VnbWVudHMgcGFyYW1ldGVyIGxpbWl0IHNldCBhcyBVU0hSVF9NQVgu
Cj4+IFRvIHJlc29sdmUgdGhpcyBpc3N1ZSBjaGFuZ2UgdG8gaW5jcmVhc2UgdGhlIHZhbHVlIGxp
bWl0IHJhbmdlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBUb2t1bm9yaSBJa2VnYW1pIDxpa2VnYW1p
LnRAZ21haWwuY29tPgo+PiBDYzogbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnCj4+IENjOiBs
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4gLS0tCj4+IMKgIGJsb2NrL2Jsay1zZXR0
aW5ncy5jwqDCoMKgwqAgfCAyICstCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDIg
Ky0KPj4gwqAgaW5jbHVkZS9saW51eC9ibGtkZXYuaMKgwqAgfCA3ICsrKystLS0KPj4gwqAgMyBm
aWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9ibG9jay9ibGstc2V0dGluZ3MuYyBiL2Jsb2NrL2Jsay1zZXR0aW5ncy5jCj4+IGlu
ZGV4IGM4ZWRhMmU3YjkxZS4uZWQ0MGJkYTU3M2MyIDEwMDY0NAo+PiAtLS0gYS9ibG9jay9ibGst
c2V0dGluZ3MuYwo+PiArKysgYi9ibG9jay9ibGstc2V0dGluZ3MuYwo+PiBAQCAtMjY2LDcgKzI2
Niw3IEBAIEVYUE9SVF9TWU1CT0woYmxrX3F1ZXVlX21heF93cml0ZV96ZXJvZXNfc2VjdG9ycyk7
Cj4+IMKgwqAgKsKgwqDCoCBFbmFibGVzIGEgbG93IGxldmVsIGRyaXZlciB0byBzZXQgYW4gdXBw
ZXIgbGltaXQgb24gdGhlIAo+PiBudW1iZXIgb2YKPj4gwqDCoCAqwqDCoMKgIGh3IGRhdGEgc2Vn
bWVudHMgaW4gYSByZXF1ZXN0Lgo+PiDCoMKgICoqLwo+PiAtdm9pZCBibGtfcXVldWVfbWF4X3Nl
Z21lbnRzKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCB1bnNpZ25lZCBzaG9ydCAKPj4gbWF4X3Nl
Z21lbnRzKQo+PiArdm9pZCBibGtfcXVldWVfbWF4X3NlZ21lbnRzKHN0cnVjdCByZXF1ZXN0X3F1
ZXVlICpxLCB1bnNpZ25lZCBpbnQgCj4+IG1heF9zZWdtZW50cykKPj4gwqAgewo+PiDCoMKgwqDC
oMKgIGlmICghbWF4X3NlZ21lbnRzKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhfc2VnbWVu
dHMgPSAxOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jCj4+IGluZGV4IGE0ZDhjOTBlZTdjYy4uMmI0OGFhYjA5NjllIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jCj4+IEBAIC0yMTkzLDcgKzIxOTMsNyBAQCBzdGF0aWMgdm9pZCBudm1l
X3NldF9xdWV1ZV9saW1pdHMoc3RydWN0IAo+PiBudm1lX2N0cmwgKmN0cmwsCj4+IMKgIMKgwqDC
oMKgwqDCoMKgwqDCoCBtYXhfc2VnbWVudHMgPSBtaW5fbm90X3plcm8obWF4X3NlZ21lbnRzLCAK
Pj4gY3RybC0+bWF4X3NlZ21lbnRzKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJsa19xdWV1ZV9t
YXhfaHdfc2VjdG9ycyhxLCBjdHJsLT5tYXhfaHdfc2VjdG9ycyk7Cj4+IC3CoMKgwqDCoMKgwqDC
oCBibGtfcXVldWVfbWF4X3NlZ21lbnRzKHEsIG1pbl90KHUzMiwgbWF4X3NlZ21lbnRzLCBVU0hS
VF9NQVgpKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGJsa19xdWV1ZV9tYXhfc2VnbWVudHMocSwgbWlu
X3QodTMyLCBtYXhfc2VnbWVudHMsIFVJTlRfTUFYKSk7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoMKg
wqDCoMKgIGlmICgoY3RybC0+cXVpcmtzICYgTlZNRV9RVUlSS19TVFJJUEVfU0laRSkgJiYKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGlzX3Bvd2VyX29mXzIoY3RybC0+bWF4X2h3X3NlY3RvcnMpKQo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2luY2x1ZGUvbGludXgvYmxr
ZGV2LmgKPj4gaW5kZXggZjYyOWQ0MGM2NDVjLi40ZjQyMjRlMjBjMjggMTAwNjQ0Cj4+IC0tLSBh
L2luY2x1ZGUvbGludXgvYmxrZGV2LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaAo+
PiBAQCAtMzM4LDggKzMzOCw4IEBAIHN0cnVjdCBxdWV1ZV9saW1pdHMgewo+PiDCoMKgwqDCoMKg
IHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgIG1heF93cml0ZV96ZXJvZXNfc2VjdG9yczsKPj4g
wqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDCoCBkaXNjYXJkX2dyYW51bGFyaXR5
Owo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgIGRpc2NhcmRfYWxpZ25t
ZW50Owo+PiArwqDCoMKgIHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgIG1heF9zZWdtZW50czsK
Pj4gwqAgLcKgwqDCoCB1bnNpZ25lZCBzaG9ydMKgwqDCoMKgwqDCoMKgIG1heF9zZWdtZW50czsK
Pj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBzaG9ydMKgwqDCoMKgwqDCoMKgIG1heF9pbnRlZ3JpdHlf
c2VnbWVudHM7Cj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgc2hvcnTCoMKgwqDCoMKgwqDCoCBtYXhf
ZGlzY2FyZF9zZWdtZW50czsKPj4gwqAgQEAgLTEwNjcsNyArMTA2Nyw4IEBAIGV4dGVybiB2b2lk
IGJsa19xdWV1ZV9tYWtlX3JlcXVlc3Qoc3RydWN0IAo+PiByZXF1ZXN0X3F1ZXVlICosIG1ha2Vf
cmVxdWVzdF9mbiAqKTsKPj4gwqAgZXh0ZXJuIHZvaWQgYmxrX3F1ZXVlX2JvdW5jZV9saW1pdChz
dHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqLCB1NjQpOwo+PiDCoCBleHRlcm4gdm9pZCBibGtfcXVldWVf
bWF4X2h3X3NlY3RvcnMoc3RydWN0IHJlcXVlc3RfcXVldWUgKiwgCj4+IHVuc2lnbmVkIGludCk7
Cj4+IMKgIGV4dGVybiB2b2lkIGJsa19xdWV1ZV9jaHVua19zZWN0b3JzKHN0cnVjdCByZXF1ZXN0
X3F1ZXVlICosIAo+PiB1bnNpZ25lZCBpbnQpOwo+PiAtZXh0ZXJuIHZvaWQgYmxrX3F1ZXVlX21h
eF9zZWdtZW50cyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqLCB1bnNpZ25lZCAKPj4gc2hvcnQpOwo+
PiArZXh0ZXJuIHZvaWQgYmxrX3F1ZXVlX21heF9zZWdtZW50cyhzdHJ1Y3QgcmVxdWVzdF9xdWV1
ZSAqcSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBp
bnQgbWF4X3NlZ21lbnRzKTsKPj4gwqAgZXh0ZXJuIHZvaWQgYmxrX3F1ZXVlX21heF9kaXNjYXJk
X3NlZ21lbnRzKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICosCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB1
bnNpZ25lZCBzaG9ydCk7Cj4+IMKgIGV4dGVybiB2b2lkIGJsa19xdWV1ZV9tYXhfc2VnbWVudF9z
aXplKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICosIAo+PiB1bnNpZ25lZCBpbnQpOwo+PiBAQCAtMTI3
Niw3ICsxMjc3LDcgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgCj4+IHF1ZXVlX21heF9o
d19zZWN0b3JzKGNvbnN0IHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQo+PiDCoMKgwqDCoMKgIHJl
dHVybiBxLT5saW1pdHMubWF4X2h3X3NlY3RvcnM7Cj4+IMKgIH0KPj4gwqAgLXN0YXRpYyBpbmxp
bmUgdW5zaWduZWQgc2hvcnQgcXVldWVfbWF4X3NlZ21lbnRzKGNvbnN0IHN0cnVjdCAKPj4gcmVx
dWVzdF9xdWV1ZSAqcSkKPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHF1ZXVlX21heF9z
ZWdtZW50cyhjb25zdCBzdHJ1Y3QgCj4+IHJlcXVlc3RfcXVldWUgKnEpCj4+IMKgIHsKPj4gwqDC
oMKgwqDCoCByZXR1cm4gcS0+bGltaXRzLm1heF9zZWdtZW50czsKPj4gwqAgfQo+Pgo+IE9uZSB3
b3VsZCBhc3N1bWUgdGhhdCB0aGUgc2FtZSByZWFzb25pbmcgZ29lcyBmb3IgCj4gbWF4X2ludGVn
cml0eV9zZWdtZW50LCBubz8KClRoZSBlcnJvciBjYXNlIGl0c2VsZiBjYW4gYmUgcmVzb2x2ZWQg
YnkgdGhlIGNoYW5nZSB3aXRob3V0IHRoZSAKbWF4X2ludGVncml0eV9zZWdtZW50IGNoYW5nZXMu
CkFsc28gdGhlIHZhbHVlIGlzIHNldCB0byAwIGFzIGRlZmF1bHQgYW5kIHNldCB0byAxIGJ5IHRo
ZSBudm1lIGRyaXZlciBzbyAKaXQgc2VlbXMgdGhhdCBub3QgbmVjZXNzYXJ5IHRvIGNoYW5nZSBm
b3IgdGhpcyBjYXNlLgoKPgo+IE90aGVyd2lzZSBsb29rcyBnb29kLgo+Cj4gUmV2aWV3ZWQtYnk6
IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgpUaGFua3MgZm9yIHlvdXIgcmV2aWV3aW5n
Lgo+Cj4gQ2hlZXJzLAo+Cj4gSGFubmVzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
