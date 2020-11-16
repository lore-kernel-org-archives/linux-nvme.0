Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D658C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:53:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB072225E
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z4P4MRKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB072225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BYX5vtUcM9/RzKT8AodFGxhXVrkRfcLqabV83rRoa/I=; b=z4P4MRKzDvgDSrhvgGhBoUX0u
	JTty2RjuqeSjsyX5GxtU22sjZfE7r0gObZYG0fJjZqnNqHNBZBgVpwcOd+53jhGaaYq7w3Jiyg9PZ
	voU4ugxUzszadaq1Bx18NSBOLflJwsKTO1G7TEpLMTyY3+zaJ88POd+MGuHPsltT6rfir67cZ0ZKE
	S4IFUrhLTS/ho65Wr1V5BPt2jqovGCs1b8qGWJxe8QmCoQ9Xo2QlGwRGy1Ufe2IKyATnMt9KhCcgh
	3ENHHOOP5Ch2DqJLPpBF2le93Dib0SVDZ5R7FqC2hLtwuMu/2xrLVDJbhTDdexNk3EW26vkrEzrN+
	pHbYVuSQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZK8-000685-MY; Mon, 16 Nov 2020 07:53:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZK6-00067H-8o
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 07:53:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3A8F3AC66;
 Mon, 16 Nov 2020 07:53:13 +0000 (UTC)
Subject: Re: [PATCH v4 09/19] lpfc: vmid: VMID params initialization
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-10-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <54fdf354-146f-a14a-4238-eebd3b545468@suse.de>
Date: Mon, 16 Nov 2020 08:53:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-10-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_025314_555038_EE8B9C2A 
X-CRM114-Status: GOOD (  25.59  )
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
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGlu
aXRpYWxpemVzIHRoZSBWTUlEIHBhcmFtZXRlcnMgbGlrZSB0aGUgdHlwZSBvZiB2bWlkLCBtYXgK
PiBudW1iZXIgb2Ygdm1pZHMgc3VwcG9ydGVkIGFuZCB0aW1lb3V0IHZhbHVlIGZvciB0aGUgdm1p
ZCByZWdpc3RyYXRpb24KPiBiYXNlZCBvbiB0aGUgdXNlciBpbnB1dC4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBHYXVyYXYgU3JpdmFzdGF2YSAgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gCj4g
LS0tCj4gdjQ6Cj4gTm8gY2hhbmdlCj4gCj4gdjM6Cj4gTm8gY2hhbmdlCj4gCj4gdjI6Cj4gUG9y
dGVkIHRoZSBwYXRjaCBvbiB0b3Agb2YgNS4xMC9zY3NpLXF1ZXVlCj4gLS0tCj4gICBkcml2ZXJz
L3Njc2kvbHBmYy9scGZjX2F0dHIuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX2F0dHIuYyBiL2RyaXZlcnMvc2NzaS9scGZjL2xw
ZmNfYXR0ci5jCj4gaW5kZXggZTk0ZWFjMTk0Njc2Li5lNzM5OTdiY2U2NWMgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19hdHRyLmMKPiArKysgYi9kcml2ZXJzL3Njc2kvbHBm
Yy9scGZjX2F0dHIuYwo+IEBAIC02MTM4LDYgKzYxMzgsNDQgQEAgTFBGQ19CQkNSX0FUVFJfUlco
ZW5hYmxlX2JiY3IsIDEsIDAsIDEsICJFbmFibGUgQkJDIFJlY292ZXJ5Iik7Cj4gICAgKi8KPiAg
IExQRkNfQVRUUl9SVyhlbmFibGVfZHBwLCAxLCAwLCAxLCAiRW5hYmxlIERpcmVjdCBQYWNrZXQg
UHVzaCIpOwo+ICAgCj4gKy8qCj4gKyAqIGxwZmNfbWF4X3ZtaWQ6IE1heGltdW0gbnVtYmVyIG9m
IFZNcyB0byBiZSB0YWdnZWQuIFRoaXMgaXMgdmFsaWQgb25seSBpZgo+ICsgKiBlaXRoZXIgdm1p
ZF9hcHBfaGVhZGVyIG9yIHZtaWRfcHJpb3JpdHlfdGFnZ2luZyBpcyBlbmFibGVkLgo+ICsgKiAg
ICAgICA0IC0gMjU1ICA9IHZtaWQgc3VwcG9ydCBlbmFibGVkIGZvciA0LTI1NSBWTXMKPiArICog
ICAgICAgVmFsdWUgcmFuZ2UgaXMgWzQsMjU1XS4KPiArICovCj4gK0xQRkNfQVRUUl9SVyhtYXhf
dm1pZCwgTFBGQ19NSU5fVk1JRCwgTFBGQ19NSU5fVk1JRCwgTFBGQ19NQVhfVk1JRCwKPiArCSAg
ICAgIk1heGltdW0gbnVtYmVyIG9mIFZNcyBzdXBwb3J0ZWQiKTsKPiArCj4gKy8qCj4gKyAqIGxw
ZmNfdm1pZF9pbmFjdGl2aXR5X3RpbWVvdXQ6IEluYWN0aXZpdHkgdGltZW91dCBkdXJhdGlvbiBp
biBob3Vycwo+ICsgKiAgICAgICAwICA9IFRpbWVvdXQgaXMgZGlzYWJsZWQKPiArICogVmFsdWUg
cmFuZ2UgaXMgWzAsMjRdLgo+ICsgKi8KPiArTFBGQ19BVFRSX1JXKHZtaWRfaW5hY3Rpdml0eV90
aW1lb3V0LCA0LCAwLCAyNCwKPiArCSAgICAgIkluYWN0aXZpdHkgdGltZW91dCBpbiBob3VycyIp
Owo+ICsKPiArLyoKPiArICogbHBmY192bWlkX2FwcF9oZWFkZXI6IEVuYWJsZSBBcHAgSGVhZGVy
IFZNSUQgc3VwcG9ydAo+ICsgKiAgICAgICAwICA9IFN1cHBvcnQgaXMgZGlzYWJsZWQgKGRlZmF1
bHQpCj4gKyAqICAgICAgIDEgID0gU3VwcG9ydCBpcyBlbmFibGVkCj4gKyAqIFZhbHVlIHJhbmdl
IGlzIFswLDFdLgo+ICsgKi8KPiArTFBGQ19BVFRSX1JXKHZtaWRfYXBwX2hlYWRlciwgTFBGQ19W
TUlEX0FQUF9IRUFERVJfRElTQUJMRSwKPiArCSAgICAgTFBGQ19WTUlEX0FQUF9IRUFERVJfRElT
QUJMRSwgTFBGQ19WTUlEX0FQUF9IRUFERVJfRU5BQkxFLAo+ICsJICAgICAiRW5hYmxlIEFwcCBI
ZWFkZXIgVk1JRCBzdXBwb3J0Iik7Cj4gKwo+ICsvKgo+ICsgKiBscGZjX3ZtaWRfcHJpb3JpdHlf
dGFnZ2luZzogRW5hYmxlIFByaW9yaXR5IFRhZ2dpbmcgVk1JRCBzdXBwb3J0Cj4gKyAqICAgICAg
IDAgID0gU3VwcG9ydCBpcyBkaXNhYmxlZCAoZGVmYXVsdCkKPiArICogICAgICAgMSAgPSBTdXBw
b3J0IGlzIGVuYWJsZWQKPiArICogVmFsdWUgcmFuZ2UgaXMgWzAsMV0uLgo+ICsgKi8KPiArTFBG
Q19BVFRSX1JXKHZtaWRfcHJpb3JpdHlfdGFnZ2luZywgTFBGQ19WTUlEX1BSSU9fVEFHX0RJU0FC
TEUsCj4gKwkgICAgIExQRkNfVk1JRF9QUklPX1RBR19ESVNBQkxFLAo+ICsJICAgICBMUEZDX1ZN
SURfUFJJT19UQUdfQUxMX1RBUkdFVFMsCj4gKwkgICAgICJFbmFibGUgUHJpb3JpdHkgVGFnZ2lu
ZyBWTUlEIHN1cHBvcnQiKTsKPiArCj4gICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqbHBmY19o
YmFfYXR0cnNbXSA9IHsKPiAgIAkmZGV2X2F0dHJfbnZtZV9pbmZvLAo+ICAgCSZkZXZfYXR0cl9z
Y3NpX3N0YXQsCj4gQEAgLTYyNTUsNiArNjI5MywxMCBAQCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0
ZSAqbHBmY19oYmFfYXR0cnNbXSA9IHsKPiAgIAkmZGV2X2F0dHJfbHBmY19yYXNfZndsb2dfZnVu
YywKPiAgIAkmZGV2X2F0dHJfbHBmY19lbmFibGVfYmJjciwKPiAgIAkmZGV2X2F0dHJfbHBmY19l
bmFibGVfZHBwLAo+ICsJJmRldl9hdHRyX2xwZmNfbWF4X3ZtaWQsCj4gKwkmZGV2X2F0dHJfbHBm
Y192bWlkX2luYWN0aXZpdHlfdGltZW91dCwKPiArCSZkZXZfYXR0cl9scGZjX3ZtaWRfYXBwX2hl
YWRlciwKPiArCSZkZXZfYXR0cl9scGZjX3ZtaWRfcHJpb3JpdHlfdGFnZ2luZywKPiAgIAlOVUxM
LAo+ICAgfTsKPiAgIAo+IEBAIC03MzE0LDYgKzczNTYsMTEgQEAgbHBmY19nZXRfY2ZncGFyYW0o
c3RydWN0IGxwZmNfaGJhICpwaGJhKQo+ICAgCWxwZmNfZW5hYmxlX2hiYV9oZWFydGJlYXRfaW5p
dChwaGJhLCBscGZjX2VuYWJsZV9oYmFfaGVhcnRiZWF0KTsKPiAgIAo+ICAgCWxwZmNfRW5hYmxl
WExhbmVfaW5pdChwaGJhLCBscGZjX0VuYWJsZVhMYW5lKTsKPiArCS8qIFZNSUQgSW5pdHMgKi8K
PiArCWxwZmNfbWF4X3ZtaWRfaW5pdChwaGJhLCBscGZjX21heF92bWlkKTsKPiArCWxwZmNfdm1p
ZF9pbmFjdGl2aXR5X3RpbWVvdXRfaW5pdChwaGJhLCBscGZjX3ZtaWRfaW5hY3Rpdml0eV90aW1l
b3V0KTsKPiArCWxwZmNfdm1pZF9hcHBfaGVhZGVyX2luaXQocGhiYSwgbHBmY192bWlkX2FwcF9o
ZWFkZXIpOwo+ICsJbHBmY192bWlkX3ByaW9yaXR5X3RhZ2dpbmdfaW5pdChwaGJhLCBscGZjX3Zt
aWRfcHJpb3JpdHlfdGFnZ2luZyk7Cj4gICAJaWYgKHBoYmEtPnNsaV9yZXYgIT0gTFBGQ19TTElf
UkVWNCkKPiAgIAkJcGhiYS0+Y2ZnX0VuYWJsZVhMYW5lID0gMDsKPiAgIAlscGZjX1hMYW5lUHJp
b3JpdHlfaW5pdChwaGJhLCBscGZjX1hMYW5lUHJpb3JpdHkpOwo+IApSZXZpZXdlZC1ieTogSGFu
bmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5u
ZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVu
ZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
