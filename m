Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338F7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:49:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA3C60201
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA3C60201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qK+ANqrN4wQWWmWrNpUn0d4R1Zm0BS+zagjYae6TMa0=; b=Juqe+d7zW+8kdznMj4c2vxHI1
	b/lL8SQLZCSOB94aAbrmMUPEko78Ulou+xesjPIwWFJaJRI3IQMk6JUUpmFOICxsWsE9RBxJiugKj
	67ZPG8wbEVpySfmXi5L6aVpuI3aYyAFVa8UeLdmpxG+VuR70a9H8uOJxzLFwprz3jI/ggXxFObc+0
	cvG3GtuPPVPG363gC3vIYUGqOXamvapSy9kbqL+gtld3sgy/mcxZpjkPbpqu8/ESAymuQiFP1CLdU
	nhkRtkqCDZB9u9opPUG/SzzpMEMAjDw+1QITBv/hmONimV8Q8vl/DKLqkI68Nhcs3CImvcI5b2t3y
	yRUX/gn5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHnPb-008f73-9R; Thu, 04 Mar 2021 12:49:03 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHnOW-008eyr-HT
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:48:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CDEF6ACBF;
 Thu,  4 Mar 2021 12:47:55 +0000 (UTC)
Subject: Re: [PATCH v8 14/16] lpfc: vmid: Adding qfpa and vmid timeout check
 in worker thread
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-15-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <bb4e6bc9-0e1c-38e0-5977-47469489e9a5@suse.de>
Date: Thu, 4 Mar 2021 13:47:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-15-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
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

T24gMy80LzIxIDY6MjcgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBGcm9tOiBHYXVyYXYgU3JpdmFz
dGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoaXMgcGF0Y2ggYWRk
IHRoZSBwZXJpb2RpYyBjaGVjayBmb3IgaXNzdWluZyBvZiBxZnBhIGNvbW1hbmQgYW5kIHZtaWQK
PiB0aW1lb3V0IGluIHRoZSB3b3JrZXIgdGhyZWFkLiBUaGUgaW5hY3Rpdml0eSB0aW1lb3V0IGNo
ZWNrIGlzIGFkZGVkIHZpYQo+IHRoZSB0aW1lciBmdW5jdGlvbi4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBHYXVyYXYgU3JpdmFzdGF2YSAgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gCj4gLS0t
Cj4gdjg6Cj4gY2hlY2tlZCB0aGUgZnVuY3Rpb24gcmV0dXJuIHZhbHVlCj4gCj4gdjc6Cj4gTm8g
Y2hhbmdlCj4gCj4gdjY6Cj4gQWRkZWQgRm9yd2FyZCBkZWNsYXJhdGlvbnMgYW5kIHJlbW92ZWQg
dW51c2VkIHZhcmlhYmxlCj4gCj4gdjU6Cj4gTm8gY2hhbmdlCj4gCj4gdjQ6Cj4gTm8gY2hhbmdl
Cj4gCj4gdjM6Cj4gTm8gY2hhbmdlCj4gCj4gdjI6Cj4gUG9ydGVkIHRoZSBwYXRjaCBvbiB0b3Ag
b2YgNS4xMC9zY3NpLXF1ZXVlCj4gLS0tCj4gICBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2hiYWRp
c2MuYyB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hh
bmdlZCwgNDMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvbHBm
Yy9scGZjX2hiYWRpc2MuYyBiL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfaGJhZGlzYy5jCj4gaW5k
ZXggYzQ1MTlmNjM0OWJjLi5jODA3MzAyYTc4MmQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zY3Np
L2xwZmMvbHBmY19oYmFkaXNjLmMKPiArKysgYi9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX2hiYWRp
c2MuYwo+IEBAIC03Myw2ICs3Myw3IEBAIHN0YXRpYyB2b2lkIGxwZmNfdW5yZWdpc3Rlcl9mY2Zp
X2NtcGwoc3RydWN0IGxwZmNfaGJhICosIExQRkNfTUJPWFFfdCAqKTsKPiAgIHN0YXRpYyBpbnQg
bHBmY19mY2ZfaW51c2Uoc3RydWN0IGxwZmNfaGJhICopOwo+ICAgc3RhdGljIHZvaWQgbHBmY19t
YnhfY21wbF9yZWFkX3NwYXJhbShzdHJ1Y3QgbHBmY19oYmEgKiwgTFBGQ19NQk9YUV90ICopOwo+
ICAgc3RhdGljIHZvaWQgbHBmY19jaGVja19pbmFjdGl2ZV92bWlkKHN0cnVjdCBscGZjX2hiYSAq
cGhiYSk7Cj4gK3N0YXRpYyB2b2lkIGxwZmNfY2hlY2tfdm1pZF9xZnBhX2lzc3VlKHN0cnVjdCBs
cGZjX2hiYSAqcGhiYSk7Cj4gICAKPiAgIHN0YXRpYyBpbnQKPiAgIGxwZmNfdmFsaWRfeHB0X25v
ZGUoc3RydWN0IGxwZmNfbm9kZWxpc3QgKm5kbHApCj4gQEAgLTQzOSw2ICs0NDAsMzIgQEAgbHBm
Y19kZXZfbG9zc190bW9faGFuZGxlcihzdHJ1Y3QgbHBmY19ub2RlbGlzdCAqbmRscCkKPiAgIAly
ZXR1cm4gZmNmX2ludXNlOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIGxwZmNfY2hlY2tfdm1p
ZF9xZnBhX2lzc3VlKHN0cnVjdCBscGZjX2hiYSAqcGhiYSkKPiArewo+ICsJc3RydWN0IGxwZmNf
dnBvcnQgKnZwb3J0Owo+ICsJc3RydWN0IGxwZmNfdnBvcnQgKip2cG9ydHM7Cj4gKwlpbnQgaTsK
PiArCj4gKwl2cG9ydHMgPSBscGZjX2NyZWF0ZV92cG9ydF93b3JrX2FycmF5KHBoYmEpOwo+ICsJ
aWYgKCF2cG9ydHMpCj4gKwkJcmV0dXJuOwo+ICsKPiArCWZvciAoaSA9IDA7IGkgPD0gcGhiYS0+
bWF4X3Zwb3J0czsgaSsrKSB7Cj4gKwkJaWYgKCghdnBvcnRzW2ldKSAmJiAoaSA9PSAwKSkKPiAr
CQkJdnBvcnQgPSBwaGJhLT5wcG9ydDsKPiArCQllbHNlCj4gKwkJCXZwb3J0ID0gdnBvcnRzW2ld
Owo+ICsJCWlmICghdnBvcnQpCj4gKwkJCWJyZWFrOwo+ICsKPiArCQlpZiAodnBvcnQtPnZtaWRf
ZmxhZyAmIExQRkNfVk1JRF9JU1NVRV9RRlBBKSB7Cj4gKwkJCWlmICghbHBmY19pc3N1ZV9lbHNf
cWZwYSh2cG9ydCkpCj4gKwkJCQl2cG9ydC0+dm1pZF9mbGFnICY9IH5MUEZDX1ZNSURfSVNTVUVf
UUZQQTsKPiArCQl9Cj4gKwl9Cj4gKwlscGZjX2Rlc3Ryb3lfdnBvcnRfd29ya19hcnJheShwaGJh
LCB2cG9ydHMpOwo+ICt9Cj4gKwo+ICAgLyoqCj4gICAgKiBscGZjX3NsaTRfcG9zdF9kZXZfbG9z
c190bW9faGFuZGxlciAtIFNMSTQgcG9zdCBkZXZsb3NzIHRpbWVvdXQgaGFuZGxlcgo+ICAgICog
QHBoYmE6IFBvaW50ZXIgdG8gaGJhIGNvbnRleHQgb2JqZWN0Lgo+IEBAIC03NTksNiArNzg2LDIy
IEBAIGxwZmNfd29ya19kb25lKHN0cnVjdCBscGZjX2hiYSAqcGhiYSkKPiAgIAlpZiAoaGFfY29w
eSAmIEhBX0xBVFQpCj4gICAJCWxwZmNfaGFuZGxlX2xhdHQocGhiYSk7Cj4gICAKPiArCS8qIEhh
bmRsZSBWTUlEIEV2ZW50cyAqLwo+ICsJaWYgKGxwZmNfaXNfdm1pZF9lbmFibGVkKHBoYmEpKSB7
Cj4gKwkJaWYgKHBoYmEtPnBwb3J0LT53b3JrX3BvcnRfZXZlbnRzICYKPiArCQkgICAgV09SS0VS
X0NIRUNLX1ZNSURfSVNTVUVfUUZQQSkgewo+ICsJCQlscGZjX2NoZWNrX3ZtaWRfcWZwYV9pc3N1
ZShwaGJhKTsKPiArCQkJcGhiYS0+cHBvcnQtPndvcmtfcG9ydF9ldmVudHMgJj0KPiArCQkJCX5X
T1JLRVJfQ0hFQ0tfVk1JRF9JU1NVRV9RRlBBOwo+ICsJCX0KPiArCQlpZiAocGhiYS0+cHBvcnQt
PndvcmtfcG9ydF9ldmVudHMgJgo+ICsJCSAgICBXT1JLRVJfQ0hFQ0tfSU5BQ1RJVkVfVk1JRCkg
ewo+ICsJCQlscGZjX2NoZWNrX2luYWN0aXZlX3ZtaWQocGhiYSk7Cj4gKwkJCXBoYmEtPnBwb3J0
LT53b3JrX3BvcnRfZXZlbnRzICY9Cj4gKwkJCSAgICB+V09SS0VSX0NIRUNLX0lOQUNUSVZFX1ZN
SUQ7Cj4gKwkJfQo+ICsJfQo+ICsKPiAgIAkvKiBQcm9jZXNzIFNMSTQgZXZlbnRzICovCj4gICAJ
aWYgKHBoYmEtPnBjaV9kZXZfZ3JwID09IExQRkNfUENJX0RFVl9PQykgewo+ICAgCQlpZiAocGhi
YS0+aGJhX2ZsYWcgJiBIQkFfUlJRX0FDVElWRSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWlu
ZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5l
Y2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2
ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVy
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
