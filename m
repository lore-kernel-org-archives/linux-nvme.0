Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3FFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 08:37:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FE764E20
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 08:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FE764E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vK8OUo38TcPjk3tHETKq+pClHhScPVmrL9xC2EkPOlA=; b=OFjlu9VRtBoc5ZOcyHy6lts0P
	9/M3Hnw/sBcjI/asnUTT5WYKwvhxugq21/vidACIaJ/GMzsw7JQZ7NKcSg3Krw5Z8AXvtR5GxSToc
	drWxya/OlIHoHD+DVKk7JT65f0p2FCK6Ioqedl5aXvSygPQTMPVXgR0Z6izOq/XV7IjP7fCghZaWf
	RGAPEY5NnE3BQptKECBLgLnBkdVMij3Pw/O5pxutLUEiLWev3xoaULm+INeseSBwgXkbr7ue3nu+6
	jDdgmnJ9dwKBLXxjJpZcengRHnawEBzv5hrW0Ln6bQnkGv+a64QtUOsU96c1tlp6mirmeUzXnOGjF
	fnWhLmAfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFC8y-0001m7-EW; Thu, 25 Feb 2021 08:37:08 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFC8v-0001li-B2
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 08:37:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 43C2EAAAE;
 Thu, 25 Feb 2021 08:37:04 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: delete disk when last path is gone
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20210223115922.104369-1-hare@suse.de>
 <20210223115922.104369-3-hare@suse.de>
 <eb979539-96fb-b767-5c5a-259263a25a0b@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4f2f7072-4bf4-3a00-047f-c20829fa09ba@suse.de>
Date: Thu, 25 Feb 2021 09:37:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <eb979539-96fb-b767-5c5a-259263a25a0b@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_033705_523702_2948EE0F 
X-CRM114-Status: GOOD (  29.84  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNC8yMSAxMTo0MCBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gVGhlIG11bHRp
cGF0aCBjb2RlIGN1cnJlbnRseSBkZWxldGVzIHRoZSBkaXNrIG9ubHkgYWZ0ZXIgYWxsIHJlZmVy
ZW5jZXMKPj4gdG8gaXQgYXJlIGRyb3BwZWQgcmF0aGVyIHRoYW4gd2hlbiB0aGUgbGFzdCBwYXRo
IHRvIHRoYXQgZGlzayBpcyBsb3N0Lgo+PiBUaGlzIGhhcyBiZWVuIHJlcG9ydGVkIHRvIGNhdXNl
IHByb2JsZW1zIHdpdGggc29tZSB1c2UgY2FzZXMgbGlrZSBNRCAKPj4gUkFJRC4KPiAKPiBXaGF0
IGlzIHRoZSBleGFjdCBwcm9ibGVtPwo+IAo+IENhbiB5b3UgZGVzY3JpYmUgd2hhdCB0aGUgcHJv
YmxlbSB5b3Ugc2VlIG5vdyBhbmQgd2hhdCB5b3UgZXhwZWN0Cj4gdG8gc2VlICh1bnJlbGF0ZWQg
dG8gcGF0Y2ggIzEpPwo+IApUaGUgcHJvYmxlbSBpcyBhIGRpZmZlcmVuY2UgaW4gYmVoYXZpb3Vy
IGJldHdlZW4gbXVsdGlwYXRoZWQgYW5kIApub24tbXVsdGlwYXRoZWQgbmFtZXNwYWNlcyAoaWUg
d2hldGhlciAnQ01JQycgaXMgc2V0IG9yIG5vdCkuCklmIHRoZSBDTUlDIGJpdCBpcyBfbm90XyBz
ZXQsIHRoZSBkaXNrIGRldmljZSB3aWxsIGJlIHJlbW92ZWQgb25jZQp0aGUgY29udHJvbGxlciBp
cyBnb25lOyBpZiB0aGUgQ01JQyBiaXQgaXMgc2V0IHRoZSBkaXNrIGRldmljZSB3aWxsIGJlIApy
ZXRhaW5lZCwgYW5kIG9ubHkgcmVtb3ZlZCBvbmNlIHRoZSBsYXN0IF9yZWZlcmVuY2VfIGlzIGRy
b3BwZWQuCgpUaGlzIGlzIGNhdXNpbmcgY3VzdG9tZXIgaXNzdWVzLCBhcyBzb21lIHZlbmRvcnMg
cHJvZHVjZSBuZWFybHkgCmlkZW50aWNhbCBQQ0kgTlZNZSBkZXZpY2VzLCB3aGljaCBkaWZmZXIg
aW4gdGhlIENNSUMgYml0LgpTbyBkZXBlbmRpbmcgb24gd2hpY2ggZGV2aWNlIHRoZSBjdXN0b21l
ciB1c2VzLCBoZSBtaWdodCBiZSBnZXR0aW5nIG9uIApvciB0aGUgb3RoZXIgYmVoYXZpb3VyLgpB
bmQgdGhpcyBpcyBjYXVzaW5nIGlzc3VlcyB3aGVuIHNhaWQgY3VzdG9tZXIgZGVwbG95cyBNRCBS
QUlEIG9uIHRoZW1zOwp3aXRoIG9uZSBzZXQgb2YgZGV2aWNlcyBQQ0kgaG90cGx1ZyB3b3Jrcywg
d2l0aCB0aGUgb3RoZXIgc2V0IG9mIGRldmljZXMgCml0IGRvZXNuJ3QuCgo+PiBUaGlzIHBhdGNo
IGltcGxlbWVudHMgYW4gYWx0ZXJuYXRpdmUgYmVoYXZpb3VyIG9mIGRlbGV0aW5nIHRoZSBkaXNr
IHdoZW4KPj4gdGhlIGxhc3QgcGF0aCBpcyBnb25lLCBpZSB0aGUgc2FtZSBiZWhhdmlvdXIgYXMg
bm9uLW11bHRpcGF0aGVkIG52bWUKPj4gZGV2aWNlcy4KPiAKPiBCdXQgd2UgYWxzbyBkb24ndCBy
ZW1vdmUgdGhlIG5vbi1tdWx0aXBhdGgnZCBudm1lIGRldmljZSB1bnRpbCB0aGUKPiBsYXN0IHJl
ZmVyZW5jZSBkcm9wcyAoZS5nLiBpZiB5b3UgaGF2ZSBhIG1vdW50ZWQgZmlsZXN5c3RlbSBvbiB0
b3ApLgo+IApBdSBjb250cmFpcmUuCgpXaGVuIGRvaW5nIFBDSSBob3RwbHVnIHRoZSBjb250cm9s
bGVyIGlzIHJlbW92ZWQgKGluIHRoZSBub24tbXVsdGlwYXRoZWQgCmNhc2UpLCBhbmQgY2FsbGlu
ZyAncHV0X2Rpc2soKScgZHVyaW5nIG52bWVfZnJlZV9ucygpLgpXaGVuIGRvaW5nIFBDSSBob3Rw
bHVnIGluIHRoZSBub24tbXVsdGlwYXRoZWQgY2FzZSwgdGhlIGNvbnRyb2xsZXIgaXMgCnJlbW92
ZWQsIHRvbywgYnV0IHB1dF9kaXNrKCkgaXMgb25seSBjYWxsZWQgb24gdGhlIG5hbWVzcGFjZSBp
dHNlbGY7IHRoZSAKJ25zaGVhZCcgZGlzayBpcyBzdGlsbCBrZXB0IGFyb3VuZCwgYW5kIHB1dF9k
aXNrKCkgb24gdGhlICduc2hlYWQnIGRpc2sgCmlzIG9ubHkgY2FsbGVkIGFmdGVyIHRoZSBsYXN0
IHJlZmVyZW5jZSBpcyBkcm9wcGVkLgoKPiBUaGlzIHdvdWxkIGJlIHRoZSBlcXVpdmFsZW50IHRv
IHJ1bm5pbmcgcmFpZCBvbiB0b3Agb2YgZG0tbXBhdGggb24KPiB0b3Agb2Ygc2NzaSBkZXZpY2Vz
IHJpZ2h0PyBBbmQgaWYgYWxsIHRoZSBtcGF0aCBkZXZpY2Ugbm9kZXMgZ28gYXdheQo+IHRoZSBt
cGF0aCBkZXZpY2UgaXMgZGVsZXRlZCBldmVuIGlmIGl0IGhhcyBhbiBvcGVuIHJlZmVyZW5jZSB0
byBpdD8KPiAKU2VlIGFib3ZlLiBUaGUgcHJpbWUgbW90aXZhdG9yIGJlaGluZCB0aGlzIHBhdGNo
IGlzIHRvIGdldCBlcXVpdmFsZW50IApiZWhhdmlvdXIgYmV0d2VlbiBtdWx0aXBhdGhlZCBhbmQg
bm9uLW11bHRpcGF0aGVkIGRldmljZXMuCkl0IGp1c3Qgc28gaGFwcGVucyB0aGF0IE1EIFJBSUQg
ZXhlcmNpc2VzIHRoaXMgcGFydGljdWxhciBpc3N1ZS4KCj4+IFRoZSBuZXcgYmVoYXZpb3VyIHdp
bGwgYmUgc2VsZWN0ZWQgd2l0aCB0aGUgJ2ZhaWxfaWZfbm9fcGF0aCcKPj4gYXR0cmlidXRlLCBh
cyByZXR1cm5pbmcgaXQncyBhcmd1YWJseSB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5Lgo+IAo+IEJ1
dCBpdHMgbm90IHRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkuCgpBZ3JlZWQuIEJ1dCBhcyB0aGUgZmly
c3QgcGF0Y2ggd2lsbCBiZSBkcm9wcGVkIChzZWUgbXkgb3RoZXIgbWFpbCkgSSdsbCAKYmUgcmVk
b2luZyB0aGUgcGF0Y2hzZXQgYW55d2F5LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1
c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcK
SFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTD
tnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
