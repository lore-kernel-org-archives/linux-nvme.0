Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8FBC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 18:00:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB7564F5C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 18:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB7564F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-reply-to:Date:Subject:Cc:
	To:From:References:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S7I2clW6kyV9ARc6XUZQ6sNDpO4ciVN4scU//CpA0jA=; b=qTCJHmF5siodl8MGweBYy5LIg
	XxG4Vxh//cS+oxvO7PADCcPyyWlGO7QOAnsZS6P57R9ghEQpT8xTesXCIZ8H62dAyTIaHfSfM87oA
	yA47sYzOpQpUWr1bclblCRnPf/ZKVuLd+AP0Tnl1TUZ52dzEM8f3ZdNLGzTl9gWWy7L36XkFr9Df3
	svxcvZEmG4GgzCdq5zufK78JkOEvRhS9OjuaBogyzpOAilA2iSNC352HkD5Rvu4RZzxDa+6HPS94I
	bGWira0w+b9AWrGvCzqV+WL34mMvws+OLVjjq2PUYfqmXwnaQe5QU7kOSsyo/oJOgd/mt7nBfjaPB
	+BhHezOQQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHsHC-009Vj3-8K; Thu, 04 Mar 2021 18:00:43 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHsH6-009ViK-MB
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 18:00:38 +0000
Received: by mail-wr1-x42a.google.com with SMTP id d15so13429942wrv.5
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 10:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:date:in-reply-to
 :message-id:mime-version:content-transfer-encoding;
 bh=8R7Ifb0lG6B9vvUmi1oPee7NhyKlrhTZle2Mf9WBYdQ=;
 b=xsl1yZ6gGZXAoEu02jhqZeM0rHDiFWFH/3g3Kq+bb5AL3RAImOHMR2VPDce9buhUs5
 wgXVWxcIDm9seZmzGULizGtbzfErxlddmAsquXMb40FHvDKf8fo6y7v+HGes/L8Iu2mq
 9k5QhKMJfYOo5VqfsPP//nDxQiT68+5sO9lG6aYhXIvdl3m4dihgCZOElKMozwREOaGD
 I85a/Sgq+RxIR2SAVRmMwpKXeghOUj/PyjpayUbjN4I6l47bJReBrH4pYk6cq3qygw1g
 QuqdlirqO7QM7NxQg4BEOH0ozHE5EMpcX+HEBKztSiZHe48YNFB1km4pJKkNcVApJwk1
 P8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
 :in-reply-to:message-id:mime-version:content-transfer-encoding;
 bh=8R7Ifb0lG6B9vvUmi1oPee7NhyKlrhTZle2Mf9WBYdQ=;
 b=hRUau+BzB8ZOvTT+4ZMhNVOsEtbeoccwOiD7xP4x3Fo3nGQlwiK/RgFDOodzedQ5WZ
 5r1Nixejy+cyGSLzyWtqx8QI1Fyp5uQSWsPoeX1u4KQTu1nEy5avJsdntChSELyoSB23
 bNB/wsFhaHcrUHm17NyWZBz/SQ4lXMALJbJZ7BSebOzF/DobJF2F+X4iVJimP5eHARSb
 EotIMLHgjYKpYJP8ViuYjgaNRsD/dIwkHk/FjJI1sLCHUX0zLptGRo/q/VesJ+eSA0UK
 8ijTcMmz3WHAfkcvPeK44a448D6dHQlAv0OznbeYKlSUHzmYJqj5gCxVQQWeyK7ymG4q
 xvUg==
X-Gm-Message-State: AOAM533AzWNIcofbplqhVTD9uVqFYN3VjsJ8WPa1W1ANf0J+NsNuJMME
 lYLUcNrFNSnpwSIwqq+V8021wA==
X-Google-Smtp-Source: ABdhPJzhkm+tkyOCMF8OnkU0x7xGFO/OwotnOJ7F3gwaZPtm3sEslFvYxW4NxGROAFsxgOn4fhDKgA==
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr5426860wrm.260.1614880835435; 
 Thu, 04 Mar 2021 10:00:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o20sm322634wmq.5.2021.03.04.10.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Mar 2021 10:00:34 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9CC271FF7E;
 Thu,  4 Mar 2021 18:00:33 +0000 (GMT)
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-3-alex.bennee@linaro.org>
 <ff78164cc13b4855911116c2d48929a2@intel.com> <87eegvgr0w.fsf@linaro.org>
 <590e0157d6c44d55aa166ccad6355db5@intel.com>
User-agent: mu4e 1.5.8; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "maxim.uvarov@linaro.org" <maxim.uvarov@linaro.org>,
 "joakim.bech@linaro.org" <joakim.bech@linaro.org>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "arnd@linaro.org" <arnd@linaro.org>, "ruchika.gupta@linaro.org"
 <ruchika.gupta@linaro.org>, "Huang, Yang" <yang.huang@intel.com>, "Zhu,
 Bing" <bing.zhu@intel.com>, "Matti.Moell@opensynergy.com"
 <Matti.Moell@opensynergy.com>, "hmo@opensynergy.com"
 <hmo@opensynergy.com>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, linux-nvme@lists.infradead.org, Ulf Hansson
 <ulf.hansson@linaro.org>, "Linus
 Walleij" <linus.walleij@linaro.org>, Arnd Bergmann
 <arnd.bergmann@linaro.org>, "Usyskin, Alexander"
 <alexander.usyskin@intel.com>, Avri Altman <avri.altman@sandisk.com>
Subject: Re: [RFC PATCH  2/5] char: rpmb: provide a user space interface
Date: Thu, 04 Mar 2021 17:52:01 +0000
In-reply-to: <590e0157d6c44d55aa166ccad6355db5@intel.com>
Message-ID: <87wnumg5oe.fsf@linaro.org>
MIME-Version: 1.0
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

CldpbmtsZXIsIFRvbWFzIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4gd3JpdGVzOgoKPj4gIldp
bmtsZXIsIFRvbWFzIiA8dG9tYXMud2lua2xlckBpbnRlbC5jb20+IHdyaXRlczoKPj4gCj4+ID4+
IFRoZSB1c2VyIHNwYWNlIEFQSSBpcyBhY2hpZXZlZCB2aWEgYSBudW1iZXIgb2Ygc3luY2hyb25v
dXMgSU9DVExzLgo+PiA+Pgo+PiA+PiAgICogUlBNQl9JT0NfVkVSX0NNRCAtIHNpbXBsZSB2ZXJz
aW9uaW5nIEFQSQo+PiA+PiAgICogUlBNQl9JT0NfQ0FQX0NNRCAtIHF1ZXJ5IG9mIHVuZGVybHlp
bmcgY2FwYWJpbGl0aWVzCj4+ID4+ICAgKiBSUE1CX0lPQ19QS0VZX0NNRCAtIG9uZSB0aW1lIHBy
b2dyYW1taW5nIG9mIGFjY2VzcyBrZXkKPj4gPj4gICAqIFJQTUJfSU9DX0NPVU5URVJfQ01EIC0g
cXVlcnkgdGhlIHdyaXRlIGNvdW50ZXIKPj4gPj4gICAqIFJQTUJfSU9DX1dCTE9DS1NfQ01EIC0g
d3JpdGUgYmxvY2tzIHRvIGRldmljZQo+PiA+PiAgICogUlBNQl9JT0NfUkJMT0NLU19DTUQgLSBy
ZWFkIGJsb2NrcyBmcm9tIGRldmljZQo+PiA+Pgo+PiA+PiBUaGUga2V5cyB1c2VkIGZvciBwcm9n
cmFtbWluZyBhbmQgd3JpdGluZyBibG9ja3MgdG8gdGhlIGRldmljZSBhcmUKPj4gPj4ga2V5X3Nl
cmlhbF90IGhhbmRsZXMgYXMgcHJvdmlkZWQgYnkgdGhlIGtleWN0bCgpIGludGVyZmFjZS4KPj4g
Pj4KPj4gPj4gW0FKQjogaGVyZSB0aGVyZSBhcmUgdHdvIGtleSBkaWZmZXJlbmNlcyBiZXR3ZWVu
IHRoaXMgYW5kIHRoZQo+PiA+PiBvcmlnaW5hbCBwcm9wb3NhbC4gVGhlIGZpcnN0IGlzIHRoZSBk
cm9wcGluZyBvZiB0aGUgc2VxdWVuY2Ugb2YKPj4gPj4gcHJlZm9ybWF0ZWQgZnJhbWVzIGluIGZh
dm91ciBvZiBleHBsaWNpdCBhY3Rpb25zLiBUaGUgc2Vjb25kIGlzIHRoZQo+PiA+PiBpbnRyb2R1
Y3Rpb24gb2Yga2V5X3NlcmlhbF90IGFuZCB0aGUga2V5cmluZyBBUEkgZm9yIHJlZmVyZW5jaW5n
IHRoZQo+PiA+PiBrZXkgdG8gdXNlXQo+PiA+Cj4+ID4gUHV0dGluZyBpdCBnZW50bHkgSSdtIG5v
dCBzdXJlIHRoaXMgaXMgZ29vZCBpZGVhLCBmcm9tIHRoZSBzZWN1cml0eSBwb2ludCBvZgo+PiB2
aWV3Lgo+PiA+IFRoZSBrZXkgaGFzIHRvIGJlIHBvc3Nlc3Npb24gb2YgdGhlIG9uZSB0aGF0IHNp
Z25zIHRoZSBmcmFtZXMgYXMgdGhleSBhcmUsCj4+IGl0IGRvZXNuJ3QgbWVhbiBpdCBpcyBsaW51
eCBrZXJuZWwga2V5cmluZywgaXQgY2FuIGJlIG90aGVyIHBhcnR5IG9uIGRpZmZlcmVudAo+PiBz
eXN0ZW0uCj4+ID4gV2l0aCB0aGlzIGFwcHJvYWNoIHlvdSB3aWxsIG1ha2UgdGhlIG90aGVyIHVz
ZWNhc2VzIG5vdCBhcHBsaWNhYmxlLiBJdAo+PiA+IGlzIGxlc3MgdGhlbiB0cml2aWFsIHRvIG1v
dmUga2V5IHNlY3VyZWx5IGZyb20gb25lIHN5c3RlbSB0byBhbm90aGVyLgo+PiAKPj4gT0sgSSBj
YW4gdW5kZXJzdGFuZCB0aGUgZGVzaXJlIGZvciBzdWNoIGEgdXNlLWNhc2UgYnV0IGl0IGRvZXMg
Y29uc3RyYWluIHRoZQo+PiBpbnRlcmZhY2Ugb24gdGhlIGtlcm5lbCB3aXRoIGFjY2VzcyB0byB0
aGUgaGFyZHdhcmUgdG8gcHVyZWx5IHByb3ZpZGluZyBhCj4+IHBpcGUgdG8gdGhlIHJhdyBoYXJk
d2FyZSB3aGlsZSBhbHNvIGhhdmluZyB0byBleHBvc2UgdGhlIGRldGFpbHMgb2YgdGhlIEhXCj4+
IHRvIHVzZXJzcGFjZS4gCj4gVGhpcyBpcyB0aGUgdXNlIGNhc2UgaW4gQW5kcm9pZC4gVGhlIGtl
eSBpcyBpbiB0aGUgInRydXN0eSIgd2hpY2gKPiBkaWZmZXJlbnQgb3MgcnVubmluZyBpbiBhIHZp
cnR1YWwgZW52aXJvbm1lbnQuIFRoZSBmaWxlIHN0b3JhZ2UKPiBhYnN0cmFjdGlvbiBpcyBpbXBs
ZW1lbnRlZCB0aGVyZS4gSSdtIG5vdCBzdXJlIHRoZSBwb2ludCBvZgo+IGNvbnN0cmFpbmluZyB0
aGUga2VybmVsLCBjYW4geW91IHBsZWFzZSBlbGFib3JhdGUgb24gdGhhdC4KCldlbGwgdGhlIGtl
cm5lbCBpcyBhbGwgYWJvdXQgYWJzdHJhY3RpbmcgZGlmZmVyZW5jZXMgbm90IGJha2luZyBpbgph
c3N1bXB0aW9ucy4gSG93ZXZlciBjYW4gSSBhc2sgYSBiaXQgbW9yZSBhYm91dCB0aGlzIHNlY3Vy
aXR5IG1vZGVsPwoKSXMgdGhlIHNlY3VyZSBlbmNsYXZlIGp1c3QgYSBzZXBhcmF0ZSB1c2Vyc3Bh
Y2UgcHJvY2VzcyBvciBpcyBpdCBpbiBhCnNlcGFyYXRlIHZpcnR1YWwgbWFjaGluZT8gSXMgaXQg
YWNjZXNzaWJsZSBhdCBhbGwgYnkgdGhlIGtlcm5lbCBydW5uaW5nCnRoZSBkcml2ZXI/CgpUaGUg
ZmFjdCB0aGF0IGtleSBpZCBpcyBwYXNzZWQgZG93biBpbnRvIHRoZSBrZXJuZWwgZG9lc24ndCBo
YXZlIHRvCmltcGx5IHRoZSBrZXJuZWwgZG9lcyB0aGUgZmluYWwgY3J5cHRvZ3JhcGhpYyBvcGVy
YXRpb24uIEluIHRoZSBBUk0Kd29ybGQgeW91IGNvdWxkIG1ha2UgYSBjYWxsIHRvIHRoZSBzZWN1
cmUgd29ybGQgdG8gZG8gdGhlIG9wZXJhdGlvbiBmb3IKeW91LiBJIG5vdGUgdGhlIGtleWN0bCgp
IGludGVyZmFjZSBhbHJlYWR5IGhhcyBzdXBwb3J0IGZvciBnb2luZyB0bwp1c2Vyc3BhY2UgdG8g
bWFrZSBxdWVyaWVzIG9mIHRoZSBrZXlyaW5nLiBNYXliZSB3aGF0IGlzIHJlYWxseSBuZWVkZWQg
aXMKYW4gYWJzdHJhY3Rpb24gZm9yIHRoZSBrZXJuZWwgdG8gZGVsZWdhdGUgdGhlIE1BQyBjYWxj
dWxhdGlvbiB0byBzb21lIG90aGVyCnRydXN0ZWQgcHJvY2VzcyB0aGF0IGFsc28gdW5kZXJzdGFu
ZHMgdGhlIGtleWlkLgoKPgo+IEFsc28gZG9lc24ndCB0aGlzIGJyZWFrIGRvd24gYWZ0ZXIgYSBQ
Uk9HUkFNX0tFWSBldmVudCBhcwo+PiB0aGUga2V5IHdpbGwgaGF2ZSBoYWQgdG8gdHJhdmVyc2Ug
aW50byB0aGUgInVudHJ1c3RlZCIga2VybmVsPwo+Cj4gVGhpcyBpcyBvbmUgaW4gYSBsaWZlIGV2
ZW50IG9mIHRoZSBjYXJkIGhhcHBlbmluZyBvbiB0aGUgbWFudWZhY3R1cmluZwo+IGZsb29yLCBt
YXliZSBldmVuIG5vdCBwZXJmb3JtZWQgb24gTGludXguCgpJbiBhbiBvZmYgbGlzdCBjb252ZXJz
YXRpb24gaXQgd2FzIHN1Z2dlc3RlZCB0aGF0IG1heWJlIHRoZSBQUk9HUkFNX0tFWQppb2N0bCBz
aG91bGQgYmUgZGlzYWJsZWQgZm9yIGxvY2tlZCBkb3duIGtlcm5lbHMgdG8gZGlzc3VhZGUgcHJv
ZHVjdGlvbgp1c2Ugb2YgdGhlIGZhY2lsaXR5IChpdCBpcyBoYW5keSBmb3IgdGVzdGluZyB0aG91
Z2ghKS4KCj4+IEkgd29uZGVyIGlmIHZpcnRpby1ycG1iIG1heSBiZSBvZiBoZWxwIGhlcmU/IFlv
dSBjb3VsZCB3cmFwIHVwIHVwIHRoZSBmcm9udC0KPj4gZW5kIGluIHRoZSBzZWN1cml0eSBkb21h
aW4gdGhhdCBoYXMgdGhlIGtleXMgYWx0aG91Z2ggSSBkb24ndCBrbm93IGhvdyBlYXN5Cj4+IGl0
IHdvdWxkIGJlIGZvciBhIGJhY2tlbmQgdG8gd29yayB3aXRoIHJlYWwgaGFyZHdhcmU/Cj4KPiBJ
J20gb3BlbiB0byBzZWUgYW55IHByb3Bvc2FsLCBub3Qgc3VyZSBJIGNhbiB3cmFwIG1heSBoZWFk
IGFib3V0IGl0IHJpZ2h0IG5vdy4gCj4KPiBBbnl3YXkgSSB3YXMgYWJvdXQgdG8gc2VuZCB0aGUg
bmV3IHJvdW5kIG9mIG15IGNvZGUsICBidXQgbGV0J3MgY29tZSB0byBjb21tb24gZ3JvdW5kIGZp
cnN0LiAKPgoKT0sgLSBJJ2xsIHNlZSB3aGF0IHRoZSBvdGhlcnMgc2F5LgoKLS0gCkFsZXggQmVu
bsOpZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
