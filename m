Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD062C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 12:41:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D4564FDF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 12:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D4564FDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mFTpE9yqig+0VgMlAwNgK8KSdqCOjdse/v19AemX664=; b=ljeVdU0U/Pj5knXwsD4xSVrBj
	QphSqhiNar5Nbb26TatsLyfxHckSQa9O+T0+s6bLreNHIXwmVchNxf4FWxceXxtcfwE02mKktd9NV
	4Z4P5DU0si1eYnG6Xkw1kJSmq3YL8oINHaj6zQU2D8A0J0t7bucSTLr+xw9OwWkDCg4BWwp5Ebr+j
	Iea48eZxcc9TE/YK83GTLVeW5h9/D4QruddKOZoGsRiqv/85RzfVTkCVP3xWScu5G62T+YaxENLQD
	mqN6kNX06pL5IqH3WUmkmP8DROM4niIpn10QsvDt46pQgmTlFP1/FB53y3UgcEGyh5zBFhw2JRIkc
	TxAJjK6Sw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKKcx-0098Ym-H8; Thu, 11 Mar 2021 12:41:19 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKKct-0098Xx-EO
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 12:41:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CFD85AC16
 for <linux-nvme@lists.infradead.org>; Thu, 11 Mar 2021 12:41:14 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
To: linux-nvme@lists.infradead.org
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
 <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
 <20201006082727.GC10243@lst.de>
 <a848297e-3243-6366-86ee-0800d51198e1@suse.de>
 <20201006083926.GA13568@lst.de>
 <00e75643-d422-ca12-1648-02ca89044182@suse.de>
 <20201006174100.GA959043@dhcp-10-100-145-180.wdl.wdc.com>
 <68ca5a63-e6e3-be5a-4b60-bd9db52ac9c1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <526fbe54-cbc8-383a-c087-09018ac9b2a8@suse.de>
Date: Thu, 11 Mar 2021 13:41:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <68ca5a63-e6e3-be5a-4b60-bd9db52ac9c1@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_124115_571315_BE359E6F 
X-CRM114-Status: GOOD (  20.00  )
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

T24gMy81LzIxIDk6MTEgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IEkgdGhpbmsgd2hh
dCB5b3UncmUgc2hvd2luZyBpcyBhIHByb2JsZW0gZm9yIGV2ZXJ5b25lLCBpbmNsdWRpbmcKPj4g
ZmFicmljcy4gVGhlIG5hbWVzcGFjZSB3YXMgYXR0YWNoZWQgdG8gdGhlIHByZXZpb3VzbHkgZXhp
c3RpbmcKPj4gc3Vic3lzdGVtLCBudm1lMSwgYnV0IHdlIGRpZG4ndCBmaW5kIHRoZSBwcmV2aW91
c2x5IGV4aXN0aW5nICJoZWFkIiB0bwo+PiByZWF0dGFjaCB0aGUgbmFtZXNwYWNlLgo+Pgo+PiBJ
IGp1c3QgdGhyZXcgdGhlIGJlbG93IHRvZ2V0aGVyIHZlcnkgaGFzdGlseSwgc28gSSdtIHN1cmUg
dGhlcmUncwo+PiBzb21ldGhpbmcgd3Jvbmcgd2l0aCBpdCwgYnV0IGp1c3QgdG8gY2FwdHVyZSB3
aGF0J3Mgd3Jvbmcgd2l0aCB0aGUKPj4gY3VycmVudCBjb2RlOgo+Pgo+PiAtLS0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Ywo+PiBpbmRleCAzODMzNTg0YjVjZWUuLjBiM2JiYmU2ZDFlOCAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+
PiBAQCAtMzg5Nyw4ICszODk3LDYgQEAgc3RhdGljIHZvaWQgbnZtZV9uc19yZW1vdmUoc3RydWN0
IG52bWVfbnMgKm5zKQo+PiDCoCDCoMKgwqDCoMKgIG11dGV4X2xvY2soJm5zLT5jdHJsLT5zdWJz
eXMtPmxvY2spOwo+PiDCoMKgwqDCoMKgIGxpc3RfZGVsX3JjdSgmbnMtPnNpYmxpbmdzKTsKPj4g
LcKgwqDCoCBpZiAobGlzdF9lbXB0eSgmbnMtPmhlYWQtPmxpc3QpKQo+PiAtwqDCoMKgwqDCoMKg
wqAgbGlzdF9kZWxfaW5pdCgmbnMtPmhlYWQtPmVudHJ5KTsKPiAKPiBOb3QgcmVtb3ZpbmcgaXQg
ZXZlciBmcm9tIHRoZSBoZWFkLT5saXN0Pwo+IAo+PiDCoMKgwqDCoMKgIG11dGV4X3VubG9jaygm
bnMtPmN0cmwtPnN1YnN5cy0+bG9jayk7Cj4+IMKgIMKgwqDCoMKgwqAgc3luY2hyb25pemVfcmN1
KCk7IC8qIGd1YXJhbnRlZSBub3QgYXZhaWxhYmxlIGluIGhlYWQtPmxpc3QgKi8KPj4gLS0gCj4g
Cj4gVGhpcyBpcyBhIHByb2JsZW0uIGJlYWN1c2UgaWYgeW91IGRvbid0IHJlbW92ZSB0aGUgbnMg
ZnJvbSB0aGUKPiBoZWFkLT5saXN0IG5vdGhpbmcgcHJldmVudHMgaXQgZnJvbSBiZWluZyByZS1z
ZWxlY3RlZCBhcyB0aGUKPiBjdXJyZW50X3BhdGggYWZ0ZXIgd2Ugc3luY2hyb25pemUgdGhlIHNy
Y3UsIGFsdGhvdWdoIGl0IGlzIGdvaW5nIGF3YXkuLi4KPiAKWW91IG1pc3JlYWQgdGhlIHBhdGNo
LgpJJ20gbm90IHNraXBwaW5nIHRoZSByZW1vdmFsIGZyb20gJ2hlYWQtPmxpc3QnLCBJJ20gc2tp
cHBpbmcgdGhlIHJlbW92YWwKZnJvbSAnc3Vic3lzLT5uc2hlYWRzJyAod2hpY2ggaXMgd2hlcmUg
J2hlYWQtPmVudHJ5JyBpcyBwb2ludGluZyB0bykuCgoKQnV0IEknbGwgYmUgc2VuZGluZyBhbiB1
cGRhdGVkIHBhdGNoIHdoaWNoIGNsYXJpZmllcyB0aGlzIHNpdHVhdGlvbi4KCkNoZWVycywKCkhh
bm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBB
cmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2
ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTD
tnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
