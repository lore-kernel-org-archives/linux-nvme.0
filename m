Return-Path: <SRS0=mwZ5=XZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32574C32792
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2019 15:16:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18222168B
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2019 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XY9HoYzy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="aRIai4eZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18222168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HINQ2jB1jNUXVr3PGdM3Uv/KFrhA7emxC3OG7FLGZI4=; b=XY9HoYzy4aKBye
	4xjuZ6DIKNzViUJft9DftT1dvMhnMeKu6m6Ok4Uh5ufOAykIFQycvuacJd258LWlkSFmpWpsIG2xK
	9031Z+/1tnzTu7z4P6Fzd0SU9tYf277DEkk5cZreWYnXApKnF3F2Trpu5ONuUY65NKHbpbboHeoRQ
	HAF3HYBj664amVoEWghrACgCWS5b+4lId2zyFUdUBOYlC7zAov6g2USS0TmK1BScayBeoDr1P0o80
	PgwGofDFykrzgxQ/JeelvlkpvPDa511dLEIdfUdOpBHkzbki6Jf0ieWM0hh9cpNJl64/9Ui3exr3n
	C1AZXpDE2gljCKU4444w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iExPx-0000mU-2P; Mon, 30 Sep 2019 15:16:53 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iExPp-0000Sq-TJ
 for linux-nvme@lists.infradead.org; Mon, 30 Sep 2019 15:16:48 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 206A7435D5;
 Mon, 30 Sep 2019 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 mime-version:content-transfer-encoding:content-id:content-type
 :content-type:content-language:accept-language:in-reply-to
 :references:message-id:date:date:subject:subject:from:from
 :received:received:received:received; s=mta-01; t=1569856603; x=
 1571671004; bh=ovZZkEVqXtEroBZ1AOBlplT/NEYMfy5tmRI2ADlJNhc=; b=a
 RIai4eZgRNwzKFJv2DyRbGGg83qE4cmVRw1Mgryjo34Bu5a8I1mlEItutTr8QWQq
 wOn1UdFf0uK6+5RcIOvCOUag8HXjpdqGEecdR+/vxRgkSr/amJgAzrcGE0WmXKku
 3vDVqzRJZdyDz/ERnQJoWE6x9FDAYunFvHFHNlbW6U=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FDwBlcelOLml; Mon, 30 Sep 2019 18:16:43 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 1F24442A12;
 Mon, 30 Sep 2019 18:16:42 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (172.17.10.102) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 30 Sep 2019 18:16:42 +0300
Received: from T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23]) by
 T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23%14]) with mapi id
 15.01.0669.032; Mon, 30 Sep 2019 18:16:42 +0300
From: Mikhail Malygin <m.malygin@yadro.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: add revalidate ns sysfs attribute to handle device
 resize
Thread-Topic: [PATCH] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Thread-Index: AQHVdMDpMOVid6ObfESE49mZGTeIcKc/lPuAgASTWQA=
Date: Mon, 30 Sep 2019 15:16:42 +0000
Message-ID: <61441646-BB45-4F84-A370-CE7E02415172@yadro.com>
References: <20190926231940.7494-1-m.malygin@yadro.com>
 <80c2509b-bd48-c3c4-13bf-8ad6b1c0f77a@grimberg.me>
In-Reply-To: <80c2509b-bd48-c3c4-13bf-8ad6b1c0f77a@grimberg.me>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.128.132]
Content-ID: <186262B45C0C5C47AA8F6D6B1CE9719D@yadro.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190930_081646_264418_C7649790 
X-CRM114-Status: GOOD (  11.17  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SnVzdCBwb3N0ZWQgYW4gdXBkYXRlZCB2ZXJzaW9uIHdpdGggc2l6ZSBjaGVjayBiZWZvcmUgdHJp
Z2dlcmluZyBuc19jaGFuZ2VkLg0KDQpSZWdhcmRpbmcgdGhlIG1vZGVsLCBJ4oCZbSBtYW5hZ2lu
ZyBib3RoIGJsb2NrIGRldmljZXMgYW5kIHRhcmdldHMgZnJvbSB1c2Vyc3BhY2UgZGFlbW9uLCBz
bw0KanVzdCBuZWVkIGFueSByZWxpYWJsZSB3YXkgdG8gdXBkYXRlIHRhcmdldCBucyBzaXplIG9u
Y2UgSSByZXNpemVkIGJsb2NrIGRldmljZS4NCg0KPiBPbiAyNyBTZXAgMjAxOSwgYXQgMjA6MjQs
IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+IHdyb3RlOg0KPiANCj4gDQo+PiAraW50
IG52bWV0X25zX3JldmFsaWRhdGUoc3RydWN0IG52bWV0X25zICpucykNCj4+ICt7DQo+PiArCXN0
cnVjdCBudm1ldF9zdWJzeXMgKnN1YnN5cyA9IG5zLT5zdWJzeXM7DQo+PiArCWludCByZXQgPSAw
Ow0KPj4gKw0KPj4gKwltdXRleF9sb2NrKCZzdWJzeXMtPmxvY2spOw0KPj4gKwlpZighbnMtPmVu
YWJsZWQpew0KPj4gKwkJZ290byBvdXRfdW5sb2NrOw0KPj4gKwl9DQo+PiArDQo+PiArCWlmKG5z
LT5iZGV2KXsNCj4+ICsJCXJldCA9IG52bWV0X2JkZXZfbnNfcmV2YWxpZGF0ZShucyk7DQo+PiAr
CX1lbHNlIGlmKG5zLT5maWxlKXsNCj4+ICsJCXJldCA9IG52bWV0X2ZpbGVfbnNfcmV2YWxpZGF0
ZShucyk7DQo+PiArCX0NCj4+ICsNCj4+ICsJbnZtZXRfbnNfY2hhbmdlZChzdWJzeXMsIG5zLT5u
c2lkKTsNCj4gDQo+IFNob3VsZG4ndCB0aGF0IGhhcHBlbiBvbmx5IG9mIHRoZSBzaXplIGNoYW5n
ZWQ/DQo+IA0KPiBTbyB3aGF0IGlzIHRoZSBtb2RlbCBoZXJlPyBoYXZlIHNvbWUgdWRldiBydWxl
IHRvDQo+IHRyaWdnZXIgdGhpcz8NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=
