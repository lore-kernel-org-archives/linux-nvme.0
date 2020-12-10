Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD37C4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 11:44:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB35C23D67
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 11:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB35C23D67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j+skdhn7m3jKlCvNfniffvhcMTl/wjtW4JZhoHpCZ7Y=; b=GpQGpkHKrSMIdzL9wTyns5WUt
	q1O7SxEVHiLY6lQ3V4TpjrpGHpAAMOIyAVMeOAb8wFNV+5eNPUpMwkjks0WbTqjpDNiZJi1SP17mz
	KfsorzkI8Kn6FQhXRi6byFBMPk7X+ZawoqbvH9L0NyHrAncAEawDW5Kfw2cDZ+4Ci+wOJ1dc6A4zk
	BKqWmudOMK2SnkYfo5zv6cwFSo45jFYIXprGEfjK+MzIVGFnHCVp38bIoInWnm/wIjDXKQ+aK+mBy
	0rPw3UKPiBU/6Mbdae0a1ujHl7Rf0sWEYUYMxOlMUqHDu21HLgfNT9w4S41UmTnaXrWdvIYpyzFw4
	pSvZOjj+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knKN8-0003yR-9J; Thu, 10 Dec 2020 11:44:34 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knKN5-0003xy-IP
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 11:44:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 925F5AE52;
 Thu, 10 Dec 2020 11:44:28 +0000 (UTC)
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
To: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20201209072806.GA10037@lst.de>
 <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
 <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
 <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
 <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
 <20201209174718.GA19512@lst.de>
 <DM5PR0601MB3624722C4C00B5A7EDB7E6A0F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209213437.GA3682670@dhcp-10-100-145-180.wdc.com>
 <20201210085111.GA15999@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <baa8c2e6-1376-1cad-4c84-1129bd80d4ca@suse.de>
Date: Thu, 10 Dec 2020 10:13:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201210085111.GA15999@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_064431_750499_861C36A3 
X-CRM114-Status: GOOD (  22.33  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Knight,
 Frederick" <Frederick.Knight@netapp.com>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvMTAvMjAgOTo1MSBBTSwgaGNoQGxzdC5kZSB3cm90ZToKPiBPbiBXZWQsIERlYyAwOSwg
MjAyMCBhdCAwMTozNDozN1BNIC0wODAwLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4gTGludXggaG9z
dHMgY3VycmVudGx5IHdhbnQgYW4gQU5BIEFFTiBhbnl0aW1lIHRoZSBob3N0IG5lZWRzIHRvIHJl
ZnJlc2gKPj4gdGhlIEFOQSBsb2cuIFRoYXQgaW5jbHVkZXMgYW55IGNvbmRpdGlvbiB0aGF0IGFk
ZHMgZ3JvdXBzIHRoYXQgZGlkbid0Cj4+IGV4aXN0IGZyb20gdGhlIGhvc3QncyBwcmV2aW91cyBy
ZWFkaW5nLgo+Pgo+PiBJZiB0aGUgTmFtZXNwYWNlIEF0dGFjaCBvY2N1cnMgdG8gYW4gQU5BIGdy
b3VwIHRoZSBob3N0IGFscmVhZHkga25vd3MKPj4gYWJvdXQsIHRoZW4geW91IGRvbid0IG5lZWQg
dG8gc2VuZCBhbiBBTkEgQUVOIGJlY2F1c2UgdGhlcmUncyBub3RoaW5nCj4+IG5ldyBpbiB0aGUg
bG9nIHRoYXQgdGhlIGhvc3QgcmVxdWlyZXMuIFlvdSBqdXN0IG5lZWQgdG8gc2VuZCB0aGUgTlMK
Pj4gTm90aWZ5IEFFTi4KPj4KPj4gQnV0IGlmIGEgc2lkZSBlZmZlY3Qgb2YgYXR0YWNoaW5nIGEg
bmFtZXNwYWNlIHJlc3VsdHMgaW4gYSBuZXcgQU5BIGdyb3VwCj4+IGJlY29taW5nIHZpc2libGUg
dG8gdGhlIGhvc3QsIHRoZW4gdGhhdCBncm91cCBjcmVhdGlvbiBpcyBjb25zaWRlcmVkIGEKPj4g
c2VwYXJhdGUgZXZlbnQsIHNvIHRoZSBob3N0IHdhbnRzIGJvdGggQUVOcy4gSSBiZWxpZXZlIHRo
aXMgaXMgd2hlcmUKPj4gQ2hyaXN0b3BoIGlzIHRyeWluZyB0byBzdGVlciB0aGUgaW50ZXJwcmV0
YXRpb24gYW5kIHRoZSB0ZXh0Lgo+IAo+IEV4YWN0bHkuICBBbHRob3VnaCBhcyBIYW5uZXMgcG9p
bnRlZCBvdXQsIHRoaXMgbGFuZ3VhZ2U6Cj4gCj4gICAgSWYsIGZvciBhbiBBTkEgR3JvdXAsIHRo
ZXJlIGFyZSBubyBuYW1lc3BhY2VzIGF0dGFjaGVkIHRvIHRoZQo+ICAgIGNvbnRyb2xsZXIgcHJv
Y2Vzc2luZyB0aGUgY29tbWFuZCwgdGhlbiBubyBBTkEgR3JvdXAgRGVzY3JpcHRvciBpcwo+ICAg
IHJldHVybmVkIGZvciB0aGF0IEFOQSBHcm91cCAoaS5lLiwgYW4gQU5BIEdyb3VwIERlc2NyaXB0
b3IgaXMgcmV0dXJuZWQKPiAgICBvbmx5IGlmIHRoYXQgQU5BIEdyb3VwIGNvbnRhaW5zIG5hbWVz
cGFjZXMgdGhhdCBhcmUgYXR0YWNoZWQgdG8gdGhlCj4gICAgY29udHJvbGxlciBwcm9jZXNzaW5n
IHRoZSBjb21tYW5kLgo+IAo+IGNyZWF0ZXMgYSBiaXQgb2YgYSBjaGlja2VuIGFuIGVnZyBwcm9i
bGVtIGluIHRoYXQgY2FzZSBvZiBhIG5ld2x5Cj4gYXR0YWNoZWQgbmFtZXNwYWNlIHRoYXQgaXMg
dGhlIGZpcnN0IG9uZSByZWZlcmVuY2luZyBhbiBBTkEgZ3JvdXAuCj4gClllcywgdGhpcyB3YXMg
d2hhdCBJIHRyaWVkIHRvIG91dGxpbmUuCgpQZXJzb25hbGx5IEkgZG9uJ3QgbWluZCB3aGV0aGVy
IHRoZSBjb250cm9sbGVyIGlzIHJlcXVpcmVkIHRvIHNlbmQgYW4gCkFOQSBjaGFuZ2UgQUVOIHRv
Z2V0aGVyIHdpdGggdGhlIE5TIGNoYW5nZSBBRU4uClJlcXVpcmluZyBib3RoIHdpbGwgcG9zZSBh
biBvcmRlcmluZyBpc3N1ZSAoYXMgb24gZmFicmljcyB3ZSBjYW4ndCAKY29udHJvbCB0aGUgY29t
cGxldGlvbiBvcmRlcmluZyksIHNvIGVmZmVjdGl2ZWx5IHdlJ2xsIGhhdmUgdG8gaW1wbGVtZW50
IApoYW5kbGluZyBmb3IgQUVOcyBhcnJpdmluZyBpbiBhbnkgb3JkZXIuCkJ1dCBJJ20gYWxzbyBm
aW5lIHdpdGgganVzdCBnZXR0aW5nIG9uZSBBRU47IHRoZSBwYXRjaCB3aWxsIHNvbHZlIHRoYXQg
CnNpdHVhdGlvbiBqdXN0IGZpbmUuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVp
bmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5k
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29m
dHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZm
ZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
