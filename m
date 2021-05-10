Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DEEC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8770961492
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8770961492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EflC9nRwt/iT3yuBAa/UpPWywxPcmsvTXiATIfkvtL4=; b=MeKMXFlvveYjbmTkFHibN09p2
	vRiGPdRqCuetGVpccU3q3SxFnEu57zqOTNgpbS6BJ17JqWq5QR92SmXbwmmNXptLRo9ceITTj2iKi
	aOVvlefu5w6Ns+HhHkz/0sdgKgXdIwAEkI/EvvvaY+dvPKZ0jOr8bfB5y9pSw7/2fT7MeDDyUQySP
	bplcMUGluq8PZXD4RNCMvPIMGpLrovZneeRLNljySNZFjKwZrCwgCzhwYKN3z95VdlN7D/gKqWkd+
	glyqkQIFF3lX4rw0lNyaIUmuqttLs0PMb1GRQLkXO8DN8whqLEeOeRQc8TJR6JlRpgXUz5Lm/8YmS
	wvnv/O4Aw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgBNp-00FWVC-P4; Mon, 10 May 2021 19:16:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNa-00FWSt-Bg
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 19:15:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=JIOAK1+fhZx/IOR2Xynab8YGGzi8P5WzWDZ1PSMW3uI=; b=f0yz82+Lc5ocFSE1tDx4/VhR4F
 y8ujTmczgmpnJiZbomh/MSSFyklnf5UBuncoQtvO0Sz8gMXmo6sJ8vP85Bh+t24A91fVXuzSlVGWO
 uUyu3UtIeyUme6JCahz8Ww+/d3O3wWr/j7tdOlDUUaDGags50GdgW5XFsREMNarzKOGan97h2+APN
 YXax8gwhuXiTdd7eKTsV/95Im28d9mri8mvCfvoU9gpGKuNEu0OxlH6PrFWPDlAcQd+ZeCt5TkfjN
 yCAI7vNQnis3W6c9+JdGrIMFXKVlawefwKqErB6CZoep5nKcz6uFJpBbgYSkHKAg2F+IpROm2sxkZ
 uYvLIr+g==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBNW-0093t0-Uw
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 19:15:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620674143; x=1652210143;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=spKgzMpThNm+7FXnhFIbmYC7b5BPPxJxCFdYMAFbdhE=;
 b=phEmAgcrf4Yzlmi4CLvQH0s/2OCuSLcI4+dBNs/IrcnKKMhULD3yFEaX
 M7uPPQvgZ9hfEeZwBlkyyPUPNE0KGGe8N1Hpe8KR0M7gihM/7Pu4ZzK4F
 a0h1xD6/kTeobd1hNFgFIfsfmx3Hy6H2wXwQNCTK6egU/Ry1RYh+qo1tc
 i1yf3ZTKlGXQ3KaIifrDQwAC75/m6pz6phux6ZZHOdgXywC+tKSE6FGO0
 mxMDJ0c05qRYOJH5rN5ReHc7YijmGFPbuho6PrzT7BzCp0tW7XsP9Yjph
 M6LRYktiGfRfSiHdR/yP8w7qrbVTCQTR9S9U6S+dOHcU94fTf+EoMDwzH g==;
IronPort-SDR: 5tnmAEEH8yRJrl66yJ7G+9+518IloXZyNyyiIrd2tGzKtrXqfKwQada5hk1VG9vXc0Fa+YdytL
 SzrTX9b+KJyzT+0YTslyuBlwwmFMNt2410QVsoXjJfyGlJZV6vUBqO8+dsEt1FNHmZH192a/jE
 0RE6SsA94a6Upqrmh+LZ0tfaqlLcQHQDuD/OBwD/81ZEiCyXLxxL1SeILl2Bew1CEtow7fYdHL
 amVij3v7F8jhWKrX0SRGHCGRVr/BF9QX/bd8c3tmHqMufqcT/Fvh42jUOON0YGw/25xacNW6LR
 38o=
X-IronPort-AV: E=Sophos;i="5.82,288,1613404800"; d="scan'208";a="168207426"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 03:15:42 +0800
IronPort-SDR: bu7csyICeDWQFNxDfemECpbidNJhyHiCDr1pP+uVYOZxIn9HJKsiUCn50v072B5q870Sb4oQdi
 5ljgU/flZrLbPj3roVU84XcmYH2gVxETpXtOHYNTJFhn34srzEMcS3G6HR2E0LSYqzRgk9x5ze
 Ho4FEC2iZnp2MNBP+e7FEbKCLU90X9JLllEF6XXbTwbaPmPcBt5o1m76hGphHkPpmAHwm0nQDZ
 GptglCMOmo+2RHDGBzAHSao78spuLRPFbQE94DZtnUB24UJ4FQmt7QzMKsI/iOYjaIaVFMqx3E
 gYKcHrxJGNsoP3yQI52Uxq1Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 11:55:41 -0700
IronPort-SDR: juojDYhPoK65TqQrA6RSYn4LL+CKsdPjiLNABk4gn+kgz5ea5niix6+ssG64ZskRn4Uf4gN67b
 y6c9M8TYOmiteSlYbM4cUfFP4wSaSRqARgGkSDF2sHN4+fFw6DSy5wkVmSq3m2ljEItwDzWVkX
 CeV/3koRaYSZqUzlxaN5qG70VhA3aIrGhypJSzsoMV8HEU0zKhL7/nHyaZrQtBu4fN3qdOdk26
 2rDYTHCI+e1FFiNFPiWqpxLwauua6tnRuK98LaF9fuCDTTDWBp8mSzFieNhVCElMiQYZ43BixX
 dmM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 May 2021 12:15:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/3] nvmet: demote discovery cmd parse err msg to debug
Date: Mon, 10 May 2021 12:15:36 -0700
Message-Id: <20210510191538.38306-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210510191538.38306-1-chaitanya.kulkarni@wdc.com>
References: <20210510191538.38306-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_121543_926858_65E7BA60 
X-CRM114-Status: GOOD (  13.47  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SG9zdCBjYW4gc2VuZCBpbnZhbGlkIGNvbW1hbmRzIGFuZCBmbG9vZCB0aGUgdGFyZ2V0IHdpdGgg
ZXJyb3IgbWVzc2FnZXMKZm9yIHRoZSBkaXNjb3ZlcnkgY29udHJvbGxlci4gRGVtb3RlIHRoZSBl
cnJvciBtZXNzYWdlIGZyb20gcHJfZXJyKCkgdG8KcHJfZGVidWcoIGluIG52bWV0X3BhcnNlX2Rp
c2NvdmVyeV9jbWQoKS7CoAoKU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFp
dGFueWEua3Vsa2FybmlAd2RjLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L2Rpc2NvdmVy
eS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9kaXNjb3ZlcnkuYyBiL2RyaXZlcnMv
bnZtZS90YXJnZXQvZGlzY292ZXJ5LmMKaW5kZXggNDg0NWQxMmUzNzRhLi5mYzM2NDVmYzJjMjQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvZGlzY292ZXJ5LmMKKysrIGIvZHJpdmVy
cy9udm1lL3RhcmdldC9kaXNjb3ZlcnkuYwpAQCAtMzc5LDcgKzM3OSw3IEBAIHUxNiBudm1ldF9w
YXJzZV9kaXNjb3ZlcnlfY21kKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKIAkJcmVxLT5leGVjdXRl
ID0gbnZtZXRfZXhlY3V0ZV9kaXNjX2lkZW50aWZ5OwogCQlyZXR1cm4gMDsKIAlkZWZhdWx0Ogot
CQlwcl9lcnIoInVuaGFuZGxlZCBjbWQgJWRcbiIsIGNtZC0+Y29tbW9uLm9wY29kZSk7CisJCXBy
X2RlYnVnKCJ1bmhhbmRsZWQgY21kICVkXG4iLCBjbWQtPmNvbW1vbi5vcGNvZGUpOwogCQlyZXEt
PmVycm9yX2xvYyA9IG9mZnNldG9mKHN0cnVjdCBudm1lX2NvbW1vbl9jb21tYW5kLCBvcGNvZGUp
OwogCQlyZXR1cm4gTlZNRV9TQ19JTlZBTElEX09QQ09ERSB8IE5WTUVfU0NfRE5SOwogCX0KLS0g
CjIuMjIuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
