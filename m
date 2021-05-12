Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89111C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 06:06:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF085613CB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 06:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF085613CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9ITZr1cZvFvszH//aORF6653h0I9HEcrVIUY85AZqcA=; b=Yc6j1VSjGkkMyAh+kBRfZVCfd
	JQNpgi48EEBqZbd5dL2PuQhB/6sOeV4hl9Kb5vYxeGoHzupcKMLbgXmfGIP+IPaegKkHfjIDTHvOh
	PoOBAN75q7DXYsC1OsLZxzcJo1vrvWkx4vKi/Yx12y6Q3PWK7q9E/KQiQ+Xe6gebXzeik9HB2Zw9p
	SpZOozBD1JrPAglFMxEsZJUkGinLepVMfG2nbjvPgZCyFSmSH2YWa5jR4YXDSAFa/+p8A/K8/UuKY
	hHwKQHBgARBD7ibO5mefYRLeo2qKXYZMwP/Iz8GJxdiyHUpOeIHrVitdcGggy/yLUpNnrMv3qUQC0
	wxl2lrG2w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgi0B-0027WN-Iy; Wed, 12 May 2021 06:05:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgi09-0027W0-RM
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 06:05:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=+JI3XaZr9BnfFPbVsTZIt6sQ5QTz197w+fL2+0l9C8A=; b=Cdrau/8LEgGryHzxjEdsG2fIqf
 GAbP37Bxf13nDBNqFwaLg81smYKZ9TQMaW1r5GKULeuukTiBUn5K6KDx5D4Vtg/VFALClflYrIxMx
 8EfGlwYAKO9UqmdDx218YApU93i26sifThOZ9u8YBh8MGDIdeGNHxTnv0ZpcyxQcD/UNYWabodca0
 x16ZpY0saTu33ALUxEwXUPYMGj+MpRS9T57l4HzljU1nvS2rVf7hxVSa/9C86cY37zu0Eatt+dASv
 FitMHbw03v6G3ctOuG2rvK6c4xLnc7h7H4nMGiOmw3TpLTbj12GcyTlEf8etjQS8hJsM9dEAoHKPC
 bsk0LdHw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgi06-00A8QY-P5
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 06:05:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 289D3ADF1;
 Wed, 12 May 2021 06:05:39 +0000 (UTC)
Subject: Re: [PATCH] nvme: allow to re-attach namespaces after all paths are
 down
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210510144906.8305-1-hare@suse.de>
 <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
 <d3f800eb-a917-d139-b430-b7b7976331de@grimberg.me>
 <7137b35c-b656-0245-f1e1-9c0806ee61cb@suse.de>
 <0d604ca8-ddf0-574a-2226-025d54e52344@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <01ce227a-2f1f-f4dd-d3fc-c179a1940464@suse.de>
Date: Wed, 12 May 2021 08:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <0d604ca8-ddf0-574a-2226-025d54e52344@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_230543_133630_2DA35989 
X-CRM114-Status: GOOD (  28.81  )
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

T24gNS8xMS8yMSA3OjAyIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4+PiBAQCAtMzYw
NSwxNiArMzYwOCwyNiBAQCBzdGF0aWMgaW50IG52bWVfaW5pdF9uc19oZWFkKHN0cnVjdCBudm1l
X25zIAo+Pj4+PiAqbnMsIHVuc2lnbmVkIG5zaWQsCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBo
ZWFkLT5zaGFyZWQgPSBpc19zaGFyZWQ7Cj4+Pj4+IMKgwqDCoMKgwqAgfSBlbHNlIHsKPj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IC1FSU5WQUw7Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBp
ZiAoIWlzX3NoYXJlZCB8fCAhaGVhZC0+c2hhcmVkKSB7Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRldl9lcnIoY3RybC0+ZGV2aWNlLAo+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICJEdXBsaWNhdGUgdW5zaGFyZWQgbmFtZXNwYWNlICVkXG4iLCBuc2lkKTsKPj4+
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfcHV0X25zX2hlYWQ7Cj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCB9Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoIW52bWVfbnNfaWRzX2Vx
dWFsKCZoZWFkLT5pZHMsIGlkcykpIHsKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2
X2VycihjdHJsLT5kZXZpY2UsCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
IklEcyBkb24ndCBtYXRjaCBmb3Igc2hhcmVkIG5hbWVzcGFjZSAlZFxuIiwKPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIC8qCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogSWYgbXVsdGlwYXRoIGlzIGVu
YWJsZWQgd2UgbWlnaHQgaGl0IGFuIG5zIGhlYWQgd2l0aCBubwo+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoCAqIHBhdGhzLCBidXQgdGhhdCBkb2Vzbid0IGluZGljYXRlIGl0J3MgYSBzaGFyZWQgbmFt
ZXNwYWNlLgo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKCFudm1lX25zX2hlYWRfbXVsdGlwYXRoKGhlYWQpIHx8Cj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICFsaXN0X2VtcHR5KCZoZWFkLT5saXN0KSkgewo+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoIWlzX3NoYXJlZCB8fCAhaGVhZC0+c2hhcmVkKSB7Cj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2VycihjdHJsLT5kZXZpY2UsCj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiRHVwbGljYXRlIHVuc2hhcmVk
IG5hbWVzcGFjZSAlZFxuIiwgbnNpZCk7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXRfcHV0X25zX2hlYWQ7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0KPj4+Pgo+Pj4+IElmIG5vdCBtdWx0aXBhdGgsIHRoZW4gaXQgaXMgbm90IHNoYXJlZC4gVGhl
IGFib3ZlIHdpbGwgZmFpbCBhdHRhY2hpbmcKPj4+PiBzaW5nbGUtcGF0aCBuYW1lc3BhY2VzIHRv
IGEga25vd24gaGVhZC4KPj4+Pgo+Pj4+IFRoZSByZXN0IGlzIHNpbWlsYXIgdG8gc29tZXRoaW5n
IEkgd2FzIHdvcmtpbmcgb24gdG9vLCB0aG91Z2gsIHNvIEkKPj4+PiB0aGluayBpdCdzIHRoZSBy
aWdodCBkaXJlY3Rpb24uCj4+Pj4KPj4+Pgo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoIW52bWVfbnNfaWRzX2VxdWFsKCZoZWFkLT5pZHMsIGlkcykpIHsKPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGN0cmwtPmRldmljZSwKPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJJRHMgZG9uJ3QgbWF0Y2ggZm9yIHNo
YXJlZCBuYW1lc3BhY2UgJWRcbiIsCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBuc2lkKTsKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBv
dXRfcHV0X25zX2hlYWQ7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290
byBvdXRfcHV0X25zX2hlYWQ7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IEJ1dCB0aGUgaWRzIG1pZ2h0IGhhdmUgY2hhbmdlZCwgc28gcmVzZXQgdGhlbSAqLwo+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoZWFkLT5pZHMgPSAqaWRzOwo+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgfQo+Pj4+PiDCoMKgwqDCoMKgIH0KPj4+Pj4gQEAgLTM3NjQsOCArMzc3Nyw2IEBA
IHN0YXRpYyB2b2lkIG52bWVfbnNfcmVtb3ZlKHN0cnVjdCBudm1lX25zICpucykKPj4+Pj4gwqDC
oMKgwqDCoCBtdXRleF9sb2NrKCZucy0+Y3RybC0+c3Vic3lzLT5sb2NrKTsKPj4+Pj4gwqDCoMKg
wqDCoCBsaXN0X2RlbF9yY3UoJm5zLT5zaWJsaW5ncyk7Cj4+Pj4+IC3CoMKgwqAgaWYgKGxpc3Rf
ZW1wdHkoJm5zLT5oZWFkLT5saXN0KSkKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsX2lu
aXQoJm5zLT5oZWFkLT5lbnRyeSk7Cj4+Pgo+Pj4gSGFubmVzLCB5b3Ugc2VudCBhIHBhdGNoIGxp
a2UgdGhpcyBiZWZvcmUsIG15IGNvbW1lbnQgd2FzIHRoYXQgYSBuc2hlYWQKPj4+IHNob3VsZCBi
ZSByZW1vdmVkIGJlZm9yZSB0aGUgZmluYWwgcmVmZXJlbmNlICh3aGljaCB3aG8ga25vd3Mgd2hl
biBpdAo+Pj4gd2lsbCBldmVyIGFycml2ZSkgYXMgaWYgYSBuc2lkIHdlcmUgdG8gYmUgcmV1c2Vk
IGJ5IHRoZSBjb250cm9sbGVyIGZvcgo+Pj4gYSBkaWZmZXJlbnQgbmFtZXNwYWNlIHRoZW4gd2Un
ZCByZWplY3QgaXQgc28gSSdtIG5vdCBzdXJlIGhvdyB0aGlzIAo+Pj4gaGVscHM/Cj4+Pgo+Pgo+
PiBCdXQgd2UgX25lZWRfIHRvIGhhdmUgdGhlIG5zaGVhZCBhdmFpbGFibGUgaW4gdGhlIGxpbmtl
ZCBsaXN0IGlmIHdlIAo+PiBldmVyIHdhbnQgdG8gcmUtYXR0YWNoIGEgbmFtZXNwYWNlIGFmdGVy
IHJlY29ubmVjdGluZyB0aGUgY29udHJvbGxlci4KPiAKPiBBZ2FpbiwgdGhpcyBpcyBhIHF1ZXVl
X2lmX25vX3BhdGggZnVuY3Rpb25hbGl0eSwgdGhpcyBzZXF1ZW5jZSBpcyAKPiBjb3JyZWN0IGZv
ciB0aGF0Lgo+IAoKV2Ugc28gbmVlZCB0byBoYXZlIGEgZmFjZS10by1mYWNlIG1lZXRpbmcgZm9y
IHRoaXMgd2lsbCBhbGwgY29uY2VybmVkIApwYXJ0aWVzIC4uLgoKV2h5IGRvIHdlIG5lZWQgcXVl
dWVfaWZfbm9fcGF0aCBmb3IgdGhpcz8KCldlIGRvIF9ub3RfIHF1ZXVlIEkvTyBpbiBhbnkgc2hh
cGUgb3IgZm9ybTsgaW4gZmFjdCwgTUQgd2lsbCByZWdpc3RlciAKSS9PIGVycm9ycyBvbiB0aGUg
ZmFpbGVkIG5zaGVhZCBqdXN0IGZpbmUuIEFuZCBteSB1bmRlcnN0YW5kaW5nIGZvciAKJ3F1ZXVl
X2lmX25vX3BhdGgnIGlzIHRoYXQgSS9PIHdpbGwgYmUgaGVsZCB1bnRpbCB0aGUgdW5kZXJseWlu
ZyBwYXRocyAKZ2V0cyByZWF0dGFjaGVkLiBCdXQgdGhpcyBpcyBfbm90XyB3aGF0IHRoaXMgcGF0
Y2ggZG9lcy4KClRoaXMgcGF0Y2ggbWVyZWx5IGRlYWxzIHdpdGggdGhlIHNpdHVhdGlvbiB3aGVu
IGEgY29udHJvbGxlciBpcyAKcmVhdHRhY2hlZCBhZnRlciBhbiBhbGwtcGF0aHMtcmVtb3ZlZCBz
Y2VuYXJpby4KQW5kIGFzIHRoZSBuc2hlYWQgc3RpbGwgX2lzXyBwcmVzZW50IHdlIHNob3VsZCB1
c2UgaXQsIHByZWNpc2VseSB0byAKYXZvaWQgdGhlIHNpdHVhdGlvbiB3aGVyZSB0aGUgTlNJRCBj
aGFuZ2VzIHVuZGVybmVhdGggdXMuCgo+PiBBbmQgd2Ugc2hvdWxkIGJlIGFibGUgdG8gY2F0Y2gg
dGhlICdyZXVzZSBuYW1lc3BhY2UnIGlzc3VlIGJ5IGNoZWNraW5nIAo+PiB0aGUgY29udGVudHMg
b2YgdGhlIG5zaWRzIGZpZWxkLCB3aGljaCB3ZSBrZWVwIGF0dGFjaGVkIHRvIHRoZSBuc2hlYWQu
Cj4gCj4gV2VsbCwgeW91IG1heSBiZSByaWdodCwgd2hhdCBJJ20gY29uY2VybmVkIGFib3V0IGlz
IHRoYXQgYSBuZXcgbmFtZXNwYWNlCj4gbWF5IGJlIGZhbHNlbHkgaWRlbnRpZmllZCBhcyB0aGUg
c2FtZSBuYW1lc3BhY2UgYmVjYXVzZSBpdCBpcyAKPiByZS1hdHRhY2hpbmcgdG8gYSBsaW5nZXJp
bmcgbW91bnRlZCBtcGF0aCBkZXZpY2UuCgpQbGVhc2UgY2hlY2sgdjMuIFlvdXIgY29uY2VybiBz
aG91bGQgYmUgYWRkcmVzc2VkIHRoZXJlLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1
c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcK
SFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTD
tnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
