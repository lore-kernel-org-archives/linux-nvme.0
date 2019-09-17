Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CFAC4CEC9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 20:09:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E1A214AF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 20:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WzUq8nvK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XMW9HNWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E1A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vq48sGOXs0XshWpzknfMPzgnplqGtGNifmnd07/wMPE=; b=WzUq8nvK2Vicu+FLnyT8aQZGR
	sc6yQ5/HyizcZiSQBL6WomfcLntlFJff91253MWH+GCBDFSVjHVNWDwDdo+1+pa9vOeF1dWXvZ1b9
	kgcE9D/cTCeIQlBEPevH22adYdIZiUD/9ePEPaYQzKn6vh3a/q2EffDBb6Qu0a+GFs+oiIv/fFOm4
	C+q8jg4iE7TnzH/CGbsM9l4fRkLr7v+pKTCU+oOXJfn+9KJyEjykZZd8ryUsIlCB25rHacaG+vvDK
	RScFhZ4t8VQPNiRs6msFrUfIwxSkwATzpNJ3D29PmpUDqmRM8Ot+OkrVAkMiaT1skRL8PGaPTLznB
	3BxTEFR+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAJme-00031j-76; Tue, 17 Sep 2019 20:09:08 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAJma-000318-Ey
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 20:09:06 +0000
Received: by mail-pl1-x643.google.com with SMTP id t11so2006086plo.0
 for <linux-nvme@lists.infradead.org>; Tue, 17 Sep 2019 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=4t2N9GZO5M0I2suBSS6LiXLUKGDxf3h0We3VZKLrNec=;
 b=XMW9HNWlimhYEZ4fh1oHUhckIu5byiD3mMr5hSjNc8oAbYYufR5zKIKo4LS1NpFx+A
 iGXn0jO+8ym3jwbR5TAhSexCinEYCeSZ8JaYiZE2pEPskunQGxmXe5UgTwOQyjfFFJ5O
 hGzHA48eiChwFrgVDnTsMnGgy9k7agekTLHKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4t2N9GZO5M0I2suBSS6LiXLUKGDxf3h0We3VZKLrNec=;
 b=AunGiV5brnzzR024ko+z5tKB1GhXgvZJkvHU0VEOBMPk4gE2rF/5/mHly/6nzmkxU2
 F/ONgZVZP7OHNZEwUbCUO9+xZSTaZx1rlOk1xEeDwrWc0UersqZhGrSvP/YBSjs0uiXO
 8pjt5j/tPXm5J3fmv9cHt+oVWjs0nRYFmuGObciU6p7uje44HETbevC/JtKkMGBVUebW
 JVe/tm0oiQoyET660jrZuF0AUOt/jbRiurztXFLTc2xHDx4EhnY6Jo7dQ2HKOvxZNeK2
 8gDWpWARFg5ljiGXoBbj5s5pvXCFect+Q3E/157/SJ4o6YaGGXnQMKlv3xR90c8nhmU4
 77jw==
X-Gm-Message-State: APjAAAVP/2A83WQsRUAGatNIzJSbmu5fFGqYb2Y7y7jBrKOiBzW0uFJG
 xw3hAWSERvpLAFI5Gww5jDL7lg==
X-Google-Smtp-Source: APXvYqyaVMxQGiI1oGcCh9ZMDi7+K06n18qX22lqKLPZpdT6sV6qUAcB6GAEzMqM1CmJjycAesJgoA==
X-Received: by 2002:a17:902:c004:: with SMTP id
 v4mr434941plx.159.1568750943743; 
 Tue, 17 Sep 2019 13:09:03 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id z2sm5692418pfq.58.2019.09.17.13.09.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:09:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
From: James Smart <james.smart@broadcom.com>
To: Bart Van Assche <bvanassche@acm.org>, "Singh, Balbir"
 <sblbir@amazon.com>, "kbusch@kernel.org" <kbusch@kernel.org>
References: <20190913233631.15352-1-sblbir@amzn.com>
 <20190913233631.15352-2-sblbir@amzn.com> <20190916074153.GA25606@lst.de>
 <c51a4ac0b974e6efbd4f9d67adc8a70ae94ac325.camel@amazon.com>
 <20190916160117.GB1455@lst.de>
 <b9eb8038c04e3ae87d4f55ea228f8d12ef1ed42a.camel@amazon.com>
 <20190917011441.GA31163@C02WT3WMHTD6>
 <9612b87ed79704b89da559f42e3051ecb171a2ce.camel@amazon.com>
 <ee9a3b5b-2572-5022-0322-e1e2ae38904b@acm.org>
 <79e20170-e7c2-279a-9787-41eed3d053fd@broadcom.com>
Message-ID: <2a60d7cf-12b6-bd42-cf98-848fd3a80156@broadcom.com>
Date: Tue, 17 Sep 2019 13:08:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <79e20170-e7c2-279a-9787-41eed3d053fd@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_130904_506472_90BB52D1 
X-CRM114-Status: GOOD (  29.19  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "sblbir@amzn.com" <sblbir@amzn.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDkvMTcvMjAxOSAxMDoyMSBBTSwgSmFtZXMgU21hcnQgd3JvdGU6Cj4gT24gOS8xNi8yMDE5
IDg6MTcgUE0sIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToKPj4gT24gOS8xNi8xOSA3OjU2IFBNLCBT
aW5naCwgQmFsYmlyIHdyb3RlOgo+Pj4gT24gTW9uLCAyMDE5LTA5LTE2IGF0IDE5OjE0IC0wNjAw
LCBLZWl0aCBCdXNjaCB3cm90ZToKPj4+IFsgLi4uIF0KPj4+IEluIG15IGNhc2UgSSB3YXMgZG9p
bmcgYSBzaW1wbGUgbWlycm9yICh1c2luZyBtYWRhZG0gYWNyb3NzIHR3byBudm1lCj4+PiBkZXZp
Y2VzKSBhbmQgd2hlbiBJIGdldCB0aW1lb3V0cyBvbiBvbmUsIEkgbmVlZCB0byB3YWl0IHVwIHRv
IDEyOCAKPj4+IHNlY29uZHMKPj4+IGJlZm9yZSBzd2l0Y2hpbmcgb3Zlci4gSWRlYWxseSBJIHdh
bnQgdGhpcyB0byBiZSByZWFsbHkgZmFzdCBhbmQgZHJvcAo+Pj4gdGhlIHNsb3cgYnJva2VuIGNv
bnRyb2xsZXIuCj4+Pgo+Pj4+IElmIHlvdSByZWFsbHkgbmVlZCB0aGUgZHJpdmVyIHRvIGRvIHNw
ZWMgbm9uLWNvbXBsaWFudCBiZWhhdmlvciwgd2UgCj4+Pj4gaGF2ZQo+Pj4+IHF1aXJrcyBmb3Ig
dGhhdC4KPj4+Cj4+PiBJIGxpa2UgdGhlIHF1aXJrcyBhcHByb2FjaCwgYnV0IGl0IGFzc3VtZXMg
dGhlIHRpbWVvdXQgdmFsdWUgaXMgbm90Cj4+PiB2YXJpYWJsZSwgYnV0IHJhdGhlciBmaXhlZCBi
eSB0aGUgcXVpcmsuIEkgd2FzIGF0dGVtcHRpbmcgdG8gcmVhbGx5IAo+Pj4gaGF2ZQo+Pj4gbWly
cm9yZWQgSU8gdGltZW91dCBxdWlja2x5IG9uIGEgYmFkIGRldmljZS4KPj4KPj4gT3RoZXIgTGlu
dXgga2VybmVsIHN0b3JhZ2UgdHJhbnNwb3J0cyAoRkMsIFNSUCkgZGVjb3VwbGUgdGhlIGZhaWxv
dmVyIAo+PiB0aW1lb3V0IGZyb20gdGhlIEkvTyB0aW1lb3V0LiBTZWUgYWxzbyB0aGUgb3V0cHV0
IG9mIGdpdCBncmVwIC1uSCAKPj4gZmFzdF9pb19mYWlsIGZvciB0aGUga2VybmVsIHNvdXJjZSB0
cmVlLiBTZWUgYWxzbyB0aGUgZG9jdW1lbnRhdGlvbiAKPj4gb2YgZmFzdF9pb19mYWlsX3RtbyBp
biBodHRwczovL2xpbnV4LmRpZS5uZXQvbWFuLzUvbXVsdGlwYXRoLmNvbmYuIAo+PiBNYXliZSB3
ZSBuZWVkIHNvbWV0aGluZyBzaW1pbGFyIGZvciBOVk1lPwo+Pgo+Cj4gV2VsbCwgaXQncyBub3Qg
cmVhbGx5IGZhc3QgaW8gZmFpbCB0aGF0IG5lZWRzIHRvIGJlIHJlcGxpY2F0ZWQsIGFuZCBpbiAK
PiBmYWN0LCB3aGVuIEkgbG9va2VkIGF0IG52bWUtZmMsIEkgc2F3IG5vIG5lZWQgZm9yIGZhc3Rf
aW9fZmFpbG92ZXIgYXMgCj4gaXQgZGlkbid0IGFwcGx5Lgo+Cj4gVG8gdW5kZXJzdGFuZDoKPiB3
aXRoIFNDU0kgLSB3ZSBoYWQgdGhlIGRldmljZSAiYmxvY2tlZCIgYXMgdGhlcmUgd2FzIGEgZGV0
ZWN0aW9uIG9mIGEgCj4gbG9zcyBvZiBjb25uZWN0aXZpdHkgdG8gdGhlIGRldmljZS4gVGhpcyBi
bG9ja2VkIHN0YXRlIGRpZCBub3QgCj4gdGVybWluYXRlIGkvbyAtIHdlIGxldCBhbnkgaW8gY29t
cGxldGlvbnMgdHJpY2tsaW5nIGluIGNvbnRpbnVlIHRvIAo+IGZpbmlzaCwgYnV0IHdlIGNlcnRh
aW5seSBzdG9wcGVkIG5ldyBpL28gZnJvbSBiZWluZyBzdGFydGVkLsKgIEkvTyAKPiBjb3VsZCBj
b250aW51ZSB0byB0aW1lb3V0LCBidXQgaW4gbW9zdCBjYXNlcywgYSB0aW1lb3V0IHdoaWxlIGlu
IHRoaXMgCj4gbG9zcy1vZi1jb25uZWN0aXZpdHksIG1lYW50IHRoZSB0aW1lb3V0IHdhcyBqdXN0
IHJlc2NoZWR1bGVkLiBUaGUgCj4gYmxvY2tlZCBzdGF0ZSB3YXMgZGVwZW5kZW50IG9uIHRoZSAi
ZGV2aWNlIGxvc3MiIHRpbWVvdXQgdGhhdCB3YXMgCj4gcnVubmluZy4gT3V0c3RhbmRpbmcgaS9v
IHdvdWxkbid0IGJlIHRlcm1pbmF0ZWQgYnkgdGhlIGxsZGQgdW50aWwgdGhlIAo+IGZpbmFsIHBv
aW50IHdoZW4gd2UgZ2F2ZSB1cCBvbiB0aGUgZGV2aWNlIGFuZCB0b3JlIGl0IGRvd24gLSB0aGUg
Cj4gZGV2aWNlIGxvc3MgdGltZW91dCBleHBpcmF0aW9uLsKgwqAgV2l0aCBtdWx0aXBhdGhpbmcs
IHdhaXRpbmcgZm9yIHRoZSAKPiBkZXZpY2UgbG9zcyB0aW1lb3V0IHdhcyB0b28gbG9uZyAtIHNv
IHdlIGludmVudGVkIHRoZSBmYXN0LWlvLWZhaWwgCj4gdGltZW91dCwgc3RhcnRlZCBhdCB0aGUg
c2FtZSBwb2ludCBhdCBkZXZsb3NzLCBhbmQgaW5oZXJlbnRseSB3b3VsZCAKPiBleHBpcmUgYmVm
b3JlIGRldmxvc3MsIHRoYXQgd291bGQgdGVybWluYXRlIGFsbCBpL28gdG8gdGhlIGRldmljZS4g
Cj4gVGhpcyBhbGxvd2VkIG11bHRpcGF0aCB0byBnZXQgdGhlIGlvIGJhY2sgZmFzdGVyIHRoYW4g
YWN0dWFsIGRldmljZSAKPiBmYWlsdXJlLgo+Cj4gV2l0aCBOVk1FLUZDIC0gdGhlcmUgaXMgYSBz
aW1pbGFyIGJlaGF2aW9yIHRvIHRoZSAiYmxvY2tlZCIgc3RhdGUsIAo+IHdoaWNoIGlzIHRoZSBy
ZWNvbm5lY3Rpbmcgc3RhdGUuwqAgRS5nLiB3aGVuIGxvc3Mgb2YgY29ubmVjdGl2aXR5IGlzIAo+
IGRldGVybWluZWQsIHRoZSBjb250cm9sbGVyIGdvZXMgdGhyb3VnaCBhbiBpbXBsaWNpdCByZXNl
dCB3aGljaCAKPiB0ZXJtaW5hdGVzIGFsbCBvdXRzdGFuZGluZyBpbywgdGhlbiBnb2VzIGludG8g
YSByZWNvbm5lY3QgdGltZW91dCB0aGF0IAo+IHJldHJpZXMgY29ubmVjdGlvbnMgdXAgdW50aWwg
YW4gb3ZlcmFsbCB0aW1lciBleHBpcmVzIC0ga25vd24gCj4gZ2VuZXJpY2FsbHkgYXMgY3RybF9s
b3NzX3RtbyB3aGljaCBhcHBsaWVzIHRvIGFsbCBmYWJyaWMgdHlwZXMgYW5kIAo+IGRlZmF1bHRz
IHRvIDYwcy7CoCBGQyBhZGRpdGlvbmFsbHkgYWRkcyBpbiB0aGUgImRldmljZSBsb3NzIiB0bW8g
a25vd24gCj4gYnkgU0NTSSAodGhlIEZDIGRldmljZSBtYXkgYmUgYm90aCBTQ1NJIGFuZCBOVk1F
IGFuZCBzaG91bGQgdXNlIHRoZSAKPiBzYW1lIHZhbHVlKSBhbmQgZXhwaXJlcyBvbiB0aGUgbWlu
aW11bSBvZiB0aG9zZSB0d28gdGltZW91dCB2YWx1ZXMuwqDCoMKgIAo+IFRoZSBmYWN0IHRoYXQg
dGhlIGNvbnRyb2xsZXIgcmVzZXQgdGVybWluYXRlcyBhbGwgb3V0c3RhbmRpbmcgaS9vLCAKPiB0
cnVlIG9uIGFueSBmYWJyaWMgdHJhbnNwb3J0LCBtZWFucyB0aGUgZmFzdF9pb19mYWlsIHRpbWVv
dXQgaXNuJ3QgCj4gbmVlZGVkLgo+Cj4gU28gd2hhdCBzZWVtcyB0byBiZSB0YWxrZWQgYWJvdXQg
aW4gdGhpcyB0aHJlYWQgaXMgaG93IHRoZSBmYWJyaWMgCj4gZGV0ZWN0cyBkZXZpY2UgY29ubmVj
dGl2aXR5IGxvc3MuwqDCoCBGQyBoYXMgaXQncyBuYW1lc2VydmVyIHNvIGl0J3MgCj4gYXV0b21h
dGljLsKgIEJ1dCB0aGUgb3RoZXIgdHJhbnNwb3J0cyBkb24ndCBoYXZlIHN1Y2ggYSB0aGluZywg
dW5sZXNzIAo+IGl0J3MgVENQIGNvbm5lY3Rpb24gdGltZW91dCBmYWlsdXJlcyBvciBzaW1pbGFy
LiBDb25uZWN0aXZpdHkgbG9zcyBpcyAKPiBzdXBwb3NlZCB0byBiZSB0aGUgam9iIG9mIHRoZSBr
ZWVwIGFsaXZlIHRpbWVvdXQuwqAgU28gSSB3b3VsZCBsb29rIGF0IAo+IHRoYXQgYXJlYSB0byBz
ZWUgaG93IGl0IHNob3VsZCBiZSBtYW5pcHVsYXRlZC4KPgo+IC0tIGphbWVzCj4KPgoKQWxzbyB3
YW50ZWQgdG8gc2F5LCB3aXRoIGZhYnJpY3MsIGlmIGEgY29tbWFuZCB0aW1lcyBvdXQgLSB0aGVy
ZSdzIG9ubHkgCjMgb3B0aW9uczogMSkgaWdub3JlIGl0IGFuZCByZXNldCB0aGUgdGltZXI7IDIp
IHNlbmQgYW4gQWJvcnQgY21kIHZpYSAKYWRtaW4gcXVldWU7IG9yIDMpIHRyZWF0IGl0IGhhcyBh
biB1bnJlY292ZXJhYmxlIGVycm9yIGFuZCByZXNldCB0aGUgCmNvbnRyb2xsZXIuwqDCoMKgICgx
KSAtIGlzbid0IHJlYXNvbmFibGUuwqAgKDIpIC0gYmFzZWQgb24gQWJvcnQgYmVpbmcgCmJlc3Qt
ZWZmb3J0IChhdCBiZXN0KSwgbGltaXRlZCBpbiBjb3VudCwgYW5kIHZhcmlvdXMgcmFjZSBjb25k
aXRpb25zLCAKaXNuJ3Qgd29ydGh3aGlsZS4gU28gKDMpIGlzIG5vcm1hbGx5IHdoYXQgaGFwcGVu
cy7CoMKgIEFzIHN0YXRlZCwgd2hlbiBhIApjb250cm9sbGVyIHJlc2V0IG9jY3VycywgYWxsIGkv
byBpcyB0ZXJtaW5hdGVkLCBzbyAtIGl0IHNob3VsZCByZWxlYXNlIAp0aGUgaS9vIGJhY2sgdG8g
dGhlIG11bHRpcGF0aGVyLiBTbyBhbiBJL08gdGltZW91dCBpcyBhbiBpbmRpcmVjdCB3YXksIApi
ZXNpZGVzIGthdG8sIHRvIHJlbGVhc2UgdGhlIGkvbydzLgoKLS0gamFtZXMKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
