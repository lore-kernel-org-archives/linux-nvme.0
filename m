Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D9C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 20:29:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB0660FEA
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 20:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB0660FEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vlnb.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hLnJ3/g0pnnpWiFMn4KznLnxdvpEuh4dTYCHqXemTJc=; b=MvjYygkUzLn/VnK1ekO7sxjh+/
	Vb1VN60+yKOJNc8alsiV/CkVh3nFjiVQEY4ZJTSHN8vm2NngD1eab9Uc0Qf5g9SHkObrfg7nFWErn
	rgF9xInl1br6MGJfVWRCFx4/FINT3eYyH8iNnJ8ItIe5llxkysHuipH7tM9DYZOlifoVYRdtPGzNl
	/rYCbvzMRIxtF+pnmFrvdCKslDT7cWnPoXG9ngPGCc2DMvCEjYaZuSoKkK7MKt12WZRSEHi5Jv76m
	1LVhTI/hcbTGSvtYzRaeZxdQR+OmSZh15C5KIYydNbmIf0PwnS7o3zht43B6jA6AK4TCSEdet3P0I
	LCg6wxVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5wMt-00Drir-5e; Tue, 20 Jul 2021 20:29:31 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5wMq-00Dri7-Fq
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 20:29:30 +0000
Received: from [192.168.0.113] ([178.252.67.224]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1M6YEz-1m3SJE2PNp-0070ir; Tue, 20 Jul 2021 22:28:41 +0200
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-7-hare@suse.de>
 <bd588839-8acc-91cf-5946-f702007b0c7d@grimberg.me>
 <d74c29b8-1c64-e439-9015-6c424baad3d3@suse.de>
From: Vladislav Bolkhovitin <vst@vlnb.net>
Message-ID: <a3098fb2-2127-6f81-97e9-ab5de503508e@vlnb.net>
Date: Tue, 20 Jul 2021 23:28:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d74c29b8-1c64-e439-9015-6c424baad3d3@suse.de>
Content-Language: en-US
X-Provags-ID: V03:K1:PbE+rqglmpjeNnT05S+5EUIqm2w3pEbGcHIffWpSRXX9biz2QeV
 tyUB8AS6Qo55qo8uqL+5neAoyx0kl4F3UmzVph2ILPwNpFPn0VjNwYyIoz5/1Dt8xFXgonN
 2eJvzYyQvpQ/1FVMyjYrmTAs1csH0ukTHK/n28AF12USDkhfH7DhVKWbtOxBL8UfwJoyPcS
 AZxLVpm0hqpr96iosFLjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Mgyzmns+BA=:iubR+6YagoGNIqn9YX1i2M
 g5kcs/ivnzTG88BCmuhVAbgXGL1XZsCdN2brkgZQ4WZGYJWivoQB4r66CkhvIZUW4QhD5uxMz
 hRUgUXg5cdqR9MHXse/8HSMDle+iiYrVYt7iE7jIBsEszu1O1QxO+fwXDhJLxJXDjcEyvqkgb
 dh6HcshaaUNE3pSBLHG6oudBeMJv0RQxfgwl9jA2vYvQddB911nURptWKOIlM4zT72/8Ncoh1
 LcCmC7YPCZyVN3z22fuLe/97QJAYY6Gc80fH5X2r4hV22CPIFl1/q0oVfmfbe7t8T49tGk8J4
 hhze9qKix37cXVKsdyEuzAIeLmzfPW4UdXIbiVmE0B9AVaB2Q1o9BxCgIuw+utWIjnqAB8Lln
 yFpbdf2IG+x4Oy8NB0uYgk59TXqaxW2icuaB4Ldas+t5fS/WYmOuwvk+eaJfS3pjY4m3lyMqP
 2WyOkcund5irMV/dqpkbvWfOckEqrR1kcQtCu6a3vjhAk9dYY53MwE5oMSBTvTGiXRjY6vOlb
 XkoNFCP2LofC842BjZuHqO8j0WCZuj7MOCJ0fAkcH1u+FRhB1VGYoyA217CCLRmDGcX8AdEuX
 L3pnZpSUQvHt+iASgepTP1ESghteGyzTl7Afp2gTprRkDqe60qk2j2vov84bYho+A7MP7tG66
 J2EKPpUXMF61RzTWbj2v32q5F52txiS4mUXRkjF+uLdu/VUbgzMoq2//clb4C2XKgFjMB1F8+
 fKXCG8119kWQTz9ts+6gT/bZ+3yUHOmr4XUVaJH274qrsVbKaxEZ5ajwDiqeP0kEeBuZiYsTL
 dRrp9v0kPMzGnIEWOg7trNguI+fQ3TNTvuozpwhA3UfmlRc/DdaaXwh36fy8obUsvbuuXiw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_132928_868575_AEF2A88D 
X-CRM114-Status: GOOD (  25.93  )
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

Ck9uIDcvMTgvMjEgMzoyMSBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IE9uIDcvMTcvMjEg
OToyMiBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4+IEltcGxlbWVudCBOVk1lLW9GIEluLUJh
bmQgYXV0aGVudGljYXRpb24uIFRoaXMgcGF0Y2ggYWRkcyB0d28gbmV3Cj4+PiBmYWJyaWMgb3B0
aW9ucyAnZGhjaGFwX2tleScgdG8gc3BlY2lmeSB0aGUgUFNLCj4+Cj4+IHByZS1zaGFyZWQta2V5
Lgo+Pgo+PiBBbHNvLCB3ZSBuZWVkIGEgc3lzZnMga25vYiB0byByb3RhdGUgdGhlIGtleSB0aGF0
IHdpbGwgdHJpZ2dlcgo+PiByZS1hdXRoZW50aWNhdGlvbiBvciBldmVuIGEgc2ltcGxlIGNvbnRy
b2xsZXIocy1wbHVyYWwpIHJlc2V0LCBzbyB0aGlzCj4+IHNob3VsZCBnbyBiZXlvbmQganVzdCB0
aGUgY29ubmVjdGlvbiBzdHJpbmcuCj4+Cj4gCj4gWWVhaCwgcmUtYXV0aGVudGljYXRpb24gY3Vy
cmVudGx5IGlzIG5vdCBpbXBsZW1lbnRlZC4gSSBmaXJzdCB3YW50ZWQgdG8KPiBnZXQgdGhpcyBw
YXRjaHNldCBvdXQgc3VjaCB0aGF0IHdlIGNhbiBzZXR0bGUgb24gdGhlIHVzZXJzcGFjZSBpbnRl
cmZhY2UKPiAoYm90aCBmcm9tIGhvc3QgYW5kIHRhcmdldCkuCj4gSSdsbCBoYXZlIHRvIHRoaW5r
IG9uIGhvdyB3ZSBzaG91bGQgaGFuZGxlIGF1dGhlbnRpY2F0aW9uOyBvbmUgb2YgdGhlCj4gcmVh
bGx5IGludGVyZXN0aW5nIGNhc2VzIHdvdWxkIGJlIHdoZW4gb25lIG1hbGljaW91cyBhZG1pbiB3
aWxsIF9qdXN0Xwo+IHNlbmQgYSAnbmVnb3RpYXRlJyBjb21tYW5kIHRvIHRoZSBjb250cm9sbGVy
LiBBcyBwZXIgc3BlYyB0aGUgY29udHJvbGxlcgo+IHdpbGwgYmUgd2FpdGluZyBmb3IgYW4gJ2F1
dGhlbnRpY2F0aW9uIHJlY2VpdmUnIGNvbW1hbmQgdG8gc2VuZCBhCj4gJ2NoYWxsZW5nZScgcGF5
bG9hZCBiYWNrIHRvIHRoZSBob3N0LiBCdXQgdGhhdCB3aWxsIG5ldmVyIGNvbWUsIHNvIGFzIGl0
Cj4gc3RhbmRzIGN1cnJlbnRseSB0aGUgY29udHJvbGxlciBpcyByZXF1aXJlZCB0byBhYm9ydCB0
aGUgY29ubmVjdGlvbi4KPiBOb3QgdmVyeSBuaWNlLgoKWWVzLCBpbiB0aGlzIGNhc2UgYWZ0ZXIg
c29tZSByZWFzb25hYmxlIHRpbWVvdXQgKEkgd291bGQgc3VnZ2VzdCAxMC0xNQpzZWNvbmRzKSB0
aGUgY29udHJvbGxlciBleHBlY3RlZCB0byBhYm9ydCBjb25uZWN0aW9uIGFuZCBjbGVhbiB1cCBh
bGwKYWxsb2NhdGVkIHJlc291cmNlcy4KClRvIGhhbmRsZSBEb1MgcG9zc2liaWxpdHkgdG8gbWFr
ZSB0b28gbWFueSBzdWNoICJvcnBoYW4iIG5lZ290aWF0aW9ucywKaGVuY2UgY29uc3VtZSBhbGwg
Y29udHJvbGxlciBtZW1vcnksIHNvbWUgYWRkaXRpb25hbCBoYW5kbGluZyBpcyBuZWVkZWQuCkZv
ciBzaW1wbGljaXR5IGFzIGEgZmlyc3Qgc3RlcCBJIHdvdWxkIHN1Z2dlc3QgdG8gaGF2ZSBhIGds
b2JhbCBsaW1pdCBvbgpudW1iZXIgb2YgY3VycmVudGx5IGJlaW5nIGF1dGhlbnRpY2F0ZWQgY29u
bmVjdGlvbnMuCgpbLi4uXQoKPj4+ICvCoMKgwqAgY2hhcC0+a2V5ID0gbnZtZV9hdXRoX2V4dHJh
Y3Rfc2VjcmV0KGN0cmwtPm9wdHMtPmRoY2hhcF9zZWNyZXQsCj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZjaGFwLT5rZXlfbGVuKTsKPj4+ICvC
oMKgwqAgaWYgKElTX0VSUihjaGFwLT5rZXkpKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0g
UFRSX0VSUihjaGFwLT5rZXkpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNoYXAtPmtleSA9IE5VTEw7
Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+ICvCoMKgwqAgfQo+Pj4gKwo+Pj4g
K8KgwqDCoCBpZiAoa2V5X2hhc2ggPT0gMCkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsK
Pj4+ICsKPj4+ICvCoMKgwqAgaG1hY19uYW1lID0gbnZtZV9hdXRoX2htYWNfbmFtZShrZXlfaGFz
aCk7Cj4+PiArwqDCoMKgIGlmICghaG1hY19uYW1lKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcHJf
ZGVidWcoIkludmFsaWQga2V5IGhhc2ggaWQgJWRcbiIsIGtleV9oYXNoKTsKPj4+ICvCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVLRVlSRUpFQ1RFRDsKPj4+ICvCoMKgwqAgfQo+Pgo+PiBXaHkgZG9l
cyB0aGUgdXNlciBpbmZsdWVuY2UgdGhlIGhtYWMgdXNlZD8gaXNuJ3QgdGhhdCBpcyBkcml2ZW4K
Pj4gYnkgdGhlIHN1c2JzeXN0ZW0/Cj4+Cj4+IEkgZG9uJ3QgdGhpbmsgdGhhdCB0aGUgdXNlciBz
aG91bGQgY2hvb3NlIGluIHRoaXMgbGV2ZWwuCj4+Cj4gCj4gVGhhdCBpcyBhbm90aGVyIHdlaXJk
bmVzcyBvZiB0aGUgc3BlYy4KPiBUaGUgX3NlY3JldF8gd2lsbCBiZSBoYXNoZWQgd2l0aCBhIHNw
ZWNpZmljIGZ1bmN0aW9uLCBhbmQgdGhhdCBmdW5jdGlvbgo+IGlzIHN0YXRlZCBpbiB0aGUgdHJh
bnNwb3J0IHJlcHJlc2VudGF0aW9uLgo+IChDZiBzZWN0aW9uICJESC1ITUFDLUNIQVAgU2VjdXJp
dHkgUmVxdWlyZW1lbnRzIikuCj4gVGhpcyBpcyBfbm90XyB0aGUgaGFzaCBmdW5jdGlvbiB1c2Vk
IGJ5IHRoZSBhdXRoZW50aWNhdGlvbiBpdHNlbGYsIHdoaWNoCj4gd2lsbCBiZSBzZWxlY3RlZCBi
eSB0aGUgcHJvdG9jb2wuCj4gU28gaXQncyBub3QgdGhlIHVzZXIgaGVyZSwgYnV0IHJhdGhlciB0
aGUgdHJhbnNwb3J0IHNwZWNpZmljYXRpb24gb2YgdGhlCj4ga2V5IHdoaWNoIHNlbGVjdHMgdGhl
IGhhc2ggYWxnb3JpdGhtLgoKWWVzLCBnb29kIGNhdGNoLiBJdCBsb29rcyBhcyBhIG1pbm9yIGVy
cmF0YSBtYXRlcmlhbCB0byBzcGVjaWZ5IHRoYXQKaGFzaCBmdW5jdGlvbiBoZXJlIGlzIGltcGxl
bWVudGF0aW9uIHNwZWNpZmljLgoKSSB3b3VsZCBzdWdnZXN0IHRvIGp1c3QgaGFyZGNvZGUgU0hB
NTEyIGhlcmUuIFVzZXJzIGRvbid0IGhhdmUgdG8gYmUKY29uZnVzZWQgYnkgdGhpcy4KClZsYWQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
