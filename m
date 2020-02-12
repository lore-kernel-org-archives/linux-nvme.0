Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE45C2BA83
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:52:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC042168B
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UnRK25wF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC042168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JRkpnPALS3T1MSnjG4GkkuOa9DLAyIf2jlRKBXQG/uY=; b=UnRK25wFOndZKlg7BZfIoEG5Z
	VAxruvW0gDHTbU9wZEXwHzUIuzTpVSDxS7/0WxN3xflQmoGHWSkNX7GkDOCusCAmKYqMeeWASmBPR
	zSlLbthxOyJR/a5oCvBe/+mfstMAtwl0+fNnJT11vS3cHI8aoaMHiz4pJFSjgP/0u4WLFFxcwIxsx
	/oWCCXsqiJ2cAIZTiT/srA4B7dpvpckxWk2TTYACLc5yG7vlvxYxzoVhyzC/N/ZaC8H8j92fumZeR
	Vp7NfH6Pn+McO/UOIhYgHoEfdVQktolG5N6J/YzFpw76q4zqR4ddK+fJeHSBFFkbHLry+JD4BVlXA
	fr1UzccWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1wB6-0003Fc-PZ; Wed, 12 Feb 2020 17:52:00 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1wB4-0003F8-Km
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 17:52:00 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C0CA6ADBB;
 Wed, 12 Feb 2020 17:51:56 +0000 (UTC)
Subject: Re: Case-sensitive host NQN
To: Christoph Hellwig <hch@lst.de>
References: <4973fdd4-8a6c-1218-8f82-5413d3fec37f@suse.de>
 <20200212173529.GA5648@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <055b0c4e-905a-7f3f-d5eb-595e127d423b@suse.de>
Date: Wed, 12 Feb 2020 18:51:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212173529.GA5648@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_095158_824674_BD5EE957 
X-CRM114-Status: GOOD (  20.63  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xMi8yMCA2OjM1IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBXZWQsIEZl
YiAxMiwgMjAyMCBhdCAwMTo1ODoyNlBNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IEhpIGFsbCwKPj4KPj4gSSd2ZSBzdHVtYmxlZCBhY3Jvc3MgYSBzbGlnaHQgd2VpcmRuZXNzIGZv
ciBvdXIgaGFuZGxpbmcgb2YgaG9zdCBOUU5zLgo+PiBXZSBkbyBmb3JtYXQgdGhlbSBsaWtlCj4+
Cj4+ICMgY2F0IC9ldGMvbnZtZS9ob3N0bnFuCj4+IG5xbi4yMDE0LTA4Lm9yZy5udm1leHByZXNz
OnV1aWQ6MzYzNDMwNTAtMzgzNC01ODRELTUxMzgtMzMzMTMwMzAzNDRFCj4+Cj4+IGFzIHRoaXMg
aXMgYSBVVUlELCBvbmUgd291bGQgZXhwZWN0IHRoYXQgaXQncyBpZGVudGljYWwgdG8KPj4KPj4g
IyBjYXQgL2V0Yy9udm1lL2hvc3RucW4KPj4gbnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6dXVp
ZDozNjM0MzA1MC0zODM0LTU4NGQtNTEzOC0zMzMxMzAzMDM0NGUKPj4KPj4gKE5vdGUgdGhlIGxv
d2VyY2FzZSBsZXR0ZXJzKS4KPj4gQXMgaXQgdHVybnMgb3V0LCB0aGlzIGlzIF9ub3RfIHRoZSBj
YXNlLCBjYXVzaW5nIHRoZSBjb25uZWN0aW9uIG5vdCB0bwo+PiBiZSBlc3RhYmxpc2hlZC4KPj4K
Pj4gV2hpY2ggaXMgc2xpZ2h0bHkgd2VpcmQsIGFuZCBub3Qgd2hhdCBvbmUgd291bGQgZXhwZWN0
Lgo+PiBUaGUgTlZNZSBzcGVjIG9ubHkgaGFzIHRoaXMgdmFndWUgc3RhdGVtZW50Cj4+ICJVcG9u
IGVudHJ5IE5WTSBob3N0IHNvZnR3YXJlIG1heSBwcm9jZXNzIGFuIE5WTWUgcXVhbGlmaWVkIG5h
bWUuLi4iCj4+IHNvIHdlIHdvdWxkIGJlIHNwZWMtY29tcGF0aWJsZSB3aGVuIHNldHRpbmcgdGhl
IGZpZWxkcyB0byBsb3dlcmNhc2UKPj4gd2hlbiByZWFkaW5nIHRoZSBucW4uCj4gCj4gQ2hlY2sg
c2VjdGlvbiA3Ljkgb2YgTlZNZSAxLjQ6Cj4gCj4gIk5WTWUgaG9zdHMsIGNvbnRyb2xsZXJzIGFu
ZCBOVk0gc3Vic3lzdGVtcyBjb21wYXJlIChlLmcuLCBmb3IgZXF1YWxpdHkpCj4gTlZNZSBRdWFs
aWZpZWQgTmFtZXMgdXNlZCBieSBOVk1lIGFzIGJpbmFyeSBzdHJpbmdzIHdpdGhvdXQgYW55IHRl
eHQKPiBwcm9jZXNzaW5nIG9yIHRleHQgY29tcGFyaXNvbiBsb2dpYyB0aGF0IGlzIHNwZWNpZmlj
IHRvIHRoZSBVbmljb2RlCj4gY2hhcmFjdGVyIHNldCBvciBsb2NhbGUgKGUuZy4sIGNhc2UgZm9s
ZGluZyBvciBjb252ZXJzaW9uIHRvIGxvd2VyIGNhc2UsCj4gVW5pY29kZSBub3JtYWxpemF0aW9u
KS4iCj4gCj4gc28gbm8sIHRoZXkgYXJlIGNhc2Ugc2Vuc2l0aXZlIGFuZCB0aGUgYWJvdmUgaXMg
YnkgZGVzaWduLgo+IAooSSBrbmV3IEkgd291bGQgYmUgZ2V0dGluZyB0aGlzIGFuc3dlciA6LSkK
QnV0IGlmIHlvdSByZWFkIHRoZSB2ZXJ5IG5leHQgc2VudGVuY2UgaXQgc2F5czoKCkFueSBzdWNo
IHRleHQgcHJvY2Vzc2luZzoKYSkgbWF5IG9jY3VyIGFzIHBhcnQgb2YgZW50cnkgb2YgTlZNZSBR
dWFsaWZpZWQgTmFtZXMgaW50byBOVk1lIGhvc3RzIAphbmQgTlZNIHN1YnN5c3RlbXM7IGFuZApi
KSBzaG91bGQgbm90IG9jY3VyIGFzIHBhcnQgb2YgcmVjZWl2aW5nIE5WTWUgUXVhbGlmaWVkIE5h
bWVzIHZpYSBhbiAKTlZNZSBjb25uZWN0aW9uLCBhcyBzaG93biBpbiBGaWd1cmUgNDM2LgoKSUUg
d2Ugd291bGQgYmUgcGVyZmVjdGx5IHdpdGhpbiB0aGUgc3BlYyB0byBjb252ZXJ0IHRoZSBucW4g
dG8gZWcgCmxvd2VyY2FzZSB3aGVuIHJlYWRpbmcgaXQgZnJvbSAvZXRjL252bWUvaG9zdG5xbi4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgIFRlYW1s
ZWFkIFN0b3JhZ2UgJiBOZXR3b3JraW5nCmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJI
LCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcp
LCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdAps
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
