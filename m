Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF2C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:00:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3FE64E76
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3FE64E76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wievQClN7gVoJ6PkRrRVkuIOoCUpZ6/VLfDWHIYpp/0=; b=ekykRVhy5ptTeDJqnRWpx1YaT
	DtXUcOdpS5oNh5pxf3dSq5Q4mVJuRgnzswo2hXvZ4DglnUad8PCOfXhDl9+dmDW9+8fDjJyrhq9Ow
	hUjSx2TO0hThODJKNISTWeTofmvM9lyvG2Fa65TbOjIsWf4/BEdGG4eHn3SA4LRatzuA/L4TgGC9D
	kX86i9yU6MOFbhbUp6YzVPlvgtWyfbU3dJ/IkDcIBcMlW2MhAC+cAI95tTiON7uiteAi7ZUfXWUMD
	QAqrgO9v8P7+hhDa+rnCzybrMcRkGcp5dkmxpgM+CzG5rEjqPF8dD+8NkWiFQU5WBkV/jTUSKZ0Hz
	2xndzuy5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDTjX-00066R-75; Sat, 20 Feb 2021 14:59:47 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDTjV-00065r-6u
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 14:59:46 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2B7BDAF8D;
 Sat, 20 Feb 2021 14:59:44 +0000 (UTC)
Subject: Re: [PATCH] nvme-fabrics: fix kato initialization
To: "George, Martin" <Martin.George@netapp.com>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210218100443.5854-1-marting@netapp.com>
 <03826110-0d9c-8b25-9975-b427036ec2cc@suse.de>
 <795b906b46f27880af74aaeb0c1fe116add5e0f5.camel@netapp.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <49574d36-3da0-0131-1869-30c8e04c93d1@suse.de>
Date: Sat, 20 Feb 2021 15:59:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <795b906b46f27880af74aaeb0c1fe116add5e0f5.camel@netapp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210220_095945_466478_9C36C2F7 
X-CRM114-Status: GOOD (  25.61  )
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

T24gMi8yMC8yMSA5OjQxIEFNLCBHZW9yZ2UsIE1hcnRpbiB3cm90ZToKPiBPbiBGcmksIDIwMjEt
MDItMTkgYXQgMTc6NDIgKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gMi8xOC8y
MSAxMTowNCBBTSwgTWFydGluIEdlb3JnZSB3cm90ZToKPj4+IEN1cnJlbnRseSBrYXRvIGlzIGlu
aXRpYWxpemVkIHRvIE5WTUVfREVGQVVMVF9LQVRPIGZvciBib3RoCj4+PiBkaXNjb3ZlcnkgJiBp
L28gY29udHJvbGxlcnMuIFRoaXMgaXMgYSBwcm9ibGVtIHNwZWNpZmljYWxseQo+Pj4gZm9yIG5v
bi1wZXJzaXN0ZW50IGRpc2NvdmVyeSBjb250cm9sbGVycyBzaW5jZSBpdCBhbHdheXMgZW5kcwo+
Pj4gdXAgd2l0aCBhIG5vbi16ZXJvIGthdG8gdmFsdWUuIEZpeCB0aGlzIGJ5IGluaXRpYWxpemlu
ZyBrYXRvCj4+PiB0byB6ZXJvIGluc3RlYWQsIGFuZCBlbnN1cmluZyB2YXJpb3VzIGNvbnRyb2xs
ZXJzIGFyZSBhc3NpZ25lZAo+Pj4gYXBwcm9wcmlhdGUga2F0byB2YWx1ZXMgYXMgZm9sbG93czoK
Pj4+Cj4+PiBub24tcGVyc2lzdGVudCBjb250cm9sbGVycyAgLSBrYXRvIHNldCB0byB6ZXJvCj4+
PiBwZXJzaXN0ZW50IGNvbnRyb2xsZXJzICAgICAgLSBrYXRvIHNldCB0byBOVk1GX0RFVl9ESVND
X1RNTwo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAob3IgYW55IHBvc2l0aXZl
IGludCB2aWEgbnZtZS1jbGkpCj4+PiBpL28gY29udHJvbGxlcnMgICAgICAgICAgICAgLSBrYXRv
IHNldCB0byBOVk1FX0RFRkFVTFRfS0FUTwo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAob3IgYW55IHBvc2l0aXZlIGludCB2aWEgbnZtZS1jbGkpCj4+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogTWFydGluIEdlb3JnZSA8bWFydGluZ0BuZXRhcHAuY29tPgo+Pj4gLS0tCj4+PiAgICBk
cml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgfCA1ICsrKystCj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+Pj4gYi9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNz
LmMKPj4+IGluZGV4IDVkZmQ4MDZmYzJkMi4uNjA0YWIwZTVhMmFkIDEwMDY0NAo+Pj4gLS0tIGEv
ZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9m
YWJyaWNzLmMKPj4+IEBAIC02MzAsNyArNjMwLDcgQEAgc3RhdGljIGludCBudm1mX3BhcnNlX29w
dGlvbnMoc3RydWN0Cj4+PiBudm1mX2N0cmxfb3B0aW9ucyAqb3B0cywKPj4+ICAgICAgICBvcHRz
LT5xdWV1ZV9zaXplID0gTlZNRl9ERUZfUVVFVUVfU0laRTsKPj4+ICAgICAgICBvcHRzLT5ucl9p
b19xdWV1ZXMgPSBudW1fb25saW5lX2NwdXMoKTsKPj4+ICAgICAgICBvcHRzLT5yZWNvbm5lY3Rf
ZGVsYXkgPSBOVk1GX0RFRl9SRUNPTk5FQ1RfREVMQVk7Cj4+PiAtICAgICBvcHRzLT5rYXRvID0g
TlZNRV9ERUZBVUxUX0tBVE87Cj4+PiArICAgICBvcHRzLT5rYXRvID0gMDsKPj4+ICAgICAgICBv
cHRzLT5kdXBsaWNhdGVfY29ubmVjdCA9IGZhbHNlOwo+Pj4gICAgICAgIG9wdHMtPmZhc3RfaW9f
ZmFpbF90bW8gPSBOVk1GX0RFRl9GQUlMX0ZBU1RfVE1POwo+Pj4gICAgICAgIG9wdHMtPmhkcl9k
aWdlc3QgPSBmYWxzZTsKPj4+IEBAIC04OTMsNiArODkzLDkgQEAgc3RhdGljIGludCBudm1mX3Bh
cnNlX29wdGlvbnMoc3RydWN0Cj4+PiBudm1mX2N0cmxfb3B0aW9ucyAqb3B0cywKPj4+ICAgICAg
ICAgICAgICAgIG9wdHMtPm5yX3dyaXRlX3F1ZXVlcyA9IDA7Cj4+PiAgICAgICAgICAgICAgICBv
cHRzLT5ucl9wb2xsX3F1ZXVlcyA9IDA7Cj4+PiAgICAgICAgICAgICAgICBvcHRzLT5kdXBsaWNh
dGVfY29ubmVjdCA9IHRydWU7Cj4+PiArICAgICB9IGVsc2Ugewo+Pj4gKyAgICAgICAgICAgICBp
ZiAoIW9wdHMtPmthdG8pCj4+PiArICAgICAgICAgICAgICAgICAgICAgb3B0cy0+a2F0byA9IE5W
TUVfREVGQVVMVF9LQVRPOwo+Pj4gICAgICAgIH0KPj4+ICAgICAgICBpZiAoY3RybF9sb3NzX3Rt
byA8IDApIHsKPj4+ICAgICAgICAgICAgICAgIG9wdHMtPm1heF9yZWNvbm5lY3RzID0gLTE7Cj4+
Pgo+PiBDYW4ndCB5b3UgbWVyZ2UgdGhpcyB3aXRoIHRoZSBwcmV2aW91cyBwYXRjaCAnZW5zdXJl
IHplcm8ta2F0byAuLic/Cj4+Cj4gCj4gV2VsbCwgeW91IGFyZSByaWdodCB0aGF0IGJvdGggdGhl
IHByZXZpb3VzIHBhdGNoIChpLmUuICdlbnN1cmUgemVybwo+IGthdG8gZm9yIG5vbi1wZXJzaXN0
ZW50IGNvbnRyb2xsZXJzJykgJiB0aGlzIGN1cnJlbnQgcGF0Y2ggYXJlIGpvaW50bHkKPiByZXF1
aXJlZCBmb3IgYXNzaWduaW5nIHByb3BlciBrYXRvIHZhbHVlcyB0byB0aGUgdmFyaW91cyBjb250
cm9sbGVycywKPiBzbyBpdCB3b3VsZCBoYXZlIG1hZGUgc2Vuc2UgdG8gbWVyZ2UgdGhlIHR3by4g
QnV0IHRoZSBwcmV2aW91cyBvbmUgaXMgYQo+IG52bWUtY2xpIHBhdGNoLCB3aGVyZWFzIHRoaXMg
Y3VycmVudCBvbmUgaXMgYSBrZXJuZWwgcGF0Y2guIFRoYXQncyB3aHkKPiBJIGNob3NlIHRvIGNy
ZWF0ZSBzZXBhcmF0ZSBpbmRpdmlkdWFsIHBhdGNoZXMgaXRzZWxmIGhlcmUuCj4gCj4gU28gSSBo
b3BlIHRoaXMgaXMgZ29vZCBlbm91Z2guIElmIG5vdCwgcGxlYXNlIGxldCBtZSBrbm93IHdoYXQn
cyB0aGUKPiByaWdodCB3YXkgdG8gcHJvY2VlZCBoZXJlLgo+IApBcmdsLiBPZiBjb3Vyc2UgeW91
IGFyZSBjb3JyZWN0LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAg
ICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChB
RyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
