Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6290AC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 10:39:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3C861164
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 10:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3C861164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=whj+c3cePVm5DRoHJQ0hlDwITmwdjCt6WsbsTkjHZmM=; b=mnRiAktIlsq3LNVUTrD3kQ5W8
	16F53Lchenwh59Yivj9YRDtxyIj83EozGgQZxnczBcYpCuzNvKP10LLKYraMm9sPfDW5y0LjISD2X
	QzLaLppdwPrhP9pN4Vs701dOLUglliWj6s194qraaK42ezyHtHkrPJDcJZXr8iGqItwQiJGFX7LV8
	PiPS7fsVN2k4SfKn3pBydoe0ZPlpbj/ZXvIC284fPW2UmM83OJkLgFuZONs1ss5dGUi+SEaWv/kof
	S12DLmE9A3nCnREzjNmBCufBuXnBzOm2COMDfykUUKMsowsRudXs7qkNBUpSC3oN+xbBmfu5BlVqk
	9omSmXdOg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgPmt-00GyoN-UQ; Tue, 11 May 2021 10:38:52 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgLPA-00GNjO-UL
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 05:58:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=IrQ938jefosye+qtoH/ZPc0/PGmSxmCaDKvumqksGwQ=; b=2YI6tmeX72y7dWMeW+J65x1zVv
 RfTn/Je4801QPqyaZvmuX9zuV7LnVAvEfwfUwPxAzoQNOBjIolE9l+hrlGIyw43wFE4MRFXO7z3QG
 HpmwLU5PiTcL4BXzksxydFobQMUfCuydBtiP+4aU8jEenfx/MBgH7Q4uxAMiJEDVm/h6hB/34oGjE
 g+dIgl33mT3SSFxe34TWdkIOjkT4WT0I0w1jvChUOtBkXSGEHM3IqmEiLoM+1/56ya/GlUS8zPkcy
 m0/vV67P1/2fNlXTcbXmQXOXeQzvc4O7r8o6pGSgZh5+8A+b/YRstNIL+XO4Z+AjmRC2U/xJmg7qX
 miGvWmMg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgLP5-009KFQ-J0
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 05:58:01 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2BE2FB011;
 Tue, 11 May 2021 05:57:58 +0000 (UTC)
Subject: Re: [PATCH] nvme: allow to re-attach namespaces after all paths are
 down
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210510144906.8305-1-hare@suse.de>
 <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
 <d3f800eb-a917-d139-b430-b7b7976331de@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7137b35c-b656-0245-f1e1-9c0806ee61cb@suse.de>
Date: Tue, 11 May 2021 07:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <d3f800eb-a917-d139-b430-b7b7976331de@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_225759_938613_2A80DA49 
X-CRM114-Status: GOOD (  26.72  )
/bin/ln: failed to access
 'reaver_cache/texts/20210510_225759_938613_2A80DA49': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_225759_938613_2A80DA49 
X-CRM114-Status: GOOD (  23.00  )
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

T24gNS8xMS8yMSAxMjoyNSBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+IEBAIC0zNjA1
LDE2ICszNjA4LDI2IEBAIHN0YXRpYyBpbnQgbnZtZV9pbml0X25zX2hlYWQoc3RydWN0IG52bWVf
bnMgCj4+PiAqbnMsIHVuc2lnbmVkIG5zaWQsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaGVhZC0+
c2hhcmVkID0gaXNfc2hhcmVkOwo+Pj4gwqDCoMKgwqDCoCB9IGVsc2Ugewo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJldCA9IC1FSU5WQUw7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKCFpc19zaGFy
ZWQgfHwgIWhlYWQtPnNoYXJlZCkgewo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2Vy
cihjdHJsLT5kZXZpY2UsCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJEdXBs
aWNhdGUgdW5zaGFyZWQgbmFtZXNwYWNlICVkXG4iLCBuc2lkKTsKPj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdvdG8gb3V0X3B1dF9uc19oZWFkOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIH0KPj4+
IC3CoMKgwqDCoMKgwqDCoCBpZiAoIW52bWVfbnNfaWRzX2VxdWFsKCZoZWFkLT5pZHMsIGlkcykp
IHsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoY3RybC0+ZGV2aWNlLAo+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiSURzIGRvbid0IG1hdGNoIGZvciBzaGFy
ZWQgbmFtZXNwYWNlICVkXG4iLAo+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+PiArwqDCoMKgwqDC
oMKgwqDCoCAqIElmIG11bHRpcGF0aCBpcyBlbmFibGVkIHdlIG1pZ2h0IGhpdCBhbiBucyBoZWFk
IHdpdGggbm8KPj4+ICvCoMKgwqDCoMKgwqDCoMKgICogcGF0aHMsIGJ1dCB0aGF0IGRvZXNuJ3Qg
aW5kaWNhdGUgaXQncyBhIHNoYXJlZCBuYW1lc3BhY2UuCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAq
Lwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghbnZtZV9uc19oZWFkX211bHRpcGF0aChoZWFkKSB8
fAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWxpc3RfZW1wdHkoJmhlYWQtPmxpc3QpKSB7
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWlzX3NoYXJlZCB8fCAhaGVhZC0+c2hh
cmVkKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoY3RybC0+
ZGV2aWNlLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJEdXBs
aWNhdGUgdW5zaGFyZWQgbmFtZXNwYWNlICVkXG4iLCBuc2lkKTsKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfcHV0X25zX2hlYWQ7Cj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9Cj4+Cj4+IElmIG5vdCBtdWx0aXBhdGgsIHRoZW4gaXQgaXMgbm90IHNoYXJl
ZC4gVGhlIGFib3ZlIHdpbGwgZmFpbCBhdHRhY2hpbmcKPj4gc2luZ2xlLXBhdGggbmFtZXNwYWNl
cyB0byBhIGtub3duIGhlYWQuCj4+Cj4+IFRoZSByZXN0IGlzIHNpbWlsYXIgdG8gc29tZXRoaW5n
IEkgd2FzIHdvcmtpbmcgb24gdG9vLCB0aG91Z2gsIHNvIEkKPj4gdGhpbmsgaXQncyB0aGUgcmln
aHQgZGlyZWN0aW9uLgo+Pgo+Pgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFudm1l
X25zX2lkc19lcXVhbCgmaGVhZC0+aWRzLCBpZHMpKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRldl9lcnIoY3RybC0+ZGV2aWNlLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICJJRHMgZG9uJ3QgbWF0Y2ggZm9yIHNoYXJlZCBuYW1lc3Bh
Y2UgJWRcbiIsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bnNpZCk7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9wdXRfbnNfaGVhZDsK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfcHV0X25zX2hlYWQ7
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiArwqDCoMKgwqDCoMKgwqAgfSBlbHNl
IHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEJ1dCB0aGUgaWRzIG1pZ2h0IGhhdmUg
Y2hhbmdlZCwgc28gcmVzZXQgdGhlbSAqLwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGVh
ZC0+aWRzID0gKmlkczsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgIH0K
Pj4+IEBAIC0zNzY0LDggKzM3NzcsNiBAQCBzdGF0aWMgdm9pZCBudm1lX25zX3JlbW92ZShzdHJ1
Y3QgbnZtZV9ucyAqbnMpCj4+PiDCoMKgwqDCoMKgIG11dGV4X2xvY2soJm5zLT5jdHJsLT5zdWJz
eXMtPmxvY2spOwo+Pj4gwqDCoMKgwqDCoCBsaXN0X2RlbF9yY3UoJm5zLT5zaWJsaW5ncyk7Cj4+
PiAtwqDCoMKgIGlmIChsaXN0X2VtcHR5KCZucy0+aGVhZC0+bGlzdCkpCj4+PiAtwqDCoMKgwqDC
oMKgwqAgbGlzdF9kZWxfaW5pdCgmbnMtPmhlYWQtPmVudHJ5KTsKPiAKPiBIYW5uZXMsIHlvdSBz
ZW50IGEgcGF0Y2ggbGlrZSB0aGlzIGJlZm9yZSwgbXkgY29tbWVudCB3YXMgdGhhdCBhIG5zaGVh
ZAo+IHNob3VsZCBiZSByZW1vdmVkIGJlZm9yZSB0aGUgZmluYWwgcmVmZXJlbmNlICh3aGljaCB3
aG8ga25vd3Mgd2hlbiBpdAo+IHdpbGwgZXZlciBhcnJpdmUpIGFzIGlmIGEgbnNpZCB3ZXJlIHRv
IGJlIHJldXNlZCBieSB0aGUgY29udHJvbGxlciBmb3IKPiBhIGRpZmZlcmVudCBuYW1lc3BhY2Ug
dGhlbiB3ZSdkIHJlamVjdCBpdCBzbyBJJ20gbm90IHN1cmUgaG93IHRoaXMgaGVscHM/Cj4gCgpC
dXQgd2UgX25lZWRfIHRvIGhhdmUgdGhlIG5zaGVhZCBhdmFpbGFibGUgaW4gdGhlIGxpbmtlZCBs
aXN0IGlmIHdlIGV2ZXIgCndhbnQgdG8gcmUtYXR0YWNoIGEgbmFtZXNwYWNlIGFmdGVyIHJlY29u
bmVjdGluZyB0aGUgY29udHJvbGxlci4KQW5kIHdlIHNob3VsZCBiZSBhYmxlIHRvIGNhdGNoIHRo
ZSAncmV1c2UgbmFtZXNwYWNlJyBpc3N1ZSBieSBjaGVja2luZyAKdGhlIGNvbnRlbnRzIG9mIHRo
ZSBuc2lkcyBmaWVsZCwgd2hpY2ggd2Uga2VlcCBhdHRhY2hlZCB0byB0aGUgbnNoZWFkLgoKSSBr
bm93IEkgbmVlZCB0byBmaXh1cCB0aGUgcGF0Y2ggZm9yIHRoYXQsIHRob3VnaC4KCj4gSSB0aGlu
ayB0aGF0IGZvciB0aGUgcmFpZCBpc3N1ZSB3ZSBzaG91bGQgc29sdmUgdGhhdCBvbmUgZGlyZWN0
bHksIHRoaXMKPiBwYXRjaCBtYXkgaGF2ZSBvdGhlciBpbXBsaWNhdGlvbnMgaW4gbXkgbWluZC4u
LgoKVGhlIFJBSUQgaXNzdWUgX2lzXyBzb2x2ZWQgd2l0aCB0aGlzIHBhdGNoLgoKQ2hlZXJzLAoK
SGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9y
YWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAr
NDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRz
ZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
