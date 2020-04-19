Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8FCC38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:49:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA79212CC
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uuv+0UF7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OhNGto8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA79212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GCsX+YUdlHxwjHciSW/ePbDPFjzF1IxziIsqs4iUPKw=; b=uuv+0UF7KoHdcl
	PI0fhOcs/zRuQ/L8T0d3zeHz616ZXrHbYagc5d4u0VJ7T+oYs1b1ZyfUeaVz1FtGhMAQgV5c4km/w
	UMGmYBNlBE5eQIqFB0qAw08KXCG3zgzasoyO2PXOsiLoGsYiFw5ifHCxxjVYNOto+7nX6Gi3Fpxgn
	sNKM+OI9+b71mZhSnVppV8CGNIMUJTa0zVRaAFdP4+J+DEZoRbX8zWUyt1B4pSx2ZGbaaUbQPNohH
	No0MyB75LVysHSr/IZsAKHaY38dyAz//u0vD6foBtJsO42NgcZwXmaH48W5SjcogwW7cuzQ+OuRFP
	CzrPah62PKpz+upnVslA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJhB-0005jZ-0A; Sun, 19 Apr 2020 23:49:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJgo-0005UL-AY
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:49:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340170; x=1618876170;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yPaDT72MuFYr5VwrhNSKg603xbDFgHyyYn6GpMBpT2o=;
 b=OhNGto8ZDGBu0rFC/O8/rfx+y55G5r9cS3siJFKZkbB/f4USLjeK6Hur
 LfpuxPW58uMVvrewURDtx8Ro2Yb/uNmUfympHMyzlfY+cgS92OOsZAU3y
 d8Y+R6XL8C/NQjDoUDSffDQGxEreUtFxWLchEJ3MGyV4D5W1+2wrmMQJQ
 ahID3CSWHcV++s3dTrCOylJiH+huh45J3qD/DTyqXzKsNDufUgU/4I93l
 KADHp6tMIO0kEWkmpGuR/TC65w05uyIAW5eRSGIsMP9mj7srU4A5R0uJH
 PxfteePpKWaVF+oAnV7CadKa5aaW566gTYcRZArVsTC13H856qMvy7KWY A==;
IronPort-SDR: 8DClCYhku3KXsibCAuYEywZhQ92ihlaS+QCEDxgXzP6AccfR88AYHoEwCu/sxvu3QA2bBZ4f8x
 MaAODj1cTWsEfF2QopHWPNBJ0kMVLGTioP5MrQCJJCNAkzjky0aXH82DgWzUYsfjsRpzwDmwAI
 uWUQv4RQD+7pedit20dLbZtwEOl+C5YbOPWEpJZpyA7qlY8z+EdMNha7Sn/5JAsXYZf8W5TdTk
 loE7bLDvH35LoWz2E3yFxOhxV9pa+mHWATttL+oja0cN/aLOL6R/5WwNJetK+IUKtYviPwVvUl
 EHw=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="244367312"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:49:30 +0800
IronPort-SDR: rqi4B8Tt7ZMamNZYNcwWrVCOSkTBO6k9NLDTzMIm7dAf6bFYQY6qcof4DfSqY68cSQIfCtIh+o
 Yf9JWF5SaFE8qgR3w04dglgbLECRh8VlE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:40:24 -0700
IronPort-SDR: 5cn53HeJo7fh1+oIh0J1FkOVM7ew1d9S9sxLOBK/RbG101S59d0aZBB2F0eA0UkztWdobDSxfk
 JR29qgaeNyvQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:49:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 3/7] nvmet: export resize thread enable-disable attr
Date: Sun, 19 Apr 2020 16:48:52 -0700
Message-Id: <20200419234856.59901-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
References: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_164930_390750_D4983F75 
X-CRM114-Status: GOOD (  11.16  )
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

V2UgaW1wbGVtZW50IG5zLXJldmFsaWRhdGlvbiBmZWF0dXJlIGFzIGEgbWVjaGFuaXNtIGFuZCBu
b3QgYXMgYSBwb2xpY3kKYW5kIGFsbG93IHVzZXIgdG8gc2V0IHRoZSBwb2xpY2llcy4gVGhpcyBh
bHNvIGFsbG93cyBtb3JlIGZsZXhpYmlsaXR5IHRvCnVzZXIuCgpUaGlzIHBhdGNoIGFkZHMgYSBu
ZXcgY29uZmlnZnMgYXR0cmlidXRlcyBzbyB0aGF0IHVzZXIgY2FuIGVuYWJsZS8KZGlzYWJsZSBy
ZXNpemUgbW9uaXRvciB0aHJlYWQgYXMgYW5kIHdoZW4gbmVlZGVkIGJ5IGFsbG93aW5nIHVzZXIg
dG8KZGVjaWRlIG9uIHRoZSBwb2xpY3kuIMKgCgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPgotLS0KIGRyaXZlcnMvbnZtZS90YXJn
ZXQvY29uZmlnZnMuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRy
aXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaCAgICB8IDEzICsrKysrKysrKysrKysKIDIgZmlsZXMg
Y2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvY29uZmlnZnMuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYwppbmRleCBiMGU4
NDAyN2IzYmMuLmY2ZmJlNTlmYzYwYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9j
b25maWdmcy5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYwpAQCAtMTA1MCw4
ICsxMDUwLDQyIEBAIHN0YXRpYyBzdHJ1Y3QgY29uZmlnZnNfZ3JvdXBfb3BlcmF0aW9ucyBudm1l
dF9zdWJzeXN0ZW1zX2dyb3VwX29wcyA9IHsKIAkubWFrZV9ncm91cAkJPSBudm1ldF9zdWJzeXNf
bWFrZSwKIH07CiAKK3N0YXRpYyBzc2l6ZV90IG52bWV0X2NvbnRyb2xfZ3JvdXBfY29udHJvbF9y
ZXNpemVfcmVmcmVzaF9zaG93KAorCQlzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sIGNoYXIgKnBh
Z2UpCit7CisJcmV0dXJuIHNucHJpbnRmKHBhZ2UsIFBBR0VfU0laRSwgIiV1XG4iLAorCQkJdG9f
bnZtZXRfY29udHJvbChpdGVtKS0+ZW5hYmxlKTsKK30KKworc3RhdGljIHNzaXplX3QgbnZtZXRf
Y29udHJvbF9ncm91cF9jb250cm9sX3Jlc2l6ZV9yZWZyZXNoX3N0b3JlKAorCQlzdHJ1Y3QgY29u
ZmlnX2l0ZW0gKml0ZW0sIGNvbnN0IGNoYXIgKnBhZ2UsIHNpemVfdCBjb3VudCkKK3sKKwlzdHJ1
Y3QgbnZtZXRfY29udHJvbF9jb25maWdmcyAqY29udHJvbCA9IHRvX252bWV0X2NvbnRyb2woaXRl
bSk7CisJYm9vbCBlbmFibGU7CisKKwlpZiAoa3N0cnRvYm9vbChwYWdlLCAmZW5hYmxlKSkKKwkJ
cmV0dXJuIC1FSU5WQUw7CisKKwltdXRleF9sb2NrKCZtb25pdG9yLT5jb250cm9sX2xvY2spOwor
CWNvbnRyb2wtPmVuYWJsZSA9IGVuYWJsZTsKKwlpZiAoY29udHJvbC0+ZW5hYmxlKQorCQludm1l
dF9lbmFibGVfbnNfcmVzaXplX21vbml0b3IoKTsKKwllbHNlCisJCW52bWV0X2Rpc2FibGVfbnNf
cmVzaXplX21vbml0b3IoKTsKKwltdXRleF91bmxvY2soJm1vbml0b3ItPmNvbnRyb2xfbG9jayk7
CisJcmV0dXJuIGNvdW50OworfQorCitDT05GSUdGU19BVFRSKG52bWV0X2NvbnRyb2xfZ3JvdXBf
LCBjb250cm9sX3Jlc2l6ZV9yZWZyZXNoKTsKKworc3RhdGljIHN0cnVjdCBjb25maWdmc19hdHRy
aWJ1dGUgKm52bWV0X2NvbnRyb2xfZ3JvdXBfYXR0cnNbXSA9IHsKKwkmbnZtZXRfY29udHJvbF9n
cm91cF9hdHRyX2NvbnRyb2xfcmVzaXplX3JlZnJlc2gsCisJTlVMTCwKK307CisKIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgY29uZmlnX2l0ZW1fdHlwZSBudm1ldF9zdWJzeXN0ZW1zX3R5cGUgPSB7CiAJ
LmN0X2dyb3VwX29wcwkJPSAmbnZtZXRfc3Vic3lzdGVtc19ncm91cF9vcHMsCisJLmN0X2F0dHJz
CQk9IG52bWV0X2NvbnRyb2xfZ3JvdXBfYXR0cnMsCiAJLmN0X293bmVyCQk9IFRISVNfTU9EVUxF
LAogfTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oIGIvZHJpdmVy
cy9udm1lL3RhcmdldC9udm1ldC5oCmluZGV4IDdmZTZkNzA1Y2JmMS4uNzk2YWNkNDIyNmExIDEw
MDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgKKysrIGIvZHJpdmVycy9udm1l
L3RhcmdldC9udm1ldC5oCkBAIC02Miw2ICs2MiwxOSBAQCBzdHJ1Y3QgbnZtZXRfcmVzaXplX21v
bml0b3IgewogCiBleHRlcm4gc3RydWN0IG52bWV0X3Jlc2l6ZV9tb25pdG9yICptb25pdG9yOwog
CitzdHJ1Y3QgbnZtZXRfY29udHJvbF9jb25maWdmcyB7CisJYm9vbCAgICAgICAgICAgICAgICAg
ICAgZW5hYmxlOworCXN0cnVjdCBjb25maWdfZ3JvdXAgICAgIGdyb3VwOworfTsKKworc3RhdGlj
IGlubGluZSBzdHJ1Y3QgbnZtZXRfY29udHJvbF9jb25maWdmcyAqdG9fbnZtZXRfY29udHJvbCgK
KwkJc3RydWN0IGNvbmZpZ19pdGVtICppdGVtKQoreworCXN0cnVjdCBjb25maWdfZ3JvdXAgKmdy
b3VwID0gdG9fY29uZmlnX2dyb3VwKGl0ZW0pOworCisJcmV0dXJuIGNvbnRhaW5lcl9vZihncm91
cCwgc3RydWN0IG52bWV0X2NvbnRyb2xfY29uZmlnZnMsIGdyb3VwKTsKK30KKwogc3RydWN0IG52
bWV0X25zIHsKIAlzdHJ1Y3QgbGlzdF9oZWFkCWRldl9saW5rOwogCXN0cnVjdCBwZXJjcHVfcmVm
CXJlZjsKLS0gCjIuMjIuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
