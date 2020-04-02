Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B80BC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB7E20784
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BmdBV9BC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB7E20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e0V3recTFDP/DXvxi5fxkduwWt8rNY3U4Sih2b3fN4o=; b=BmdBV9BCTlNHRugcaasNfGBST
	Eq9IxdD9z0cet2ph4p1SGiH+JLQQKojEW2eL7ch6LtEmMnz5/7LBruoQq9LbU3WCshk6ZUoILW9aN
	ZaifF10teNSxUHbW2c49uT3+5eCWWQXzjCetFhQq/EjQ8Isn6S8zdsVOxbZtkUWiN4TTeKtBhD2N3
	phQpAkCpq1I/fa/NJUrGeKXDLe6yJvHAUyY7cBpgq/vdzykNd1L9X/rNT4stqh0zPIOI3e532rV+W
	NGDkxPI5fQ5Ro0aZj14/YKxbtW3ksKTPlPFy9Uyf84uWkzY2+4+R6J4zijOVSPsiDpbwQgbyljieV
	LkZsSIWzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJtyV-0006Dm-RP; Thu, 02 Apr 2020 07:09:15 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJtyS-0006DF-Cp
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 07:09:13 +0000
Received: by mail-wr1-f47.google.com with SMTP id g3so547439wrx.2
 for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2020 00:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M+rroqTcSqMqZe4jehzy/oQOfa13zTIP70wBS0tOEs4=;
 b=ZfwtHDIBDLXpMQHC8PN0dZfXc+NgttNGMoh0w6I029XMFt3BBaWKLJE1YFYZZRIMNb
 ZTXa7h1BPtGz+tEfO5y9ZdEVdR3SPJI3WjQUc5pKq64LsrOz8h99i9zsOCtM/Oh5tZSZ
 L3AwHQdg8FvQ4SF26gZiJjiBEXkzo6gz2kGWEUKZeoGhWTPXWjge+m5pY3E8iL9cOHvI
 w5X4u7BtzM7YKGmdmr5kVMuBAV/9qr53KUSaV0dAi2kyE1VUeTCF1ZH/RQzZs0zvRRIw
 7JRxF9aPEFuL6bE9CSVwuDabbSh7+pGKZ3y5RNavJOUySGzCwSZOC3Zv4WJV0h3nSNXQ
 6pgA==
X-Gm-Message-State: AGi0PubqlESm8r7JqKB3646FLpKTbNXrubSr0sLcPdXOyssu0qI/xc3s
 h/m0TR3dT1vdXdIBcE4EEH8=
X-Google-Smtp-Source: APiQypLkJujM7HfoNeyq+5f3RO+G5V4zi6NyaXqMVrI/kxQxz1A8qV+IaL0oryG2g9i1UTiPwaNlYQ==
X-Received: by 2002:a5d:6581:: with SMTP id q1mr1901839wru.17.1585811350382;
 Thu, 02 Apr 2020 00:09:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a836:db4c:a7ac:3d7c?
 ([2601:647:4802:9070:a836:db4c:a7ac:3d7c])
 by smtp.gmail.com with ESMTPSA id v26sm6387760wra.7.2020.04.02.00.09.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Apr 2020 00:09:09 -0700 (PDT)
Subject: Re: nvme deadlock with ANA
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Anton Eidelman <anton@lightbitslabs.com>, Hannes Reinecke <hare@suse.de>,
 James Smart <james.smart@broadcom.com>
References: <5e38c566-3f26-288d-1004-161d1084b468@grimberg.me>
 <d2d05ef0-55fd-12ee-978d-f53086dd4fd9@grimberg.me>
Message-ID: <0381771a-c067-6b9e-1d6b-1dd09dca1053@grimberg.me>
Date: Thu, 2 Apr 2020 00:09:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d2d05ef0-55fd-12ee-978d-f53086dd4fd9@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_000912_436656_1415EE53 
X-CRM114-Status: GOOD (  16.31  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

U29tZW9uZSBoYXMgYSBnb29kIGlkZWEgb24gdGhpcz8KCk9uIDMvMjUvMjAgMTE6MjkgUE0sIFNh
Z2kgR3JpbWJlcmcgd3JvdGU6Cj4gQWRkaW5nIEphbWVzIGFzIHRoaXMgY2FuIGJlIGFsc28gcmVs
ZXZhbnQgZm9yIEZDIChvciBtYXliZSBpdAo+IGlzbid0KS4uLgo+IAo+IE9uIDMvMjUvMjAgMTE6
MjMgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+IEhleSwKPj4KPj4gSSB3YW50IHRvIGNvbnN1
bHQgd2l0aCB5b3UgZ3V5cyBvbiBhIGRlYWRsb2NrIGNvbmRpdGlvbiBJJ20gYWJsZSB0bwo+PiBo
aXQgd2l0aCBhIHRlc3QgdGhhdCBpbmNvcnBvcmF0ZSBjb250cm9sbGVyIHJlY29ubmVjdCwgYW5h
IHVwZGF0ZXMKPj4gYW5kIGxpdmUgSS9PIHdpdGggdGltZW91dHMuCj4+Cj4+IFRoaXMgaXMgdHJ1
ZSBmb3IgTlZNZS9UQ1AsIGJ1dCBjYW4gYWxzbyBoYXBwZW4gaW4gcmRtYSBvciBwY2kgZHJpdmVy
cyBhcwo+PiB3ZWxsLgo+Pgo+PiBUaGUgZGVhZGxvY2sgY29tYmluZXMgNCBmbG93cyBpbiBwYXJh
bGxlbDoKPj4gLSBucyBzY2FubmluZyAodHJpZ2dlcmVkIGZyb20gcmVjb25uZWN0KQo+PiAtIHJl
cXVlc3QgdGltZW91dAo+PiAtIEFOQSB1cGRhdGUgKHRyaWdnZXJlZCBmcm9tIHJlY29ubmVjdCkK
Pj4gLSBGUyBJL08gY29taW5nIGludG8gdGhlIG1wYXRoIGRldmljZQo+Pgo+PiAoMSkgbnMgc2Nh
bm5pbmcgdHJpZ2dlcnMgZGlzayByZXZhbGlkYXRpb24gLT4gdXBkYXRlIGRpc2sgaW5mbyAtPgo+
PiDCoMKgwqDCoCBmcmVlemUgcXVldWUgLT4gYnV0IGJsb2NrZWQsIHdoeT8KPj4KPj4gKDIpIHRp
bWVvdXQgaGFuZGxlciByZWZlcmVuY2UgdGhlIGdfdXNhZ2VfY291bnRlciAtID4gYnV0IGJsb2Nr
cyBpbgo+PiDCoMKgwqDCoCB0aGUgdGltZW91dCBoYW5kbGVyLCB3aHk/Cj4+Cj4+ICgzKSB0aGUg
dGltZW91dCBoYW5kbGVyIChpbmRpcmVjdGx5KSBjYWxscyBudm1lX3N0b3BfcXVldWUoKSAtPiB3
aGljaAo+PiDCoMKgwqDCoCB0YWtlcyB0aGUgbmFtZXNwYWNlc19yd3NlbSAtID4gYnV0IGJsb2Nr
cywgd2h5Pwo+Pgo+PiAoNCkgQU5BIHVwZGF0ZSB0YWtlcyB0aGUgbmFtZXNwYWNlc19yd3NlbSAt
PiBjYWxscyBudm1lX21wYXRoX3NldF9saXZlKCkKPj4gwqDCoMKgwqAgLT4gd2hpY2ggc3luY2hy
b25pemUgdGhlIG5zX2hlYWQgc3JjdSAoc2VlIGNvbW1pdCA1MDRkYjA4N2FhY2MpIC0+Cj4+IMKg
wqDCoMKgIGJ1dCBpdCBibG9ja3MsIHdoeT8KPj4KPj4gKDUpIEZTIEkvTyBjYW1lIGludG8gbnZt
ZV9tcGF0aF9tYWtlX3JlcXVlc3QgLT4gdG9vayBzcmN1X3JlYWRfbG9jayAtPgo+PiDCoMKgwqDC
oCBkaXJlY3RfbWFrZV9yZXF1ZXN0ID4gYmxrX3F1ZXVlX2VudGVyIC0+IGJ1dCBibG9ja2VkLCB3
aHk/Cj4+Cj4+ID09PiBiZWNhdXNlIG9mICgxKSwgdGhlIHJlcXVlc3QgcXVldWUgaXMgdW5kZXIg
ZnJlZXplIC0+IGRlYWRsb2NrLgo+Pgo+PiBOb3cgYXMgSSBzYWlkLCB0aGlzIHJlcHJvZHVjZWQg
d2l0aCBudm1lLXRjcCwgcmRtYSBkb2VzIHByZXR0eSBtdWNoIHRoZQo+PiBzYW1lIHRoaW5nLCBh
bmQgaWYgd2UgbG9vayBhdCBwY2ksIGl0IGFsc28gY2FsbHMgbnZtZV9kZXZfZGlzYWJsZSB3aGlj
aAo+PiBhbHNvIGNhbGxzIG52bWVfc3RvcF9xdWV1ZXMsIGFuZCB3aWxsIGFsc28gYmxvY2sgaW4g
bnZtZV9zZXRfbGl2ZSAobm90Cj4+IHNwZWNpZmljIHRvIEFOQSkuCj4+Cj4+IEknbSB0cnlpbmcg
dG8gdGhpbmsgYWJvdXQgd2hhdCBpcyB0aGUgcHJvcGVyIHNvbHV0aW9uIGZvciB0aGF0LCBzbyBJ
Cj4+IHRob3VnaHQgSSdkIHNlbmQgaXQgZm9yIHNvbWUgYnJhaW5zdG9ybWluZy4uLgo+Pgo+PiBB
bnkgdGhvdWdodHMgb24gdGhpcz8KPj4KPj4KPj4gU2VlIHNvbWUgdHJhY2VzIGZvciB2aXN1YWxp
emF0aW9uOgo+PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4gLSBuc19zY2Fu
bmluZwo+PiAtLSAKPj4gQ2FsbCBUcmFjZToKPj4gwqDCoF9fc2NoZWR1bGUrMHgyYjkvMHg2YzAK
Pj4gwqDCoHNjaGVkdWxlKzB4NDIvMHhiMAo+PiDCoMKgYmxrX21xX2ZyZWV6ZV9xdWV1ZV93YWl0
KzB4NGIvMHhiMAo+PiDCoMKgPyB3YWl0X3dva2VuKzB4ODAvMHg4MAo+PiDCoMKgYmxrX21xX2Zy
ZWV6ZV9xdWV1ZSsweDFiLzB4MjAKPj4gwqDCoG52bWVfdXBkYXRlX2Rpc2tfaW5mbysweDYyLzB4
M2EwIFtudm1lX2NvcmVdCj4+IMKgwqBfX252bWVfcmV2YWxpZGF0ZV9kaXNrKzB4YjgvMHgxMTAg
W252bWVfY29yZV0KPj4gwqDCoG52bWVfcmV2YWxpZGF0ZV9kaXNrKzB4YTIvMHgxMTAgW252bWVf
Y29yZV0KPj4gwqDCoHJldmFsaWRhdGVfZGlzaysweDJiLzB4YTAKPj4gwqDCoG52bWVfdmFsaWRh
dGVfbnMrMHg0OS8weDkwMCBbbnZtZV9jb3JlXQo+PiDCoMKgPyBibGtfbXFfZnJlZV9yZXF1ZXN0
KzB4ZDIvMHgxMDAKPj4gwqDCoD8gX19udm1lX3N1Ym1pdF9zeW5jX2NtZCsweGJlLzB4MWUwIFtu
dm1lX2NvcmVdCj4+IMKgwqA/IF9fc3dpdGNoX3RvX2FzbSsweDQwLzB4NzAKPj4gwqDCoD8gX2Nv
bmRfcmVzY2hlZCsweDE5LzB4MzAKPj4gwqDCoD8gZG93bl9yZWFkKzB4MTMvMHhhMAo+PiDCoMKg
bnZtZV9zY2FuX3dvcmsrMHgyNGYvMHgzODAgW252bWVfY29yZV0KPj4gwqDCoHByb2Nlc3Nfb25l
X3dvcmsrMHgxZGIvMHgzODAKPj4gwqDCoHdvcmtlcl90aHJlYWQrMHg0ZC8weDQwMAo+PiAtLSAK
Pj4KPj4gLSByZXF1ZXN0IHRpbWVvdXQKPj4gLS0gCj4+IENhbGwgVHJhY2U6Cj4+IMKgwqBfX3Nj
aGVkdWxlKzB4MmI5LzB4NmMwCj4+IMKgwqBzY2hlZHVsZSsweDQyLzB4YjAKPj4gwqDCoHNjaGVk
dWxlX3RpbWVvdXQrMHgyMDMvMHgyZjAKPj4gwqDCoD8gdHR3dV9kb19hY3RpdmF0ZSsweDViLzB4
NzAKPj4gwqDCoHdhaXRfZm9yX2NvbXBsZXRpb24rMHhiMS8weDEyMAo+PiDCoMKgPyB3YWtlX3Vw
X3ErMHg3MC8weDcwCj4+IMKgwqBfX2ZsdXNoX3dvcmsrMHgxMjMvMHgxZDAKPj4gwqDCoD8gd29y
a2VyX2RldGFjaF9mcm9tX3Bvb2wrMHhiMC8weGIwCj4+IMKgwqBmbHVzaF93b3JrKzB4MTAvMHgy
MAo+PiDCoMKgbnZtZV90Y3BfdGltZW91dCsweDY5LzB4YjAgW252bWVfdGNwXQo+PiDCoMKgYmxr
X21xX2NoZWNrX2V4cGlyZWQrMHgxM2QvMHgxNjAKPj4gwqDCoGJ0X2l0ZXIrMHg1Mi8weDYwCj4+
IMKgwqBibGtfbXFfcXVldWVfdGFnX2J1c3lfaXRlcisweDFhNC8weDJmMAo+PiDCoMKgPyBibGtf
cG9sbCsweDM1MC8weDM1MAo+PiDCoMKgPyBibGtfcG9sbCsweDM1MC8weDM1MAo+PiDCoMKgPyBz
eXNjYWxsX3JldHVybl92aWFfc3lzcmV0KzB4Zi8weDdmCj4+IMKgwqBibGtfbXFfdGltZW91dF93
b3JrKzB4NTkvMHgxMTAKPj4gwqDCoHByb2Nlc3Nfb25lX3dvcmsrMHgxZGIvMHgzODAKPj4gwqDC
oHdvcmtlcl90aHJlYWQrMHg0ZC8weDQwMAo+PiDCoMKga3RocmVhZCsweDEwNC8weDE0MAo+PiDC
oMKgPyBwcm9jZXNzX29uZV93b3JrKzB4MzgwLzB4MzgwCj4+IMKgwqA/IGt0aHJlYWRfcGFyaysw
eDgwLzB4ODAKPj4gwqDCoHJldF9mcm9tX2ZvcmsrMHgzNS8weDQwCj4+Cj4+IC4uLgo+Pgo+PiBD
YWxsIFRyYWNlOgo+PiDCoMKgX19zY2hlZHVsZSsweDJiOS8weDZjMAo+PiDCoMKgc2NoZWR1bGUr
MHg0Mi8weGIwCj4+IMKgwqByd3NlbV9kb3duX3JlYWRfc2xvd3BhdGgrMHgxNmMvMHg0YTAKPj4g
wqDCoGRvd25fcmVhZCsweDg1LzB4YTAKPj4gwqDCoG52bWVfc3RvcF9xdWV1ZXMrMHgyMS8weDUw
IFtudm1lX2NvcmVdCj4+IMKgwqBudm1lX3RjcF90ZWFyZG93bl9pb19xdWV1ZXMucGFydC4yMSsw
eDE5LzB4ODAgW252bWVfdGNwXQo+PiDCoMKgbnZtZV90Y3BfZXJyb3JfcmVjb3Zlcnlfd29yaysw
eDMzLzB4ODAgW252bWVfdGNwXQo+PiDCoMKgcHJvY2Vzc19vbmVfd29yaysweDFkYi8weDM4MAo+
PiDCoMKgd29ya2VyX3RocmVhZCsweDRkLzB4NDAwCj4+IMKgwqBrdGhyZWFkKzB4MTA0LzB4MTQw
Cj4+IMKgwqA/IHByb2Nlc3Nfb25lX3dvcmsrMHgzODAvMHgzODAKPj4gwqDCoD8ga3RocmVhZF9w
YXJrKzB4ODAvMHg4MAo+PiDCoMKgcmV0X2Zyb21fZm9yaysweDM1LzB4NDAKPj4gLS0gCj4+Cj4+
IC0gQU5BIHVwZGF0ZQo+PiAtLSAKPj4gQ2FsbCBUcmFjZToKPj4gwqDCoF9fc2NoZWR1bGUrMHgy
YjkvMHg2YzAKPj4gwqDCoHNjaGVkdWxlKzB4NDIvMHhiMAo+PiDCoMKgc2NoZWR1bGVfdGltZW91
dCsweDIwMy8weDJmMAo+PiDCoMKgPyBfX3F1ZXVlX3dvcmsrMHgxMTcvMHgzZjAKPj4gwqDCoHdh
aXRfZm9yX2NvbXBsZXRpb24rMHhiMS8weDEyMAo+PiDCoMKgPyB3YWtlX3VwX3ErMHg3MC8weDcw
Cj4+IMKgwqBfX3N5bmNocm9uaXplX3NyY3UucGFydC4wKzB4ODEvMHhiMAo+PiDCoMKgPyBfX2Jw
Zl90cmFjZV9yY3VfdXRpbGl6YXRpb24rMHgxMC8weDEwCj4+IMKgwqA/IGt0aW1lX2dldF9tb25v
X2Zhc3RfbnMrMHg0ZS8weGEwCj4+IMKgwqBzeW5jaHJvbml6ZV9zcmN1X2V4cGVkaXRlZCsweDI4
LzB4MzAKPj4gwqDCoHN5bmNocm9uaXplX3NyY3UrMHg1Ny8weGUwCj4+IMKgwqBudm1lX21wYXRo
X3NldF9saXZlKzB4NGYvMHgxNDAgW252bWVfY29yZV0KPj4gwqDCoG52bWVfdXBkYXRlX25zX2Fu
YV9zdGF0ZSsweDVjLzB4NjAgW252bWVfY29yZV0KPj4gwqDCoG52bWVfdXBkYXRlX2FuYV9zdGF0
ZSsweGNhLzB4ZTAgW252bWVfY29yZV0KPj4gwqDCoG52bWVfcGFyc2VfYW5hX2xvZysweGExLzB4
MTgwIFtudm1lX2NvcmVdCj4+IMKgwqA/IG52bWVfYW5hX3dvcmsrMHgyMC8weDIwIFtudm1lX2Nv
cmVdCj4+IMKgwqBudm1lX3JlYWRfYW5hX2xvZysweDc2LzB4MTAwIFtudm1lX2NvcmVdCj4+IMKg
wqBudm1lX2FuYV93b3JrKzB4MTUvMHgyMCBbbnZtZV9jb3JlXQo+PiDCoMKgcHJvY2Vzc19vbmVf
d29yaysweDFkYi8weDM4MAo+PiAtLSAKPj4KPj4gRlMgSS9PCj4+IC0tIAo+PiBDYWxsIFRyYWNl
Ogo+PiDCoMKgX19zY2hlZHVsZSsweDJiOS8weDZjMAo+PiDCoMKgc2NoZWR1bGUrMHg0Mi8weGIw
Cj4+IMKgwqBibGtfcXVldWVfZW50ZXIrMHgxNjkvMHgyMTAKPj4gwqDCoD8gd2FpdF93b2tlbisw
eDgwLzB4ODAKPj4gwqDCoGRpcmVjdF9tYWtlX3JlcXVlc3QrMHg0OS8weGQwCj4+IMKgwqBudm1l
X25zX2hlYWRfbWFrZV9yZXF1ZXN0KzB4YmMvMHgzZTAgW252bWVfY29yZV0KPj4gwqDCoD8gZ2V0
X3VzZXJfcGFnZXNfZmFzdCsweGE1LzB4MTkwCj4+IMKgwqBnZW5lcmljX21ha2VfcmVxdWVzdCsw
eGNmLzB4MzIwCj4+IMKgwqBzdWJtaXRfYmlvKzB4NDIvMHgxNzAKPj4gwqDCoD8gc2V0X3BhZ2Vf
ZGlydHlfbG9jaysweDQwLzB4NjAKPj4gwqDCoGlvbWFwX2Rpb19zdWJtaXRfYmlvLmlzcmEuMCsw
eDU1LzB4NjAKPj4gwqDCoGlvbWFwX2Rpb19iaW9fYWN0b3IrMHgxYzkvMHgzZDAKPj4gwqDCoGlv
bWFwX2Rpb19hY3RvcisweDU4LzB4MWMwCj4+IMKgwqBpb21hcF9hcHBseSsweGQ1LzB4MTQwCj4+
IMKgwqA/IGlvbWFwX2Rpb19iaW9fYWN0b3IrMHgzZDAvMHgzZDAKPj4gwqDCoGlvbWFwX2Rpb19y
dysweDJjMi8weDQ0MAo+PiDCoMKgPyBpb21hcF9kaW9fYmlvX2FjdG9yKzB4M2QwLzB4M2QwCj4+
IMKgwqA/IF9feDY0X3N5c19pb19jYW5jZWwrMHgxNTAvMHgxNTAKPj4gwqDCoHhmc19maWxlX2Rp
b19haW9fcmVhZCsweDY2LzB4ZjAgW3hmc10KPj4gwqDCoD8geGZzX2ZpbGVfZGlvX2Fpb19yZWFk
KzB4NjYvMHhmMCBbeGZzXQo+PiDCoMKgeGZzX2ZpbGVfcmVhZF9pdGVyKzB4YmYvMHhlMCBbeGZz
XQo+PiDCoMKgYWlvX3JlYWQrMHhjOC8weDE2MAo+PiAtLSAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
