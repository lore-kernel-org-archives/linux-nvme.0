Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635CCC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 06:09:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE1261432
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 06:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE1261432
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lXm2zFqwLr6zaeMW2i/Q0AQwcmu3uDi4yhnEqE7omQY=; b=b0msM308UWRF9Z3x7ERYYefzo
	KYT9yN3IqsGgNwwGpbrwsnhmAv0SdIXSb3WUF4sKZ7/XXjdfnCIVo07bcgNeqpG1QWmknLrPHc5Tr
	rC5e8Khm2BDi9GfcRrHns2lCu0XNTiHjXEvM552imGZPEx1Npmrjpim6eT2UMXReWofSkY1ErmF6u
	rO1tkYvfmwV0Dad2OVAkwusmYv1MuxVqg/JPcV2FweZ2jauKt2MG811L1SHzwHW+krwHZ0PC0ADIC
	ElTVvmxS28btS/rb4vC1aJgI7ZOmlQncUreXeyg+suCxTJeCP8Jp4jggEx/p0QtOMmGw+5iYk1ZAD
	XfrxGBFRg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgi3s-0027nJ-VZ; Wed, 12 May 2021 06:09:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgi3r-0027n8-OU
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 06:09:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=8LEQvhihgPPF2bVd9ktm5SWrGlSC6hkMUCad3g85Pis=; b=dg/p2COge15KPOF4YvtbHmUJzB
 M5nfQjUZf8me1cFDgI4eoCbrYshjUNK2ZGi9rKfHmC3fj9HX1TfQ+wP+i5YAccnENU5oP+BgKZoPA
 X++tteqQ9LgJwNQrzn7BOCSqqdK7v66RTtgyIsH2AI+1rBqsgwUwg19XHxbHcvqW5uJWIu2DtnYHM
 lwH2iJISzsn1CWBKSx91y01mhX5lCc3T//og1yNYJr34QResIPOomQuZtOOGvZ+NN7vv816GtdZT9
 RDQ+B2nkYmpQu/Sc+SaW30ovir+4edmzPy5HRo+lv14K8Q18nn7OuRIFNUmoSIF7bDWGvt6ExFs3Z
 u6n3ThfA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgi3o-00A8Vq-RX
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 06:09:34 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 826C3B024;
 Wed, 12 May 2021 06:09:31 +0000 (UTC)
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
To: Sagi Grimberg <sagi@grimberg.me>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
 <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <dbb70739-e636-7f4c-7332-1fbc07332444@suse.de>
 <07fa3404-ed37-052a-c2d7-0e21c119f5c5@suse.de>
 <SJ0PR19MB4544F01520BE86D205B41B23F2589@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <b511b6a0-392f-9845-8097-1f2173085ce0@grimberg.me>
 <SJ0PR19MB4544420019D202816F4392DFF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <7b0d0915-961a-0af2-7ea3-77f59cd98ef1@grimberg.me>
 <SJ0PR19MB45449EA9215D3EB116E1325CF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <60aa6be0-ca88-bab8-c893-4c2b1d3f8baf@grimberg.me>
 <SJ0PR19MB45449B142BE6DC506FBABA72F2539@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <9c7d43e1-e13e-43a9-8212-ff48467d3a49@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2d747a9f-d29d-de1c-7bdc-69e11bf5d9da@suse.de>
Date: Wed, 12 May 2021 08:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <9c7d43e1-e13e-43a9-8212-ff48467d3a49@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_230933_208231_6DCCCA75 
X-CRM114-Status: GOOD (  28.26  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8xMS8yMSA3OjEzIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBJJ3ZlIGJlZW4g
dGhpbmtpbmcgYWJvdXQgd2hhdCB5b3Ugc2FpZCByZWdhcmRpbmcgdGhlIG5lZWQgdG8gcmVwZWF0
IAo+PiB0aGUgLXcgb3B0aW9uIHdoZW4gdHdvIGludGVyZmFjZXMgc2hhcmUgdGhlIHNhbWUgSVAg
YWRkcmVzcy4gSSB0aGluayAKPj4gd2UncmUgbG9va2luZyBhdCB0aGUgcHJvYmxlbSBmcm9tIGEg
ZGlmZmVyZW50IHBvaW50IG9mIHZpZXcuIFRoZSAKPj4gY3VycmVudCBpbXBsZW1lbnRhdGlvbiB1
c2VzIGFuIElQIGFkZHJlc3MgdG8gaWRlbnRpZnkgYW4gaW50ZXJmYWNlLiBJLCAKPj4gb24gdGhl
IG90aGVyIGhhbmQsIGJlbGlldmUgdGhhdCB0aGUgYmVzdCB3YXkgdG8gaWRlbnRpZnkgYW4gaW50
ZXJmYWNlIAo+PiBpcyBieSBpdHMgImludGVyZmFjZSBuYW1lIG9yIGluZGV4Ii4gSW4gcHJldmlv
dXMgZW1haWxzLCBJIHByb3ZpZGVkIAo+PiBleGFtcGxlcyBvZiB0aGUgcHJvYmxlbXMgdGhhdCBt
YXkgb2NjdXIgd2hlbiB1c2luZyBhbiBJUCBhZGRyZXNzIHRvIAo+PiBpZGVudGlmeSBhbiBpbnRl
cmZhY2UuIEZvciBleGFtcGxlLCBvbmUgY2FuIGFzc2lnbiB0aGUgc2FtZSBJUCBhZGRyZXNzIAo+
PiB0byBkaWZmZXJlbnQgaW50ZXJmYWNlcyBtYWtpbmcgaXQgaW1wb3NzaWJsZSB0byBkaXN0aW5n
dWlzaCBpbnRlcmZhY2VzIAo+PiBieSB0aGVpciBJUCBhZGRyZXNzIGFsb25lLiBBbm90aGVyIGV4
YW1wbGUgaXMgdGhhdCB0aGUgbG93IGxldmVsIEFQSXMgCj4+IChlLmcuIHNldHNvY2tvcHQoU09f
QklORFRPREVWSUNFKSBkb27igJl0IGV2ZW4gcmVxdWlyZSB0aGUgc291cmNlIElQIAo+PiBhZGRy
ZXNzLiBUaGV5IG9ubHkgbmVlZCB0aGUgaW50ZXJmYWNlIG5hbWUvaW5kZXguIFNvLCB3aHkgZ28g
dGhyb3VnaCAKPj4gdGhlIHRyb3VibGUgb2YgcGVyZm9ybWluZyBhIHJldmVyc2UgYWRkcmVzcyBs
b29rdXAgdG8gcmV0cmlldmUgdGhlIAo+PiBpbnRlcmZhY2UgbmFtZS9pbmRleCB3aGVuIHRoZSBh
ZGRyZXNzIGlzIG5vdCB1c2VkIGF0IGFsbD8KPj4KPj4gQnkgdGhlIHdheSwgaWYgbnZtZS1jbGkv
bGludXgtbnZtZSBhbGxvd2VkIHNwZWNpZnlpbmcgaW50ZXJmYWNlcyBieSAKPj4gbmFtZS9pbmRl
eCwgdGhlbiB3ZSB3b3VsZCBub3QgcmVhbGx5IG5lZWQgdG8gcmVwZWF0IHRoZSAtdyBvcHRpb24g
Cj4+IHVubGVzcyB3ZSBhbHNvIHdhbnRlZCB0byBzZXQgdGhlIHNvdXJjZSBhZGRyZXNzIGF0IHRo
ZSBzYW1lIHRpbWUuIAo+PiBTZXR0aW5nIHRoZSBzb3VyY2UgYWRkcmVzcyBpcyBhIGNvbXBsZXRl
bHkgZGlmZmVyZW50IHRoaW5nIGZyb20gCj4+IHNldHRpbmcgdGhlIGludGVyZmFjZS4gT25lIHNo
b3VsZCBiZSBhbGxvd2VkIHRvIHNldCBvbmUgaW5kZXBlbmRlbnRseSAKPj4gZnJvbSB0aGUgb3Ro
ZXIsIG9yIGJvdGgsIG9yIG5vbmUuCj4+Cj4+IElmIHlvdSBsb29rIGF0IGhvdyBwaW5nIGlzIGlt
cGxlbWVudGVkLCB0aGV5IGRvIG5vdCBpbmZlciB0aGUgCj4+IGludGVyZmFjZSBmcm9tIHRoZSBJ
UCBhZGRyZXNzLiBJZiBvbmUgd2FudHMgdG8gZm9yY2UgcGluZyB0byBnbyBvdmVyIAo+PiBhbiBp
bnRlcmZhY2UsIHRoZW4gb25lIG11c3QgcHJvdmlkZSB0aGUgaW50ZXJmYWNlIGJ5IG5hbWUvaW5k
ZXggdXNpbmcgCj4+IHRoZSAtSSBvcHRpb24uIElmIG9uZSB3YW50cyB0byBjaGFuZ2UgdGhlIHNv
dXJjZSBJUCBhZGRyZXNzICh3aXRob3V0IAo+PiBmb3JjaW5nIGEgc3BlY2lmaWMgaW50ZXJmYWNl
KSwgdGhlbiBvbmUgcHJvdmlkZXMgdGhlIElQIGFkZHJlc3MgdG8gdGhlIAo+PiAtSSBvcHRpb24u
IEl0J3Mgc2ltcGxlIGFuZCBpbnR1aXRpdmUuIEFuZCBwaW5nIGFsc28gc3VwcG9ydHMgYXBwZW5k
aW5nIAo+PiB0aGUgaW50ZXJmYWNlIHRvIHRoZSBEZXN0aW5hdGlvbiBJUCB1c2luZyB0aGUgJyUn
IGRlbGltaXRlciBmb3IgCj4+IElQdjYtb25seSBhcyBwZXIgUkZDNDAwNy4KPj4KPj4gSSB0aGlu
ayB0aGF0IG52bWUtY2xpL2xpbnV4LW52bWUgc2hvdWxkIGZvbGxvdyB0aGUgcGluZyBhcHByb2Fj
aC4gCj4+IEludGVyZmFjZXMgc2hvdWxkIG5ldmVyIGJlIGluZmVycmVkIGZyb20gc291cmNlIElQ
IGFkZHJlc3NlcywgYnV0IAo+PiBpbnN0ZWFkIGJlIGNsZWFybHkgaWRlbnRpZmllZCBieSB0aGVp
ciBuYW1lIG9yIGluZGV4LiBBbmQgc2V0dGluZyB0aGUgCj4+IHNvdXJjZSBhZGRyZXNzIHNob3Vs
ZCBiZSBpbmRlcGVuZGVudCBmcm9tIHNldHRpbmcgdGhlIGludGVyZmFjZS4KPiAKPiBJJ20gc3Rh
cnRpbmcgdG8gdGhpbmsgdGhhdCB3ZSBhcmUgZ29pbmcgaW4gY2lyY2xlcywgSSdtIGdldHRpbmcg
dG8KPiB0aGUgcG9pbnQgdGhhdCBoYXZpbmcgaG9zdF9pZmFjZSBpcyB0aGUgcmlnaHQgd2F5IHRv
IGdvLgo+IAo+IFdlIGNhbiBoYXZlIG52bWUtY2xpIGNvbnZlcnQgPGFkZHI+JWlmYWNlIG5vdGF0
aW9uIHRvCj4gIi4uLGhvc3RfdHJhZGRyPTxhZGRyPixob3N0X2lmYWNlPTxpZmFjZT4sLi4iIHdo
ZW4gY3JlYXRpbmcgdGhlCj4gY29udHJvbGxlciBzdHJpbmcuLi4KClRoYXQgd2FzIG15IHRoaW5r
aW5nLCB0b287IHRoZSBvbmx5IF9vdGhlcl8gd2F5IHdvdWxkIGJlIHRvIGhhdmUgYSAKaG9zdF90
cmFkZHIgX2ltcGx5XyBhIGJpbmRpbmcgdG8gdGhlIHVuZGVybHlpbmcgaW50ZXJmYWNlLgpXZSBj
b3VsZCBkZWZpbmUgdGhhdCwgYnV0IGhhdmluZyBhIHNpbmdsZSBvcHRpb24gZG9pbmcgX3R3b18g
ZGlmZmVyZW50IAp0aGluZ3MgaXMgbm90IGdvb2Qgc29mdHdhcmUgZGVzaWduLgpTbyBsZXQncyBk
byB0aGUgJ2hvc3RfaWZhY2UnIHRoaW5naWUuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5u
ZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVu
ZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
