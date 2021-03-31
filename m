Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543B4C43460
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:05:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CC360FE5
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CC360FE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OV/PWkcLeDMU7w/5tD6021nPQLZYgxTxhthjIDn6k9g=; b=dU9FATY0m5ufITnsagTWlemqo
	zQHdfHPbsLB0zqkgsy41qQEs7sbzwXSzhtfigqWGhVOH8wnIbha9obzVi3yKELVj4lQwJhndmEHYz
	Mcxs8xQGxWGXfmPb64TtotsqbOgYXDm1tbacoQFycQ7tVm4+/LJN9PoB23Wm+szkYFL00CucbYsnO
	bVUeU0POM3s7wYBnS+8oDseCo+BG8qVw9waQ/mxMs0E65QbFVTYZwQDMVuf8KVqIgGizXar2xWq2l
	kzEdf+ZZl4tDELmoH6UG57vxek1WNntMkiEn8MSBXjaflZSkteu88VL+HaGoy2FxkeRxPvOiXa5KB
	4k9zkYvpw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRbSt-006k03-8f; Wed, 31 Mar 2021 14:04:59 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRbSp-006jzS-TB
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 14:04:57 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 69768B270
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 14:04:55 +0000 (UTC)
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
To: linux-nvme@lists.infradead.org
References: <20210331131228.131118-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1d7843a8-2a6e-ac2f-03d4-96785108b06e@suse.de>
Date: Wed, 31 Mar 2021 16:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210331131228.131118-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_150456_062946_EB63A3B5 
X-CRM114-Status: GOOD (  23.90  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8zMS8yMSAzOjEyIFBNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IENvbW1pdCA4YzRkZmVh
OTdmMTUgKCJudm1lLWZhYnJpY3M6IHJlamVjdCBJL08gdG8gb2ZmbGluZSBkZXZpY2UiKQo+IGlu
dHJvZHVjZWQgZmFzdF9pb19mYWlsX3RtbyBidXQgZGlkbid0IGV4cG9ydCB0aGUgdmFsdWUgdG8g
c3lzZnMuIFRoYXQKPiBtZWFucyB0aGUgdmFsdWUgaXMgaGFyZCBjb2RlZCBkdXJpbmcgY29tcGls
ZSB0aW1lLiBFeHBvcnQgdGhlIHRpbWVvdXQKPiB2YWx1ZSB0byB1c2VyIHNwYWNlIHZpYSBzeXNm
cyB0byBhbGxvdyBydW50aW1lIGNvbmZpZ3VyYXRpb24uCj4gCj4gQ2M6IFZpY3RvciBHbGFka292
IDxWaWN0b3IuR2xhZGtvdkBraW94aWEuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWdu
ZXIgPGR3YWduZXJAc3VzZS5kZT4KPiAtLS0KPiAKPiBUaGlzIHBhdGNoIGlzIGFnYWluc3QgbnZt
ZS01LjEzCj4gCj4gQlRXLCBjaGVja3BhdGNoIGNvbXBsYWlucyB3aXRoCj4gCj4gICBXQVJOSU5H
OiBTeW1ib2xpYyBwZXJtaXNzaW9ucyAnU19JUlVHTyB8IFNfSVdVU1InIGFyZSBub3QgcHJlZmVy
cmVkLiBDb25zaWRlciB1c2luZyBvY3RhbCBwZXJtaXNzaW9ucyAnMDY0NCcuCj4gCj4gSXMgdGhp
cyBzb21ldGhpbmcgd2Ugd2FudCB0byBhZGFwdCB0bz8KPiAKPiAgZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hh
bmdlZCwgMzEgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBpbmRleCA0MDIxNWEwMjQ2ZTQu
LmM4ZGUwZTM3YzdkOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiAr
KysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBAQCAtMzY5Niw2ICszNjk2LDM2IEBAIHN0
YXRpYyBzc2l6ZV90IG52bWVfY3RybF9yZWNvbm5lY3RfZGVsYXlfc3RvcmUoc3RydWN0IGRldmlj
ZSAqZGV2LAo+ICBzdGF0aWMgREVWSUNFX0FUVFIocmVjb25uZWN0X2RlbGF5LCBTX0lSVUdPIHwg
U19JV1VTUiwKPiAgCW52bWVfY3RybF9yZWNvbm5lY3RfZGVsYXlfc2hvdywgbnZtZV9jdHJsX3Jl
Y29ubmVjdF9kZWxheV9zdG9yZSk7Cj4gIAo+ICtzdGF0aWMgc3NpemVfdCBudm1lX2N0cmxfZmFz
dF9pb19mYWlsX3Rtb19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwKPiArCQlzdHJ1Y3QgZGV2aWNl
X2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQo+ICt7Cj4gKwlzdHJ1Y3QgbnZtZV9jdHJsICpj
dHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7Cj4gKwo+ICsJaWYgKGN0cmwtPm9wdHMtPmZhc3Rf
aW9fZmFpbF90bW8gPT0gLTEpCj4gKwkJcmV0dXJuIHNwcmludGYoYnVmLCAib2ZmXG4iKTsKPiAr
CXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCBjdHJsLT5vcHRzLT5mYXN0X2lvX2ZhaWxfdG1v
KTsKPiArfQo+ICsKPiArc3RhdGljIHNzaXplX3QgbnZtZV9jdHJsX2Zhc3RfaW9fZmFpbF90bW9f
c3RvcmUoc3RydWN0IGRldmljZSAqZGV2LAo+ICsJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKPiArewo+ICsJc3RydWN0IG52bWVf
Y3RybCAqY3RybCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwo+ICsJc3RydWN0IG52bWZfY3RybF9v
cHRpb25zICpvcHRzID0gY3RybC0+b3B0czsKPiArCWludCBmYXN0X2lvX2ZhaWxfdG1vLCBlcnI7
Cj4gKwo+ICsJZXJyID0ga3N0cnRvaW50KGJ1ZiwgMTAsICZmYXN0X2lvX2ZhaWxfdG1vKTsKPiAr
CWlmIChlcnIpCj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICsJZWxzZSBpZiAoZmFzdF9pb19m
YWlsX3RtbyA8IDApCj4gKwkJb3B0cy0+ZmFzdF9pb19mYWlsX3RtbyA9IC0xOwo+ICsJZWxzZQo+
ICsJCW9wdHMtPmZhc3RfaW9fZmFpbF90bW8gPSBmYXN0X2lvX2ZhaWxfdG1vOwo+ICsJcmV0dXJu
IGNvdW50Owo+ICt9Cj4gK3N0YXRpYyBERVZJQ0VfQVRUUihmYXN0X2lvX2ZhaWxfdG1vLCBTX0lS
VUdPIHwgU19JV1VTUiwKPiArCW52bWVfY3RybF9mYXN0X2lvX2ZhaWxfdG1vX3Nob3csIG52bWVf
Y3RybF9mYXN0X2lvX2ZhaWxfdG1vX3N0b3JlKTsKPiArCj4gIHN0YXRpYyBzdHJ1Y3QgYXR0cmli
dXRlICpudm1lX2Rldl9hdHRyc1tdID0gewo+ICAJJmRldl9hdHRyX3Jlc2V0X2NvbnRyb2xsZXIu
YXR0ciwKPiAgCSZkZXZfYXR0cl9yZXNjYW5fY29udHJvbGxlci5hdHRyLAo+IEBAIC0zNzE1LDYg
KzM3NDUsNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqbnZtZV9kZXZfYXR0cnNbXSA9IHsK
PiAgCSZkZXZfYXR0cl9ob3N0aWQuYXR0ciwKPiAgCSZkZXZfYXR0cl9jdHJsX2xvc3NfdG1vLmF0
dHIsCj4gIAkmZGV2X2F0dHJfcmVjb25uZWN0X2RlbGF5LmF0dHIsCj4gKwkmZGV2X2F0dHJfZmFz
dF9pb19mYWlsX3Rtby5hdHRyLAo+ICAJTlVMTAo+ICB9Owo+ICAKPiAKSXQncyBhY3R1YWxseSBf
bm90XyBoYXJkY29kZWQgZHVyaW5nIGNvbXBpbGF0aW9uIHRpbWUsIGJ1dCByYXRoZXIKc2V0dGFi
bGUgdmlhIG9wdGlvbnMgdG8gJ252bWUgY29ubmVjdCcuIEJ1dCB3ZSBzdGlsbCBzaG91bGQgYmUg
YWJsZSB0bwpjaGFuZ2UgaXQgYWZ0ZXIgY29ubmVjdGlvbiBoYXMgYmVlbiBlc3RhYmxpc2hlZC4K
ClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhh
bm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBB
cmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2
ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTD
tnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
