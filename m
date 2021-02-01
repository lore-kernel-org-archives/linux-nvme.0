Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EA9C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:43:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8906C64E29
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8906C64E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QVmoVfJyv5Uy076ZCcwCmE39T40iP3H4NrJJPI6+3cc=; b=jnPfB6OK/mhVEI8CT8fI0Kseq
	FZgHtIZjmrXvoIx1LbHL8oV2yiHPya02hioXV0SjOITSFGEB/zG3ku8Cig5TWedPzo7P53OiMHAnA
	A1m5UAI6Q4El/Fnd4LKWriQWOc2MiOjZLyFnDWH12zL0ZSrnCKWjfLjp+HuHUstQ1zYN7HQAeuc0L
	60Lp8gpDeXlRMs/UdibHELiQOllqmavJu2ql28+tIXoTm71YGbuiVVQ+NQckvrbdmH2CxYyyR+Wer
	Xl4K+WkJd/5gMsogd2JhlOz4Bji669dk/99I5lsv+r1JBMwHYxaFDemQSfcAgwxiWIWOmKu+bMch5
	+5z5yMkUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6RzI-0005B7-6r; Mon, 01 Feb 2021 05:43:00 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6RzD-00058C-Lc
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:42:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612159261; x=1643695261;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZMFIjq/D8g27gEw+tEHJS6OWJntYoNbVSk5eHeJjEsQ=;
 b=ktzR/klMYujH6FBT76vXkQRePq+BYKrCTHRVvs7du6EJtXGAVrIokKw8
 ayEDUPXGXAMk/9qhoM9e6FIRM5KHuJ40dF69DLNjX5Ef5XE5etOlVhVw3
 tfJG/gyOwq8vGzUD39fQ3369ckg3gxdYcf+9RyLBI9p4Ru38uJ8rvFtJo
 SoOvp7QJ+iWqEFcDLDaUCacSh7RFXSlpjuRVa8275018hEaKYewf37DEa
 ll3dlEBmbP4Xk5XNL/gomnx7LMFHNjjQLdruQGP2bhjVYql+GNorqHe9/
 GkcV0pgxWp7hwbuC2qyoCDD+ovqgbHSH35mqM2ivyiOW2lbs3tdvGOkco w==;
IronPort-SDR: fR27c387xhWbn8OdzSTZGi3/VF63ykKxynQrCETfErFQAbO7MGpumC8LPicYOhxZLTGy7XN9kW
 IjcxLgi3if5Uvf0+PoUJNhbtAMVg4c+Am24yVfVbF3yWXyvF7TEIjAZmXVxG0TQ7SssCLR0LSS
 YoWdM2nxhK89KcO2Nd8vjGCpIwwO0u3YDtP8lZhpYr/vR72mAKgh0J3kROHitq9Fi5jQC2DRKo
 sUR9pq3zzfAUANSbuzMX4io4ABQc5mSHLaC2CbxIduexQ/yyIHceRPHJZXJsVUcsIPE8JLcp2/
 Fvo=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="262851355"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 14:00:59 +0800
IronPort-SDR: hkOJnxb7KWIreU++iaujyI8fkykMlHd3cJGaCXApNRdhUmLD4CnaGnCqG4NQrhjaoewxbf5q+/
 nrRl6pt6rsQJtaLvcgNzaJ6bn9/byjxoJL77YyO2019CU7hGM60e7O8GXGsWpzLCyy6JXA+YmY
 YdTm3cTbFyVtgJhNDkhJNYFWdX3Zvif2Vc3C2qcFvATmhCPBzG0RsNIzdKGIlSwc05dXp4024K
 vpKJPyN0ygD/ptDbIgwd6lU6EFCzZUqbAAnue5S2z5MdpWSrbtSqKM1tJWx6L5d0W55cMZoMU2
 ODZJjmSKMgJcPNx+qnrHeg1y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:25:04 -0800
IronPort-SDR: YtuXOqAZxIsgK9q5XhSNA4hu1VJLVA4WtrXaptgQbQLjEwkqKQRUzVKg5Mk7Zgl7UDD4CrzIpO
 jQdkOwgrq6qWeF+0D6w8yzJPucLnk28kuOeT2jozckh/UYb6xZGLFSiedS5tvnNMdEY9O7omI7
 VjX+ftKYUBukKxjIwyd1ro9VKJW2nqg2/rg1qmcPm9XYBaCYQr0Y8h1f14wIzTXhbtuToAlHmU
 gPES2hQhBGw44pLCp4gju/lnt0hIXqPPnG1T1muFgRIrT5lIfNC7t7LolhpjEw2PIvWYrDQcwg
 KHw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:42:55 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 10/10] nvme-loop: rename variable to get rid of the warn
Date: Sun, 31 Jan 2021 21:41:38 -0800
Message-Id: <20210201054138.34324-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004255_964871_541DFF24 
X-CRM114-Status: GOOD (  13.43  )
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
