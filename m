Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43959C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 16:43:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF82064DED
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 16:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF82064DED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eewaodnZ3USZ4Ud8Y69QTIhSix9Hra+hotIHaapOxRA=; b=kQgc/MFc4GJB1rw7pvARVMh2/
	OCRET/+7HyYA7OxO87H5jsG9wAPmNbvNQ2Y6+3MHzpjBg1giTzXXSzu3fRqAyjSkEHSLqajIF/oKi
	Pu39ZI2aF0pYIbicBZX6OvhR4imEz4EfaIXy88iA9F8OSryFMjzKi5kQefrdXVqxXJVtFHeeSA+NO
	VRIJ0swX0e+F2/OsPZ1A4EOMBUI7oiSq43ZKG3cqy5ES4DeF/aax3PYUN4Of+czVIfizRSMSkzKji
	WCpakRFLqqXxbjTnxyRnGcizFteiJk1BJX06mrBmMRuE03lgv5WQ0I2riCGQNcPl3F5qKznwXJhIZ
	OH+yKDkFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lD8rs-0006QE-9l; Fri, 19 Feb 2021 16:43:00 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lD8rq-0006PI-8R
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 16:42:59 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3463CACD4
 for <linux-nvme@lists.infradead.org>; Fri, 19 Feb 2021 16:42:57 +0000 (UTC)
Subject: Re: [PATCH] nvme-fabrics: fix kato initialization
To: linux-nvme@lists.infradead.org
References: <20210218100443.5854-1-marting@netapp.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <03826110-0d9c-8b25-9975-b427036ec2cc@suse.de>
Date: Fri, 19 Feb 2021 17:42:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218100443.5854-1-marting@netapp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_114258_472123_168CA123 
X-CRM114-Status: GOOD (  23.88  )
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

T24gMi8xOC8yMSAxMTowNCBBTSwgTWFydGluIEdlb3JnZSB3cm90ZToKPiBDdXJyZW50bHkga2F0
byBpcyBpbml0aWFsaXplZCB0byBOVk1FX0RFRkFVTFRfS0FUTyBmb3IgYm90aAo+IGRpc2NvdmVy
eSAmIGkvbyBjb250cm9sbGVycy4gVGhpcyBpcyBhIHByb2JsZW0gc3BlY2lmaWNhbGx5Cj4gZm9y
IG5vbi1wZXJzaXN0ZW50IGRpc2NvdmVyeSBjb250cm9sbGVycyBzaW5jZSBpdCBhbHdheXMgZW5k
cwo+IHVwIHdpdGggYSBub24temVybyBrYXRvIHZhbHVlLiBGaXggdGhpcyBieSBpbml0aWFsaXpp
bmcga2F0bwo+IHRvIHplcm8gaW5zdGVhZCwgYW5kIGVuc3VyaW5nIHZhcmlvdXMgY29udHJvbGxl
cnMgYXJlIGFzc2lnbmVkCj4gYXBwcm9wcmlhdGUga2F0byB2YWx1ZXMgYXMgZm9sbG93czoKPiAK
PiBub24tcGVyc2lzdGVudCBjb250cm9sbGVycyAgLSBrYXRvIHNldCB0byB6ZXJvCj4gcGVyc2lz
dGVudCBjb250cm9sbGVycyAgICAgIC0ga2F0byBzZXQgdG8gTlZNRl9ERVZfRElTQ19UTU8KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKG9yIGFueSBwb3NpdGl2ZSBpbnQgdmlhIG52
bWUtY2xpKQo+IGkvbyBjb250cm9sbGVycyAgICAgICAgICAgICAtIGthdG8gc2V0IHRvIE5WTUVf
REVGQVVMVF9LQVRPCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChvciBhbnkgcG9z
aXRpdmUgaW50IHZpYSBudm1lLWNsaSkKPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gR2Vvcmdl
IDxtYXJ0aW5nQG5ldGFwcC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9mYWJyaWNz
LmMgfCA1ICsrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+IGluZGV4IDVkZmQ4MDZmYzJkMi4uNjA0YWIwZTVh
MmFkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+IEBAIC02MzAsNyArNjMwLDcgQEAgc3RhdGljIGlu
dCBudm1mX3BhcnNlX29wdGlvbnMoc3RydWN0IG52bWZfY3RybF9vcHRpb25zICpvcHRzLAo+ICAg
CW9wdHMtPnF1ZXVlX3NpemUgPSBOVk1GX0RFRl9RVUVVRV9TSVpFOwo+ICAgCW9wdHMtPm5yX2lv
X3F1ZXVlcyA9IG51bV9vbmxpbmVfY3B1cygpOwo+ICAgCW9wdHMtPnJlY29ubmVjdF9kZWxheSA9
IE5WTUZfREVGX1JFQ09OTkVDVF9ERUxBWTsKPiAtCW9wdHMtPmthdG8gPSBOVk1FX0RFRkFVTFRf
S0FUTzsKPiArCW9wdHMtPmthdG8gPSAwOwo+ICAgCW9wdHMtPmR1cGxpY2F0ZV9jb25uZWN0ID0g
ZmFsc2U7Cj4gICAJb3B0cy0+ZmFzdF9pb19mYWlsX3RtbyA9IE5WTUZfREVGX0ZBSUxfRkFTVF9U
TU87Cj4gICAJb3B0cy0+aGRyX2RpZ2VzdCA9IGZhbHNlOwo+IEBAIC04OTMsNiArODkzLDkgQEAg
c3RhdGljIGludCBudm1mX3BhcnNlX29wdGlvbnMoc3RydWN0IG52bWZfY3RybF9vcHRpb25zICpv
cHRzLAo+ICAgCQlvcHRzLT5ucl93cml0ZV9xdWV1ZXMgPSAwOwo+ICAgCQlvcHRzLT5ucl9wb2xs
X3F1ZXVlcyA9IDA7Cj4gICAJCW9wdHMtPmR1cGxpY2F0ZV9jb25uZWN0ID0gdHJ1ZTsKPiArCX0g
ZWxzZSB7Cj4gKwkJaWYgKCFvcHRzLT5rYXRvKQo+ICsJCQlvcHRzLT5rYXRvID0gTlZNRV9ERUZB
VUxUX0tBVE87Cj4gICAJfQo+ICAgCWlmIChjdHJsX2xvc3NfdG1vIDwgMCkgewo+ICAgCQlvcHRz
LT5tYXhfcmVjb25uZWN0cyA9IC0xOwo+IApDYW4ndCB5b3UgbWVyZ2UgdGhpcyB3aXRoIHRoZSBw
cmV2aW91cyBwYXRjaCAnZW5zdXJlIHplcm8ta2F0byAuLic/CgpDaGVlcnMsCgpIYW5uZXMKLS0g
CkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0
ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQw
NTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBG
ZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
