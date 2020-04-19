Return-Path: <SRS0=yQ2W=6E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83843C5321D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 01:00:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A1B214D8
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 01:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z7CIHB6B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pfKBm3vB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A1B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sMBuu14vGhFVzS4bswTnI+4MAG47eyZsg71pl+7bfOY=; b=Z7CIHB6BECDH9Q
	FC+wMdD98AggPy3UqQf2a+1pGSZSWKLTftoJxgphR2kgU6ILK0kF1oazwpzOc5By+y2uHHWKdNUNT
	irXDzPozM8pw+3BE1uQejoaKtsmcxpzPosBPgjItBNGHH6dJ7qIEdKG1CUIZrRoeFsDbvNPGisMPq
	dZCvo+71d6i9UuEDz2EIa2HUR1RTB9wNcpXeVoj9xKTl2klHNfBOnG0/bUsM2UNj0JCJ+OBcZa3m3
	1e8rCqU+ORog3LcGkaNE7DnR7kY+TUlrRJMT5ForMYi7hp9IZHtqOyiex+KQl+GxtfKkI0/LHBLIM
	cIhCIH4aVsgx85Hg7dnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQKnK-00040H-Ki; Mon, 20 Apr 2020 01:00:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJgy-0005bW-Ad
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:49:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340180; x=1618876180;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1bjOhs5K+09PmX9s41TwM+KH5ZmYJCj4wd6o7d1MMWM=;
 b=pfKBm3vBnUbe53cEEvBiaSaYGcDXPeGx92F78NR6uYINzdKjl4H2x0hb
 +JJKc+fJFbWN3BRWe3UvuiNs5pVESqLu8dV3B5SZExTUw9eBze/dnhvph
 iGODFy1IqYNmxFNe2DPHJkjZg8BazrWj+EpVrPcezocHz22S0AP8rZsCf
 V+5JpLxIxPwenwgrWoM0/d4RCX9F132mSXN4/1jcSlkRxwP3GAecBQ7qf
 A8b1pEgSO5QGCLJPrhh3pMvPz5uZPr1a2jxb+5jwwyjzqPB/dtvy+yPzd
 usguhMmLnsAwueYQKm4T1ugSMOLbphxxUM23sAhIOD4851wCBL7cbuPPF A==;
IronPort-SDR: 4GzHZqimS+Vql+MbzgVdNl8CeEjqIHPHoOp2bnbXyEbSn2/3vdq2EjyoQptJgkmCYWpPVZiMkq
 0VHubM7iEDb9Vu37qm14qSKLlpzycGSVp8pzUIXsaPW3jM5mtgSwnke2M6SNpxOjZ5QaMwRKlu
 GScUK8X8FP9Uwb+f3MmGrRRUlPbsR4PDmUa43poR43UYrCmHGD3sSypkCOGkfrndLLi4aXMO2g
 EjX/V2U+ADTIS7UplglxGpfy6/bvBq4rTLjIFQCML8XvNNI5fldCUZnpaDq7vCKoUUYhhFhXTb
 Xgg=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="137096865"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:49:39 +0800
IronPort-SDR: TtVBQVPunMWbjsFHOAgQxfjdQb5yWY67Wnb9bntgLMi5Ci0vAIAIi/ae/Il3rSkOJ7iHdJMVOW
 /zt8e/PpNVkcNegrg9ekJNmqp5vxIdJMk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:40:01 -0700
IronPort-SDR: 7r4ZUh1mKvo62XWZquSXiOgmHDiC7Uikd4rm/b0Qy/QPAiLYqU/2HZFFuJLNpsFdwcU52CjREc
 PuqWdIxLFaPA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:49:39 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 4/7] nvmet: export resize thread scan interval
Date: Sun, 19 Apr 2020 16:48:53 -0700
Message-Id: <20200419234856.59901-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
References: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_164940_498390_AFFC2356 
X-CRM114-Status: GOOD (  13.23  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V2UgaW1wbGVtZW50IG5zLXJldmFsaWRhdGlvbiBmZWF0dXJlIGFzIGEgbWVjaGFuaXNtIGJ1dCBh
cyBhIHBvbGljeQp0aGF0IGFsbG93cyB1c2VyIHRvIHNldCB0aGUgcG9saWNpZXMuIFRoaXMgYWxz
byBhbGxvd3MgbW9yZSBmbGV4aWJpbGl0eQp0byB1c2VyLgoKQ3VycmVudGx5LCB3ZSBoYXZlIHN5
c3RlbXMgd2hpY2ggYXJlIHJ1bm5pbmcgd2l0aG91dCByZXNpemUgbW9uaXRvciwKdGhhdCBtZWFu
cyB3ZSBzaG91bGQgYXZvaWQgYW55IHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb25zIGludHJvZHVjZWQg
YnkKdGhpcyBmZWF0dXJlLiBPbiBzb21lIHN5c3RlbXMsIHRoZSBmcmVxdWVuY3kgb2YgdGhlIHJl
c2l6ZSBtb25pdG9yCmV4ZWN1dGlvbiBtYXkgcmVzdWx0IGluIGEgcG90ZW50aWFsIGRyb3AgaW4g
dGhlIHBlcmZvcm1hbmNlLgoKSW4gb3JkZXIgdG8gbWFrZSB0aGlzIGZlYXR1cmUgYmFja3dhcmQg
Y29tcGF0aWJsZSB0aGlzIHBhdGNoIGFkZHMgbmV3CmNvbmZpZ2ZzIGF0dHJpYnV0ZXMgc28gdGhh
dCB1c2VycyBjYW4gc2V0IGhvdyBvZnRlbiByZXNpemUgbW9uaXRvcgpzaG91bGQgY2hlY2sgZm9y
IHRoZSBBRU4gYnkgc2V0dGluZyB0aGUgdGltZW91dCB2YWx1ZSBpbiBtc2VjIGFzIGFuZAp3aGVu
IG5lZWRlZCzCoGFsbG93aW5nIHVzZXIgdG8gZGVjaWRlIG9uIHRoZSBwb2xpY3kuIMKgCgpTaWdu
ZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29t
PgotLS0KIGRyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYyB8IDI2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrCiBkcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmggICAgfCAgMSArCiAyIGZp
bGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
dGFyZ2V0L2NvbmZpZ2ZzLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMKaW5kZXgg
ZjZmYmU1OWZjNjBjLi41N2M5NzM3NzMxODAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvY29uZmlnZnMuYworKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMKQEAgLTEw
NzgsOCArMTA3OCwzNCBAQCBzdGF0aWMgc3NpemVfdCBudm1ldF9jb250cm9sX2dyb3VwX2NvbnRy
b2xfcmVzaXplX3JlZnJlc2hfc3RvcmUoCiAKIENPTkZJR0ZTX0FUVFIobnZtZXRfY29udHJvbF9n
cm91cF8sIGNvbnRyb2xfcmVzaXplX3JlZnJlc2gpOwogCitzdGF0aWMgc3NpemVfdCBudm1ldF9j
b250cm9sX2dyb3VwX2NvbnRyb2xfcmVzaXplX3RpbWVvdXRfc2hvdygKKwkJc3RydWN0IGNvbmZp
Z19pdGVtICppdGVtLCBjaGFyICpwYWdlKQoreworCXJldHVybiBzbnByaW50ZihwYWdlLCBQQUdF
X1NJWkUsICIldVxuIiwKKwkJCXRvX252bWV0X2NvbnRyb2woaXRlbSktPm1zZWMpOworfQorCitz
dGF0aWMgc3NpemVfdCBudm1ldF9jb250cm9sX2dyb3VwX2NvbnRyb2xfcmVzaXplX3RpbWVvdXRf
c3RvcmUoCisJCXN0cnVjdCBjb25maWdfaXRlbSAqaXRlbSwgY29uc3QgY2hhciAqcGFnZSwgc2l6
ZV90IGNvdW50KQoreworCXN0cnVjdCBudm1ldF9jb250cm9sX2NvbmZpZ2ZzICpjb250cm9sID0g
dG9fbnZtZXRfY29udHJvbChpdGVtKTsKKwl1MzIgbXNlYzsKKworCWlmIChrc3RydG91MzIocGFn
ZSwgMTAsICZtc2VjKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwltdXRleF9sb2NrKCZtb25pdG9y
LT5jb250cm9sX2xvY2spOworCWNvbnRyb2wtPm1zZWMgPSBtc2VjOworCW1vbml0b3ItPm1zZWMg
PSBtc2VjOworCW11dGV4X3VubG9jaygmbW9uaXRvci0+Y29udHJvbF9sb2NrKTsKKwlyZXR1cm4g
Y291bnQ7Cit9CisKK0NPTkZJR0ZTX0FUVFIobnZtZXRfY29udHJvbF9ncm91cF8sIGNvbnRyb2xf
cmVzaXplX3RpbWVvdXQpOworCiBzdGF0aWMgc3RydWN0IGNvbmZpZ2ZzX2F0dHJpYnV0ZSAqbnZt
ZXRfY29udHJvbF9ncm91cF9hdHRyc1tdID0gewogCSZudm1ldF9jb250cm9sX2dyb3VwX2F0dHJf
Y29udHJvbF9yZXNpemVfcmVmcmVzaCwKKwkmbnZtZXRfY29udHJvbF9ncm91cF9hdHRyX2NvbnRy
b2xfcmVzaXplX3RpbWVvdXQsCiAJTlVMTCwKIH07CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS90YXJnZXQvbnZtZXQuaCBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaAppbmRleCA3OTZh
Y2Q0MjI2YTEuLmQxNGY3OTJmMzI3ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9u
dm1ldC5oCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaApAQCAtNjUsNiArNjUsNyBA
QCBleHRlcm4gc3RydWN0IG52bWV0X3Jlc2l6ZV9tb25pdG9yICptb25pdG9yOwogc3RydWN0IG52
bWV0X2NvbnRyb2xfY29uZmlnZnMgewogCWJvb2wgICAgICAgICAgICAgICAgICAgIGVuYWJsZTsK
IAlzdHJ1Y3QgY29uZmlnX2dyb3VwICAgICBncm91cDsKKwl1MzIJCQltc2VjOwogfTsKIAogc3Rh
dGljIGlubGluZSBzdHJ1Y3QgbnZtZXRfY29udHJvbF9jb25maWdmcyAqdG9fbnZtZXRfY29udHJv
bCgKLS0gCjIuMjIuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
