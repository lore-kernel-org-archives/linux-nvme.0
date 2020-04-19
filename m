Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808C8C38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:50:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BBA212CC
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="axdBfr1G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="noaAx/GB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BBA212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QQmbDRrp1cng51lZkzxNi2lkIPChKsaezjp89CAzgBE=; b=axdBfr1GLhiOgo
	4PDEbKkH1BQwIVfSoglNYJG2RD5wCgq6nhdDpaspVA3Mz8t9ckbCBGxy4Pm1SlarOh9BjJePYdIVv
	zuONLQqEUSHOb/n95txF3BuVv/TUsaLjYLceOhoh0pvxCNlnlxC/PQsfi1xfIhBeGJ79GdvQ17D0G
	9OJGRm4CYLi50AocrwQEFKvRsI2gRHtLtDV9xxEVHECdx61ciXNBlT7u/PZpmlP2n5OJLO2b6sL0+
	aoFvSPO7ibp3Ekcy4bghfDXRUB8FIHSihLuTzdHa/A0EzTAGZr4csPPrkTWDyvJMrA3OHsZ/dhobk
	UzctUqMBXn78sG3y1aSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJhT-00075T-H7; Sun, 19 Apr 2020 23:50:11 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJh4-0005g5-5n
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340203; x=1618876203;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6bw3okjnPsvuFZNTZwTRnPv2pYQBMyIEp+mcENmwG+0=;
 b=noaAx/GBt3RLkz4zjps/lJsKK70xusC+CIqAbbfA4YdjScwCJZK94InL
 Pok/N5PxSJdTRTUJagVHC0Vbx01DOvX/niLM2qEGILK8uzeuhnhKEgVSM
 T0TtL7g1l3bF3zdwn22TW87pkFr2e3q6O0RTAmu75/ceFttShq39Bs2Kq
 VzR8uZpUuU/3acdyAL+y27qIXB9ihzIabPmuFM/Yb3Z066HZsLRw2/MVT
 ShWZ2dO3Dlrv1JAg+OCXszHwkSNRmu2IQZbt4aGqxedUJQpr6DUbNoDYc
 dYKOXLXQJDhwZTCk8yLQahrA3kcwnVrRamHu1OzWo5uE8YOBxjE9XsVL/ g==;
IronPort-SDR: 93XD0BZBg9e80z5SC/Mtp/AoopxlsgEETEFi8RH7bdQctzm+3v0+L14JoBTVJx++AwR4GsGha8
 ahrDBQFneyowfNG/QNvf70z5Z/mDL8cT7yWpRhx/F442oUJU7/gP+t3/3YsBvAO9UtNzsGUAEz
 dy0VaMdgpTvT/qonRtp+H98418b+k6500zWCqYDxTLrIo0KX72U/Ud8VyVnbs4Jd9VLicwGSgL
 0e6IREM+nZZhNfVkVfgnWGMeVdLs4XPwDilij34RFDWWpNoX4hNfaUtWoPUq8kQceLS1uPLtOO
 mVc=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="238116483"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:50:02 +0800
IronPort-SDR: 1FMXOHYmdUUDM2BQDHZFHdG4l5yeQ6ksfE0oaX9ARSDAC68UKuop4IkDE/B3RCEwG3a9WoPjVB
 mnZgL2rGXp7tzD8zdr4WLhec4nXpZaX2c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:40:07 -0700
IronPort-SDR: AX13fL94Qf1xgs5x5MNKZwMMwu+YpgHilmpPYMCPOPsUObhusJlndt03UgfyWul6vuGfzJKMfF
 fs1bSTKImoFw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:49:45 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 5/7] nvmet: export resize thread sched attributes
Date: Sun, 19 Apr 2020 16:48:54 -0700
Message-Id: <20200419234856.59901-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
References: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_164946_294839_445D0581 
X-CRM114-Status: GOOD (  11.93  )
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

V2UgaW1wbGVtZW50IG5zLXJldmFsaWRhdGlvbiBmZWF0dXJlIGFzIGEgbWVjaGFuaXNtIGFuZCBh
bGxvdyB1c2VyIHRvCmRlY2lkZSBwb2xpY3kgYWJvdXQgdGhlIHNhbWUuIFRoaXMgYWxsb3dzIG1v
cmUgZmxleGliaWxpdHkgdG8gdXNlci4gVGhpcwpwYXRjaCBhZGRzIGEgbmV3IGNvbmZpZ2ZzIGF0
dHJpYnV0ZXMgc28gdGhhdCB1c2VyIGNhbiBzZXQgdGhlIHNjaGVkdWxpbmcKcGFyYW1ldGVycyBz
dWNoIGFzIHNjaGVkdWxpbmcgcG9saWN5IGFuZCBwcmlvcml0eSBmb3IgbW9uaXRvciB0aHJlYWQg
YXMKYW5kIHdoZW4gbmVlZGVkIGJ5IGFsbG93aW5nIHVzZXIgdG8gZGVjaWRlIG9uIHRoZSBwb2xp
Y3kuIMKgCgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxr
YXJuaUB3ZGMuY29tPgotLS0KIGRyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYyB8IDcwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbnZtZS90YXJnZXQvbnZt
ZXQuaCAgICB8ICAyICsKIDIgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYyBiL2RyaXZlcnMvbnZtZS90YXJn
ZXQvY29uZmlnZnMuYwppbmRleCA1N2M5NzM3NzMxODAuLmJlNGZhNzc5N2ExNiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9udm1lL3RhcmdldC9jb25maWdmcy5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJn
ZXQvY29uZmlnZnMuYwpAQCAtMTA1MCw2ICsxMDUwLDc0IEBAIHN0YXRpYyBzdHJ1Y3QgY29uZmln
ZnNfZ3JvdXBfb3BlcmF0aW9ucyBudm1ldF9zdWJzeXN0ZW1zX2dyb3VwX29wcyA9IHsKIAkubWFr
ZV9ncm91cAkJPSBudm1ldF9zdWJzeXNfbWFrZSwKIH07CiAKK3N0YXRpYyBzc2l6ZV90IG52bWV0
X2NvbnRyb2xfZ3JvdXBfY29udHJvbF9yZXNpemVfc2NoZWRfcHJpb3JpdHlfc2hvdygKKwkJc3Ry
dWN0IGNvbmZpZ19pdGVtICppdGVtLCBjaGFyICpwYWdlKQoreworCXJldHVybiBzbnByaW50Zihw
YWdlLCBQQUdFX1NJWkUsICIldVxuIiwKKwkJCXRvX252bWV0X2NvbnRyb2woaXRlbSktPnNjaGVk
X3ByaW9yaXR5KTsKK30KKworc3RhdGljIHNzaXplX3QgbnZtZXRfY29udHJvbF9ncm91cF9jb250
cm9sX3Jlc2l6ZV9zY2hlZF9wcmlvcml0eV9zdG9yZSgKKwkJc3RydWN0IGNvbmZpZ19pdGVtICpp
dGVtLCBjb25zdCBjaGFyICpwYWdlLCBzaXplX3QgY291bnQpCit7CisJc3RydWN0IG52bWV0X2Nv
bnRyb2xfY29uZmlnZnMgKmNvbnRyb2wgPSB0b19udm1ldF9jb250cm9sKGl0ZW0pOworCXUzMiBz
Y2hlZF9wcmlvcml0eTsKKwlpbnQgcmV0ID0gMDsKKworCWlmIChrc3RydG91MzIocGFnZSwgMTAs
ICZzY2hlZF9wcmlvcml0eSkpIHsKKwkJcmV0ID0gLUVJTlZBTDsKKwkJZ290byBvdXQ7CisJfQor
CisJbXV0ZXhfbG9jaygmbW9uaXRvci0+Y29udHJvbF9sb2NrKTsKKwlpZiAoY29udHJvbC0+ZW5h
YmxlKSB7CisJCW11dGV4X3VubG9jaygmbW9uaXRvci0+Y29udHJvbF9sb2NrKTsKKwkJcmV0ID0g
LUVJTlZBTDsKKwkJZ290byBvdXQ7CisJfQorCWNvbnRyb2wtPnNjaGVkX3ByaW9yaXR5ID0gc2No
ZWRfcHJpb3JpdHk7CisJbW9uaXRvci0+c2NoZWRfcHJpb3JpdHkgPSBzY2hlZF9wcmlvcml0eTsK
KwltdXRleF91bmxvY2soJm1vbml0b3ItPmNvbnRyb2xfbG9jayk7CitvdXQ6CisJcmV0dXJuIHJl
dCA/IHJldCA6IGNvdW50OworfQorCitDT05GSUdGU19BVFRSKG52bWV0X2NvbnRyb2xfZ3JvdXBf
LCBjb250cm9sX3Jlc2l6ZV9zY2hlZF9wcmlvcml0eSk7CisKK3N0YXRpYyBzc2l6ZV90IG52bWV0
X2NvbnRyb2xfZ3JvdXBfY29udHJvbF9yZXNpemVfc2NoZWRfcG9saWN5X3Nob3coCisJCXN0cnVj
dCBjb25maWdfaXRlbSAqaXRlbSwgY2hhciAqcGFnZSkKK3sKKwlyZXR1cm4gc25wcmludGYocGFn
ZSwgUEFHRV9TSVpFLCAiJXVcbiIsCisJCQl0b19udm1ldF9jb250cm9sKGl0ZW0pLT5zY2hlZF9w
b2xpY3kpOworfQorCitzdGF0aWMgc3NpemVfdCBudm1ldF9jb250cm9sX2dyb3VwX2NvbnRyb2xf
cmVzaXplX3NjaGVkX3BvbGljeV9zdG9yZSgKKwkJc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLCBj
b25zdCBjaGFyICpwYWdlLCBzaXplX3QgY291bnQpCit7CisJc3RydWN0IG52bWV0X2NvbnRyb2xf
Y29uZmlnZnMgKmNvbnRyb2wgPSB0b19udm1ldF9jb250cm9sKGl0ZW0pOworCXUzMiBzY2hlZF9w
b2xpY3k7CisJaW50IHJldCA9IDA7CisKKwlpZiAoa3N0cnRvdTMyKHBhZ2UsIDEwLCAmc2NoZWRf
cG9saWN5KSkgeworCQlyZXQgPSAtRUlOVkFMOworCQlnb3RvIG91dDsKKwl9CisKKwltdXRleF9s
b2NrKCZtb25pdG9yLT5jb250cm9sX2xvY2spOworCWlmIChjb250cm9sLT5lbmFibGUpIHsKKwkJ
bXV0ZXhfdW5sb2NrKCZtb25pdG9yLT5jb250cm9sX2xvY2spOworCQlyZXQgPSAtRUlOVkFMOwor
CQlnb3RvIG91dDsKKwl9CisJY29udHJvbC0+c2NoZWRfcG9saWN5ID0gc2NoZWRfcG9saWN5Owor
CW1vbml0b3ItPnNjaGVkX3BvbGljeSA9IHNjaGVkX3BvbGljeTsKKwltdXRleF91bmxvY2soJm1v
bml0b3ItPmNvbnRyb2xfbG9jayk7CitvdXQ6CisJcmV0dXJuIHJldCA/IHJldCA6IGNvdW50Owor
fQorCitDT05GSUdGU19BVFRSKG52bWV0X2NvbnRyb2xfZ3JvdXBfLCBjb250cm9sX3Jlc2l6ZV9z
Y2hlZF9wb2xpY3kpOworCiBzdGF0aWMgc3NpemVfdCBudm1ldF9jb250cm9sX2dyb3VwX2NvbnRy
b2xfcmVzaXplX3JlZnJlc2hfc2hvdygKIAkJc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLCBjaGFy
ICpwYWdlKQogewpAQCAtMTEwNCw2ICsxMTcyLDggQEAgc3RhdGljIHNzaXplX3QgbnZtZXRfY29u
dHJvbF9ncm91cF9jb250cm9sX3Jlc2l6ZV90aW1lb3V0X3N0b3JlKAogQ09ORklHRlNfQVRUUihu
dm1ldF9jb250cm9sX2dyb3VwXywgY29udHJvbF9yZXNpemVfdGltZW91dCk7CiAKIHN0YXRpYyBz
dHJ1Y3QgY29uZmlnZnNfYXR0cmlidXRlICpudm1ldF9jb250cm9sX2dyb3VwX2F0dHJzW10gPSB7
CisJJm52bWV0X2NvbnRyb2xfZ3JvdXBfYXR0cl9jb250cm9sX3Jlc2l6ZV9zY2hlZF9wcmlvcml0
eSwKKwkmbnZtZXRfY29udHJvbF9ncm91cF9hdHRyX2NvbnRyb2xfcmVzaXplX3NjaGVkX3BvbGlj
eSwKIAkmbnZtZXRfY29udHJvbF9ncm91cF9hdHRyX2NvbnRyb2xfcmVzaXplX3JlZnJlc2gsCiAJ
Jm52bWV0X2NvbnRyb2xfZ3JvdXBfYXR0cl9jb250cm9sX3Jlc2l6ZV90aW1lb3V0LAogCU5VTEws
CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmggYi9kcml2ZXJzL252bWUv
dGFyZ2V0L252bWV0LmgKaW5kZXggZDE0Zjc5MmYzMjdlLi4xNWNiMzM3Y2Q5YjggMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaAorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0
L252bWV0LmgKQEAgLTYzLDYgKzYzLDggQEAgc3RydWN0IG52bWV0X3Jlc2l6ZV9tb25pdG9yIHsK
IGV4dGVybiBzdHJ1Y3QgbnZtZXRfcmVzaXplX21vbml0b3IgKm1vbml0b3I7CiAKIHN0cnVjdCBu
dm1ldF9jb250cm9sX2NvbmZpZ2ZzIHsKKwl1MzIJCQlzY2hlZF9wcmlvcml0eTsKKwl1MzIJCQlz
Y2hlZF9wb2xpY3k7CiAJYm9vbCAgICAgICAgICAgICAgICAgICAgZW5hYmxlOwogCXN0cnVjdCBj
b25maWdfZ3JvdXAgICAgIGdyb3VwOwogCXUzMgkJCW1zZWM7Ci0tIAoyLjIyLjEKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxp
bmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
