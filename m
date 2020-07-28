Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B18C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:21:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F252072E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="w67vEZ77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F252072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GoMuRyre5lJX72H6zj63EYHJ7reononjTYpS/5+Y5HY=; b=w67vEZ77PtTa5lznB8PlJYMP0
	Lne6NHPE+SDnX94QVSc9bHDRo4+Ge45g67X+LTsAZJof4Wm25pCJrF71C35srDexGQ4o1YOIdxN73
	PlArE3NCp2Va3lYJ1PvtnSWztIgrCGMHY2fgWEDUMhBUjUBShaRRHBXKv11CTX3AeAhrAbdW3qkT8
	PNzfADajF1vDMRyzew3dqZiFVpBeFYupRKOwGVOCUBl3EynuFtAq0BhLMeE8mdpVMLoSHcvEMCE/X
	rSTfTzg3uSLKCCAF/PoZ6lBvDH2Kg+ix6OZAomRWHLiCLHTZxLmew+CZc5Ar5vpWb8RyHo/Xp45Jh
	HcOO2A5VA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0GBG-0002NB-NQ; Tue, 28 Jul 2020 03:21:30 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0GBD-0002MI-AY
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 03:21:28 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5019FED751AA482E4210;
 Tue, 28 Jul 2020 11:21:24 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 28 Jul 2020 11:21:20 +0800
Subject: Re: [PATCH v5 2/2] nvme: use blk_mq_[un]quiesce_tagset
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@kernel.dk>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-3-sagi@grimberg.me>
 <56517f9c-2d4e-0fee-52d6-20ef9be54bc0@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <5d11e813-b0dd-3082-366b-176717cdf3a6@huawei.com>
Date: Tue, 28 Jul 2020 11:21:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <56517f9c-2d4e-0fee-52d6-20ef9be54bc0@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_232127_633215_5232B8C6 
X-CRM114-Status: GOOD (  20.04  )
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
Cc: linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzcvMjggODo1NCwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPiAKPiBPbiA3LzI3
LzIwIDQ6MTAgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+IEFsbCBjb250cm9sbGVyIG5hbWVz
cGFjZXMgc2hhcmUgdGhlIHNhbWUgdGFnc2V0LCBzbyB3ZQo+PiBjYW4gdXNlIHRoaXMgaW50ZXJm
YWNlIHdoaWNoIGRvZXMgdGhlIG9wdGltYWwgb3BlcmF0aW9uCj4+IGZvciBwYXJhbGxlbCBxdWll
c2NlIGJhc2VkIG9uIHRoZSB0YWdzZXQgdHlwZSAoZS5nLgo+PiBibG9ja2luZyB0YWdzZXRzIGFu
ZCBub24tYmxvY2tpbmcgdGFnc2V0cykuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJl
cmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMgfCAxNCArKy0tLS0tLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBpbmRleCAwNWFhNTY4YTYwYWYu
LmM0MWRmMjA5OTZkNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+
ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBAQCAtNDU1NywyMyArNDU1NywxMyBA
QCBFWFBPUlRfU1lNQk9MX0dQTChudm1lX3N0YXJ0X2ZyZWV6ZSk7Cj4+IMKgIHZvaWQgbnZtZV9z
dG9wX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQo+PiDCoCB7Cj4+IC3CoMKgwqAgc3Ry
dWN0IG52bWVfbnMgKm5zOwo+PiAtCj4+IC3CoMKgwqAgZG93bl9yZWFkKCZjdHJsLT5uYW1lc3Bh
Y2VzX3J3c2VtKTsKPj4gLcKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KG5zLCAmY3RybC0+bmFt
ZXNwYWNlcywgbGlzdCkKPj4gLcKgwqDCoMKgwqDCoMKgIGJsa19tcV9xdWllc2NlX3F1ZXVlKG5z
LT5xdWV1ZSk7Cj4+IC3CoMKgwqAgdXBfcmVhZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+
ICvCoMKgwqAgYmxrX21xX3F1aWVzY2VfdGFnc2V0KGN0cmwtPnRhZ3NldCk7Cj4gCj4gUnJyLi4g
dGhpcyBvbmUgaXMgc2xpZ2h0bHkgYW5ub3lpbmcuIFdlIGhhdmUgdGhlIGNvbm5lY3RfcSBpbgo+
IGZhYnJpY3MgdGhhdCB3ZSB1c2UgdG8gaXNzdWUgdGhlIGNvbm5lY3QgY29tbWFuZCB3aGljaCBp
cyBub3cKPiBxdWllc2NlZCB0b28uLi4KPiAKPiBJZiB3ZSB3aWxsIHVzZSB0aGlzIGludGVyZmFj
ZSwgd2UgY2FuIHVucXVpZXNjZSBpdCByaWdodCBhd2F5LAo+IGJ1dCB0aGF0IHNlZW1zIGtpbmRh
IGJhY2t3YXJkcy4uSW8gcXVldWUgYW5kIGFkbWluIHF1ZXVlIGhhcyBkaWZmZXJlbnQgdHJlYXQg
bWVjaGFuaXNtLCBpbnRyb2R1Y2UKYmxrX21xX3F1aWVzY2VfdGFnc2V0IG1heSBtYWtlIHRoZSBt
ZWNoYW5pc20gdW5jbGVhci4gU28gdGhpcyBpcwpwcm9iYWJseSBub3QgYSBnb29kIGNob2ljZS4K
Cj4gCj4gLS0gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4IDA1YWE1NjhhNjBhZi4uNzBhZjBmZjYzZTdmIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYwo+IEBAIC00NTU3LDIzICs0NTU3LDE1IEBAIEVYUE9SVF9TWU1CT0xfR1BM
KG52bWVfc3RhcnRfZnJlZXplKTsKPiAKPiAgwqB2b2lkIG52bWVfc3RvcF9xdWV1ZXMoc3RydWN0
IG52bWVfY3RybCAqY3RybCkKPiAgwqB7Cj4gLcKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9ucyAq
bnM7Cj4gLQo+IC3CoMKgwqDCoMKgwqAgZG93bl9yZWFkKCZjdHJsLT5uYW1lc3BhY2VzX3J3c2Vt
KTsKPiAtwqDCoMKgwqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50cnkobnMsICZjdHJsLT5uYW1lc3Bh
Y2VzLCBsaXN0KQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJsa19tcV9xdWllc2Nl
X3F1ZXVlKG5zLT5xdWV1ZSk7Cj4gLcKgwqDCoMKgwqDCoCB1cF9yZWFkKCZjdHJsLT5uYW1lc3Bh
Y2VzX3J3c2VtKTsKPiArwqDCoMKgwqDCoMKgIGJsa19tcV9xdWllc2NlX3RhZ3NldChjdHJsLT50
YWdzZXQpOwo+ICvCoMKgwqDCoMKgwqAgaWYgKGN0cmwtPmNvbm5lY3RfcSkKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBibGtfbXFfdW5xdWllc2NlX3F1ZXVlKGN0cmwtPmNvbm5lY3Rf
cSk7Cj4gIMKgfQo+ICDCoEVYUE9SVF9TWU1CT0xfR1BMKG52bWVfc3RvcF9xdWV1ZXMpOwo+IC0t
IAo+IAo+IFRob3VnaHRzPwo+IC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
