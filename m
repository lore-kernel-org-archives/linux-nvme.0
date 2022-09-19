Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4BBC54EE9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 01:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SCvkpvK48dt0RorK9oFh11/dJY6Ke91+ljyUVARvrp4=; b=1JN1Q9n4YTlxOhEUTlLTgTcsNf
	Uhk9pnLzn5Pq3pdD2mE3Q9p/Jn151zTbxKXNVMYQJyB8GGPDkMLeGkh2Xdcg5sOEVqjmZCdpFnQSg
	r9e9OIyFlzfGd8BcsKyD20BUy9CFLwekxThANfaSor9ePFJU0LdOYo5BT6vGX6a/HzQEVbL0hm6oP
	g8FB5QNnQeKpzTka95+i0lnw1pvwzsCeAx8GVGPBRnS/8IKTZtEpCVjM0Ml7hjKjoevL87QJZRMLx
	b5cr5LObaI7KAILt0CnCKLd1DepZ6dDmkA4iEO5wTPbtc/KFczlv727eBMUmJGozMu6WfxNpwhbWT
	OGw2OqOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oa5tM-005fE0-PY; Mon, 19 Sep 2022 01:48:12 +0000
Received: from m1564.mail.126.com ([220.181.15.64])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oa5tI-005f7k-SC
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 01:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=fLebM
	RKl+CypIgX/ABfUk3zfg1bZt89agwxxfxZ7cRU=; b=QaZ3yAit1mLEhfCbfXVDT
	2GGGN0zhiZUKl+i38n27eaa4FR3lwI7pKPM185mw7yquueFcLg3cPRUejs5fqBLK
	IagncMt37wScXw1B6egIXN5zgDMXEUSo8f3pB3Z0xlK8mCKwCb794SuVqUa//Jnl
	w1W253HCWrysS/HyySb0Po=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr64
 (Coremail) ; Mon, 19 Sep 2022 09:46:59 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date: Mon, 19 Sep 2022 09:46:59 +0800 (CST)
From: "Liang He" <windhl@126.com>
To: james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org
Subject: Re:[PATCH] nvmet-fc: Fix potential Use-after-free bug in
 nvmet_fc_delete_target_queue()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220916082953.4095940-1-windhl@126.com>
References: <20220916082953.4095940-1-windhl@126.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5c965e81.13d6.183536d5bba.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMqowAB3f3MUyidjk45yAA--.968W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBiAF2JVlbFiEwACsX
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_184809_433942_EAAC6150 
X-CRM114-Status: UNSURE (   7.58  )
X-CRM114-Notice: Please train this message.
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

CgpBdCAyMDIyLTA5LTE2IDE2OjI5OjUzLCAiTGlhbmcgSGUiIDx3aW5kaGxAMTI2LmNvbT4gd3Jv
dGU6Cj5JbiBudm1ldF9mY19kZWxldGVfdGFyZ2V0X3F1ZXVlKCksIHRoZSBudm1ldF9mY190Z3Rf
cV9wdXQoKSBtYXkgZnJlZQo+cXVldWUgaWYgaXRzIHJlZmNvdW50IGhpdHMgMC4gQW5kIHRoZSBm
b2xsb3dpbmcgY29kZSB3aWxsIGRlcmVmZXJlbmNlCj5pdCB0byBnZXQgcWNsb2NrIGJ5ICdxdWV1
ZS0+cWxvY2snLCBzbyB0aGVyZSBpcyBhIHBvdGVudGlhbCBVQUYgYnVnLgo+Cj5GaXhlczogNjE5
YzYyZGNjNjJiICgibnZtZXQtZmM6IGNvcnJlY3QgcmVmIGNvdW50aW5nIGVycm9yIHdoZW4gZGVm
ZXJyZWQgcmN2IHVzZWQiKQo+U2lnbmVkLW9mZi1ieTogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29t
Pgo+LS0tCj4gZHJpdmVycy9udm1lL3RhcmdldC9mYy5jIHwgMyArKy0KPiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPmRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvdGFyZ2V0L2ZjLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2ZjLmMKPmluZGV4IGFiMjYy
N2UxN2JiOS4uMzJlMWQ2MjAxN2QyIDEwMDY0NAo+LS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9m
Yy5jCj4rKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2ZjLmMKPkBAIC04ODEsNiArODgxLDcgQEAg
bnZtZXRfZmNfZGVsZXRlX3RhcmdldF9xdWV1ZShzdHJ1Y3QgbnZtZXRfZmNfdGd0X3F1ZXVlICpx
dWV1ZSkKPiAJc3RydWN0IG52bWV0X2ZjX3RndHBvcnQgKnRndHBvcnQgPSBxdWV1ZS0+YXNzb2Mt
PnRndHBvcnQ7Cj4gCXN0cnVjdCBudm1ldF9mY19mY3BfaW9kICpmb2QgPSBxdWV1ZS0+Zm9kOwo+
IAlzdHJ1Y3QgbnZtZXRfZmNfZGVmZXJfZmNwX3JlcSAqZGVmZXJmY3AsICp0ZW1wcHRyOwo+Kwlz
cGlubG9ja190ICpxX2xvY2sgPSAmcXVldWUtPnFsb2NrOwo+IAl1bnNpZ25lZCBsb25nIGZsYWdz
Owo+IAlpbnQgaTsKPiAJYm9vbCBkaXNjb25uZWN0Owo+QEAgLTk0Miw3ICs5NDMsNyBAQCBudm1l
dF9mY19kZWxldGVfdGFyZ2V0X3F1ZXVlKHN0cnVjdCBudm1ldF9mY190Z3RfcXVldWUgKnF1ZXVl
KQo+IAo+IAkJa2ZyZWUoZGVmZXJmY3ApOwo+IAo+LQkJc3Bpbl9sb2NrX2lycXNhdmUoJnF1ZXVl
LT5xbG9jaywgZmxhZ3MpOwo+KwkJc3Bpbl9sb2NrX2lycXNhdmUocV9sb2NrLCBmbGFncyk7Cj4g
CX0KPiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcXVldWUtPnFsb2NrLCBmbGFncyk7Cj4gCj4t
LSAKPjIuMjUuMQoKU29ycnksIG15IHBhdGNoIGlzIHRvdGFsbHkgd3JvbmcgYXMgdGhlICdxbG9j
aycgaXMgZW1iZWRlZCBpbnRvIHF1ZXVlLgpTbyBpZiBxdWV1ZSBpcyBmcmVlZCwgdGhlICdxbG9j
aycgd2lsbCBhbHNvIGJlIGZyZWVkLgoKTm93LCB3ZSBjYW4gb25seSBob3BlIHRoZSAnbnZtZXRf
ZmNfdGd0X3FfcHV0JyBpbiBsaW4gOTQxIHdpbGwgbmV2ZXIgcmVhbGx5IGZyZWUgdGhlICdxdWV1
ZScuCg==

