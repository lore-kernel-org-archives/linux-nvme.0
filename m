Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648BFC433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 07:12:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA42E619DA
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 07:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA42E619DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pfEVjYpKlV7DsJnaCiisxTBTZoxuzYTE9z7Vi6vjwrs=; b=TQaL9d79jb2DBhOpMrRa9r4yd
	o8WFUD8awgaCGblAjWLCUgrYajsPmRRkvC/HjASMI1EOiOV7EQqOXLsICHaV0IcZ0Natv+IogWg3U
	b/xkyCeOLlAawdgy146aF4jFg+1yz1/mL3p9isyDzhdwLuXaXZrp8PKvmVntN2jZioM2SMoaVFaia
	ugA4absJ6jW5uWXiiYpWao0k1VAdbXfmZJh6Q2/NI/yZWgHpTz2KzuTlCqJc5mS8iX74M7JsyuEsu
	eOa6INcPdyGu2d9zty1AcHPEhIex/XxWIpFlgjZL99JkDzk3xvCq1UUXD2bod+fJyR4+faSEmZQP/
	qGaCahD0w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRV1L-005kJS-0T; Wed, 31 Mar 2021 07:12:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRV1G-005kJ3-6I
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 07:12:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7CC63AFFA;
 Wed, 31 Mar 2021 07:12:00 +0000 (UTC)
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: "Ewan D. Milne" <emilne@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
Date: Wed, 31 Mar 2021 09:11:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_081202_472672_87875812 
X-CRM114-Status: GOOD (  25.03  )
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

T24gMy8zMS8yMSAxOjI4IEFNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBUdWUsIE1hciAzMCwg
MjAyMSBhdCAxMDozNDoyNUFNIC0wNzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pgo+Pj4+IEl0
IGlzLCBidXQgaW4gdGhpcyBzaXR1YXRpb24sIHRoZSBjb250cm9sbGVyIGlzIHNlbmRpbmcgYSBz
ZWNvbmQKPj4+PiBjb21wbGV0aW9uIHRoYXQgcmVzdWx0cyBpbiBhIHVzZS1hZnRlci1mcmVlLCB3
aGljaCBtYWtlcyB0aGUKPj4+PiB0cmFuc3BvcnQgaXJyZWxldmFudC4gVW5sZXNzIHRoZXJlIGlz
IHNvbWUgb3RoZXIgZmxvdyAod2hpY2ggaXMKPj4+PiB1bmNsZWFyCj4+Pj4gdG8gbWUpIHRoYXQg
Y2F1c2VzIHRoaXMgd2hpY2ggaXMgYSBidWcgdGhhdCBuZWVkcyB0byBiZSBmaXhlZCByYXRoZXIK
Pj4+PiB0aGFuIGhpZGRlbiB3aXRoIGEgc2FmZWd1YXJkLgo+Pj4+Cj4+Pgo+Pj4gVGhlIGtlcm5l
bCBzaG91bGQgbm90IGNyYXNoIHJlZ2FyZGxlc3Mgb2YgYW55IG5ldHdvcmsgdHJhZmZpYyB0aGF0
IGlzCj4+PiBzZW50IHRvIHRoZSBzeXN0ZW0uICBJdCBzaG91bGQgbm90IGJlIHBvc3NpYmxlIHRv
IGVpdGhlciBpbnRlbnRpb25hbGx5Cj4+PiBvZiBtaXN0YWtlbmx5IGNvbnRydWN0IHBhY2tldHMg
dGhhdCB3aWxsIGRlbnkgc2VydmljZSBpbiB0aGlzIHdheS4KPj4KPj4gVGhpcyBpcyBub3Qgc3Bl
Y2lmaWMgdG8gbnZtZS10Y3AuIEkgY2FuIGJ1aWxkIGFuIHJkbWEgb3IgcGNpIGNvbnRyb2xsZXIK
Pj4gdGhhdCBjYW4gdHJpZ2dlciB0aGUgc2FtZSBjcmFzaC4uLiBJIHNhdyBhIHNpbWlsYXIgcGF0
Y2ggZnJvbSBIYW5uZXMKPj4gaW1wbGVtZW50ZWQgaW4gdGhlIHNjc2kgbGV2ZWwsIGFuZCBub3Qg
dGhlIGluZGl2aWR1YWwgc2NzaSB0cmFuc3BvcnRzLi4KPiAKPiBJZiBzY3NpIHdhbnRzIHRoaXMg
dG9vLCB0aGlzIGNvdWxkIGJlIG1hZGUgZ2VuZXJpYyBhdCB0aGUgYmxrLW1xIGxldmVsLgo+IFdl
IGp1c3QgbmVlZCB0byBtYWtlIHNvbWV0aGluZyBsaWtlIGJsa19tcV90YWdfdG9fcnEoKSwgYnV0
IHJldHVybiBOVUxMCj4gaWYgdGhlIHJlcXVlc3QgaXNuJ3Qgc3RhcnRlZC4KPiAgCj4+IEkgd291
bGQgYWxzbyBtZW50aW9uLCB0aGF0IGEgY3Jhc2ggaXMgbm90IGV2ZW4gdGhlIHNjYXJpZXN0IGlz
c3VlIHRoYXQKPj4gd2UgY2FuIHNlZSBoZXJlLCBiZWNhdXNlIGlmIHRoZSByZXF1ZXN0IGhhcHBl
bmVkIHRvIGJlIHJldXNlZCB3ZSBhcmUKPj4gaW4gdGhlIHNpbGVudCBkYXRhIGNvcnJ1cHRpb24g
cmVhbG0uLi4KPiAKPiBJZiB0aGlzIGRvZXMgaGFwcGVuLCBJIHRoaW5rIHdlIGhhdmUgdG8gY29t
ZSB1cCB3aXRoIHNvbWUgd2F5IHRvCj4gbWl0aWdhdGUgaXQuIFdlJ3JlIG5vdCB1dGlsaXppbmcg
dGhlIGZ1bGwgMTYgYml0cyBvZiB0aGUgY29tbWFuZF9pZCwgc28KPiBtYXliZSB3ZSBjYW4gYXBw
ZW5kIHNvbWV0aGluZyBsaWtlIGEgZ2VuZXJhdGlvbiBzZXF1ZW5jZSBudW1iZXIgdGhhdCBjYW4K
PiBiZSBjaGVja2VkIGZvciB2YWxpZGl0eS4KPiAKLi4uIHdoaWNoIHdpbGwgYmUgbmVhciBpbXBv
c3NpYmxlLgpXZSBjYW4gcHJvdGVjdCBhZ2FpbnN0IGNyYXNoaW5nIG9uIGludmFsaWQgZnJhbWVz
LgpXZSBjYW4gX25vdF8gcHJvdGVjdCBhZ2FpbnN0IG1hbGljaW91c2x5IGNyYWZ0ZWQgcGFja2V0
cyByZWZlcmVuY2luZyBhbnkKcmFuZG9tIF9leGlzdGluZ18gdGFnOyB0aGF0J3Mgd2hhdCBUTFMg
aXMgZm9yLgoKV2hhdCB3ZSBjYW4gZG8sIHRob3VnaCwgaXMgY2hlY2tpbmcgdGhlICdzdGF0ZScg
ZmllbGQgaW4gdGhlIHRjcApyZXF1ZXN0LCBhbmQgb25seSBhbGxvdyBjb21wbGV0aW9ucyBmb3Ig
Y29tbWFuZHMgd2hpY2ggYXJlIGluIGEgc3RhdGUKYWxsb3dpbmcgZm9yIGNvbXBsZXRpb25zLgoK
TGV0J3Mgc2VlIGlmIEkgY2FuIHdoaXAgdXAgYSBwYXRjaC4KCkNoZWVycywKCkhhbm5lcwotLSAK
RHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QK
aGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
