Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD8C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1A864E45
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1A864E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QVmoVfJyv5Uy076ZCcwCmE39T40iP3H4NrJJPI6+3cc=; b=fEIy0uT7/Fe/Q2O3gDBUrH550
	rEN80FyUojZippacbpxT6SgZXRh+4aBjzzyUb2TLdG//s+2cXu0WTflunCQPI4PTQ7BgEkZdhkSVL
	nNGLU/Z88ljronqyjxXL2afCQ1uEp/bY8LaWnxtgDi7F+n5ZUFJhUz06pdJ93sdWWi7UR3ByDUsX5
	IC5MM4/ujB0glDG+NWB0g4aYsi4JJ0KcmHeNgjaAHjaK6s7UR50cDWweo75dlAGCednvCajQPXzeF
	Psu+wEmKlJw6AfpOdDCKBISIfJSh7oepvchW74wz/F8h8FF89K56zoQ7LKwDhNgFn5C7YB+kyPh21
	8w6fvKtfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iNI-00075R-Fq; Wed, 10 Feb 2021 05:49:16 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iNF-000742-SG
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936153; x=1644472153;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZMFIjq/D8g27gEw+tEHJS6OWJntYoNbVSk5eHeJjEsQ=;
 b=ng9c/w3MLFo82LJVzKShzUqbHNRTeMbtAGCnZW5/o9zul0QSLuMgEwJ0
 jNpsILKs6J/p5ufkNAn1nJbEH/rWRri75m6ntMHFISB/GnlYixBgK2Nn0
 GOBqZH6h4exA2BxOBOvpHgCqceoLfGpVuLgCvsd3V3syuS3iL7EHMKRsF
 mfGw9nhhEySs0T41/Iv8GfJq7GthnInZfNKtjXlEE2ZmR/y5k2jPkwsGe
 Hhfvvsy3UngX6/gVodb7OrIJ11R3a3x9u6MDjM5jsdC+k0Wa11G1T/QpJ
 OlHlaBiVIZXJ0nVkAA5QJsjSmP+Vjs2fVgZuBSNHxWvj7J7IQDSdh53T7 A==;
IronPort-SDR: oBkP5aqwQ169WBsWSZuXSP1hOJxaNl+IyGlSVXtJxaiGetZvLQT183jDbYC9mSeX/wP+MpCRpn
 Ts1Xg5g8czjyVs3Vz6FoeNhVVWVqXeVQljkRlWYbqPXakmu86KMzjfpyjU4wVAQc74Uy2LMsyk
 8Z96gUfSBTY+6oGXg4zNlXt+i+gnKtSCpyCVBS7MivFEkiUDF3Kd5ZTtdcojkqB3bL8LSYJgj1
 tKxGKPxthOIZDJ3CByO5LfTFsIZ7YVXhCSYiaQtHXGKEqEJRDH7ddd9mOYre2skA2YqfOXUZVJ
 G7s=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="159609305"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:49:13 +0800
IronPort-SDR: VCG9JbzrHyW3DtLe5d7x0et2y0i5GZmaoCLzidDUNIMMq11vwVCnOQLC0nLGlCEshHq/v86ILA
 0ECc9H2/Kdz57IWQx5VjVDSQeqlFlU6bstkso5GWBkZTt0F/9kITZRWfQ07eEifRdapsNPR4I+
 pk/FKbrgXC4bbvHMwXvapy5lP+Y+p658c/p+MmJH4F3pNI5Ve9FXjv5Tevjci3XwdiomftkH6g
 kkcIhce438r5Ix3Gegl8s+L0RG0QPt+yqQnUO6cLY9UqIbSOrwCERX3zy5r9s1ETD21P4gspSo
 QsHUsxUz18I26TvFL9/lM/X/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:32:56 -0800
IronPort-SDR: 2gRY/kpqXZcsdJMLo6beMg6LcPWsUvMGyJEzIYxISeFNz+yhK7WkE1QQCRowqVKxELR7VEcKDP
 dinlJljlSLlI4GOyBFI2SRgIWfzVHch2PUr1pc3BZC2i1FWvubvUpbDvhSHmpPs/GUgN7+b4Ry
 g2U98Ygnl94RV9bQXYkWrvuVN5IBsGBR+bAckWo+cbEc6qzmUkn4m6mjvel2BVxICjNGYijgF/
 CYGQ3bqHz40x+ARCpoFJjc9hq6Q8zoxzI715850xKfS9xahYcPtXa9q9EKBLq/kIMYgdzblL2Z
 AQY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:49:13 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 09/11] nvme-loop: rename variable to get rid of the warn
Date: Tue,  9 Feb 2021 21:48:00 -0800
Message-Id: <20210210054802.34269-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004914_051303_5B5ABBD0 
X-CRM114-Status: GOOD (  13.01  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

UmVuYW1lIHRoZSBudm1lX2xvb3BfaW5pdF9yZXF1ZXN0KCkgbnVtYV9ub2RlIHBhcmFtZXRlciB0
bwpod19xdWV1ZV9udW1hX25vZGUgc28gdGhhdCB3ZSBjYW4gZ2V0IHJpZCBvZiB0aGUgZm9sbG93
aW5nIHdhcm5pbmcgOi0KCmRyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jOiBJbiBmdW5jdGlvbiDi
gJhudm1lX2xvb3BfaW5pdF9yZXF1ZXN04oCZOgpkcml2ZXJzL252bWUvdGFyZ2V0L2xvb3AuYzoy
MDU6MTY6IHdhcm5pbmc6IGRlY2xhcmF0aW9uIG9mIOKAmG51bWFfbm9kZeKAmSBzaGFkb3dzIGEg
Z2xvYmFsIGRlY2xhcmF0aW9uIFstV3NoYWRvd10KICAgdW5zaWduZWQgaW50IG51bWFfbm9kZSkK
ClNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdk
Yy5jb20+Ci0tLQogZHJpdmVycy9udm1lL3RhcmdldC9sb29wLmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvdGFyZ2V0L2xvb3AuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jCmluZGV4IGNi
NmY4NjU3MmIyNC4uODhkMDY1NmFkNGE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0
L2xvb3AuYworKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2xvb3AuYwpAQCAtMjAyLDcgKzIwMiw3
IEBAIHN0YXRpYyBpbnQgbnZtZV9sb29wX2luaXRfaW9kKHN0cnVjdCBudm1lX2xvb3BfY3RybCAq
Y3RybCwKIAogc3RhdGljIGludCBudm1lX2xvb3BfaW5pdF9yZXF1ZXN0KHN0cnVjdCBibGtfbXFf
dGFnX3NldCAqc2V0LAogCQlzdHJ1Y3QgcmVxdWVzdCAqcmVxLCB1bnNpZ25lZCBpbnQgaGN0eF9p
ZHgsCi0JCXVuc2lnbmVkIGludCBudW1hX25vZGUpCisJCXVuc2lnbmVkIGludCBod19xdWV1ZV9u
dW1hX25vZGUpCiB7CiAJc3RydWN0IG52bWVfbG9vcF9jdHJsICpjdHJsID0gc2V0LT5kcml2ZXJf
ZGF0YTsKIAotLSAKMi4yMi4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
