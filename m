Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7F1C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:30:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561382070A
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ghuwh6Fr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="zRQfXSIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561382070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YWZwmV0dxIQ9UXUuV+Wmmk585LbJplM9hV4C1TEXU1Y=; b=ghuwh6FrkVygOWgYOcs4QEjVB
	ypYn5Ngdh4q1wgsU99mlTDE9Yef+9J+8KZ/hkFsMcVg7qCmDGsaoE4T/5B1fLTardU5xkqlhN4gb0
	5u6FRUVIEVDBiwYN8CDcFDOYxUDz8/yNM7gdVCWNf356nRdmegksa8wJ+jkbS3yewCp7aRslp2C2i
	yYFgVrCJczjg9MJgTeoqWxj4LFvFifN4WOudknAs0AZhy5xTWoyxvV3Rt/ScyTGA27OxgTFvxl7kl
	xBxL7xsdo1yYb6AabaD7RMnkqEJwCE+2JmmZglBXTyTEuhAp6uOZdXiiN7uEjck4WiZSuNyWkpj9H
	PNfEG4/Yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolcl-0004oh-RF; Fri, 26 Jun 2020 10:30:23 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolcW-0004iD-Ek
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:30:20 +0000
Received: by mail-lf1-x141.google.com with SMTP id g2so4893418lfb.0
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=S6DFRoMnilCvEWUf89Cbh++Cevgda6Y99TKDJOaAgsM=;
 b=zRQfXSIqplNRjwgx/uTShDuhYTkQkudTDeoFxoFAHvneIVnKyyIpNktI+LDQkdkspP
 Q0X7YG7TSiHCxeePMkDta+Kumtq/LXwV67lilCJcvhRMfg/lFumRlHZGX1b+4FwrCUhq
 MJjxwIY07rgjhUctzhe0nvYkBzDpRJx4KOYqC+t2u26624j4umgwykBWEHBC0OjCrfOW
 c2ZRgeWIL6ra5Smko4F8oUsCow96hzXtCXUHKRHsUGpyP88IzPILhJT/AsPgXJiITuj3
 R40ciBfQh/es6IN9NowL7xjxlR1Ru47V1a97v09K8bOegdPGgNMs5AV/R3KGbRSr9aiw
 nwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=S6DFRoMnilCvEWUf89Cbh++Cevgda6Y99TKDJOaAgsM=;
 b=tQGsoDTux3OCFDgbpiXDTsWTp5OsvGnJn5b8zqujXScFarj2woQtn5XaXnO0fiiv0B
 t2e9IXiKf3VBfpAcDWC+D+f9xpsNhiR7HLG+BLc29nedjxertT5K/2DRhbsZjaSBV5Yg
 LcVfV9IJHvEKeHwvNFEQoBelpMKnqBYupPK2kvAQ9WmxNYq2rA72eSCGiODxj7VqS1Po
 411J5KwxMJRR6npQBctY0FJdggq6Ehm3HwV4vj1laS6siQB/30lwB6Sn2oEOBulZtbSf
 lDmswLLhOxoQFKTIygMAJ7zkdpjRez6sKx7K7pO0gfAFsAs9dn8gfx5DWkpJuPPIixNK
 bVHA==
X-Gm-Message-State: AOAM532j7QrQsNMDsMMODnPciI9qhYJP/vhwRTycjN3tJBUAu7oByXqQ
 v3KAwo4BPRrWlUKrjVu6xNMbD6JmDeHpyypt
X-Google-Smtp-Source: ABdhPJzW7l5JK8cIui7W9r62CBHhDUtaXNWKkqXytiT/LSxZZ5g3FGMeDP1LbjI9gbvggxNDprqn7A==
X-Received: by 2002:a17:907:20c4:: with SMTP id
 qq4mr1121473ejb.85.1593151134252; 
 Thu, 25 Jun 2020 22:58:54 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id g19sm4145252ejz.79.2020.06.25.22.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 22:58:53 -0700 (PDT)
Date: Fri, 26 Jun 2020 07:58:52 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/6] block: add support for selecting all zones
Message-ID: <20200626055852.ec6bfvx7mj3ucz5r@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-3-javier@javigon.com>
 <CY4PR04MB375143652B4BA25F1680A91EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375143652B4BA25F1680A91EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjYuMDYuMjAyMCAwMToyNywgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI1
IDIxOjIyLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBGcm9tOiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPj4KPj4gQWRkIGZsYWcgdG8gYWxsb3cgc2VsZWN0
aW5nIGFsbCB6b25lcyBvbiBhIHNpbmdsZSB6b25lIG1hbmFnZW1lbnQKPj4gb3BlcmF0aW9uCj4+
Cj4+IFNpZ25lZC1vZmYtYnk6IEphdmllciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcu
Y29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBTZWx2YUt1bWFyIFMgPHNlbHZha3VtYS5zMUBzYW1zdW5n
LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbiBKb3NoaSA8am9zaGkua0BzYW1zdW5nLmNv
bT4KPj4gU2lnbmVkLW9mZi1ieTogTml0ZXNoIFNoZXR0eSA8bmouc2hldHR5QHNhbXN1bmcuY29t
Pgo+PiAtLS0KPj4gIGJsb2NrL2Jsay16b25lZC5jICAgICAgICAgICAgIHwgMyArKysKPj4gIGlu
Y2x1ZGUvbGludXgvYmxrX3R5cGVzLmggICAgIHwgMyArKy0KPj4gIGluY2x1ZGUvdWFwaS9saW51
eC9ibGt6b25lZC5oIHwgOSArKysrKysrKysKPj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLXpvbmVk
LmMgYi9ibG9jay9ibGstem9uZWQuYwo+PiBpbmRleCBlODdjNjAwMDRkYzUuLjI5MTk0Mzg4YTFi
YiAxMDA2NDQKPj4gLS0tIGEvYmxvY2svYmxrLXpvbmVkLmMKPj4gKysrIGIvYmxvY2svYmxrLXpv
bmVkLmMKPj4gQEAgLTQyMCw2ICs0MjAsOSBAQCBpbnQgYmxrZGV2X3pvbmVfbWdtdF9pb2N0bChz
dHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBmbW9kZV90IG1vZGUsCj4+ICAJCXJldHVybiAtRU5P
VFRZOwo+PiAgCX0KPj4KPj4gKwlpZiAoem1nbXQuZmxhZ3MgJiBCTEtfWk9ORV9TRUxFQ1RfQUxM
KQo+PiArCQlvcCB8PSBSRVFfWk9ORV9BTEw7Cj4+ICsKPj4gIAlyZXR1cm4gYmxrZGV2X3pvbmVf
bWdtdChiZGV2LCBvcCwgem1nbXQuc2VjdG9yLCB6bWdtdC5ucl9zZWN0b3JzLAo+PiAgCQkJCUdG
UF9LRVJORUwpOwo+PiAgfQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMu
aCBiL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgKPj4gaW5kZXggY2NiODk1ZjkxMWIxLi4xNmI1
N2ZiMmI5OWMgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgKPj4gKysr
IGIvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaAo+PiBAQCAtMzUxLDYgKzM1MSw3IEBAIGVudW0g
cmVxX2ZsYWdfYml0cyB7Cj4+ICAJICogd29yayBpdGVtIHRvIGF2b2lkIHN1Y2ggcHJpb3JpdHkg
aW52ZXJzaW9ucy4KPj4gIAkgKi8KPj4gIAlfX1JFUV9DR1JPVVBfUFVOVCwKPj4gKwlfX1JFUV9a
T05FX0FMTCwJCS8qIGFwcGx5IHpvbmUgb3BlcmF0aW9uIHRvIGFsbCB6b25lcyAqLwo+Pgo+PiAg
CS8qIGNvbW1hbmQgc3BlY2lmaWMgZmxhZ3MgZm9yIFJFUV9PUF9XUklURV9aRVJPRVM6ICovCj4+
ICAJX19SRVFfTk9VTk1BUCwJCS8qIGRvIG5vdCBmcmVlIGJsb2NrcyB3aGVuIHplcm9pbmcgKi8K
Pj4gQEAgLTM3OCw3ICszNzksNyBAQCBlbnVtIHJlcV9mbGFnX2JpdHMgewo+PiAgI2RlZmluZSBS
RVFfQkFDS0dST1VORAkJKDFVTEwgPDwgX19SRVFfQkFDS0dST1VORCkKPj4gICNkZWZpbmUgUkVR
X05PV0FJVAkJKDFVTEwgPDwgX19SRVFfTk9XQUlUKQo+PiAgI2RlZmluZSBSRVFfQ0dST1VQX1BV
TlQJCSgxVUxMIDw8IF9fUkVRX0NHUk9VUF9QVU5UKQo+PiAtCj4+ICsjZGVmaW5lIFJFUV9aT05F
X0FMTAkJKDFVTEwgPDwgX19SRVFfWk9ORV9BTEwpCj4+ICAjZGVmaW5lIFJFUV9OT1VOTUFQCQko
MVVMTCA8PCBfX1JFUV9OT1VOTUFQKQo+PiAgI2RlZmluZSBSRVFfSElQUkkJCSgxVUxMIDw8IF9f
UkVRX0hJUFJJKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVk
LmggYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaAo+PiBpbmRleCAwN2I1ZmRlMjFkOWYu
LmE4Yzg5ZmU1OGY5NyAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVk
LmgKPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKPj4gQEAgLTE1Nyw2ICsx
NTcsMTUgQEAgZW51bSBibGtfem9uZV9hY3Rpb24gewo+PiAgCUJMS19aT05FX01HTVRfUkVTRVQJ
PSAweDQsCj4+ICB9Owo+Pgo+PiArLyoqCj4+ICsgKiBlbnVtIGJsa196b25lX21nbXRfZmxhZ3Mg
LSBGbGFncyBmb3IgYmxrX3pvbmVfbWdtdAo+PiArICoKPj4gKyAqIEJMS19aT05FX1NFTEVDVF9B
TEw6IFNlbGVjdCBhbGwgem9uZXMgZm9yIGN1cnJlbnQgem9uZSBhY3Rpb24KPj4gKyAqLwo+PiAr
ZW51bSBibGtfem9uZV9tZ210X2ZsYWdzIHsKPj4gKwlCTEtfWk9ORV9TRUxFQ1RfQUxMCT0gMSA8
PCAwLAo+PiArfTsKPj4gKwo+PiAgLyoqCj4+ICAgKiBzdHJ1Y3QgYmxrX3pvbmVfbWdtdCAtIEV4
dGVuZGVkIHpvbmVkIG1hbmFnZW1lbnQKPj4gICAqCj4+Cj4KPk5BQ0suCj4KPkRldGFpbHM6Cj4x
KSBSRVFfT1BfWk9ORV9SRVNFVCB0b2dldGhlciB3aXRoIFJFUV9aT05FX0FMTCBpcyB0aGUgc2Ft
ZSBhcwo+UkVRX09QX1pPTkVfUkVTRVRfQUxMLCBpc24ndCBpdCA/IFlvdSBhcmUgZHVwbGljYXRp
bmcgYSBmdW5jdGlvbmFsaXR5IHRoYXQKPmFscmVhZHkgZXhpc3RzLgo+MikgVGhlIHBhdGNoIGlu
dHJvZHVjZXMgUkVRX1pPTkVfQUxMIGF0IHRoZSBibG9jayBsYXllciBvbmx5IHdpdGhvdXQgZGVm
aW5pbmcKPmhvdyBpdCB0aWVzIGludG8gU0NTSSBhbmQgTlZNZSBkcml2ZXIgdXNlIG9mIGl0LiBJ
cyBSRVFfWk9ORV9BTEwgaW5kaWNhdGluZyB0aGF0Cj50aGUgem9uZSBtYW5hZ2VtZW50IGNvbW1h
bmRzIGFyZSB0byBiZSBleGVjdXRlZCB3aXRoIHRoZSBBTEwgYml0IHNldCA/IElmIHllcywKPnRo
YXQgd2lsbCBicmVhayBkZXZpY2UtbWFwcGVyLiBTZWUgdGhlIHNwZWNpYWwgY29kZSBmb3IgaGFu
ZGxpbmcKPlJFUV9PUF9aT05FX1JFU0VUX0FMTC4gVGhhdCBjb2RlIGlzIGluIHBsYWNlIGZvciBh
IHJlYXNvbjogdGhlIHRhcmdldCBibG9jawo+ZGV2aWNlIG1heSBub3QgYmUgYW4gZW50aXJlIHBo
eXNpY2FsIGRldmljZS4gSW4gdGhhdCBjYXNlLCBhcHBseWluZyBhIHpvbmUKPm1hbmFnZW1lbnQg
Y29tbWFuZCB0byBhbGwgem9uZXMgb2YgdGhlIHBoeXNpY2FsIGRyaXZlIGlzIHdyb25nLgo+Mykg
UkVRX1pPTkVfQUxMIHNlZW1zIGNvbXBsZXRlbHkgZXF1aXZhbGVudCB0byBzcGVjaWZ5aW5nIGEg
c2VjdG9yIHJhbmdlIG9mIFswCj4uLiBkcml2ZSBjYXBhY2l0eV0uIFNvIHdoYXQgaXMgdGhlIHBv
aW50ID8gVGhlIGN1cnJlbnQgaW50ZXJmYWNlIGhhbmRsZXMgdGhhdC4KPlRoYXQgaXMgaG93IHdl
IGNob3NlIGJldHdlZW4gUkVRX09QX1pPTkVfUkVTRVQgYW5kIFJFUV9PUF9aT05FX1JFU0VUX0FM
TCByaWdodCBub3cuCj40KSBXaXRob3V0IGFueSBpbi1rZXJuZWwgdXNlciwgSSBkbyBub3Qgc2Vl
IHRoZSBwb2ludC4gQW5kIGZvciBhcHBsaWNhdGlvbnMsIEkKPmRvIG5vdCBzZWUgYW55IGdvb2Qg
dXNlIGNhc2UgZm9yIGRvaW5nIG9wZW4gYWxsLCBjbG9zZSBhbGwsIG9mZmxpbmUgYWxsIG9yCj5m
aW5pc2ggYWxsLiBJZiB5b3UgaGF2ZSBhbnkgc3VjaCBnb29kIHVzZSBjYXNlLCBwbGVhc2UgZWxh
Ym9yYXRlLgo+CgpUaGUgbWFpbiB1c2UgaWYgcmVzZXQgYWxsLCBidXQgd2l0aG91dCBoYXZpbmcg
dG8gbG9vayB0aHJvdWdoIGFsbCB6b25lcywKYXMgaXQgaW1wb3NlcyBhbiBvdmVyaGVhZCB3aGVu
IHdlIGhhdmUgYSBsYXJnZSBudW1iZXIgb2Ygem9uZXMuIEhhdmluZwp0aGUgcG9zc2liaWxpdHkg
dG8gb2ZmbG9hZCBpdCB0byBIVyBpcyBtb3JlIGVmZmljaWVudC4KCkkgaGFkIG5vdCB0aG91Z2h0
IGFib3V0IHRoZSBkZXZpY2UgbWFwcGVyIHVzZSBjYXNlLiBXb3VsZCBpdCBiZSBhbgpvcHRpb24g
dG8gdHJhbnNsYXRlIHRoaXMgaW50byBSRVFfT1BfWk9ORV9SRVNFVF9BTEwgd2hlbiB3ZSBoYXZl
IGEKZGV2aWNlIG1hcHBlciAob3IgYW55IG90aGVyIGNhc2Ugd2hlcmUgdGhpcyBtaWdodCBicmVh
aykgYW5kIHRoZW4gbGVhdmUKdGhlIGJpdCBnbyB0byB0aGUgZHJpdmVyIGlmIGl0IGFwcGxpZXMg
dG8gdGhlIHdob2xlIGRldmljZT8KCkphdmllcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
