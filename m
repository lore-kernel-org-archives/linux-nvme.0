Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAC8C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 18:50:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81808611AC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 18:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81808611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k45Bb2uu5LoWyV/nhhHQc++Pf2+puZAV7+sAIfVkKX8=; b=D4AI0vV2ncqxOaOkxdrGMPXrx
	HkQUWLfZYYQdCQhq+SOWIKFP9Ck+r8YTVyrkr7lEBwdSAEFkKdHR/2j3KxxU2lH14BkV5eUrNYloj
	31dE7g0IdN+OvGRLc77PvfHbMnBq+URwBXoOjO5A08szmutxuDXxyIOjD+cxxRDG2ZisjlL8JCCVv
	edokKxmIr7Qkg6w+zSU84pCUuH5VYvi7dPlWgXucFJCiXY9ngy/Fl/kyI25L+X3sHgNPKbnCfKfWy
	EhX+jZ8tM0Y4EH7jJAcfl2VHxteBg+VHI7q/5Hzn3FUlDAoKINm83sUPoA5+GCWYMJ5/9YXnBtxoK
	vMl4ozkuw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj4mz-001ekI-Dc; Tue, 18 May 2021 18:49:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj4mv-001ek2-OB
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 18:49:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=rXdI/BJzxy9YWfqbSlFu8AkDNwYI9tMD5CFL0TgpswI=; b=0lTBmmev4q/IPe0nkqGSSub56a
 k9kWRU4En2RmIGdJMaiqsOEjF9lv5dX6olxAQ997YNxUSuAeMPkR3mKoUiyiYZJWqOoeQLhjLQ2tM
 6L4zUDoAX9xwcZWDziSFTVr1Yk3FKQr+NbnBqlSUf+frMWjpo0IoQ1CrWRLHuj5oJWDIlHXv+f5nE
 u1Fg4e0WWrolXJ+aN7+MbCrMPidez4GeZ4Jucos0JQI65AY4IAAvJD8OBngNigkMcIpY1OkXMWQjp
 Ldh8UggA4tQFvSnjtiMZhhgE3zQ/dNXqPOa0zZd1FlY7KVJeCLcrPL9axXgR6+VPUmmK+lryR5D3q
 mx29Zzrg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj4mt-00EtNs-4b
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 18:49:52 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AECB1AD0B;
 Tue, 18 May 2021 18:49:49 +0000 (UTC)
Subject: Re: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210517083215.105604-1-hare@suse.de>
 <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
 <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de>
 <deb1d103-8fc6-6f38-f9e9-d3a327ea5678@grimberg.me>
 <b7f6c507-d2a4-4231-737e-04e1c8a3df9e@suse.de>
 <d81323b2-a914-4dee-718a-39728d2e2039@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <799078b2-0409-53ea-c462-b074b69d8a57@suse.de>
Date: Tue, 18 May 2021 20:49:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d81323b2-a914-4dee-718a-39728d2e2039@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_114951_345755_2A0C9F32 
X-CRM114-Status: GOOD (  12.60  )
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

T24gNS8xOC8yMSA4OjM5IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+Pj4+PiBiL2RyaXZlcnMvbnZt
ZS9ob3N0L211bHRpcGF0aC5jCj4+Pj4+PiBpbmRleCAwNTUxNzk2NTE3ZTYuLmVjYzk5YmQ1Zjhh
ZCAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+Pj4+
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4+Pj4gQEAgLTEwMCw4ICsx
MDAsMTEgQEAgdm9pZCBudm1lX2tpY2tfcmVxdWV1ZV9saXN0cyhzdHJ1Y3QgbnZtZV9jdHJsCj4+
Pj4+PiAqY3RybCkKPj4+Pj4+IMKgwqDCoMKgwqDCoCBkb3duX3JlYWQoJmN0cmwtPm5hbWVzcGFj
ZXNfcndzZW0pOwo+Pj4+Pj4gwqDCoMKgwqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50cnkobnMsICZj
dHJsLT5uYW1lc3BhY2VzLCBsaXN0KSB7Cj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKG5zLT5o
ZWFkLT5kaXNrKQo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2Jsb2NrZF9zY2hlZHVs
ZV93b3JrKCZucy0+aGVhZC0+cmVxdWV1ZV93b3JrKTsKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAoIW5zLT5oZWFkLT5kaXNrKQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGlu
dWU7Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAga2Jsb2NrZF9zY2hlZHVsZV93b3JrKCZucy0+aGVh
ZC0+cmVxdWV1ZV93b3JrKTsKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoY3RybC0+c3RhdGUg
PT0gTlZNRV9DVFJMX0xJVkUpCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkaXNrX3Vl
dmVudChucy0+aGVhZC0+ZGlzaywgS09CSl9DSEFOR0UpOwo+Pj4+Pj4gwqDCoMKgwqDCoMKgIH0K
Pj4+Pj4KPj4+Pj4gSSBhc2tlZCB0aGlzIG9uIHYxLCBpcyB0aGlzIG9ubHkgbmVlZGVkIGZvciBt
cGF0aCBkZXZpY2VzPwo+Pj4+Cj4+Pj4gWWVzOyB3ZSBuZWVkIHRvIHNlbmQgdGhlIEtPQkpfQ0hB
TkdFIGV2ZW50IG9uIHRoZSBtcGF0aCBkZXZpY2UgYXMgaXQncwo+Pj4+IG5vdCBiYWNrZWQgYnkg
aGFyZHdhcmUuIFRoZSBvbmx5IG5vbi1tdWx0aXBhdGhlZCBkZXZpY2VzIEkndmUgc2VlbiBzbwo+
Pj4+IGZhciBhcmUgUENJIGRldmljZXMgd2hlcmUgZXZlbnRzIGFyZSBnZW5lcmF0ZWQgYnkgdGhl
IFBDSSBkZXZpY2UKPj4+PiBpdHNlbGYuCj4+Pgo+Pj4gQW5kIGZvciBmYWJyaWNzPwo+Pgo+PiBO
byBldmVudHMgd2hhdHNvZXZlci4KPj4gSGVuY2UgdGhpcyBwYXRjaC4KPiAKPiBOb24tbXVsdGlw
YXRoIGZhYnJpY3MgSSBtZWFudAoKSSBrbm93LiBBcyBzYWlkLCBJJ3ZlIG5ldmVyIHNlZW4gdGhl
bS4gRGlkIHlvdT8KCkluIGZhY3QsIEkgd291bGRuJ3QgYmUgc3VycHJpc2VkIGlmIHRoYXQgd291
bGQgb3BlbiBhIGNvbXBsZXRlbHkKZGlmZmVyZW50IGNhbiBvZiB3b3Jtcy4KCkNoZWVycywKCkhh
bm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNo
aXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VT
RSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBOw7xybmJlcmcKR0Y6IEYu
IEltZW5kw7ZyZmZlciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
