Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB8EC3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 22:24:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F4123431
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 22:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n55sTl48";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VgREfwnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F4123431
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iI5W0CpwZw1wSOA0UaEXpl507emMYrpmh7BVlp3lBos=; b=n55sTl48TpAFAr9FF8zOkjg3M
	9h/jFGqRXtsNitHt370iBCKCbbB7SKhWq/USByY6ntWMlL8E+sOqx7DWwodJtUMmqkswncgpLM3Kc
	Zx2Fo2dEIAOKhe3iyBmCDz4PZqShJ0Ddaxt+r7+AoVVbd8zOh6TPtrKSTXYUxqY9WHDs8TmX5Hqdq
	A71lmdqE07yO/wKuRCJ/ItojJ9TGgeX1pFOWOH+wNI7IoEA+qsryukxI39dT9CUlvOy1CPife5Cvm
	SM6tSzVIpuvazAa5I/RF5AOyw1X46Jk/BmmI5pmbSqj7jwPWo+v/SsohRSh/IrA5aDEYHaIasmvh+
	JLSMVhTUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3pJm-0007kF-7u; Fri, 30 Aug 2019 22:24:30 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3pJj-0007jd-P5
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 22:24:29 +0000
Received: by mail-pg1-x544.google.com with SMTP id l21so4211037pgm.3
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Ff6JaWGzUMMDLrrGDBYHz23FoZRhDC8ttvu90YEtwdE=;
 b=VgREfwnTxqTwHEtIB/YXXOCG7Q7LzEmcClLOTJU02KAu0wSFLuvmmcZP5qGdljWWsV
 WxxFX3mBofCfWG4ZDe0gcr+inqPXqpm0L7yuMFp0c+LeZryhyPpEUpKrdwlD4ilZowBu
 foqsv1jwGDH5hoZicgk+FwV7vOKQPBdhYYcYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Ff6JaWGzUMMDLrrGDBYHz23FoZRhDC8ttvu90YEtwdE=;
 b=JHkPTM+priLJZF59kat8/DcI++aybLcyMXrHrEHYIIC3+OVnRrl2grdLKHgn1rMXML
 7N1LZceggy36pWI90Kt4Dalus1OkKH8an7eHWCGpUhhYwWFL9fwNYgl66HXO+rS3XKP5
 G6m5jEPPCh6ktfy/ORRbOtXUjLIbDmJ/fuoUJCD0MgOGi2Ev4FpycX4KTuniVcsLzob6
 qS/CrxSbKR6HfzArm88l+KOFXfnI2ezYjCzKyH+UJlA0SiIgQh+7bxJIMCGekjsYa1K4
 yVYk3+PIcJciUK5EqLtthEV9pa9sacs7rUi0SlOt64yDU5sfkALjFQpmL99wZG7MYUC+
 JZUQ==
X-Gm-Message-State: APjAAAVQDm6HoVwr0Z0T57Mxp/ElXc2REPzyngf93OHigEyc/DyqR4nb
 xqncnBqj13WeK4bqGJ+fjfkSyOeZsUE=
X-Google-Smtp-Source: APXvYqy1rRqO2cvMQ40YpDjzXhWN78RV44Nf2UhSHvaMGdNBkdXsK831laZrb5vyMBVwv1tK5GxvuQ==
X-Received: by 2002:a62:ab13:: with SMTP id p19mr20845043pff.20.1567203866802; 
 Fri, 30 Aug 2019 15:24:26 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b126sm17999006pfa.177.2019.08.30.15.24.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 15:24:26 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830055514.GC8492@lst.de>
 <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
 <3c58613f-9380-6887-434a-0db31136e7aa@broadcom.com>
 <c50cbc24-328f-35b7-5c74-c66a9bd76128@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <84338eac-c287-1826-4ac1-72cd17ee62cc@broadcom.com>
Date: Fri, 30 Aug 2019 15:24:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c50cbc24-328f-35b7-5c74-c66a9bd76128@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_152427_822433_D507504C 
X-CRM114-Status: GOOD (  16.41  )
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
Cc: Keith Busch <keith.busch@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOC8zMC8yMDE5IDI6MDcgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4+Pj4+IFllcyB3
ZSBkbywgdXNlcnNwYWNlIHNob3VsZCB1c2UgaXQgdG8gb3JkZXIgZXZlbnRzLsKgIERvZXMgdWRl
diBub3QKPj4+Pj4+IGhhbmRsZSB0aGF0IHByb3Blcmx5IHRvZGF5Pwo+Pj4+Pgo+Pj4+PiBUaGUg
cHJvYmxlbSBpcyBub3Qgb3JkZXJpbmcgb2YgZXZlbnRzLCBpdHMgcmVhbGx5IGFib3V0IHRoZSBm
YWN0IHRoYXQKPj4+Pj4gdGhlIGNoYXJkZXYgY2FuIGJlIHJlbW92ZWQgYW5kIHJlYWxsb2NhdGVk
IGZvciBhIGRpZmZlcmVudCBjb250cm9sbGVyCj4+Pj4+IChjb3VsZCBiZSBhIGNvbXBsZXRlbHkg
ZGlmZmVyZW50IGRpc2NvdmVyeSBjb250cm9sbGVyKSBieSB0aGUgdGltZQo+Pj4+PiB0aGF0IHVz
ZXJzcGFjZSBoYW5kbGVzIHRoZSBldmVudC4KPj4+Pgo+Pj4+IFRoZSBzYW1lIGlzIGdlbmVyYWxs
eSB0cnVlIGZvciBsb3Qgb2Yga2VybmVsIGRldmljZXMuwqAgV2UgY291bGQgcmVkdWNlCj4+Pj4g
dGhlIGNoYW5jZSBieSB1c2luZyB0aGUgaWRyIGN5Y2xpYyBhbGxvY2F0b3IuCj4+Pgo+Pj4gV2Vs
bCwgaXQgd2FzIHJhaXNlZCBieSBIYW5uZXMgYW5kIEphbWVzLCBzbyBJJ2xsIGFzayB0aGVtIHJl
c3BvbmQgaGVyZQo+Pj4gYmVjYXVzZSBJIGRvbid0IG1pbmQgaGF2aW5nIGl0IHRoaXMgd2F5LiBJ
IHBlcnNvbmFsbHkgdGhpbmsgdGhhdCB0aGlzCj4+PiBpcyBhIGJldHRlciBhcHByb2FjaCB0aGFu
IGhhdmluZyBhIGN5Y2xpYyBpZHIgYWxsb2NhdG9yLiBJbiBnZW5lcmFsLCBJCj4+PiBkb24ndCBu
ZWNlc3NhcmlseSB0aGluayB0aGF0IHRoaXMgaXMgYSBnb29kIGlkZWEgdG8gaGF2ZSBjeWNsaWMK
Pj4+IGNvbnRyb2xsZXIgZW51bWVyYXRpb25zIGlmIHdlIGRvbid0IGFic29sdXRlbHkgaGF2ZSB0
by4uLgo+Pgo+PiBXZSBoaXQgaXQgcmlnaHQgYW5kIGxlZnQgd2l0aG91dCB0aGUgY3ljbGljIGFs
bG9jYXRvciwgYnV0IHRoYXQgd29uJ3QgCj4+IG5lY2Vzc2FyaWx5IHJlbW92ZSBpdC4KPj4KPj4g
UGVyaGFwcyB3ZSBzaG91bGQgaGF2ZSBoYWQgYSB1bmlxdWUgdG9rZW4gYXNzaWduZWQgdG8gdGhl
IGNvbnRyb2xsZXIsIAo+PiBhbmQgaGF2ZSB0aGUgZXZlbnQgcGFzcyB0aGUgbmFtZSBhbmQgdGhl
IHRva2VuLsKgIFRoZSBjbGkgd291bGQgdGhlbiwgCj4+IGlmIHRoZSB0b2tlbiBpcyBwcmVzZW50
LCB2YWxpZGF0ZSBpdCB2aWEgYW4gaW9jdGwgYmVmb3JlIHByb2NlZWRpbmcgCj4+IHdpdGggb3Ro
ZXIgaW9jdGxzLgo+Pgo+PiBXaGVyZSBhbGwgdGhlIGNvbm5lY3Rpb24gYXJndW1lbnRzIHdlcmUg
YWRkZWQgd2UgZHVlIHRvIHRoZSByZXVzZSAKPj4gaXNzdWUgYW5kIHRoZW4gc29sdmluZyB0aGUg
cXVlc3Rpb24gb2YgaG93IHRvIHZlcmlmeSBhbmQvb3IgbG9va3VwIAo+PiB0aGUgZGVzaXJlZCBj
b250cm9sbGVyLCBieSB1c2luZyB0aGUgc2hvdGd1biBhcHByb2FjaCByYXRoZXIgdGhhbiAKPj4g
YmVpbmcgdmVyeSBwb2ludGVkLCB3aGljaCBpcyB3aGF0IHRoZSBuYW1lL3Rva2VuIHdvdWxkIGRv
Lgo+Cj4gVGhpcyB1bmlxdWUgdG9rZW4gaXM6IHRydHlwZTp0cmFkZHI6dHJzdmNpZDpob3N0LXRy
YWRkciAuLi4KCndlbGwgeWVzIDopwqAgdGhvdWdoIHJhdGhlciB2ZXJib3NlLsKgwqAgVGhlcmUg
aXMgc3RpbGwgYSBtaW51dGUgd2luZG93IGFzIAp3ZSdyZSBjb21wYXJpbmcgdmFsdWVzIGluIHN5
c2ZzLCBwcmlvciB0byBvcGVuaW5nIHRoZSBkZXZpY2UsIHNvIAp0ZWNobmljYWxseSBzb21ldGhp
bmcgY291bGQgY2hhbmdlIGluIHRoYXQgd2luZG93IGJldHdlZW4gd2hlbiB3ZSAKY2hlY2tlZCBz
eXNmcyBhbmQgd2hlbiB3ZSBvcGVuJ2QuwqDCoCBXZSBjYW4gY2VydGFpbiBjaGVjayBhZnRlciB3
ZSBvcGVuIAp0aGUgZGV2aWNlIHRvIHNvbHZlIHRoYXQgaXNzdWUuCgpUaGVyZSBpcyBzb21lIGVs
ZWdhbmNlIHRvIGEgMzItYml0IHRva2VuIGZvciB0aGUgY29udHJvbGxlciAoY2FuIGJlIGFuIApp
bmNyZW1lbnRpbmcgdmFsdWUpIHBhc3NlZCBpbiB0aGUgZXZlbnQgYW5kIHVzZWQgd2hlbiBzZXJ2
aWNpbmcgdGhlIApldmVudCB0aGF0IGF2b2lkcyBhIGJ1bmNoIG9mIHdvcmsuCgpEb2luZyBlaXRo
ZXIgb2YgdGhlc2Ugd291bGQgZWxpbWluYXRlIHdoYXQgSGFubmVzIGxpa2VkIC0gbG9va2luZyBm
b3IgCnRoZSBkaXNjb3ZlcnkgY29udHJvbGxlciB3aXRoIHRob3NlIGF0dHJpYnV0ZXMuIEFsdGhv
dWdoLCBJIGRvbid0IGtub3cgCnRoYXQgbG9va2luZyBmb3IgaXQgaXMgYWxsIHRoYXQgbWVhbmlu
Z2Z1bC4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
