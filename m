Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C167CC6B3A
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6LRLl4jVPEFVAXY2BRqgZpy/X6yETBthjrFMUB4zjSo=; b=ItZFLYWx40/DI0zs8IqPBxl3UT
	GNGu4fRfbYuru3VH9Jnp91/P7LcQGUOHEhRouTQ6EU4Rk6uj8Y026p91XKP4ZDq2ubDfrV2oW7CL1
	J6YJ5VkFCvz17sLV5QDTh6LUPvkVfg+SjnGRzGyWNCI1mC1enkIp3V4QOgMb5SriSCaSC0z94Dk+R
	oEDYq1FjtT9qEpxhPEXHa98w8GHUNY/pmxZawGquuSbLcTXp9xk5wzQK1Buiecl1tGooPfknOzitA
	9v0M4xQYCaOO2sUeCeQEi03PmkVJlDSS69T1Yjn8G+duFIPnS3qvmm2FTqu5wOwLWYezId5icQWqL
	xdRrxgvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHJWh-0000000HYbo-3KhD;
	Thu, 15 Oct 2026 11:21:35 +0000
Received: from m16.mail.163.com ([117.135.210.4])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHJWe-0000000HYb6-3PZF
	for linux-nvme@lists.infradead.org;
	Thu, 15 Oct 2026 11:21:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=6LRLl4jVPEFVAXY2BRqgZpy/X6yETBthjrFMUB4zjSo=; b=L
	/9wNE0OnMg/TLFGeJV8jpxj88Kkaa9uuY+5zf0UnawavR8yDYW5N1k7BqZ0RvcNJ
	SejKs9EUu+Rc3iJyMlZD/2ilBpV83S8Tcgv6SrHdr3NHZBnQYO9TU5DXXiZ3bT1H
	RQNXA4EG5cbhCgnyMy4+0A6ylXn/go6Z44hsUbDh0A=
Date: Thu, 15 Oct 2026 19:20:40 +0800 (CST)
From: kensanya  <kensanya@163.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: Re:Re: [PATCH] nvmet-fc: skip hostport ops when the LLDD has no
 host handle
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261015061449.GA14497@lst.de>
References: <20261014075303.277735-1-kensanya@163.com>
 <20261015061449.GA14497@lst.de>
X-NTES-SC: AL_Qu2SAPydvEov5iWYZ+kcnkcTg+k8WMW1ufsg2Ydec/4EswX9+hASWlF5LWX1/+uDGhqFqgmybiFH5+hjQKhGNmqyOAipXo4kMzfWuftYFw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7273ecea.964a.1a13f4af93f.Coremail.kensanya@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dSgvCgD3_ysJt9BqTehZAA--.5112W
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbC6gm+mmrQtwnzMQAA3B
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_042133_615651_7DFB7F8E 
X-CRM114-Status: UNSURE (   5.17  )
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

QXQgMjAyNi0xMC0xNSAxNDoxNDo0OSwgIkNocmlzdG9waCBIZWxsd2lnIiA8aGNoQGxzdC5kZT4g
d3JvdGU6Cj5PbiBXZWQsIE9jdCAxNCwgMjAyNiBhdCAwMzo1MzowM1BNICswODAwLCBrZW5zYW55
YUAxNjMuY29tIHdyb3RlOgo+PiBGcm9tOiBUYW5aaGVuZyA8dGFuemhlbmdAa3lsaW5vcy5jbj4K
Pj4gCj4+IG52bWV0X2ZjX2FsbG9jX2hvc3Rwb3J0KCkgcmV0dXJucyBOVUxMIHdoZW4gdGhlIExM
REQgcGFzc2VzIGEgTlVMTAo+PiBob3N0aGFuZGxlLiBUaGF0IGlzIG5vdCBhbiBFUlJfUFRSLCBz
byBudm1ldF9mY19hbGxvY190YXJnZXRfYXNzb2MoKQo+PiBrZWVwcyB0aGUgYXNzb2NpYXRpb24g
YW5kIGxlYXZlcyBhc3NvYy0+aG9zdHBvcnQgTlVMTC4KPgo+QSBOVUxMIGhvc3RoYW5kbGUgZG9l
c24ndCBtYWtlIG11Y2ggc2Vuc2UsIHNvIHdoeSBkbyB5b3Ugd2FudCB0byBoYW5kbGUKPnRoYXQ/
CgpIaS4KCm52bWV0X2ZjX3Jjdl9sc19yZXEoKSBvbmx5IHN0b3JlcyB0aGUgaG9zdGhhbmRsZSBp
biB0aGUgaW9kLiBJdCBkb2VzIG5vdCBjYWxsIApudm1ldF9mY19hbGxvY19ob3N0cG9ydCgpLiBU
aGF0IGZ1bmN0aW9uIHJldHVybnMgTlVMTCBmb3IgYSBOVUxMIGhvc3RoYW5kbGUsIAphbmQgbnZt
ZXRfZmNfYWxsb2NfdGFyZ2V0X2Fzc29jKCkgc3RvcmVzIGl0IGluIGFzc29jLT5ob3N0cG9ydC4g
ClRoZSBhc3NvY2lhdGlvbiBpcyBzdGlsbCBjcmVhdGVkLCBzbyB0ZWFyZG93biBjYW4gTlVMTC1k
ZXJlZmVyZW5jZSBpdCBpbiBudm1ldF8KZmNfaG9zdHBvcnRfcHV0KCksIGFuZCBpbiBudm1ldF9m
Y194bXRfZGlzY29ubmVjdF9hc3NvYygpIHdoZW4gb3BzLT5sc19yZXEgaXMgc2V0LgoKbnZtZXRf
ZmNfaG9zdHBvcnRfcHV0KCkgbmVlZHMgdGhlIHNhbWUgY2hlY2suIE5vIGhvc3Rwb3J0IGlzIGFs
bG9jYXRlZCBhbmQgCm5vIGtyZWYgaXMgdGFrZW4sIGJ1dCBudm1ldF9mY190YXJnZXRfYXNzb2Nf
ZnJlZSgpIHN0aWxsIGNhbGxzIG52bWV0X2ZjX2hvc3Rwb3J0X3B1dChhc3NvYy0+aG9zdHBvcnQp
LCAKd2hpY2ggZG9lcyBrcmVmX3B1dCgmaG9zdHBvcnQtPnJlZiwgbnZtZXRfZmNfaG9zdHBvcnRf
ZnJlZSkuCgpCZXN0IHJlZ2FyZC4KVGFuWmhlbmcu

