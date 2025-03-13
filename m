Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCA7C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 05:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:Mime-Version:References:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=6sY/7FdgPMrB92rg3PJECrh/+gGW3ra+PU0Lugn9eMY=; b=eARLBy+WQt40CNkynJtqS4Y2EH
	Zp+A88CT4TQhVpazEP/iNSCgq5X0kf+/6ACM7ZmsDeL40NoXVqDxJ85ibefuUMvH0CewalIbbrQY5
	LFgOnJQ0TlOKnfBJnrhjWZVpGBMoMv2lDKkPxSncIPTXzhxFsrHSTmqCLH1/JmRXQpvYVNrFImbt2
	JQbVEZ4vlanBD3PqedHeSeeIiQrQBjs+6q2GjRSPuFrjpVxIrrLgK48UGNT91BVt8eCQXErLOa2ia
	ysNZnsyOOPxmrhTo5n1Yat5ly7DA8o2Z154tY22DqEMDsOMm+BK82BBf8AhTK4pvFGWetjsO2kOKE
	ufNOqWrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsbNl-0000000AABB-0qTP;
	Thu, 13 Mar 2025 05:45:25 +0000
Received: from [1.203.97.240] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsXh4-00000009tLT-2cJS
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 01:49:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 85B3C900113;
	Thu, 13 Mar 2025 09:48:59 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281458922156400S1741830538431531_;
	Thu, 13 Mar 2025 09:48:58 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: zhang.guanghui@cestc.cn
X-SENDER: zhang.guanghui@cestc.cn
X-LOGIN-NAME: zhang.guanghui@cestc.cn
X-FST-TO: mlombard@bsdbackstore.eu
X-RCPT-COUNT: 9
X-LOCAL-RCPT-COUNT: 0
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 39.156.73.12
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <04ac8a49813e1ceebe4a332c09420545>
X-System-Flag: 0
Date: Thu, 13 Mar 2025 09:48:57 +0800
From: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, 
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
	<D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
X-Priority: 3
X-GUID: FF449562-DD47-4AB7-B4CD-D0CF3D8BDFE0
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Mime-Version: 1.0
Message-ID: <2025031309485746586710@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-Bad-Reply: References but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_184906_950648_DDBFD9CF 
X-CRM114-Status: UNSURE (   8.12  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 12 Mar 2025 22:45:24 -0700
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

WWVzLCB0aGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQsICBkZXNwaXRlIHRoZSBudm1lX3RjcF90cnlf
c2VuZCgpIGZhaWx1cmUsIHRoZSB0YXJnZXQgc2VuZHMgYSByZXNwb25zZSBjYXBzdWxlIGZvciB0
aGUgY29tbWFuZCwgbGVhZGluZyB0byBhIFVBRiBpbiB0aGUgaG9zdC4gCgpJcyBpdCBtb3JlIHJl
YXNvbmFibGUgdG8gZGlzYWJsZSBxdWV1ZS0+cmRfZW5hYmxlZCB0byBwcmV2ZW50IHJlY2Vpdmlu
Zy4gVGhhbmtzIAogCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L3RjcC5jCmluZGV4IGJlMDRjNWYzODU2ZC4uMTc0MDdlYjEyYWQ5IDEwMDY0
NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC90
Y3AuYwpAQCAtMTIwMyw4ICsxMjAzLDkgQEAgc3RhdGljIGludCBudm1lX3RjcF90cnlfc2VuZChz
dHJ1Y3QgbnZtZV90Y3BfcXVldWUgKnF1ZXVlKQogICAgICAgIH0gZWxzZSBpZiAocmV0IDwgMCkg
ewogICAgICAgICAgICAgICAgZGV2X2VycihxdWV1ZS0+Y3RybC0+Y3RybC5kZXZpY2UsCiAgICAg
ICAgICAgICAgICAgICAgICAgICJmYWlsZWQgdG8gc2VuZCByZXF1ZXN0ICVkXG4iLCByZXQpOwot
ICAgICAgICAgICAgICAgbnZtZV90Y3BfZmFpbF9yZXF1ZXN0KHF1ZXVlLT5yZXF1ZXN0KTsKICAg
ICAgICAgICAgICAgIG52bWVfdGNwX2RvbmVfc2VuZF9yZXEocXVldWUpOworICAgICAgICAgICAg
ICBxdWV1ZS0+cmRfZW5hYmxlZCA9IGZhbHNlOworICAgICAgICAgICAgICBudm1lX3RjcF9lcnJv
cl9yZWNvdmVyeSgmcXVldWUtPmN0cmwtPmN0cmwpOwogICAgICAgIH0KIG91dDoKICAgICAgICBt
ZW1hbGxvY19ub3JlY2xhaW1fcmVzdG9yZShub3JlY2xhaW1fZmxhZyk7CgoKCgp6aGFuZy5ndWFu
Z2h1aUBjZXN0Yy5jbgoKCgrlj5Hku7bkurrvvJrCoE1hdXJpemlvIExvbWJhcmRpCgoKCuWPkemA
geaXtumXtO+8msKgMjAyNS0wMy0xMcKgMTg6NTIKCgoK5pS25Lu25Lq677yawqB6aGFuZy5ndWFu
Z2h1aUBjZXN0Yy5jbjsgc2FnaTsgbWd1cnRvdm95OyBrYnVzY2g7IHNhc2hhbDsgY2h1bmd1YW5n
Lnh1CgoKCuaKhOmAge+8msKgbGludXgta2VybmVsOyBsaW51eC1udm1lOyBsaW51eC1ibG9jawoK
CgrkuLvpopjvvJrCoFJlOiBudm1lLXRjcDogZml4IGEgcG9zc2libGUgVUFGIHdoZW4gZmFpbGlu
ZyB0byBzZW5kIHJlcXVlc3TjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFzYWdpZ3JpbUBnbWFpbC5j
b23ku6Plj5HjgJEKCgoKT24gRnJpIE1hciA3LCAyMDI1IGF0IDExOjEwIEFNIENFVCwgemhhbmcu
Z3VhbmdodWlAY2VzdGMuY24gd3JvdGU6CgoKCj4KCgoKPiBIaQoKCgo+CgoKCj7CoMKgwqDCoMKg
wqDCoMKgIEFmdGVyIHRlc3RpbmcgdGhpcyBwYXRjaCzCoMKgIHNlbmRpbmcgcmVxdWVzdCBmYWls
dXJlIG9jY3VycmVkLMKgwqAgdW5mb3J0dW5hdGVseSwgdGhlIGlzc3VlIHN0aWxsIHBlcnNpc3Rz
LgoKCgrCoAoKCgpNYXliZSBJIGFtIGNvbXBsZXRlbHkgd3JvbmcgYnV0IEkgYW0gc3RpbGwgcXVp
dGUgY29udmluY2VkIHRoYXQgdGhlIHByb2JsZW0gaGVyZQoKCgppcyB0aGF0LCBkZXNwaXRlIHRo
ZSBudm1lX3RjcF90cnlfc2VuZCgpIGZhaWx1cmUsIHRoZSB0YXJnZXQgc2VuZHMgYSByZXNwb25z
ZSBjYXBzdWxlCgoKCmZvciB0aGUgY29tbWFuZCwgbGVhZGluZyB0byBhIGRvdWJsZS1jb21wbGV0
aW9uIGluIHRoZSBob3N0LgoKCgrCoAoKCgpTYWdpLCB3aGF0IGFib3V0IHRha2luZyB0aGlzIHBh
dGNoOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzIwMjUwMzA2MTYwMzIyLjEz
NzAzMDAtMi1tbG9tYmFyZEByZWRoYXQuY29tL1QvI3UKCgoKYW5kIGRvIGEgc3RlcCBmdXJ0aGVy
IGJ5IG5vdCBjb21wbGV0aW5nIHRoZSByZXF1ZXN0LCBsZWF2aW5nIHRoZSBlcnJvcgoKCgpyZWNv
dmVyeSBoYW5kbGVyIHRoZSB0YXNrIG9mIGNsZWFuaW5nIGV2ZXJ5dGhpbmcgdXA/CgoKCsKgCgoK
CsKgCgoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L3RjcC5jCgoKCmluZGV4IDMyN2YzZjJmNTM5OS4uNzJjMWQ3OTQ4Mzg2IDEwMDY0NAoK
CgotLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwoKCgorKysgYi9kcml2ZXJzL252bWUvaG9z
dC90Y3AuYwoKCgpAQCAtMTMyOCw4ICsxMzI4LDggQEAgc3RhdGljIGludCBudm1lX3RjcF90cnlf
c2VuZChzdHJ1Y3QgbnZtZV90Y3BfcXVldWUgKnF1ZXVlKQoKCgp9IGVsc2UgaWYgKHJldCA8IDAp
IHsKCgoKZGV2X2VycihxdWV1ZS0+Y3RybC0+Y3RybC5kZXZpY2UsCgoKCiJmYWlsZWQgdG8gc2Vu
ZCByZXF1ZXN0ICVkXG4iLCByZXQpOwoKCgotIG52bWVfdGNwX2ZhaWxfcmVxdWVzdChxdWV1ZS0+
cmVxdWVzdCk7CgoKCm52bWVfdGNwX2RvbmVfc2VuZF9yZXEocXVldWUpOwoKCgorIG52bWVfdGNw
X2Vycm9yX3JlY292ZXJ5KCZxdWV1ZS0+Y3RybC0+Y3RybCk7CgoKCn0KCgoKb3V0OgoKCgptZW1h
bGxvY19ub3JlY2xhaW1fcmVzdG9yZShub3JlY2xhaW1fZmxhZyk7CgoKCsKgCgoKCsKgCgoKCk1h
dXJpemlvCgoKCsKgCgoKCsKgCgoK




