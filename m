Return-Path: <SRS0=GfOp=4X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89850C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 09:05:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD232073D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 09:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cb4RVsL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD232073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IPUkFotj3yGx33m2R8jaXONWA515s5sc7dggvlG4uj4=; b=Cb4RVsL9mNJ9CH
	n1HnuYGmxxh/bYQR9wAbMrlGblhboqp7/IPmXCgQL7JItUfphiMt1OaIwlArnCNcG4PQTlfs/8h8V
	SRfs+ng18KzeHpdxRlquAIXFK1vuTtdaqd2EGZIx7kI90BiqenjIwi7kJzVYQDbItpPfRcB4YoL73
	oahPvgloYR4vrkgElbdjW8fU34pjCz4Mhj1ObIz+yTSTFzV3ib582ULn2vnaeJTyDrBsnuH1L11zW
	MeAznNTA2G40QBFECS3B/MaDRwu45ph7BrPc7ZcN5gZTpqBEjiWbRU/ocDRblWZ3/i6WEXyaYdfNd
	KvEX3n3u7Aduww7z+bgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jA8um-00025h-4t; Fri, 06 Mar 2020 09:05:04 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA8ui-0001wp-Po
 for linux-nvme@lists.infradead.org; Fri, 06 Mar 2020 09:05:02 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 87186AB3D;
 Fri,  6 Mar 2020 09:04:59 +0000 (UTC)
Subject: Re: [PATCH 17/29] nvmet-fc: Add Disconnect Association Xmt support
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-18-jsmart2021@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <95b01875-00ba-7e0f-2f1c-0ad284f76a44@suse.de>
Date: Fri, 6 Mar 2020 10:04:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-18-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200306_010501_128925_E343B813 
X-CRM114-Status: GOOD (  22.70  )
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
Cc: martin.petersen@oracle.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi81LzIwIDc6MzcgUE0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IEFzIHBhcnQgb2YgRkMtTlZN
RS0yIChhbmQgYW1tZW5kbWVudCBvbiBGQy1OVk1FKSwgdGhlIHRhcmdldCBpcyB0bwo+IHNlbmQg
YSBEaXNjb25uZWN0IExTIGFmdGVyIGFuIGFzc29jaWF0aW9uIGlzIHRlcm1pbmF0ZWQgYW5kIGFu
eQo+IGV4Y2hhbmdlcyBmb3IgdGhlIGFzc29jaWF0aW9uIGhhdmUgYmVlbiBBQlRTJ2QuIFRoZSB0
YXJnZXQgaXMgYWxzbwo+IG5vdCB0byBzZW5kIHRoZSByZWNlaXB0IHRvIGFueSBEaXNjb25uZWN0
IEFzc29jaWF0aW9uIExTLCByZWNlaXZlZAo+IHRvIGluaXRpYXRlIHRoZSBhc3NvY2lhdGlvbiB0
ZXJtaW5hdGlvbiBvciByZWNlaXZlZCB3aGlsZSB0aGUKPiBhc3NvY2lhdGlvbiBpcyB0ZXJtaW5h
dGluZywgdW50aWwgdGhlIERpc2Nvbm5lY3QgTFMgaGFzIGJlZW4gdHJhbnNtaXQuCj4gCj4gQWRk
IHN1cHBvcnQgZm9yIHNlbmRpbmcgRGlzY29ubmVjdCBBc3NvY2lhdGlvbiBMUyBhZnRlciBhbGwg
SS9PJ3MKPiBjb21wbGV0ZSAod2hpY2ggaXMgYWZ0ZXIgQUJUUydkIGNlcnRhaW5seSkuIFV0aWxp
emVzIHRoZSBuZXcgTExERAo+IGFwaSB0byBzZW5kIGxzIHJlcXVlc3RzLgo+IAo+IFRoZXJlIGlz
IG5vIG5lZWQgdG8gdHJhY2sgdGhlIERpc2Nvbm5lY3QgTFMgcmVzcG9uc2Ugb3IgdG8gcmV0cnkK
PiBhZnRlciB0aW1lb3V0LiBBbGwgc3BlYyByZXF1aXJlbWVudHMgd2lsbCBoYXZlIGJlZW4gbWV0
IGJ5IHdhaXRpbmcKPiBmb3IgaS9vIGNvbXBsZXRpb24gdG8gaW5pdGlhdGUgdGhlIHRyYW5zbWlz
c2lvbi4KPiAKPiBBZGQgc3VwcG9ydCBmb3IgdHJhY2tpbmcgdGhlIHJlY2VwdGlvbiBvZiBEaXNj
b25uZWN0IEFzc29jaWF0aW9uCj4gYW5kIGRlZmVyaW5nIHRoZSByZXNwb25zZSB0cmFuc21pc3Np
b24gdW50aWwgYWZ0ZXIgdGhlIERpc2Nvbm5lY3QKPiBBc3NvY2lhdGlvbiBMUyBoYXMgYmVlbiB0
cmFuc21pdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFp
bC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbnZtZS90YXJnZXQvZmMuYyB8IDI5OCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQo+ICAxIGZpbGUgY2hhbmdlZCwg
Mjg3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL252bWUvdGFyZ2V0L2ZjLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2ZjLmMKPiBpbmRleCBk
NTIzOTNjZDI5ZjcuLjNlOTRjNDkwOWNmOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvdGFy
Z2V0L2ZjLmMKPiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2ZjLmMKPiBAQCAtMjUsNyArMjUs
NyBAQAo+ICBzdHJ1Y3QgbnZtZXRfZmNfdGd0cG9ydDsKPiAgc3RydWN0IG52bWV0X2ZjX3RndF9h
c3NvYzsKPiAgCj4gLXN0cnVjdCBudm1ldF9mY19sc19pb2Qgewo+ICtzdHJ1Y3QgbnZtZXRfZmNf
bHNfaW9kIHsJCS8vIGZvciBhbiBMUyBSUVNUIFJDVgo+ICAJc3RydWN0IG52bWVmY19sc19yc3AJ
CSpsc3JzcDsKPiAgCXN0cnVjdCBudm1lZmNfdGd0X2ZjcF9yZXEJKmZjcHJlcTsJLyogb25seSBp
ZiBSUyAqLwo+ICAKPiBAQCAtNDUsNiArNDUsMTggQEAgc3RydWN0IG52bWV0X2ZjX2xzX2lvZCB7
Cj4gIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QJCXdvcms7Cj4gIH0gX19hbGlnbmVkKHNpemVvZih1bnNp
Z25lZCBsb25nIGxvbmcpKTsKPiAgCj4gK3N0cnVjdCBudm1ldF9mY19sc19yZXFfb3AgewkJLy8g
Zm9yIGFuIExTIFJRU1QgWE1UCj4gKwlzdHJ1Y3QgbnZtZWZjX2xzX3JlcQkJbHNfcmVxOwo+ICsK
PiArCXN0cnVjdCBudm1ldF9mY190Z3Rwb3J0CQkqdGd0cG9ydDsKPiArCXZvaWQJCQkJKmhvc3Ro
YW5kbGU7Cj4gKwo+ICsJaW50CQkJCWxzX2Vycm9yOwo+ICsJc3RydWN0IGxpc3RfaGVhZAkJbHNy
ZXFfbGlzdDsgLyogdGd0cG9ydC0+bHNfcmVxX2xpc3QgKi8KPiArCWJvb2wJCQkJcmVxX3F1ZXVl
ZDsKPiArfTsKPiArCj4gKwo+ICAvKiBkZXNpcmVkIG1heGltdW0gZm9yIGEgc2luZ2xlIHNlcXVl
bmNlIC0gaWYgc2cgbGlzdCBhbGxvd3MgaXQgKi8KPiAgI2RlZmluZSBOVk1FVF9GQ19NQVhfU0VR
X0xFTkdUSAkJKDI1NiAqIDEwMjQpCj4gIApQbGVhc2UsIHVzZSBub3JtYWwgY29tbWVudHMsIG5v
dCBDKystc3R5bGUgLy8gdGhpbmdpZXMuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5k
ZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAz
NjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
