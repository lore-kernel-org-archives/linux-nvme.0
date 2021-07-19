Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980F7C07E9B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 10:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455A560725
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 10:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455A560725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=13N0gNiN4eMWjfzEcg9Er2h9ysBr2XrJ6PBPwAsgJ/s=; b=Oo4Ulx1pPIeliq
	a4V9UrTsTkpptS9x7csWZr2Z2PfvZ8sYE/Qn+cbb9HOMJg6ZYi2KtZd28VH0lu33N7nXuGO2upwkw
	WIFfr94dtuJ9Y6gcPF/wSdZmAqbYr8Xz7Epi0b8VTyUsgHZpU63iYv0/creMF6/mYp+JjP0nHxNug
	SSzAw8iGEhf6tvfG3q2j/KfHptcRNw7q02i4vgXvgjZxfUs+01rDfnij07k41e/kml/Wu68FV4QrU
	vWSgW7Uvr/xKGrECp4DaNkoIhmfj+q81oTNmZe/Lh3IU/0UZ8mvanqbyWWFsZE9SalafwC98PXTe1
	TThx8jiD7hnvKEvuzBNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5QNV-009FoO-KH; Mon, 19 Jul 2021 10:20:01 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5QNR-009Fnh-VK
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 10:19:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626689983;
 s=strato-dkim-0002; d=chronox.de;
 h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=4T18oeaYOjfqnhYLdO03K1noXsqk67VasKd9H+0LppA=;
 b=rFuO/vz7he1U5Gl5XTpJRF1q+F2k4SAmhmrnTIbr+1eS0qjWnUsdmFFYI/TsHFJnXL
 6UVE7H0d/kjn1xwlFlZB/ioNSeQ74AhJutmuQMXN2cDezi3Kbfmc3kdu6HxyiAdsGQKV
 0Lfl9G2/8Hyz0W0JP+siI3JS2ZRJ4eURvUAHdc1GttcuOlexNKVd0IstOXf6YmpKzbrS
 77A8biWdYDwgB6HL/qzxSC5hN/8K/Aiu1umg7Ll/ASz1TUXu2UMCO7cwuyOVBBHkThe0
 mwBqWkEAAwGKOkN1/noixKRtfRA5guFCeGIVICF4566qZJ4k82NUDkcnFiYTGnJfwHCZ
 PFPQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNzyCzy1Sfr67uExK884EC0GFGHavJSlBkMRYMkE="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
 with ESMTPSA id 9043bbx6JAJgHYN
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 19 Jul 2021 12:19:42 +0200 (CEST)
Message-ID: <740af9f7334c294ce879bef33985dfab6d0523b3.camel@chronox.de>
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
From: Stephan Mueller <smueller@chronox.de>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>, 
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Date: Mon, 19 Jul 2021 12:19:41 +0200
In-Reply-To: <2af95a8e-50d9-7e2d-a556-696e9404fee4@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
 <2510347.locV8n3378@positron.chronox.de>
 <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
 <6538288.aohFRl0Q45@positron.chronox.de>
 <59695981-9edc-6b7a-480a-94cca95a0b8c@suse.de>
 <463a191b9896dd708015645cfc125988cd5deaef.camel@chronox.de>
 <2af95a8e-50d9-7e2d-a556-696e9404fee4@suse.de>
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_031958_244520_60303464 
X-CRM114-Status: GOOD (  38.60  )
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

QW0gTW9udGFnLCBkZW0gMTkuMDcuMjAyMSB1bSAxMTo1NyArMDIwMCBzY2hyaWViIEhhbm5lcyBS
ZWluZWNrZToKPiBPbiA3LzE5LzIxIDEwOjUxIEFNLCBTdGVwaGFuIE11ZWxsZXIgd3JvdGU6Cj4g
PiBBbSBNb250YWcsIGRlbSAxOS4wNy4yMDIxIHVtIDEwOjE1ICswMjAwIHNjaHJpZWIgSGFubmVz
IFJlaW5lY2tlOgo+ID4gPiBPbiA3LzE4LzIxIDI6NTYgUE0sIFN0ZXBoYW4gTcO8bGxlciB3cm90
ZToKPiA+ID4gPiBBbSBTb25udGFnLCAxOC4gSnVsaSAyMDIxLCAxNDozNzozNCBDRVNUIHNjaHJp
ZWIgSGFubmVzIFJlaW5lY2tlOgo+ID4gCj4gPiA+ID4gPiBUaGUga2V5IGlzIGFsc28gdXNlZCB3
aGVuIHVzaW5nIHRoZSBmZmRoZSBhbGdvcml0aG0uCj4gPiA+ID4gPiBOb3RlOiBJIF90aGlua18g
dGhhdCBJIG5lZWQgdG8gdXNlIHRoaXMga2V5IGZvciB0aGUgZmZkaGUgYWxnb3JpdGhtLAo+ID4g
PiA+ID4gYmVjYXVzZSB0aGUgaW1wbGVtZW50YXRpb24gSSBjYW1lIHVwIHdpdGggaXMgZXNzZW50
aWFsbHkgcGxhaW4gREgKPiA+ID4gPiA+IHdpdGgKPiA+ID4gPiA+IHByZS1kZWZpbmVkICdwJywg
J3EnIGFuZCAnZycgdmFsdWVzLiBCdXQgdGhlIERIIGltcGxlbWVudGF0aW9uIGFsc28KPiA+ID4g
PiA+IHJlcXVpcmVzIGEgJ2tleScsIGFuZCBmb3IgdGhhdCBJJ20gdXNpbmcgdGhpcyBrZXkgaGVy
ZS4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gSXQgbWlnaHQgYmUgdGhhdCBJJ20gY29tcGxldGVseSBv
ZmYsIGFuZCBkb24ndCBuZWVkIHRvIHVzZSBhIGtleSBmb3IKPiA+ID4gPiA+IG91cgo+ID4gPiA+
ID4gREggaW1wbGVtZW50YXRpb24uIEluIHRoYXQgY2FzZSB5b3UgYXJlIGNvcnJlY3QuCj4gPiA+
ID4gPiAoQW5kIHRoYXQncyB3aHkgSSBzYWlkIEknbGwgbmVlZCBhIHJldmlldyBvZiB0aGUgRkZE
SEUKPiA+ID4gPiA+IGltcGxlbWVudGF0aW9uKS4KPiA+ID4gPiA+IEJ1dCBmb3Igbm93IEknbGwg
bmVlZCB0aGUga2V5IGZvciBGRkRIRS4KPiA+ID4gPiAKPiA+ID4gPiBEbyBJIHVuZGVyc3RhbmQg
eW91IGNvcnJlY3RseSB0aGF0IHRoZSBkaGNoYXBfa2V5IGlzIHVzZWQgYXMgdGhlIGlucHV0Cj4g
PiA+ID4gdG8KPiA+ID4gPiB0aGUgCj4gPiA+ID4gREggLSBpLmUuIGl0IGlzIHRoZSByZW1vdGUg
cHVibGljIGtleSB0aGVuPyBJdCBsb29rcyBzdHJhbmdlIHRoYXQgdGhpcwo+ID4gPiA+IGlzCj4g
PiA+ID4gdXNlZCAKPiA+ID4gPiBmb3IgREggYnV0IHRoZW4gaXQgaXMgY2hhbmdlZCBoZXJlIGJ5
IGhhc2hpbmcgaXQgdG9nZXRoZXIgd2l0aAo+ID4gPiA+IHNvbWV0aGluZwo+ID4gPiA+IGVsc2Ug
Cj4gPiA+ID4gdG8gZm9ybSBhIG5ldyBkaGNoYXBfa2V5LiBNYXliZSB0aGF0IGlzIHdoYXQgdGhl
IHByb3RvY29sIHNheXMuIEJ1dCBpdAo+ID4gPiA+IHNvdW5kcyAKPiA+ID4gPiBzdHJhbmdlIHRv
IG1lLCBlc3BlY2lhbGx5IHdoZW4geW91IHRoaW5rIHRoYXQgZGhjaGFwX2tleSB3b3VsZCBiZSwK
PiA+ID4gPiBzYXksCj4gPiA+ID4gMjA0OCAKPiA+ID4gPiBiaXRzIGlmIGl0IGlzIHRydWx5IHRo
ZSByZW1vdGUgcHVibGljIGtleSBhbmQgdGhlbiBhZnRlciB0aGUgaGFzaGluZwo+ID4gPiA+IGl0
IGlzCj4gPiA+ID4gMjU2IAo+ID4gPiA+IHRoaXMgZGhjaGFwX2tleSBjYW5ub3QgYmUgdXNlZCBm
b3IgRkZDLURILgo+ID4gPiA+IAo+ID4gPiA+IE9yIGFyZSB5b3UgdXNpbmcgdGhlIGRoY2hhcF9r
ZXkgZm9yIHR3byBkaWZmZXJlbnQgcHVycG9zZXM/Cj4gPiA+ID4gCj4gPiA+ID4gSXQgc2VlbXMg
SSBtaXNzIHNvbWV0aGluZyBoZXJlLgo+ID4gPiA+IAo+ID4gPiBObywgbm90IGVudGlyZWx5LiBJ
dCdzIG1lIHdobyBidWdnZXJlZCBpdCB1cC4KPiA+ID4gSSBnb3QgY2FycmllZCBhd2F5IGJ5IHRo
ZSBmYWN0IHRoYXQgdGhlcmUgaXMgYSBjcnlwdG9fZGhfZW5jb2RlX2tleSgpCj4gPiA+IGZ1bmN0
aW9uLCBhbmQgdGhvdWdodCBJIG5lZWQgdG8gdXNlIGl0IGhlcmUuCj4gPiAKPiA+IFRoYW5rIHlv
dSBmb3IgY2xhcmlmeWluZyB0aGF0LiBJdCBzb3VuZHMgdG8gbWUgdGhhdCB0aGVyZSBpcyBubyBk
ZWZpbmVkCj4gPiBwcm90b2NvbCAob3IgaWYgdGhlcmUsIEkgd291bGQgYmUgd29uZGVyaW5nIGhv
dyB0aGUgY29kZSB3b3VsZCBoYXZlIHdvcmtlZAo+ID4gd2l0aCBhIGRpZmZlcmVudCBpbXBsZW1l
bnRhdGlvbikuIFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gZmlyc3Qgc3BlY2lmeSBhCj4gPiBwcm90
b2NvbCBmb3IgYXV0aGVudGljYXRpb24gYW5kIGhhdmUgaXQgZGlzY3Vzc2VkPyBJIHBlcnNvbmFs
bHkgdGhpbmsgaXQKPiA+IGlzIGEKPiA+IGJpdCBkaWZmaWN1bHQgdG8gZnVsbHkgdW5kZXJzdGFu
ZCB0aGUgcHJvdG9jb2wgZnJvbSB0aGUgY29kZSBhbmQgZGlzY3Vzcwo+ID4gcHJvdG9jb2wtbGV2
ZWwgaXRlbXMgYmFzZWQgb24gdGhlIGNvZGUuCj4gPiAKPiBPaCwgdGhlIHByb3RvY29sIF9pc18g
c3BlY2lmaWVkOgo+IAo+IGh0dHBzOi8vbnZtZXhwcmVzcy5vcmcvd3AtY29udGVudC91cGxvYWRz
L05WTS1FeHByZXNzLUJhc2UtU3BlY2lmaWNhdGlvbi0yXzAtMjAyMS4wNi4wMi1SYXRpZmllZC01
LnBkZgo+IAo+IEl0J3MganVzdCB0aGF0IEkgaGF2ZSBpc3N1ZXMgdHJhbnNsYXRpbmcgdGhhdCBz
cGVjIG9udG8gd2hhdCB0aGUga2VybmVsCj4gcHJvdmlkZXMuCgphY2NvcmRpbmcgdG8gdGhlIG5h
bWluZyBjb252ZW50aW9ucyB0aGVyZSBpbiBmaWd1cmVzIDQ0NyBhbmQgZm9sbG93aW5nOgoKLSB4
IGFuZCB5OiBESCBwcml2YXRlIGtleSAoa2VybmVsIGNhbGxzIGl0IHNlY3JldCBzZXQgd2l0aCBk
aF9zZXRfc2VjcmV0IG9yCmVuY29kZWQgaW50byBwYXJhbS5rZXkpCgotIGdeeCBtb2QgcCAgLyBn
XnkgbW9kIHA6IERIIHB1YmxpYyBrZXlzIGZyb20gZWl0aGVyIGVuZCB0aGF0IGlzIGNvbW11bmlj
YXRlZApvdmVyIHRoZSB3aXJlIChjb3JyZXNwb25kaW5nIHRvIHRoZSB0aGUgREggcHJpdmF0ZSBr
ZXlzIG9mIHggYW5kIHkpIC0gdG8gc2V0Cml0LCB5b3UgaW5pdGlhbGl6ZSBhIGRoIHJlcXVlc3Qg
YW5kIHNldCB0aGUgcHVibGljIGtleSB0byBpdCB3aXRoCmtwcF9yZXF1ZXN0X3NldF9pbnB1dC4g
QWZ0ZXIgcGVyZm9ybWluZyB0aGUgY3J5cHRvX2twcF9jb21wdXRlX3NoYXJlZF9zZWNyZXQKeW91
IHJlY2VpdmUgdGhlIHNoYXJlZCBzZWNyZXQKCi0gZ154eSBtb2QgcDogREggc2hhcmVkIHNlY3Jl
dCAtIHRoaXMgaXMgdGhlIG9uZSB0aGF0IGlzIHRvIGJlIHVzZWQgZm9yIHRoZQpzdWJzZXF1ZW50
IGhhc2hpbmcgL0hNQUMgb3BlcmF0aW9ucyBhcyB0aGlzIGlzIHRoZSBvbmUgdGhhdCBpcyBpZGVu
dGljYWwgb24KYm90aCwgdGhlIGhvc3QgYW5kIHRoZSBjb250cm9sbGVyLgoKQ2lhbwpTdGVwaGFu
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
