Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45D1C388F2
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 13:04:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C699223B0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 13:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="118KtkdP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="VmrGwZZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C699223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7P722rYemydpLCv9uQwWBb+8/mCbyqrIceLcnDiKG4M=; b=118KtkdP4VGL5nI5BMFhvF4EY
	K0qy3kTNDQcFfFHlZ4Z+WqtM8VrUYOLi/zmKzF9m9E1+jv0VGkvfKywoHccEOm6tD/Qua2POg7EQx
	2F7fve2Z7Dwq1EjxWfg0yZMMbPOzLuIDHVzmgFwUGJlLcEX65fzfxezpvovcBlOrSOgPZINYKau7p
	qhktG8d6JmgJYBlWQQmSKBdmF2/cSZMuBhxXLUNK8EE6fW638OElFbsJVVzbWqI/vPdq4blxX2Pto
	IVYnXB6lwQlrlwSmctHcW6f/c4JpB3aJMVS89GjiD6vEVqDAxOuCBVKQvJ3q966Ms1uv4rKY9/MWB
	W4Q7WQRcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZZVX-0005wI-7T; Mon, 02 Nov 2020 13:04:23 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZZVT-0005v6-UV
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 13:04:20 +0000
Received: by mail-ed1-x544.google.com with SMTP id l24so14247726edj.8
 for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2020 05:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=/q1vhBdyTHY66HKX4WZ7Bax206ccPeTM5MICm/keYCA=;
 b=VmrGwZZr1yRpp5U2PCe7HMxEpzsdLxoYZuHG+6qqew2XJ0Po9B3h3cij6DYNwLbpZU
 4ARCtSNzKKHHg+d6DTdlJUiNCLUr2QsO5H+rb+c2QMdZWOM+SkoUTjL22NjW0AQ3I1mG
 wElpCdlSALwU7TLBsZEmcd51C/I62DAyUzBzwFgQ9kbrbX3R/HGWASVomF61WNZxvzwI
 gWkLkMs6ocZ8iUz2m/I+Dgw+ltZkG9XXBfT4WZGSz0Y9s1goWelXNtLLdIwqjq3s6jDv
 sDdbd4TlKHwbVPjM+qOPOLFKZgOT5RDq8LhSKjIzQ0Ih5CVP3kzW0988aFD1Lh2hOc3F
 te+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/q1vhBdyTHY66HKX4WZ7Bax206ccPeTM5MICm/keYCA=;
 b=d5IbeqdDFmveWKKbjzQtwvAkqTqa9ussMNsT4JmH77y/fs1XogS5K7E4dtrhhruylH
 CMJGQbSVjah5wd/L2tzlHbmlR0U+k8YOy63IHoQf4MPxAc/DuEL/MF6Nr8HExJUzMlwL
 8fRpQNm1lqKBjkaEDQEROJG7ptluLh2sVnaZ3im3zbadC55QpBKgABp9AdMlHpsZXB04
 vG5rCs5qkF0M+jG8ydYSdBSR0NugEXtWkKe7rmcoVTSpUmAKhXeWNvKGuM4E12l1+nwg
 fzwABdFM8etiz8jVVuvt/AbgyNu1IG0WARrWGuKURthrggcGAWCXcp4Fo+m4kRU+IXK/
 cnog==
X-Gm-Message-State: AOAM531DMj2cNUkf2OLe5PJQJ3KEFESK6Fws7wwuBdxwNCp+60lIE57o
 z1DKGd0ZvzemPCwTgJHZKDh7Qg==
X-Google-Smtp-Source: ABdhPJxQTTxwpPnBTJMErUUF2H5z+Dcavi2Ihqa1SYp061K2Qhx/M/6aSd1MBWE07SpSyh7jRnErvw==
X-Received: by 2002:aa7:cc84:: with SMTP id p4mr16081656edt.97.1604322253141; 
 Mon, 02 Nov 2020 05:04:13 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
 by smtp.gmail.com with ESMTPSA id p4sm509999ejw.101.2020.11.02.05.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 05:04:12 -0800 (PST)
Date: Mon, 2 Nov 2020 14:04:11 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102130411.2vqqrma6zetec543@MacBook-Pro.localdomain>
References: <20201029185753.14368-1-javier.gonz@samsung.com>
 <20201030143146.GA105238@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030143146.GA105238@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_080420_014751_FA65E090 
X-CRM114-Status: GOOD (  28.60  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMzAuMTAuMjAyMCAxNDozMSwgTmlrbGFzIENhc3NlbCB3cm90ZToKPk9uIFRodSwgT2N0IDI5
LCAyMDIwIGF0IDA3OjU3OjUzUE0gKzAxMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+IEFs
bG93IFpOUyBTU0RzIHRvIGJlIHByZXNlbnRlZCB0byB0aGUgaG9zdCBldmVuIHdoZW4gdGhleSBp
bXBsZW1lbnQKPj4gZmVhdHVyZXMgdGhhdCBhcmUgbm90IHN1cHBvcnRlZCBieSB0aGUga2VybmVs
IHpvbmVkIGJsb2NrIGRldmljZS4KPj4KPj4gSW5zdGVhZCBvZiByZWplY3RpbmcgdGhlIFNTRCBh
dCB0aGUgTlZNZSBkcml2ZXIgbGV2ZWwsIGRlYWwgd2l0aCB0aGlzIGluCj4+IHRoZSBibG9jayBs
YXllciBieSBzZXR0aW5nIGNhcGFjaXR5IHRvIDAsIGFzIHdlIGRvIHdpdGggb3RoZXIgdGhpbmdz
Cj4+IHN1Y2ggYXMgdW5zdXBwb3J0ZWQgUEkgY29uZmlndXJhdGlvbnMuIFRoaXMgYWxsb3dzIHRv
IHVzZSBzdGFuZGFyZAo+PiBtYW5hZ2VtZW50IHRvb2xzIHN1Y2ggYXMgbnZtZS1jbGkgdG8gY2hv
b3NlIGEgZGlmZmVyZW50IGZvcm1hdCBvcgo+PiBmaXJtd2FyZSBzbG90IHRoYXQgaXMgY29tcGF0
aWJsZSB3aXRoIHRoZSBMaW51eCB6b25lZCBibG9jayBkZXZpY2UuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEphdmllciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgo+PiAtLS0KPj4g
IGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8ICA1ICsrKysrCj4+ICBkcml2ZXJzL252bWUvaG9z
dC9udm1lLmggfCAgMSArCj4+ICBkcml2ZXJzL252bWUvaG9zdC96bnMuYyAgfCAzMSArKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDE3IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+IGluZGV4IGMxOTBjNTZiZjcw
Mi4uOWNhNGYwYTZmZjJjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMK
Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+IEBAIC0yMDI2LDYgKzIwMjYsMTEg
QEAgc3RhdGljIHZvaWQgbnZtZV91cGRhdGVfZGlza19pbmZvKHN0cnVjdCBnZW5kaXNrICpkaXNr
LAo+PiAgCQkJY2FwYWNpdHkgPSAwOwo+PiAgCX0KPgo+SGVsbG8gSmF2aWVyLAo+Cj4+Cj4+ICsj
aWZkZWYgQ09ORklHX0JMS19ERVZfWk9ORUQKPgo+aWYgKElTX0VOQUJMRUQoQ09ORklHX0JMS19E
RVZfWk9ORUQpCj4KPmlzIHByZWZlcnJlZCBvdmVyIGlmZGVmcy4KCkkgd2lsbCBhZGRyZXNzIHRo
aXMgaW4gYSB2Mi4KCj4KPj4gKwlpZiAoIW5zLT56b25lX3N1cCkKPj4gKwkJY2FwYWNpdHkgPSAw
Owo+PiArI2VuZGlmCj4+ICsKPj4gIAlzZXRfY2FwYWNpdHlfcmV2YWxpZGF0ZV9hbmRfbm90aWZ5
KGRpc2ssIGNhcGFjaXR5LCBmYWxzZSk7Cj4+Cj4+ICAJbnZtZV9jb25maWdfZGlzY2FyZChkaXNr
LCBucyk7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJz
L252bWUvaG9zdC9udm1lLmgKPj4gaW5kZXggODc3MzdmYTMyMzYwLi40MmNiZTViYmM1MTggMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+PiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC9udm1lLmgKPj4gQEAgLTQ0Myw2ICs0NDMsNyBAQCBzdHJ1Y3QgbnZtZV9ucyB7Cj4+
ICAJdTggcGlfdHlwZTsKPj4gICNpZmRlZiBDT05GSUdfQkxLX0RFVl9aT05FRAo+PiAgCXU2NCB6
c3plOwo+PiArCWJvb2wgem9uZV9zdXA7Cj4KPlBlcmhhcHMgYSBtb3JlIGRlc2NyaXB0aXZlIG5h
bWU/IHpvbmVkX25zX3N1cHAgPwoKU3VyZS4gSSBjYW4gZG8gdGhhdC4KCj4KPj4gICNlbmRpZgo+
PiAgCXVuc2lnbmVkIGxvbmcgZmVhdHVyZXM7Cj4+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
em5zLmMKPj4gaW5kZXggNTdjZmQ3ODczMWZiLi43N2E3ZmVkNTA4ZWYgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5j
Cj4+IEBAIC00NCwyMCArNDQsMjMgQEAgaW50IG52bWVfdXBkYXRlX3pvbmVfaW5mbyhzdHJ1Y3Qg
Z2VuZGlzayAqZGlzaywgc3RydWN0IG52bWVfbnMgKm5zLAo+PiAgCXN0cnVjdCBudm1lX2lkX25z
X3pucyAqaWQ7Cj4+ICAJaW50IHN0YXR1czsKPj4KPj4gLQkvKiBEcml2ZXIgcmVxdWlyZXMgem9u
ZSBhcHBlbmQgc3VwcG9ydCAqLwo+PiArCW5zLT56b25lX3N1cCA9IHRydWU7Cj4KPkkgZG9uJ3Qg
dGhpbmsgaXQgaXMgd2lzZSB0byBhc3NpZ24gaXQgdG8gdHJ1ZSBoZXJlLgo+RS5nLiBpZiBremFs
bG9jKCkgZmFpbGVzLCBpZiBudm1lX3N1Ym1pdF9zeW5jX2NtZCgpIGZhaWxzLAo+b3IgaWYgbnZt
ZV9zZXRfbWF4X2FwcGVuZCgpIGZhaWxzLCB5b3UgaGF2ZSBhbHJlYWR5IHNldCB0aGlzIHRvIHRy
dWUsCj5idXQgem9jIG9yIHBvd2VyIG9mIDIgY2hlY2tzIHdlcmUgbmV2ZXIgcGVyZm9ybWVkLgoK
SSBkbyBub3QgdGhpbmsgaXQgd2lsbCBtYXR0ZXIgbXVjaCBhcyBpdCBpcyBqdXN0IGFuIGludGVy
bmFsIHZhcmlhYmxlLgpJZiBhbnkgb2YgdGhlIGNoZWNrcyB5b3UgbWVudGlvbiBmYWlsLCB0aGVu
IHRoZSBuYW1lc3BhY2Ugd2lsbCBub3QgZXZlbgpiZSBpbml0aWFsaXplZC4KCklzIHRoZXJlIGFu
eXRoaW5nIEkgYW0gbWlzc2luZz8KCj5QZXJoYXBzIHNvbWV0aGluZyBsaWtlIHRoaXMgd291bGQg
YmUgbW9yZSByb2J1c3Q6Cj4KPkBAIC01MywxOCArNTMsMTkgQEAgaW50IG52bWVfdXBkYXRlX3pv
bmVfaW5mbyhzdHJ1Y3QgbnZtZV9ucyAqbnMsIHVuc2lnbmVkIGxiYWYpCj4gICAgICAgIHN0cnVj
dCBudm1lX2NvbW1hbmQgYyA9IHsgfTsKPiAgICAgICAgc3RydWN0IG52bWVfaWRfbnNfem5zICpp
ZDsKPiAgICAgICAgaW50IHN0YXR1czsKPisgICAgICAgYm9vbCBuZXdfbnNfc3VwcCA9IHRydWU7
Cj4rCj4rICAgICAgIC8qIGRlZmF1bHQgdG8gTlMgbm90IHN1cHBvcnRlZCAqLwo+KyAgICAgICBu
cy0+em9uZWRfbnNfc3VwcCA9IGZhbHNlOwo+Cj4tICAgICAgIC8qIERyaXZlciByZXF1aXJlcyB6
b25lIGFwcGVuZCBzdXBwb3J0ICovCj4gICAgICAgIGlmICghKGxlMzJfdG9fY3B1KGxvZy0+aW9j
c1tudm1lX2NtZF96b25lX2FwcGVuZF0pICYKPiAgICAgICAgICAgICAgICAgICAgICAgIE5WTUVf
Q01EX0VGRkVDVFNfQ1NVUFApKSB7Cj4gICAgICAgICAgICAgICAgZGV2X3dhcm4obnMtPmN0cmwt
PmRldmljZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICJhcHBlbmQgbm90IHN1cHBvcnRlZCBm
b3Igem9uZWQgbmFtZXNwYWNlOiVkXG4iLAo+ICAgICAgICAgICAgICAgICAgICAgICAgbnMtPmhl
YWQtPm5zX2lkKTsKPi0gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPi0gICAgICAgfQo+
LQo+LSAgICAgICAvKiBMYXppbHkgcXVlcnkgY29udHJvbGxlciBhcHBlbmQgbGltaXQgZm9yIHRo
ZSBmaXJzdCB6b25lZCBuYW1lc3BhY2UgKi8KPi0gICAgICAgaWYgKCFucy0+Y3RybC0+bWF4X3pv
bmVfYXBwZW5kKSB7Cj4rICAgICAgICAgICAgICAgbmV3X25zX3N1cHAgPSBmYWxzZTsKPisgICAg
ICAgfSBlbHNlIGlmICghbnMtPmN0cmwtPm1heF96b25lX2FwcGVuZCkgewo+KyAgICAgICAgICAg
ICAgIC8qIExhemlseSBxdWVyeSBjb250cm9sbGVyIGFwcGVuZCBsaW1pdCBmb3IgdGhlIGZpcnN0
IHpvbmVkIG5hbWVzcGFjZSAqLwo+ICAgICAgICAgICAgICAgIHN0YXR1cyA9IG52bWVfc2V0X21h
eF9hcHBlbmQobnMtPmN0cmwpOwo+ICAgICAgICAgICAgICAgIGlmIChzdGF0dXMpCj4gICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gc3RhdHVzOwo+QEAgLTgwLDE5ICs4MSwxNiBAQCBpbnQg
bnZtZV91cGRhdGVfem9uZV9pbmZvKHN0cnVjdCBudm1lX25zICpucywgdW5zaWduZWQgbGJhZikK
PiAgICAgICAgYy5pZGVudGlmeS5jc2kgPSBOVk1FX0NTSV9aTlM7Cj4KPiAgICAgICAgc3RhdHVz
ID0gbnZtZV9zdWJtaXRfc3luY19jbWQobnMtPmN0cmwtPmFkbWluX3EsICZjLCBpZCwgc2l6ZW9m
KCppZCkpOwo+LSAgICAgICBpZiAoc3RhdHVzKQo+LSAgICAgICAgICAgICAgIGdvdG8gZnJlZV9k
YXRhOwo+KyAgICAgICBpZiAoc3RhdHVzKSB7Cj4rICAgICAgICAgICAgICAga2ZyZWUoaWQpOwo+
KyAgICAgICAgICAgICAgIHJldHVybiBzdGF0dXM7Cj4rICAgICAgIH0KPgo+LSAgICAgICAvKgo+
LSAgICAgICAgKiBXZSBjdXJyZW50bHkgZG8gbm90IGhhbmRsZSBkZXZpY2VzIHJlcXVpcmluZyBh
bnkgb2YgdGhlIHpvbmVkCj4tICAgICAgICAqIG9wZXJhdGlvbiBjaGFyYWN0ZXJpc3RpY3MuCj4t
ICAgICAgICAqLwo+ICAgICAgICBpZiAoaWQtPnpvYykgewo+ICAgICAgICAgICAgICAgIGRldl93
YXJuKG5zLT5jdHJsLT5kZXZpY2UsCj4gICAgICAgICAgICAgICAgICAgICAgICAiem9uZSBvcGVy
YXRpb25zOiV4IG5vdCBzdXBwb3J0ZWQgZm9yIG5hbWVzcGFjZToldVxuIiwKPiAgICAgICAgICAg
ICAgICAgICAgICAgIGxlMTZfdG9fY3B1KGlkLT56b2MpLCBucy0+aGVhZC0+bnNfaWQpOwo+LSAg
ICAgICAgICAgICAgIHN0YXR1cyA9IC1FSU5WQUw7Cj4tICAgICAgICAgICAgICAgZ290byBmcmVl
X2RhdGE7Cj4rICAgICAgICAgICAgICAgbmV3X25zX3N1cHAgPSBmYWxzZTsKPiAgICAgICAgfQo+
Cj4gICAgICAgIG5zLT56c3plID0gbnZtZV9sYmFfdG9fc2VjdChucywgbGU2NF90b19jcHUoaWQt
PmxiYWZlW2xiYWZdLnpzemUpKTsKPkBAIC0xMDAsMTcgKzk4LDE0IEBAIGludCBudm1lX3VwZGF0
ZV96b25lX2luZm8oc3RydWN0IG52bWVfbnMgKm5zLCB1bnNpZ25lZCBsYmFmKQo+ICAgICAgICAg
ICAgICAgIGRldl93YXJuKG5zLT5jdHJsLT5kZXZpY2UsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAiaW52YWxpZCB6b25lIHNpemU6JWxsdSBmb3IgbmFtZXNwYWNlOiV1XG4iLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgbnMtPnpzemUsIG5zLT5oZWFkLT5uc19pZCk7Cj4tICAgICAgICAgICAg
ICAgc3RhdHVzID0gLUVJTlZBTDsKPi0gICAgICAgICAgICAgICBnb3RvIGZyZWVfZGF0YTsKPisg
ICAgICAgICAgICAgICBuZXdfbnNfc3VwcCA9IGZhbHNlOwo+ICAgICAgICB9Cj4KPisgICAgICAg
bnMtPnpvbmVkX25zX3N1cHAgPSBuZXdfbnNfc3VwcDsKPiAgICAgICAgcS0+bGltaXRzLnpvbmVk
ID0gQkxLX1pPTkVEX0hNOwo+ICAgICAgICBibGtfcXVldWVfZmxhZ19zZXQoUVVFVUVfRkxBR19a
T05FX1JFU0VUQUxMLCBxKTsKPiAgICAgICAgYmxrX3F1ZXVlX21heF9vcGVuX3pvbmVzKHEsIGxl
MzJfdG9fY3B1KGlkLT5tb3IpICsgMSk7Cj4gICAgICAgIGJsa19xdWV1ZV9tYXhfYWN0aXZlX3pv
bmVzKHEsIGxlMzJfdG9fY3B1KGlkLT5tYXIpICsgMSk7Cj4tZnJlZV9kYXRhOgo+LSAgICAgICBr
ZnJlZShpZCk7Cj4tICAgICAgIHJldHVybiBzdGF0dXM7Cj4gfQo+Cj4gc3RhdGljIHZvaWQgKm52
bWVfem5zX2FsbG9jX3JlcG9ydF9idWZmZXIoc3RydWN0IG52bWVfbnMgKm5zLAo+CgpTdXJlLCB3
ZSBjYW4gdXNlIGEgbG9jYWwgYXNzaWdubWVudCBhcyB5b3Ugc3VnZ2VzdC4gSSdsbCBzZW5kIGEg
VjIgd2l0aAp0aGlzLgoKSmF2aWVyCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=
