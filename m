Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855FBC04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:25:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421AB613CC
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421AB613CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xts3Q6zqx6VyR8PMRtt+RKr9+UViiQ5B7VpOvlD0QEk=; b=M89PwgOIhJAX0ZGq3+sKvGoqL
	fZQWf4li1H+BKnPA6ciYFalk5k9VTabWpWNZ1p/8rQku/SJpZTSt4lt8jz63+I/UPBJEQv1JsMidp
	NUk6aVBEPxhSpBAy2udcbQPR0gEnggW20TaLotq1jyeq9iL5E8LFNkooKL80wl1bo9KrtaDjvH2AO
	xe5Egrb45xP/BYcJqxvF3GMjjglAzGJopm6qVwJz4vbAaFAQFIAWxRXuTlIB72mDLacf00pBux1WO
	1BRJ1Cr3v0CqXrcnL+yLbzfXEAzO+YetoLXxAzVPhVxFuq16yl9iS3IH0y51HoRE2zKtPxksMvi1J
	0QM60Opig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llH8Z-001p9T-AY; Mon, 24 May 2021 20:25:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkjLd-0042T1-LL
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 08:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=jkWgVmeV1aDIbqHf2NWEl/RY0pR5gonwUowiZNNAcjQ=; b=4PjnM576myJhwoneRqVSRWG2ve
 ZMlMvJfl++4XNbC/3PUpCNX44mbupTU1L1iQIF6RGgSo8BrLxBy2NXBPXiTC4AqUaDs67qJYTxyoA
 UYVr4CDqfLi4caNI7NelkCjNRiQ4dfd7JkjAkcoA0XOJXTxyUf5cavp9kuwKpndZLLZmJPg3IPV5b
 PVj42GP6pp/bsoy6YsPXDyK6/cBstqJF72pmzRdzNRUzCjjx8ILHPRucbTpHTozVTCStFlJiNskz5
 wVRB35IxHAOuHXdlXDhA4mA4xVaKfksVo3YMDAwBg/18xsyKeHrKghQtp5DCKN60aREBg6RaVXkEN
 H79pZUug==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkjLa-000N7V-NL
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 08:20:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621758028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkWgVmeV1aDIbqHf2NWEl/RY0pR5gonwUowiZNNAcjQ=;
 b=b+KRmroRC/XnrIoT11eR1Zk2Jd7yfgwHdeYGc5z7w8i6TcEXXIvJ+uAJltYU677ItQKbcP
 lTfr+wvAFKJAAA6huplmsb7+l7hNTLV7yag5ZnXHWJBdfxMJJWQT/9Tyv1KcRDcaRBTR4d
 gH8UlaT3HpMdJlK6xi7bJ6DG0Dwlpuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621758028;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkWgVmeV1aDIbqHf2NWEl/RY0pR5gonwUowiZNNAcjQ=;
 b=5gJEAWYW4NtLrHn8NUGKKYttWxGml91Pn705UCTO6YjfUC4LqVOYzM2Ns7am/CTWT5WxK7
 TNrsYHd51WvUdFAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B335CAB7C;
 Sun, 23 May 2021 08:20:28 +0000 (UTC)
Subject: Re: [PATCH 18/26] nvme-multipath: convert to
 blk_alloc_disk/blk_cleanup_disk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
 Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
 drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-19-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1a771bf9-5083-c440-f0e1-5f6920b5b017@suse.de>
Date: Sun, 23 May 2021 10:20:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-19-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_012031_079013_B1E8EBFD 
X-CRM114-Status: GOOD (  28.87  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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

T24gNS8yMS8yMSA3OjUxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBDb252ZXJ0IHRo
ZSBudm1lLW11bHRpcGF0aCBkcml2ZXIgdG8gdXNlIHRoZSBibGtfYWxsb2NfZGlzayBhbmQKPiBi
bGtfY2xlYW51cF9kaXNrIGhlbHBlcnMgdG8gc2ltcGxpZnkgZ2VuZGlzayBhbmQgcmVxdWVzdF9x
dWV1ZQo+IGFsbG9jYXRpb24uCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+Cj4gLS0tCj4gICBkcml2ZXJzL252ZGltbS9wbWVtLmMgICAgICAgICB8ICAx
IC0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIHwgNDUgKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgMzMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3BtZW0u
YyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYwo+IGluZGV4IDlmY2QwNTA4NDU2NC4uMzFmM2M0YmQ2
ZjcyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZkaW1tL3BtZW0uYwo+ICsrKyBiL2RyaXZlcnMv
bnZkaW1tL3BtZW0uYwo+IEBAIC00NzIsNyArNDcyLDYgQEAgc3RhdGljIGludCBwbWVtX2F0dGFj
aF9kaXNrKHN0cnVjdCBkZXZpY2UgKmRldiwKPiAgIAkJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVF
X0ZMQUdfREFYLCBxKTsKPiAgIAo+ICAgCWRpc2stPmZvcHMJCT0gJnBtZW1fZm9wczsKPiAtCWRp
c2stPnF1ZXVlCQk9IHE7Cj4gICAJZGlzay0+cHJpdmF0ZV9kYXRhCT0gcG1lbTsKPiAgIAludmRp
bW1fbmFtZXNwYWNlX2Rpc2tfbmFtZShuZG5zLCBkaXNrLT5kaXNrX25hbWUpOwo+ICAgCXNldF9j
YXBhY2l0eShkaXNrLCAocG1lbS0+c2l6ZSAtIHBtZW0tPnBmbl9wYWQgLSBwbWVtLT5kYXRhX29m
ZnNldCkKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+IGluZGV4IGE1ZDAyZjIzNmNjYS4uYjVmYmRiNDE2
MDIyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4gKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPiBAQCAtNDI3LDcgKzQyNyw2IEBAIHN0YXRp
YyB2b2lkIG52bWVfcmVxdWV1ZV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgIAo+
ICAgaW50IG52bWVfbXBhdGhfYWxsb2NfZGlzayhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1
Y3QgbnZtZV9uc19oZWFkICpoZWFkKQo+ICAgewo+IC0Jc3RydWN0IHJlcXVlc3RfcXVldWUgKnE7
Cj4gICAJYm9vbCB2d2MgPSBmYWxzZTsKPiAgIAo+ICAgCW11dGV4X2luaXQoJmhlYWQtPmxvY2sp
Owo+IEBAIC00NDMsMzMgKzQ0MiwyNCBAQCBpbnQgbnZtZV9tcGF0aF9hbGxvY19kaXNrKHN0cnVj
dCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQpCj4gICAJaWYgKCEo
Y3RybC0+c3Vic3lzLT5jbWljICYgTlZNRV9DVFJMX0NNSUNfTVVMVElfQ1RSTCkgfHwgIW11bHRp
cGF0aCkKPiAgIAkJcmV0dXJuIDA7Cj4gICAKPiAtCXEgPSBibGtfYWxsb2NfcXVldWUoY3RybC0+
bnVtYV9ub2RlKTsKPiAtCWlmICghcSkKPiAtCQlnb3RvIG91dDsKPiAtCWJsa19xdWV1ZV9mbGFn
X3NldChRVUVVRV9GTEFHX05PTlJPVCwgcSk7Cj4gLQkvKiBzZXQgdG8gYSBkZWZhdWx0IHZhbHVl
IGZvciA1MTIgdW50aWwgZGlzayBpcyB2YWxpZGF0ZWQgKi8KPiAtCWJsa19xdWV1ZV9sb2dpY2Fs
X2Jsb2NrX3NpemUocSwgNTEyKTsKPiAtCWJsa19zZXRfc3RhY2tpbmdfbGltaXRzKCZxLT5saW1p
dHMpOwo+IC0KPiAtCS8qIHdlIG5lZWQgdG8gcHJvcGFnYXRlIHVwIHRoZSBWTUMgc2V0dGluZ3Mg
Ki8KPiAtCWlmIChjdHJsLT52d2MgJiBOVk1FX0NUUkxfVldDX1BSRVNFTlQpCj4gLQkJdndjID0g
dHJ1ZTsKPiAtCWJsa19xdWV1ZV93cml0ZV9jYWNoZShxLCB2d2MsIHZ3Yyk7Cj4gLQo+IC0JaGVh
ZC0+ZGlzayA9IGFsbG9jX2Rpc2soMCk7Cj4gKwloZWFkLT5kaXNrID0gYmxrX2FsbG9jX2Rpc2so
Y3RybC0+bnVtYV9ub2RlKTsKPiAgIAlpZiAoIWhlYWQtPmRpc2spCj4gLQkJZ290byBvdXRfY2xl
YW51cF9xdWV1ZTsKPiArCQlyZXR1cm4gLUVOT01FTTsKPiAgIAloZWFkLT5kaXNrLT5mb3BzID0g
Jm52bWVfbnNfaGVhZF9vcHM7Cj4gICAJaGVhZC0+ZGlzay0+cHJpdmF0ZV9kYXRhID0gaGVhZDsK
PiAtCWhlYWQtPmRpc2stPnF1ZXVlID0gcTsKPiAgIAlzcHJpbnRmKGhlYWQtPmRpc2stPmRpc2tf
bmFtZSwgIm52bWUlZG4lZCIsCj4gICAJCQljdHJsLT5zdWJzeXMtPmluc3RhbmNlLCBoZWFkLT5p
bnN0YW5jZSk7Cj4gLQlyZXR1cm4gMDsKPiAgIAo+IC1vdXRfY2xlYW51cF9xdWV1ZToKPiAtCWJs
a19jbGVhbnVwX3F1ZXVlKHEpOwo+IC1vdXQ6Cj4gLQlyZXR1cm4gLUVOT01FTTsKPiArCWJsa19x
dWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX05PTlJPVCwgaGVhZC0+ZGlzay0+cXVldWUpOwo+ICsJ
Lyogc2V0IHRvIGEgZGVmYXVsdCB2YWx1ZSBvZiA1MTIgdW50aWwgdGhlIGRpc2sgaXMgdmFsaWRh
dGVkICovCj4gKwlibGtfcXVldWVfbG9naWNhbF9ibG9ja19zaXplKGhlYWQtPmRpc2stPnF1ZXVl
LCA1MTIpOwo+ICsJYmxrX3NldF9zdGFja2luZ19saW1pdHMoJmhlYWQtPmRpc2stPnF1ZXVlLT5s
aW1pdHMpOwo+ICsKPiArCS8qIHdlIG5lZWQgdG8gcHJvcGFnYXRlIHVwIHRoZSBWTUMgc2V0dGlu
Z3MgKi8KPiArCWlmIChjdHJsLT52d2MgJiBOVk1FX0NUUkxfVldDX1BSRVNFTlQpCj4gKwkJdndj
ID0gdHJ1ZTsKPiArCWJsa19xdWV1ZV93cml0ZV9jYWNoZShoZWFkLT5kaXNrLT5xdWV1ZSwgdndj
LCB2d2MpOwo+ICsJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIG52bWVfbXBh
dGhfc2V0X2xpdmUoc3RydWN0IG52bWVfbnMgKm5zKQo+IEBAIC03NjgsMTYgKzc1OCw3IEBAIHZv
aWQgbnZtZV9tcGF0aF9yZW1vdmVfZGlzayhzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkKQo+ICAg
CS8qIG1ha2Ugc3VyZSBhbGwgcGVuZGluZyBiaW9zIGFyZSBjbGVhbmVkIHVwICovCj4gICAJa2Js
b2NrZF9zY2hlZHVsZV93b3JrKCZoZWFkLT5yZXF1ZXVlX3dvcmspOwo+ICAgCWZsdXNoX3dvcmso
JmhlYWQtPnJlcXVldWVfd29yayk7Cj4gLQlibGtfY2xlYW51cF9xdWV1ZShoZWFkLT5kaXNrLT5x
dWV1ZSk7Cj4gLQlpZiAoIXRlc3RfYml0KE5WTUVfTlNIRUFEX0RJU0tfTElWRSwgJmhlYWQtPmZs
YWdzKSkgewo+IC0JCS8qCj4gLQkJICogaWYgZGV2aWNlX2FkZF9kaXNrIHdhc24ndCBjYWxsZWQs
IHByZXZlbnQKPiAtCQkgKiBkaXNrIHJlbGVhc2UgdG8gcHV0IGEgYm9ndXMgcmVmZXJlbmNlIG9u
IHRoZQo+IC0JCSAqIHJlcXVlc3QgcXVldWUKPiAtCQkgKi8KPiAtCQloZWFkLT5kaXNrLT5xdWV1
ZSA9IE5VTEw7Cj4gLQl9Cj4gLQlwdXRfZGlzayhoZWFkLT5kaXNrKTsKPiArCWJsa19jbGVhbnVw
X2Rpc2soaGVhZC0+ZGlzayk7Cj4gICB9Cj4gICAKPiAgIHZvaWQgbnZtZV9tcGF0aF9pbml0X2N0
cmwoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiAKV2hhdCBhYm91dCB0aGUgY2hlY2sgZm9yIEdF
TkhEX0ZMX1VQIGEgYml0IGZ1cnRoZXIgdXAgaW4gbGluZSA3NjY/CkNhbiB0aGlzIHN0aWxsIGhh
cHBlbiB3aXRoIHRoZSBuZXcgYWxsb2NhdGlvbiBzY2hlbWUsIGllIGlzIHRoZXJlIHN0aWxsIAph
IGRpZmZlcmVuY2UgaW4gbGlmZXRpbWUgYmV0d2VlbiAtPmRpc2sgYW5kIC0+ZGlzay0+cXVldWU/
CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAg
S2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgs
IE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyks
IEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
