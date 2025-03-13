Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35822C282EC
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:Mime-Version:References:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=9R1EiGAgQe25MrWNKrF2WevN9VUMvqqUyAGKWCs4Slw=; b=iCSp0gfkVSP9BALaHyl0P1PgxY
	YFWgEe/U5cCP8H08yReobUa34BuKyhc9oKFHuLtXmqsfu4BLn6Gq/NhHqAYblfuZKhpshOTALGk+9
	PnqsilvVmqqhotgYkCbet6Lsf4cfEf8f/fqNs+KGOs3GH/UezhbNmi4t5kXHptCgSoQ+2FuVX2aFu
	/KcaM3RiKZeww3EBsb0Ib9LE0UNjr5HFJwXbAoLIobxv27glQ/DbXBSE0p53DTZA3z7APzdE38Wxf
	zZ1sDAzLS6oyoll4eEvH7TGlFWcVWTINd7IZ6pP983GQht2RLwkCiYDdI9LnVcpsCNZtTcFEuX7zo
	zgHiFgYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tshoY-0000000BGEB-2HFO;
	Thu, 13 Mar 2025 12:37:30 +0000
Received: from [1.203.97.240] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tse5M-0000000AZO4-4C18
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 08:38:38 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id F031E900114;
	Thu, 13 Mar 2025 16:38:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281457503039856S1741855113830797_;
	Thu, 13 Mar 2025 16:38:34 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: zhang.guanghui@cestc.cn
X-SENDER: zhang.guanghui@cestc.cn
X-LOGIN-NAME: zhang.guanghui@cestc.cn
X-FST-TO: hare@suse.de
X-RCPT-COUNT: 10
X-LOCAL-RCPT-COUNT: 0
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 39.156.73.12
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <708528d4f6f342195498421eb54f3467>
X-System-Flag: 0
Date: Thu, 13 Mar 2025 16:38:33 +0800
From: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>
To: "Hannes Reinecke" <hare@suse.de>, 
	"Maurizio Lombardi" <mlombard@bsdbackstore.eu>, 
	sagi <sagi@grimberg.me>, 
	mgurtovoy <mgurtovoy@nvidia.com>, 
	kbusch <kbusch@kernel.org>, 
	sashal <sashal@kernel.org>, 
	chunguang.xu <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFJlOiBudm1lLXRjcDogZml4IGEgcG9zc2libGUgVUFGIHdoZW4gZmFpbGluZyB0byBzZW5kIHJlcXVlc3TjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFzYWdpZ3JpbUBnbWFpbC5jb23ku6Plj5HjgJE=?=
References: <2025021015413817916143@cestc.cn>, 
	<aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>, 
	<202503071810452687957@cestc.cn>, 
	<D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>, 
	<2025031309485746586710@cestc.cn>, 
	<deb1584c-67b8-4543-9017-9ca18a9ee7d8@suse.de>
X-Priority: 3
X-GUID: 66D57D25-E26A-4CB3-B730-BF52186BB060
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Mime-Version: 1.0
Message-ID: <2025031316383284926527@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-Bad-Reply: References but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_013837_367243_CF8965B1 
X-CRM114-Status: GOOD (  13.07  )
X-Mailman-Approved-At: Thu, 13 Mar 2025 05:37:28 -0700
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

SGksCgoKCsKgIGluIGZhY3QsIHRoZSBudm1lX3RjcF90cnlfc2VuZCgpIGZhaWx1cmUsIHRoZSB0
YXJnZXQgbWF5IHNlbmQgQzJIVGVybVJlcSBpbW1lZGlhdGVseS4gd2hpbGUgdGhlIGhvc3QgcmVj
ZWl2ZXMgdGhlIEMySFRlcm1SZXEgYW5kIHN0aWxsIHN0YXJ0aW5nIGVycm9yIHJlY292ZXJ5LsKg
CgoKCnNvIHdoZW4gcXVldWUtPnJkX2VuYWJsZWQgaXMgZmFsc2UswqAgY2FuIGF2b2lkIHN0YXJ0
aW5nIGVycm9yIHJlY292ZXJ5IGFnYWdpbi4gVGhhbmtzCgoKCgoKemhhbmcuZ3VhbmdodWlAY2Vz
dGMuY24KCgoKwqAKCgoK5Y+R5Lu25Lq677yawqBIYW5uZXMgUmVpbmVja2UKCgoK5Y+R6YCB5pe2
6Ze077yawqAyMDI1LTAzLTEzwqAxNTo1MQoKCgrmlLbku7bkurrvvJrCoHpoYW5nLmd1YW5naHVp
QGNlc3RjLmNuOyBNYXVyaXppbyBMb21iYXJkaTsgc2FnaTsgbWd1cnRvdm95OyBrYnVzY2g7IHNh
c2hhbDsgY2h1bmd1YW5nLnh1CgoKCuaKhOmAge+8msKgbGludXgta2VybmVsOyBsaW51eC1udm1l
OyBsaW51eC1ibG9jawoKCgrkuLvpopjvvJrCoFJlOiBudm1lLXRjcDogZml4IGEgcG9zc2libGUg
VUFGIHdoZW4gZmFpbGluZyB0byBzZW5kIHJlcXVlc3TjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFz
YWdpZ3JpbUBnbWFpbC5jb23ku6Plj5HjgJEKCgoKT24gMy8xMy8yNSAwMjo0OCwgemhhbmcuZ3Vh
bmdodWlAY2VzdGMuY24gd3JvdGU6CgoKCj4gWWVzLCB0aGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQs
wqAgZGVzcGl0ZSB0aGUgbnZtZV90Y3BfdHJ5X3NlbmQoKSBmYWlsdXJlLCB0aGUgdGFyZ2V0IHNl
bmRzIGEgcmVzcG9uc2UgY2Fwc3VsZSBmb3IgdGhlIGNvbW1hbmQsIGxlYWRpbmcgdG8gYSBVQUYg
aW4gdGhlIGhvc3QuCgoKCj4KCgoKPiBJcyBpdCBtb3JlIHJlYXNvbmFibGUgdG8gZGlzYWJsZSBx
dWV1ZS0+cmRfZW5hYmxlZCB0byBwcmV2ZW50IHJlY2VpdmluZy4gVGhhbmtzCgoKCj7CoMKgCgoK
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hv
c3QvdGNwLmMKCgoKPiBpbmRleCBiZTA0YzVmMzg1NmQuLjE3NDA3ZWIxMmFkOSAxMDA2NDQKCgoK
PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwoKCgo+ICsrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L3RjcC5jCgoKCj4gQEAgLTEyMDMsOCArMTIwMyw5IEBAIHN0YXRpYyBpbnQgbnZtZV90Y3Bf
dHJ5X3NlbmQoc3RydWN0IG52bWVfdGNwX3F1ZXVlICpxdWV1ZSkKCgoKPsKgwqDCoMKgwqDCoMKg
wqDCoCB9IGVsc2UgaWYgKHJldCA8IDApIHsKCgoKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZGV2X2VycihxdWV1ZS0+Y3RybC0+Y3RybC5kZXZpY2UsCgoKCj7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiZmFpbGVkIHRvIHNlbmQg
cmVxdWVzdCAlZFxuIiwgcmV0KTsKCgoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBu
dm1lX3RjcF9mYWlsX3JlcXVlc3QocXVldWUtPnJlcXVlc3QpOwoKCgo+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBudm1lX3RjcF9kb25lX3NlbmRfcmVxKHF1ZXVlKTsKCgoKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcXVldWUtPnJkX2VuYWJsZWQgPSBmYWxzZTsKCgoK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV90Y3BfZXJyb3JfcmVjb3ZlcnkoJnF1
ZXVlLT5jdHJsLT5jdHJsKTsKCgoKPsKgwqDCoMKgwqDCoMKgwqDCoCB9CgoKCj7CoMKgIG91dDoK
CgoKPsKgwqDCoMKgwqDCoMKgwqDCoCBtZW1hbGxvY19ub3JlY2xhaW1fcmVzdG9yZShub3JlY2xh
aW1fZmxhZyk7CgoKCj4KCgoKPgoKCgo+CgoKCkhtbS4gSW4gcHJpbmNpcGxlLCB5ZXMuIFByb2Js
ZW0gaXMgdGhhdCBuZXR3b3JrIGlzIGEgYmktZGlyZWN0aW9uYWwKCgoKY29tbXVuaWNhdGlvbiwg
YW5kIGEgZmFpbHVyZSBvbiBvbmUgc2lkZSBkb2Vzbid0IG5lY2Vzc2FyaWx5IGltcGx5CgoKCmEg
ZmFpbHVyZSBvbiB0aGUgb3RoZXIuCgoKCkluIHBhcnRpY3VsYXIgd2hlbiB0aGUgc2VuZCBzaWRl
IGZhaWxzIHdlIHNob3VsZCBfY29udGludWVfIHRvIHJlYWQKCgoKYXMgd2Ugc2hvdWxkIGJlIGZs
dXNoaW5nIHRoZSByZWFkIHNpZGUgYnVmZmVyIGJlZm9yZSBjbG9zaW5nLgoKCgrCoAoKCgpTbyBJ
IGFncmVlIHdpdGggc3RhcnRpbmcgZXJyb3IgcmVjb3ZlcnksIGJ1dCBub3Qgd2l0aCBkaXNhYmxp
bmcgdGhlCgoKCnJlYWRpbmcgc2lkZSAoYXMgd2UgaGF2ZW4ndCBlbmNvdW50ZXJlZCBhIHJlYWQg
ZXJyb3IpLgoKCgrCoAoKCgpDaGVlcnMsCgoKCsKgCgoKCkhhbm5lcwoKCgotLQoKCgpEci4gSGFu
bmVzIFJlaW5lY2tlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBLZXJuZWwgU3Rv
cmFnZSBBcmNoaXRlY3QKCgoKaGFyZUBzdXNlLmRlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKzQ5IDkxMSA3NDA1MyA2ODgKCgoK
U1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgRnJhbmtlbnN0ci4gMTQ2LCA5MDQ2MSBOw7xy
bmJlcmcKCgoKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogSS4gVG90ZXYsIEEuIE1jRG9u
YWxkLCBXLiBLbm9ibGljaAoKCgrCoAoKCgrCoAoKCg==




