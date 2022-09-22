Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B52C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eou0ikRWzj/VkLZJkdubOcpKqZ/XCCFJnONZ7TErgO4=; b=vG5QRwZWWDa8TkgpdvUbrm1Waz
	DgAxk83HMWE2hemoWkbSVs0oaciN+Zmy5VUQjWi+gEXf5rIHlwgG4Lycylsao60CtGyq3UUL/nAxF
	IX0q0T00Jd+bahiPAvPRPvy8pV2NpULVWc6TrtlC7+Dz7mnVOk22LDsrwMSbfzj7EPekRK/8dtWE/
	3Y9YhsapClm7hVPWUOIWEFzWKD0eI4Mrj0UMJSF4S2auCW8ciVX+qgYAUfjzLBUKwe0dPFVsNV8jj
	Dc+ns6Xyl5E/33p7QeJW43EEI/t7/169EhiD1BazePoycCrEU7Y7/25trPYywkbz/F9uRERIyGAj7
	6z7A37tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQaR-00HE7w-Fw; Thu, 22 Sep 2022 18:06:11 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQaO-00HE4t-Te
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 18:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663869969; x=1695405969;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=eou0ikRWzj/VkLZJkdubOcpKqZ/XCCFJnONZ7TErgO4=;
  b=pMEX9upTJGskTkSvKeI4uqN2ZP5nqWe+cQ2b8iaguheWQFTWtni3Cyww
   7qfpd2Kc/6MugU+TrSm1SmQIL78EXirKGaJbvols190omFRURv2cSba1a
   c0uQTOzKNZNKz4zjulP7ibhuRKD81R47AplM6Wm/51JPj0PpBXTaq5giF
   k=;
Subject: Re: [PATCH] nvme-pci: Set min align mask before calculating max_hw_sectors
Thread-Topic: [PATCH] nvme-pci: Set min align mask before calculating max_hw_sectors
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1box-d-0e176545.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 18:06:03 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1box-d-0e176545.us-east-1.amazon.com (Postfix) with ESMTPS id DA6B08927D;
	Thu, 22 Sep 2022 18:06:01 +0000 (UTC)
Received: from EX19D012UWC002.ant.amazon.com (10.13.138.165) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 22 Sep 2022 18:06:01 +0000
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX19D012UWC002.ant.amazon.com (10.13.138.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 22 Sep 2022 18:06:01 +0000
Received: from EX19D002UWC004.ant.amazon.com ([fe80::f92f:5ec1:6ed3:7754]) by
 EX19D002UWC004.ant.amazon.com ([fe80::f92f:5ec1:6ed3:7754%4]) with mapi id
 15.02.1118.012; Thu, 22 Sep 2022 18:06:01 +0000
From: "Bhatnagar, Rishabh" <risbhat@amazon.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"Bacco, Mike" <mbacco@amazon.com>
Thread-Index: AQHYzSXrGcZlfkaEIUSpSTnvXbRMzq3piRAAgAFtQICAAFX8AA==
Date: Thu, 22 Sep 2022 18:06:00 +0000
Message-ID: <529ACE8D-95AF-46D6-B449-30C7AD815AEC@amazon.com>
References: <20220920191932.22797-1-risbhat@amazon.com>
 <871c0e19-9272-e92b-28dc-a50ae705bba8@grimberg.me>
 <20220922055815.GA27619@lst.de>
In-Reply-To: <20220922055815.GA27619@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.161.179]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5AC30DBE291D64C9C786C65323948CE@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_110609_128442_4709F0B5 
X-CRM114-Status: GOOD (  17.87  )
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

DQoNCu+7v09uIDkvMjEvMjIsIDEwOjU4IFBNLCAiQ2hyaXN0b3BoIEhlbGx3aWciIDxoY2hAbHN0
LmRlPiB3cm90ZToNCg0KICAgIENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91
dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUuDQoNCg0KDQogICAgT24gV2VkLCBTZXAgMjEsIDIwMjIgYXQgMTE6MTA6
NThBTSArMDMwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCiAgICA+DQogICAgPj4gSWYgc3dpb3Rs
YiBpcyBmb3JjZSBlbmFibGVkIGRtYV9tYXhfbWFwcGluZ19zaXplIGVuZHMgdXAgY2FsbGluZw0K
ICAgID4+IHN3aW90bGJfbWF4X21hcHBpbmdfc2l6ZSB3aGljaCB0YWtlcyBpbnRvIGFjY291bnQg
dGhlIG1pbiBhbGlnbg0KICAgID4+IG1hc2sgZm9yIHRoZSBkZXZpY2UuDQogICAgPj4gU2V0IHRo
ZSBtaW4gYWxpZ24gbWFzayBmb3IgbnZtZSBkcml2ZXIgYmVmb3JlIGNhbGxpbmcNCiAgICA+PiBk
bWFfbWF4X21hcHBpbmdfc2l6ZSB3aGlsZSBjYWxjdWxhdGluZyBtYXggaHcgc2VjdG9ycy4NCiAg
ICA+DQogICAgPiBEb2VzIHRoaXMgZml4IGEgc3BlY2lmaWMgYnVnPyBpZiBzbyBpdCBuZWVkcyBh
IGZpeGVzIHRhZyBzbyBpdCBjYW4NCiAgICA+IGdvIHRvIHN0YWJsZSBiYWNrcG9ydHMgYXMgd2Vs
bC4NCg0KICAgIEhtbS4gIEJhc2ljYWxseSB0aGlzIGlzIGFub3RoZXIgZml4bGV0IGZvciBudm1l
IG9uIHN3aW90bGIsIHdoaWNoDQogICAgYWxyZWFkeSBkcm92ZSBhZGRpbmcgdGhlIG1heF9tYXBw
aW5nIHNpemUgYW5kIHRoZSBhbGlnbl9tYXNrLCBhbmQNCiAgICBpdCBzZWVtcyB3ZSBzdGlsbCBo
YWRuJ3QgY292ZXJlZCBhbGwgY29ybmVyIGNhc2VzIHByb3Blcmx5LiAgU28NCiAgICBJIHRoaW5r
IGl0IGJhc2ljYWxseSBoYXMgYmVlbiBicm9rZW4gc2luY2UgZGF5IDEsIGJ1dCBudm1lIG9uDQog
ICAgc3dpb3RsYiBvbmx5IHN0YXJ0ZWQgYmVjb21pbmcgImludGVyZXN0aW5nIiB3aXRoIHRoZSB0
cnVzdGVkDQogICAgaHlwZXJ2aXNvciBzY2hlbWVzLg0KDQpZZXMgdGhpcyBmaXhlcyBhIGJ1ZyB0
aGF0IHdlIHNhdyBpbiBudm1lIGRyaXZlcihhZnRlciBlbmFibGluZyBzd2lvdGxiKSB0aGF0IHJl
c2VtYmxlcyB3aGF0IHdhcw0KZml4ZWQgaW4gODI4MDY3NDRmZDdkZGU2MDNiNjRjMTUxZWVkZGFh
NGVlNjIxOTNmZC4gQnV0IG5vdCBzZXR0aW5nIHRoZQ0KbWluX2FsaWduX21hc2sgYmVmb3JlIGRl
cml2aW5nIG1heCBodyBzZWN0b3JzIHdhcyBjYXVzaW5nIHRoZSBidWcgdG8gc3RpbGwgZXhpc3Qu
DQpBbHNvIHdlIHdvdWxkIHByb2JhYmx5IG5lZWQgdG8gYmFja3BvcnQgdGhlIGFib3ZlIGZpeCBh
bG9uZyB3aXRoICg4MjgwNjc0NGZkN2RkZTYwM2I2NGMxNTFlZWRkYWE0ZWU2MjE5M2ZkKQ0KdG8g
NS4xMCBhbmQgNS4xNSBrZXJuZWxzLiBMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluayBpcyB0aGUg
YmVzdCB3YXkgdG8gYWNoaWV2ZSB0aGF0Lg0KDQo=

