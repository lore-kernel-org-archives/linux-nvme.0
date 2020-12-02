Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E7BC83012
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C980221E9
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C980221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lAVH9pAWQdQ/7u3VsoX0Bn0IUOhZNiFoq5qHC+oVLAA=; b=o+dYeWthNnDksC9aGF6ogaxxO
	yjK7Ur4VqibZbSGIdlu4cY1WUzFxNantfgpoCv39WarbOIOR1GpsLRbvWVGpmD08Tpq8DzmwMvOzV
	QExox/V7P4D+KnZ8QVb235Id4vPacmmKJuT2VcHTUa3Uoibg4jhYsZ9TXRDYdT9MQ53QPlXh9Kxq3
	HTccLHQYLee3oT89375+BOJg5usd2AqwcAR9yWoz7Tk5Mzl65hJBWKb98JoiMk35wvvbCNndhhnKz
	P81EQo+SBcHkZ28wkk8rlqUM+ezzUJ/4ygLI9juYT/SOEG+Ze7RU2cTTeqh/Te5HW8PPYiA3CyPRk
	Q43OFmQ9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkLY1-0005VE-4p; Wed, 02 Dec 2020 06:23:29 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkLXy-0005UX-NT
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 06:23:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606890206; x=1638426206;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hpoI1V55y5gwFhJlJIS3F+nAY0E41Z5thazQ0M5y7lA=;
 b=RiGqz4LVtzfTRROZ4Whk8uuf10P+mh+ykwAX9hnXeEhuwRFVA9fnu4Kx
 Gu/KpQEIWdPrOiNvqakXJ4DxjYI3RLle9dt3V8HRdTMpwqOaT8jyYWJAq
 75UXgMcDoZ4+OMgCE2iySOAsMWFD+5lWYpAUauBCgfjbeSLp3cBm5r0+s
 U2nXoY4QVYeTO0kKUaqlQGQm7uz8Ayfxi+1tJA/5lpANE1UiHFJbyCNwE
 EOkmvVIiLzFk6dMU1Q+uFLaRcaHSCA3Hd8CqvpGbde6lmysvGI7czOtgH
 b4SNz4hoKQ+kvP8vBhvePuieH6K6GmHzZu/56zNRN1zfiVc/jIincVI+f Q==;
IronPort-SDR: SzWN27XKGf0cWcmg58bQXfuh7tg4y4ZBwg4WDXJVaFW2Et3hZICNmbgm1/fQ5p8kkLDbiYqZXb
 6MJBfD2CEMNofGMm8BN2qyKnpl+d8TCO8fpQkWuDuULNZBb1f6D2O7XOxNVI77L/woBxeXyBN6
 00/UVCEWHF+uKqxTUZDmMFY5/GFRmYjoxNZkzWlA3Ip0iYw40xHs3wcd60Bpa0phei4Ds1AfOm
 32GSWCPX1P1ZQvhiha18rrShb7nZXVKn65Qxn+jqnEJH1OqX6T1PaY0TsJ7EPXOsyGpDddFOZd
 J4k=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="158458573"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:23:25 +0800
IronPort-SDR: kuqdramd4uDp5NJOjGkTpI8njmPHJp6KFfvq/MlQUnIh+7ZgkuqpFitaFOUhT+1dQEwWxmhpF7
 RLYTnwDUt0ZtL/j9NydggTCBa0Ks22a4U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2020 22:09:00 -0800
IronPort-SDR: hBYFBf+pPzvg+2AAdZ7UtHZh9yFsJPwZOETn77uGbTPq2L7oVh4ulBd2/rSv9txkxiTWLPLEJc
 HKdbicUob75w==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:25 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V4 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Date: Tue,  1 Dec 2020 22:22:22 -0800
Message-Id: <20201202062227.9826-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_012326_919130_AFC6984E 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: johannes.thumshirn@wdc.com, damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
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
