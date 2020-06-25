Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F124620709
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YgSrMQpS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="a4kPMuPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F124620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9JbzdCD8W7hc2aCQGYJPtwDNpv3+B9eyIXZXMmEo+gU=; b=YgSrMQpSd/42d3O+fYKl4jLqB
	ogfClYH03byaQgxyHMsTpluBQKkbZsAgDqUiCToVmGCIBbktbwIP+5UjCixaKeI+pRMXq4r+za+rE
	9j7UWteZ9xXzP00iJ++A8wfwrfeDbPMv5h1KlYXrccesUDF5sjFVF2DasT1k5i+z3vu/v7uA1LOa8
	efMovvFwWB1UPcuxC8XTqCYnWZnzzRproOVUDLGe88LYBZUxu8FZK3CkjyhATKFJ/e470//UV7HOo
	UG64qxgIg9cfPUHf38wzXAzu1tq7hmZCj7zgi5xL+wICfduKJJoW14aoDrUDMNtLsIsg+4RKbX95q
	eNTJzlmJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joQtn-0001kw-IX; Thu, 25 Jun 2020 12:22:35 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joQtc-0001gh-Tm
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 12:22:26 +0000
Received: by mail-wr1-x443.google.com with SMTP id k6so5638600wrn.3
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Ju3UDNPPwBAk1TA1zeQdRuOHY5B22Z1S54Q7dxG7ro=;
 b=a4kPMuPRI94jYMbUyDiniUkJA4zHEgowzmPRA9qYcmXUwmmW3U2rYITJC0+M3sTR78
 KVXqrURRTM+O4yO3SgN2zJ86WC0cyeLX4d6ryi0wJ4Nebi7WZSqa6HHD+ZxZvrewq2P1
 OX/BOsVovRoiGC4xBatKL4iWx1NRQVYBtAw4yOxNz/O3PjT9uXFP4y4Nj8oL38r/lITX
 kAbq+bt36sje5oCKcgh4VWXRlBXjvDHYB7DPPqkFBXZ5RjqJzA2sYDnBwcoQeylDqJar
 Y8bM/RXncZrCOKNrv/To5XmqAVNpHfZwuL7rHFdVrXynZOqA5NRy1K7PRNn08PiUkKLB
 pxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Ju3UDNPPwBAk1TA1zeQdRuOHY5B22Z1S54Q7dxG7ro=;
 b=jXFhi1e8sEEI47VeHipwwJCtfH0okgV7Q7Mqj+baWaCuuRU7rHguNChMfQYKqmF4bx
 EkNZ6fHHAqGccY38TbEBfy3bLr/Guv4XY9ssN4bhE29TpKzSQEhLGcuucLKeWvpy/7vR
 bLglPy5P5gsFpq1XpkSx4H/3jXSI6T/zfoaxeTOFtMMiwFblEs87HefsDuKk8sR7txgb
 zLRtzjWfcQbWIrBOTe3dSKD/snca8E0Ukkef32ZJM58xmpzrYDtGytewyD5Sv9sLkRB1
 UhsThzPZW7jKIshu/TltCmINsAzeKiXHiytSUEiHIx9MUgCB7ESiy8ITn84JBfLclorO
 tXpw==
X-Gm-Message-State: AOAM530WPzIcjotQHYnF9YUiLGv3oshtQiU4NIlTuRazz8bebeYKfVO6
 31wMpThMZm3go7XQgfwaZKtbER1FKcvkSA==
X-Google-Smtp-Source: ABdhPJxWQm3VN+zqrMTnb8iXcKCR7M7Ez3ONvMlEt8CNYRRoA4A76A69bhclHB00O5N4pgSPkhGdNg==
X-Received: by 2002:a05:6000:128e:: with SMTP id
 f14mr39466905wrx.276.1593087743370; 
 Thu, 25 Jun 2020 05:22:23 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 05:22:22 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 6/6] nvme: Add consistency check for zone count
Date: Thu, 25 Jun 2020 14:21:52 +0200
Message-Id: <20200625122152.17359-7-javier@javigon.com>
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

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpTaW5jZSB0
aGUgbnVtYmVyIG9mIHpvbmVzIGlzIGNhbGN1bGF0ZWQgdGhyb3VnaCB0aGUgcmVwb3J0ZWQgZGV2
aWNlCmNhcGFjaXR5IGFuZCB0aGUgWk5TIHNwZWNpZmljYXRpb24gYWxsb3dzIHRvIHJlcG9ydCB0
aGUgdG90YWwgbnVtYmVyIG9mCnpvbmVzIGluIHRoZSBkZXZpY2UsIGFkZCBhbiBleHRyYSBjaGVj
ayB0byBndWFyYW50ZWUgY29uc2lzdGVuY3kgYmV0d2Vlbgp0aGUgZGV2aWNlIGFuZCB0aGUga2Vy
bmVsLgoKU2lnbmVkLW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3Vu
Zy5jb20+ClNpZ25lZC1vZmYtYnk6IFNlbHZhS3VtYXIgUyA8c2VsdmFrdW1hLnMxQHNhbXN1bmcu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuIEpvc2hpIDxqb3NoaS5rQHNhbXN1bmcuY29tPgpT
aWduZWQtb2ZmLWJ5OiBOaXRlc2ggU2hldHR5IDxuai5zaGV0dHlAc2Ftc3VuZy5jb20+Ci0tLQog
ZHJpdmVycy9udm1lL2hvc3Qvem5zLmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L3pucy5jCmluZGV4IDdkODM4MWZlNzY2NS4uZGU4MDY3ODhhMTg0IDEwMDY0
NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC96
bnMuYwpAQCAtMjM0LDYgKzIzNCwxMyBAQCBzdGF0aWMgaW50IG52bWVfbnNfcmVwb3J0X3pvbmVz
KHN0cnVjdCBudm1lX25zICpucywgc2VjdG9yX3Qgc2VjdG9yLAogCQlzZWN0b3IgKz0gbnMtPnpz
emUgKiBuejsKIAl9CiAKKwlpZiAobnJfem9uZXMgPCAwICYmIHpvbmVfaWR4ICE9IG5zLT5ucl96
b25lcykgeworCQlkZXZfZXJyKG5zLT5jdHJsLT5kZXZpY2UsICJpbmNvbnNpc3RlbnQgem9uZSBj
b3VudCAldS8ldVxuIiwKKwkJCQl6b25lX2lkeCwgbnMtPm5yX3pvbmVzKTsKKwkJcmV0ID0gLUVJ
TlZBTDsKKwkJZ290byBvdXRfZnJlZTsKKwl9CisKIAlyZXQgPSB6b25lX2lkeDsKIG91dF9mcmVl
OgogCWt2ZnJlZShyZXBvcnQpOwotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
