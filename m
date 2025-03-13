Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB60C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 12:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:Mime-Version:References:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=aRS/gsPEteXLJ2p4xACg0b5rMlszo2I167Jw/FxPAls=; b=xFi9spA9NbrIRh0oTfxPQcCAT5
	Byxftx02kjJYZdj4e/HNd9Ig+35EyIP5xZ/XTMj5BUprHpFlpg+EiV4ymxOS+UEgePW7rxHZ0AmfE
	iBvnvkbbRoo8sEDFWXLMCU454Dd6uQuJluoUpGZlOaMeySmxK8lRRaCitDbibYuyrfwwmuxlkXcxe
	7SRvi8RrEZK2uSsCdjDrM6REOiG8+6YTg1QengMIflDqxZTeqIX043qPY0WaFwYkfLgeg2NuM59iy
	XcNcJYz0Cr58wvrwN2puyU9h0KhtEioo6hiscQPWGrFOjThlrsgJbkZazC9q+WwYL+cctiGdblFKd
	8R1uxC6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tshoX-0000000BGDR-3WNf;
	Thu, 13 Mar 2025 12:37:29 +0000
Received: from [1.203.97.240] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdmS-0000000AWdB-33De
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 08:19:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 88815900117;
	Thu, 13 Mar 2025 16:18:59 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281457528402288S1741853938483160_;
	Thu, 13 Mar 2025 16:18:58 +0800 (CST)
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
X-UNIQUE-TAG: <1fc75af5795b445a503e38b8a51da45b>
X-System-Flag: 0
Date: Thu, 13 Mar 2025 16:18:57 +0800
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
X-GUID: B9AB85EF-1578-4A33-80D3-D820132276F8
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Mime-Version: 1.0
Message-ID: <2025031316185747646815@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-Bad-Reply: References but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_011905_074943_10578784 
X-CRM114-Status: GOOD (  11.74  )
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

SGksICBpbiBmYWN0LCB0aGUgdGFyZ2V0IG1heSBzZW5kIEMySFRlcm1SZXEuCgoKCgp6aGFuZy5n
dWFuZ2h1aUBjZXN0Yy5jbgoKCgrCoAoKCgrlj5Hku7bkurrvvJrCoEhhbm5lcyBSZWluZWNrZQoK
Cgrlj5HpgIHml7bpl7TvvJrCoDIwMjUtMDMtMTPCoDE1OjUxCgoKCuaUtuS7tuS6uu+8msKgemhh
bmcuZ3VhbmdodWlAY2VzdGMuY247IE1hdXJpemlvIExvbWJhcmRpOyBzYWdpOyBtZ3VydG92b3k7
IGtidXNjaDsgc2FzaGFsOyBjaHVuZ3VhbmcueHUKCgoK5oqE6YCB77yawqBsaW51eC1rZXJuZWw7
IGxpbnV4LW52bWU7IGxpbnV4LWJsb2NrCgoKCuS4u+mimO+8msKgUmU6IG52bWUtdGNwOiBmaXgg
YSBwb3NzaWJsZSBVQUYgd2hlbiBmYWlsaW5nIHRvIHNlbmQgcmVxdWVzdOOAkOivt+azqOaEj++8
jOmCruS7tueUsXNhZ2lncmltQGdtYWlsLmNvbeS7o+WPkeOAkQoKCgpPbiAzLzEzLzI1IDAyOjQ4
LCB6aGFuZy5ndWFuZ2h1aUBjZXN0Yy5jbiB3cm90ZToKCgoKPiBZZXMsIHRoZSBwcm9ibGVtIGhl
cmUgaXMgdGhhdCzCoCBkZXNwaXRlIHRoZSBudm1lX3RjcF90cnlfc2VuZCgpIGZhaWx1cmUsIHRo
ZSB0YXJnZXQgc2VuZHMgYSByZXNwb25zZSBjYXBzdWxlIGZvciB0aGUgY29tbWFuZCwgbGVhZGlu
ZyB0byBhIFVBRiBpbiB0aGUgaG9zdC4KCgoKPgoKCgo+IElzIGl0IG1vcmUgcmVhc29uYWJsZSB0
byBkaXNhYmxlIHF1ZXVlLT5yZF9lbmFibGVkIHRvIHByZXZlbnQgcmVjZWl2aW5nLiBUaGFua3MK
CgoKPsKgwqAKCgoKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgYi9kcml2
ZXJzL252bWUvaG9zdC90Y3AuYwoKCgo+IGluZGV4IGJlMDRjNWYzODU2ZC4uMTc0MDdlYjEyYWQ5
IDEwMDY0NAoKCgo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCgoKCj4gKysrIGIvZHJp
dmVycy9udm1lL2hvc3QvdGNwLmMKCgoKPiBAQCAtMTIwMyw4ICsxMjAzLDkgQEAgc3RhdGljIGlu
dCBudm1lX3RjcF90cnlfc2VuZChzdHJ1Y3QgbnZtZV90Y3BfcXVldWUgKnF1ZXVlKQoKCgo+wqDC
oMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAocmV0IDwgMCkgewoKCgo+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKHF1ZXVlLT5jdHJsLT5jdHJsLmRldmljZSwKCgoK
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJmYWls
ZWQgdG8gc2VuZCByZXF1ZXN0ICVkXG4iLCByZXQpOwoKCgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG52bWVfdGNwX2ZhaWxfcmVxdWVzdChxdWV1ZS0+cmVxdWVzdCk7CgoKCj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfdGNwX2RvbmVfc2VuZF9yZXEocXVl
dWUpOwoKCgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxdWV1ZS0+cmRfZW5hYmxlZCA9
IGZhbHNlOwoKCgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudm1lX3RjcF9lcnJvcl9y
ZWNvdmVyeSgmcXVldWUtPmN0cmwtPmN0cmwpOwoKCgo+wqDCoMKgwqDCoMKgwqDCoMKgIH0KCgoK
PsKgwqAgb3V0OgoKCgo+wqDCoMKgwqDCoMKgwqDCoMKgIG1lbWFsbG9jX25vcmVjbGFpbV9yZXN0
b3JlKG5vcmVjbGFpbV9mbGFnKTsKCgoKPgoKCgo+CgoKCj4KCgoKSG1tLiBJbiBwcmluY2lwbGUs
IHllcy4gUHJvYmxlbSBpcyB0aGF0IG5ldHdvcmsgaXMgYSBiaS1kaXJlY3Rpb25hbAoKCgpjb21t
dW5pY2F0aW9uLCBhbmQgYSBmYWlsdXJlIG9uIG9uZSBzaWRlIGRvZXNuJ3QgbmVjZXNzYXJpbHkg
aW1wbHkKCgoKYSBmYWlsdXJlIG9uIHRoZSBvdGhlci4KCgoKSW4gcGFydGljdWxhciB3aGVuIHRo
ZSBzZW5kIHNpZGUgZmFpbHMgd2Ugc2hvdWxkIF9jb250aW51ZV8gdG8gcmVhZAoKCgphcyB3ZSBz
aG91bGQgYmUgZmx1c2hpbmcgdGhlIHJlYWQgc2lkZSBidWZmZXIgYmVmb3JlIGNsb3NpbmcuCgoK
CsKgCgoKClNvIEkgYWdyZWUgd2l0aCBzdGFydGluZyBlcnJvciByZWNvdmVyeSwgYnV0IG5vdCB3
aXRoIGRpc2FibGluZyB0aGUKCgoKcmVhZGluZyBzaWRlIChhcyB3ZSBoYXZlbid0IGVuY291bnRl
cmVkIGEgcmVhZCBlcnJvcikuCgoKCsKgCgoKCkNoZWVycywKCgoKwqAKCgoKSGFubmVzCgoKCi0t
CgoKCkRyLiBIYW5uZXMgUmVpbmVja2XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdAoKCgpoYXJlQHN1c2UuZGXCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCArNDkgOTExIDc0
MDUzIDY4OAoKCgpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBGcmFua2Vuc3RyLiAxNDYs
IDkwNDYxIE7DvHJuYmVyZwoKCgpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBJLiBUb3Rl
diwgQS4gTWNEb25hbGQsIFcuIEtub2JsaWNoCgoKCsKgCgoKCsKgCgoK




