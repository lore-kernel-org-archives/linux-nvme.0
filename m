Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B39C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:44:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAF22225E
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="szjZ0u87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAF22225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PlfJLKToFaq7wSInz+gUjlSfepTWpBRbl9hdep9qRic=; b=szjZ0u87Pmm5g+3C2NYHwd7A1
	MBvBWkezHy594P9aUx4Fvr3rxz3kAKzg5GWINU41UhmqQlt4sbRsjSMLNtg6gTvMbxGHF/0R/JgFN
	cNLxzOx+bkGa/kOb8VJJn2Y2y7gMB1lOJ8FkwnL9Y4bNGuY9VQCFCjxscCTEKvwItYiuszek+tFA4
	21ohj02C9KoOe0gtWUpac048gLrbntDmV2Z53fWSi/0MHyOeMp0cHWuV1lmjnDvUvW1bQdntq7e1F
	yVBDnTMy8cE7FtSA6u8XzPaxNvdYAPvtXvwaKmC0C1v+cLA9RCLf30UyXUYof7RzBLZWGO0fMJw0d
	kGSJrtYcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZBK-0004zo-7s; Mon, 16 Nov 2020 07:44:10 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZBI-0004zR-Nq
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 07:44:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B355BAC54;
 Mon, 16 Nov 2020 07:44:07 +0000 (UTC)
Subject: Re: [PATCH v4 05/19] lpfc: vmid: API to check if VMID is enabled.
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-6-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <60c0e014-81b1-2679-4e68-6cefa0604628@suse.de>
Date: Mon, 16 Nov 2020 08:44:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-6-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_024408_927439_64BA32F4 
X-CRM114-Status: GOOD (  24.39  )
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
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIEFQSSB3aWxs
IGRldGVybWluZSBpZiBWTUlEIGlzIGVuYWJsZWQgYnkgdGhlIHVzZXIgb3Igbm90Lgo+IAo+IFNp
Z25lZC1vZmYtYnk6IEdhdXJhdiBTcml2YXN0YXZhICA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRj
b20uY29tPgo+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFNtYXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNv
bT4KPiAKPiAtLS0KPiB2NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBObyBjaGFuZ2UKPiAKPiB2
MjoKPiBQb3J0ZWQgdGhlIHBhdGNoIG9uIHRvcCBvZiA1LjEwL3Njc2ktcXVldWUKPiAtLS0KPiAg
IGRyaXZlcnMvc2NzaS9scGZjL2xwZmMuaCB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKwo+
ICAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zY3NpL2xwZmMvbHBmYy5oIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmYy5oCj4gaW5kZXgg
OGYwMDYyZDJiODkxLi5hNjJlOTg1YWExODAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zY3NpL2xw
ZmMvbHBmYy5oCj4gKysrIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmYy5oCj4gQEAgLTE1MDYsMyAr
MTUwNiwyNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqcm91dGluZShlbnVtIGVudW1fbmFtZSB0YWJs
ZV9rZXkpCQkJXAo+ICAgCX0JCQkJCQkJCVwKPiAgIAlyZXR1cm4gbmFtZTsJCQkJCQkJXAo+ICAg
fQo+ICsKPiArLyoqCj4gKyAqIGxwZmNfaXNfdm1pZF9lbmFibGVkIC0gcmV0dXJucyBpZiBWTUlE
IGlzIGVuYWJsZWQgZm9yIGVpdGhlciBzd2l0Y2ggdHlwZXMKPiArICogQHBoYmE6IFBvaW50ZXIg
dG8gSEJBIGNvbnRleHQgb2JqZWN0Lgo+ICsgKgo+ICsgKiBSZWxhdGlvbnNoaXAgYmV0d2VlbiB0
aGUgZW5hYmxlLCB0YXJnZXQgc3VwcG9ydCBhbmQgaWYgdm1pZCB0YWcgaXMgcmVxdWlyZWQKPiAr
ICogZm9yIHRoZSBwYXJ0aWN1bGFyIGNvbWJpbmF0aW9uCj4gKyAqIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICsgKiBTd2l0Y2ggICAgRW5hYmxl
IEZsYWcgIFRhcmdldCBTdXBwb3J0ICBWTUlEIE5lZWRlZAo+ICsgKiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiArICogQXBwIElkICAgICAwICAg
ICAgICAgICAgICBOQSAgICAgICAgICAgICAgTgo+ICsgKiBBcHAgSWQgICAgIDEgICAgICAgICAg
ICAgICAwICAgICAgICAgICAgICBOCj4gKyAqIEFwcCBJZCAgICAgMSAgICAgICAgICAgICAgIDEg
ICAgICAgICAgICAgIFkKPiArICogUHIgVGFnICAgICAwICAgICAgICAgICAgICBOQSAgICAgICAg
ICAgICAgTgo+ICsgKiBQciBUYWcgICAgIDEgICAgICAgICAgICAgICAwICAgICAgICAgICAgICBO
Cj4gKyAqIFByIFRhZyAgICAgMSAgICAgICAgICAgICAgIDEgICAgICAgICAgICAgIFkKPiArICog
UHIgVGFnICAgICAyICAgICAgICAgICAgICAgKiAgICAgICAgICAgICAgWQo+ICsgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gKyAqCj4gKyAqKi8K
PiArc3RhdGljIGlubGluZSBpbnQgbHBmY19pc192bWlkX2VuYWJsZWQoc3RydWN0IGxwZmNfaGJh
ICpwaGJhKQo+ICt7Cj4gKwlyZXR1cm4gcGhiYS0+Y2ZnX3ZtaWRfYXBwX2hlYWRlciB8fCBwaGJh
LT5jZmdfdm1pZF9wcmlvcml0eV90YWdnaW5nOwo+ICt9Cj4gCkZlZWxzIGEgYml0IHdlaXJkLCBo
YXZpbmcgdGhpcyBwYXRjaCBvbiBpdHMgb3duOyBtYXliZSBtZXJnZSBpdCB3aXRoIHRoZSAKbmV4
dCBvbmU/CkJ1dCBJJ20gbm90IGJvdGhlcmVkIGVpdGhlciB3YXkuCgpSZXZpZXdlZC1ieTogSGFu
bmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5u
ZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVu
ZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
