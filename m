Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F7DC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 10:04:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDCA22257
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 10:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v53doH2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDCA22257
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+qlUv81qBkFvDoOp5W592em9V1OYPJ187uoq61C3m4c=; b=v53doH2yOzvcmTA90Uq1zMWt3
	SRTeEL7IniwvTlO86R20LHpP/QE4zF2oqVHmdWLVhNA9vIwSidsDGQoFu3KAeerazhgY3AIxel2X+
	ch4Ox0dM7Kc0nf25dFN9ZYAILESx1AAu8RVOzNR3wFMVVqJpOTxPsM/dfRBvJdi/+NBBmK4HU3d6e
	AfvJu0fUCnCD/OsWXbECjj9aBu1SES0KuVnebo9YOoW7SVsVyVRYxhd6QNBBP6QjUl2lAhyLz0Fyj
	6zn+LQR9fkVcweW1NM7zf20J5e/uMK/J6KuOzKG/hbtIXY/WtoZISFQSWJDvyAPNkwrm6RQyQVLT4
	dEm+KAOCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUS1O-0000mH-H5; Mon, 19 Oct 2020 10:04:06 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUS1L-0000lG-4d
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 10:04:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EA10EAEAB;
 Mon, 19 Oct 2020 10:04:00 +0000 (UTC)
Subject: Re: [PATCH] nvme-fc: fix error loop in create_hw_io_queues
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20201016210604.48542-1-james.smart@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a49f995b-d256-51f9-e004-e975fab81104@suse.de>
Date: Mon, 19 Oct 2020 12:04:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201016210604.48542-1-james.smart@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_060403_289657_B943C744 
X-CRM114-Status: GOOD (  21.69  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvMTYvMjAgMTE6MDYgUE0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IFRoZSBsb29wIHRoYXQg
YmFja3Mgb3V0IG9mIGh3IGlvIHF1ZXVlIGNyZWF0aW9uIGNvbnRpbnVlcyB0aHJvdWdoIGluZGV4
Cj4gMCwgd2hpY2ggY29ycmVzcG9uZHMgdG8gdGhlIGFkbWluIHF1ZXVlIGFzIHdlbGwuCj4gCj4g
Rml4IHRoZSBsb29wIHNvIGl0IG9ubHkgcHJvY2VlZHMgdGhyb3VnaCBpbmRleGVzIDEuLm4gd2hp
Y2ggY29ycmVzcG9uZCB0bwo+IGlvIHF1ZXVlcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBT
bWFydCA8amFtZXMuc21hcnRAYnJvYWRjb20uY29tPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hv
c3QvZmMuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYy5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvZmMuYwo+IGluZGV4IGUyZTA5ZTI1YzA1Ni4uZjAwMjUyMjE0NmUyIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9mYy5jCj4gQEAgLTIzMTQsNyArMjMxNCw3IEBAIG52bWVfZmNfY3JlYXRlX2h3X2lvX3F1ZXVl
cyhzdHJ1Y3QgbnZtZV9mY19jdHJsICpjdHJsLCB1MTYgcXNpemUpCj4gICAJcmV0dXJuIDA7Cj4g
ICAKPiAgIGRlbGV0ZV9xdWV1ZXM6Cj4gLQlmb3IgKDsgaSA+PSAwOyBpLS0pCj4gKwlmb3IgKDsg
aSA+IDA7IGktLSkKPiAgIAkJX19udm1lX2ZjX2RlbGV0ZV9od19xdWV1ZShjdHJsLCAmY3RybC0+
cXVldWVzW2ldLCBpKTsKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+IAo+IApSZXZpZXdlZC1ieTog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBI
YW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cmhh
cmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJ
bWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
