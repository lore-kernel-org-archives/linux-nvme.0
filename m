Return-Path: <SRS0=60sM=IA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C943FC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 07:10:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A1D64DE8
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 07:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A1D64DE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1Tvl3vbqHT9nzlNLB74UDbDMxyyAzK2sxKNEVELaqJk=; b=lgkOhspqH7W6QLgWCos51MGmw
	F9rxA6S7TdpJlWMk8+d+FJmtJevnHy6MyZyMS9Y0IG8+etUuKXRVCAJkamcfDEHbaxO6TPmxRZQZ+
	UD/n6xNHz9044b+oOWoin4nRZNw8HYufh75UklD64QxsfRPEudyIBd/j9NvtyzZUoXwI0TDbnMZXl
	cB4q13pRb0zz3ZZw2gpImFhAX6qbpmAM1cxDeSWzZl8j74BKpaYihByzekN6hS0m1fpzbIRUdGNdL
	Ui0xoCuSwcr98PYXttOwAN9C8LE/2nB2OV80Zf9FXiRKi46oXzjJ0rEiXxIPNz/Or2juWnzHyjCvw
	BfVZssL9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGzAC-0004H5-7w; Tue, 02 Mar 2021 07:09:48 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGzA5-0004Gi-Hw
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 07:09:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9AFF1AFDC;
 Tue,  2 Mar 2021 07:09:39 +0000 (UTC)
To: James Smart <jsmart2021@gmail.com>, Christoph Hellwig <hch@lst.de>
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-5-hare@suse.de>
 <0611f10e-fb76-faad-caa8-a069ae415ffa@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/4] nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a
 command has been aborted
Message-ID: <2df43917-3ff2-b2dd-cc54-0aee7ebffaea@suse.de>
Date: Tue, 2 Mar 2021 08:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0611f10e-fb76-faad-caa8-a069ae415ffa@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_020941_755761_B4193706 
X-CRM114-Status: GOOD (  22.54  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xLzIxIDg6MDcgUE0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IE9uIDIvMjUvMjAyMSAxMTox
NyBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBXaGVuIGEgY29tbWFuZCBoYXMgYmVlbiBh
Ym9ydGVkIHdlIHNob3VsZCByZXR1cm4gTlZNRV9TQ19IT1NUX0FCT1JURURfQ01ECj4+IHRvIGJl
IGNvbnNpc3RlbnQgd2l0aCB0aGUgb3RoZXIgdHJhbnNwb3J0cy4KPj4KPj4gQ2M6IEphbWVzIFNt
YXJ0IDxqYW1lcy5zbWFydEBicm9hZGNvbS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBS
ZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+PiBSZXZpZXdlZC1ieTogRGFuaWVsIFdhZ25lciA8ZHdh
Z25lckBzdXNlLmRlPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvZmMuYyB8IDIgKy0K
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYy5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
ZmMuYwo+PiBpbmRleCBlZjEyYTYxOWRhZWMuLjk3ZTM0MjRjN2IwMyAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4+
IEBAIC0xOTU2LDcgKzE5NTYsNyBAQCBudm1lX2ZjX2ZjcGlvX2RvbmUoc3RydWN0IG52bWVmY19m
Y3BfcmVxICpyZXEpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9m
KG9wLT5yc3BfaXUpLCBETUFfRlJPTV9ERVZJQ0UpOwo+PiDCoCDCoMKgwqDCoMKgIGlmIChvcHN0
YXRlID09IEZDUE9QX1NUQVRFX0FCT1JURUQpCj4+IC3CoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBj
cHVfdG9fbGUxNihOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUiA8PCAxKTsKPj4gK8KgwqDCoMKgwqDC
oMKgIHN0YXR1cyA9IGNwdV90b19sZTE2KE5WTUVfU0NfSE9TVF9BQk9SVEVEX0NNRCA8PCAxKTsK
Pj4gwqDCoMKgwqDCoCBlbHNlIGlmIChmcmVxLT5zdGF0dXMpIHsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHN0YXR1cyA9IGNwdV90b19sZTE2KE5WTUVfU0NfSE9TVF9QQVRIX0VSUk9SIDw8IDEpOwo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2luZm8oY3RybC0+Y3RybC5kZXZpY2UsCj4gCj4gSXMg
dGhlcmUgYSBkaWZmZXJlbmNlIGJldHdlZW4gYW4gSS9PIGFib3J0ZWQgYnkgYSBOVk1FIEFCT1JU
IGNtZCB2cyBhCj4gdHJhbnNwb3J0LWNhbmNlbGxlZCBpbyA/wqDCoCBUaGlzIGxpbmUgaXMgbW9y
ZSB0aGUgdHJhbnNwb3J0LWNhbmNlbGxlZCBpby4KPiAKV2VsbCwgYXMgd2UgaGF2ZSBzZXZlcmFs
IGRpc3RpbmN0IGVycm9yIGNvZGVzIGZvciB0aGF0OgoKMHgwNyAoQ29tbWFuZCBhYm9ydCByZXF1
ZXN0ZWQpIGlzIGZvciBjb21tYW5kcyB0ZXJtaW5hdGVkIGJ5IE5WTUUgQWJvcnQKMHgwOCAoQ29t
bWFuZCBhYm9ydGVkIGR1ZSB0byBTUSBkZWxldGlvbikgaXMgZm9yIGNvbW1hbmRzIHRlcm1pbmF0
ZWQgZHVlCnRvIGFuIGV4cGxpY2l0ICdEZWxldGUgSS9PIHN1Ym1pc3Npb24gcXVldWUnIGNvbW1h
bmQKMHgzNzAgKEhvc3QgcGF0aGluZyBlcnJvcikgaXMgZm9yIGFueSByYW5kb20gaG9zdCBwYXRo
aW5nIGVycm9yCjB4MzcxIChDb21tYW5kIGFib3J0ZWQgYnkgaG9zdCkgaXMgZm9yIGNvbW1hbmRz
IGJlaW5nIGFib3J0ZWQgJ2FzIGEKcmVzdWx0IG9mIGEgaG9zdCBhY3Rpb24nCgphcmd1YWJseSBi
b3RoICgweDM3MCBhbmQgMHgzNzEpIGNhbiBiZSB1c2VkIHdoZW4gZmFpbGluZyBJL08gb24gcGF0
aApsb3NzLCBidXQgYWxsIG90aGVyIHRyYW5zcG9ydHMgYXJlIHVzaW5nIDB4MzcxIGhlcmUsIHNv
IEZDIHJlYWxseSBzaG91bGQKYmUgdXNpbmcgdGhlIHNhbWUgY29udmVudGlvbiB0byBoYXZlIGNv
bnNpc3RlbnQgZXJyb3IgaGFuZGxpbmcuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5k
ZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAz
NjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
