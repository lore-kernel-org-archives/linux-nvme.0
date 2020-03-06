Return-Path: <SRS0=GfOp=4X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745D1C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 09:18:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEE52072A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 09:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RWS4H0hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEE52072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5qWPMJkMW1CAhn2QlaOJ+Vk0jZbwebjdja/8blHdWDs=; b=RWS4H0hsiHAyce
	1E/NyEvVdx4jCxuUbdVhgtjDPJ0o8CmH/hae9AyvpGrRxebmmqIm4W97W59UzEJ+T0KFOvsF1aDOA
	Wq07PXuXey7gXKZdDBGUHVdjo5cDKYNrEg/kwPodrZiBRtb28QsgFdDpBzdF5smlnAsS2TddVg67i
	T/5is4LbvhxV3rdF9N0rhJhQEbcPL7e6QvQQwT7cO+MzY3LKhydIIMYrq8az2sGTMbv9ApRHbj7ms
	2sn8kRBCtTklioVF/ZRsxQBfUUimcA/WJ+pnrkkh67ooGcSpKlu47fmn8Vj0GdjdbHMqcyha2VCfh
	3RrhiR21AnmcL/d0FFgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jA97r-00071g-48; Fri, 06 Mar 2020 09:18:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA97o-00071A-3v
 for linux-nvme@lists.infradead.org; Fri, 06 Mar 2020 09:18:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 50770AE7B;
 Fri,  6 Mar 2020 09:18:29 +0000 (UTC)
Subject: Re: [PATCH 20/29] lpfc: Refactor lpfc nvme headers
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-21-jsmart2021@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <8a7c28de-869f-c0d7-5445-521b07769773@suse.de>
Date: Fri, 6 Mar 2020 10:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-21-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200306_011832_448596_16C124EE 
X-CRM114-Status: GOOD (  18.57  )
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
Cc: Paul Ely <paul.ely@broadcom.com>, martin.petersen@oracle.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi81LzIwIDc6MzcgUE0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IEEgbG90IG9mIGZpbGVzIGlu
IGxwZmMgaW5jbHVkZSBudm1lIGhlYWRlcnMsIGJ1aWxkaW5nIHVwIHJlbGF0aW9uc2hpcHMgdGhh
dAo+IHJlcXVpcmUgYSBmaWxlIHRvIGNoYW5nZSBmb3IgaXRzIGhlYWRlcnMgd2hlbiB0aGVyZSBp
cyBubyBvdGhlciBjaGFuZ2UKPiBuZWNlc3NhcnkuIEl0IHdvdWxkIGJlIGJldHRlciB0byBsb2Nh
bGl6ZSB0aGUgbnZtZSBoZWFkZXJzLgo+IAo+IFRoZXJlIGlzIGFsc28gbm8gbmVlZCBmb3Igc2Vw
YXJhdGUgbnZtZSAoaW5pdGlhdG9yKSBhbmQgbnZtZXQgKHRndCkKPiBoZWFkZXIgZmlsZXMuCj4g
Cj4gUmVmYWN0b3IgdGhlIGluY2x1c2lvbiBvZiBudm1lIGhlYWRlcnMgc28gdGhhdCBhbGwgbnZt
ZSBpdGVtcyBhcmUKPiBpbmNsdWRlZCBieSBscGZjX252bWUuaAo+IAo+IE1lcmdlIGxwZmNfbnZt
ZXQuaCBpbnRvIGxwZmNfbnZtZS5oIHNvIHRoYXQgdGhlcmUgaXMgYSBzaW5nbGUgaGVhZGVyIHVz
ZWQKPiBieSBib3RoIHRoZSBudm1lIGFuZCBudm1ldCBzaWRlcy4gVGhpcyBwcmVwYXJlcyBmb3Ig
c3RydWN0dXJlIHNoYXJpbmcKPiBiZXR3ZWVuIHRoZSB0d28gcm9sZXMuIFByZXAgdG8gYWRkIHNo
YXJlZCBmdW5jdGlvbiBwcm90b3R5cGVzIGZvciB1cGNvbWluZwo+IHNoYXJlZCByb3V0aW5lcy4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBQYXVsIEVseSA8cGF1bC5lbHlAYnJvYWRjb20uY29tPgo+IFNp
Z25lZC1vZmYtYnk6IEphbWVzIFNtYXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4KPiAtLS0KPiAg
ZHJpdmVycy9zY3NpL2xwZmMvbHBmY19hdHRyLmMgICAgICB8ICAgMyAtCj4gIGRyaXZlcnMvc2Nz
aS9scGZjL2xwZmNfY3QuYyAgICAgICAgfCAgIDEgLQo+ICBkcml2ZXJzL3Njc2kvbHBmYy9scGZj
X2RlYnVnZnMuYyAgIHwgICAzIC0KPiAgZHJpdmVycy9zY3NpL2xwZmMvbHBmY19oYmFkaXNjLmMg
ICB8ICAgMiAtCj4gIGRyaXZlcnMvc2NzaS9scGZjL2xwZmNfaW5pdC5jICAgICAgfCAgIDMgLQo+
ICBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX21lbS5jICAgICAgIHwgICA0IC0KPiAgZHJpdmVycy9z
Y3NpL2xwZmMvbHBmY19ucG9ydGRpc2MuYyB8ICAgMiAtCj4gIGRyaXZlcnMvc2NzaS9scGZjL2xw
ZmNfbnZtZS5jICAgICAgfCAgIDMgLQo+ICBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX252bWUuaCAg
ICAgIHwgMTQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgZHJpdmVycy9z
Y3NpL2xwZmMvbHBmY19udm1ldC5jICAgICB8ICAgNSAtLQo+ICBkcml2ZXJzL3Njc2kvbHBmYy9s
cGZjX252bWV0LmggICAgIHwgMTU4IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPiAgZHJpdmVycy9zY3NpL2xwZmMvbHBmY19zbGkuYyAgICAgICB8ICAgMyAtCj4gIDEyIGZp
bGVzIGNoYW5nZWQsIDE0NyBpbnNlcnRpb25zKCspLCAxODcgZGVsZXRpb25zKC0pCj4gIGRlbGV0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX252bWV0LmgKPiAKUmV2aWV3ZWQt
Ynk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApE
ci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApo
YXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNv
ZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
