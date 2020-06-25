Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08044C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CFE206EB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wmE5sUW9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="pKwqM6/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CFE206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=diBPdas3v0H8lO8M/crrunGVVumKHiPL4EHF97yjou4=; b=wmE5sUW9hF+gAVPPHItAuM0eJ
	d/HQT8g7Sxiyv8YQ11YAspWnJtIKsds5ZpTuQJzNyWK2+zLMumMfFrwxvOC86k+bFALdtZkNvjnlF
	NwU26Hj1Na3wQ7fNv0Xs1Jx8EBOnu1YF0xikLXnTmkb1DJ5k+feqmq1aj3EoKb24hcYgojZ5VADlw
	a+A9l2wnmqReIb0y8pS2gv3Tk4BUBZR6xUz7gU8WZ9wpuM9lwbFKsCh3DpU2orYwY5dB5xV5CD74R
	8Ll1g6U6wHHzcM7Q5OR1tlJVfhxOA/Ajk2mWJvDxUE3r8I2oi2Lpd4WIO52x8oVP1YRnY2bIRmcCb
	QN2nOAfXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joQtj-0001jP-TV; Thu, 25 Jun 2020 12:22:31 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joQtb-0001g5-3d
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 12:22:26 +0000
Received: by mail-wr1-x444.google.com with SMTP id j4so3154433wrp.10
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uplg47+RomE9YaWxZaB8jq75+RVgxneSzcAc8bd9ca0=;
 b=pKwqM6/BNNtcXKCnqMZeye8/adtX0X/kD2BvhvoojAvfru7Z8ZK4mKkjbZbxp9tbWo
 HxBdLz44Pni9xhrCCnd1oFt9oJPzvizNfc78+H5GGICH+/lGRMs85hCDdmPwoXSmoJWx
 at8xpmekaKwqpaNJaMuZRrmjniqcFCJNPPnTVEvl27FQZXMuXayOxT9X+zBX7oK23xsX
 nUD9rOQ52tE5Yn9OZHGOBlXhWWJjJVl6dziT27/AxnVGLJLunr3bGLnHw451QsydaDDc
 hlc4yoAUoY6iy/JrUOGAxRvOTpwG9/fEakD1h5bJK/4gahehBNDeLxdoJ0JOWImgk3r1
 SULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uplg47+RomE9YaWxZaB8jq75+RVgxneSzcAc8bd9ca0=;
 b=tQ1a8vpn9S0D0dOV30KdFsr9giEpehrkVbKwekRZjW4gvCK/6L0Akupr+Nza4JGYaB
 eRBVCxtFFcz4LQdof6y2YtBf5jC6MTeTd+wRjjlSHhJ5GTMdbZAEqG20Y5xQDq1N3w5L
 RdxYLaf3RPK0bhIIy3e8LX/Lx34WZJgGA3fzKdtb1GaptMI75abhZrDvWx28A4NwzXkZ
 KPWsIBGmY4x7IxmTX3r+vjZE3V3+qdtKK+i/O3N87VEGmyqSD1dU9LEDUKmLGVvtiATw
 R8lIJmgnooyC7BXKyyLORJ0GlO640r9ypizR/RlMUN1uajwHoALFZOON2EHGb15QynRV
 eNHQ==
X-Gm-Message-State: AOAM532Wg9n75QJzyyI3V1Jictf0tH8kAJfPzS3LOOK7FruDsrIAzcab
 8f9tPvlrLzVJjYk7Lu+bejeX4A0V0RXN4Q==
X-Google-Smtp-Source: ABdhPJzl2u7SbnklyFfMa/Qyq7hFxasyRw6r1/oAry3ecNHjaxknZiMpQeqk9tjHTb1+Tl39UBn2Qg==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr2763592wrw.111.1593087741592; 
 Thu, 25 Jun 2020 05:22:21 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 05:22:20 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Date: Thu, 25 Jun 2020 14:21:51 +0200
Message-Id: <20200625122152.17359-6-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625122152.17359-1-javier@javigon.com>
References: <20200625122152.17359-1-javier@javigon.com>
MIME-Version: 1.0
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpBZGQgem9u
ZSBhdHRyaWJ1dGVzIGZpZWxkIHRvIHRoZSBibGtfem9uZSBzdHJ1Y3R1cmUuIFVzZSBaTlMgYXR0
cmlidXRlcwphcyBiYXNlIGZvciB6b25lZCBibG9jayBkZXZpY2VzIGluIGdlbmVyYWwuCgpTaWdu
ZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KU2ln
bmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxzZWx2YWt1bWEuczFAc2Ftc3VuZy5jb20+ClNpZ25l
ZC1vZmYtYnk6IEthbmNoYW4gSm9zaGkgPGpvc2hpLmtAc2Ftc3VuZy5jb20+ClNpZ25lZC1vZmYt
Ynk6IE5pdGVzaCBTaGV0dHkgPG5qLnNoZXR0eUBzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL252
bWUvaG9zdC96bnMuYyAgICAgICB8ICAxICsKIGluY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5o
IHwgMTMgKysrKysrKysrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMgYi9kcml2
ZXJzL252bWUvaG9zdC96bnMuYwppbmRleCAyNThkMDM2MTBjYzAuLjdkODM4MWZlNzY2NSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3Qv
em5zLmMKQEAgLTE5NSw2ICsxOTUsNyBAQCBzdGF0aWMgaW50IG52bWVfem9uZV9wYXJzZV9lbnRy
eShzdHJ1Y3QgbnZtZV9ucyAqbnMsCiAJem9uZS5jYXBhY2l0eSA9IG52bWVfbGJhX3RvX3NlY3Qo
bnMsIGxlNjRfdG9fY3B1KGVudHJ5LT56Y2FwKSk7CiAJem9uZS5zdGFydCA9IG52bWVfbGJhX3Rv
X3NlY3QobnMsIGxlNjRfdG9fY3B1KGVudHJ5LT56c2xiYSkpOwogCXpvbmUud3AgPSBudm1lX2xi
YV90b19zZWN0KG5zLCBsZTY0X3RvX2NwdShlbnRyeS0+d3ApKTsKKwl6b25lLmF0dHIgPSBlbnRy
eS0+emE7CiAKIAlyZXR1cm4gY2IoJnpvbmUsIGlkeCwgZGF0YSk7CiB9CmRpZmYgLS1naXQgYS9p
bmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25l
ZC5oCmluZGV4IDBjNDlhNGIyY2U1ZC4uMmU0M2EwMGUzNDI1IDEwMDY0NAotLS0gYS9pbmNsdWRl
L3VhcGkvbGludXgvYmxrem9uZWQuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQu
aApAQCAtODIsNiArODIsMTYgQEAgZW51bSBibGtfem9uZV9yZXBvcnRfZmxhZ3MgewogCUJMS19a
T05FX1JFUF9DQVBBQ0lUWQk9ICgxIDw8IDApLAogfTsKIAorLyoqCisgKiBab25lIEF0dHJpYnV0
ZXMKKyAqLworZW51bSBibGtfem9uZV9hdHRyIHsKKwlCTEtfWk9ORV9BVFRSX1pGQwk9IDEgPDwg
MCwKKwlCTEtfWk9ORV9BVFRSX0ZaUgk9IDEgPDwgMSwKKwlCTEtfWk9ORV9BVFRSX1JaUgk9IDEg
PDwgMiwKKwlCTEtfWk9ORV9BVFRSX1pERVYJPSAxIDw8IDcsCit9OworCiAvKioKICAqIHN0cnVj
dCBibGtfem9uZSAtIFpvbmUgZGVzY3JpcHRvciBmb3IgQkxLUkVQT1JUWk9ORSBpb2N0bC4KICAq
CkBAIC0xMDgsNyArMTE4LDggQEAgc3RydWN0IGJsa196b25lIHsKIAlfX3U4CWNvbmQ7CQkvKiBa
b25lIGNvbmRpdGlvbiAqLwogCV9fdTgJbm9uX3NlcTsJLyogTm9uLXNlcXVlbnRpYWwgd3JpdGUg
cmVzb3VyY2VzIGFjdGl2ZSAqLwogCV9fdTgJcmVzZXQ7CQkvKiBSZXNldCB3cml0ZSBwb2ludGVy
IHJlY29tbWVuZGVkICovCi0JX191OAlyZXN2WzRdOworCV9fdTgJYXR0cjsJCS8qIFpvbmUgYXR0
cmlidXRlcyAqLworCV9fdTgJcmVzdlszXTsKIAlfX3U2NAljYXBhY2l0eTsJLyogWm9uZSBjYXBh
Y2l0eSBpbiBudW1iZXIgb2Ygc2VjdG9ycyAqLwogCV9fdTgJcmVzZXJ2ZWRbMjRdOwogfTsKLS0g
CjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
