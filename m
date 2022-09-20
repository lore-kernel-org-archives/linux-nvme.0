Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFA0C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lagsoi79YjwrN1LgIufByL9cxQR3QmAtK9z0CFrDx5k=; b=bqs841weqGxbBdfyySqPljHw7Z
	Gmw0V/oUfWmqAw5hr9fGDaX3Pv7YlfyOPKH5Smlj/e1JOTtUv8AW1Xm76dfVrxhREjDqu+mwEHYAZ
	z2FpEJhG2tDOTWfQLucvjMvsEzDOg+Z+B7npadDrVgVKYGqdoq+ZES7kKiaDU3dU2uRE24vENjpvP
	mnLFSs51E8n3FrbqYX4gSH98ztf1zWbz7gAqEcIaqePsj0qIUeT7NI7nacA8JpcTOjlM30InwxyEo
	UgbJXlpVZnbHJH+hYoKAz/x9fxTHrNU/hwtnZJ7OkHAmgIFr2TRbQHgxThPupw9+MCwheZmvmkvIl
	BD5GNa8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oajJX-00686z-Sa; Tue, 20 Sep 2022 19:53:51 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oajJU-00684Z-0P
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 19:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663703628; x=1695239628;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=Lagsoi79YjwrN1LgIufByL9cxQR3QmAtK9z0CFrDx5k=;
  b=NXXloNiviMxIgz4SgwIZeeMDPP7onHbWYCY5g41t28fSDKGFzNEHV7bm
   aecP3sJrnrfYi9t9I8pVU/17zoxWj1FFsQVxceb/gubQeM+Gmxmgz24c6
   RDk4K+Fuka7e9OA5yNydvUbFaLk15HpH7Yck2EhH3kqfqk6PGa/rpEJ+7
   I=;
X-IronPort-AV: E=Sophos;i="5.93,331,1654560000"; 
   d="scan'208";a="246652419"
Subject: Re: "nvme nvmeX: IO queues not created" with "Amazon.com,
 Inc. NVMe SSD Controller" from 5.19.y (issue bisected)
Thread-Topic: "nvme nvmeX: IO queues not created" with "Amazon.com,
 Inc. NVMe SSD Controller" from 5.19.y (issue bisected)
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:53:43 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com (Postfix) with ESMTPS id D3FE581A16;
	Tue, 20 Sep 2022 19:53:42 +0000 (UTC)
Received: from EX19D012UWB003.ant.amazon.com (10.13.138.41) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 20 Sep 2022 19:53:42 +0000
Received: from EX19D042UWB003.ant.amazon.com (10.13.139.135) by
 EX19D012UWB003.ant.amazon.com (10.13.138.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 20 Sep 2022 19:53:42 +0000
Received: from EX19D042UWB003.ant.amazon.com ([fe80::f8ec:de48:8e93:4187]) by
 EX19D042UWB003.ant.amazon.com ([fe80::f8ec:de48:8e93:4187%5]) with mapi id
 15.02.1118.012; Tue, 20 Sep 2022 19:53:42 +0000
From: "Dutta, Soumyaroop" <duttaso@amazon.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, "Sironi, Filippo"
	<sironi@amazon.de>, Christoph Hellwig <hch@lst.de>, Jaroslav Pulchart
	<jaroslav.pulchart@gooddata.com>, "Greenberg, Aviv" <aggreenb@amazon.com>,
	"Priescu, Valentin" <priescuv@amazon.de>, "Machulsky, Zorik"
	<zorik@amazon.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"niklas.cassel@wdc.com" <niklas.cassel@wdc.com>
Thread-Index: AQHYwoNPj8Tyb1j+Nk+7wft2AMLbIa3T0K8AgAAMsICAFEgOAIAANZCA
Date: Tue, 20 Sep 2022 19:53:42 +0000
Message-ID: <63C5A47C-A882-4B6F-9AE3-2D4780248690@amazon.com>
References: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
 <20220907062919.GA21266@lst.de>
 <010D1898-D943-44D6-9EB3-44E599F8AE84@amazon.de>
 <3E46620F-C371-4108-9A74-AA1A624AA9A5@amazon.de>
 <18e67378-1365-5e36-981b-13cada73bcda@leemhuis.info>
In-Reply-To: <18e67378-1365-5e36-981b-13cada73bcda@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.161.242]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ED926784438F741A0A4DC0C938C35C4@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_125348_209589_85BCE63B 
X-CRM114-Status: GOOD (  25.98  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGVsbG8sDQoNCldlIGFwb2xvZ2l6ZSBmb3IgdGhlIGRlbGF5ZWQgcmVwbHkuIE91ciBJbnZlc3Rp
Z2F0aW9uIGFuZCB0ZXN0aW5nIG9mIHRoZSBwcm9wb3NlZCBmaXggaGFkIGNvbmNsdWRlZCBzaW5j
ZSB0aGVuLiANCldlIElkZW50aWZpZWQgYSBsYXRlbnQgaXNzdWUgaW4gb3VyIE5WTWUgQ29udHJv
bGxlciBmaXJtd2FyZSB0aGF0LCBjb3VwbGVkIHdpdGggdGhlIHJlY2VudCBjaGFuZ2VzIGluIExp
bnV4IDUuMTkgcmVzdWx0ZWQgaW50byB0aGUgSU8gcXVldWVzIG5vdCBiZWluZyBjcmVhdGVkIGFm
dGVyIGNvbnRyb2xsZXIgZW5hYmxlbWVudC4NCldlIGhhdmUgaWRlbnRpZmllZCB0aGUgZml4LCBh
bmQgaGF2ZSBpdCB0ZXN0ZWQgdGhyb3VnaCBkaWZmZXJlbnQgdmVyc2lvbnMuIFRoZSBuZXcgcmVs
ZWFzZSwgd2hpY2ggaW5jbHVkZXMgdGhpcyBmaXggaXMgbm93IHVuZGVyIGRlcGxveW1lbnQsIGFu
ZCBzaG91bGQgYmUgYXZhaWxhYmxlIGFjcm9zcyB0aGUgQVdTIGZsZWV0IG92ZXIgdGhlIG5leHQg
ZmV3IHdlZWtzLg0KDQpUaGFua3MNClNvdW15YXJvb3ANCg0K77u/T24gOS8yMC8yMiwgMjo0MiBB
TSwgIlRob3JzdGVuIExlZW1odWlzIiA8cmVncmVzc2lvbnNAbGVlbWh1aXMuaW5mbz4gd3JvdGU6
DQoNCiAgICBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRo
ZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KDQoNCg0KICAgIEhpLCB0aGlzIGlzIHlvdXIgTGludXgga2VybmVsIHJlZ3Jlc3Npb24g
dHJhY2tlci4NCg0KICAgIE9uIDA3LjA5LjIyIDExOjU4LCBTaXJvbmksIEZpbGlwcG8gd3JvdGU6
DQogICAgPiBBZGRpbmcgbW9yZSBmb2xrcyAoU291bXlhcm9vcCwgVmFsZW50aW4sIGFuZCBab3Jp
aykgaW52b2x2ZWQgaW4gdGhlIGludmVzdGlnYXRpb24sIHdoaWNoIGlzIGJ5IG5vdyBjb25jbHVk
ZWQuDQoNCiAgICBIYXMgYW55IHByb2dyZXNzIGJlZW4gbWFkZSB0byBnZXQgdGhpcyByZWdyZXNz
aW9uIGZpeGVkPyBJIG1pZ2h0IGJlDQogICAgbWlzc2luZyBzb21ldGhpbmcsIGJ1dCBmcm9tIGhl
cmUgaXQgbG9va3MgbGlrZSBub3RoaW5nIGhhcHBlbmVkIHNpbmNlDQogICAgdHdvIHdlZWtzLiBU
aGluZyBpczogaWRlYWxseSBpdCBzaG91bGRuJ3QgdGFrZSB0aGlzIGxvbmcgdG8gZml4DQogICAg
cmVncmVzc2lvbnMgaW4gcHJvZHVjdGlvbiByZWxlYXNlcywgYXMgZXhwbGFpbmVkIGluDQogICAg
aHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9oYW5kbGluZy1yZWdyZXNzaW9ucy5odG1s
DQoNCiAgICBDaWFvLCBUaG9yc3RlbiAod2VhcmluZyBoaXMgJ3RoZSBMaW51eCBrZXJuZWwncyBy
ZWdyZXNzaW9uIHRyYWNrZXInIGhhdCkNCg0KICAgIFAuUy46IEFzIHRoZSBMaW51eCBrZXJuZWwn
cyByZWdyZXNzaW9uIHRyYWNrZXIgSSBkZWFsIHdpdGggYSBsb3Qgb2YNCiAgICByZXBvcnRzIGFu
ZCBzb21ldGltZXMgbWlzcyBzb21ldGhpbmcgaW1wb3J0YW50IHdoZW4gd3JpdGluZyBtYWlscyBs
aWtlDQogICAgdGhpcy4gSWYgdGhhdCdzIHRoZSBjYXNlIGhlcmUsIGRvbid0IGhlc2l0YXRlIHRv
IHRlbGwgbWUgaW4gYSBwdWJsaWMNCiAgICByZXBseSwgaXQncyBpbiBldmVyeW9uZSdzIGludGVy
ZXN0IHRvIHNldCB0aGUgcHVibGljIHJlY29yZCBzdHJhaWdodC4NCg0KICAgICNyZWd6Ym90IHBv
a2UNCg0KICAgID4gT24gMDcuMDkuMjIsIDExOjEzLCAiU2lyb25pLCBGaWxpcHBvIiA8c2lyb25p
QGFtYXpvbi5kZT4gd3JvdGU6DQogICAgPg0KICAgID4gICAgIEknbSBhd2FyZSBvZiBhIGN1c3Rv
bWVyIGNvbnRhY3QgcmVnYXJkaW5nIHRoaXMgaXNzdWUgYW5kIEkga25vdyB0aGF0IHRoZSB0ZWFt
IHJlc3BvbnNpYmxlIGZvciB0aGUgTlZNZSBpbXBsZW1lbnRhdGlvbiBpcyBpbnZlc3RpZ2F0aW5n
Lg0KICAgID4gICAgIEFkZGluZyBBdml2IHNpbmNlIGhlJ3MgY2xvc2VyIHRvIHRoaXMgc3BhY2Ug
dGhhbiBJIGFtIGFuZCBtYXkgaGF2ZSBtb3JlIGluc2lnaHRzIGludG8gaG93IHRoZSBpbnZlc3Rp
Z2F0aW9uIGlzIHByb2dyZXNzaW5nLg0KICAgID4NCiAgICA+ICAgICBPbiAwNy4wOS4yMiwgMDg6
MzAsICJDaHJpc3RvcGggSGVsbHdpZyIgPGhjaEBsc3QuZGU+IHdyb3RlOg0KICAgID4NCiAgICA+
ICAgICAgICAgQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0
aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCiAgICA+DQogICAgPg0KICAgID4NCiAgICA+ICAgICAgICAgRmlsaXBwbywNCiAgICA+
DQogICAgPiAgICAgICAgIGNhbiB5b3UgaGVscCBmaWd1cmluZyBvdXQgd2hhdCBpcyBnb2luZyBv
biB3aXRoIHRoaXMgQW1hem9uIGNvbnRyb2xsZXI/DQogICAgPg0KICAgID4gICAgICAgICBPbiBX
ZWQsIFNlcCAwNywgMjAyMiBhdCAwODowNTowNUFNICswMjAwLCBKYXJvc2xhdiBQdWxjaGFydCB3
cm90ZToNCiAgICA+ICAgICAgICAgPiBIZWxsbywNCiAgICA+ICAgICAgICAgPg0KICAgID4gICAg
ICAgICA+IEkgd291bGQgbGlrZSB0byByZXBvcnQgYSByZWdyZXNzaW9uIGlzc3VlIGluIDUuMTku
eSBpbiBOVk1lIGRyaXZlci4NCiAgICA+ICAgICAgICAgPg0KICAgID4gICAgICAgICA+IFRoZSBp
c3N1ZSBpcyByZXByb2R1Y2libGUgYXQgQVdTIEVDMiBpbnN0YW5jZXMgd2l0aCBsb2NhbCBOVk1l
IHN0b3JhZ2UNCiAgICA+ICAgICAgICAgPiBsaWtlICJyNWQuKiIuIEtlcm5lbCByZXBvcnQgIklP
IHF1ZXVlcyBub3QgY3JlYXRlZCI6DQogICAgPiAgICAgICAgID4gWyAgICAyLjkzNjY0MV0gbnZt
ZSBudm1lMDogMi8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzICA8LSBFQlMgdm9sdW1lDQog
ICAgPiAgICAgICAgID4gWyAgICAyLjkzOTQ5M10gbnZtZSBudm1lMTogMi8wLzAgZGVmYXVsdC9y
ZWFkL3BvbGwgcXVldWVzICA8LSBFQlMgdm9sdW1lDQogICAgPiAgICAgICAgID4gWyAgICAyLjk0
MDc5N10gbnZtZSBudm1lMjogSU8gcXVldWVzIG5vdCBjcmVhdGVkICAgICAgICAgICAgICA8LSBM
b2NhbCB2b2x1bWUNCiAgICA+ICAgICAgICAgPiB3aXRoIDUuMTkueSAoa2VybmVsIDUuMTkpIGFu
ZCB0aGUgbnZtZSBzdG9yYWdlIGNhbm5vdCBiZSB1c2VkLg0KICAgID4gICAgICAgICA+DQogICAg
PiAgICAgICAgID4gSSBiaXNlY3RlZCB0aGUgaXNzdWUgdG8gY29tbWl0DQogICAgPiAgICAgICAg
ID4gImFhNDFkMmZlNjBlZTJlNDQ1MmIwZjljYTlmMGY2ZDgwYTRmZjlmOWQiIChudm1lOiBzZXQg
Y29udHJvbGxlcg0KICAgID4gICAgICAgICA+IGVuYWJsZSBiaXQgaW4gYSBzZXBhcmF0ZSB3cml0
ZSkuIFJldmVydGluZyBpdCBtYWtlcyB0aGUgbnZtZSBkZXZpY2UNCiAgICA+ICAgICAgICAgPiB3
b3JraW5nIGFnYWluOg0KICAgID4gICAgICAgICA+IFsgICAgMy4wMjU1OTldIG52bWUgbnZtZTA6
IDIvMC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcw0KICAgID4gICAgICAgICA+IFsgICAgMy4w
MzI0NjddIG52bWUgbnZtZTI6IDgvMC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcw0KICAgID4g
ICAgICAgICA+IFsgICAgMy4wNDAwNDBdIG52bWUgbnZtZTE6IDIvMC8wIGRlZmF1bHQvcmVhZC9w
b2xsIHF1ZXVlcw0KICAgID4gICAgICAgICA+DQogICAgPiAgICAgICAgID4gQmVzdCwNCiAgICA+
ICAgICAgICAgPiAtLQ0KICAgID4gICAgICAgICA+IEphcm9zbGF2IFB1bGNoYXJ0DQogICAgPiAg
ICAgICAgID4gU3IuIFByaW5jaXBhbCBTVyBFbmdpbmVlcg0KICAgID4gICAgICAgICA+IEdvb2RE
YXRhDQogICAgPiAgICAgICAgIC0tLWVuZCBxdW90ZWQgdGV4dC0tLQ0KICAgID4NCiAgICA+DQog
ICAgPg0KICAgID4NCiAgICA+DQogICAgPiBBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1h
bnkgR21iSA0KICAgID4gS3JhdXNlbnN0ci4gMzgNCiAgICA+IDEwMTE3IEJlcmxpbg0KICAgID4g
R2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcw0K
ICAgID4gRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJC
IDE0OTE3MyBCDQogICAgPiBTaXR6OiBCZXJsaW4NCiAgICA+IFVzdC1JRDogREUgMjg5IDIzNyA4
NzkNCiAgICA+DQogICAgPg0KDQo=

