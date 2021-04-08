Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E81FC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:24:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022BC61057
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022BC61057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xSdBUIMgjm3Bm2OaN7cJt7xXNCYfI4vyJ+ysqT9H5Dw=; b=XezvXi+mkMEkosQg98BeQ2Nx/
	tRwpxSWWRxWL++WppIRMGKGo+URWMMot0UsO6EOXytE2a02l+SpvM6l02ADs17RDx/E8xlt4LNEyI
	KbDT9GzMESRud2sYemlYRYQ41hpGile/pYgTRL2RFoFOO3btiBXT0FA9qrEvKDRy2kwlAkhxCgSKX
	taqKhMiKxTF33tBv0UhMv6dPQS9bHstf2SMZfNZmbadXODglWIOzkK+uLSeUdTFOU5tTdmxL5V4g2
	Uk6oFqO6/t/OC2+8qhruJooEwHIu4CAvQ5EmUO3DfoGlQ2e8E+SpRdYN8XtsWBF/BzPh/CvpAfyao
	l/b4Z4iJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUP0w-007CiS-Hp; Thu, 08 Apr 2021 07:23:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUP0s-007Cfo-QI
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 07:23:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BFB5568B05; Thu,  8 Apr 2021 09:23:37 +0200 (CEST)
Date: Thu, 8 Apr 2021 09:23:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Message-ID: <20210408072337.GB24502@lst.de>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
 <20210408001427.20501-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408001427.20501-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_082338_965773_29428858 
X-CRM114-Status: GOOD (  19.08  )
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

PiArc3RhdGljIHZvaWQgbnZtZXRfc2V0X2NzaV96bnNfZWZmZWN0cyhzdHJ1Y3QgbnZtZV9lZmZl
Y3RzX2xvZyAqbG9nKQoKU2FtZSBuYW1pbmcgbml0cGljayBhcyBmb3IgdGhlIG52bSB2ZXJzaW9u
LgoKPiAgCXN3aXRjaCAocmVxLT5ucy0+Y3NpKSB7Cj4gIAljYXNlIE5WTUVfQ1NJX05WTToKPiAr
CQlyZXR1cm4gbnZtZXRfY29weV9uc19pZGVudGlmaWVyKHJlcSwgTlZNRV9OSURUX0NTSSwKPiAr
CQkJCQkJTlZNRV9OSURUX0NTSV9MRU4sCj4gKwkJCQkJCSZyZXEtPm5zLT5jc2ksIG8pOwo+ICsJ
Y2FzZSBOVk1FX0NTSV9aTlM6Cj4gKwkJaWYgKCFJU19FTkFCTEVEKENPTkZJR19CTEtfREVWX1pP
TkVEKSkKPiArCQkJcmV0dXJuIE5WTUVfU0NfSU5WQUxJRF9JT19DTURfU0VUOwo+ICsKClRoaXMg
Z29lcyBhd2F5IHdpdGggbXkgY29tbWVudCBvbiB0aGUgcHJldmlvdXMgcGF0Y2guCgo+IEBAIC00
NDgsNiArNDU2LDE1IEBAIHUxNiBudm1ldF9iZGV2X3BhcnNlX2lvX2NtZChzdHJ1Y3QgbnZtZXRf
cmVxICpyZXEpCj4gIAljYXNlIG52bWVfY21kX3dyaXRlX3plcm9lczoKPiAgCQlyZXEtPmV4ZWN1
dGUgPSBudm1ldF9iZGV2X2V4ZWN1dGVfd3JpdGVfemVyb2VzOwo+ICAJCXJldHVybiAwOwo+ICsJ
Y2FzZSBudm1lX2NtZF96b25lX2FwcGVuZDoKPiArCQlyZXEtPmV4ZWN1dGUgPSBudm1ldF9iZGV2
X2V4ZWN1dGVfem9uZV9hcHBlbmQ7Cj4gKwkJcmV0dXJuIDA7Cj4gKwljYXNlIG52bWVfY21kX3pv
bmVfbWdtdF9yZWN2Ogo+ICsJCXJlcS0+ZXhlY3V0ZSA9IG52bWV0X2JkZXZfZXhlY3V0ZV96b25l
X21nbXRfcmVjdjsKPiArCQlyZXR1cm4gMDsKPiArCWNhc2UgbnZtZV9jbWRfem9uZV9tZ210X3Nl
bmQ6Cj4gKwkJcmVxLT5leGVjdXRlID0gbnZtZXRfYmRldl9leGVjdXRlX3pvbmVfbWdtdF9zZW5k
OwoKSSB0aGluayB3ZSBuZWVkIGEgc2VwYXJhdGUgX3BhcnNlIGZvciBqdXN0IFpOUy4gIFRoYXQg
d2F5IHdlIGNhbgpkbyB0aGUgbnMuY3NpIGFuZCBJU19FTkFCTEVEIGNoZWNrIGluIG9uZSBzaW5n
bGUgcGxhY2UsIGFuZCB3ZQphbHNvIGRvbid0IG5lZWQgc3R1YnMgZm9yIGFueSBvZiB0aGVzZSBm
dW5jdGlvbnMgYXMgdGhleSBhcmUgYWxsCnVuZGVyIHRoZSBJU19FTkFCTEVEIGNoZWNrIGFuZCB0
aHVzIHRoZSBjb21waWxlciB3aWxsIG5ldmVyIGdlbmVyYXRlCmEgY2FsbCB0byB0aGVtIGZvciAh
Q09ORklHX0JMS19ERVZfWk9ORUQuCgo+ICtzdGF0aWMgdTE2IG52bWV0X2JkZXZfdmFsaWRhdGVf
em9uZV9tZ210X3JlY3Yoc3RydWN0IG52bWV0X3JlcSAqcmVxKQo+ICt7Cj4gKwlzZWN0b3JfdCBz
ZWN0ID0gbnZtZXRfbGJhX3RvX3NlY3QocmVxLT5ucywgcmVxLT5jbWQtPnptci5zbGJhKTsKPiAr
CXUzMiBvdXRfYnVmc2l6ZSA9IChsZTMyX3RvX2NwdShyZXEtPmNtZC0+em1yLm51bWQpICsgMSkg
PDwgMjsKPiArCj4gKwlpZiAoIWJkZXZfaXNfem9uZWQocmVxLT5ucy0+YmRldikpCj4gKwkJcmV0
dXJuIE5WTUVfU0NfSU5WQUxJRF9OUyB8IE5WTUVfU0NfRE5SOwoKSSB0aGluayBjaGVja2luZyB0
aGUgY3NpINGWbiB0aGUgbnZtZXRfbnMgc3RydWN0dXJlIGhlcmUgaXMgYSBsb3QKY2xlYW5lci4g
IEFuZCBhcyBtZW50aW9uZWQgYWJpdmUgSSB0aGluayB3ZSBzaG91bGQgZG8gdGhpcyBvbmNlIGZv
cgphbGwgem5zLXNwZWNpZmljIGNvbW1hbmRzLgoKPiArdm9pZCBudm1ldF9leGVjdXRlX2lkZW50
aWZ5X2Nuc19jc19jdHJsKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKPiArewo+ICsJdTggemFzbCA9
IHJlcS0+c3EtPmN0cmwtPnN1YnN5cy0+emFzbDsKPiArCXN0cnVjdCBudm1ldF9jdHJsICpjdHJs
ID0gcmVxLT5zcS0+Y3RybDsKPiArCXN0cnVjdCBudm1lX2lkX2N0cmxfem5zICppZDsKPiArCXUx
NiBzdGF0dXM7Cj4gKwo+ICsJaWYgKHJlcS0+Y21kLT5pZGVudGlmeS5jc2kgIT0gTlZNRV9DU0lf
Wk5TKSB7Cj4gKwkJcmVxLT5lcnJvcl9sb2MgPSBvZmZzZXRvZihzdHJ1Y3QgbnZtZV9jb21tb25f
Y29tbWFuZCwgb3Bjb2RlKTsKPiArCQlzdGF0dXMgPSBOVk1FX1NDX0lOVkFMSURfT1BDT0RFIHwg
TlZNRV9TQ19ETlI7Cj4gKwkJZ290byBvdXQ7Cj4gKwl9CgpUaGUgQ1NJIGNoZWNrIG9yIHJhdGhl
ciBhIHN3aXRjaCBvbiB0aGUgQ1NJIHdpdGggYSBkZWZhdWx0IGZhaWwKbmVlZHMgdG8gbW92ZSBp
bnRvIHRoZSBjb21tb24gY29kZSwgcHJvYmFibHkgaW50byB0aGUgbWFpbiBwYXJzaW5nCmZ1bmN0
aW9uLgoKPiArdm9pZCBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2Nuc19jc19ucyhzdHJ1Y3QgbnZt
ZXRfcmVxICpyZXEpCj4gK3sKPiArCXN0cnVjdCBudm1lX2lkX25zX3pucyAqaWRfem5zOwo+ICsJ
dTY0IHpzemU7Cj4gKwl1MTYgc3RhdHVzOwo+ICsKPiArCWlmIChyZXEtPmNtZC0+aWRlbnRpZnku
Y3NpICE9IE5WTUVfQ1NJX1pOUykgewo+ICsJCXJlcS0+ZXJyb3JfbG9jID0gb2Zmc2V0b2Yoc3Ry
dWN0IG52bWVfY29tbW9uX2NvbW1hbmQsIG9wY29kZSk7Cj4gKwkJc3RhdHVzID0gTlZNRV9TQ19J
TlZBTElEX09QQ09ERSB8IE5WTUVfU0NfRE5SOwo+ICsJCWdvdG8gb3V0Owo+ICsJfQoKU2FtZSBo
ZXJlLgoKPiArc3RhdGljIGludCBudm1ldF9iZGV2X3JlcG9ydF96b25lX2NiKHN0cnVjdCBibGtf
em9uZSAqeiwgdW5zaWduZWQgaSwgdm9pZCAqZCkKPiArewo+ICsJc3RydWN0IG52bWV0X3JlcG9y
dF96b25lX2RhdGEgKnJ6ID0gZDsKPiArCXN0cnVjdCBudm1lX3pvbmVfZGVzY3JpcHRvciAqZW50
cmllcyA9IHJ6LT5yei0+ZW50cmllczsKPiArCXN0cnVjdCBudm1ldF9ucyAqbnMgPSByei0+bnM7
Cj4gKwlzdGF0aWMgY29uc3QgdW5zaWduZWQgaW50IGJsa196Y29uZF90b19udm1lX3pzdGF0ZVtd
ID0gewo+ICsJCVtCTEtfWk9ORV9DT05EX0VNUFRZXQkgPSBOVk1FX1pSQVNGX1pPTkVfU1RBVEVf
RU1QVFksCj4gKwkJW0JMS19aT05FX0NPTkRfSU1QX09QRU5dID0gTlZNRV9aUkFTRl9aT05FX1NU
QVRFX0lNUF9PUEVOLAo+ICsJCVtCTEtfWk9ORV9DT05EX0VYUF9PUEVOXSA9IE5WTUVfWlJBU0Zf
Wk9ORV9TVEFURV9FWFBfT1BFTiwKPiArCQlbQkxLX1pPTkVfQ09ORF9DTE9TRURdCSA9IE5WTUVf
WlJBU0ZfWk9ORV9TVEFURV9DTE9TRUQsCj4gKwkJW0JMS19aT05FX0NPTkRfUkVBRE9OTFldID0g
TlZNRV9aUkFTRl9aT05FX1NUQVRFX1JFQURPTkxZLAo+ICsJCVtCTEtfWk9ORV9DT05EX0ZVTExd
CSA9IE5WTUVfWlJBU0ZfWk9ORV9TVEFURV9GVUxMLAo+ICsJCVtCTEtfWk9ORV9DT05EX09GRkxJ
TkVdCSA9IE5WTUVfWlJBU0ZfWk9ORV9TVEFURV9PRkZMSU5FLAo+ICsJfTsKPiArCj4gKwlpZiAo
cnotPnpyYXNmID09IE5WTUVfWlJBU0ZfWk9ORV9SRVBPUlRfQUxMKQo+ICsJCWdvdG8gcmVjb3Jk
X3pvbmU7Cj4gKwo+ICsJLyoKPiArCSAqIE1ha2Ugc3VyZSB0aGlzIHpvbmUgY29uZGl0aW9uJ3Mg
dmFsdWUgaXMgbWFwcGVkIHRvIE5WTWUgWk5TIHpvbmUKPiArCSAqIGNvbmRpdGlvbiB2YWx1ZS4K
PiArCSAqLwo+ICsJaWYgKHotPmNvbmQgPiBBUlJBWV9TSVpFKGJsa196Y29uZF90b19udm1lX3pz
dGF0ZSkgfHwKPiArCSAgICAhYmxrX3pjb25kX3RvX252bWVfenN0YXRlW3otPmNvbmRdKQo+ICsJ
CXJldHVybiAtRUlOVkFMOwo+ICsKPiArCS8qIGZpbHRlciB6b25lIGJ5IGNvbmRpdGlvbiAqLwo+
ICsJaWYgKGJsa196Y29uZF90b19udm1lX3pzdGF0ZVt6LT5jb25kXSAhPSByei0+enJhc2YpCj4g
KwkJcmV0dXJuIDA7Cj4gKwo+ICtyZWNvcmRfem9uZToKCldoaWxlIG5vdCBiYWQgcGVyIHNlIEkg
aW5kIHRoZSBzdHJ1Y3R1cmUgYSBsaXR0bGUgb2RkLiAgSSdkIG1vdmUgdGhlCmNoZWNrcyBpbnRv
IGEgbGV2ZWwgb2YgaW5kZW50YXRpb24gaW5zdGVhZC4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
