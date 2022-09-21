Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EF6ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	CC:To:From:Subject:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+IrwkpfxYKVW5aMLap4I+PcjA9fvUd4sMbb/IHJrSxY=; b=q2fms6qzWUMx5IOI5pLhbkAHfI
	ePRxbX+2phrd5QVo0JYx4XLRBb4w1i0LaaTxFyjYqQqTABpOkJVx/sziJPuTLwU9s51DKIel3zbKA
	zzyeZ1+E/igVrcb9B53k86UmxcOPmew2dV2/tOlHPnm7WCwsARGu9Tjjbd/q1BF1QeiFxIKTSKqI/
	idXt1qUenDLWRTjucZ6oPegk6FBArVst3a6eVfHg1cAuuNfFAAbQD0A9tWhs9Z5vQsa17N/S0i0EE
	pxHHEPApWp092srinlAKByAcvy72yWgE3h4nOyR1J3a8tuvg62y+aqZew561y+rkiz0/oDyqCov9O
	pNHEaDfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oavac-00ABZz-Cz; Wed, 21 Sep 2022 09:00:18 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oavaW-00ABVw-0U
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:00:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1663750812; x=1695286812;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=+IrwkpfxYKVW5aMLap4I+PcjA9fvUd4sMbb/IHJrSxY=;
  b=bOwZcdl0YEE0LXwrcu4ibg4Z9ZbGW2HWOaARCxtEEGG4bQdwqFwGBZ+l
   sXtjupFN2gmbEVA/vxQACoTBZxNvHt715XjPPb5Lmov+zSNCIF1iQ3zmb
   6/sTvtQ1nBaVtHH1i0FLDcDXj24Fii13zZURaOcfm7ePQCZtOJR1hyCM5
   g=;
X-IronPort-AV: E=Sophos;i="5.93,332,1654560000"; 
   d="scan'208";a="227454461"
Subject: Re: "nvme nvmeX: IO queues not created" with "Amazon.com,
 Inc. NVMe SSD Controller" from 5.19.y (issue bisected)
Thread-Topic: "nvme nvmeX: IO queues not created" with "Amazon.com,
 Inc. NVMe SSD Controller" from 5.19.y (issue bisected)
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-b69ea591.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:59:50 +0000
Received: from EX13D01EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-b69ea591.us-east-1.amazon.com (Postfix) with ESMTPS id 56016C0967;
	Wed, 21 Sep 2022 08:59:49 +0000 (UTC)
Received: from EX19D010EUA001.ant.amazon.com (10.252.50.180) by
 EX13D01EUA004.ant.amazon.com (10.43.165.123) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 21 Sep 2022 08:59:48 +0000
Received: from EX19D002EUA002.ant.amazon.com (10.252.50.7) by
 EX19D010EUA001.ant.amazon.com (10.252.50.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 21 Sep 2022 08:59:48 +0000
Received: from EX19D002EUA002.ant.amazon.com ([fe80::e567:d848:f092:2483]) by
 EX19D002EUA002.ant.amazon.com ([fe80::e567:d848:f092:2483%3]) with mapi id
 15.02.1118.012; Wed, 21 Sep 2022 08:59:48 +0000
From: "Sironi, Filippo" <sironi@amazon.de>
To: Keith Busch <kbusch@kernel.org>, Thorsten Leemhuis
	<regressions@leemhuis.info>
CC: Christoph Hellwig <hch@lst.de>, Jaroslav Pulchart
	<jaroslav.pulchart@gooddata.com>, "Greenberg, Aviv" <aggreenb@amazon.com>,
	"Dutta, Soumyaroop" <duttaso@amazon.com>, "Priescu, Valentin"
	<priescuv@amazon.de>, "Machulsky, Zorik" <zorik@amazon.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"niklas.cassel@wdc.com" <niklas.cassel@wdc.com>
Thread-Index: AQHYwoNPj8Tyb1j+Nk+7wft2AMLbIa3T0K8AgAAMsICAFEgOAIAAp9wAgADvc4A=
Date: Wed, 21 Sep 2022 08:59:48 +0000
Message-ID: <99C2DE77-B354-4C20-A2CB-24DD2FF4825F@amazon.de>
References: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
 <20220907062919.GA21266@lst.de>
 <010D1898-D943-44D6-9EB3-44E599F8AE84@amazon.de>
 <3E46620F-C371-4108-9A74-AA1A624AA9A5@amazon.de>
 <18e67378-1365-5e36-981b-13cada73bcda@leemhuis.info>
 <YyoXtuHvGzCB2ZNT@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YyoXtuHvGzCB2ZNT@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.165.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C18FD02D1B66F4288682A8BBBD4ACEC@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_020012_165487_A230C224 
X-CRM114-Status: GOOD (  20.87  )
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

T24gMjAuMDkuMjIsIDIxOjU3LCAiS2VpdGggQnVzY2giIDxrYnVzY2hAa2VybmVsLm9yZz4gd3Jv
dGU6DQo+IE9uIFR1ZSwgU2VwIDIwLCAyMDIyIGF0IDExOjQxOjU4QU0gKzAyMDAsIFRob3JzdGVu
IExlZW1odWlzIHdyb3RlOg0KPiAgPiBIaSwgdGhpcyBpcyB5b3VyIExpbnV4IGtlcm5lbCByZWdy
ZXNzaW9uIHRyYWNrZXIuDQo+ICA+DQo+ICA+IE9uIDA3LjA5LjIyIDExOjU4LCBTaXJvbmksIEZp
bGlwcG8gd3JvdGU6DQo+ICA+ID4gQWRkaW5nIG1vcmUgZm9sa3MgKFNvdW15YXJvb3AsIFZhbGVu
dGluLCBhbmQgWm9yaWspIGludm9sdmVkIGluIHRoZSBpbnZlc3RpZ2F0aW9uLCB3aGljaCBpcyBi
eSBub3cgY29uY2x1ZGVkLg0KPiAgPg0KPiAgPiBIYXMgYW55IHByb2dyZXNzIGJlZW4gbWFkZSB0
byBnZXQgdGhpcyByZWdyZXNzaW9uIGZpeGVkPyBJIG1pZ2h0IGJlDQo+ICA+IG1pc3Npbmcgc29t
ZXRoaW5nLCBidXQgZnJvbSBoZXJlIGl0IGxvb2tzIGxpa2Ugbm90aGluZyBoYXBwZW5lZCBzaW5j
ZQ0KPiAgPiB0d28gd2Vla3MuIFRoaW5nIGlzOiBpZGVhbGx5IGl0IHNob3VsZG4ndCB0YWtlIHRo
aXMgbG9uZyB0byBmaXgNCj4gID4gcmVncmVzc2lvbnMgaW4gcHJvZHVjdGlvbiByZWxlYXNlcywg
YXMgZXhwbGFpbmVkIGluDQo+ICA+IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvaGFu
ZGxpbmctcmVncmVzc2lvbnMuaHRtbA0KPg0KPiAgVGhpcyBpcyBhIGRldmljZSBidWcsIG5vdCBh
IGtlcm5lbCBvbmUuIFRoZSBpZGVhbCBmaXggd2lsbCBjb21lIGZyb20gdGhlDQo+ICBkZXZpY2Un
cyB2ZW5kb3IgdG8gYnJpbmcgaXRzZWxmIGludG8gcHJvdG9jb2wgY29tcGxhaW5jZS4NCj4NCj4g
IFdlIGRvIHdvcmsgYXJvdW5kIHRoZXNlIHR5cGVzIG9mIHByb2JsZW1zIHdoZW4gbmVjZXNzYXJ5
LCBidXQgd2UgdXN1YWxseSB3YW50IGENCj4gIHN0YXRlbWVudCBmcm9tIHRoZSB2ZW5kb3IgdGhh
dCB0aGV5IGNhbid0L3dvbid0IGZpeCBpdCBiZWZvcmUgd2UgY3JlYXRlIG5ldw0KPiAgcXVpcmtz
IHRvIG1haW50YWluLiBUaGUgdmVuZG9yIGhhcyBzYWlkIHRoZXkgYXJlIGludmVzdGlnYXRpbmcg
dGhpcyBhbmQgd2lsbA0KPiAgdXBkYXRlIHdpdGggdGhlaXIgY29uY2x1c2lvbnMuIEFzIGZhciBh
cyBJIGtub3csIHRoZSBiYWxsIGlzIHN0aWxsIGluIHRoZWlyDQo+ICBjb3VydC4NCg0KU291bXlh
cm9vcCByZXBsaWVkIGEgZmV3IG1pbnV0ZXMgYmVmb3JlIHlvdXIgZW1haWwuDQoNClRoaXMgaGFz
IGJlZW4gcm9vdCBjYXVzZWQgdG8gYW4gTlZNZSBjb250cm9sbGVyIGZpcm13YXJlIGxhdGVudCBp
c3N1ZQ0KdGhhdCB3YXMgdW5jb3ZlcmVkIHdpdGggdGhlIHJlY2VudCBjaGFuZ2VzIGluIExpbnV4
IDUuMTkuIFdlIGlkZW50aWZpZWQNCmEgZml4IGZvciB0aGlzIGlzc3VlIGFuZCBpdCBpcyByb2xs
aW5nIG91dCBpbiBvdXIgZmxlZXQgYXMgd2Ugc3BlYWsuIFRoZQ0Kcm9sbG91dCB3aWxsIGZpbmlz
aCBpbiB0aGUgbmV4dCBmZXcgd2Vla3MuDQoNCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIg
R2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1
bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFt
dHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4K
VXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==


