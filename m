Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6467C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:34:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DCC206A1
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vW8a2Lyy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="QMaVtQUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DCC206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ieK4czrZoq0WEPbfYv3s5ah6JtMY/tuMFj5OLJO8PeM=; b=vW8a2LyyYg+t2oohYh1Be3czU
	qjA9FVw9e24ZN0xrIe5DC5yitJUq75pxeONHVHtR50M8nnJfqP31J/0YJm+n5EG9xm93iNC67q24c
	WaBOISA+n/uzUhxWZMuku9OX/iC2BSjCW0BfOCiGl8QaVOpiBplIJ84slfO2nAHTlqSsyWJyP8mcX
	nxB4Vy/4SmwjEJ3qX8GInVfLKJc46gyH9irfdaBncW/gkvHsPr3amseRIFHz/2baMir9XXw2zEAq1
	XkeJipSgQh21aDKkKOQHH7khBkylXTWWPFyc7HsibRx/h4R+xZbBaEidZ2noWAhAU9i6KO1PBZ/tH
	kTJn7U/cg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqug3-00024S-Fn; Thu, 02 Jul 2020 08:34:39 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqug0-000238-BZ
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 08:34:37 +0000
Received: by mail-ed1-x544.google.com with SMTP id d16so16077703edz.12
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 01:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=qi9qGF+SqQYuKRudvW84peIMSp1FDuyHvZ3I82vYQjg=;
 b=QMaVtQUw67TOY8AIWVh5B/jTHwhYg/McW4YY3DLJr4nE2LTcEgxHyqm6BB+xkN2sxS
 e5yDTfynX2vrT7S/vmx4xp/bECLjs++MjdCvldaQbv6R2v+phwdYiZwBxvPkSrzo4ELU
 MEqyEVSCkE4sDy9ra8jHwrz8zIIBJ4tfYmw5W9Xckc6spGHwg3H5a2s3dzuLIpLdlT1u
 uwsr/P0i7eWnel0BTxgX+y5ZY8czC+NDrovMfImI/LgN/k77SjAH6dHCH9Tu1OvRUgv1
 MghwDW+4JkXAOFivNSkLYwRUQz5LbSgZcLZlLBJtpOoE9+UQ+udP0XVfyruSTN7InDiV
 2Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qi9qGF+SqQYuKRudvW84peIMSp1FDuyHvZ3I82vYQjg=;
 b=d9soCmIcO2ybhJ/80lCqC+b8+ftxt6rV6X5MUa/ZRzaR28+mqKD5X8vPaRyj+U++Km
 Hp4g3xD+c+5suzTuhr2rFdqmSeFuLaOgjUqaLDKHavxWx9bO/TSW8AF9AaIoqt2vgpls
 qZe/z8HByEB/oJGMH7o2L/JVbwLPINvVYpxO3Vnvc+yUbfSt1EzV5pPldvHDRWQAjozQ
 0cowmOx9aBTZ1T0w8bxOMJxSvPDyjlb4NvRpF6nso29SPoiSUpBOMTY7PGK9/wuxirbm
 HgftJN2o+boSpotpzly4OGnpQT2qKodn3QAQLC5qH+kqQggFub5ihE+S2Fpq7d6ax9Jd
 pfTg==
X-Gm-Message-State: AOAM533FEjmscPMmlo+Ns5ycPL1YEAxiXmRUwWangrHW/ZYmhZIcnaDN
 ljkaqoDbjaHj8ofa134bpSicPw==
X-Google-Smtp-Source: ABdhPJxyKxm9ZA5zyOrNFXILHYk1ydemwjcqycIrZHrUPV+z5kl1jj+rAQi3+BMRu5PEERrCEZCJjA==
X-Received: by 2002:aa7:c1d8:: with SMTP id d24mr34060818edp.178.1593678874803; 
 Thu, 02 Jul 2020 01:34:34 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id b14sm4996168ejg.18.2020.07.02.01.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 01:34:34 -0700 (PDT)
Date: Thu, 2 Jul 2020 10:34:30 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 1/4] block: Add zone flags to queue zone prop.
Message-ID: <20200702083430.miax2cd44mkhc5fb@mpHalley.local>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-2-javier@javigon.com>
 <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_043436_552610_69B703EC 
X-CRM114-Status: GOOD (  23.94  )
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
 "kbusch@kernel.org" <kbusch@kernel.org>, "mb@lightnvm.io" <mb@lightnvm.io>,
 "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDIuMDcuMjAyMCAwNzo1NCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA3LzAy
IDE1OjU1LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBGcm9tOiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPj4KPj4gQXMgdGhlIHpvbmVkIGJsb2NrIGRldmlj
ZSB3aWxsIGhhdmUgdG8gZGVhbCB3aXRoIGZlYXR1cmVzIHRoYXQgYXJlCj4+IG9wdGlvbmFsIGZv
ciB0aGUgYmFja2VuZCBkZXZpY2UsIGFkZCBhIGZsYWcgZmllbGQgdG8gaW5mb3JtIHRoZSBibG9j
awo+PiBsYXllciBhYm91dCBzdXBwb3J0ZWQgZmVhdHVyZXMuIFRoaXMgYnVpbGRzIG9uIHRvcCBv
Zgo+PiBibGtfem9uZV9yZXBvcnRfZmxhZ3MgYW5kIGV4dGVuZGVzIHRvIHRoZSB6b25lIHJlcG9y
dCBjb2RlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29u
ekBzYW1zdW5nLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxzZWx2YWt1bWEu
czFAc2Ftc3VuZy5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEthbmNoYW4gSm9zaGkgPGpvc2hpLmtA
c2Ftc3VuZy5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5qLnNoZXR0eUBz
YW1zdW5nLmNvbT4KPj4gLS0tCj4+ICBibG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICAgfCAz
ICsrLQo+PiAgZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jIHwgMiArKwo+PiAgZHJpdmVy
cy9udm1lL2hvc3Qvem5zLmMgICAgICAgIHwgMSArCj4+ICBkcml2ZXJzL3Njc2kvc2QuYyAgICAg
ICAgICAgICAgfCAyICsrCj4+ICBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oICAgICAgICAgfCAzICsr
Kwo+PiAgNSBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstem9uZWQuYyBiL2Jsb2NrL2Jsay16b25lZC5jCj4+
IGluZGV4IDgxMTUyYTI2MDM1NC4uMGYxNTZlOTZlNDhmIDEwMDY0NAo+PiAtLS0gYS9ibG9jay9i
bGstem9uZWQuYwo+PiArKysgYi9ibG9jay9ibGstem9uZWQuYwo+PiBAQCAtMzEyLDcgKzMxMiw4
IEBAIGludCBibGtkZXZfcmVwb3J0X3pvbmVzX2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2UgKmJk
ZXYsIGZtb2RlX3QgbW9kZSwKPj4gIAkJcmV0dXJuIHJldDsKPj4KPj4gIAlyZXAubnJfem9uZXMg
PSByZXQ7Cj4+IC0JcmVwLmZsYWdzID0gQkxLX1pPTkVfUkVQX0NBUEFDSVRZOwo+PiArCXJlcC5m
bGFncyA9IHEtPnpvbmVfZmxhZ3M7Cj4KPnpvbmVfZmxhZ3Mgc2VlbSB0byBiZSBhIGZhaXJseSBn
ZW5lcmljIGZsYWdzIGZpZWxkIHdoaWxlIHJlcC5mbGFncyBpcyBvbmx5IGFib3V0Cj50aGUgcmVw
b3J0ZWQgZGVzY3JpcHRvcnMgc3RydWN0dXJlLiBTbyB5b3UgbWF5IHdhbnQgdG8gZGVmaW5lIGEK
PkJMS19aT05FX1JFUF9GTEFHU19NQVNLIGFuZCBoYXZlOgo+Cj4JcmVwLmZsYWdzID0gcS0+em9u
ZV9mbGFncyAmIEJMS19aT05FX1JFUF9GTEFHU19NQVNLOwo+Cj50byBhdm9pZCBmbGFncyBtZWFu
aW5nbGVzcyBmb3IgdGhlIHVzZXIgYmVpbmcgc2V0Lgo+Cj5JbiBhbnkgY2FzZSwgc2luY2UgKmFs
bCogem9uZWQgYmxvY2sgZGV2aWNlcyBub3cgcmVwb3J0IGNhcGFjaXR5LCBJIGRvIG5vdAo+cmVh
bGx5IHNlZSB0aGUgcG9pbnQgdG8gYWRkIEJMS19aT05FX1JFUF9GTEFHU19NQVNLIHRvIHEtPnpv
bmVfZmxhZ3MsIGVzcGVjaWFsbHkKPmNvbnNpZGVyaW5nIHRoYXQgeW91IHNldCB0aGUgZmxhZyBm
b3IgYWxsIHpvbmVkIGRldmljZSB0eXBlcywgaW5jbHVkaW5nIHNjc2kKPndoaWNoIGRvZXMgbm90
IGhhdmUgem9uZSBjYXBhY2l0eS4gVGhpcyBtYWtlcyBxLT56b25lX2ZsYWdzIHJhdGhlciBjb25m
dXNpbmcKPmluc3RlYWQgb2YgY2xlYXJseSBkZWZpbmluZyB0aGUgZGV2aWNlIGZlYXR1cmVzIGFz
IHlvdSBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdAo+bWVzc2FnZS4KPgo+SSB0aGluayBpdCBtYXkg
YmUgYmV0dGVyIHRvIGp1c3QgZHJvcCB0aGlzIHBhdGNoLCBhbmQgaWYgbmVlZGVkLCBpbnRyb2R1
Y2UgdGhlCj56b25lX2ZsYWdzIGZpZWxkIHdoZXJlIGl0IG1heSBiZSBuZWVkZWQgKGUuZy4gT0ZG
TElORSB6b25lIGlvY3RsIHN1cHBvcnQpLgoKSSBhbSB1c2luZyB0aGlzIGFzIGEgd2F5IHRvIHBh
c3MgdGhlIE9GRkxJTkUgc3VwcG9ydCBmbGFnIHRvIHRoZSBibG9jawpsYXllci4gSSB1c2VkIHRo
aXMgdG9vIGZvciB0aGUgYXR0cmlidXRlcy4gQXJlIHlvdSB0aGlua2luZyBvZiBhCmRpZmZlcmVu
dCB3YXkgdG8gc2VuZCB0aGlzPwoKSSBiZWxpZXZlIHRoaXMgZml0cyB0b28gZm9yIGNhcGFjaXR5
LCBidXQgd2UgY2FuIGp1c3QgcGFzcyBpdCBpbgphbGwgcmVwb3J0IGFzIGJlZm9yZSBpZiB5b3Ug
cHJlZmVyLgoKPgo+PiArCj4+ICAJaWYgKGNvcHlfdG9fdXNlcihhcmdwLCAmcmVwLCBzaXplb2Yo
c3RydWN0IGJsa196b25lX3JlcG9ydCkpKQo+PiAgCQlyZXR1cm4gLUVGQVVMVDsKPj4gIAlyZXR1
cm4gMDsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYyBiL2Ry
aXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYwo+PiBpbmRleCBiMDU4MzJlYjIxYjIuLjk1N2My
MTAzZjI0MCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jCj4+
ICsrKyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYwo+PiBAQCAtNzgsNiArNzgsOCBA
QCBpbnQgbnVsbF9pbml0X3pvbmVkX2RldihzdHJ1Y3QgbnVsbGJfZGV2aWNlICpkZXYsIHN0cnVj
dCByZXF1ZXN0X3F1ZXVlICpxKQo+PiAgCX0KPj4KPj4gIAlxLT5saW1pdHMuem9uZWQgPSBCTEtf
Wk9ORURfSE07Cj4+ICsJcS0+em9uZV9mbGFncyA9IEJMS19aT05FX1JFUF9DQVBBQ0lUWTsKPj4g
Kwo+PiAgCWJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX1pPTkVfUkVTRVRBTEwsIHEpOwo+
PiAgCWJsa19xdWV1ZV9yZXF1aXJlZF9lbGV2YXRvcl9mZWF0dXJlcyhxLCBFTEVWQVRPUl9GX1pC
RF9TRVFfV1JJVEUpOwo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwo+PiBpbmRleCAwNjQyZDNjNTRlOGYuLjg4ODI2NDI2
MWJhMyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKPj4gKysrIGIvZHJp
dmVycy9udm1lL2hvc3Qvem5zLmMKPj4gQEAgLTgxLDYgKzgxLDcgQEAgaW50IG52bWVfdXBkYXRl
X3pvbmVfaW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0IG52bWVfbnMgKm5zLAo+PiAg
CX0KPj4KPj4gIAlxLT5saW1pdHMuem9uZWQgPSBCTEtfWk9ORURfSE07Cj4+ICsJcS0+em9uZV9m
bGFncyA9IEJMS19aT05FX1JFUF9DQVBBQ0lUWTsKPj4gIAlibGtfcXVldWVfZmxhZ19zZXQoUVVF
VUVfRkxBR19aT05FX1JFU0VUQUxMLCBxKTsKPj4gIGZyZWVfZGF0YToKPj4gIAlrZnJlZShpZCk7
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvc2QuYyBiL2RyaXZlcnMvc2NzaS9zZC5jCj4+
IGluZGV4IGQ5MGZlZmZmZTMxYi4uYjljOTIwYmFjZTI4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L3Njc2kvc2QuYwo+PiArKysgYi9kcml2ZXJzL3Njc2kvc2QuYwo+PiBAQCAtMjk2Nyw2ICsyOTY3
LDcgQEAgc3RhdGljIHZvaWQgc2RfcmVhZF9ibG9ja19jaGFyYWN0ZXJpc3RpY3Moc3RydWN0IHNj
c2lfZGlzayAqc2RrcCkKPj4gIAlpZiAoc2RrcC0+ZGV2aWNlLT50eXBlID09IFRZUEVfWkJDKSB7
Cj4+ICAJCS8qIEhvc3QtbWFuYWdlZCAqLwo+PiAgCQlxLT5saW1pdHMuem9uZWQgPSBCTEtfWk9O
RURfSE07Cj4+ICsJCXEtPnpvbmVfZmxhZ3MgPSBCTEtfWk9ORV9SRVBfQ0FQQUNJVFk7Cj4+ICAJ
fSBlbHNlIHsKPj4gIAkJc2RrcC0+em9uZWQgPSAoYnVmZmVyWzhdID4+IDQpICYgMzsKPj4gIAkJ
aWYgKHNka3AtPnpvbmVkID09IDEgJiYgIWRpc2tfaGFzX3BhcnRpdGlvbnMoc2RrcC0+ZGlzaykp
IHsKPj4gQEAgLTI5ODMsNiArMjk4NCw3IEBAIHN0YXRpYyB2b2lkIHNkX3JlYWRfYmxvY2tfY2hh
cmFjdGVyaXN0aWNzKHN0cnVjdCBzY3NpX2Rpc2sgKnNka3ApCj4+ICAJCQkJCSAgIkRyaXZlLW1h
bmFnZWQgU01SIGRpc2tcbiIpOwo+PiAgCQl9Cj4+ICAJfQo+PiArCj4+ICAJaWYgKGJsa19xdWV1
ZV9pc196b25lZChxKSAmJiBzZGtwLT5maXJzdF9zY2FuKQo+PiAgCQlzZF9wcmludGsoS0VSTl9O
T1RJQ0UsIHNka3AsICJIb3N0LSVzIHpvbmVkIGJsb2NrIGRldmljZVxuIiwKPj4gIAkJICAgICAg
cS0+bGltaXRzLnpvbmVkID09IEJMS19aT05FRF9ITSA/ICJtYW5hZ2VkIiA6ICJhd2FyZSIpOwo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2luY2x1ZGUvbGludXgvYmxr
ZGV2LmgKPj4gaW5kZXggOGZkOTAwOTk4YjRlLi4zZjJlMzQyNWZhNTMgMTAwNjQ0Cj4+IC0tLSBh
L2luY2x1ZGUvbGludXgvYmxrZGV2LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaAo+
PiBAQCAtNTEyLDEyICs1MTIsMTUgQEAgc3RydWN0IHJlcXVlc3RfcXVldWUgewo+PiAgCSAqIFN0
YWNraW5nIGRyaXZlcnMgKGRldmljZSBtYXBwZXJzKSBtYXkgb3IgbWF5IG5vdCBpbml0aWFsaXpl
Cj4+ICAJICogdGhlc2UgZmllbGRzLgo+PiAgCSAqCj4+ICsJICogRmxhZ3MgcmVwcmVzZW50IGZl
YXR1cmVzIGFzIGRlc2NyaWJlZCBieSBibGtfem9uZV9yZXBvcnRfZmxhZ3MgaW4gYmxrem9uZWQu
aAo+PiArCSAqCj4+ICAJICogUmVhZHMgb2YgdGhpcyBpbmZvcm1hdGlvbiBtdXN0IGJlIHByb3Rl
Y3RlZCB3aXRoIGJsa19xdWV1ZV9lbnRlcigpIC8KPj4gIAkgKiBibGtfcXVldWVfZXhpdCgpLiBN
b2RpZnlpbmcgdGhpcyBpbmZvcm1hdGlvbiBpcyBvbmx5IGFsbG93ZWQgd2hpbGUKPj4gIAkgKiBu
byByZXF1ZXN0cyBhcmUgYmVpbmcgcHJvY2Vzc2VkLiBTZWUgYWxzbyBibGtfbXFfZnJlZXplX3F1
ZXVlKCkgYW5kCj4+ICAJICogYmxrX21xX3VuZnJlZXplX3F1ZXVlKCkuCj4+ICAJICovCj4+ICAJ
dW5zaWduZWQgaW50CQlucl96b25lczsKPj4gKwl1bnNpZ25lZCBpbnQJCXpvbmVfZmxhZ3M7Cj4+
ICAJdW5zaWduZWQgbG9uZwkJKmNvbnZfem9uZXNfYml0bWFwOwo+PiAgCXVuc2lnbmVkIGxvbmcJ
CSpzZXFfem9uZXNfd2xvY2s7Cj4+ICAjZW5kaWYgLyogQ09ORklHX0JMS19ERVZfWk9ORUQgKi8K
Pj4KPgo+QW5kIHlvdSBhcmUgbWlzc2luZyBkZXZpY2UtbWFwcGVyIHN1cHBvcnQuIERNIHRhcmdl
dCBkZXZpY2VzIGhhdmUgYSByZXF1ZXN0Cj5xdWV1ZSB0aGF0IHdvdWxkIG5lZWQgdG8gc2V0IHRo
ZSB6b25lX2ZsYWdzIHRvby4KCk9rLiBJIGxvb2tlZCBhdCBpdCBhbmQgSSB0aG91Z2h0IHRoYXQg
dGhpcyB3b3VsZCBiZSBpbmhlcml0ZWQgYnkgdGhlCnVuZGVybHlpbmcgZGV2aWNlLiBJIHdpbGwg
YWRkIGl0IGluIFYzLgoKSmF2aWVyCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=
