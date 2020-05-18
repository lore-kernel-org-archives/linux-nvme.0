Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACBDC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 04:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FDC20787
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 04:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nWX/PJQS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ViEkSX7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FDC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=culws760nl7UIy9pM8vJXgtldWcCez6EJ4H4ScXMjcw=; b=nWX/PJQSi0aa5M
	ZrFpU2zLhvkekzYNPSn4CEKCCKXGtDaQoi+vuaVKCxmZA72irEdnQOZiAp8H+miiC3DmQP1wKvN2o
	AqFhevc2/FeTpUxXeMO1JKQtoMbuA/TVsdpDz19+pzjnPo9LxDp+wvXv6rGvs8PTXof0J4S3Hz6j0
	5+m65qqcVi64oTgWvApLR2c+xdlswn6+kj9NX+jA4VLLK7Ipn3jFZ3xuMB1lm6JpTWkMbVcXk/eD3
	eXWP5hOUh0Xd8gEbsn6CcDmtXBhq+e9ockbNmOp2yR5JI1ss1sEsB3TgUpSceHTTcxL8x1YyijGLf
	9YxkGjul4GI+0DbvUbKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaXQT-0001Ye-Gz; Mon, 18 May 2020 04:30:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaXQQ-0001Xq-UV
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 04:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589776250; x=1621312250;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lnxcCb2rDCzA2bTg+bPaCrZSiRoLtHRwGp6zgGSSsiA=;
 b=ViEkSX7fSFc8JHHanXrPNR/l+Akp3EkM/rkqvU+OqaemAJDVhsRza/4I
 6OUrNz5pS+7fwr+ojJHOkto85lVci6FR3dB0xfh0vJqMXrCgigcP57H4B
 HfCxAMBNQrhsQy1tqk4idjhnwam5brK+OAHLF9HmJ2bEphQhnFIqLbCh+
 m/7qU6T+q6MAQoT4+veL7u1+GiNSuV4E5zIv2UAvUKMWaYVW44q4JT77h
 cXFIMRSST54kQPwH8VOnrfZ1ac/vdfI3C6sPqwj7IeMXeZzc+2OuOJdkn
 KokfYQ3mkt3zug61rrBAKcTDLQsTaInm8AQS7FMB7AsOooNJY19BKuOp1 w==;
IronPort-SDR: T2YYies+DEet25mkBN7fIKjDPhiuUKU4Q8ysqsDOQR2QhzXmtoj5lmdz8LQ0MpyRfdPSec59n8
 i+fGkjvIqQHsa+sfFubbkSt8K8AS1ueqS4vePdtBF/dJBSjGw2wZ13YZHZYu1LjPmOlQ50yFfC
 JK+50i8g3DVNigqUVwszU2/HRwwtpJhkZ92djB2OeM+SNiFuL7QEQy+kq8SJAX9eU0aA4ooH7u
 BMQJoSPDc8ymdMSpwmgmmcPcAJOPkJi0fNzkyvdo0kb9/X8m3ZpUYEWzuSz0MCBKKob7RYrFQt
 b1A=
X-IronPort-AV: E=Sophos;i="5.73,406,1583164800"; d="scan'208";a="246898178"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 May 2020 12:30:50 +0800
IronPort-SDR: uplc+Kuzdhk0OU//jm1gS7oNPaxe2bgKk0KyAqXJN6JMBnTXt/qDBe5QJ5b+4iQ5k4A7hW+mW0
 C7EnFmiEd7JcgVdpKoLE9/TOkhQbeBqxc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2020 21:20:24 -0700
IronPort-SDR: xOU+1UN7BjQjkGcW7y24MAYusR6jf9gD/1r1GWq9osfX8wJo++UlY3LUhdiSxsU38zUc+c26WC
 InYC+LGmYRKA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 May 2020 21:30:50 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V3 1/3] nvmet: add helper to revalidate bdev and file ns
Date: Sun, 17 May 2020 21:30:32 -0700
Message-Id: <20200518043034.48277-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200518043034.48277-1-chaitanya.kulkarni@wdc.com>
References: <20200518043034.48277-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200517_213050_986745_A39BCF7E 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaCBhZGRzIGEgd3JhcHBlciBoZWxwZXIgdG8gaW5kaWNhdGUgc2l6ZSBjaGFuZ2Ug
aW4gdGhlIGJkZXYgJgpmaWxlLWJhY2tlZCBuYW1lc3BhY2Ugd2hlbiByZXZhbGlkYXRpbmcgbnMu
IFRoZSBuZXcgaGVscGVyCm52bWV0X25zX3JldmFsaWF0ZSgpIGNoZWNrcyB0aGUgc2l6ZSBjaGFu
Z2QgYW5kIGdlbmVyYXRlcyBBRU4gaWYgc2l6ZQpjaGFuZ2UgaXMgZGV0ZWN0ZWQuIFRoaXMgaGVs
cGVyIGlzIG5lZWRlZCBpbiBvcmRlciB0byBtaW5pbWl6ZSBjb2RlCnJlcGV0aXRpb24gaW4gdGhl
IG5leHQgcGF0Y2ggZm9yIGNvbmZpZ2ZzLmMgYW5kIGV4aXN0aW5nIGFkbWluLWNtZC5jLiDCoAoK
U2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2Rj
LmNvbT4KLS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jIHwgIDUgKy0tLS0KIGRy
aXZlcnMvbnZtZS90YXJnZXQvY29yZS5jICAgICAgfCAxMCArKysrKysrKysrCiBkcml2ZXJzL252
bWUvdGFyZ2V0L252bWV0LmggICAgIHwgIDEgKwogMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
YWRtaW4tY21kLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCmluZGV4IDRjNzlh
YTgwNDg4Ny4uZjU0NGExNGU4YjVjIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2Fk
bWluLWNtZC5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMKQEAgLTQ4Niwx
MCArNDg2LDcgQEAgc3RhdGljIHZvaWQgbnZtZXRfZXhlY3V0ZV9pZGVudGlmeV9ucyhzdHJ1Y3Qg
bnZtZXRfcmVxICpyZXEpCiAJaWYgKCFucykKIAkJZ290byBkb25lOwogCi0JaWYgKG5zLT5iZGV2
KQotCQludm1ldF9iZGV2X25zX3JldmFsaWRhdGUobnMpOwotCWVsc2UKLQkJbnZtZXRfZmlsZV9u
c19yZXZhbGlkYXRlKG5zKTsKKwludm1ldF9uc19yZXZhbGlkYXRlKG5zKTsKIAogCS8qCiAJICog
bnVzZSA9IG5jYXAgPSBuc3plIGlzbid0IGFsd2F5cyB0cnVlLCBidXQgd2UgaGF2ZSBubyB3YXkg
dG8gZmluZApkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgYi9kcml2ZXJz
L252bWUvdGFyZ2V0L2NvcmUuYwppbmRleCBiNjg1Zjk5ZDU2YTEuLjliN2NiNjE0N2NhOCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1lL3Rh
cmdldC9jb3JlLmMKQEAgLTUxNCw2ICs1MTQsMTYgQEAgc3RhdGljIHZvaWQgbnZtZXRfcDJwbWVt
X25zX2FkZF9wMnAoc3RydWN0IG52bWV0X2N0cmwgKmN0cmwsCiAJCW5zLT5uc2lkKTsKIH0KIAor
dm9pZCBudm1ldF9uc19yZXZhbGlkYXRlKHN0cnVjdCBudm1ldF9ucyAqbnMpCit7CisJbG9mZl90
IG9sZF9zaXplID0gbnMtPnNpemU7CisKKwlucy0+YmRldiA/IG52bWV0X2JkZXZfbnNfcmV2YWxp
ZGF0ZShucykgOiBudm1ldF9maWxlX25zX3JldmFsaWRhdGUobnMpOworCisJaWYgKG9sZF9zaXpl
ICE9IG5zLT5zaXplKQorCQludm1ldF9uc19jaGFuZ2VkKG5zLT5zdWJzeXMsIG5zLT5uc2lkKTsK
K30KKwogaW50IG52bWV0X25zX2VuYWJsZShzdHJ1Y3QgbnZtZXRfbnMgKm5zKQogewogCXN0cnVj
dCBudm1ldF9zdWJzeXMgKnN1YnN5cyA9IG5zLT5zdWJzeXM7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvdGFyZ2V0L252bWV0LmggYi9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgKaW5kZXgg
M2Q5ODFlYjZlMTAwLi45M2UwYzJhYTNlNzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvbnZtZXQuaAorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgKQEAgLTUwMCw2ICs1
MDAsNyBAQCB1MTYgbnZtZXRfZmlsZV9mbHVzaChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpOwogdm9p
ZCBudm1ldF9uc19jaGFuZ2VkKHN0cnVjdCBudm1ldF9zdWJzeXMgKnN1YnN5cywgdTMyIG5zaWQp
Owogdm9pZCBudm1ldF9iZGV2X25zX3JldmFsaWRhdGUoc3RydWN0IG52bWV0X25zICpucyk7CiBp
bnQgbnZtZXRfZmlsZV9uc19yZXZhbGlkYXRlKHN0cnVjdCBudm1ldF9ucyAqbnMpOwordm9pZCBu
dm1ldF9uc19yZXZhbGlkYXRlKHN0cnVjdCBudm1ldF9ucyAqbnMpOwogCiBzdGF0aWMgaW5saW5l
IHUzMiBudm1ldF9yd19sZW4oc3RydWN0IG52bWV0X3JlcSAqcmVxKQogewotLSAKMi4yMi4xCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
