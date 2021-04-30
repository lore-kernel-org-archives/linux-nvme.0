Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1D6C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 01:07:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B1E61433
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 01:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B1E61433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EflC9nRwt/iT3yuBAa/UpPWywxPcmsvTXiATIfkvtL4=; b=bHEdddMVvRa0YUYtKazaLsF0s
	cIZHBczXASeRQ6w7XAWKYQbNYEtOTXhbiSsKDBdUMCgOoya/R6CQ3WyzE0bEz7Juw73JIHDO0BaUB
	WpaBwomw0VnIFYMRYBKO/60jMjDh95hB4+Ff2sBEq4ZC76PLYUTFcrUkwDMwb3Uq+5TU7sOqfxxcn
	nFy4PMrMwVUXXL01GfK4B8HPAGq5d0zg1yghVpte+bAum+Vv6MkPAj8CE0nQ0XA5WKuR4HNTSx2I6
	k2I2gY5QIZ8XKV2qijc2mLETtxQ6p6ZAWDAIhvlhBfpMrypbOQTtjOIbhDSoDtz9bMrLhD+caEkF6
	/XtCIJdcA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcHch-006rGS-QV; Fri, 30 Apr 2021 01:07:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcHcY-006rFY-6r
 for linux-nvme@desiato.infradead.org; Fri, 30 Apr 2021 01:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=JIOAK1+fhZx/IOR2Xynab8YGGzi8P5WzWDZ1PSMW3uI=; b=bOmdGgz3w36PU+Xi+vALlDhWCn
 a3xb8/S6+YTi7uXdcuYvZKMS/a9O+RaSBYr7QS2TQNys32KFDMYubtX9MV9xX77ro+acKx+V95XWH
 bQlNxR+bu9WpXyeHrWz82B6G9/wqgyjIrL224v+0d1JZLwe7Z4ckJjy15yB6QTOF99ngKHzYtxGPg
 JIVknF1K07bJuCrllASwzp+czgQf2Zm+mAsyIdSXTzxoqJ9WaU0U7vwuu74OhqFt10+6mY435C1/l
 tufsWf/ABcRstukJcdpNQW5ERRnRMnKOC0FSPtlT+43jovhxzFekiKZIZQwmKemA58L2OtJX4LHb+
 IEQoYg/g==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcHcV-0013Xl-LW
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 01:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619744823; x=1651280823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=spKgzMpThNm+7FXnhFIbmYC7b5BPPxJxCFdYMAFbdhE=;
 b=Gi+dt9rNn33avvkLtvbL3wm6rOHB8bZxwmop1WuTTqc6ggfMdipkszRj
 VqSNIchCxiNs8eJB6HYQKuFO3DLO3UXpJb3ZUr8zvgIlHUHX7R/lIAJaI
 UwB/iqATs41RcejWaG4nGX3vZdxfSnDdAmcbMGhhwLRNl3b47/ySKX9jj
 ryRtFA03MFrI3Y9bBmdY8+higBCkYU+hfTPVUvXCT/qYKJhg86o8UoqFk
 tBReXeo8DR3jiE9QDrldGooZowqUMka6SW0z8rMRm72na0nLQ2kf0j+qY
 wxk8UpNfEB9yrJITsamXzLSaB8DU7q6K3dWAJUK94q06iIi86FsuEhCXg w==;
IronPort-SDR: SKPCS9YSuuYeuBrcIe9VEeYbsop3Qp6IyCN6OiyMQ/iqLGwHV3Sf/lPqEz+njlKUA/BEYuBB0C
 Tzyedz4hRT8Nk/6PVc1iSTmhz1EAndL8u0k/SlfFx+D5DRhZwKGakiLObLNbyuOn79ezzgHbTt
 s8he0oJMhBzFOqi37lGLoMEih3j6sKCUPiRikZBeT1YZJattJJT4HY+24PgZfbfol1NuMyxyAb
 38gfYIATYSPyhgJgjZ9zcoZWAUUKqDnzF9NKVHAECu5CrhkZK63Q0cUHPEGdyHXEg7XjjIDk6D
 h9g=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; d="scan'208";a="167272008"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 09:07:01 +0800
IronPort-SDR: 9nOduCRhlAvTSSd2dGl2IzwfNU8SPv9f9pzS5CLMq7v/pPxKLWzlMLBcJiJBFRCPFE10X/7HfV
 bpvRtxOaZwyD0E7N5sY+sHiYuz5o8ynHTeSKX4PXO7cz/YgY6bioikwPVEgdO8W721wzHU/vLJ
 KKPo7cCOqbKgBVf1sYNvfHnRhLL7tR/HAmSyCGkYC1DuqX6SAxq6r8F81dytNLxJQ0xlPoQssM
 Ic9EEATDbDwget7fMFudICRB5ywllLdM9OVV0XCHA4G1JNgq4wJndMKqA+57VyleJ6XDBtipCs
 7OAiWAPF2i1gH4iJny/XL2lR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2021 17:45:49 -0700
IronPort-SDR: vIKj4izWXlUpf5mmQjbRbaV7W8Yt5cDUqJdKzGSczKL0BF+whm8T3WV5wh0UFlI1Vd4qJae8D+
 sWLl5Rd3t9WCbJ7MHQ71iRD+owfCxzqg/iS5LR9Jndf+ad8gitFt0/IMLwZJqWfYpZV/R1tg/a
 SewOfohHCAOUpJewvVqoxy+Q8/gmGMptrVRuuochPCYoaw2zWfUPTxrjiOcbxbf1wN1fcFHU3g
 7xYTxVP/db5D6grZL1NbGa717k++uuccH7ODNgONlcVAFQhLjFF0GAmoFqUitwlftlloOSmW/G
 FF0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2021 18:07:01 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/3] nvmet: demote discovery cmd parse err msg to debug
Date: Thu, 29 Apr 2021 18:06:49 -0700
Message-Id: <20210430010651.36736-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
References: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210429_180703_783587_3B448C09 
X-CRM114-Status: GOOD (  13.79  )
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
