Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E782EC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 01:07:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BC761003
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 01:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BC761003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YyTGs8tG1HavkcT5c5gGjOM/ldm+E47DGodd8Ja1yjE=; b=nANwSg/M7qBkrSCfUFO+YqdJS
	xofNkiVPzj0dCfYhx0v1irdcxrzb8Dd0q0D3x0sUq+CTmSkqCWrg21ejusVkdVCmuQ0x/LFmnJBl0
	DzOEqnh6GUJk3JNLE3KDoq+n+rKTNdykTTZWTv7nNRMXITKOFnrD7HylpDQ3Pj7j2wAf4Ng27S8c+
	9wmIS42dRW8W+9Wk5Fy+aEgUJeHNp63hKSW241dni4kBUSslKXXflJuQWWynAPgMzIgdBjbsZF5j4
	HO/aGicQbKP8g6n1Sg6S4yPsr251ikEvjo9j6fg78fMT7acASCttf8Hw51GTpU8/uD2GsxGamZtT9
	moYePpeGQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcHcu-006rIG-OX; Fri, 30 Apr 2021 01:07:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcHcg-006rGJ-2W
 for linux-nvme@desiato.infradead.org; Fri, 30 Apr 2021 01:07:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=lImVIXAsFnA/fVat1KLrVMXN/hnQSsdjvajbrUXg3L8=; b=B+t+OJAdCOKL/KHnBHpoo5/G1H
 00JvySINr/DF6eVF3Kl7G4k5NxIS+G/y5c/gKmdcVPwkqrC2iEYioLQG0FtRLAypH7xw0PS/mny9e
 JbGivxC3+XeYYy14+pLQghmu30JaOIiYQWTrXzku+0QbDg5Nrhk+y0FABPhjqd8+sTPkX4BnIILf1
 D45M2kJuADoZq6thFq2X8zy57S1Ij6v/P/lYRSPjh+Ue61btz/NrY7i50TTBT+MuQ4MrsAgvhtycl
 ITmihXgPgYaD0h8zfj5gZF7vu38qZOW8Mb5WmkffqiFQJ4KrrjvhelmKA+3m0F/3Md65WyQJ5kzzO
 W4nhtboQ==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcHcd-0013Y4-8n
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 01:07:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619744833; x=1651280833;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6XeqqvuFUVYzNRqxoJP1DPxF3P9ekKpBR86otwd+zFE=;
 b=IbuMBuIK992dK3dWciiMsXdcODe9U7yJopJhqOSNThKgmjg7uFROygeh
 ipOE0QAds9IRhJClEORH0Z4KnMBRmgfMtC2TgKXL6bEpkSftlu4r6TZY5
 HF7qabOACvaFxvAQUnZPu957iLFdt7PSzb+Gvta+j45+45qRij3sFutab
 /jAIDYyMaDhl0/D6jLRYZ3Z8jo/+KvOxboTESxjXZmpXi8b1GvWd3OGsf
 ZEU9dj9mIbyc7rSAc75A2FShKNQEGIBEPC8sBljO5l3pzJBrFGIVSSUsI
 0+46LtvO0HDEoGdvcNktj9d7OAV25P5qAVq4ZL+2n25h6YRO4PZPV6+Z9 A==;
IronPort-SDR: 8ZaHfULXhw41s9lPwKJ+XqB9TCPEqmI8d2DamAs3g1z7hc6kjGuqX1UWTHh9qmvmIbdxikuPhf
 P2g7kuv9RL63MejBV30sMa/zYQa+YLEJIEbdhxV04+nERV+2dxUdWzezCLnvdkPIwc8xaicQMP
 q69fYkWtqUGr4bGU/QQRNXH0vSX1O92w6dOcsWAHhrk37IVJTFRFUL2hCpWTvtSEZhV4UkwIhJ
 xs1iTrd4OH3M4mZ11/cI6OT/F1tQd7ybQW6//X8STVGioPUZ+blKUBsEwqBM3QXLg5q7BCFBe4
 2Mw=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; d="scan'208";a="270663719"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 09:07:10 +0800
IronPort-SDR: 6WooqZhz5Q771Kz2Nov3DDrCgNTTcMhUjtTnpR0wD42CaXYFG5H8lh/FRCjHvdt7pnQ5T7ZzOi
 QfCA85H75yKSqtHf9s1318iZGoe+m5RZq0R50XUGdxKzmUhFCQQLh3CsFs2832nDUmH86tlSQB
 ijMXK2ugkDdytn1jIs3reWPq+lV4SZa3ZQ5/b9lBsb9g21hxAC/X+gC9b/wKTBE3rmqUDuTTrW
 QaBiMCMrMc6vfaVixxmVw2XjpmQUgSOZ3pOB1rvFATJzWGahqV15JZuw4zvFaiRC3DcKqldCZj
 HK2ohrSQCpnPNHjcBqwuftgB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2021 17:47:26 -0700
IronPort-SDR: 5EvD52hngm0gNLsaU6hgsE/3zkejThRQohB+3aGNYySDjHLeD7h4YGFZLpx7VTORmjIbjpYMQZ
 KquqV7IYKu0leghMaRTX5nUOTzUXkG22K7jlyOaag7kIwzOd4nycqpTiwMZeZ4dKXkZbh3qtC2
 LK6rkQE9SQOPWN2g7/lvi10y+jDeu2IakCZhVRQfwNdkCeh4655nBKOa+IOG8uMeUH27prn9YK
 oGPO85FVcJZrHPcPkWAarhr3Ckvq6fapgaI4BIA+7aK9l2c1AaDv06HwTkrrUvKlAqWlbXsVG5
 93k=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2021 18:07:08 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/3] nvmet: demote admin cmd parse err msg to debug
Date: Thu, 29 Apr 2021 18:06:50 -0700
Message-Id: <20210430010651.36736-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
References: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_180711_390087_DFEB4F28 
X-CRM114-Status: GOOD (  12.46  )
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

SG9zdCBjYW4gc2VuZCBpbnZhbGlkIGFkbWluIGNvbW1hbmRzIGFuZCBmbG9vZCB0aGUgdGFyZ2V0
IHdpdGggZXJyb3IKbWVzc2FnZXMuIERlbW90ZSB0aGUgZXJyb3IgbWVzc2FnZSBmcm9tIHByX2Vy
cigpIHRvIHByX2RlYnVnKCkgaW4KbnZtZXRfcGFyc2VfYWRtaW5fY21kKCkgYnkgY2FsbGluZyBu
dm1ldF9yZXBvcnRfaW52bGlkX29wY29kZSgpLsKgCgpUaGlzIGFsc28gcmVtb3ZlcyB0aGUgZHVw
bGljYXRlIGNvZGUuCgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55
YS5rdWxrYXJuaUB3ZGMuY29tPgotLS0KIGRyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMg
fCA3ICsrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYyBiL2RyaXZl
cnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMKaW5kZXggZDJhMjZmZjNmN2IzLi5mOTA3ZWM2YmQx
YWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMKKysrIGIvZHJp
dmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwpAQCAtOTc1LDEwICs5NzUsNyBAQCB1MTYgbnZt
ZXRfcGFyc2VfYWRtaW5fY21kKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKIAljYXNlIG52bWVfYWRt
aW5fa2VlcF9hbGl2ZToKIAkJcmVxLT5leGVjdXRlID0gbnZtZXRfZXhlY3V0ZV9rZWVwX2FsaXZl
OwogCQlyZXR1cm4gMDsKKwlkZWZhdWx0OgorCQlyZXR1cm4gbnZtZXRfcmVwb3J0X2ludmFsaWRf
b3Bjb2RlKHJlcSk7CiAJfQotCi0JcHJfZXJyKCJ1bmhhbmRsZWQgY21kICVkIG9uIHFpZCAlZFxu
IiwgY21kLT5jb21tb24ub3Bjb2RlLAotCSAgICAgICByZXEtPnNxLT5xaWQpOwotCXJlcS0+ZXJy
b3JfbG9jID0gb2Zmc2V0b2Yoc3RydWN0IG52bWVfY29tbW9uX2NvbW1hbmQsIG9wY29kZSk7Ci0J
cmV0dXJuIE5WTUVfU0NfSU5WQUxJRF9PUENPREUgfCBOVk1FX1NDX0ROUjsKIH0KLS0gCjIuMjIu
MQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
