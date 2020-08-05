Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14BFC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 09:42:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A222067C
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 09:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AVF+yfQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A222067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TAOp5KCSDPtJP30DwJpsT5P+JTv2Yufg286TTSIBspw=; b=AVF+yfQvDRFTsz6NYl3Yw1C9J
	mDifD8vTes25gWXkNWWJEfiQD1BYN5/T7Ei+ox9U8mHwKYEwiSvzTBTtWeHq313c8EfKf2jnH6g4N
	cG3aTeAK4dZ3TyBoFW6OylhwWxMfo79OpEBXTS/prQ399aVXGevRIxMHhsl24A9fPHdWGdUyL/PDH
	tb25LkO4VSWq3jvKhX7stafWj0Z4sKHjDD1IsXH5fKIqxciw53+l19Pl0plwuzyIWqO29mb6WN1Ut
	INgCQxkerXZVrTF72XBXTh908dl2mOWACoPZrVlrClO9rYMPXJz0V1DRNVqyYbTs34Bu8dcSUC7oD
	beqALHXIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3FwL-0002Ks-He; Wed, 05 Aug 2020 09:42:29 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3FwH-0002Ix-A0
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 09:42:27 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EFB68D3545A65E881EDC;
 Wed,  5 Aug 2020 17:42:18 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 5 Aug 2020 17:42:17 +0800
Subject: Re: [PATCH] nvme-core: fix deadlock when reconnect failed due to
 nvme_set_queue_count timeout
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20200805063335.19882-1-lengchao@huawei.com>
 <02a20ae5-5af3-8595-c8b4-237449fbc1ee@grimberg.me>
 <c0b91c52-6d5b-90d9-206e-780f836a1ed8@huawei.com>
 <26a34c36-a781-acad-1ea9-8dfa03fabf88@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <ff24e8b6-1974-1b0a-39ae-b9e1194eb174@huawei.com>
Date: Wed, 5 Aug 2020 17:42:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <26a34c36-a781-acad-1ea9-8dfa03fabf88@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_054225_625421_8BC03A64 
X-CRM114-Status: GOOD (  19.89  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzgvNSAxNjoyMiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+PiBBIGRlYWRs
b2NrIGhhcHBlbnMgV2hlbiB3ZSB0ZXN0IG52bWUgb3ZlciByb2NlIHdpdGggbGluayBibGluay4g
VGhlCj4+Pj4gcmVhc29uOiBsaW5rIGJsaW5rIHdpbGwgY2F1c2UgZXJyb3IgcmVjb3ZlcnksIGFu
ZCB0aGVuIHJlY29ubmVjdC5JZgo+Pj4+IHJlY29ubmVjdCBmYWlsIGR1ZSB0byBudm1lX3NldF9x
dWV1ZV9jb3VudCB0aW1lb3V0LCB0aGUgcmVjb25uZWN0Cj4+Pj4gcHJvY2VzcyB3aWxsIHNldCB0
aGUgcXVldWUgY291bnQgYXMgMCBhbmQgY29udGludWUgLCBhbmQgdGhlbgo+Pj4+IG52bWVfc3Rh
cnRfY3RybCB3aWxsIGNhbGwgbnZtZV9lbmFibGVfYWVuLCBhbmQgZGVhZGxvY2sgaGFwcGVucwo+
Pj4+IGJlY2F1c2UgdGhlIGFkbWluIHF1ZXVlIGlzIHF1aWVzY2VkLgo+Pj4KPj4+IFdoeSBpcyB0
aGUgYWRtaW4gcXVldWUgcXVpZXNjZWQ/IGlmIHdlIGFyZSBjYWxsaW5nIHNldF9xdWV1ZV9jb3Vu
dAo+Pj4gaXQgd2FzIGFscmVhZHkgdW5xdWllc2NlZD8KPj4gbnZtZV9zZXRfcXVldWVfY291bnQg
dGltZW91dCB3aWxsIG52bWVfcmRtYV90ZWFyZG93bl9hZG1pbl9xdWV1ZQo+IAo+IE5vdCBpbiB0
aGUgcGF0Y2hzZXQgSSBzZW50LgpZZXMsIHRoZSBudm1lX3JkbWFfdGVhcmRvd25fYWRtaW5fcXVl
dWUgaXMgYWxyZWFkeSBkZWxldGVkLiBUaGUgY29ubmVjdApzaG91bGQgdGVybWluYXRlZCBpbnN0
ZWFkIG9mIGNvbnRpbnVlLCBiZWNhdXNlIGNvbnRpbnVlIGNhbiBub3Qgc3VjY2VzcywKaXQgaXMg
anVzdCBhbiBpbmVmZmVjdGl2ZSBhY3Rpb24uIC4KPiAKPj4gLCB0aGUgYWRtaW4gcXVldWUKPj4g
d2lsbCBiZSBxdWllc2NlZCBpbiBudm1lX3JkbWFfdGVhcmRvd25fYWRtaW5fcXVldWUuCj4+Pgo+
Pj4+IGxvZzoKPj4+PiBBdWfCoCAzIDIyOjQ3OjI0IGxvY2FsaG9zdCBrZXJuZWw6IG52bWUgbnZt
ZTI6IEkvTyAyMiBRSUQgMCB0aW1lb3V0Cj4+Pj4gQXVnwqAgMyAyMjo0NzoyNCBsb2NhbGhvc3Qg
a2VybmVsOiBudm1lIG52bWUyOiBDb3VsZCBub3Qgc2V0IHF1ZXVlIGNvdW50Cj4+Pj4gKDg4MSkK
Pj4+PiBzdGFjazoKPj4+PiByb290wqDCoMKgwqAgMjM4NDjCoCAwLjDCoCAwLjDCoMKgwqDCoMKg
IDDCoMKgwqDCoCAwID/CoMKgwqDCoMKgwqDCoCBEwqDCoMKgIEF1ZzAzwqDCoCAwOjAwCj4+Pj4g
W2t3b3JrZXIvdTEyOjQrbnZtZS13cV0KPj4+PiBbPDA+XSBibGtfZXhlY3V0ZV9ycSsweDY5LzB4
YTAKPj4+PiBbPDA+XSBfX252bWVfc3VibWl0X3N5bmNfY21kKzB4YWYvMHgxYjAgW252bWVfY29y
ZV0KPj4+PiBbPDA+XSBudm1lX2ZlYXR1cmVzKzB4NzMvMHhiMCBbbnZtZV9jb3JlXQo+Pj4+IFs8
MD5dIG52bWVfc3RhcnRfY3RybCsweGE0LzB4MTAwIFtudm1lX2NvcmVdCj4+Pj4gWzwwPl0gbnZt
ZV9yZG1hX3NldHVwX2N0cmwrMHg0MzgvMHg3MDAgW252bWVfcmRtYV0KPj4+PiBbPDA+XSBudm1l
X3JkbWFfcmVjb25uZWN0X2N0cmxfd29yaysweDIyLzB4MzAgW252bWVfcmRtYV0KPj4+PiBbPDA+
XSBwcm9jZXNzX29uZV93b3JrKzB4MWE3LzB4MzcwCj4+Pj4gWzwwPl0gd29ya2VyX3RocmVhZCsw
eDMwLzB4MzgwCj4+Pj4gWzwwPl0ga3RocmVhZCsweDExMi8weDEzMAo+Pj4+IFs8MD5dIHJldF9m
cm9tX2ZvcmsrMHgzNS8weDQwCj4+Pj4KPj4+PiBNYW55IGZ1bmN0aW9ucyB3aGljaCBjYWxsIF9f
bnZtZV9zdWJtaXRfc3luY19jbWQgdHJlYXQgZXJyb3IgY29kZSBpbiB0d28KPj4+PiBtb2Rlczog
SWYgZXJyb3IgY29kZSBsZXNzIHRoYW4gMCwgdHJlYXQgYXMgY29tbWFuZCBmYWlsZWQuIElmIGVy
cm9lIGNvZGUKPj4+PiBtb3JlIHRoYW4gMCwgdHJlYXQgYXMgdGFyZ2V0IG5vdCBzdXBwb3J0IG9y
IG90aGVyLgo+Pj4KPj4+IFdlIHJlbHkgaW4gYSBsb3Qgb2YgcGxhY2VzIG9uIHRoZSBudm1lIHN0
YXR1cyBiZWluZyByZXR1cm5lZCBmcm9tCj4+PiBudm1lX3N1Ym1pdF9zeW5jX2NtZCAoZXNwZWNp
YWxseSBpbiBudm1lX3JldmFsaWRhdGVfZGlzayBhbmQgZm9yCj4+PiBwYXRoL2Fib3J0ZWQgY2Fu
Y2VsbGF0aW9ucyksIGFuZCB0aGlzIHBhdGNoIGJyZWFrcyBpdC4gWW91IG5lZWQgdG8gZmluZAo+
Pj4gYSBzb2x1dGlvbiB0aGF0IGRvZXMgbm90IGhpZGUgdGhlIG52bWUgc3RhdHVzIGNvZGUgZnJv
bSBwcm9wYWdhdGluZwo+Pj4gYmFjay4KPj4gVGhlIGRpZmZlcmVuY2UgaXMganVzdCBFSU5UUiBh
bmQgRUlPLCB0aGVyZSBpcyBubyByZWFsIGltcGFjdC4KPiAKPiBJdCdzIG5vdCBFSU8sIGl0cyBw
cm9wYWdhdGluZyBiYWNrIHRoZSBudm1lIHN0YXR1cy4gQW5kIHdlIG5lZWQgdGhlCj4gbnZtZSBz
dGF0dXMgYmFjayB0byBub3QgZmFsc2VseSByZW1vdmUgbmFtZXNwYWNlcyB3aGVuIHdlIGhhdmUK
PiBucyBzY2FubmluZyBkdXJpbmcgY29udHJvbGxlciByZXNldHMgb3IgbmV0d29yayBkaXNjb25u
ZWN0cy4KSSBzZWUgeW91ciBwb2ludC4gSSB0aGluayB3ZSBhbHJlYWR5IGZhbHNlbHkgcmVtb3Zl
IG5hbWVzcGFjZXMgbm93CmlmIHJldHVybiBlcnJvciBpcyBFQUdBSU4gb3IgRUJVU1kgZXRjLiBN
YXliZSB3ZSBuZWVkIGltcHJvdmUgdGhlCmVycm9yIGNvZGUgdHJlYXQgZm9yIG52bWVfcmV2YWxp
ZGF0ZV9kaXNrLiBsaWtlIHRoaXM6Ci0tLQogIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDYg
KysrLS0tCiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKaW5kZXggODY1NjQ1NTc3ZjJjLi5kMmE2MTc5OGU5YTEgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAg
LTIwMjIsMTAgKzIwMjIsMTAgQEAgc3RhdGljIGludCBudm1lX3JldmFsaWRhdGVfZGlzayhzdHJ1
Y3QgZ2VuZGlzayAqZGlzaykKICAgICAgICAgICogT25seSBmYWlsIHRoZSBmdW5jdGlvbiBpZiB3
ZSBnb3QgYSBmYXRhbCBlcnJvciBiYWNrIGZyb20gdGhlCiAgICAgICAgICAqIGRldmljZSwgb3Ro
ZXJ3aXNlIGlnbm9yZSB0aGUgZXJyb3IgYW5kIGp1c3QgbW92ZSBvbi4KICAgICAgICAgICovCi0g
ICAgICAgaWYgKHJldCA9PSAtRU5PTUVNIHx8IChyZXQgPiAwICYmICEocmV0ICYgTlZNRV9TQ19E
TlIpKSkKLSAgICAgICAgICAgICAgIHJldCA9IDA7Ci0gICAgICAgZWxzZSBpZiAocmV0ID4gMCkK
KyAgICAgICBpZiAocmV0ID4gMCAmJiAocmV0ICYgTlZNRV9TQ19ETlIpKQogICAgICAgICAgICAg
ICAgIHJldCA9IGJsa19zdGF0dXNfdG9fZXJybm8obnZtZV9lcnJvcl9zdGF0dXMocmV0KSk7Cisg
ICAgICAgZWxzZSBpZiAocmV0ICE9IC1FTk9ERVYpCisgICAgICAgICAgICAgICByZXQgPSAwOwog
ICAgICAgICByZXR1cm4gcmV0OwogIH0KCi0tIAoyLjE2LjQKCj4gCj4gU28gYXMgSSBzYWlkLCB5
b3UgbmVlZCB0byBzb2x2ZSB0aGlzIGlzc3VlIHdpdGhvdXQgcHJldmVudGluZyB0aGUKPiBudm1l
IHN0YXR1cyBwcm9wYWdhdGUgYmFjay4KPiAuCldlIGNhbiBzb2x2ZSB0aGlzIGlzc3VlIGJ5IGNo
ZWNrIHRoZSBzdGF0dXMuIEJ1dCB3ZSBuZWVkIG1vZGlmeSBtYW55CmZ1bnRpb25zLCB0aGlzIGlz
IHVnbHkuIFRvIGRpc3Rpbmd1aXNoIG90aGVyIGVycm9yIGNvZGVzLCB3ZSBtYXkgbmVlZApyZXR1
cm4gRUlOVFIgZm9yIGhvc3QgY2FuY2VsIHJlcXVlc3QoTlZNRV9TQ19IT1NUX0FCT1JURURfQ01E
IG9yCk5WTUVfU0NfSE9TVF9QQVRIX0VSUk9SKSwgdGhlIGNhbGxlciBuZWVkIHRyZWF0IEVJTlRS
IGFzIGNhbmNlbGVkCnJlcXVlc3QuIEl0IG1pZ2h0IGJlIG1vcmUgYXBwcm9wcmlhdGUuCgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
