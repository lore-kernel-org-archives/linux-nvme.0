Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19D4C021AD
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 08:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:Mime-Version:References:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=uWWKRY5OqdO+rjWbyCUqROOK8f0tsrcstsiLFGxs6lo=; b=2uCJhi8jDJfw6kCnWunsumRKtE
	dC5bFgU7+eaWKVZKuOhXb/iWdWbnnBhWiZ3bWoMGuJMnUz+VZ8LI17loeMGINxXXrxVzi/JR2alES
	BW0nVhFpqkT3VXAAQOXvhR3gUPQt7FIoniImTCETmMMSGdu9esoGOZrlaLEWVcHiwaEvQMEXVCgqk
	L1ea/MQEZxsA634eG+tsMHTYKPlrcAt07ByBqVSMau7tIPBCfsgiMmj39kFI/cKFy82L8b7i9+EJN
	BqAT5k7OfPiJjN+G3x2gvlXsfPCKiN/02Tg7wUDgxgsEjuV4b0tp/a1BoIkswJiWyJdAlU3cW4Fna
	Y0Q00NmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl1no-0000000HKcX-2x1f;
	Thu, 20 Feb 2025 08:21:00 +0000
Received: from [1.203.97.240] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl1nl-0000000HKbO-2w0V
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 08:20:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id CE4B7900114;
	Thu, 20 Feb 2025 16:20:51 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281458769654128S1740039650735091_;
	Thu, 20 Feb 2025 16:20:51 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: zhang.guanghui@cestc.cn
X-SENDER: zhang.guanghui@cestc.cn
X-LOGIN-NAME: zhang.guanghui@cestc.cn
X-FST-TO: sagi@grimberg.me
X-RCPT-COUNT: 8
X-LOCAL-RCPT-COUNT: 0
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 39.156.73.12
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <fd7484a0a686beb9490205984160b761>
X-System-Flag: 0
Date: Thu, 20 Feb 2025 16:20:49 +0800
From: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>
To: sagi <sagi@grimberg.me>, 
	mgurtovoy <mgurtovoy@nvidia.com>, 
	kbusch <kbusch@kernel.org>, 
	sashal <sashal@kernel.org>, 
	chunguang.xu <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Subject: Re: Re: nvme-tcp: fix a possible UAF when failing to send request
References: <2025021015413817916143@cestc.cn>, 
	<aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
X-Priority: 3
X-GUID: 752A99AE-CBA7-430D-A461-66F2A12A1897
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Mime-Version: 1.0
Message-ID: <202502201620484789268@cestc.cn>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_002058_058374_127B3DDB 
X-CRM114-Status: GOOD (  16.42  )
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

CkhpIArCoMKgwqDCoMKgwqDCoMKgQWZ0ZXIgdGVzdGluZyB0aGlzIHBhdGNoLCAgTm8gc2VuZGlu
ZyByZXF1ZXN0IGZhaWx1cmUgb2NjdXJyZWQsIHRoZSBpc3N1ZSBoYXMgbm90IGJlZW4gcmVwcm9k
dWNlZCB5ZXQuICAKSXQgbWF5IHRha2UgYSBsb25nIHRpbWUgdG8gdGVzdC4KCmJlc3Qgd2lzaGVz
CgoKCnpoYW5nLmd1YW5naHVpQGNlc3RjLmNuCgoKCsKgCgoKCuWPkeS7tuS6uu+8msKgU2FnaSBH
cmltYmVyZwoKCgrlj5HpgIHml7bpl7TvvJrCoDIwMjUtMDItMTfCoDE1OjQ2CgoKCuaUtuS7tuS6
uu+8msKgemhhbmcuZ3VhbmdodWlAY2VzdGMuY247IG1ndXJ0b3ZveTsga2J1c2NoOyBzYXNoYWw7
IGNodW5ndWFuZy54dQoKCgrmioTpgIHvvJrCoGxpbnV4LWtlcm5lbDsgbGludXgtbnZtZTsgbGlu
dXgtYmxvY2sKCgoK5Li76aKY77yawqBSZTogbnZtZS10Y3A6IGZpeCBhIHBvc3NpYmxlIFVBRiB3
aGVuIGZhaWxpbmcgdG8gc2VuZCByZXF1ZXN044CQ6K+35rOo5oSP77yM6YKu5Lu255Sxc2FnaWdy
aW1AZ21haWwuY29t5Luj5Y+R44CRCgoKCsKgCgoKCsKgCgoKCsKgCgoKCk9uIDEwLzAyLzIwMjUg
OTo0MSwgemhhbmcuZ3VhbmdodWlAY2VzdGMuY24gd3JvdGU6CgoKCj4gSGVsbG8KCgoKPgoKCgo+
CgoKCj4KCgoKPsKgIMKgIMKgwqBXaGVuIHVzaW5nIHRoZSBudm1lLXRjcCBkcml2ZXIgaW4gYSBz
dG9yYWdlIGNsdXN0ZXIsIHRoZSBkcml2ZXIgbWF5IHRyaWdnZXIgYSBudWxsIHBvaW50ZXIgY2F1
c2luZyB0aGUgaG9zdCB0byBjcmFzaCBzZXZlcmFsIHRpbWVzLgoKCgo+CgoKCj4KCgoKPgoKCgo+
IEJ5IGFuYWx5emluZyB0aGUgdm1jb3JlLCB3ZSBrbm93IHRoZSBkaXJlY3QgY2F1c2UgaXMgdGhh
dMKgIHRoZSByZXF1ZXN0LT5tcV9oY3R4IHdhcyB1c2VkIGFmdGVyIGZyZWUuCgoKCj4KCgoKPgoK
Cgo+CgoKCj4KCgoKPgoKCgo+IENQVTHCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoENQVTIKCgoKPgoKCgo+CgoKCj4KCgoKPiBudm1lX3RjcF9wb2xswqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgbnZtZV90Y3BfdHJ5X3NlbmTCoCAtLWZhaWxlZCB0byBzZW5k
IHJlcXJlc3QgMTMKCgoKPgoKCgo+CgoKCj4KCgoKPsKgIMKgIMKgwqBudm1lX3RjcF90cnlfcmVj
dsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG52bWVfdGNwX2ZhaWxfcmVxdWVzdAoKCgo+CgoKCj4K
CgoKPgoKCgo+wqAgwqAgwqDCoMKgIMKgwqBudm1lX3RjcF9yZWN2X3NrYsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIG52bWVfdGNwX2VuZF9yZXF1ZXN0CgoKCj4KCgoKPgoKCgo+CgoKCj7CoCDCoCDC
oMKgwqAgwqDCoMKgIMKgwqBudm1lX3RjcF9yZWN2X3BkdcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IG52bWVfY29tcGxldGVfcnEKCgoKPgoKCgo+CgoKCj4KCgoKPsKgIMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqBudm1lX3RjcF9oYW5kbGVfY29tcMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgbnZtZV9yZXRyeV9yZXEgLS3CoHJlcXVlc3QtPm1xX2hjdHggaGF2ZSBiZWVuIGZyZWVk
LCBpcyBOVUxMLgoKCgo+CgoKCj4KCgoKPgoKCgo+wqAgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqBudm1lX3RjcF9wcm9jZXNzX252bWVfY3FlCgoKCj4KCgoKPgoKCgo+CgoKCj7C
oCDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgIG52bWVfY29tcGxldGVf
cnEKCgoKPgoKCgo+CgoKCj4KCgoKPsKgIMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgIG52bWVfZW5kX3JlcQoKCgo+CgoKCj4KCgoKPgoKCgo+wqAgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBibGtf
bXFfZW5kX3JlcXVlc3QKCgoKPgoKCgo+CgoKCj4KCgoKPgoKCgo+CgoKCj4KCgoKPgoKCgo+IHdo
ZW4gbnZtZV90Y3BfdHJ5X3NlbmQgZmFpbGVkIHRvIHNlbmQgcmVxcmVzdCAxMywgaXQgbWF5YmUg
YmUgcmVzdWx0ZWQgYnkgc2VsaW51eCBvciBvdGhlciByZWFzb25zLCB0aGlzIGlzIGEgcHJvYmxl
bS4gdGhlbsKgIHRoZSBudm1lX3RjcF9mYWlsX3JlcXVlc3Qgd291bGQgZXhlY3V0ZeOAggoKCgo+
CgoKCj4KCgoKPgoKCgo+IGJ1dCB0aGUgbnZtZV90Y3BfcmVjdl9wZHUgbWF5IGhhdmUgcmVjZWl2
ZWQgdGhlIHJlc3BvbmRpbmcgcGR1IGFuZCB0aGUgbnZtZV90Y3BfcHJvY2Vzc19udm1lX2NxZSB3
b3VsZCBoYXZlIGNvbXBsZXRlZCB0aGUgcmVxdWVzdC7CoCByZXF1ZXN0LT5tcV9oY3R4IHdhcyB1
c2VkIGFmdGVyIGZyZWUuCgoKCj4KCgoKPgoKCgo+CgoKCj4gdGhlIGZvbGxvdyBwYXRjaCBpcyB0
byBzb2x2ZSBpdC4KCgoKwqAKCgoKWmhhbmcsIHlvdXIgZW1haWwgY2xpZW50IG5lZWRzIGZpeGlu
ZyAtIGl0IGlzIGltcG9zc2libGUgdG8gZm9sbG93IHlvdXIKCgoKZW1haWxzLgoKCgrCoAoKCgo+
CgoKCj4KCgoKPgoKCgo+IGNhbiB5b3UgZ2l2ZcKgIHNvbWUgc3VnZ2VzdGlvbnM/wqAgdGhhbmtz
IQoKCgrCoAoKCgpUaGUgcHJvYmxlbSBpcyB0aGUgQzJIVGVybSB0aGF0IHRoZSBob3N0IGlzIHVu
YWJsZSB0byBoYW5kbGUgY29ycmVjdGx5LgoKCgpBbmQgaXQgYWxzbyBhcHBlYXJzIHRoYXQgbnZt
ZV90Y3BfcG9sbCgpIGRvZXMgbm90IHNpZ25hbCBjb3JyZWN0bHkgdG8KCgoKYmxrLW1xIHRvIHN0
b3AKCgoKY2FsbGluZyBwb2xsLgoKCgrCoAoKCgpPbmUgdGhpbmcgdG8gZG8gaXMgdG8gaGFuZGxl
IEMySFRlcm0gUERVIGNvcnJlY3RseSwgYW5kLCBoZXJlIGlzIGEKCgoKcG9zc2libGUgZml4IHRv
IHRyeSBmb3IgdGhlIFVBRiBpc3N1ZToKCgoKLS0KCgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMKCgoKaW5kZXggYzYzN2ZmMDRh
MDUyLi4wZTM5MGU5OGFhZjkgMTAwNjQ0CgoKCi0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5j
CgoKCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCgoKCkBAIC0yNjczLDYgKzI2NzMsNyBA
QCBzdGF0aWMgaW50IG52bWVfdGNwX3BvbGwoc3RydWN0IGJsa19tcV9od19jdHgKCgoKKmhjdHgs
IHN0cnVjdCBpb19jb21wX2JhdGNoICppb2IpCgoKCsKgewoKCgrCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgbnZtZV90Y3BfcXVldWUgKnF1ZXVlID0gaGN0eC0+ZHJpdmVyX2RhdGE7CgoKCsKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBzb2NrICpzayA9IHF1ZXVlLT5zb2NrLT5zazsKCgoKK8KgwqDCoMKgwqDC
oCBpbnQgcmV0OwoKCgrCoAoKCgrCoMKgwqDCoMKgwqDCoCBpZiAoIXRlc3RfYml0KE5WTUVfVENQ
X1FfTElWRSwgJnF1ZXVlLT5mbGFncykpCgoKCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gMDsKCgoKQEAgLTI2ODAsOSArMjY4MSw5IEBAIHN0YXRpYyBpbnQgbnZtZV90Y3Bf
cG9sbChzdHJ1Y3QgYmxrX21xX2h3X2N0eAoKCgoqaGN0eCwgc3RydWN0IGlvX2NvbXBfYmF0Y2gg
KmlvYikKCgoKwqDCoMKgwqDCoMKgwqAgc2V0X2JpdChOVk1FX1RDUF9RX1BPTExJTkcsICZxdWV1
ZS0+ZmxhZ3MpOwoKCgrCoMKgwqDCoMKgwqDCoCBpZiAoc2tfY2FuX2J1c3lfbG9vcChzaykgJiYK
CgoKc2tiX3F1ZXVlX2VtcHR5X2xvY2tsZXNzKCZzay0+c2tfcmVjZWl2ZV9xdWV1ZSkpCgoKCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBza19idXN5X2xvb3Aoc2ssIHRydWUpOwoKCgot
wqDCoMKgwqDCoMKgIG52bWVfdGNwX3RyeV9yZWN2KHF1ZXVlKTsKCgoKK8KgwqDCoMKgwqDCoCBy
ZXQgPSBudm1lX3RjcF90cnlfcmVjdihxdWV1ZSk7CgoKCsKgwqDCoMKgwqDCoMKgIGNsZWFyX2Jp
dChOVk1FX1RDUF9RX1BPTExJTkcsICZxdWV1ZS0+ZmxhZ3MpOwoKCgotwqDCoMKgwqDCoMKgIHJl
dHVybiBxdWV1ZS0+bnJfY3FlOwoKCgorwqDCoMKgwqDCoMKgIHJldHVybiByZXQgPCAwID8gcmV0
IDogcXVldWUtPm5yX2NxZTsKCgoKwqB9CgoKCsKgCgoKCsKgc3RhdGljIGludCBudm1lX3RjcF9n
ZXRfYWRkcmVzcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBjaGFyICpidWYsIGludAoKCgpzaXpl
KQoKCgotLQoKCgrCoAoKCgpEb2VzIHRoaXMgaGVscD8KCgoKwqAKCgoKwqAKCgo=




