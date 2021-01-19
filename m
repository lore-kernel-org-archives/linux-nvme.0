Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A093AC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 19:08:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357B120706
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 19:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357B120706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+2nYXJ79SN+lPSFm8bwrF122MQFtu9qoXTHw0kebmrM=; b=IWjkYalGBw/3zrM5M4AS8WakE
	Ym00Rv8kctzlUVS1Ssr4rogi9OPUNBf0masphWnrzHvq8Lz/JP7azyXvWA7gPhRWklb163RMhKDWg
	JLsDNdKTAMb+4wSaDJioJmiU/W/nE8DdfEj4WRTZtTzO1B+6z3aDWyt8QYIEN86kn7mr4X1Ir7fHE
	sCpEcFPvFejBrXhyC+Y/jVOHCkH5Oyd7Or0SB8l3yl5CeKtOfce0zMYFXcIQCu09bbo17QoruefQu
	0DMNYgjBBLeWN7E2KzFfvt+ABglXFVTg+CbO66guXRnLAjp7/H81jEtpyRxAZogoT1chl/+ZkwNXW
	nt9lozIGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1wM6-000201-Rv; Tue, 19 Jan 2021 19:07:54 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1wM2-0001yy-Kr
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 19:07:51 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CA819AC7B;
 Tue, 19 Jan 2021 19:07:47 +0000 (UTC)
Subject: Re: [PATCHv2] nvme/hwmon: rework to avoid devm allocation
To: Guenter Roeck <linux@roeck-us.net>
References: <20210119064318.124415-1-hare@suse.de>
 <20210119145632.GD54031@roeck-us.net>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1093bedb-9b6d-b365-85d0-de8ef7eceb95@suse.de>
Date: Tue, 19 Jan 2021 20:07:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210119145632.GD54031@roeck-us.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_140750_796733_B0E8FC20 
X-CRM114-Status: GOOD (  23.26  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8xOS8yMSAzOjU2IFBNLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+IE9uIFR1ZSwgSmFuIDE5
LCAyMDIxIGF0IDA3OjQzOjE4QU0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gVGhl
IG9yaWdpbmFsIGRlc2lnbiB0byB1c2UgZGV2aWNlLW1hbmFnZWQgcmVzb3VyY2UgYWxsb2NhdGlv
bgo+PiBkb2Vzbid0IHJlYWxseSB3b3JrIGFzIHRoZSBOVk1lIGNvbnRyb2xsZXIgaGFzIGEgdmFz
dGx5IGRpZmZlcmVudAo+PiBsaWZldGltZSB0aGFuIHRoZSBod21vbiBzeXNmcyBhdHRyaWJ1dGVz
LCBjYXVzaW5nIHdhcm5pbmcgYWJvdXQKPj4gZHVwbGljYXRlIHN5c2ZzIGVudHJpZXMgdXBvbiBy
ZWNvbm5lY3Rpb24uCj4+IFRoaXMgcGF0Y2ggcmV3b3JrcyB0aGUgaHdtb24gYWxsb2NhdGlvbiB0
byBhdm9pZCBkZXZpY2UtbWFuYWdlZAo+PiByZXNvdXJjZSBhbGxvY2F0aW9uLCBhbmQgdXNlcyB0
aGUgTlZNZSBjb250cm9sbGVyIGFzIHBhcmVudCBmb3IKPj4gdGhlIHN5c2ZzIGF0dHJpYnV0ZXMu
Cj4gCj4gSSBkb24ndCByZWFsbHkga25vdyBlbm91Z2ggYWJvdXQgdGhlIG52bWUgaW5mcmFzdHJ1
Y3R1cmUgdG8gdW5kZXJzdGFuZAo+IHRoaXMgcGFydCBvZiB0aGUgY2hhbmdlLiBDb3VwbGUgb2Yg
cXVlc3Rpb25zOiBXaHkgaXMgdGhlIHBhcmVudCBjaGFuZ2UKPiBuZWVkZWQsIGFuZCBkb2VzIHRo
ZSAic2Vuc29ycyIgY29tbWFuZCBzdGlsbCB3b3JrIGFmdGVyIHRoaXMgY2hhbmdlID8KPiAKUHJv
YmxlbSBpcyB0aGF0IGl0J3Mgbm90IHJlYWxseSBhICduZXcnIGluZnJhc3RydWN0dXJlLCBpdCdz
IApOVk1lLW92ZXItZmFicmljcywgd2hpY2ggYmVoYXZlcyBzbGlnaHRseSBkaWZmZXJlbnQgZnJv
bSB0aGUgUENJLWJhc2VkIApOVk1lIGRldmljZXMuCkluIHBhcnRpY3VsYXIgd2UgY2FuIGFuZCB3
aWxsIGhhdmUgY29ubmVjdGl2aXR5IGZhaWx1cmVzLCByZXF1aXJpbmcgdGhlIApjb250cm9sbGVy
IHRvIGJlIHJlc2V0IG9yIHJlY3JlYXRlZC4KQW5kIGFzIHRoZSBod21vbiBzeXNmcyBhdHRyaWJ1
dGVzIHdlcmUgbmV2ZXIgcmVtb3ZlZCBjb3JyZWN0bHkgaW4gdGhlIApmaXJzdCBwbGFjZSB3ZSdy
ZSBzZWVpbmcgdGhlc2UgZXJyb3JzLgpJdCBpc24ndCBlYXNpbHkgcmVjcmVhdGVkIG9uIFBDSSBk
ZXZpY2VzIGFzIHRoZSBzeXNmcyBhdHRyaWJ1dGVzIHdpbGwgCm9ubHkgZXZlciBiZSByZW1vdmVk
IG9uIHNodXRkb3duIChvciBtb2R1bGUgdW5sb2FkKS4KU28gSSBmZWFyIHRoZSBpc3N1ZSB3YXMg
d2l0aCB1cyBzaW5jZSBkYXktMS4KCkFzIGZvciB0aGUgcGFyZW50IGNoYW5nZTogZm9yIGZhYnJp
Y3MgdGhlICctPmRldicgZGV2aWNlIHBvaW50cyB0byBhIApzdGF0aWMgbnZtZl9kZXZpY2UsIHdo
aWNoIGlzIGlkZW50aWNhbCBmb3IgZXZlcnkgZmFicmljcyBjb250cm9sbGVyLgpTbyB5b3UgcmVh
bGx5IG5lZWQgdG8gdXNlIHRoZSBhY3R1YWwgZGV2aWNlIGluICctPmRldmljZScgdG8gaGF2ZSBh
IApkaWZmZXJlbnQgcGFyZW50IGRldmljZSBmb3IgZGlmZmVyZW50IGNvbnRyb2xsZXJzLgpTbyBm
b3IgUENJIHRoYXQgbWVhbnMgdGhhdCB0aGUgJ2h3bW9uJyBkZXZpY2UgbW92ZWQgb25lIGVsZW1l
bnQgZG93biAKKGZyb20gdGhlIFBDSSBkZXZpY2UgdG8gdGhlIG52bWUgY29udHJvbGxlcikuCkJ1
dCBzaG91bGRuJ3QgbWFrZSBtdWNoIG9mIGEgZGlmZmVyZW5jZTsgSSdsbCBjaGVjayBvbiBpZiAn
c2Vuc29ycycgCmNvbnRpbnVlcyB0byB3b3JrLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFu
bmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJl
QHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJl
cmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1l
bmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
