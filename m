Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B38C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 11:23:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0F661984
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 11:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0F661984
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BvfxGuclWZvc4IA8u6+/ZpLuCRjQCsdhCmm4Yy/rSDU=; b=S1zWoXN5XoOVDQeC2pJBx1zDL
	5mbWck+jZLz3Am9kdRxN0DcdVBNW+ywUSxBCvRIY37a4b5GiYWwKCka1TilZ1jImq7UnGKUc9hTxr
	6VLeEBpzH3UbRN8/oG4vo/h+S6ytk3jIODIYAxDt7XqLjeiYdJ4kNMfDJnRFEt02uglg6lAt5Tl24
	4BDl8K8xAWx3o1CnRbTX4u4qbefYjuUmNZoiR1MK7nYm1ECW3YH4VxpPbCd4mpy4UkMiHL2udpYNq
	ZqNB+iXDlVklljUWYTrCwbyX5oZ3imGhKOzqeAvL+GWHxwn0gTlQ1Yu5FjEkgq5cQPwsWcucKMTOC
	q4NuJea9Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOIeH-00BR1G-52; Mon, 22 Mar 2021 11:23:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOIeA-00BQzz-0R
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 11:22:59 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1504AADE3;
 Mon, 22 Mar 2021 11:22:56 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <84378224-df30-8205-ebc3-45daf7a173d5@suse.de>
Date: Mon, 22 Mar 2021 12:22:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322073726.788347-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_112258_235402_D0E0852E 
X-CRM114-Status: GOOD (  29.74  )
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

T24gMy8yMi8yMSA4OjM3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBXaGVuIHdlIHJl
c2V0L3RlYXJkb3duIGEgY29udHJvbGxlciwgd2UgbXVzdCBmcmVlemUgYW5kIHF1aWVzY2UgdGhl
Cj4gbmFtZXNwYWNlcyByZXF1ZXN0IHF1ZXVlcyB0byBtYWtlIHN1cmUgdGhhdCB3ZSBzYWZlbHkg
c3RvcCBpbmZsaWdodCBJL08KPiBzdWJtaXNzaW9ucy4gRnJlZXplIGlzIG1hbmRhdG9yeSBiZWNh
dXNlIGlmIG91ciBoY3R4IG1hcCBjaGFuZ2VkIGJldHdlZW4KPiByZWNvbm5lY3RzLCBibGtfbXFf
dXBkYXRlX25yX2h3X3F1ZXVlcyB3aWxsIGltbWVkaWF0ZWx5IGF0dGVtcHQgdG8gZnJlZXplCj4g
dGhlIHF1ZXVlLCBhbmQgaWYgaXQgc3RpbGwgaGFzIHBlbmRpbmcgc3VibWlzc2lvbnMgKHRoYXQg
YXJlIHN0aWxsCj4gcXVpZXNjZWQpIGl0IHdpbGwgaGFuZy4KPiAKPiBIb3dldmVyLCBieSBmcmVl
emluZyB0aGUgbmFtZXNwYWNlcyByZXF1ZXN0IHF1ZXVlcywgYW5kIG9ubHkgdW5mcmVlemluZwo+
IHRoZW0gd2hlbiB3ZSBzdWNjZXNzZnVsbHkgcmVjb25uZWN0LCBpbmZsaWdodCBzdWJtaXNzaW9u
cyB0aGF0IGFyZQo+IHJ1bm5pbmcgY29uY3VycmVudGx5IGNhbiBub3cgYmxvY2sgZ3JhYmJpbmcg
dGhlIG5zaGVhZCBzcmN1IHVudGlsIGVpdGhlcgo+IHdlIHN1Y2Nlc3NmdWxseSByZWNvbm5lY3Qg
b3IgY3RybF9sb3NzX3RtbyBleHBpcmVkIChvciB0aGUgdXNlcgo+IGV4cGxpY2l0bHkgZGlzY29u
bmVjdGVkKS4KPiAKPiBUaGlzIGNhdXNlZCBhIGRlYWRsb2NrIHdoZW4gYSBkaWZmZXJlbnQgY29u
dHJvbGxlciAoZGlmZmVyZW50IHBhdGggb24gdGhlCj4gc2FtZSBzdWJzeXN0ZW0pIGJlY2FtZSBs
aXZlIChpLmUuIG9wdGltaXplZC9ub24tb3B0aW1pemVkKS4gVGhpcyBpcwo+IGJlY2F1c2UgbnZt
ZV9tcGF0aF9zZXRfbGl2ZSBuZWVkcyB0byBzeW5jaHJvbml6ZSB0aGUgbnNoZWFkIHNyY3UgYmVm
b3JlCj4gcmVxdWV1ZWluZyBJL08gaW4gb3JkZXIgdG8gbWFrZSBzdXJlIHRoYXQgY3VycmVudF9w
YXRoIGlzIHZpc2libGUgdG8KPiBmdXR1cmUgKHJlLSlzdWJtaXNpb25zLiBIb3dldmVyIHRoZSBz
cmN1IGxvY2sgaXMgdGFrZW4gYnkgYSBibG9ja2VkCj4gc3VibWlzc2lvbiBvbiBhIGZyb3plbiBy
ZXF1ZXN0IHF1ZXVlLCBhbmQgd2UgaGF2ZSBhIGRlYWRsb2NrLgo+IAo+IEluIG9yZGVyIHRvIGZp
eCB0aGlzIHVzZSB0aGUgYmxrX21xX3N1Ym1pdF9iaW9fZGlyZWN0IEFQSSB0byBzdWJtaXQgdGhl
Cj4gYmlvIHRvIHRoZSBsb3ctbGV2ZWwgZHJpdmVyLCB3aGljaCBkb2VzIG5vdCBibG9jayBvbiB0
aGUgcXVldWUgZnJlZQo+IGJ1dCBpbnN0ZWFkIGFsbG93cyBudm1lLW11bHRpcGF0aCB0byBwaWNr
IGFub3RoZXIgcGF0aCBvciBxdWV1ZSB1cCB0aGUKPiBiaW8uCj4gCj4gRml4ZXM6IDlmOTg3NzJi
YTMwNyAoIm52bWUtcmRtYTogZml4IGNvbnRyb2xsZXIgcmVzZXQgaGFuZyBkdXJpbmcgdHJhZmZp
YyIpCj4gRml4ZXM6IDI4NzViMGFlY2FiZSAoIm52bWUtdGNwOiBmaXggY29udHJvbGxlciByZXNl
dCBoYW5nIGR1cmluZyB0cmFmZmljIikKPiAKPiBSZXBvcnRlZC1ieSBTYWdpIEdyaW1iZXJnIDxz
YWdpQGdyaW1iZXJnLm1lPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyB8IDggKysrKysr
Ky0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L211bHRpcGF0aC5jCj4gaW5kZXggYTFkNDc2ZTFhYzAyMGYuLjkyYWRlYmZhZjg2ZmQx
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4gKysrIGIvZHJp
dmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPiBAQCAtMzA5LDYgKzMwOSw3IEBAIGJsa19xY190
IG52bWVfbnNfaGVhZF9zdWJtaXRfYmlvKHN0cnVjdCBiaW8gKmJpbykKPiAgCSAqLwo+ICAJYmxr
X3F1ZXVlX3NwbGl0KCZiaW8pOwo+ICAKPiArcmV0cnk6Cj4gIAlzcmN1X2lkeCA9IHNyY3VfcmVh
ZF9sb2NrKCZoZWFkLT5zcmN1KTsKPiAgCW5zID0gbnZtZV9maW5kX3BhdGgoaGVhZCk7Cj4gIAlp
ZiAobGlrZWx5KG5zKSkgewo+IEBAIC0zMTYsNyArMzE3LDEyIEBAIGJsa19xY190IG52bWVfbnNf
aGVhZF9zdWJtaXRfYmlvKHN0cnVjdCBiaW8gKmJpbykKPiAgCQliaW8tPmJpX29wZiB8PSBSRVFf
TlZNRV9NUEFUSDsKPiAgCQl0cmFjZV9ibG9ja19iaW9fcmVtYXAoYmlvLCBkaXNrX2RldnQobnMt
PmhlYWQtPmRpc2spLAo+ICAJCQkJICAgICAgYmlvLT5iaV9pdGVyLmJpX3NlY3Rvcik7Cj4gLQkJ
cmV0ID0gc3VibWl0X2Jpb19ub2FjY3QoYmlvKTsKPiArCj4gKwkJaWYgKCFibGtfbXFfc3VibWl0
X2Jpb19kaXJlY3QoYmlvLCAmcmV0KSkgewo+ICsJCQludm1lX21wYXRoX2NsZWFyX2N1cnJlbnRf
cGF0aChucyk7Cj4gKwkJCXNyY3VfcmVhZF91bmxvY2soJmhlYWQtPnNyY3UsIHNyY3VfaWR4KTsK
PiArCQkJZ290byByZXRyeTsKPiArCQl9Cj4gIAl9IGVsc2UgaWYgKG52bWVfYXZhaWxhYmxlX3Bh
dGgoaGVhZCkpIHsKPiAgCQlkZXZfd2Fybl9yYXRlbGltaXRlZChkZXYsICJubyB1c2FibGUgcGF0
aCAtIHJlcXVldWluZyBJL09cbiIpOwo+ICAKPiAKQWguIFdlJ3ZlIHJ1biBpbnRvIHRoZSBzYW1l
IGlzc3VlLCBhbmQgSSd2ZSBjb21lIHVwIHdpdGggYmFzaWNhbGx5IHRoZQpzYW1lIHBhdGNoIHRv
IGhhdmUgaXQgZml4ZWQuClRlc3RzIGFyZSBzdGlsbCBvdXRzdGFuZGluZywgc28gSSBoYXZlbid0
IGJlZW4gYWJsZSB0byB2YWxpZGF0ZSBpdCBwcm9wZXJseS4KVGhhbmtzIGZvciBmaXhpbmcgaXQg
dXAuCgpSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMs
CgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0b3Jh
Z2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQw
NTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IElt
ZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
