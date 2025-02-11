Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFA3C0219D
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 08:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:Mime-Version:References:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=v3/QnHLfPhdX6VRlE+pIU43UTeH6HpsCS0I+aVAD7EY=; b=0bGl0aW/PQtAbwR8Q2F6Q3qJvb
	Iu4+aOAH4ATA+/6ErnRxC3/y/PieMxw/u2s63LIz1RBnGsPm4i8QZx7cP0zHHnhqXMYSO95efM7hN
	tZTHh7RpLdFXh3twy2gjhlsS01cAZGHe5Hj6rrheSpxkXKCsvnMWvcqVaCqo7dSc4tkGdfTnD4mS+
	JQpY3dZjKPqH/yK8sZCdJIEG5Vl7mUHCQay5eQ4vu3ogv2yDtSGGf3fBRef/yvJckeb5n+AzylFGW
	0RzdXC5TBl3RIJEgWBY8WjYB7xJI4hyK6JLq/J0+cgMP47U+gShWr7sSm4CJ4QovLBKyrncZAQRac
	8Ss1+bvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thlGF-00000002vVf-3hpm;
	Tue, 11 Feb 2025 08:04:51 +0000
Received: from [1.203.97.246] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thlG6-00000002vTm-1j6Y
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 08:04:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id ABD1A7C0114;
	Tue, 11 Feb 2025 16:04:37 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P1609376T281456890605936S1739261076388694_;
	Tue, 11 Feb 2025 16:04:37 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: zhang.guanghui@cestc.cn
X-SENDER: zhang.guanghui@cestc.cn
X-LOGIN-NAME: zhang.guanghui@cestc.cn
X-FST-TO: chunguang.xu@shopee.com
X-RCPT-COUNT: 9
X-LOCAL-RCPT-COUNT: 0
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 39.156.73.12
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <f1449e49e91462346a3942c695e01741>
X-System-Flag: 0
Date: Tue, 11 Feb 2025 16:04:35 +0800
From: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>
To: chunguang.xu <chunguang.xu@shopee.com>, 
	"Maurizio Lombardi" <mlombard@bsdbackstore.eu>
Cc: mgurtovoy <mgurtovoy@nvidia.com>, 
	sagi <sagi@grimberg.me>, 
	kbusch <kbusch@kernel.org>, 
	sashal <sashal@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Subject: Re: Re: nvme-tcp: fix a possible UAF when failing to send request
References: <2025021015413817916143@cestc.cn>, 
	<D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>, 
	<3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>, 
	<D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>, 
	<CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
X-Priority: 3
X-GUID: 28157AFE-1A33-4CB7-B756-379251543D66
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Mime-Version: 1.0
Message-ID: <202502111604342976121@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_000442_635460_31C279E4 
X-CRM114-Status: GOOD (  11.61  )
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

SGnCoAoKCgrCoCDCoCBUaGlzIGlzIGHCoCByYWNlIGlzc3VlLMKgwqBJIGNhbid0IHJlcHJvZHVj
ZSBpdCBzdGFibHkgeWV0LiBJIGhhdmUgbm90IHRlc3RlZCB0aGUgbGF0ZXN0IGtlcm5lbC7CoCBi
dXQgaW4gZmFjdCzCoMKgSSd2ZSBzeW5jZWQgc29tZSBudm1lLXRjcCBwYXRjaGVzIGZyb23CoCBs
YXN0ZXN0IHVwc3RyZWFtLCAKCgoKQnV0IGluIGZhY3QsIHRoZSBpc3N1ZSBzdGlsbCBleGlzdHMu
IEkgcmV2aWV3IG52bWUtdGNwIGNvZGUgYW5kIGZvdW5kIHRoYXQgdGhpcyBpc3N1ZXMgbWF5IGV4
aXN0IGluIG52bWVfdGNwX3BvbGwgcHJvY2Vzc2luZy4gCgoKCgoKCgp6aGFuZy5ndWFuZ2h1aUBj
ZXN0Yy5jbgoKCgrCoAoKCgpGcm9tOsKgWHUgQ2h1bmd1YW5nCgoKCkRhdGU6wqAyMDI1LTAyLTEx
wqAxNToyMAoKCgpUbzrCoE1hdXJpemlvIExvbWJhcmRpCgoKCkNDOsKgTWF4IEd1cnRvdm95OyB6
aGFuZy5ndWFuZ2h1aTsgc2FnaTsga2J1c2NoOyBzYXNoYWw7IGxpbnV4LWtlcm5lbDsgbGludXgt
bnZtZTsgbGludXgtYmxvY2sKCgoKU3ViamVjdDrCoFJlOiBudm1lLXRjcDogZml4IGEgcG9zc2li
bGUgVUFGIHdoZW4gZmFpbGluZyB0byBzZW5kIHJlcXVlc3QKCgoKCgoKCkhpOsKgCgoKCgoKCgpE
b2VzwqAgeW91IGhhdmUgdGVzdGVkIHRoZSBsYXRlc3Qga2VybmVsLCBjYW4gaXTCoCByZXByb2R1
Y2UgdGhlIHNhbWUgaXNzdWXvvJ8KCgoKCgoKCk1hdXJpemlvIExvbWJhcmRpIDxtbG9tYmFyZEBi
c2RiYWNrc3RvcmUuZXU+IOS6jiAyMDI15bm0MuaciDEx5pel5ZGo5LqMIDAwOjQw5YaZ6YGT77ya
CgoKCgoKT24gTW9uIEZlYiAxMCwgMjAyNSBhdCAxMToyNCBBTSBDRVQsIE1heCBHdXJ0b3ZveSB3
cm90ZToKCgoKPgoKCgo+IEl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlIEhPU1RfUEFUSF9FUlJPUiBo
YW5kbGluZyBjYW4gYmUgaW1wcm92ZWQgaW4KCgoKPiBudm1lLXRjcC4KCgoKPgoKCgo+IEluIG52
bWUtcmRtYSB3ZSB1c2UgbnZtZV9ob3N0X3BhdGhfZXJyb3IocnEpIGFuZCBudm1lX2NsZWFudXBf
Y21kKHJxKSBpbgoKCgo+IGNhc2Ugd2UgZmFpbCB0byBzdWJtaXQgYSBjb21tYW5kLi4KCgoKPgoK
Cgo+IGNhbiB5b3UgdHJ5IHRvIHJlcGxhY2luZyBudm1lX3RjcF9lbmRfcmVxdWVzdChibGtfbXFf
cnFfZnJvbV9wZHUocmVxKSwKCgoKPiBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUik7IGNhbGwgd2l0
aCB0aGUgc2ltaWxhciBsb2dpYyB3ZSB1c2UgaW4KCgoKPiBudm1lLXJkbWEgZm9yIGhvc3QgcGF0
aCBlcnJvciBoYW5kbGluZyA/CgoKCgoKWWVzLCBJIGNvdWxkIHRyeSB0byBwcmVwYXJlIGEgcGF0
Y2guCgoKCgoKSW4gYW55IGNhc2UsIEkgdGhpbmsgdGhlIG1haW4gaXNzdWUgaGVyZSBpcyB0aGF0
IG52bWVfdGNwX3BvbGwoKQoKCgpzaG91bGQgYmUgcHJldmVudGVkIGZyb20gcmFjaW5nIGFnYWlu
c3QgaW9fd29yay4uLiBhbmQgSSBhbHNvIHRoaW5rCgoKCnRoZXJlIGlzIGEgcG9zc2libGUgcmFj
ZSBjb25kaXRpb24gaWYgbnZtZV90Y3BfcG9sbCgpIHJhY2VzIGFnYWluc3QKCgoKdGhlIGNvbnRy
b2xsZXIgcmVzZXR0aW5nIGNvZGUuCgoKCgoKTWF1cml6aW8KCgo=




