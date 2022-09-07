Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509B0ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 09:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	CC:To:From:Subject:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oSlezLoJZSZzhODC5MyDmxUYVv45M+XLcgirBIOSllg=; b=CgSuXYDObVgXoSUPWMj5JvKPSt
	+/QUdIWt877yVpcOAPL7sv16wjEEcZJyZ2+8Als41nbtqZsWGfABPH7eRgJ1uFAGK64fbXEpFxzuy
	1+/lZIUyUr+LncCvRk2SHodfYhRunizX0TRT67l7fHN6pKvWKw5gxuzqqWxnJUyvAHD+T5Od7Dwv8
	XTzqtQC/PNRZIOzfUeCKEA7H6wiIPNOBP4S+v39agTk+18RfjbinZD6pZDQhEU4+S5at/fep0hDyc
	+p8I+efPatTOmxeuiRvuIwoIWwWzhgJyOYFYO1r5tltAiMfXGiG3izZ4p7rRjQCV4ueLfpSiQMNiW
	/yH9zNGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVrBY-004liO-6g; Wed, 07 Sep 2022 09:17:28 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVr80-004jG5-Q6
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 09:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1662542029; x=1694078029;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=oSlezLoJZSZzhODC5MyDmxUYVv45M+XLcgirBIOSllg=;
  b=H1UsME/0sCTmjssFkNfzxa5zTFfiYTRwh4sBQNGxc9jhYWoIoZ3aeuQS
   UzcDCLgJsbphrTEvV94C9IhmWO3xFz0GfTNyabs5IkZi3yeyhFqiZtiYQ
   2ksETozOPlvGcQ7AveKdEKAeKxG2M7mXTz4a/rQ0TEjMLZYJLr7RQvSqp
   Q=;
X-IronPort-AV: E=Sophos;i="5.93,296,1654560000"; 
   d="scan'208";a="238459615"
Subject: Re: "nvme nvmeX: IO queues not created" with "Amazon.com,
 Inc. NVMe SSD Controller" from 5.19.y (issue bisected)
Thread-Topic: "nvme nvmeX: IO queues not created" with "Amazon.com,
 Inc. NVMe SSD Controller" from 5.19.y (issue bisected)
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:13:32 +0000
Received: from EX13D02EUC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com (Postfix) with ESMTPS id 8D5F5453FE;
	Wed,  7 Sep 2022 09:13:30 +0000 (UTC)
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 7 Sep 2022 09:13:29 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1497.040;
 Wed, 7 Sep 2022 09:13:29 +0000
From: "Sironi, Filippo" <sironi@amazon.de>
To: Christoph Hellwig <hch@lst.de>, Jaroslav Pulchart
	<jaroslav.pulchart@gooddata.com>, "Greenberg, Aviv" <aggreenb@amazon.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"niklas.cassel@wdc.com" <niklas.cassel@wdc.com>
Thread-Index: AQHYwoNPj8Tyb1j+Nk+7wft2AMLbIa3T0K8A
Date: Wed, 7 Sep 2022 09:13:28 +0000
Message-ID: <010D1898-D943-44D6-9EB3-44E599F8AE84@amazon.de>
References: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
 <20220907062919.GA21266@lst.de>
In-Reply-To: <20220907062919.GA21266@lst.de>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.249]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECD71FBC7CDF7C458E662EF83CCEDBB3@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_021349_019856_4911E722 
X-CRM114-Status: GOOD (  18.06  )
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

SSdtIGF3YXJlIG9mIGEgY3VzdG9tZXIgY29udGFjdCByZWdhcmRpbmcgdGhpcyBpc3N1ZSBhbmQg
SSBrbm93IHRoYXQgdGhlIHRlYW0gcmVzcG9uc2libGUgZm9yIHRoZSBOVk1lIGltcGxlbWVudGF0
aW9uIGlzIGludmVzdGlnYXRpbmcuDQpBZGRpbmcgQXZpdiBzaW5jZSBoZSdzIGNsb3NlciB0byB0
aGlzIHNwYWNlIHRoYW4gSSBhbSBhbmQgbWF5IGhhdmUgbW9yZSBpbnNpZ2h0cyBpbnRvIGhvdyB0
aGUgaW52ZXN0aWdhdGlvbiBpcyBwcm9ncmVzc2luZy4gDQoNCu+7v09uIDA3LjA5LjIyLCAwODoz
MCwgIkNocmlzdG9waCBIZWxsd2lnIiA8aGNoQGxzdC5kZT4gd3JvdGU6DQoNCiAgICBDQVVUSU9O
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24u
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNv
bmZpcm0gdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0KICAg
IEZpbGlwcG8sDQoNCiAgICBjYW4geW91IGhlbHAgZmlndXJpbmcgb3V0IHdoYXQgaXMgZ29pbmcg
b24gd2l0aCB0aGlzIEFtYXpvbiBjb250cm9sbGVyPw0KDQogICAgT24gV2VkLCBTZXAgMDcsIDIw
MjIgYXQgMDg6MDU6MDVBTSArMDIwMCwgSmFyb3NsYXYgUHVsY2hhcnQgd3JvdGU6DQogICAgPiBI
ZWxsbywNCiAgICA+DQogICAgPiBJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IGEgcmVncmVzc2lvbiBp
c3N1ZSBpbiA1LjE5LnkgaW4gTlZNZSBkcml2ZXIuDQogICAgPg0KICAgID4gVGhlIGlzc3VlIGlz
IHJlcHJvZHVjaWJsZSBhdCBBV1MgRUMyIGluc3RhbmNlcyB3aXRoIGxvY2FsIE5WTWUgc3RvcmFn
ZQ0KICAgID4gbGlrZSAicjVkLioiLiBLZXJuZWwgcmVwb3J0ICJJTyBxdWV1ZXMgbm90IGNyZWF0
ZWQiOg0KICAgID4gWyAgICAyLjkzNjY0MV0gbnZtZSBudm1lMDogMi8wLzAgZGVmYXVsdC9yZWFk
L3BvbGwgcXVldWVzICA8LSBFQlMgdm9sdW1lDQogICAgPiBbICAgIDIuOTM5NDkzXSBudm1lIG52
bWUxOiAyLzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMgIDwtIEVCUyB2b2x1bWUNCiAgICA+
IFsgICAgMi45NDA3OTddIG52bWUgbnZtZTI6IElPIHF1ZXVlcyBub3QgY3JlYXRlZCAgICAgICAg
ICAgICAgPC0gTG9jYWwgdm9sdW1lDQogICAgPiB3aXRoIDUuMTkueSAoa2VybmVsIDUuMTkpIGFu
ZCB0aGUgbnZtZSBzdG9yYWdlIGNhbm5vdCBiZSB1c2VkLg0KICAgID4NCiAgICA+IEkgYmlzZWN0
ZWQgdGhlIGlzc3VlIHRvIGNvbW1pdA0KICAgID4gImFhNDFkMmZlNjBlZTJlNDQ1MmIwZjljYTlm
MGY2ZDgwYTRmZjlmOWQiIChudm1lOiBzZXQgY29udHJvbGxlcg0KICAgID4gZW5hYmxlIGJpdCBp
biBhIHNlcGFyYXRlIHdyaXRlKS4gUmV2ZXJ0aW5nIGl0IG1ha2VzIHRoZSBudm1lIGRldmljZQ0K
ICAgID4gd29ya2luZyBhZ2FpbjoNCiAgICA+IFsgICAgMy4wMjU1OTldIG52bWUgbnZtZTA6IDIv
MC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcw0KICAgID4gWyAgICAzLjAzMjQ2N10gbnZtZSBu
dm1lMjogOC8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzDQogICAgPiBbICAgIDMuMDQwMDQw
XSBudm1lIG52bWUxOiAyLzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMNCiAgICA+DQogICAg
PiBCZXN0LA0KICAgID4gLS0NCiAgICA+IEphcm9zbGF2IFB1bGNoYXJ0DQogICAgPiBTci4gUHJp
bmNpcGFsIFNXIEVuZ2luZWVyDQogICAgPiBHb29kRGF0YQ0KICAgIC0tLWVuZCBxdW90ZWQgdGV4
dC0tLQ0KDQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vu
c3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFl
Z2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVu
YnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4
NzkKCgo=


