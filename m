Return-Path: <SRS0=a62X=FU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FA9C0018C
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 16:26:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB202339E
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 16:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB202339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eXbMVGvzWs/oDHTVVA+SSv4EP/EBRB7NWbklWJLLEGo=; b=FBqceV0pO0FtzLnhXhR0wik2Q
	4K0aE9nh8dpdYbTdAW0v6RrJjX3JEwFsx0uXKtisB7Vcbv/dbWMkVlQjI75/mqr3GHRt/7OpLk8r0
	eCf6osSe2lQP/u6RxzITJC9jTcTsj0060/NLa/OSJAqo1igCl6905GPyt3EiMG+Xzl/42Nj+4WwEF
	i8dzFv7McQDqqoxSMBdjwVBTKOu8YgPY31xdXwkOupm2ssxS5rE+Rqx4lbPKFN/tg8QifIhIcSpm0
	rVrvo27jFqX7YlIn/O1MYZxXWaX2Fg2yAAqGx+aQxWlGt4EDj5xfwoHAabbqsr88g6yTEySribzqg
	B/0jGMjCA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpZdO-0001Iz-UG; Wed, 16 Dec 2020 16:26:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpZdL-0001I8-U0
 for linux-nvme@lists.infradead.org; Wed, 16 Dec 2020 16:26:36 +0000
Date: Wed, 16 Dec 2020 08:26:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608135994;
 bh=7zZcgrufRU4Ojp16Hwd3RabYlkJfiaRhagRHw0Tmmlk=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jf/B9621ajmNSB1mvS7cPVsU3iiFFXYz+ZQOBE32zWbt5FShZqzDm3nCyLFrqzaud
 I1Wuhe7C/9RNimqz5TBNZjC/k4dEV8bLdTEXRtq6/HHiU3oosSmfKdpmkyvUuLKgAq
 Cl3i+qx1oCVNxdFBtLi7Dmjpl100XeCRkXw9F8HxK85wr0Lbmq9Y1aKVwjX9ssVSSC
 TCAmatWoG0c0P7Buf45ojC7DUjYf7up0VgtwIXloOzA2ND56ewkaNuVRpZLnaTXBeo
 5p+RLgSlwPxWHKgaIjfeK9okdfAe+2TJtyOnGYjwxMkwJbNtFuLvKhHfv9yHF5AOYK
 fZXO5N2ZdB0ew==
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Message-ID: <20201216162631.GA77639@dhcp-10-100-145-180.wdc.com>
References: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
 <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201216_112636_118573_92CE3126 
X-CRM114-Status: GOOD (  22.60  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, minwoo.im.dev@gmail.com,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgMDk6MDE6NTFBTSArMDEwMCwgSmF2aWVyIEdvbnrDoWxl
eiB3cm90ZToKPiA+IE9uIDE1IERlYyAyMDIwLCBhdCAyMy40NiwgS2VpdGggQnVzY2ggPGtidXNj
aEBrZXJuZWwub3JnPiB3cm90ZToKPiA+IO+7v09uIFR1ZSwgRGVjIDE1LCAyMDIwIGF0IDA4OjU1
OjU3UE0gKzAxMDAsIGphdmllckBqYXZpZ29uLmNvbSB3cm90ZToKPiA+PiArc3RhdGljIGludCBu
dm1lX2FsbG9jX2NoYXJkZXZfbnMoc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52bWVf
bnMgKm5zKQo+ID4+ICt7Cj4gPj4gKyAgICBjaGFyIGNkaXNrX25hbWVbRElTS19OQU1FX0xFTl07
Cj4gPj4gKyAgICBpbnQgcmV0Owo+ID4+ICsKPiA+PiArICAgIGRldmljZV9pbml0aWFsaXplKCZu
cy0+Y2Rldl9kZXZpY2UpOwo+ID4+ICsgICAgbnMtPmNkZXZfZGV2aWNlLmRldnQgPSBNS0RFVihN
QUpPUihudm1lX25zX2Jhc2VfY2hyX2RldnQpLAo+ID4+ICsgICAgICAgICAgICAgICAgICAgICBu
cy0+aGVhZC0+aW5zdGFuY2UpOwo+ID4gCj4gPiBBaCwgSSBzZWUgbm93LiBXZSBhcmUgbWFraW5n
IHRoZXNlIGdlbmVyaWMgaGFuZGxlcyBmb3IgZWFjaCBwYXRoLCBidXQKPiA+IHRoZSBucy0+aGVh
ZC0+aW5zdGFuY2UgaXMgdGhlIHNhbWUgZm9yIGFsbCBwYXRocyB0byBhIG5hbWVzcGFjZSwgc28g
aXQncwo+ID4gbm90IHVuaXF1ZSBmb3IgdGhhdC4gRnVydGhlciwgdGhhdCBoZWFkLT5pbnN0YW5j
ZSBpcyBhbGxvY2F0ZWQgcGVyCj4gPiBzdWJzeXN0ZW0sIHNvIGl0J3Mgbm90IHVuaXF1ZSBmcm9t
IG5hbWVzcGFjZSBoZWFkcyBzZWVuIGluIG90aGVyCj4gPiBzdWJzeXN0ZW1zLgo+ID4gCj4gPiBT
bywgSSB0aGluayB5b3UgbmVlZCB0byBhbGxvY2F0ZSBhIG5ldyBkZXZfdCBmb3IgZWFjaCBzdWJz
eXN0ZW0gcmF0aGVyCj4gPiB0aGFuIHRoZSBnbG9iYWwgbnZtZV9uc19iYXNlX2Nocl9kZXZ0LCBh
bmQgSSBndWVzcyB3ZSBhbHNvIG5lZWQgYSBuZXcKPiA+IG52bWVfbnMgaW5zdGFuY2UgZmllbGQg
YXNzaWduZWQgZnJvbSB5ZXQgYW5vdGhlciBpZGE/Cj4gCj4gT2suIEnigJlsbCBsb29rIGludG8g
aXQuIAoKVGhlIHN1Z2dlc3Rpb24gbWF5IGJlIG92ZXJraWxsIGFzIHdlIGRvbid0IG5lZWQgdW5p
cXVlIG1ham9ycyBmb3IgZWFjaApjb250cm9sbGVyIHJpZ2h0IG5vdyAodGhhdCBtYXkgY2hhbmdl
IGlmIHBlb3BsZSBuZWVkIG1vcmUgdGhhbiBhCm1pbGxpb24gZ2VuZXJpYyBoYW5kbGVzLCBidXQg
SSB0aGluayB3ZSdyZSBhIHdheXMgb2ZmIGZyb20gdGhhdCByZWFsaXR5KS4KClRoZSBmb2xsb3dp
bmcgb24gdG9wIG9mIHlvdXIgcGF0Y2ggbWFrZXMgaXQgYWxsIHdvcmsgZm9yIG1lLiBBbHNvLCBJ
CmRvbid0IHRoaW5rIHdlIHNob3VsZCBhYm9ydCBhZGRpbmcgdGhlIG5hbWVzcGFjZSBpZiB0aGUg
Z2VuZXJpYyBoYW5kbGUKZmFpbHMsIHNvIHRoYXQncyBpbmNsdWRlZCBoZXJlIHRvbzoKCi0tLQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jCmluZGV4IGMxYWE0YmNjZGViMi4uY2M5ZWFmNGViYTMyIDEwMDY0NAotLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCkBAIC04
Niw2ICs4Niw4IEBAIHN0YXRpYyBERUZJTkVfTVVURVgobnZtZV9zdWJzeXN0ZW1zX2xvY2spOwog
CiBzdGF0aWMgREVGSU5FX0lEQShudm1lX2luc3RhbmNlX2lkYSk7CiBzdGF0aWMgZGV2X3QgbnZt
ZV9jdHJsX2Jhc2VfY2hyX2RldnQ7CisKK3N0YXRpYyBERUZJTkVfSURBKG52bWVfZ2VuX21pbm9y
X2lkYSk7CiBzdGF0aWMgZGV2X3QgbnZtZV9uc19iYXNlX2Nocl9kZXZ0Owogc3RhdGljIHN0cnVj
dCBjbGFzcyAqbnZtZV9jbGFzczsKIHN0YXRpYyBzdHJ1Y3QgY2xhc3MgKm52bWVfbnNfY2xhc3M7
CkBAIC01MzksNyArNTQxLDggQEAgc3RhdGljIHZvaWQgbnZtZV9mcmVlX25zKHN0cnVjdCBrcmVm
ICprcmVmKQogCiAJaWYgKG5zLT5uZGV2KQogCQludm1lX252bV91bnJlZ2lzdGVyKG5zKTsKLQor
CWlmIChucy0+bWlub3IpCisJCWlkYV9zaW1wbGVfcmVtb3ZlKCZudm1lX2dlbl9taW5vcl9pZGEs
IG5zLT5taW5vciAtIDEpOwogCWNkZXZfZGV2aWNlX2RlbCgmbnMtPmNkZXYsICZucy0+Y2Rldl9k
ZXZpY2UpOwogCXB1dF9kaXNrKG5zLT5kaXNrKTsKIAludm1lX3B1dF9uc19oZWFkKG5zLT5oZWFk
KTsKQEAgLTM5MzIsOSArMzkzNSwxMyBAQCBzdGF0aWMgaW50IG52bWVfYWxsb2NfY2hhcmRldl9u
cyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QgbnZtZV9ucyAqbnMpCiAJY2hhciBjZGlz
a19uYW1lW0RJU0tfTkFNRV9MRU5dOwogCWludCByZXQ7CiAKKwlyZXQgPSBpZGFfc2ltcGxlX2dl
dCgmbnZtZV9nZW5fbWlub3JfaWRhLCAwLCAwLCBHRlBfS0VSTkVMKTsKKwlpZiAocmV0IDwgMCkK
KwkJcmV0dXJuIHJldDsKKworCW5zLT5taW5vciA9IHJldCArIDE7CiAJZGV2aWNlX2luaXRpYWxp
emUoJm5zLT5jZGV2X2RldmljZSk7Ci0JbnMtPmNkZXZfZGV2aWNlLmRldnQgPSBNS0RFVihNQUpP
Uihudm1lX25zX2Jhc2VfY2hyX2RldnQpLAotCQkJCSAgICAgbnMtPmhlYWQtPmluc3RhbmNlKTsK
Kwlucy0+Y2Rldl9kZXZpY2UuZGV2dCA9IE1LREVWKE1BSk9SKG52bWVfbnNfYmFzZV9jaHJfZGV2
dCksIHJldCk7CiAJbnMtPmNkZXZfZGV2aWNlLmNsYXNzID0gbnZtZV9uc19jbGFzczsKIAlucy0+
Y2Rldl9kZXZpY2UucGFyZW50ID0gY3RybC0+ZGV2aWNlOwogCW5zLT5jZGV2X2RldmljZS5ncm91
cHMgPSBudm1lX25zX2NoYXJfaWRfYXR0cl9ncm91cHM7CkBAIC0zOTQ1LDE1ICszOTUyLDIyIEBA
IHN0YXRpYyBpbnQgbnZtZV9hbGxvY19jaGFyZGV2X25zKHN0cnVjdCBudm1lX2N0cmwgKmN0cmws
IHN0cnVjdCBudm1lX25zICpucykKIAogCXJldCA9IGRldl9zZXRfbmFtZSgmbnMtPmNkZXZfZGV2
aWNlLCAiJXMiLCBjZGlza19uYW1lKTsKIAlpZiAocmV0KQotCQlyZXR1cm4gcmV0OworCQlnb3Rv
IHB1dF9pZGE7CiAKIAljZGV2X2luaXQoJm5zLT5jZGV2LCAmbnZtZV9jZGV2X2ZvcHMpOwogCW5z
LT5jZGV2Lm93bmVyID0gY3RybC0+b3BzLT5tb2R1bGU7CiAKIAlyZXQgPSBjZGV2X2RldmljZV9h
ZGQoJm5zLT5jZGV2LCAmbnMtPmNkZXZfZGV2aWNlKTsKIAlpZiAocmV0KQotCQlrZnJlZV9jb25z
dChucy0+Y2Rldl9kZXZpY2Uua29iai5uYW1lKTsKKwkJZ290byBmcmVlX2tvYmo7CisKKwlyZXR1
cm4gcmV0OwogCitmcmVlX2tvYmo6CisJa2ZyZWVfY29uc3QobnMtPmNkZXZfZGV2aWNlLmtvYmou
bmFtZSk7CitwdXRfaWRhOgorCWlkYV9zaW1wbGVfcmVtb3ZlKCZudm1lX2dlbl9taW5vcl9pZGEs
IG5zLT5taW5vciAtIDEpOworCW5zLT5taW5vciA9IDA7CiAJcmV0dXJuIHJldDsKIH0KIApAQCAt
NDAyMyw3ICs0MDM3LDkgQEAgc3RhdGljIHZvaWQgbnZtZV9hbGxvY19ucyhzdHJ1Y3QgbnZtZV9j
dHJsICpjdHJsLCB1bnNpZ25lZCBuc2lkLAogCW52bWVfZmF1bHRfaW5qZWN0X2luaXQoJm5zLT5m
YXVsdF9pbmplY3QsIG5zLT5kaXNrLT5kaXNrX25hbWUpOwogCiAJaWYgKG52bWVfYWxsb2NfY2hh
cmRldl9ucyhjdHJsLCBucykpCi0JCWdvdG8gb3V0X3B1dF9kaXNrOworCQlkZXZfd2FybihjdHJs
LT5kZXZpY2UsCisJCQkiZmFpbGVkIHRvIGNyZWF0ZSBnZW5lcmljIGhhbmRsZSBmb3IgbnNpZDol
ZFxuIiwKKwkJCW5zaWQpOwogCiAJa2ZyZWUoaWQpOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL252
bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKaW5kZXggMTY4Yzc3MTlj
ZGE0Li5jY2ZkNDlkMmEwMzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAor
KysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKQEAgLTQzNSw2ICs0MzUsNyBAQCBzdHJ1Y3Qg
bnZtZV9ucyB7CiAKIAlzdHJ1Y3QgZGV2aWNlIGNkZXZfZGV2aWNlOwkvKiBjaGFyIGRldmljZSAq
LwogCXN0cnVjdCBjZGV2IGNkZXY7CisJaW50IG1pbm9yOwogCiAJaW50IGxiYV9zaGlmdDsKIAl1
MTYgbXM7Ci0tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
