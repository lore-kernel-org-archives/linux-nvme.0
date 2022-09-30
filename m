Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C70C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=54Z6N36rD55wrP42MbiHF69anSJYDti4+bGSXjjKdq8=; b=CmsBW5G36qIP44TVaNi+b4G82P
	X8HpeLfD2C1ciDSN/D97NjCZea8aHsg9C+3wgLoHy5pmrP/Vx0U+kQzcmhVJhdXh0fl8YzShAvZHM
	1gdJRzNdaBBO9bYdT3i97hakKDCNg+RMlMFKZOaIGMVQfK2b71BpMfPco+Kk/Da6Du4PP4JFvthcl
	U121R+IxmLPKC/xuq1Er8GNPtj3XpVsqthe7tILhXIibQQK6sAMfoZ9kdegvWhIDpnuHZrMQov6tj
	M3wi+NWymzJ8MJhpAHBPqsbv6COSUEhwHzvSI9z3xIML4F3XisYpLDeQGLR+dM99rL8FWv5U6aKRS
	EAPUjccA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHVC-009zXZ-TL; Fri, 30 Sep 2022 15:00:34 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHTW-009yXR-PQ
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 14:58:55 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id 63so5585301ybq.4
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nero-im.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=54Z6N36rD55wrP42MbiHF69anSJYDti4+bGSXjjKdq8=;
        b=Iap/SUAuT1Qgl5odM9TnHatNkI3smcWWz2Fru8KZUrcN9z7Eavh+xKo0gNxVtXU5RO
         6pKwfISb1TQdqB3QQ28bI7OaAxvjXBusxYiHNR/GsjgqznhlcNk4M0IPUW5SZfUBOERd
         3VqJAq6pKe5doocBXWslDK8MNJNuQnOmnzqZ1oVVdmkYCpGvrwLC69omewoGB8WvB7ba
         NOnH2ORJxtmSJvBtCuUleg5gKZlBSBE9Fy7ARqwn/eRUQyBbt8fEMC39BtEUJoX1tnf5
         PT1MwTwGaynzoe6XbzT3x7w80UzwxjufsqT5MAZhpc04UfVgpmltLTkvbCTIf/1hWlsG
         vTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=54Z6N36rD55wrP42MbiHF69anSJYDti4+bGSXjjKdq8=;
        b=qcRx9QIkMIMrJQTwZXM7KYgTEpdssC9/NNlhXX9Mr7s3kke4jV7S4/zxJPA61PY0PW
         a3E9pJPA09vw1wniIdLSlEkR9ZMa4m243GSUoV8U/w8Wf2G3Qqa1mzUtSHDkWHuTbRPa
         aBO9myPsXxPe5xbhjIga3RGhZH75kFDjqHky7detA26okltIo/j7R6PCWwZncRSzaYh0
         efNmFPifVuSV32at1nVoE14LIizuUcX7ObgsjKGW+N8BZiLL/N5LWHpTndtU2nz4HjzD
         B3GzKp6/Le5YXu08pd/5aKt3vEZqZLqShZGf10UUKP8tB/1OHlCoR8pTECDpxXFWyAAj
         SHSA==
X-Gm-Message-State: ACrzQf1flq0r7dYiftqM2VFu+B0X0Z2eRvlxZAmeCDbfiRfyep4ecOsc
	HY1dkDK/oxXmVMYzIHs/Gp/HpWAyPW4ZPyPhhO9xAzTzUj1KvGNe
X-Google-Smtp-Source: AMsMyM7tIx9R5FVD809CMSTYKIBtGjRihfdQPnSNl+G7Qojn/Hu4a38mYCVglgCYLogG2Uq5Q7eJtLqzWA7F/afdXjM=
X-Received: by 2002:a25:c907:0:b0:69f:cba0:72b1 with SMTP id
 z7-20020a25c907000000b0069fcba072b1mr9001154ybf.518.1664549927348; Fri, 30
 Sep 2022 07:58:47 -0700 (PDT)
MIME-Version: 1.0
From: Neerav Kumar <me@nero.im>
Date: Fri, 30 Sep 2022 09:58:36 -0500
Message-ID: <CAF9DR03RxNagB37S=F__JUhOf0m=M8vwCJ=kv93mQYXDGTJN7Q@mail.gmail.com>
Subject: add NVME_QUIRK_BOGUS_NID for Intel P4608
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_075851_053927_177B174C 
X-CRM114-Status: UNSURE (   7.24  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Intel P4608 reports bogus eui64 non-unique values so apply the
namespace quirk to it too.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9f6614f7dbeb..ed4002109122 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3432,7 +3432,8 @@ static const struct pci_device_id nvme_id_table[] = {
     { PCI_VDEVICE(INTEL, 0x0a54),    /* Intel P4500/P4600 */
         .driver_data = NVME_QUIRK_STRIPE_SIZE |
                 NVME_QUIRK_DEALLOCATE_ZEROES |
-                NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+                NVME_QUIRK_IGNORE_DEV_SUBNQN |
+                NVME_QUIRK_BOGUS_NID, },
     { PCI_VDEVICE(INTEL, 0x0a55),    /* Dell Express Flash P4600 */
         .driver_data = NVME_QUIRK_STRIPE_SIZE |
                 NVME_QUIRK_DEALLOCATE_ZEROES, },

