Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B1C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 09:21:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A3861186
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 09:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A3861186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=27SelGlpg9R0tq9S15VUqyETjWiFvpoYW/0BVJWQ3qw=; b=MLu4N6UngIgyae3ixGQWlZOhT
	4gCZrQ5vbsKMpAVe+8/bJ/UA44ixRhCCagvI6ea8CcEJNXpMyjgHPctwC80sHI1J1gQ7OdomNbQTt
	KWEy+/P/QMowIw8SINTPOVPIvgtsjyJo6hKl7dSIZIwtQ3uh2DvL+P+ULsLC+xb+8F9A4MqcEjFxX
	nbkZsx1IWnK6tQ70Ry28NOO6syzLISpn6URBacXoYIjVvwLui1vIKHQzzS0kvGPu8ow/j1IUDwLTV
	Br9St6qg6aC9Y3IN0OQjuia2TUOcUhgOZeweZY9SdPl81952aeL/kGV5j22+67iwuY8BpZyKfFtJv
	UWaQ8Y24A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhTzs-007bwo-C8; Fri, 14 May 2021 09:20:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhTzp-007bw6-IC
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 09:20:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=wRZs2VB0LNmvv5Zr/ZRahqvsI6MF6/OgrYnSdxdSNy8=; b=NXeVHfIwyisYX3mQmjBN8RjWAv
 1e4SDWv0gsbWY8xc7e+9FHFXqVHohdd2yHrvdAAK2x9ueGk/jw4OBdpp2rbwL8nrlsaXI3mIM0cBw
 ZFa9bnealwoQSO2CVIEwAUW0RYNodFqT8yLgNBUHnyRzfCjJr8HHZqGJSdNHIVw8T6bM4/ZpnGiS4
 pJGTSkSPHWWJb555vHZDRlllMpxcm26JKJ6Y28wI+CXaKVAAxgEVm3lcD3cISE+V2qM7RuvwvSGh0
 QLBrAusWzpIvkywPt/I0MB/n+9AbHxE+seuc/SS+qvSEKbMkCpKTChrNG67hbGcS3CUE+05Jxk0Qz
 Payng7Bw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhTzm-00BqyF-Uw
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 09:20:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9BEA7AE86;
 Fri, 14 May 2021 09:20:32 +0000 (UTC)
Subject: Re: [PATCH] nvme-fc: clear q_live at beginning of association teardown
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20210511045635.12494-1-jsmart2021@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <0b5714c4-0182-3fa9-ee93-d7fa50441707@suse.de>
Date: Fri, 14 May 2021 11:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511045635.12494-1-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_022035_164251_9B2E4A58 
X-CRM114-Status: GOOD (  22.79  )
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

T24gNS8xMS8yMSA2OjU2IEFNLCBKYW1lcyBTbWFydCB3cm90ZToKPiBUaGUgX19udm1mX2NoZWNr
X3JlYWR5KCkgcm91dGluZSB1c2VkIHRvIGJvdW5jZSBhbGwgZmlsZXN5c3RlbSBpbyBpZgo+IHRo
ZSBjb250cm9sbGVyIHN0YXRlIGlzbid0IExJVkUuIEhvd2V2ZXIsIGEgbGF0ZXIgcGF0Y2ggY2hh
bmdlZCB0aGUKPiBsb2dpYyBzbyB0aGF0IGl0IHJlamVjdGlvbiBlbmRzIHVwIGJlaW5nIGJhc2Vk
IG9uIHRoZSBRIGxpdmUgY2hlY2suCj4gVGhlIGZjIHRyYW5zcG9ydCBoYXMgYSBzbGlnaHRseSBk
aWZmZXJlbnQgc2VxdWVuY2UgZnJvbSByZG1hIGFuZCB0Y3AKPiBmb3Igc2h1dHRpbmcgZG93biBx
dWV1ZXMvbWFya2luZyB0aGVtIG5vbi1saXZlLiBGQyBtYXJrcyBpdHMgcXVldWUKPiBub24tbGl2
ZSBhZnRlciBhYm9ydGluZyBhbGwgaW9zIGFuZCB3YWl0aW5nIGZvciB0aGVpciB0ZXJtaW5hdGlv
biwKPiBsZWF2aW5nIGEgcmF0aGVyIGxhcmdlIHdpbmRvdyBmb3IgZmlsZXN5c3RlbSBpbyB0byBj
b250aW51ZSB0byBoaXQgdGhlCj4gdHJhbnNwb3J0LiBVbmZvcnR1bmF0ZWx5IHRoaXMgcmVzdWx0
ZWQgaW4gZmlsZXN5c3RlbSBpbyBvciBhcHBsaWNhdGlvbnMKPiBzZWVpbmcgSS9PIGVycm9ycy4K
PiAKPiBDaGFuZ2UgdGhlIGZjIHRyYW5zcG9ydCB0byBtYXJrIHRoZSBxdWV1ZXMgbm9uLWxpdmUg
YXQgdGhlIGZpcnN0Cj4gc2lnbiBvZiB0ZWFyZG93biBmb3IgdGhlIGFzc29jaWF0aW9uICh3aGVu
IGkvbyBpcyBpbml0aWFsbHkgdGVybWluYXRlZCkuCj4gCj4gRml4ZXM6IDczYTUzNzk5MzdlYyAo
Im52bWUtZmFicmljczogYWxsb3cgdG8gcXVldWUgcmVxdWVzdHMgZm9yIGxpdmUgcXVldWVzIikK
PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjUuOCsKPiBTaWduZWQtb2ZmLWJ5OiBK
YW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gCj4gLS0tCj4gc3RhYmxlIHRyZWVz
IGZvciA1LjggYW5kIDUuOSB3aWxsIHJlcXVpcmUgYSBzbGlnaHRseSBtb2RpZmllZCBwYXRjaAo+
IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9mYy5jIHwgMTIgKysrKysrKysrKysrCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L2ZjLmMgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4gaW5kZXggZDlhYjllNzg3MWQw
Li4yNTZlODc3MjFhMDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+ICsr
KyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMKPiBAQCAtMjQ2MSw2ICsyNDYxLDE4IEBAIG52bWVf
ZmNfdGVybWluYXRlX2V4Y2hhbmdlKHN0cnVjdCByZXF1ZXN0ICpyZXEsIHZvaWQgKmRhdGEsIGJv
b2wgcmVzZXJ2ZWQpCj4gIHN0YXRpYyB2b2lkCj4gIF9fbnZtZV9mY19hYm9ydF9vdXRzdGFuZGlu
Z19pb3Moc3RydWN0IG52bWVfZmNfY3RybCAqY3RybCwgYm9vbCBzdGFydF9xdWV1ZXMpCj4gIHsK
PiArCWludCBxOwo+ICsKPiArCS8qCj4gKwkgKiBpZiBhYm9ydGluZyBpbywgdGhlIHF1ZXVlcyBh
cmUgbm8gbG9uZ2VyIGdvb2QsIG1hcmsgdGhlbQo+ICsJICogYWxsIGFzIG5vdCBsaXZlLgo+ICsJ
ICovCj4gKwlpZiAoY3RybC0+Y3RybC5xdWV1ZV9jb3VudCA+IDEpIHsKPiArCQlmb3IgKHEgPSAx
OyBxIDwgY3RybC0+Y3RybC5xdWV1ZV9jb3VudDsgcSsrKQo+ICsJCQljbGVhcl9iaXQoTlZNRV9G
Q19RX0xJVkUsICZjdHJsLT5xdWV1ZXNbcV0uZmxhZ3MpOwo+ICsJfQo+ICsJY2xlYXJfYml0KE5W
TUVfRkNfUV9MSVZFLCAmY3RybC0+cXVldWVzWzBdLmZsYWdzKTsKPiArCj4gIAkvKgo+ICAJICog
SWYgaW8gcXVldWVzIGFyZSBwcmVzZW50LCBzdG9wIHRoZW0gYW5kIHRlcm1pbmF0ZSBhbGwgb3V0
c3RhbmRpbmcKPiAgCSAqIGlvcyBvbiB0aGVtLiBBcyBGQyBhbGxvY2F0ZXMgRkMgZXhjaGFuZ2Ug
Zm9yIGVhY2ggaW8sIHRoZQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1
c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAg
S2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICs0
OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgOTA0
MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZmZXIsIEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJn
KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
