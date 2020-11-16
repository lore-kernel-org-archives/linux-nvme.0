Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B1C55ABD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:52:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BE12225E
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LIzFb9I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BE12225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=naZAOTu8RO0pri/BpuXvJpLV8My0smkLe9XQ2cOL4N0=; b=LIzFb9I5eJfgjlyDY0Dj3W/Rn
	sQb/ONG77V6mEhWfDDBDv/kVZbYtAYqjePRD9XnDlaW1SGlGBV/u5uHdGgUrNcZhIg09JmP0G5jte
	onTbdXRxAEQFL2U6c2zjk3P1oa2Bsw6voqRE9Be4ICjvuRWYrQJmBnXi9K/Q5UGuK6x/NiQ0oFTjh
	xsTgsdPfRE5uRVHt2LdJzbDigQ3NPotVfTlBJClf0lfMH4417Py1GlKk0eHSK0UyAblc1UuqTtguo
	eUTJTCDVRKXeK4emPC/8+oGHHoH2HzBXxLv0NNEXA++rQO0RixJXonv0GngqdmbSYUABdwSIW03RV
	0bjf65T6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZJL-0005xw-Ds; Mon, 16 Nov 2020 07:52:27 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZJI-0005x7-OP
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 07:52:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9B8CAAC55;
 Mon, 16 Nov 2020 07:52:23 +0000 (UTC)
Subject: Re: [PATCH v4 08/19] lpfc: vmid: Add support for vmid in mailbox
 command
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-9-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4a0a6ff2-f2ec-bccf-4c65-f0182fa9f3c9@suse.de>
Date: Mon, 16 Nov 2020 08:52:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-9-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_025224_966851_8CD701A5 
X-CRM114-Status: GOOD (  22.65  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA1OjIzIEFNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gRnJvbTogR2F1cmF2IFNyaXZh
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGFk
ZHMgc3VwcG9ydGluZyBkYXRhc3RydWN0dXJlcyBmb3IgbWFpbGJveCBjb21tYW5kIHdoaWNoIGhl
bHBzCj4gaW4gZGV0ZXJtaW5pbmcgaWYgdGhlIGZpcm13YXJlIHN1cHBvcnRzIGFwcGlkIG9yIG5v
dC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBHYXVyYXYgU3JpdmFzdGF2YSAgPGdhdXJhdi5zcml2YXN0
YXZhQGJyb2FkY29tLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAy
MUBnbWFpbC5jb20+Cj4gCj4gLS0tCj4gdjQ6Cj4gTm8gY2hhbmdlCj4gCj4gdjM6Cj4gTm8gY2hh
bmdlCj4gCj4gdjI6Cj4gUG9ydGVkIHRoZSBwYXRjaCBvbiB0b3Agb2YgNS4xMC9zY3NpLXF1ZXVl
Cj4gLS0tCj4gICBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2h3NC5oIHwgMTIgKysrKysrKysrKysr
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Njc2kvbHBmYy9scGZjX2h3NC5oIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19odzQu
aAo+IGluZGV4IDEyZTRlNzYyMzNlNi4uNzZjMDcyMzY2YTE2IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvc2NzaS9scGZjL2xwZmNfaHc0LmgKPiArKysgYi9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX2h3
NC5oCj4gQEAgLTI3Miw2ICsyNzIsOSBAQCBzdHJ1Y3QgbHBmY19zbGk0X2ZsYWdzIHsKPiAgICNk
ZWZpbmUgbHBmY192ZmlfcnNyY19yZHlfTUFTSwkJMHgwMDAwMDAwMQo+ICAgI2RlZmluZSBscGZj
X3ZmaV9yc3JjX3JkeV9XT1JECQl3b3JkMAo+ICAgI2RlZmluZSBMUEZDX1ZGSV9SU1JDX1JEWQkJ
MQo+ICsjZGVmaW5lIGxwZmNfZnRyX2FzaGRyX1NISUZUICAgICAgICAgICAgNAo+ICsjZGVmaW5l
IGxwZmNfZnRyX2FzaGRyX01BU0sgICAgICAgICAgICAgMHgwMDAwMDAwMQo+ICsjZGVmaW5lIGxw
ZmNfZnRyX2FzaGRyX1dPUkQgICAgICAgICAgICAgd29yZDAKPiAgIH07Cj4gICAKPiAgIHN0cnVj
dCBzbGk0X2Jsc19yc3Agewo+IEBAIC0yOTQzLDYgKzI5NDYsOSBAQCBzdHJ1Y3QgbHBmY19tYnhf
cmVxdWVzdF9mZWF0dXJlcyB7Cj4gICAjZGVmaW5lIGxwZmNfbWJ4X3JxX2Z0cl9ycV9tcnFwX1NI
SUZUCQkxNgo+ICAgI2RlZmluZSBscGZjX21ieF9ycV9mdHJfcnFfbXJxcF9NQVNLCQkweDAwMDAw
MDAxCj4gICAjZGVmaW5lIGxwZmNfbWJ4X3JxX2Z0cl9ycV9tcnFwX1dPUkQJCXdvcmQyCj4gKyNk
ZWZpbmUgbHBmY19tYnhfcnFfZnRyX3JxX2FzaGRyX1NISUZUICAgICAgICAgIDE3Cj4gKyNkZWZp
bmUgbHBmY19tYnhfcnFfZnRyX3JxX2FzaGRyX01BU0sgICAgICAgICAgIDB4MDAwMDAwMDEKPiAr
I2RlZmluZSBscGZjX21ieF9ycV9mdHJfcnFfYXNoZHJfV09SRCAgICAgICAgICAgd29yZDIKPiAg
IAl1aW50MzJfdCB3b3JkMzsKPiAgICNkZWZpbmUgbHBmY19tYnhfcnFfZnRyX3JzcF9pYWFiX1NI
SUZUCQkwCj4gICAjZGVmaW5lIGxwZmNfbWJ4X3JxX2Z0cl9yc3BfaWFhYl9NQVNLCQkweDAwMDAw
MDAxCj4gQEAgLTI5NzQsNiArMjk4MCw5IEBAIHN0cnVjdCBscGZjX21ieF9yZXF1ZXN0X2ZlYXR1
cmVzIHsKPiAgICNkZWZpbmUgbHBmY19tYnhfcnFfZnRyX3JzcF9tcnFwX1NISUZUCQkxNgo+ICAg
I2RlZmluZSBscGZjX21ieF9ycV9mdHJfcnNwX21ycXBfTUFTSwkJMHgwMDAwMDAwMQo+ICAgI2Rl
ZmluZSBscGZjX21ieF9ycV9mdHJfcnNwX21ycXBfV09SRAkJd29yZDMKPiArI2RlZmluZSBscGZj
X21ieF9ycV9mdHJfcnNwX2FzaGRyX1NISUZUICAgICAgICAgMTcKPiArI2RlZmluZSBscGZjX21i
eF9ycV9mdHJfcnNwX2FzaGRyX01BU0sgICAgICAgICAgMHgwMDAwMDAwMQo+ICsjZGVmaW5lIGxw
ZmNfbWJ4X3JxX2Z0cl9yc3BfYXNoZHJfV09SRCAgICAgICAgICB3b3JkMwo+ICAgfTsKPiAgIAo+
ICAgc3RydWN0IGxwZmNfbWJ4X3N1cHBfcGFnZXMgewo+IEBAIC00MzgzLDYgKzQzOTIsOSBAQCBz
dHJ1Y3Qgd3FlX2NvbW1vbiB7Cj4gICAjZGVmaW5lIHdxZV9udm1lX1NISUZUICAgICAgICA0Cj4g
ICAjZGVmaW5lIHdxZV9udm1lX01BU0sgICAgICAgICAweDAwMDAwMDAxCj4gICAjZGVmaW5lIHdx
ZV9udm1lX1dPUkQgICAgICAgICB3b3JkMTAKPiArI2RlZmluZSB3cWVfYXBwaWRfU0hJRlQgICAg
ICAgNQo+ICsjZGVmaW5lIHdxZV9hcHBpZF9NQVNLICAgICAgICAweDAwMDAwMDAxCj4gKyNkZWZp
bmUgd3FlX2FwcGlkX1dPUkQgICAgICAgIHdvcmQxMAo+ICAgI2RlZmluZSB3cWVfb2FzX1NISUZU
ICAgICAgICAgNgo+ICAgI2RlZmluZSB3cWVfb2FzX01BU0sgICAgICAgICAgMHgwMDAwMDAwMQo+
ICAgI2RlZmluZSB3cWVfb2FzX1dPUkQgICAgICAgICAgd29yZDEwCj4gClBsZWFzZSBtZXJnZSBp
dCB3aXRoIHBhdGNoIDEwLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
ICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5
IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
