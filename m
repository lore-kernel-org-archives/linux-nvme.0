Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83C7C63777
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4385820663
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lzAZVJ8k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WDXBXnwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4385820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lAVH9pAWQdQ/7u3VsoX0Bn0IUOhZNiFoq5qHC+oVLAA=; b=lzAZVJ8keDDLLiEDFX62huXqF
	pb7suJP9iKrf6EwhbEdeKjDWO/ZEJmmcDC0P+TXiCFyJkU22f7K+V9252y6qKyjzRY/P28i0mzi1d
	f8lJEoMdKIef66Ec7mtRAO3sl9PFtXg9nMpZRsNd6PlNBJI2g3ojDHUA+TI5Lf6T+BcRM2i91h/Cm
	GZY2BvDfs8Od7wwuH5dE4txltwoFg6aK9lqz5JYUG4hEVVjYuxfFoIksFOzTdzQQwrIBfuF5PlKfC
	WJZQ72+pdUPvG5RBM9av4pQ80es0N/UO1z/GmJdzEOhbs4DPgeQBIxEvs/MmLWoTkmhhZMUdnUtJT
	4RsS54nZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZss-0000g7-FD; Mon, 30 Nov 2020 03:29:50 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZso-0000d5-7v
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 03:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606706985; x=1638242985;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hpoI1V55y5gwFhJlJIS3F+nAY0E41Z5thazQ0M5y7lA=;
 b=WDXBXnwJUWkmo929LSWMNsBud6HJjYvK/ec0HzDJZ85hXVqxx05Y/EJS
 zZzGv8KBEFsvkewIR/qMmTB736V5/ZaWoObHTyz7fnsn+6rB556wXixRM
 WfFR+VWpAxS6wSy7Ykl0xdpJzx7tVWmfl/OHhNBbZ2OfxGMpiWBuOT6m6
 uKGyQXyGuuxoRyKduJ+rQg4p81reYsuqDZQMiuYh5YHoO/1GvrbojN7na
 QKWYZmCB1uN/Z1x+Aqjw0FRqZ1FRcvdP55QZ7kmSaxBtTJ+ldgbkqEK9J
 MEv+VuGB7Pi8Oe7RQMv14SHWfKoqBqv8MczxGH1s+/DZ/9NBJf2YrJxMh Q==;
IronPort-SDR: HcP7KlYrpoTfF0zbqDxJV+0ZgSYljjSFY5GESYP17ywDSQ6YSQnGPIXY9mOMeAuqNdKR5imOnX
 4ZcuJOR6285qAlp9i7gnlJTPzYP8y9ZZCAqfi0jWfEFPZtV83XowlVGtSvq2+BNFhrXmg9dyLY
 PYVQKhavNeXB37NgYB5pWYZr8myIMuxWy2vB+fFeZDM2MAcLi5ZLFayV1pMzbNlHqGKRnV2Dog
 ejZJxoEUEv9fbD9MF37MEfS4SqapKn8pv4JKhxzAlfYJF2uB6ascLBYLWzsrDxgZx11dwnw+zo
 Ygg=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="153710349"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:45 +0800
IronPort-SDR: f03l4zxYmSrc/l1srLNsRdW/fikurBo1hn5J4FbA28xuawxTB9ng33t9iqkfrtMPCIBkRxWKT0
 X83L+WynPYEK6PNU6KMqY59zZdAYuSJnw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 19:15:23 -0800
IronPort-SDR: 6xWCH0RaF8WNbAwW/PPWh9osExPyzV/1nidU+0Z3OEJdmdikHsqbn/84veuNpiweFXykiE+nKv
 w97dQe4exBQg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:46 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Date: Sun, 29 Nov 2020 19:29:04 -0800
Message-Id: <20201130032909.40638-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_222946_424270_61F461C1 
X-CRM114-Status: GOOD (  13.74  )
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
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V2hlbiBkaXNjb3ZlcmluZyB0aGUgWk5TLCB0aGUgaG9zdC1zaWRlwqBsb29rcyBmb3IgdGhlIE5W
TUVfQ1NJX1pOUwp2YWx1ZSBpbiB0aGUgbnMtZGVzYy4gVXBkYXRlIHRoZSBudm1ldF9leGVjdXRl
X2lkZW50aWZ5X2Rlc2NsaXN0KCkKc3VjaCB0aGF0IGl0IGNhbiBub3cgdXBkYXRlIHRoZSBucy1k
ZXNjIHdpdGggTlZNRV9DU0lfWk5TIGlmIGJkZXYgaXMKem9uZWQuCgpTaWduZWQtb2ZmLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPgotLS0KIGRyaXZl
cnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5j
IGIvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwppbmRleCBjNjRiNDBjNjMxZTAuLmQ0
ZmMxYmIxYTMxOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwor
KysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCkBAIC02MjgsNiArNjI4LDEwIEBA
IHN0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfZGVzY2xpc3Qoc3RydWN0IG52bWV0
X3JlcSAqcmVxKQogCQkJZ290byBvdXQ7CiAJfQogCisJc3RhdHVzID0gbnZtZXRfcHJvY2Vzc196
bnNfY2lzKHJlcSwgJm9mZik7CisJaWYgKHN0YXR1cykKKwkJZ290byBvdXQ7CisKIAlpZiAoc2df
emVyb19idWZmZXIocmVxLT5zZywgcmVxLT5zZ19jbnQsIE5WTUVfSURFTlRJRllfREFUQV9TSVpF
IC0gb2ZmLAogCQkJb2ZmKSAhPSBOVk1FX0lERU5USUZZX0RBVEFfU0laRSAtIG9mZikKIAkJc3Rh
dHVzID0gTlZNRV9TQ19JTlRFUk5BTCB8IE5WTUVfU0NfRE5SOwotLSAKMi4yMi4xCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
