Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F2FC4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 17:04:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5A723C43
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 17:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5A723C43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8/G9ms/QjAZ0VRhGTU7+kGM0Ck/aijWyPg+iSwchMh0=; b=bu3eMRH3oj0CIuF63xJG9umYA
	VK9+U49CGYZXe2VbRkqdq0j2S1Z78T6wGsHwUrediZRMILnA75bJY9oFeeD1/lj1ahiQu1EEcZgsc
	hB2sfpbqyFqFKL6TjKsOr6uquVF03qTNphfEJbMjL4pM8PvtpT4JiSLWbDn6LiL1ZQSVYP/GUWL8h
	ssx2X0LbVzNKF45lteCR9R0vdUw/hI1kY1RouQo9RM9lUhu61KIU/bbdXE7RtCfp/7XsENANVmd1W
	gv3NQta5NTC07pt0dUzItS5iEXE8lH2ppbsoS0xmDBC1qJY26yuPndSJtXWLLPb888tIcIadW7zbY
	n8joeE+tg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn2tH-00058B-6Z; Wed, 09 Dec 2020 17:04:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn2tE-00057O-LZ
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 17:04:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1DD79AC9A;
 Wed,  9 Dec 2020 17:04:30 +0000 (UTC)
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
To: Keith Busch <kbusch@kernel.org>
References: <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209072806.GA10037@lst.de>
 <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
 <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
Date: Wed, 9 Dec 2020 18:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_120432_915534_5A9B5993 
X-CRM114-Status: GOOD (  22.99  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Knight, Frederick" <Frederick.Knight@netapp.com>,
 "Meneghini, John" <John.Meneghini@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvOS8yMCA1OjE5IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBXZWQsIERlYyAwOSwg
MjAyMCBhdCAwNTowMjowNVBNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDEy
LzkvMjAgNDo1MyBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+PiBPbiBXZWQsIERlYyAwOSwgMjAy
MCBhdCAwMzoyMDo1N1BNICswMDAwLCBLbmlnaHQsIEZyZWRlcmljayB3cm90ZToKPj4+PiBXaGVu
IGEgbmFtZXNwYWNlIGlzIGNyZWF0ZWQgKGFuZCBjb250YWluZWQgaW4gYW4gQU5BIEdyb3VwKSwg
dGhlIGFjdAo+Pj4+IG9mIGNyZWF0aW5nIHRoYXQgbmFtZXNwYWNlIHJlc3VsdHMgaW4gYSBjaGFu
Z2UgdG8gdGhlIEFOQSBMb2cgcGFnZSAtCj4+Pj4gdGhlcmVmb3JlIEFFTi4KPj4+Cj4+PiBUaGF0
IGlzIHdyb25nOiBjcmVhdGluZyBhIG5hbWVzcGFjZSBkb2Vzbid0IGRvIGFueXRoaW5nIHRvIHRo
ZSBBTkEgbG9nLgo+Pj4gT25seSBhdHRhY2hlZCBuYW1lc3BhY2VzIGFwcGVhciBpbiB0aGUgbG9n
LiBDcmVhdGluZyBhIG5hbWVzcGFjZQo+Pj4gZG9lc24ndCByZXN1bHQgaW4gYXV0b21hdGljYWxs
eSBhdHRhY2hpbmcgaXQgdG8gYW55IGNvbnRyb2xsZXIuCj4+Pgo+Pj4gWW91IGFyZSB0aGlua2lu
ZyBvZiBOYW1lc3BhY2UgQXR0YWNoIGZyb20gc2VjdGlvbiA1LjE5LCBhbmQgdGhlIHNwZWMKPj4+
IGRvZXNuJ3QgZGVmaW5lIGFueSBzcGVjaWFsIGV4Y2VwdGlvbnMgZm9yIGV2ZW50cyByZXN1bHRp
bmcgZnJvbSAqdGhhdCoKPj4+IGNvbW1hbmQsIHdoaWNoIGlzIGFsc28gdGhlIGNvbW1hbmQgdGhh
dCB0cmlnZ2VyZWQgdGhpcyB0aHJlYWQuCj4+Pgo+PiBBY3R1YWxseSwgbm8sIHdlJ3JlIG5vdCB0
aGlua2luZyBhYm91dCAnTmFtZXNwYWNlIEF0dGFjaCcuCj4gCj4gVGhpcyBwYXRjaCBpcyB0aGUg
cmVzdWx0IGZyb20gYW4gQXR0YWNoIGNvbW1hbmQsIG90aGVyd2lzZSB0aGUgaG9zdAo+IGRyaXZl
ciB3b3VsZG4ndCBoYXZlIGZvdW5kIGFuIHVua25vd24gQU5BIGdyb3VwIGZvciBhIG5ldyBuYW1l
c3BhY2UKPiBkdXJpbmcgdGhlIHJlc2Nhbi4KPiAKPj4gVGhpcyBpcyBhIG5vcm1hbCBuYW1lc3Bh
Y2UgY3JlYXRpb24gb24gdGhlIGNvbnRyb2xsZXIgc2lkZS4KPj4KPj4gSSBkbyBhZ3JlZSB0aGF0
ICdOYW1lc3BhY2UgQXR0YWNoJyB3b3VsZCBoYXZlIGRpZmZlcmVudCBjb25zdHJhaW5zIGFuZCBy
dWxlcwo+PiB1bmRlciB3aGljaCBBRU5zIHdpbGwgYmUgc2VudCwgYnV0IHRoaXMgaXMgbm90IHdo
YXQgb3VyIGluaXRpYWwgdXNlLWNhc2Ugd2FzCj4+IGFib3V0Lgo+IAo+IFRoZSB1c2UgY2FzZSBp
biB0aGlzIHBhdGNoIGlzIGFib3V0IGdldHRpbmcgdGhlIGhvc3QgdG8gcmVjb2duaXplIHRoZQo+
IEFOQSBncm91cCBvZiBhIG5ld2x5IGF0dGFjaGVkIG5hbWVzcGFjZS4gSWYgeW91IHN0b3AgYXQg
bmFtZXNwYWNlCj4gY3JlYXRpb24sIHRoZW4gdGhpcyBwYXRjaCBkb2Vzbid0IGRvIGFueXRoaW5n
Lgo+IApOb3cgeW91IGdvdCBtZSBjb25mdXNlZC4KT2YgY291cnNlIHRoZSBuYW1lc3BhY2UgaXMg
YXR0YWNoZWQgdG8gYSBjb250cm9sbGVyLCBidXQgdGhpcyBpcyBfbm90XyAKdGhlIHJlc3VsdCBv
ZiBhICduYW1lc3BhY2UgYXR0YWNoJyBjb21tYW5kIGZyb20gdGhlIGhvc3QuCklmIHRoYXQncyB3
aGF0IHlvdSBpbXBseS4KTm90IHN1cmUsIHRob3VnaDsgYXMgc2FpZCwgSSdtIGNvbmZ1c2VkIG5v
dy4KClRoZSB1c2UtY2FzZSBJJ20gdHJ5aW5nIHRvIGRlc2NyaWJlIGlzIHRoYXQgdGhlIGFkbWlu
IG9uIHRoZSBzdG9yYWdlIAphcnJheSBpcyBjcmVhdGluZyBhIG5hbWVzcGFjZSBhbmQgYXR0YWNo
aW5nIGl0IHRvIGFuIGV4aXN0aW5nIHN1YnN5c3RlbSwgCmNvbXBsZXRlbHkgd2l0aG91dCBpbnRl
cmFjdGlvbiBmcm9tIHRoZSBob3N0LiBJdCBqdXN0IHNvIGhhcHBlbnMgdGhhdCAKdGhpcyBuZXcg
bmFtZXNwYWNlIGhhcyBhIGRpZmZlcmVudCBBTkEgZ3JvdXAgdGhhbiB0aGUgZXhpc3RpbmcgCm5h
bWVzcGFjZXMgaW4gdGhpcyBzdWJzeXN0ZW0uClRoZW4gdGhlIGFycmF5IGhhcyB0byBub3RpZnkg
dGhlIGhvc3QgYWJvdXQgdGhpcy4KQW5kIHRoZSB3aG9sZSBkaXNjdXNzaW9uIGlzIGFib3V0IHdo
aWNoIEFFTnMgdGhpcyBjb250cm9sbGVyL3N0b3JhZ2UgCmFycmF5IHNob3VsZCBiZSBzZW5kaW5n
LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAg
IEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJI
LCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcp
LCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
