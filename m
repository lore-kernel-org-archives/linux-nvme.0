Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MISSING_HEADERS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C50C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 06:41:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF462076E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 06:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l6f43aTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF462076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	From:Subject:Reply-To:To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+CpqynaZgABnZKCG99CedYjYpm4jtqni4OELjZhif4o=; b=l6f43aTCODHI9vBOgry5F/un3
	0smEC2VtDpNVETQB1FKcjKgbQIgCIQYF3lgsGleRb5FpK6PElcAsQZ8xqqc0qcQ58nhi2XslQoS3O
	LBQBDGATQ9+DpXgPniJlzrEaaZs0l9oQbNfohZXy25RF0jqv9wJYIzbF4QO+obbIQBKprs231o0Rm
	+/Tztt5Ey0gzqbNvJfW4Llon68C3Qw2caUdTF/lMSFcyxBcBNdVAcRhJufmfMRO2m3fFzVF16KPqq
	0G5P1RDUqBQWHyxwuxDgIHGOUvx3ppz4IV+EszPZlmHdQ56uXKYBIkmSEqHiYnhmslyG24I/tcxIi
	vpJNLmksw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3D6g-0000vi-FZ; Wed, 05 Aug 2020 06:40:58 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3D6e-0000uG-6J
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 06:40:57 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 204FB987492CCD0BCC4C;
 Wed,  5 Aug 2020 14:40:51 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 5 Aug 2020 14:40:49 +0800
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
From: Chao Leng <lengchao@huawei.com>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
Message-ID: <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
Date: Wed, 5 Aug 2020 14:40:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_024056_513530_4871EEAB 
X-CRM114-Status: GOOD (  25.57  )
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
Cc: linux-nvme@lists.infradead.org, John.Meneghini@netapp.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sm9obiwgV2F0IGRvIHlvdSB0aGluayBhYm91dCBpZiBkZWxldGUgdHJhbnNsYXRlIE5WTUVfU0Nf
Q01EX0lOVEVSUlVQVEVECnRvIEJMS19TVFNfVEFSR0VUPyBUaGFuayB5b3UuCgpPbiAyMDIwLzcv
MzAgOTo0OSwgQ2hhbyBMZW5nIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjAvNy8yOSAxMzo1OSwgQ2hy
aXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+IE9uIFdlZCwgSnVsIDI5LCAyMDIwIGF0IDEwOjU0OjI5
QU0gKzA4MDAsIENoYW8gTGVuZyB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMjAyMC83LzI4IDE5OjE5
LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+PiBPbiBNb24sIEp1bCAyNywgMjAyMCBhdCAw
MTo1ODoxOFBNICswODAwLCBDaGFvIExlbmcgd3JvdGU6Cj4+Pj4+IFRoZSBwcm90b2NvbCBOVk0t
RXhwcmVzcy0xLjQgZGVmaW5lOgo+Pj4+PiBDb21tYW5kIEludGVycnVwdGVkOiBDb21tYW5kIHBy
b2Nlc3Npbmcgd2FzIGludGVycnVwdGVkIGFuZCB0aGUKPj4+Pj4gY29udHJvbGxlciBpcyB1bmFi
bGUgdG8gc3VjY2Vzc2Z1bGx5IGNvbXBsZXRlIHRoZSBjb21tYW5kLiBUaGUgaG9zdAo+Pj4+PiBz
aG91bGQgcmV0cnkgdGhlIGNvbW1hbmQuIElmIHRoaXMgc3RhdHVzIGNvZGUgaXMgcmV0dXJuZWQs
IHRoZW4KPj4+Pj4gdGhlIGNvbnRyb2xsZXIgc2hhbGwgY2xlYXIgdGhlIERvIE5vdCBSZXRyeSBi
aXQgdG8g4oCYMOKAmSBpbiB0aGUgU3RhdHVzCj4+Pj4+IGZpZWxkIG9mIHRoZSBDUUUgKHJlZmVy
IHRvIEZpZ3VyZSAxMjQpLiBUaGUgY29udHJvbGxlciBzaGFsbCBub3QgcmV0dXJuCj4+Pj4+IHRo
aXMgc3RhdHVzIGNvZGUgdW5sZXNzIHRoZSBob3N0IGhhcyBzZXQgdGhlIEFkdmFuY2VkIENvbW1h
bmQgUmV0cnkKPj4+Pj4gRW5hYmxlIChBQ1JFKSBmaWVsZCB0byAxaCBpbiB0aGUgSG9zdCBCZWhh
dmlvciBTdXBwb3J0IGZlYXR1cmUocmVmZXIgdG8KPj4+Pj4gc2VjdGlvbiA1LjIxLjEuMjIpLgo+
Pj4+Pgo+Pj4+PiBBY2NvcmRpbmcgdGhlIHByb3RvY29sIGRlZmluZSwgTlZNRV9TQ19DTURfSU5U
RVJSVVBURUQgbmVlZCByZXRyeS4KPj4+Pj4gVGhlIGVycm9yIGNvZGUgTlZNRV9TQ19DTURfSU5U
RVJSVVBURUQgc2hvdWxkIG5vdCB0cmFuc2xhdGUgdG8KPj4+Pj4gQkxLX1NUU19UQVJHRVQsIGJl
Y2F1c2UgaWYgdGhlIGVycm9yIGNvZGUgdHJhbnNsYXRlIHRvIEJMS19TVFNfVEFSR0VULAo+Pj4+
PiBkbS1tdWx0aXBhaCB3aWxsIHJldHVybiBlcnJvciB0byBhcHBsaWNhdGlvbi4gU28gaWYgdGFy
Z2V0IHJldHVybiBlcnJvcgo+Pj4+PiBjb2RlIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVELCBpbyB3
aWxsIGludGVycnVwdC4gTlZNRV9TQ19DTURfSU5URVJSVVBURUQKPj4+Pj4gc2hvdWxkIHRyYW5z
bGF0ZSB0byBCTEtfU1RTX0lPRVJSIGJ5IGRlZmF1bHQsIGRtLW11bHRpcGF0aCB3aWxsIGZhaWwK
Pj4+Pj4gb3ZlciB0byBvdGhlciBwYXRoIHJldHJ5IHRoZSBpby4KPj4+Pgo+Pj4+IElPRVJSIHN0
aWxsIHNlZW1zIHdyb25nLCB0aG91Z2guCj4+Pj4gLgo+Pj4KPj4+IEJMS19TVFNfVEFSR0VUIG1l
YW5zIHRhcmdldCBoYXMgY3JpdGljYWwgZXJyb3IuIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVECj4+
PiBqdXN0IG1lYW5zIHRhcmdldCBuZWVkIHJldHJ5IGlvLiBJdCBpcyBub3Qgc3VpdGFibGUgdG8g
dHJhbnNsYXRlCj4+PiBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCB0byBCTEtfU1RTX1RBUkdFVC4g
TWF5YmUgdHJhbnNsYXRlIHRvCj4+PiBCTEtfU1RTX0lPRVJSIGlzIGFsc28gbm90IHN1aXRhYmxl
LCB3ZSBzaG91bGQgdHJhbnNsYXRlCj4+PiBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCB0byBCTEtf
U1RTX0FHQUlOLgo+Pj4gV2UgY2FuIGRvIGxpa2UgdGhpczoKPj4KPj4gQkxLX1NUU19BR0FJTiBp
cyBhIGJhZCBjaG9pY2UgYXMgd2UgdXNlIGl0IGZvciBjYWxscyB0aGF0IGJsb2NrIHdoZW4KPj4g
dGhlIGNhbGxlcnMgYXNrZWQgZm9yIG5vbi1ibG9ja2luZyBzdWJtaXNzaW9uLsKgIEknbSByZWFs
bHkgbm90IHN1cmUKPj4gd2Ugd2FudCB0byBjaGFuZ2UgYW55dGhpbmcgaGVyZSAtIHRoZSBlcnJv
ciBkZWZpbml0aW9uIGNsZWFybHkgc3RhdGVzCj4+IGl0IGlzIG5vdCBhIGZhaWx1cmUgYnV0IGEg
cmVxdWVzdCB0byByZXRyeSBsYXRlci4KPj4gLgo+Pgo+IEJMS19TVFNfQUdBSU4gaXMgbm90IGEg
Z29vZCBjaG9pY2UsIGJ1dCBCTEtfU1RTX1RBUkdFVCBpcyBhbHNvIG5vdAo+IGEgZ29vZCBjaG9p
Y2UuIEkgZmluZCB0aGUgcGF0Y2ggdGhhdCB0cmFuc2xhdGUgTlZNRV9TQ19DTURfSU5URVJSVVBU
RUQKPiB0byBCTEtfU1RTX1RBUkdFVC4KPiAKPiBjb21taXQ6MzUwMzhiZmZhODdkYTI4MjAxMGI5
MTEwOGNhZGQxMzIzOGJiNWJiZAo+IG52bWU6IFRyYW5zbGF0ZSBtb3JlIHN0YXR1cyBjb2RlcyB0
byBibGtfc3RhdHVzX3QKPiBEZWNvZGUgaW50ZXJydXB0ZWQgY29tbWFuZCBhbmQgbm90IHJlYWR5
IG5hbWVzcGFjZSBudm1lIHN0YXR1cyBjb2RlcyB0bwo+IEJMS19TVFNfVEFSR0VULiBUaGVzZSBh
cmUgbm90IGdlbmVyaWMgSU8gZXJyb3JzIGFuZCBzaG91bGQgdXNlIGEgbm9uLXBhdGgKPiBzcGVj
aWZpYyBlcnJvciBzbyB0aGF0IGl0IGNhbiB1c2UgdGhlIG5vbi1mYWlsb3ZlciByZXRyeSBwYXRo
Lgo+IFJlcG9ydGVkLWJ5OiBKb2huIE1lbmVnaGluaSA8Sm9obi5NZW5lZ2hpbmlAbmV0YXBwLmNv
bT4KPiAKPiBJbiB0aGUgb2xkIHZlcnNpb24sIG5lZWQgdHJhbnNsYXRlIE5WTUVfU0NfQ01EX0lO
VEVSUlVQVEVEIHRvCj4gQkxLX1NUU19UQVJHRVQsIGJlY2F1c2UgbnZtZSBtdWx0aXBhdGggY2hl
Y2sgdGhlIGJsa19wYXRoX2Vycm9yLAo+IHdlIGV4cGVjdCByZXRyeSBJTyBpbiB0aGUgY3VycmVu
dCBwYXRoLCBzbyBoYXZlIHRvIHRyYW5zbGF0ZQo+IE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEIHRv
IEJMS19TVFNfVEFSR0VULiBBbHRob3VnaCBjb252ZXJ0aW5nIHRvCj4gQkxLX1NUU19UQVJHRVQg
aXMgbm90IGEgZ29vZCBjaG9pY2UsIHRoZXJlIHNlZW1zIHRvIGJlIG5vIGJldHRlciBjaG9pY2UK
PiBmb3IgdGhlIG9sZCB2ZXJzaW9uIGNvZGUuIEJ1dCBub3cgd2UgZG8gbm90IG5lZWQgdHJhbnNs
YXRlCj4gTlZNRV9TQ19DTURfSU5URVJSVVBURUQgdG8gQkxLX1NUU19UQVJHRVQsIG52bWUgbXVs
dGlwYXRoIGFscmVhZHkKPiBpbXByb3ZlIGFuZCBkb2VzIG5vdCBkZXBlbmQgb24gYmxrX3BhdGhf
ZXJyb3IuCj4gCj4gQWNjb3JkaW5nIHRvIHRoZSBkZXNjcmlwdGlvbiBvZiBCTEtfU1RTX1RBUkdF
VDoKPiBbQkxLX1NUU19UQVJHRVRdwqDCoMKgID0geyAtRVJFTU9URUlPLMKgwqDCoCAiY3JpdGlj
YWwgdGFyZ2V0IiB9Cj4gQkxLX1NUU19UQVJHRVQgbWF5IGVhc2lseSBtaXN0YWtlbiBhcyBhIGZh
dGFsIGVycm9yIG9uIHRoZSBzdG9yYWdlLgo+IEkgYWxyZWFkeSBjaGVjayBhbGwgdGhlIGVycm9y
IGNvZGUgb2YgQkxLX1NUU194eCwgdGhlcmUgaXMgbm8gZ29vZAo+IGNob2ljZSBmb3IgTlZNRV9T
Q19DTURfSU5URVJSVVBURUQgbm93LiBJbiB0aGUgYWJzZW5jZSBvZiBhIHN1aXRhYmxlCj4gZXJy
b3IgY29kZSwgaXQgaXMgYSBnb29kIGNob2ljZSB0byByZXRhaW4gdGhlIGRlZmF1bHQuIFNvIEkg
c3Ryb25nbHkKPiBzdWdnZXN0IGRlbGV0ZSB0cmFuc2xhdGUgTlZNRV9TQ19DTURfSU5URVJSVVBU
RUQgdG8gQkxLX1NUU19UQVJHRVQuCj4gCj4gSm9obiwgd2hhdCBkbyB5b3UgdGhpbms/CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
