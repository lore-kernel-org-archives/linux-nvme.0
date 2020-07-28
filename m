Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1EEC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 23:39:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACE02075D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 23:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fv79uuh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACE02075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tjNdkEeDsVoVWbTkGH/QPFVh/C9cOphoAXRibY01SG0=; b=fv79uuh5sQB3qacqzxbmV+N3a
	JHFNPnIv4EpQtw/G0rxqO8dYrIToyy+iCTKIegwYRcectfS/kZKSpOQByJ62WjtplYWQ0LWSL6hOo
	Sqan1vX6iei9Qr+VGw9XCJjHZsHJI53hg5rPfQ5o0XABlehmdeeqpMPrYnBS+JkF9b9dHBswBrJ8R
	VV4Xpng3X5XqphUmdkRbtZ7WtE3BJG7nE/6JhUtneuiEIB/olEW+TwODQ/OHgxqBHs6pErqoIoqlv
	9JnjtvAe3qT/JJr0PNlmp+4R+Xr+mr/9SsuNgawzFdIOMte69KFCIqtuuThdVAcF9GT6/bZFGJnRp
	UmL8cCUow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0ZC2-0007D4-EU; Tue, 28 Jul 2020 23:39:34 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0ZBy-0007Ce-Ur
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 23:39:32 +0000
Received: by mail-pj1-f46.google.com with SMTP id f9so1057189pju.4
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 16:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3EO4lVOsBzE7baNZ02TXv8Bg/hQH5yQ45gqj7Z/mSMw=;
 b=W1HFkzFhHe3IyisRnee5Hh5lyR/6ikbAOi4saU6UykYaYYshBXG175aVRI2u9OStSJ
 6/MfA6YdW1W/vyrdrlKosvdwtcUoxxaH3IbhFgt/81+u2R2kY3rAO7jhOSdStHDQnXvU
 QtYfkp3mGaoJxApJxQKGgjEPHCAssTc0XQQt4qf/vIAFhM+aFB0fMXMQloACVD64dp3S
 KBi/qjLMqdLrkeLb+6WbXczBiBczZaozsy8z13ALzw9TcCP6wmbXiXtXfjBt6J0Fsspu
 24ycnq7B+5h5q88nR1pcrXIJuqSSQnvYyF/EAvR+Uf40gE75uFL1X99s8FkUgi50C9xR
 gbbQ==
X-Gm-Message-State: AOAM53030RMqw22tkzNXhOyN37ZAzgS2DTRFs+kxQlNg+gXBk02AYyek
 jxtwAA6fZgx3jyY7AC0797A=
X-Google-Smtp-Source: ABdhPJzzUCkCKHLp8vigSJRJw+W1y3plUC45jKzRhHuvIONaYsZKCmIva86GfgR4tHgyTZv5HRZlpQ==
X-Received: by 2002:a17:90b:1106:: with SMTP id
 gi6mr7221200pjb.2.1595979569766; 
 Tue, 28 Jul 2020 16:39:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fcc5:69d8:6e20:4fd1?
 ([2601:647:4802:9070:fcc5:69d8:6e20:4fd1])
 by smtp.gmail.com with ESMTPSA id c125sm146300pfa.119.2020.07.28.16.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 16:39:29 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
To: James Smart <james.smart@broadcom.com>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20200728053523.21657-1-sagi@grimberg.me>
 <8ff91295-9393-a548-a46f-85d415d9cbc9@huawei.com>
 <233d8e35-f85f-458e-05ad-5baba1b04bbb@grimberg.me>
 <c782f0c1-76b2-cc67-6770-eb55f9e2a3aa@broadcom.com>
 <612f10f0-3cdd-a7c3-e666-ad9f5c835d00@grimberg.me>
 <8de13e09-dff5-f988-2f99-b781ab826421@broadcom.com>
 <d62657c5-dc81-cde3-8a14-4449684982d9@grimberg.me>
 <520f2317-533d-b546-dd35-80ae5f707aa7@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8c96aa2a-89e3-b8e5-8506-f489aa9a69f1@grimberg.me>
Date: Tue, 28 Jul 2020 16:39:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <520f2317-533d-b546-dd35-80ae5f707aa7@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_193931_298016_1086294B 
X-CRM114-Status: GOOD (  27.68  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Pj4+PiBDYW4geW91IHBsZWFzZSBnaXZlIGFuIGV4YW1wbGU/IE5WTUVfUkVRX1VTRVJDTUQgc2hv
dWxkIG5vdCBiZSBhbnkKPj4+PiBkaWZmZXJlbnQgZnJvbSBhbnkgb3RoZXIgdHlwZSBvZiBJL08u
Cj4+PiAuLi4KPj4KPj4gVGhlIHByb2JsZW0gSSBoYXZlIHdpdGggdGhpcyBjb2RlIGlzIHRoYXQg
Y2hlY2tpbmcgZm9yIE5WTUVfUkVRX1VTRVJDTUQKPj4gaXMgYSBiaWcgaGFtbWVyIHRoYXQgeW91
IGxhbmQgb24gd2hhdCBjYW4gYmUgbm9ybWFsIEkvTwo+PiAoZS5nLiBudm1lIHJlYWQvd3JpdGUv
d3JpdGUtemVyb3MpLCBhbmQgd2UgbXVzdCBub3QgcmVseSBvbiB0aGlzCj4+IGluZGljYXRpb24g
dG8gcHJldmVudCB3aGF0IHlvdSBhcmUgZGVzY3JpYmluZy4KPj4KPj4gSXQgbWF5YmUgKGp1c3Qg
bWF5YmUpIE9LIHRvIGNoZWNrIE5WTUVfUkVRX1VTRVJDTUQgb25seSBmb3IgdGhlIGFkbWluCj4+
IHF1ZXVlLCBidXQgd2UgYXJlIHJlYWxseSBjaXJjbGluZyBvdmVyIHRoZSBmYWN0IHRoYXQgd2Ug
Y2Fubm90IHJlbGlhYmx5Cj4+IHNlbmQgYWRtaW4gY29ubmVjdCBiZWZvcmUgdG8gZ28gb2ZmIGZp
cnN0LCBiZWNhdXNlIHdlIGhhdmUgdG8gdW5xdWllc2NlCj4+IGl0IGJlZm9yZSB3ZSBpc3N1ZSB0
aGUgYWRtaW4gY29ubmVjdCwgYW5kIHRoZXJlIG1pZ2h0IGJlIGEgc3RyYXkgY29tbWFuZAo+PiBn
b2luZyBpbnRvIGV4ZWN1dGlvbiBiZWZvcmUgd2Ugc3VibWl0IHRoZSBhZG1pbiBjb25uZWN0Lgo+
IAo+IGFncmVlLgo+IAo+IERpZG4ndCB5b3Ugc3VnZ2VzdCBzb21ldGhpbmcgc2VwYXJhdGUgdG8g
aXNvbGF0ZSB0aGUgY29ubmVjdCAKPiBjb21tYW5kcy9pbml0IGNvbW1hbmRzID/CoMKgIENhbiB3
ZSB1c2UgYSBkaWZmZXJlbnQgdGFnIHNldCBmb3IgCj4gImluaXRpYWxpemF0aW9uIiBjb21tYW5k
cz/CoCBXZSBjYW4gdXNlIGRpZmZlcmVudCBxdWV1ZV9ycSByb3V0aW5lcyB3aXRoIAo+IGRpZmZl
cmVudCBjaGVjayByZWFkeSBjaGVja3MuwqAgSSBkb24ndCBsaWtlIHRoZSBvdmVyaGVhZCwgYnV0
IHN1cmUgbWFrZXMgCj4gdGhlIGxvZ2ljIG1vcmUgc3RyYWlnaHRmb3J3YXJkLgoKSSB0aGluayBJ
J3ZlIGFkZGVkIHRoaXMgbm93IHRoYXQgSSdtIGxvb2tpbmcgYmFjazoKZTc4MzJjYjQ4YTY1ICgi
bnZtZTogbWFrZSBmYWJyaWNzIGNvbW1hbmQgcnVuIG9uIGEgc2VwYXJhdGUgcmVxdWVzdCBxdWV1
ZSIpCgpCdXQgaXQgc3RpbGwgZG9lc24ndCBzb2x2ZSB0aGUgdXNlciBjb21tYW5kcyB5b3UgYXJl
IHJlZmVycmluZyB0by4KCj4+Pj4+IEFzIGZvciB0aGUgYmxrX3JxX2lzX3Bhc3N0aHJvdWdoIGNo
ZWNrIC0gSSBndWVzcyBJIGNhbiBzZWUgaXQgYmVpbmcgCj4+Pj4+IGJhc2VkIG9uIHRoZSBxdWV1
ZSBzdGF0ZSwgYW5kIHRoZSBjaGVjayBsb29rcyBva8KgICh3ZSBzaG91bGQgbmV2ZXIgCj4+Pj4+
IHNlZSAhYmxrX3JxX2lzX3Bhc3N0aHJvdWdoIG9uIHRoZSBhZG1pbiBxKS4KPj4+Pj4gQnV0Li4u
Cj4+Pj4+IC0gSSBkb24ndCBrbm93IHdoeSBpdCB3YXMgdGhhdCBpbXBvcnRhbnQgdG8gY2hhbmdl
IGl0LiBPbiB0aGUgCj4+Pj4+IGNvbm5lY3RpbmcgcGF0aCwgYWxsIHlvdSdyZSBkb2luZyBpcyBs
ZXR0aW5nIGlvIHN0YXJ0IGZsb3dpbmcgCj4+Pj4+IGJlZm9yZSBhbGwgdGhlIHF1ZXVlcyBoYXZl
IGJlZW4gY3JlYXRlZC7CoCBEaWQgeW91IHJlYWxseSBuZWVkIHRvIAo+Pj4+PiBzdGFydCB0aGF0
IG11Y2ggc29vbmVyID8KPj4+Pgo+Pj4+IFRoZSBpc3N1ZSBpcyB0aGF0IGNvbnRyb2xsZXIgaW4g
UkVTRVRUSU5HIHN0YXRlIHdpbGwgaGF2ZSByZXF1ZXN0cyB0aGF0Cj4+Pj4gYXJlIGJlaW5nIGlz
c3VlZCwgYW5kIGlmIHdlIGRvbid0IGxldCBpdCBwYXNzIHRocm91Z2gsIGl0IHdpbGwgaGFuZwo+
Pj4+IGFyb3VuZCBmb3JldmVyIGJlaW5nIHJlcXVldWVkIHByZXZlbnRpbmcgcXVldWUgZnJlZXpl
IHRvIGNvbXBsZXRlLgo+Pj4KPiAKPiBJc24ndCB0aGlzIHRoZSByZWFsIHByb2JsZW06wqAgd2Ug
cmVxdWlyZSB0aGUgcmVxdWVzdCB0byBjb21wbGV0ZSBpbiAKPiBvcmRlciB0byBnZXQgb2ZmIHRo
ZSByZXF1ZXN0IHF1ZXVlIGluIG9yZGVyIHRvIGZyZWV6ZS4gQnV0IHRvIGNvbXBsZXRlIC0gCj4g
aXQgaGFzIHRvIGZpbmlzaCB3aXRoIHNvbWUgc3RhdHVzLiBUaGlzIGlzIG9rIGlmIHJ1bm5pbmcg
bXVsdGlwYXRoLCBhcyAKPiBtcGF0aCBxdWV1ZXMgYW5kIHJldHJpZXMgLSBidXQgd2hhdCBtcGF0
aCBpcyBub3QgcnVubmluZyA/IFRoZSBpc3N1ZXIgb2YgCj4gdGhlIGlvIHdpbGwgZ2V0IHRoZSBl
cnJvciA/CgpXZSBhbHJlYWR5IGZhaWwgbm9yZXRyeSBlcnJvcnMgd2hlbiB3ZSBjYW5jZWwgKG9y
IGFib3J0KSBhbnl0aGluZyB0aGF0CndhcyBzdWJtaXR0ZWQgYmVmb3JlLCBzbyB0aGVyZSBpcyBu
b3RoaW5nIG5ldyBoZXJlLiBub24tbXBhdGgKZG9lcyBub3Qgc2V0IEZBSUxGQVNUIHNvIGl0IGdl
dHMgcmVxdWV1ZWQsIHVzZXIgY29tbWFuZHMgZG8sIHNvIHRoZXkKYXJlIGZhaWxlZCwgdGhpcyBp
cyBub3QgZGlmZmVyZW50IHRoYW4gYmVmb3JlLgoKPiBTaG91bGQgd2UgYWx3YXlzIGJlIHB1dHRp
bmcgZXZlbiBub24tbXAgZGV2aWNlcyB1bmRlciBtcCwgdGh1cyBtcCAKPiBjYXRjaGVzIHRoZSBl
cnJvcnMgcmF0aGVyIHRoYW4gdGhlIGJsayBxdWV1ZSwgYW5kIGNhbiBoYXZlIGEgc2hvcnQgZGVs
YXkgCj4gd2hpbGUgdGhlIGNvbnRyb2xsZXIgcmVjb25uZWN0cyA/wqAgQXQgbGVhc3Qgbm9ybWFs
IGlvIGNhbiBiZSBoYW5kbGVkIAo+IHRoaXMgd2F5IGFuZCB3ZSdkIGhhdmUgdG8gZmlndXJlIG91
dCB0aGUgaW9jdGwgcGF0aC7CoMKgIEJ1dCBpdCBzaG91bGQgCj4gc3RpbGwgYWxsb3cgdGhlIGNv
cmUgaW8sIHN1Y2ggYXMgc2Nhbm5pbmcsIHRvIGdldCB0aGUgZXJyb3IgYW5kIGZhaWwgCj4gb3V0
LCB0byBiZSBwaWNrZWQgdXAgYWZ0ZXIgdGhlIHJlY29ubmVjdC4KCm5vbi1tcGF0aCBzdGlsbCBn
ZXRzIHJlcXVldWVkIGJlY2F1c2UgaXQgZG9lc24ndCBzZXQgYW55IHNvcnQgb2YKRkFJTEZBU1Qg
ZmxhZy4Kb3IKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
