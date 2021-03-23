Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E191C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 03:24:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB10861923
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 03:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB10861923
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=doZRMJaz39Kmn0HWIUZ5A4fAdCQe9TYAekQMSkFLVkM=; b=Xx+4Hw+ys+izfCsbDm00GnK68
	xNubZj1Vz6Lt6qFLCBijKGn+bhzauSTFJKaHAudKYGP/WYiYgIzKysHWib6aknmnwEDybZ+xD1zrO
	Gt54gOX2CQxMwv0ux/zTwxIYpValEmKAaABz8cQtfdFo3+ImQOzM3yD/PXqxy2jOjf318d/ffW7OK
	SG0ce8kFQR04fGzu+p9fYSkOxLXqF/fvvWIaWMubjBAifpzcO8CdveibsbFcR+xRQXMfKaDGJR2YU
	EheVt+gk0UHh+k2/+R/0s4zdx46uOqlNl3Iv/ApcWoKYEPsTc5ImkSD5WAhPZT9Ntd5066e2oUabv
	nFM3c8ZCQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOXe1-00DZi4-F8; Tue, 23 Mar 2021 03:23:49 +0000
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOXdv-00DZgr-W4
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 03:23:46 +0000
Received: by mail-pf1-f174.google.com with SMTP id y200so12827544pfb.5
 for <linux-nvme@lists.infradead.org>; Mon, 22 Mar 2021 20:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rKubAEWkBMJTqDV1jZZtUPjCTqZjldMM8icTDfEO31A=;
 b=XQl0C2xhEa1cxqpm+Y9wVYffWXzH9t0B5XyN8IaZNQg9UE24ufQpxRGk3RKRP1x5y5
 Pv3uZNyE4fZqXcI/OgRiEEh1NonSfjLGY0a0vB70iYB8GUzpq8N0+MOzd/Etpd0Toj3D
 JU/FbvKKBjQ2Q/6mRPpYYD3ReWP9WnmmmWgj/r3Yjeb15rNhWwAyY07l7XKA9lfo75FO
 RFkBxunqFf75uofFHJmwWVtdVZdEm60NzVnw/CHYQsMN7M0cAjhASoB2iDY1bbmDeFy6
 7RuEpZOetM6ES/qXOit04xsyw3f/498g8S67p2V1BTok2AoFzPTfKfzUIaOPP8NnMsbn
 kUkQ==
X-Gm-Message-State: AOAM533MWOOu+65yHfugaJW1KcdBcsgRW96Zx5wgVQG6oj7fD/bT/QY+
 u93y76RHmKVYVU05HHBeZFet16+95g4=
X-Google-Smtp-Source: ABdhPJw9d6CsMDC7X0RS7nY5UUn71khTf3PQSpmJaMk422IDpQeHtRk86OT0F8e742aR4XKA3pQt/g==
X-Received: by 2002:a17:902:c401:b029:e6:1ef0:8251 with SMTP id
 k1-20020a170902c401b02900e61ef08251mr2889964plk.9.1616469821217; 
 Mon, 22 Mar 2021 20:23:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2a1:40ef:41b6:3cf0?
 ([2601:647:4802:9070:2a1:40ef:41b6:3cf0])
 by smtp.gmail.com with ESMTPSA id d11sm720672pjz.47.2021.03.22.20.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Mar 2021 20:23:40 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
Message-ID: <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
Date: Mon, 22 Mar 2021 20:23:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_032344_175999_CB2C8EE8 
X-CRM114-Status: GOOD (  32.52  )
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

CgpPbiAzLzIyLzIxIDc6NTcgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IFdoZW4gd2Ug
cmVzZXQvdGVhcmRvd24gYSBjb250cm9sbGVyLCB3ZSBtdXN0IGZyZWV6ZSBhbmQgcXVpZXNjZSB0
aGUKPj4gbmFtZXNwYWNlcyByZXF1ZXN0IHF1ZXVlcyB0byBtYWtlIHN1cmUgdGhhdCB3ZSBzYWZl
bHkgc3RvcCBpbmZsaWdodCBJL08KPj4gc3VibWlzc2lvbnMuIEZyZWV6ZSBpcyBtYW5kYXRvcnkg
YmVjYXVzZSBpZiBvdXIgaGN0eCBtYXAgY2hhbmdlZCBiZXR3ZWVuCj4+IHJlY29ubmVjdHMsIGJs
a19tcV91cGRhdGVfbnJfaHdfcXVldWVzIHdpbGwgaW1tZWRpYXRlbHkgYXR0ZW1wdCB0byBmcmVl
emUKPj4gdGhlIHF1ZXVlLCBhbmQgaWYgaXQgc3RpbGwgaGFzIHBlbmRpbmcgc3VibWlzc2lvbnMg
KHRoYXQgYXJlIHN0aWxsCj4+IHF1aWVzY2VkKSBpdCB3aWxsIGhhbmcuCj4+Cj4+IEhvd2V2ZXIs
IGJ5IGZyZWV6aW5nIHRoZSBuYW1lc3BhY2VzIHJlcXVlc3QgcXVldWVzLCBhbmQgb25seSB1bmZy
ZWV6aW5nCj4+IHRoZW0gd2hlbiB3ZSBzdWNjZXNzZnVsbHkgcmVjb25uZWN0LCBpbmZsaWdodCBz
dWJtaXNzaW9ucyB0aGF0IGFyZQo+PiBydW5uaW5nIGNvbmN1cnJlbnRseSBjYW4gbm93IGJsb2Nr
IGdyYWJiaW5nIHRoZSBuc2hlYWQgc3JjdSB1bnRpbCBlaXRoZXIKPj4gd2Ugc3VjY2Vzc2Z1bGx5
IHJlY29ubmVjdCBvciBjdHJsX2xvc3NfdG1vIGV4cGlyZWQgKG9yIHRoZSB1c2VyCj4+IGV4cGxp
Y2l0bHkgZGlzY29ubmVjdGVkKS4KPj4KPj4gVGhpcyBjYXVzZWQgYSBkZWFkbG9jayB3aGVuIGEg
ZGlmZmVyZW50IGNvbnRyb2xsZXIgKGRpZmZlcmVudCBwYXRoIG9uIHRoZQo+PiBzYW1lIHN1YnN5
c3RlbSkgYmVjYW1lIGxpdmUgKGkuZS4gb3B0aW1pemVkL25vbi1vcHRpbWl6ZWQpLiBUaGlzIGlz
Cj4+IGJlY2F1c2UgbnZtZV9tcGF0aF9zZXRfbGl2ZSBuZWVkcyB0byBzeW5jaHJvbml6ZSB0aGUg
bnNoZWFkIHNyY3UgYmVmb3JlCj4+IHJlcXVldWVpbmcgSS9PIGluIG9yZGVyIHRvIG1ha2Ugc3Vy
ZSB0aGF0IGN1cnJlbnRfcGF0aCBpcyB2aXNpYmxlIHRvCj4+IGZ1dHVyZSAocmUtKXN1Ym1pc2lv
bnMuIEhvd2V2ZXIgdGhlIHNyY3UgbG9jayBpcyB0YWtlbiBieSBhIGJsb2NrZWQKPj4gc3VibWlz
c2lvbiBvbiBhIGZyb3plbiByZXF1ZXN0IHF1ZXVlLCBhbmQgd2UgaGF2ZSBhIGRlYWRsb2NrLgo+
Pgo+PiBJbiBvcmRlciB0byBmaXggdGhpcyB1c2UgdGhlIGJsa19tcV9zdWJtaXRfYmlvX2RpcmVj
dCBBUEkgdG8gc3VibWl0IHRoZQo+PiBiaW8gdG8gdGhlIGxvdy1sZXZlbCBkcml2ZXIsIHdoaWNo
IGRvZXMgbm90IGJsb2NrIG9uIHRoZSBxdWV1ZSBmcmVlCj4+IGJ1dCBpbnN0ZWFkIGFsbG93cyBu
dm1lLW11bHRpcGF0aCB0byBwaWNrIGFub3RoZXIgcGF0aCBvciBxdWV1ZSB1cCB0aGUKPj4gYmlv
Lgo+IAo+IEFsbW9zdC4uLgo+IAo+IFRoaXMgc3RpbGwgaGFzIHRoZSBzYW1lIGlzc3VlIGJ1dCBp
bnN0ZWFkIG9mIGJsb2NraW5nIG9uCj4gYmxrX3F1ZXVlX2VudGVyKCkgaXQgaXMgYmxvY2tlZCBv
biBibGtfbXFfZ2V0X3RhZygpOgo+IC0tIAo+ICDCoF9fc2NoZWR1bGUrMHgyMmIvMHg2ZTAKPiAg
wqBzY2hlZHVsZSsweDQ2LzB4YjAKPiAgwqBpb19zY2hlZHVsZSsweDQyLzB4NzAKPiAgwqBibGtf
bXFfZ2V0X3RhZysweDExZC8weDI3MAo+ICDCoD8gYmxrX2Jpb19zZWdtZW50X3NwbGl0KzB4MjM1
LzB4MmEwCj4gIMKgPyBmaW5pc2hfd2FpdCsweDgwLzB4ODAKPiAgwqBfX2Jsa19tcV9hbGxvY19y
ZXF1ZXN0KzB4NjUvMHhlMAo+ICDCoGJsa19tcV9zdWJtaXRfYmlvKzB4MTQ0LzB4NTAwCj4gIMKg
YmxrX21xX3N1Ym1pdF9iaW9fZGlyZWN0KzB4NzgvMHhhMAo+ICDCoG52bWVfbnNfaGVhZF9zdWJt
aXRfYmlvKzB4YzMvMHgyZjAgW252bWVfY29yZV0KPiAgwqBfX3N1Ym1pdF9iaW9fbm9hY2N0KzB4
Y2YvMHgyZTAKPiAgwqBfX2Jsa2Rldl9kaXJlY3RfSU8rMHg0MTMvMHg0NDAKPiAgwqA/IF9faW9f
Y29tcGxldGVfcncuY29uc3Rwcm9wLjArMHgxNTAvMHgxNTAKPiAgwqBnZW5lcmljX2ZpbGVfcmVh
ZF9pdGVyKzB4OTIvMHgxNjAKPiAgwqBpb19pdGVyX2RvX3JlYWQrMHgxYS8weDQwCj4gIMKgaW9f
cmVhZCsweGM1LzB4MzUwCj4gIMKgPyBjb21tb25faW50ZXJydXB0KzB4MTQvMHhhMAo+ICDCoD8g
dXBkYXRlX2xvYWRfYXZnKzB4N2EvMHg1ZTAKPiAgwqBpb19pc3N1ZV9zcWUrMHhhMjgvMHgxMDIw
Cj4gIMKgPyBsb2NrX3RpbWVyX2Jhc2UrMHg2MS8weDgwCj4gIMKgaW9fd3Ffc3VibWl0X3dvcmsr
MHhhYS8weDEyMAo+ICDCoGlvX3dvcmtlcl9oYW5kbGVfd29yaysweDEyMS8weDMzMAo+ICDCoGlv
X3dxZV93b3JrZXIrMHhiNi8weDE5MAo+ICDCoD8gaW9fd29ya2VyX2hhbmRsZV93b3JrKzB4MzMw
LzB4MzMwCj4gIMKgcmV0X2Zyb21fZm9yaysweDIyLzB4MzAKPiAtLSAKPiAKPiAtLSAKPiAgwqA/
IHVzbGVlcF9yYW5nZSsweDgwLzB4ODAKPiAgwqBfX3NjaGVkdWxlKzB4MjJiLzB4NmUwCj4gIMKg
PyB1c2xlZXBfcmFuZ2UrMHg4MC8weDgwCj4gIMKgc2NoZWR1bGUrMHg0Ni8weGIwCj4gIMKgc2No
ZWR1bGVfdGltZW91dCsweGZmLzB4MTQwCj4gIMKgPyBkZWxfdGltZXJfc3luYysweDY3LzB4YjAK
PiAgwqA/IF9fcHJlcGFyZV90b19zd2FpdCsweDRiLzB4NzAKPiAgwqBfX3dhaXRfZm9yX2NvbW1v
bisweGIzLzB4MTYwCj4gIMKgX19zeW5jaHJvbml6ZV9zcmN1LnBhcnQuMCsweDc1LzB4ZTAKPiAg
wqA/IF9fYnBmX3RyYWNlX3JjdV91dGlsaXphdGlvbisweDEwLzB4MTAKPiAgwqBudm1lX21wYXRo
X3NldF9saXZlKzB4NjEvMHgxMzAgW252bWVfY29yZV0KPiAgwqBudm1lX3VwZGF0ZV9hbmFfc3Rh
dGUrMHhkNy8weDEwMCBbbnZtZV9jb3JlXQo+ICDCoG52bWVfcGFyc2VfYW5hX2xvZysweGE1LzB4
MTYwIFtudm1lX2NvcmVdCj4gIMKgPyBudm1lX21wYXRoX3NldF9saXZlKzB4MTMwLzB4MTMwIFtu
dm1lX2NvcmVdCj4gIMKgbnZtZV9yZWFkX2FuYV9sb2crMHg3Yi8weGUwIFtudm1lX2NvcmVdCj4g
IMKgcHJvY2Vzc19vbmVfd29yaysweDFlNi8weDM4MAo+ICDCoHdvcmtlcl90aHJlYWQrMHg0OS8w
eDMwMAo+IC0tIAo+IAo+IAo+IAo+IElmIEkgd2VyZSB0byBhbHdheXMgc3RhcnQgdGhlIHF1ZXVl
cyBpbiBudm1lX3RjcF90ZWFyZG93bl9jdHJsCj4gcmlnaHQgYWZ0ZXIgSSBjYW5jZWwgdGhlIHRh
Z3NldCBpbmZsaWdodHMgbGlrZToKPiAtLSAKPiBAQCAtMTkzNCw4ICsxOTM0LDcgQEAgc3RhdGlj
IHZvaWQgbnZtZV90Y3BfdGVhcmRvd25faW9fcXVldWVzKHN0cnVjdCAKPiBudm1lX2N0cmwgKmN0
cmwsCj4gIMKgwqDCoMKgwqDCoMKgIG52bWVfc3luY19pb19xdWV1ZXMoY3RybCk7Cj4gIMKgwqDC
oMKgwqDCoMKgIG52bWVfdGNwX3N0b3BfaW9fcXVldWVzKGN0cmwpOwo+ICDCoMKgwqDCoMKgwqDC
oCBudm1lX2NhbmNlbF90YWdzZXQoY3RybCk7Cj4gLcKgwqDCoMKgwqDCoCBpZiAocmVtb3ZlKQo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfc3RhcnRfcXVldWVzKGN0cmwpOwo+
ICvCoMKgwqDCoMKgwqAgbnZtZV9zdGFydF9xdWV1ZXMoY3RybCk7Cj4gIMKgwqDCoMKgwqDCoMKg
IG52bWVfdGNwX2Rlc3Ryb3lfaW9fcXVldWVzKGN0cmwsIHJlbW92ZSk7Cj4gLS0gCj4gCj4gdGhl
biBhIHNpbXBsZSByZXNldCBkdXJpbmcgdHJhZmZpYyBicmlja3MgdGhlIGhvc3Qgb24gaW5maW5p
dGUgbG9vcAo+IGJlY2F1c2UgaW4gdGhlIHNldHVwIHNlcXVlbmNlIHdlIGZyZWV6ZSB0aGUgcXVl
dWUgaW4KPiBudm1lX3VwZGF0ZV9uc19pbmZvLCBzbyB0aGUgcXVldWUgaXMgZnJvemVuIGJ1dCB3
ZSBzdGlsbCBoYXZlIGFuCj4gYXZhaWxhYmxlIHBhdGggKGJlY2F1c2UgdGhlIGNvbnRyb2xsZXIg
aXMgYmFjayB0byBsaXZlISkgc28gbnZtZS1tcGF0aAo+IGtlZXBzIGNhbGxpbmcgYmxrX21xX3N1
Ym1pdF9iaW9fZGlyZWN0IGFuZCBmYWlscywgYW5kCj4gbnZtZV91cGRhdGVfbnNfaW5mbyBjYW5u
b3QgcHJvcGVybHkgZnJlZXplIHRoZSBxdWV1ZS4uCj4gLT4gZGVhZGxvY2suCj4gCj4gU28gdGhp
cyBpcyBvYnZpb3VzbHkgaW5jb3JyZWN0Lgo+IAo+IEFsc28sIGlmIHdlIG1ha2UgbnZtZS1tcGF0
aCBzdWJtaXQgYSBSRVFfTk9XQUlUIHdlIGJhc2ljYWxseQo+IHdpbGwgZmFpbCBhcyBzb29uIGFz
IHdlIHJ1biBvdXQgb2YgdGFncywgZXZlbiBpbiB0aGUgbm9ybWFsIHBhdGguLi4KPiAKPiBTbyBJ
J20gbm90IGV4YWN0bHkgc3VyZSB3aGF0IHdlIHNob3VsZCBkbyB0byBmaXggdGhpcy4uLgoKSXQn
cyBzdGlsbCBub3QgdG9vIGxhdGUgdG8gZ28gd2l0aCBteSBvcmlnaW5hbCBhcHByb2FjaC4uLiA7
KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
