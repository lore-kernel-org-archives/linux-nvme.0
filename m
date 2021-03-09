Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC106C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 11:41:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB9B6525B
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 11:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB9B6525B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kwNuP5LqQH8yGD9j778kFwuhQrzbBarIAC1F+nU0qAc=; b=ExP843UQkWTY4w4TVbPQT0tb/
	g0e+P2o6fomD4VUuw60+7vpJIjPWRtL/PFNzGG0tB+kqVH9UggalGa+txPD9wxUMjC6aFQSksxMsX
	hhos2LWGX+yZtqhWmIZPa4S49NmX4VWemosOGHWyoGWw5CZ608ABfDWVOtyz2pPECl89ChqiUo2qc
	S+2hrMZe29sOh27PnK9OeO14IG+dQolOaYKXEkS42nNsih1VfSRaSdBrOp+ZTf20f2E2C+4Rc5ph7
	dj3yUkETNvVotQ2JK6D5TbApOfWhe5PyZSrrQt/m3DuLW8mP1oaIwHCgNyrR01z3Wp7AioGizmkYP
	sKFt9BxJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJak3-004Lsg-47; Tue, 09 Mar 2021 11:41:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJajy-004Lri-D6
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 11:41:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1C40668BEB; Tue,  9 Mar 2021 12:41:28 +0100 (CET)
Date: Tue, 9 Mar 2021 12:41:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V10 4/8] nvmet: add ZBD over ZNS backend support
Message-ID: <20210309114127.GD9520@lst.de>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309045823.18545-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_114131_386798_10402A71 
X-CRM114-Status: GOOD (  24.25  )
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

T24gTW9uLCBNYXIgMDgsIDIwMjEgYXQgMDg6NTg6MTlQTSAtMDgwMCwgQ2hhaXRhbnlhIEt1bGth
cm5pIHdyb3RlOgo+IE5WTWUgVFAgNDA1MyDigJMgWm9uZWQgTmFtZXNwYWNlcyAoWk5TKSBhbGxv
d3MgaG9zdCBzb2Z0d2FyZSB0bwo+IGNvbW11bmljYXRlIHdpdGggYSBub24tdm9sYXRpbGUgbWVt
b3J5IHN1YnN5c3RlbSB1c2luZyB6b25lcyBmb3IKPiBOVk1lIHByb3RvY29sIGJhc2VkIGNvbnRy
b2xsZXJzLiBOVk1lT0YgYWxyZWFkeSBzdXBwb3J0IHRoZSBaTlMgTlZNZQo+IFByb3RvY29sIGNv
bXBsaWFudCBkZXZpY2VzIG9uIHRoZSB0YXJnZXQgaW4gdGhlIHBhc3N0aHJ1IG1vZGUuIFRoZXJl
Cj4gYXJlIEdlbmVyaWMgem9uZWQgYmxvY2sgZGV2aWNlcyBsaWtlICBTaGluZ2xlZCBNYWduZXRp
YyBSZWNvcmRpbmcgKFNNUikKPiBIRERzIHRoYXQgYXJlIG5vdCBiYXNlZCBvbiB0aGUgTlZNZSBw
cm90b2NvbC4KPiAKPiBUaGlzIHBhdGNoIGFkZHMgWk5TIGJhY2tlbmQgdG8gc3VwcG9ydCB0aGUg
WkJEcyBmb3IgTlZNZU9GIHRhcmdldC4KPiAKPiBUaGlzIHN1cHBvcnQgaW5jbHVkZXMgaW1wbGVt
ZW50aW5nIHRoZSBuZXcgY29tbWFuZCBzZXQgTlZNRV9DU0lfWk5TLAo+IGFkZGluZyBkaWZmZXJl
bnQgY29tbWFuZCBoYW5kbGVycyBmb3IgWk5TIGNvbW1hbmQgc2V0IHN1Y2ggYXMKPiBOVk1lIElk
ZW50aWZ5IENvbnRyb2xsZXIsIE5WTWUgSWRlbnRpZnkgTmFtZXNwYWNlLCBOVk1lIFpvbmUgQXBw
ZW5kLAo+IE5WTWUgWm9uZSBNYW5hZ2VtZW50IFNlbmQgYW5kIE5WTWUgWm9uZSBNYW5hZ2VtZW50
IFJlY2VpdmUuCj4gCj4gV2l0aCBuZXcgY29tbWFuZCBzZXQgaWRlbnRpZmllciB3ZSBhbHNvIHVw
ZGF0ZSB0aGUgdGFyZ2V0IGNvbW1hbmQgZWZmZWN0cwo+IGxvZ3MgdG8gcmVmbGVjdCB0aGUgWk5T
IGNvbXBsaWFudCBjb21tYW5kcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvdGFy
Z2V0L01ha2VmaWxlICAgICAgfCAgIDEgKwo+ICBkcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNt
ZC5jICAgfCAgIDggKwo+ICBkcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMgfCAgMzMg
KysrLQo+ICBkcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmggICAgICAgfCAgMzggKysrKwo+ICBk
cml2ZXJzL252bWUvdGFyZ2V0L3pucy5jICAgICAgICAgfCAzMDggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCj4gIDUgZmlsZXMgY2hhbmdlZCwgMzgwIGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL252bWUvdGFyZ2V0L3pucy5j
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvTWFrZWZpbGUgYi9kcml2ZXJz
L252bWUvdGFyZ2V0L01ha2VmaWxlCj4gaW5kZXggZWJmOTFmYzRjNzJlLi45ODM3ZTU4MGZhN2Ug
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9NYWtlZmlsZQo+ICsrKyBiL2RyaXZl
cnMvbnZtZS90YXJnZXQvTWFrZWZpbGUKPiBAQCAtMTIsNiArMTIsNyBAQCBvYmotJChDT05GSUdf
TlZNRV9UQVJHRVRfVENQKQkJKz0gbnZtZXQtdGNwLm8KPiAgbnZtZXQteQkJKz0gY29yZS5vIGNv
bmZpZ2ZzLm8gYWRtaW4tY21kLm8gZmFicmljcy1jbWQubyBcCj4gIAkJCWRpc2NvdmVyeS5vIGlv
LWNtZC1maWxlLm8gaW8tY21kLWJkZXYubwo+ICBudm1ldC0kKENPTkZJR19OVk1FX1RBUkdFVF9Q
QVNTVEhSVSkJKz0gcGFzc3RocnUubwo+ICtudm1ldC0kKENPTkZJR19CTEtfREVWX1pPTkVEKQkJ
Kz0gem5zLm8KPiAgbnZtZS1sb29wLXkJKz0gbG9vcC5vCj4gIG52bWV0LXJkbWEteQkrPSByZG1h
Lm8KPiAgbnZtZXQtZmMteQkrPSBmYy5vCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvYWRtaW4tY21kLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCj4gaW5kZXgg
NzZkOWZjMGY0OGMyLi4wNWVmMzYyZDcwYjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL3Rh
cmdldC9hZG1pbi1jbWQuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMK
PiBAQCAtNzE5LDggKzcxOSwxNiBAQCBzdGF0aWMgdm9pZCBudm1ldF9leGVjdXRlX2lkZW50aWZ5
KHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKPiAgCXN3aXRjaCAocmVxLT5jbWQtPmlkZW50aWZ5LmNu
cykgewo+ICAJY2FzZSBOVk1FX0lEX0NOU19OUzoKPiAgCQlyZXR1cm4gbnZtZXRfZXhlY3V0ZV9p
ZGVudGlmeV9ucyhyZXEpOwo+ICsJY2FzZSBOVk1FX0lEX0NOU19DU19OUzoKPiArCQlpZiAocmVx
LT5jbWQtPmlkZW50aWZ5LmNzaSA9PSBOVk1FX0NTSV9aTlMpCj4gKwkJCXJldHVybiBudm1ldF9l
eGVjdXRlX2lkZW50aWZ5X2Nuc19jc19ucyhyZXEpOwo+ICsJCWJyZWFrOwo+ICAJY2FzZSBOVk1F
X0lEX0NOU19DVFJMOgo+ICAJCXJldHVybiBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2N0cmwocmVx
KTsKPiArCWNhc2UgTlZNRV9JRF9DTlNfQ1NfQ1RSTDoKPiArCQlpZiAocmVxLT5jbWQtPmlkZW50
aWZ5LmNzaSA9PSBOVk1FX0NTSV9aTlMpCj4gKwkJCXJldHVybiBudm1ldF9leGVjdXRlX2lkZW50
aWZ5X2Nuc19jc19jdHJsKHJlcSk7Cj4gKwkJYnJlYWs7CgpJIHN0aWxsIGZpbmQgdGhlIHdheSBo
b3cgdGhpcyBtaXhlcyB0aGUgQ05TIGFuZCBDU0kgZmllbGRzIGluIGEgc2luZ2xlCnN3aXRjaCB3
ZWlyZC4gIEknZCBleHBlY3QgYW4gb3V0ZXIgc3dpdGNoIGZvciBDTlMgYW5kIGFuIGlubmVyIG9u
ZSBmb3IKdGhlIENTSSB2YWx1ZS4KCj4gK3N0YXRpYyB1MTYgbnZtZXRfYmRldl96bnNfY2hlY2tz
KHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKPiArewo+ICsJaWYgKCFiZGV2X2lzX3pvbmVkKHJlcS0+
bnMtPmJkZXYpKQo+ICsJCXJldHVybiBOVk1FX1NDX0lOVkFMSURfTlMgfCBOVk1FX1NDX0ROUjsK
PiArCj4gKwlpZiAocmVxLT5jbWQtPnptci56cmEgIT0gTlZNRV9aUkFfWk9ORV9SRVBPUlQpCj4g
KwkJcmV0dXJuIE5WTUVfU0NfSU5WQUxJRF9GSUVMRDsKPiArCj4gKwlpZiAocmVxLT5jbWQtPnpt
ci56cmFzZiAhPSBOVk1FX1pSQVNGX1pPTkVfUkVQT1JUX0FMTCkKPiArCQlyZXR1cm4gTlZNRV9T
Q19JTlZBTElEX0ZJRUxEOwo+ICsKPiArCWlmIChyZXEtPmNtZC0+em1yLnByICE9IE5WTUVfUkVQ
T1JUX1pPTkVfUEFSVElBTCkKPiArCQlyZXR1cm4gTlZNRV9TQ19JTlZBTElEX0ZJRUxEOwoKZXJy
b3JfbG9jIGluZm9ybWF0aW9uIHdvdWxkIGJlIHVzZWZ1bCBoZXJlLgoKPiArc3RhdGljIGlubGlu
ZSBib29sIG52bWV0X3puc191cGRhdGVfemFzbChzdHJ1Y3QgbnZtZXRfbnMgKm5zKQo+ICt7Cj4g
KwlzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9IG5zLT5iZGV2LT5iZF9kaXNrLT5xdWV1ZTsKPiAr
CXU4IHphc2wgPSBudm1ldF96YXNsKHF1ZXVlX21heF96b25lX2FwcGVuZF9zZWN0b3JzKHEpKTsK
PiArCj4gKwlpZiAobnMtPnN1YnN5cy0+emFzbCkKPiArCQlyZXR1cm4gbnMtPnN1YnN5cy0+emFz
bCA8IHphc2wgPyBmYWxzZSA6IHRydWU7CgpObyBuZWVkIGZvciB0aGUgdGVuYXJ5IGV4cHJlc3Np
b24gaGVyZSwgdGhlIGNvbXBhcmlzbSB3aWxsIGF1dG9jb252ZXJ0IHRvCmJvb2wuCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
