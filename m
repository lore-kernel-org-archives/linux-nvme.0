Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE37C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:44:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582BD64F23
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582BD64F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/itnQub8DlQIgTixKmL67WTV3ztg+IdlomBeTrbutEk=; b=FxFXAix6M+zIO1g1vCFitVkHF
	tliiQTflV2MSsy5TW0e2H2ZOnpLn4HbaRRWmqDB4yYY9q3/od8xKFRenteZnoD767P6x8esQC3Ckf
	oyqX1w+JS8PXJMk6GvyYBycDI4SYLdX/v/8x3O5qY4DIDy7iflfeQ+wxVBAnZahg+JMyQuzqIyk+o
	VKAyq1sLn2HHakvSl6f2xicZOPtPIfmQ9RWcF+d17F7nrbVG2kkJKrh++Ipiia8HC95jfH/xmMKEo
	EhnOEHS/9PVMyOn4gyo6MlDdJAyuF1hySEofGwvQxe9csdN+x2qNi0TAo7cA+WlkKNAvWLfCM5EGS
	rc1xli41Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHnKa-008eOQ-ND; Thu, 04 Mar 2021 12:43:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHnK5-008eK3-8r
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:43:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C5A97AEE5;
 Thu,  4 Mar 2021 12:43:20 +0000 (UTC)
Subject: Re: [PATCH v8 12/16] lpfc: vmid: Appends the vmid in the wqe before
 sending
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-13-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <cb296bf1-e001-44ca-e7da-4ca8d6a06346@suse.de>
Date: Thu, 4 Mar 2021 13:43:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-13-git-send-email-muneendra.kumar@broadcom.com>
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
cyB0aGUgdm1pZCBpbiB3cWUgYmVmb3JlIHNlbmRpbmcgb3V0IHRoZSByZXF1ZXN0Lgo+IFRoZSB0
eXBlIG9mIHZtaWQgZGVwZW5kcyBvbiB0aGUgY29uZmlndXJlZCB0eXBlIGFuZCBpcyBjaGVja2Vk
IGJlZm9yZQo+IGJlaW5nIGFwcGVuZGVkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEdhdXJhdiBTcml2
YXN0YXZhICA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IFNpZ25lZC1vZmYtYnk6
IEphbWVzIFNtYXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4KPiAKPiAtLS0KPiB2ODoKPiBNb2Rp
ZmllZCB0aGUgbG9nIG1lc3NhZ2VzCj4gCj4gdjc6Cj4gTm8gY2hhbmdlCj4gCj4gdjY6Cj4gTm8g
Y2hhbmdlCj4gCj4gdjU6Cj4gTW9kaWZpZWQgdGhlIGNvbW1lbnRzCj4gCj4gdjQ6Cj4gTm8gY2hh
bmdlCj4gCj4gdjM6Cj4gTm8gY2hhbmdlCj4gCj4gdjI6Cj4gUG9ydGVkIHRoZSBwYXRjaCBvbiB0
b3Agb2YgNS4xMC9zY3NpLXF1ZXVlCj4gLS0tCj4gICBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX3Ns
aS5jIHwgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kv
bHBmYy9scGZjX3NsaS5jIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19zbGkuYwo+IGluZGV4IGIy
MGZhNWQ0YmQ4MC4uMzBiNjA2ODY3ZDY3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc2NzaS9scGZj
L2xwZmNfc2xpLmMKPiArKysgYi9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX3NsaS5jCj4gQEAgLTk3
NjcsNiArOTc2Nyw4IEBAIGxwZmNfc2xpNF9pb2NiMndxZShzdHJ1Y3QgbHBmY19oYmEgKnBoYmEs
IHN0cnVjdCBscGZjX2lvY2JxICppb2NicSwKPiAgIAkJCQkqcGNtZCA9PSBFTFNfQ01EX1JTQ05f
WE1UIHx8Cj4gICAJCQkJKnBjbWQgPT0gRUxTX0NNRF9GRElTQyB8fAo+ICAgCQkJCSpwY21kID09
IEVMU19DTURfTE9HTyB8fAo+ICsJCQkJKnBjbWQgPT0gRUxTX0NNRF9RRlBBIHx8Cj4gKwkJCQkq
cGNtZCA9PSBFTFNfQ01EX1VWRU0gfHwKPiAgIAkJCQkqcGNtZCA9PSBFTFNfQ01EX1BMT0dJKSkg
ewo+ICAgCQkJCWJmX3NldChlbHNfcmVxNjRfc3AsICZ3cWUtPmVsc19yZXEsIDEpOwo+ICAgCQkJ
CWJmX3NldChlbHNfcmVxNjRfc2lkLCAmd3FlLT5lbHNfcmVxLAo+IEBAIC05ODk4LDYgKzk5MDAs
MjQgQEAgbHBmY19zbGk0X2lvY2Iyd3FlKHN0cnVjdCBscGZjX2hiYSAqcGhiYSwgc3RydWN0IGxw
ZmNfaW9jYnEgKmlvY2JxLAo+ICAgCQkJcHRyID0gJndxZS0+d29yZHNbMjJdOwo+ICAgCQkJbWVt
Y3B5KHB0ciwgZmNwX2NtbmQsIHNpemVvZihzdHJ1Y3QgZmNwX2NtbmQpKTsKPiAgIAkJfQo+ICsK
PiArCQkvKiBhZGQgdGhlIFZNSUQgdGFncyBhcyBwZXIgc3dpdGNoIHJlc3BvbnNlICovCj4gKwkJ
aWYgKGlvY2JxLT5pb2NiX2ZsYWcgJiBMUEZDX0lPX1ZNSUQpIHsKPiArCQkJdW5pb24gbHBmY193
cWUxMjggKndxZTEyODsKPiArCj4gKwkJCWlmIChwaGJhLT5wcG9ydC0+dm1pZF9wcmlvcml0eV90
YWdnaW5nKSB7Cj4gKwkJCQliZl9zZXQod3FlX2NjcGUsICZ3cWUtPmZjcF9pd3JpdGUud3FlX2Nv
bSwgMSk7Cj4gKwkJCQliZl9zZXQod3FlX2NjcCwgJndxZS0+ZmNwX2l3cml0ZS53cWVfY29tLAo+
ICsJCQkJICAgICAgIChpb2NicS0+dm1pZF90YWcuY3NfY3RsX3ZtaWQpKTsKPiArCQkJCS8qIEJp
dCAwIG11c3QgYmUgMCAqLwo+ICsJCQl9IGVsc2Ugewo+ICsJCQkJd3FlMTI4ID0gKHVuaW9uIGxw
ZmNfd3FlMTI4ICopd3FlOwo+ICsJCQkJYmZfc2V0KHdxZV9hcHBpZCwgJndxZS0+ZmNwX2l3cml0
ZS53cWVfY29tLCAxKTsKPiArCQkJCWJmX3NldCh3cWVfd3FlcywgJndxZTEyOC0+ZmNwX2l3cml0
ZS53cWVfY29tLAo+ICsJCQkJICAgICAgIDEpOwo+ICsJCQkJd3FlMTI4LT53b3Jkc1szMV0gPSBp
b2NicS0+dm1pZF90YWcuYXBwX2lkOwo+ICsJCQl9Cj4gKwkJfQo+ICAgCQlicmVhazsKPiAgIAlj
YXNlIENNRF9GQ1BfSVJFQUQ2NF9DUjoKPiAgIAkJLyogd29yZDMgaW9jYj1pb3RhZyB3cWU9cGF5
bG9hZF9vZmZzZXRfbGVuICovCj4gQEAgLTk5NjIsNiArOTk4MiwyMyBAQCBscGZjX3NsaTRfaW9j
YjJ3cWUoc3RydWN0IGxwZmNfaGJhICpwaGJhLCBzdHJ1Y3QgbHBmY19pb2NicSAqaW9jYnEsCj4g
ICAJCQlwdHIgPSAmd3FlLT53b3Jkc1syMl07Cj4gICAJCQltZW1jcHkocHRyLCBmY3BfY21uZCwg
c2l6ZW9mKHN0cnVjdCBmY3BfY21uZCkpOwo+ICAgCQl9Cj4gKwo+ICsJCS8qIGFkZCB0aGUgVk1J
RCB0YWdzIGFzIHBlciBzd2l0Y2ggcmVzcG9uc2UgKi8KPiArCQlpZiAoaW9jYnEtPmlvY2JfZmxh
ZyAmIExQRkNfSU9fVk1JRCkgewo+ICsJCQl1bmlvbiBscGZjX3dxZTEyOCAqd3FlMTI4Owo+ICsK
PiArCQkJaWYgKHBoYmEtPnBwb3J0LT52bWlkX3ByaW9yaXR5X3RhZ2dpbmcpIHsKPiArCQkJCWJm
X3NldCh3cWVfY2NwZSwgJndxZS0+ZmNwX2lyZWFkLndxZV9jb20sIDEpOwo+ICsJCQkJYmZfc2V0
KHdxZV9jY3AsICZ3cWUtPmZjcF9pcmVhZC53cWVfY29tLAo+ICsJCQkJICAgICAgIChpb2NicS0+
dm1pZF90YWcuY3NfY3RsX3ZtaWQpKTsKPiArCQkJCS8qIEJpdCAwIG11c3QgYmUgMCAqLwo+ICsJ
CQl9IGVsc2Ugewo+ICsJCQkJd3FlMTI4ID0gKHVuaW9uIGxwZmNfd3FlMTI4ICopd3FlOwo+ICsJ
CQkJYmZfc2V0KHdxZV9hcHBpZCwgJndxZS0+ZmNwX2lyZWFkLndxZV9jb20sIDEpOwo+ICsJCQkJ
YmZfc2V0KHdxZV93cWVzLCAmd3FlMTI4LT5mY3BfaXJlYWQud3FlX2NvbSwgMSk7Cj4gKwkJCQl3
cWUxMjgtPndvcmRzWzMxXSA9IGlvY2JxLT52bWlkX3RhZy5hcHBfaWQ7Cj4gKwkJCX0KPiArCQl9
Cj4gICAJCWJyZWFrOwo+ICAgCWNhc2UgQ01EX0ZDUF9JQ01ORDY0X0NSOgo+ICAgCQkvKiB3b3Jk
MyBpb2NiPWlvdGFnIHdxZT1wYXlsb2FkX29mZnNldF9sZW4gKi8KPiBAQCAtMTAwMTksNiArMTAw
NTYsMjMgQEAgbHBmY19zbGk0X2lvY2Iyd3FlKHN0cnVjdCBscGZjX2hiYSAqcGhiYSwgc3RydWN0
IGxwZmNfaW9jYnEgKmlvY2JxLAo+ICAgCQkJcHRyID0gJndxZS0+d29yZHNbMjJdOwo+ICAgCQkJ
bWVtY3B5KHB0ciwgZmNwX2NtbmQsIHNpemVvZihzdHJ1Y3QgZmNwX2NtbmQpKTsKPiAgIAkJfQo+
ICsKPiArCQkvKiBhZGQgdGhlIFZNSUQgdGFncyBhcyBwZXIgc3dpdGNoIHJlc3BvbnNlICovCj4g
KwkJaWYgKGlvY2JxLT5pb2NiX2ZsYWcgJiBMUEZDX0lPX1ZNSUQpIHsKPiArCQkJdW5pb24gbHBm
Y193cWUxMjggKndxZTEyODsKPiArCj4gKwkJCWlmIChwaGJhLT5wcG9ydC0+dm1pZF9wcmlvcml0
eV90YWdnaW5nKSB7Cj4gKwkJCQliZl9zZXQod3FlX2NjcGUsICZ3cWUtPmZjcF9pY21kLndxZV9j
b20sIDEpOwo+ICsJCQkJYmZfc2V0KHdxZV9jY3AsICZ3cWUtPmZjcF9pY21kLndxZV9jb20sCj4g
KwkJCQkgICAgICAgKGlvY2JxLT52bWlkX3RhZy5jc19jdGxfdm1pZCkpOwo+ICsJCQkJLyogQml0
IDAgbXVzdCBiZSAwICovCj4gKwkJCX0gZWxzZSB7Cj4gKwkJCQl3cWUxMjggPSAodW5pb24gbHBm
Y193cWUxMjggKil3cWU7Cj4gKwkJCQliZl9zZXQod3FlX2FwcGlkLCAmd3FlLT5mY3BfaWNtZC53
cWVfY29tLCAxKTsKPiArCQkJCWJmX3NldCh3cWVfd3FlcywgJndxZTEyOC0+ZmNwX2ljbWQud3Fl
X2NvbSwgMSk7Cj4gKwkJCQl3cWUxMjgtPndvcmRzWzMxXSA9IGlvY2JxLT52bWlkX3RhZy5hcHBf
aWQ7Cj4gKwkJCX0KPiArCQl9Cj4gICAJCWJyZWFrOwo+ICAgCWNhc2UgQ01EX0dFTl9SRVFVRVNU
NjRfQ1I6Cj4gICAJCS8qIEZvciB0aGlzIGNvbW1hbmQgY2FsY3VsYXRlIHRoZSB4bWl0IGxlbmd0
aCBvZiB0aGUKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtl
cm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBH
ZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
