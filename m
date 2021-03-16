Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3820DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 05:24:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12456506F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 05:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12456506F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1CzD8VHWdPMp1NsXU8erqeBHSt5R0gyvMNspX3nXvug=; b=Mc2DyZH758dZCfwIvEq0252ud
	bHOzsDda+p/GY2rYk32+F/yl0PLAzKgZdCicqe5SsdXiguQnvRgNGKF7RlrUa23fwsjUVuLrRrso1
	S7t+Th5O5N6IyMfjOkcd8YsEzaYtsPssZIZpYf7mEge8VSbRZcOHGpDGrwGGy88/7OT0EU8DkLgjU
	Nze7+q+aJRlNKE2sy6NI5xfsJZv2LExZWDNk74z7/lCA32JybZETOHbEKZjOTk2XjWjh02WBPMRH4
	L0T25GADkgNYQKLduTXFOlLCkyvCAlwc+IGhmCCoe0Dy5BQZBKna89JuGZKHxvCQ0qsyOb8+Cx8ZW
	LCimB991Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM2CE-00HSLx-88; Tue, 16 Mar 2021 05:24:46 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM2CA-00HSLb-35
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 05:24:43 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 f2-20020a17090a4a82b02900c67bf8dc69so761935pjh.1
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 22:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=nHDKK9cwB/SVmiSnX7QLelhy9j7mhfcxFHJqI3Khacs=;
 b=FaM5aznThi/Cgu4Va8fl94WeDz5uwJMDsna460YrUPfhFdA1fI+NOXADL3e3rUfGbW
 eo8qeGg336sK04LNRhVtZ5Og9sjqKbCzqopK6sIpHlMzHNxaFsHBv/dvaR/MAwtsgqKc
 0CcNAocg/eESDKnPuKkWBazwfPiLYALUluOBOFYXK1eUV2UJ/DfIQRr7RCt0weOjKYvd
 eLmiOaPSeNeIqiB6xJE0uQZ52ZnqzojA+b7DI5ERsdKswaVjBrLAbbyFdHSEWncDSp73
 ywcDtKkNDKDk404oDOs0mkrVZqYASaDftB+qSqlwz0TnLdf5shwNyJQAodJYfAIg3PHj
 KbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=nHDKK9cwB/SVmiSnX7QLelhy9j7mhfcxFHJqI3Khacs=;
 b=lGEbAhpMQ2MrO5yh7yFlHrtorY8yf3Hku7lXo2pjbwq7JfwNk34tHpf6J4nHnNzpH3
 IlRGn0St+b5c4QRuJaihGX+Lp2W2yYGMeQHcVWrJvnGfSo+qe69wWIlS+9JbnSAfoq86
 6qTZgf0h0ZconcHmaZtpP9BIM9FPVY1vMgiQ7TclTZBfHOlEvj9COcFenErWAMppzjSs
 V7vOw1JUJrIaTubXXcp9+IfaOi4y7jlNY1sVXD3mQrRs4jnvPzA6ZwNm7Mu6xrI1wx6j
 C3qp9pvVh5JDmrHL1j9ihjahyTVwkXEDJHMTvS1q4y21t0a0YR6+S/jtfNRwbCX4K39k
 hbrw==
X-Gm-Message-State: AOAM5306+f+n2jfBVHeJdbv6JSs4dOL/V5lK1m7d4dElMb842UwPbmlu
 41wsMqI5o6O+bGonZXHrKr8=
X-Google-Smtp-Source: ABdhPJxdFIh2RcvQ+wNCfHdesE9OhV17xfZUf7YATzIjbnzVrNR/MK3vblyzi1YLUPO+FOJEuFKVRQ==
X-Received: by 2002:a17:903:304e:b029:e5:d43:9415 with SMTP id
 u14-20020a170903304eb02900e50d439415mr14861378pla.42.1615872280306; 
 Mon, 15 Mar 2021 22:24:40 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id t10sm1374663pjf.30.2021.03.15.22.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 22:24:39 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: finish receiving before send back response if
 nvmet_req_init() failed.
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, stable@vger.kernel.org
References: <20210315100928.87596-1-houpu.main@gmail.com>
 <3a5bd33b-32c2-24c4-3880-883e33bfe282@grimberg.me>
From: Hou Pu <houpu.main@gmail.com>
Message-ID: <a4ae0e4b-3d59-3a5a-1533-4545e2e4633e@gmail.com>
Date: Tue, 16 Mar 2021 13:24:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3a5bd33b-32c2-24c4-3880-883e33bfe282@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_052442_235266_CC96CA65 
X-CRM114-Status: GOOD (  28.83  )
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

Ck9uIDIwMjEvMy8xNiAxOjMyIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IFdoZW4gcmVj
ZWl2aW5nIGEgcGR1LCBpZiBudm1ldF9yZXFfaW5pdCgpIGZhaWxlZCAoZm9yIGV4YW1wbGUgYSBu
cyBpcwo+PiBub3QgZm91bmQpLCB0aGUgcXVldWUtPnJjdl9zdGF0ZSBjb3VsZCBiZSBtb3ZlZCB0
byBOVk1FVF9UQ1BfUkVDVl9EQVRBCj4+IGJ5IG52bWV0X3RjcF9oYW5kbGVfcmVxX2ZhaWx1cmUo
KS4gV2Ugc2hvdWxkIHJldHVybiAwIGhlcmUgdG8gY29udGludWUKPj4gdG8gY29uc3VtZSB0aGUg
cG9zc2libGUgcmVtYWluaW5nIGlubGluZSB3cml0ZSBvdXQgZGF0YSBpbgo+PiBudm1ldF90Y3Bf
dHJ5X3JlY3Zfb25lKCkuIE90aGVyd2lzZSwgdGhlIHJlc3BvbnNlIHRvIHRoaXMgcmVxdWVzdCB3
b3VsZAo+PiBiZSBzZW50IGFuZCBpb3Ygd291bGQgYmUgZnJlZWQuIE5leHQgdGltZSBpbiBudm1l
dF90Y3BfdHJ5X3JlY3Zfb25lKCksCj4+IHdlIHdvdWxkIGdvIHRvIHRoZSByZWNlaXZpbmcgZGF0
YSBwaGFzZSBhbmQgdGhlIGlvdiBpcyB1c2VkIGFnYWluLgo+Pgo+PiBBIHBhbmljIGhhcHBlbmQg
d2l0aCBhIDUuNCBrZXJuZWwgaW5zdGFsbGVkIGFzIGJlbG93Ogo+Cj4gQ2FuIHlvdSBwbGVhc2Ug
dHJ5IHRvIHJlcHJvZHVjZSB0aGlzIHdpdGggdXBzdHJlYW0/IGFuZCB3aXRoIGxhdGVzdAo+IHN0
YWJsZSA1LjQ/IHRoZXJlIGhhdmUgYmVlbiBzb21lIGZpeGVzIGluIHRoaXMgYXJlYS4gV2UgbWF5
IG5lZWQKPiB0byBoZWxwIGJhY2twb3J0ZWQgcGF0Y2hlcyB0byBzdGFibGUgaWYgbmVlZGVkLgoK
ClRoaXMgY291bGQgYmUgcmVwcm9kdWNlZCBvbiB0aGUgbGF0ZXN0IHN0YWJsZSAoNS40LjEwNSku
wqAgSSB0cmllZCB3aXRoIAp1cHN0cmVhbQoKKDUuMTItcmMzKSwgaXQgY291bGQgbm90IGJlIHJl
cHJvZHVjZWQuIEJ1dCBJIHRob3VnaHQgdGhlIGJ1ZyBzdGlsbCAKZXhpc3QgaW4gdXBzdHJlYW0s
Cgp0aGVuIEkgYWRkZWQgdGhlIGZvbGxvd2luZyBjaGFuZ2VzIHRvIGNhdGNoIHN1Y2ggdXNlIGFm
dGVyIHByb2JsZW1zLgoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5jIGIv
ZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYwppbmRleCA4YjA0ODVhZGEzMTUuLjQ2ODQ3Y2NmNDM5
NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYworKysgYi9kcml2ZXJzL252
bWUvdGFyZ2V0L3RjcC5jCkBAIC0yMTcsNiArMjE3LDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBu
dm1ldF90Y3BfcHV0X2NtZChzdHJ1Y3QgCm52bWV0X3RjcF9jbWQgKmNtZCkKIMKgwqDCoMKgwqDC
oMKgIGxpc3RfYWRkX3RhaWwoJmNtZC0+ZW50cnksICZjbWQtPnF1ZXVlLT5mcmVlX2xpc3QpOwog
wqB9Cgorc3RhdGljIGlubGluZSBib29sIG52bWV0X3RjcF9jbWRfZnJlZWQoc3RydWN0IG52bWV0
X3RjcF9jbWQgKmNtZCkKK3sKK8KgwqDCoMKgwqDCoCAvKiBXaGVuIGEgY21kIGlzIGZpcnN0IGdl
dGVkLCBsaXN0X2RlbF9pbml0KCkgaXMgY2FsbGVkLCBpdCBjb3VsZCBiZQorwqDCoMKgwqDCoMKg
wqAgKiB1c2VkIHRvIHRlbGwgaWYgaXQgaXMgb24gZnJlZSBsaXN0CivCoMKgwqDCoMKgwqDCoCAq
LworwqDCoMKgwqDCoMKgIGlmIChjbWQtPmVudHJ5Lm5leHQgPT0gJmNtZC0+ZW50cnkgJiYgY21k
LT5lbnRyeS5wcmV2ID09IAomY21kLT5lbnRyeSkKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIGZhbHNlOworwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOworfQorCiDCoHN0YXRp
YyBpbmxpbmUgaW50IHF1ZXVlX2NwdShzdHJ1Y3QgbnZtZXRfdGNwX3F1ZXVlICpxdWV1ZSkKIMKg
ewogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHF1ZXVlLT5zb2NrLT5zay0+c2tfaW5jb21pbmdfY3B1
OwpAQCAtMTA4OCw2ICsxMDk4LDkgQEAgc3RhdGljIGludCBudm1ldF90Y3BfdHJ5X3JlY3ZfZGF0
YShzdHJ1Y3QgCm52bWV0X3RjcF9xdWV1ZSAqcXVldWUpCiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
bnZtZXRfdGNwX2NtZMKgICpjbWQgPSBxdWV1ZS0+Y21kOwogwqDCoMKgwqDCoMKgwqAgaW50IHJl
dDsKCivCoMKgwqDCoMKgwqAgaWYgKG52bWV0X3RjcF9jbWRfZnJlZWQoY21kKSkKK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJjbWQ9JXAgd2hpY2ggaXMgZnJlZWQgaXMgdXNl
ZCBhZ2FpblxuIiwgY21kKTsKKwogwqDCoMKgwqDCoMKgwqAgd2hpbGUgKG1zZ19kYXRhX2xlZnQo
JmNtZC0+cmVjdl9tc2cpKSB7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0g
c29ja19yZWN2bXNnKGNtZC0+cXVldWUtPnNvY2ssICZjbWQtPnJlY3ZfbXNnLAogwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbWQtPnJlY3ZfbXNnLm1zZ19m
bGFncyk7CgpUaGUgZG1lc2cgc2hvd3M6CgpbwqDCoCA4MC4wNTg1MzVdIG52bWV0X3RjcDogZmFp
bGVkIGNtZCAwMDAwMDAwMDc0NzEwZmRhIGlkIDgzIG9wY29kZSAxLCAKZGF0YV9sZW46IDEwMjQK
W8KgwqAgODAuMDYwMjI1XSBudm1ldF90Y3A6IGNtZD0wMDAwMDAwMGI0NzBkOTZhIHdoaWNoIGlz
IGZyZWVkIGlzIHVzZWQgYWdhaW4KW8KgwqAgODAuMDYwOTAzXSBudm1ldF90Y3A6IGZhaWxlZCBj
bWQgMDAwMDAwMDA3ZDY0OGU1ZSBpZCA4NCBvcGNvZGUgMSwgCmRhdGFfbGVuOiAxMDI0ClvCoMKg
IDgwLjA2MTM3N10gbnZtZXRfdGNwOiBjbWQ9MDAwMDAwMDAyZjMxOTRjYiB3aGljaCBpcyBmcmVl
ZCBpcyB1c2VkIGFnYWluClvCoMKgIDgwLjA2MTY1Nl0gbnZtZXRfdGNwOiBmYWlsZWQgY21kIDAw
MDAwMDAwNDdjYzk2NmEgaWQgODUgb3Bjb2RlIDIsIApkYXRhX2xlbjogMTAyNApbwqDCoCA4MC4w
NjY2NTddIG52bWV0X3RjcDogZmFpbGVkIGNtZCAwMDAwMDAwMDUzMTljOWIyIGlkIDg2IG9wY29k
ZSAxLCAKZGF0YV9sZW46IDEwMjQKW8KgwqAgODAuMDY3MzI1XSBudm1ldF90Y3A6IGNtZD0wMDAw
MDAwMDI0NWM3MGQ2IHdoaWNoIGlzIGZyZWVkIGlzIHVzZWQgYWdhaW4KClNvLCBJIHRoaW5rIHRo
ZSB1cHN0cmVhbSBhbHNvIGhhcyB0aGlzIGJ1Zy4KCgpIb3cgdG8gcmVwcm9kdWNlOgoKMS4gUnVu
aW5nIGZpbyBmcm9tIGluaXRpYXRvcjoKCmZpbyAtYnM9MTAyNCAtZmlsZW5hbWU9L2Rldi9udm1l
MW4xIC1ydz1yYW5kcncgLWRpcmVjdD0xIAotaW9lbmdpbmU9bGliYWlvIC1udW1qb2JzPTQgLXRp
bWVfYmFzZWQ9MSAtcnVudGltZT02MDAgLWlvZGVwdGg9MSAtbmFtZT10CgoyLiBkaXNhYmxlIG5h
bWVzcGFjZSAxIGZyb20gdGFyZ2V0IGJ5IDoKCmVjaG8gMCA+IC9zeXMva2VybmVsL2NvbmZpZy9u
dm1ldC9zdWJzeXN0ZW1zL215c3ViL25hbWVzcGFjZXMvMS9lbmFibGUKClsuLl0KCj4+Cj4+IMKg
IGRyaXZlcnMvbnZtZS90YXJnZXQvdGNwLmMgfCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lL3RhcmdldC90Y3AuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvdGNwLmMKPj4gaW5kZXggOGIw
NDg1YWRhMzE1Li5kYTFjNjY3ZTIxYmEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvdGNwLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYwo+PiBAQCAtOTYxLDcg
Kzk2MSw3IEBAIHN0YXRpYyBpbnQgbnZtZXRfdGNwX2RvbmVfcmVjdl9wZHUoc3RydWN0IAo+PiBu
dm1ldF90Y3BfcXVldWUgKnF1ZXVlKQo+PiBsZTMyX3RvX2NwdShyZXEtPmNtZC0+Y29tbW9uLmRw
dHIuc2dsLmxlbmd0aCkpOwo+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZXRfdGNwX2hhbmRs
ZV9yZXFfZmFpbHVyZShxdWV1ZSwgcXVldWUtPmNtZCwgcmVxKTsKPj4gLcKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRUFHQUlOOwo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4KPiBXaGF0IGd1
YXJhbnRlZXMgdGhhdCB5b3Ugd2lsbCBhY3R1YWxseSBoYXZlIG1vcmUgdG8gY29uc3VtZT8KCgpJ
biBteSBjYXNlLCB3cml0ZSAxMDI0IGJ5dGVzIHJlcXVlc3QgbmVlZCByZWNlaXZlIGlubGluZSBk
YXRhLgoKQWZ0ZXIgcmVjZWl2ZSBjbWQgcGR1LCB0aGUgZm9sbG93aW5nIGlubGluZSBkYXRhIHN0
aWxsIG5lZWQgdG8gYmUgcmVhZCAKZnJvbSB0aGUgc29ja2V0LgoKClRoYW5rcywKCkhvdQoKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
