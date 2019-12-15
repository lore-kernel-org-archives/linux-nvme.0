Return-Path: <SRS0=GgRz=2F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0478C43603
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 12:34:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1EE205C9
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 12:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qZXRUwO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1EE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=DvQqvC3yMDs8NQDZO5ylxtH+urHN1XBxz6WVaGVf8Hw=; b=qZXRUwO/uYtk6c
	HmhcZCTQpncgsFXp7RQGhM9HDZjqOh5BGhdsVk/UViTiPJpe1frAmxCSEhxSHQSOSeC9rqVH7RJjh
	GNg1Z0Vqii5P1TB4M473sWq1nglOPcs4H2Lv5cF80CEPPPIuPcm0slncG1iwBFiK5+J8k+vpox+s/
	DOJnh2kuxD/cPG3Ytg0nK0hffg+UeBZ4XyrKiN9WzCwMP6bTuZFwJWRcjGv8zq1lKxSpXcMfrLbl1
	/zrYzIJ17Yby/zgVC0jI0BTOoZtBwRB4MMTSbEd2f5ZimEXqfKYtYeAjLj26b9E2kgZ8buujlwC1Y
	a77CWGFt2UlnYnu1IZyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igT66-00057F-HK; Sun, 15 Dec 2019 12:34:06 +0000
Received: from ip-12-0-68-226-us.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igT63-00056i-AZ
 for linux-nvme@lists.infradead.org; Sun, 15 Dec 2019 12:34:05 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 15 Dec 2019 04:33:58 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::65fa:7220:c1b7:572e]) by
 SJSMAIL01.us.kioxia.com ([fe80::65fa:7220:c1b7:572e%3]) with mapi id
 15.01.1779.004; Sun, 15 Dec 2019 04:33:58 -0800
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, "James
 Smart" <james.smart@broadcom.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "james.smart@broadcom.com"
 <james.smart@broadcom.com>
Subject: RE: [PATCH] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH] nvme-fabrics: reject I/O to offline device
Thread-Index: AdWoHEM2hZCp1trGT5CqiIXVszcBJgBiTd2AAAZbKjAAHmVugAAOa+zgAGeWsYAALWm8AABQExWAACdLqzABJ7DY0A==
Date: Sun, 15 Dec 2019 12:33:58 +0000
Message-ID: <1d04ad0c20b9441b839e764666060213@kioxia.com>
References: <2caa40133c444771b706406b928ad88a@kioxia.com>
 <78d980de-b2b8-bd47-fc3f-20314653598e@broadcom.com>
 <c625b332ee124b038da1ae59b02f4e21@kioxia.com>
 <9a73a895-7d6b-21e9-9008-816117be1ff4@broadcom.com>
 <ac9b5d7192fb49ac9bdf19dd35be0ab2@kioxia.com>
 <4963e813-0d99-4890-804a-cd4c9c660607@broadcom.com>
 <ae027c0c-45ab-d412-11f3-39dcf3217434@grimberg.me>
 <e009d8fe-74ec-8c87-30ec-b1ac657b2aa8@suse.de> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191215_043403_365177_64716B27 
X-CRM114-Status: UNSURE (   9.35  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQpPbiAxMi85LzE5IDE3OjMwIFBNLCBWaWN0b3IgR2xhZGtvdiB3cm90ZToNCj4gDQo+IE9uIDEy
LzgvMTkgMTQ6MTggUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gPg0KPiA+IE9uIDEyLzYv
MTkgMTE6MTggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+ID4gPg0KLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCj4gPiA+IEkgdGhpbmsgd2UgbmVlZCBh
IGZhaWxfZmFzdF90bW8gc2V0IGluIHdoZW4gZXN0YWJsaXNoaW5nIHRoZQ0KPiA+ID4gY29udHJv
bGxlciB0byBnZXQgaXQgcmlnaHQuDQo+ID4gPg0KPiA+IEFncmVlZC4gVGhpcyB3aG9sZSBwYXRj
aCBsb29rcyBsaWtlIHNvbWVvbmUgaXMgdHJ5aW5nIHRvIHJlaW1wbGVtZW50DQo+ID4gZmFzdF9p
b19mYWlsX3RtbyAvIGRldl9sb3NzX3Rtby4NCj4gPiBBcyB3ZSdyZSBtb3ZpbmcgaW50byB1bnJl
bGlhYmxlIGZhYnJpY3MgSSBndWVzcyB3ZSdsbCBuZWVkIGEgc2ltaWxhcg0KPiBtZWNoYW5pc20u
DQo+ID4NCj4gPiBDaGVlcnMsDQo+ID4NCj4gPiBIYW5uZXMNCj4gDQo+IA0KPiBGb2xsb3dpbmcg
eW91ciBzdWdnZXN0aW9ucywgSSBhZGRlZCBhIG5ldyBzZXNzaW9uIHBhcmFtZXRlciBjYWxsZWQN
Cj4gImZhc3RfZmFpbF90bW8iLg0KPiBUaGUgdGltZW91dCBpcyBtZWFzdXJlZCBpbiBzZWNvbmRz
IGZyb20gdGhlIGNvbnRyb2xsZXIgcmVjb25uZWN0LCBhbnkNCj4gY29tbWFuZCBiZXlvbmQgdGhh
dCB0aW1lb3V0IGlzIHJlamVjdGVkLg0KPiBUaGUgbmV3IHBhcmFtZXRlciB2YWx1ZSBtYXkgYmUg
cGFzc2VkIGR1cmluZyDigJhjb25uZWN04oCZLCBhbmQgaXRzIGRlZmF1bHQNCj4gdmFsdWUgaXMg
MzAgc2Vjb25kcy4NCj4gQSB2YWx1ZSBvZiAtMSBtZWFucyBubyB0aW1lb3V0IChpbiBzaW1pbGFy
IHRvIGN1cnJlbnQgYmVoYXZpb3IpLg0KPiANCj4gLS0tDQo+IFJlZ2FyZHMsDQo+IFZpY3Rvcg0K
DQpKYW1lcywgSGFubmVzICYgU2FnaS4gDQpDYW4geW91IHBsZWFzZSByZXZpZXcgbGFzdCBwcm9w
b3NlZCBwYXRjaD8NCg0KUmVnYXJkcywNClZpY3Rvcg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
