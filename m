Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6D3C4707F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 11:24:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9F361284
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 11:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9F361284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iE90GvL1NdKYneuvx8uQYC6LH3oTuOl4u7JC9kFVoB0=; b=ddT3dP6nC7SumbaiCEmFdPEDR9
	y3xJGiUdfbCKfmWV7ybaMN6NGjzDnmyju8ezAGDOws/EVfQ2vAz9OXqkV9s1Dbo90sbAe1rWK8W4g
	JS2Nz4N514MBq6Gs74e7pth7HLR1D2Gleqyxm58jV+yb4lRbwPwr9jLXMtITW83jEYBrgyKR4rO7V
	v9E1j1ks3/HgZoxYeIceK+eft8Fr0KgChROY/mS/9h/K21eE1DPjShLU9ryRsPZverB2dw/qUtl/k
	nwMCkjU5svHSLMTOyOCK7hJ1PEWrHmEkBFL4GBdKzC3leOb1aKfXRDCuim1touuP6dRt/nAKmj4m4
	ytNiiXGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmE80-005Fac-7u; Thu, 27 May 2021 11:24:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmE7x-005FYm-3n
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 11:24:38 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 890E6218DD;
 Thu, 27 May 2021 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622114674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIjLih0zrcgqKyvGQQUEDCshMrlFrGC02tlfaQPJMrQ=;
 b=1lCOmVi2bjJgvTbi/YpabNFknMDG348eDU1qul2XMpv5/fZGmr40glXiL3jbbZvbqhxSUv
 jQz5Al5WOT00Lhab3qRCXSfaAcqtXgYRQlGEiThS8wkcbOJVTtZ7Li8gNQLCKIUTpf0zBj
 GGz0wD5rc6HH3yxjWl892xL4EMCm95o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622114674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIjLih0zrcgqKyvGQQUEDCshMrlFrGC02tlfaQPJMrQ=;
 b=4JeOS4gbzW8tT3Ym+DlPngBsWSDQq+NCHUB3oCQ7XURWwPPiimQEvIYCO9doUiSmMU5Gsk
 aRQQ0I92vtjjDsBA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id 6351611A98;
 Thu, 27 May 2021 11:24:34 +0000 (UTC)
Subject: Re: [PATCH] nvmet: use new ana_log_size instead the old one
To: Hou Pu <houpu.main@gmail.com>, sagi@grimberg.me, hch@lst.de,
 chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org
References: <20210513130410.1186-1-houpu.main@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <ab5cb841-abd6-16a9-af4f-a4824838d684@suse.de>
Date: Thu, 27 May 2021 13:24:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210513130410.1186-1-houpu.main@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_042437_337423_F2BA9BE1 
X-CRM114-Status: GOOD (  20.37  )
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

T24gNS8xMy8yMSAzOjA0IFBNLCBIb3UgUHUgd3JvdGU6Cj4gVGhlIG5ldyBhbmFfbG9nX3NpemUg
c2hvdWxkIGJlIHVzZWQgaW5zdGVhZCBvZiB0aGUgb2xkIG9uZS4KPiBPciBrZXJuZWwgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlIHdpbGwgaGFwcGVuIGxpa2UgYmVsb3c6Cj4gCj4gWyAgIDM4Ljk1
Nzg0OV1bICAgVDY5XSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJl
c3M6IDAwMDAwMDAwMDAwMDAwM2MKPiBbICAgMzguOTc1NTUwXVsgICBUNjldICNQRjogc3VwZXJ2
aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKPiBbICAgMzguOTc1OTU1XVsgICBUNjld
ICNQRjogZXJyb3JfY29kZSgweDAwMDIpIC0gbm90LXByZXNlbnQgcGFnZQo+IFsgICAzOC45NzY5
MDVdWyAgIFQ2OV0gUEdEIDAgUDREIDAKPiBbICAgMzguOTc5Mzg4XVsgICBUNjldIE9vcHM6IDAw
MDIgWyMxXSBTTVAgTk9QVEkKPiBbICAgMzguOTgwNDg4XVsgICBUNjldIENQVTogMCBQSUQ6IDY5
IENvbW06IGt3b3JrZXIvMDoyIE5vdCB0YWludGVkIDUuMTIuMCsgIzU0Cj4gWyAgIDM4Ljk4MTI1
NF1bICAgVDY5XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlY
LCAxOTk2KSwgQklPUyByZWwtMS4xNC4wLTAtZzE1NTgyMWExOTkwYi1wcmVidWlsdC5xZW11Lm9y
ZyAwNC8wMS8yMDE0Cj4gWyAgIDM4Ljk4MjUwMl1bICAgVDY5XSBXb3JrcXVldWU6IGV2ZW50cyBu
dm1lX2xvb3BfZXhlY3V0ZV93b3JrCj4gWyAgIDM4Ljk4NTIxOV1bICAgVDY5XSBSSVA6IDAwMTA6
bWVtY3B5X29yaWcrMHg2OC8weDEwZgo+IFsgICAzOC45ODYyMDNdWyAgIFQ2OV0gQ29kZTogODMg
YzIgMjAgZWIgNDQgNDggMDEgZDYgNDggMDEgZDcgNDggODMgZWEgMjAgMGYgMWYgMDAgNDggODMg
ZWEgMjAgNGMgOGIgNDYgZjggNGMgOGIgNGUgZjAgNGMgOGIgNTYgZTggNGMgOGIgNWUgZTAgNDgg
OGQgNzYgZTAgPDRjPiA4OSA0NyBmOCA0YyA4OSA0ZiBmMCA0YyA4OSA1NyBlOCA0YyA4OSA1ZiBl
MCA0OCA4ZCA3ZiBlMCA3MyBkMgo+IFsgICAzOC45ODc2NzddWyAgIFQ2OV0gUlNQOiAwMDE4OmZm
ZmZjOTAwMDAxYjdkNDggRUZMQUdTOiAwMDAwMDI4Nwo+IFsgICAzOC45ODc5OTZdWyAgIFQ2OV0g
UkFYOiAwMDAwMDAwMDAwMDAwMDIwIFJCWDogMDAwMDAwMDAwMDAwMDAyNCBSQ1g6IDAwMDAwMDAw
MDAwMDAwMTAKPiBbICAgMzguOTg4MzI3XVsgICBUNjldIFJEWDogZmZmZmZmZmZmZmZmZmZlNCBS
U0k6IGZmZmY4ODgxMDg0YmMwMDQgUkRJOiAwMDAwMDAwMDAwMDAwMDQ0Cj4gWyAgIDM4Ljk4ODYy
MF1bICAgVDY5XSBSQlA6IDAwMDAwMDAwMDAwMDAwMjQgUjA4OiAwMDAwMDAwMTAwMDAwMDAwIFIw
OTogMDAwMDAwMDAwMDAwMDAwMAo+IFsgICAzOC45ODg5OTFdWyAgIFQ2OV0gUjEwOiAwMDAwMDAw
MTAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6IDAwMDAwMDAwMDAwMDAwMjQKPiBb
ICAgMzguOTg5Mjg5XVsgICBUNjldIFIxMzogZmZmZjg4ODEwODRiYzAwMCBSMTQ6IDAwMDAwMDAw
MDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDI0Cj4gWyAgIDM4Ljk4OTg0NV1bICAgVDY5XSBG
UzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODIzN2MwMDAwMCgwMDAwKSBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwCj4gWyAgIDM4Ljk5MDIzNF1bICAgVDY5XSBDUzogIDAwMTAgRFM6
IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4gWyAgIDM4Ljk5MDQ5MF1bICAg
VDY5XSBDUjI6IDAwMDAwMDAwMDAwMDAwM2MgQ1IzOiAwMDAwMDAwMTA4NWIyMDAwIENSNDogMDAw
MDAwMDAwMDAwMDZmMAo+IFsgICAzOC45OTExMDVdWyAgIFQ2OV0gQ2FsbCBUcmFjZToKPiBbICAg
MzguOTk0MTU3XVsgICBUNjldICBzZ19jb3B5X2J1ZmZlcisweGI4LzB4ZjAKPiBbICAgMzguOTk1
MzU3XVsgICBUNjldICBudm1ldF9jb3B5X3RvX3NnbCsweDQ4LzB4NmQKPiBbICAgMzguOTk1NTY1
XVsgICBUNjldICBudm1ldF9leGVjdXRlX2dldF9sb2dfcGFnZV9hbmErMHhkNC8weDFjYgo+IFsg
ICAzOC45OTU3OTJdWyAgIFQ2OV0gIG52bWV0X2V4ZWN1dGVfZ2V0X2xvZ19wYWdlKzB4YzkvMHgx
NDYKPiBbICAgMzguOTk1OTkyXVsgICBUNjldICBudm1lX2xvb3BfZXhlY3V0ZV93b3JrKzB4M2Uv
MHg0NAo+IFsgICAzOC45OTYxODFdWyAgIFQ2OV0gIHByb2Nlc3Nfb25lX3dvcmsrMHgxYzMvMHgz
YzAKPiBbICAgMzguOTk2MzkzXVsgICBUNjldICB3b3JrZXJfdGhyZWFkKzB4NDQvMHgzZDAKPiBb
ICAgMzguOTk2NjAwXVsgICBUNjldICA/IGNhbmNlbF9kZWxheWVkX3dvcmsrMHg5MC8weDkwCj4g
WyAgIDM4Ljk5NjgwNF1bICAgVDY5XSAga3RocmVhZCsweGY3LzB4MTMwCj4gWyAgIDM4Ljk5Njk2
MV1bICAgVDY5XSAgPyBrdGhyZWFkX2NyZWF0ZV93b3JrZXJfb25fY3B1KzB4NzAvMHg3MAo+IFsg
ICAzOC45OTcxNzFdWyAgIFQ2OV0gIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwCj4gWyAgIDM4Ljk5
NzcwNV1bICAgVDY5XSBNb2R1bGVzIGxpbmtlZCBpbjoKPiBbICAgMzguOTk4NzQxXVsgICBUNjld
IENSMjogMDAwMDAwMDAwMDAwMDAzYwo+IFsgICAzOS4wMDAxMDRdWyAgIFQ2OV0gLS0tWyBlbmQg
dHJhY2UgZTcxOTkyN2I2MDlkMGZhMCBdLS0tCj4gCj4gRml4ZXM6IDVlMWY2ODk5MTNhNCAoIm52
bWUtbXVsdGlwYXRoOiBmaXggZG91YmxlIGluaXRpYWxpemF0aW9uIG9mIEFOQSBzdGF0ZSIpCj4g
U2lnbmVkLW9mZi1ieTogSG91IFB1IDxob3VwdS5tYWluQGdtYWlsLmNvbT4KPiAtLS0KPiAgZHJp
dmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
aG9zdC9tdWx0aXBhdGguYyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4gaW5kZXgg
ZGViMTQ1NjJjOTZhLi5mODE4NzFjNzEyOGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvbXVsdGlwYXRoLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+IEBA
IC04MTcsNyArODE3LDcgQEAgaW50IG52bWVfbXBhdGhfaW5pdF9pZGVudGlmeShzdHJ1Y3QgbnZt
ZV9jdHJsICpjdHJsLCBzdHJ1Y3QgbnZtZV9pZF9jdHJsICppZCkKPiAgCWlmIChhbmFfbG9nX3Np
emUgPiBjdHJsLT5hbmFfbG9nX3NpemUpIHsKPiAgCQludm1lX21wYXRoX3N0b3AoY3RybCk7Cj4g
IAkJa2ZyZWUoY3RybC0+YW5hX2xvZ19idWYpOwo+IC0JCWN0cmwtPmFuYV9sb2dfYnVmID0ga21h
bGxvYyhjdHJsLT5hbmFfbG9nX3NpemUsIEdGUF9LRVJORUwpOwo+ICsJCWN0cmwtPmFuYV9sb2df
YnVmID0ga21hbGxvYyhhbmFfbG9nX3NpemUsIEdGUF9LRVJORUwpOwo+ICAJCWlmICghY3RybC0+
YW5hX2xvZ19idWYpCj4gIAkJCXJldHVybiAtRU5PTUVNOwo+ICAJfQo+IApQbGVhc2UgZml4dXAg
dGhlIHN1YmplY3QgbGluZTsgdGhpcyBpcyBfbm90XyBmb3IgbnZtZXQsIGJ1dCByYXRoZXIgdGhl
CmluaXRpYXRvciBzaWRlICdudm1lJy4KCk90aGVyd2lzZToKClJldmlld2VkLWJ5OiBIYW5uZXMg
UmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNocmlzdG9waCwgcGxlYXNlIHB1bGwgdGhpcyBpbjsg
aXQgcmVsaWFibHkga2lsbHMgbXkgdGVzdGJlZCAuLi4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIu
IEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBz
dXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBT
b2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBOw7xybmJlcmcKR0Y6IEYuIEltZW5kw7ZyZmZl
ciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
