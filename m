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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F5C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:53:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B294F20759
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p2qCpFXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B294F20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EGuRVv9dYpwBKdOfn63gbGeps0A3YNGJpA9ecUltRgU=; b=p2qCpFXNyu0oqGUos4UjPLs70
	CQh1g3ZCtBi96lzGVyG0rrVh4PYlpuOu3GuU7ai9Y4/9OtFaAdjEmPnntNLekzqgHvFK8KIXwby51
	YpNe+6c7XWqjD+NcpkkWa3XELVSlY1g27uo9fq37c7o1TTgaPjNPXfFk4+AT5hxXGE1WyfGdKcsCC
	3DeiKZMSHrKAEvzq3nxNvBrVgE6QMXIoqqBbHG/EoXWi7PqBBzr16VknFgzQaTSroMQYcMNDtMvGB
	0f0qoOakkGzU+Hfuyp4dI63OwphWdVq+enJR3eVXDf/f7Vza7Qds49jzaoBiW9spTnSUvB09r+hZ2
	EXPj+3DBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0GgE-0006RK-Fk; Tue, 28 Jul 2020 03:53:30 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0GgB-0006Q7-Ut
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 03:53:28 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 561636516745AEDC90FA;
 Tue, 28 Jul 2020 11:51:53 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 28 Jul 2020 11:51:51 +0800
Subject: Re: [PATCH v5 2/2] nvme: use blk_mq_[un]quiesce_tagset
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@kernel.dk>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-3-sagi@grimberg.me>
 <56517f9c-2d4e-0fee-52d6-20ef9be54bc0@grimberg.me>
 <5d11e813-b0dd-3082-366b-176717cdf3a6@huawei.com>
 <92b821a6-a774-d85b-2711-418d36fc10d0@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <0e40714a-e1aa-163e-0d8e-db1ea439faad@huawei.com>
Date: Tue, 28 Jul 2020 11:51:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <92b821a6-a774-d85b-2711-418d36fc10d0@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_235328_228775_F9F86B1B 
X-CRM114-Status: GOOD (  14.62  )
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

CgpPbiAyMDIwLzcvMjggMTE6MzQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+Pj4gQWxsIGNv
bnRyb2xsZXIgbmFtZXNwYWNlcyBzaGFyZSB0aGUgc2FtZSB0YWdzZXQsIHNvIHdlCj4+Pj4gY2Fu
IHVzZSB0aGlzIGludGVyZmFjZSB3aGljaCBkb2VzIHRoZSBvcHRpbWFsIG9wZXJhdGlvbgo+Pj4+
IGZvciBwYXJhbGxlbCBxdWllc2NlIGJhc2VkIG9uIHRoZSB0YWdzZXQgdHlwZSAoZS5nLgo+Pj4+
IGJsb2NraW5nIHRhZ3NldHMgYW5kIG5vbi1ibG9ja2luZyB0YWdzZXRzKS4KPj4+Pgo+Pj4+IFNp
Z25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4+Pj4gLS0tCj4+
Pj4gwqAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgMTQgKystLS0tLS0tLS0tLS0KPj4+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPj4+Pgo+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMKPj4+PiBpbmRleCAwNWFhNTY4YTYwYWYuLmM0MWRmMjA5OTZkNyAxMDA2NDQK
Pj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4+PiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKPj4+PiBAQCAtNDU1NywyMyArNDU1NywxMyBAQCBFWFBPUlRfU1lNQk9M
X0dQTChudm1lX3N0YXJ0X2ZyZWV6ZSk7Cj4+Pj4gwqAgdm9pZCBudm1lX3N0b3BfcXVldWVzKHN0
cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4+Pj4gwqAgewo+Pj4+IC3CoMKgwqAgc3RydWN0IG52bWVf
bnMgKm5zOwo+Pj4+IC0KPj4+PiAtwqDCoMKgIGRvd25fcmVhZCgmY3RybC0+bmFtZXNwYWNlc19y
d3NlbSk7Cj4+Pj4gLcKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KG5zLCAmY3RybC0+bmFtZXNw
YWNlcywgbGlzdCkKPj4+PiAtwqDCoMKgwqDCoMKgwqAgYmxrX21xX3F1aWVzY2VfcXVldWUobnMt
PnF1ZXVlKTsKPj4+PiAtwqDCoMKgIHVwX3JlYWQoJmN0cmwtPm5hbWVzcGFjZXNfcndzZW0pOwo+
Pj4+ICvCoMKgwqAgYmxrX21xX3F1aWVzY2VfdGFnc2V0KGN0cmwtPnRhZ3NldCk7Cj4+Pgo+Pj4g
UnJyLi4gdGhpcyBvbmUgaXMgc2xpZ2h0bHkgYW5ub3lpbmcuIFdlIGhhdmUgdGhlIGNvbm5lY3Rf
cSBpbgo+Pj4gZmFicmljcyB0aGF0IHdlIHVzZSB0byBpc3N1ZSB0aGUgY29ubmVjdCBjb21tYW5k
IHdoaWNoIGlzIG5vdwo+Pj4gcXVpZXNjZWQgdG9vLi4uCj4+Pgo+Pj4gSWYgd2Ugd2lsbCB1c2Ug
dGhpcyBpbnRlcmZhY2UsIHdlIGNhbiB1bnF1aWVzY2UgaXQgcmlnaHQgYXdheSwKPj4+IGJ1dCB0
aGF0IHNlZW1zIGtpbmRhIGJhY2t3YXJkcy4uSW8gcXVldWUgYW5kIGFkbWluIHF1ZXVlIGhhcyBk
aWZmZXJlbnQgdHJlYXQgbWVjaGFuaXNtLCBpbnRyb2R1Y2UKPj4gYmxrX21xX3F1aWVzY2VfdGFn
c2V0IG1heSBtYWtlIHRoZSBtZWNoYW5pc20gdW5jbGVhci4gU28gdGhpcyBpcwo+PiBwcm9iYWJs
eSBub3QgYSBnb29kIGNob2ljZS4KPiAKPiBUaGUgbWVhbmluZyBvZiBibGtfbXFfcXVpZXNjZV90
YWdzZXQgaXMgY2xlYXIsIHRoZSBhd2t3YXJkIHRoaW5nIGlzCj4gdGhhdCB3ZSBuZWVkIHRvIHVu
cXVpZXNjZSB0aGUgY29ubmVjdF9xIGFmdGVyIGJsa19tcV9xdWllc2NlX3RhZ3NldAo+IHF1aWVz
Y2VkIGl0LgpJbyBxdWV1ZSBhbmQgYWRtaW4gcXVldWUgaGFzIGRpZmZlcmVudCB0cmVhdCBtZWNo
YW5pc20uIElmIHdlIHN3aXRjaCB0bwpibGtfbXFfcXVpZXNjZV90YWdzZXQsIG1heWJlIHdlIG5l
ZWQgZG8gbW9yZSBleHRyYXMgc3VjaCBhcyB1bnF1aWVzY2UKdGhlIGNvbm5lY3RfcSwgdGh1cyB0
aGUgbWVjaGFuaXNtIG1heWJlIHVuY2xlYXIuIFN1cmVseSBpZiB3ZSBpbnRyb2R1Y2UKYmxrX21x
X3F1aWVzY2VfdGFnc2V0IGZvciBuZXcgZmVhdHVyZSwgdGhlIGFic3RyYWN0aW9uIGlzIGdyZWF0
Lgo+IAo+IEknbSB0aGlua2luZyBvZiByZXNvcnRpbmcgZnJvbSB0aGlzIGFic3RyYWN0aW9uLi4u
Cj4gLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
