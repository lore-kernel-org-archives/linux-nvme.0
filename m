Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A43C4CEC9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 17:22:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0698020640
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 17:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ItoLC5d1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gy1/+TbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0698020640
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kR81N/sccqXbkGJVjsQRJdT1pKO4Y5xmSfr3ZPKOiaM=; b=ItoLC5d1OTMYSV8afKo5UI2fO
	7uiKr3CxlKEqT+SjF5FiMOU7lmV334cLufGUF53RUNtp0P4JE+n32UoiUM29CtDE90y5fXGlxuTCX
	GrV9UH4fD3fj+mslPCqARPK8w/+cgUCGJzjNodIZ6hdjnPvxGVw30yNHOOUzA1LqgTlI+HYxtNwu5
	gNNsdYfDS9vbWpA+RZlAtHnQGYdWQiwI/J9pVh61ytpW0dGkSzzvQLetOKbIHqBv8GCKtTgCJArbW
	PStOpOMOtiohbQPrHLpWPLHp2CvdPyZp0Y1k/Wu/Okk0jVe+yQ9w47SXo1fBEe6HhEJmIOrP3eGVy
	/BuCvAx+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAHBN-00027B-R3; Tue, 17 Sep 2019 17:22:30 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAHAl-0001sM-3o
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 17:21:53 +0000
Received: by mail-pf1-x443.google.com with SMTP id b128so2568151pfa.1
 for <linux-nvme@lists.infradead.org>; Tue, 17 Sep 2019 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7ucbnYt1A+4g6xDG2+C44v86gWUp5JEa7dbSNUTZHpg=;
 b=Gy1/+TbBLhQGZkvVrOZwXB84S1BXHnX2C6QhGjJptCz565ywMxZmwmti6JyZi4tE5f
 RWi2Qh9SIcMKNgOSOH9qqVhIXvqRXwNo34ru7DnzlOnIMtMLzFuxVs7SnEzORGrsXvYc
 4CsThBr6E4NuKcCNgjWg/GtDXYkZbT7LXpU4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7ucbnYt1A+4g6xDG2+C44v86gWUp5JEa7dbSNUTZHpg=;
 b=qTiTFA6l1FZ0iTJFbdBfYaaSOFVfV3MBL7WBwbvro5V/u8bFE98+er50dkCrYe/CsO
 Mlr6lsjdQYduEG/VXo5kEW5dY54WhKKgIHb5opHtmjoPaixO7ipqfnwXO5e9njgqPnB/
 BMyA1Gmi7o+MmP2LbrIhX8NefghwzQNK2u3+ZESTLD6FYq57Nbay92K59vVKpI/EyyNs
 w6mAH9mdEnJ0b2Y/vM9EU01d3NyvvdKBXvbHoojo6QBECk6S1Kn+/ATL+zZTZ+W9Aq9o
 X5euMk4nOaVTpw5OSYlgtDc8n2YtQoAyAtDUueFTmvKkt/hIyP8jDoZVhq6fkFTl0MCP
 oyNQ==
X-Gm-Message-State: APjAAAUxBooshGpSj1xuAFyo0YnP0Kv7jVWGAA7WhW8oG0oFjeBqH6io
 68pHjK2968GAdrjtkpliCEVUTg==
X-Google-Smtp-Source: APXvYqxsCRLu1i61bLcbrFsa0RiYOMI2irgjlTGWRUugigWuLn9xiry5m7hV4T4K55bpSfQjVmz2bw==
X-Received: by 2002:a63:925d:: with SMTP id s29mr131252pgn.144.1568740909986; 
 Tue, 17 Sep 2019 10:21:49 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id m13sm2715102pgn.57.2019.09.17.10.21.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 10:21:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
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
From: James Smart <james.smart@broadcom.com>
Message-ID: <79e20170-e7c2-279a-9787-41eed3d053fd@broadcom.com>
Date: Tue, 17 Sep 2019 10:21:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ee9a3b5b-2572-5022-0322-e1e2ae38904b@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_102151_181289_CFBC135C 
X-CRM114-Status: GOOD (  21.74  )
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

T24gOS8xNi8yMDE5IDg6MTcgUE0sIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToKPiBPbiA5LzE2LzE5
IDc6NTYgUE0sIFNpbmdoLCBCYWxiaXIgd3JvdGU6Cj4+IE9uIE1vbiwgMjAxOS0wOS0xNiBhdCAx
OToxNCAtMDYwMCwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+IFsgLi4uIF0KPj4gSW4gbXkgY2FzZSBJ
IHdhcyBkb2luZyBhIHNpbXBsZSBtaXJyb3IgKHVzaW5nIG1hZGFkbSBhY3Jvc3MgdHdvIG52bWUK
Pj4gZGV2aWNlcykgYW5kIHdoZW4gSSBnZXQgdGltZW91dHMgb24gb25lLCBJIG5lZWQgdG8gd2Fp
dCB1cCB0byAxMjggCj4+IHNlY29uZHMKPj4gYmVmb3JlIHN3aXRjaGluZyBvdmVyLiBJZGVhbGx5
IEkgd2FudCB0aGlzIHRvIGJlIHJlYWxseSBmYXN0IGFuZCBkcm9wCj4+IHRoZSBzbG93IGJyb2tl
biBjb250cm9sbGVyLgo+Pgo+Pj4gSWYgeW91IHJlYWxseSBuZWVkIHRoZSBkcml2ZXIgdG8gZG8g
c3BlYyBub24tY29tcGxpYW50IGJlaGF2aW9yLCB3ZSAKPj4+IGhhdmUKPj4+IHF1aXJrcyBmb3Ig
dGhhdC4KPj4KPj4gSSBsaWtlIHRoZSBxdWlya3MgYXBwcm9hY2gsIGJ1dCBpdCBhc3N1bWVzIHRo
ZSB0aW1lb3V0IHZhbHVlIGlzIG5vdAo+PiB2YXJpYWJsZSwgYnV0IHJhdGhlciBmaXhlZCBieSB0
aGUgcXVpcmsuIEkgd2FzIGF0dGVtcHRpbmcgdG8gcmVhbGx5IGhhdmUKPj4gbWlycm9yZWQgSU8g
dGltZW91dCBxdWlja2x5IG9uIGEgYmFkIGRldmljZS4KPgo+IE90aGVyIExpbnV4IGtlcm5lbCBz
dG9yYWdlIHRyYW5zcG9ydHMgKEZDLCBTUlApIGRlY291cGxlIHRoZSBmYWlsb3ZlciAKPiB0aW1l
b3V0IGZyb20gdGhlIEkvTyB0aW1lb3V0LiBTZWUgYWxzbyB0aGUgb3V0cHV0IG9mIGdpdCBncmVw
IC1uSCAKPiBmYXN0X2lvX2ZhaWwgZm9yIHRoZSBrZXJuZWwgc291cmNlIHRyZWUuIFNlZSBhbHNv
IHRoZSBkb2N1bWVudGF0aW9uIG9mIAo+IGZhc3RfaW9fZmFpbF90bW8gaW4gaHR0cHM6Ly9saW51
eC5kaWUubmV0L21hbi81L211bHRpcGF0aC5jb25mLiBNYXliZSAKPiB3ZSBuZWVkIHNvbWV0aGlu
ZyBzaW1pbGFyIGZvciBOVk1lPwo+CgpXZWxsLCBpdCdzIG5vdCByZWFsbHkgZmFzdCBpbyBmYWls
IHRoYXQgbmVlZHMgdG8gYmUgcmVwbGljYXRlZCwgYW5kIGluIApmYWN0LCB3aGVuIEkgbG9va2Vk
IGF0IG52bWUtZmMsIEkgc2F3IG5vIG5lZWQgZm9yIGZhc3RfaW9fZmFpbG92ZXIgYXMgaXQgCmRp
ZG4ndCBhcHBseS4KClRvIHVuZGVyc3RhbmQ6CndpdGggU0NTSSAtIHdlIGhhZCB0aGUgZGV2aWNl
ICJibG9ja2VkIiBhcyB0aGVyZSB3YXMgYSBkZXRlY3Rpb24gb2YgYSAKbG9zcyBvZiBjb25uZWN0
aXZpdHkgdG8gdGhlIGRldmljZS4gVGhpcyBibG9ja2VkIHN0YXRlIGRpZCBub3QgdGVybWluYXRl
IAppL28gLSB3ZSBsZXQgYW55IGlvIGNvbXBsZXRpb25zIHRyaWNrbGluZyBpbiBjb250aW51ZSB0
byBmaW5pc2gsIGJ1dCB3ZSAKY2VydGFpbmx5IHN0b3BwZWQgbmV3IGkvbyBmcm9tIGJlaW5nIHN0
YXJ0ZWQuwqAgSS9PIGNvdWxkIGNvbnRpbnVlIHRvIAp0aW1lb3V0LCBidXQgaW4gbW9zdCBjYXNl
cywgYSB0aW1lb3V0IHdoaWxlIGluIHRoaXMgCmxvc3Mtb2YtY29ubmVjdGl2aXR5LCBtZWFudCB0
aGUgdGltZW91dCB3YXMganVzdCByZXNjaGVkdWxlZC4gVGhlIApibG9ja2VkIHN0YXRlIHdhcyBk
ZXBlbmRlbnQgb24gdGhlICJkZXZpY2UgbG9zcyIgdGltZW91dCB0aGF0IHdhcyAKcnVubmluZy4g
T3V0c3RhbmRpbmcgaS9vIHdvdWxkbid0IGJlIHRlcm1pbmF0ZWQgYnkgdGhlIGxsZGQgdW50aWwg
dGhlIApmaW5hbCBwb2ludCB3aGVuIHdlIGdhdmUgdXAgb24gdGhlIGRldmljZSBhbmQgdG9yZSBp
dCBkb3duIC0gdGhlIGRldmljZSAKbG9zcyB0aW1lb3V0IGV4cGlyYXRpb24uwqDCoCBXaXRoIG11
bHRpcGF0aGluZywgd2FpdGluZyBmb3IgdGhlIGRldmljZSAKbG9zcyB0aW1lb3V0IHdhcyB0b28g
bG9uZyAtIHNvIHdlIGludmVudGVkIHRoZSBmYXN0LWlvLWZhaWwgdGltZW91dCwgCnN0YXJ0ZWQg
YXQgdGhlIHNhbWUgcG9pbnQgYXQgZGV2bG9zcywgYW5kIGluaGVyZW50bHkgd291bGQgZXhwaXJl
IGJlZm9yZSAKZGV2bG9zcywgdGhhdCB3b3VsZCB0ZXJtaW5hdGUgYWxsIGkvbyB0byB0aGUgZGV2
aWNlLiBUaGlzIGFsbG93ZWQgCm11bHRpcGF0aCB0byBnZXQgdGhlIGlvIGJhY2sgZmFzdGVyIHRo
YW4gYWN0dWFsIGRldmljZSBmYWlsdXJlLgoKV2l0aCBOVk1FLUZDIC0gdGhlcmUgaXMgYSBzaW1p
bGFyIGJlaGF2aW9yIHRvIHRoZSAiYmxvY2tlZCIgc3RhdGUsIHdoaWNoIAppcyB0aGUgcmVjb25u
ZWN0aW5nIHN0YXRlLsKgIEUuZy4gd2hlbiBsb3NzIG9mIGNvbm5lY3Rpdml0eSBpcyAKZGV0ZXJt
aW5lZCwgdGhlIGNvbnRyb2xsZXIgZ29lcyB0aHJvdWdoIGFuIGltcGxpY2l0IHJlc2V0IHdoaWNo
IAp0ZXJtaW5hdGVzIGFsbCBvdXRzdGFuZGluZyBpbywgdGhlbiBnb2VzIGludG8gYSByZWNvbm5l
Y3QgdGltZW91dCB0aGF0IApyZXRyaWVzIGNvbm5lY3Rpb25zIHVwIHVudGlsIGFuIG92ZXJhbGwg
dGltZXIgZXhwaXJlcyAtIGtub3duIApnZW5lcmljYWxseSBhcyBjdHJsX2xvc3NfdG1vIHdoaWNo
IGFwcGxpZXMgdG8gYWxsIGZhYnJpYyB0eXBlcyBhbmQgCmRlZmF1bHRzIHRvIDYwcy7CoCBGQyBh
ZGRpdGlvbmFsbHkgYWRkcyBpbiB0aGUgImRldmljZSBsb3NzIiB0bW8ga25vd24gYnkgClNDU0kg
KHRoZSBGQyBkZXZpY2UgbWF5IGJlIGJvdGggU0NTSSBhbmQgTlZNRSBhbmQgc2hvdWxkIHVzZSB0
aGUgc2FtZSAKdmFsdWUpIGFuZCBleHBpcmVzIG9uIHRoZSBtaW5pbXVtIG9mIHRob3NlIHR3byB0
aW1lb3V0IHZhbHVlcy7CoMKgwqAgVGhlIApmYWN0IHRoYXQgdGhlIGNvbnRyb2xsZXIgcmVzZXQg
dGVybWluYXRlcyBhbGwgb3V0c3RhbmRpbmcgaS9vLCB0cnVlIG9uIAphbnkgZmFicmljIHRyYW5z
cG9ydCwgbWVhbnMgdGhlIGZhc3RfaW9fZmFpbCB0aW1lb3V0IGlzbid0IG5lZWRlZC4KClNvIHdo
YXQgc2VlbXMgdG8gYmUgdGFsa2VkIGFib3V0IGluIHRoaXMgdGhyZWFkIGlzIGhvdyB0aGUgZmFi
cmljIApkZXRlY3RzIGRldmljZSBjb25uZWN0aXZpdHkgbG9zcy7CoMKgIEZDIGhhcyBpdCdzIG5h
bWVzZXJ2ZXIgc28gaXQncyAKYXV0b21hdGljLsKgIEJ1dCB0aGUgb3RoZXIgdHJhbnNwb3J0cyBk
b24ndCBoYXZlIHN1Y2ggYSB0aGluZywgdW5sZXNzIAppdCdzIFRDUCBjb25uZWN0aW9uIHRpbWVv
dXQgZmFpbHVyZXMgb3Igc2ltaWxhci7CoCBDb25uZWN0aXZpdHkgbG9zcyBpcyAKc3VwcG9zZWQg
dG8gYmUgdGhlIGpvYiBvZiB0aGUga2VlcCBhbGl2ZSB0aW1lb3V0LsKgIFNvIEkgd291bGQgbG9v
ayBhdCAKdGhhdCBhcmVhIHRvIHNlZSBob3cgaXQgc2hvdWxkIGJlIG1hbmlwdWxhdGVkLgoKLS0g
amFtZXMKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
