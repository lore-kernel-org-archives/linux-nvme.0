Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C490BC5ACAE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 21:21:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AA3206CD
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 21:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kdZ0JgK3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXZG9PCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AA3206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=K9zStzSAH2XLNHzy98IYzv9rdvVDhZsCwT0FoECgygM=; b=kdZ0JgK3rtsDQ8
	08QvGY2zSU7BkRIPCgThgTTs0uvvZal8eYjLWMcUCe7h8kSBWzUNq2nG23j7t7okbp1FIefGHsL22
	x7try9HfZa5ym1fdITl4mwb/PeuNCK6kCxdUHjtAMsZsWL7WNUAQoACfEn/TvvCDhgujMZZMpbwoG
	1K1HogIItCwP8bo2lx/vLkv5/SplYGJh4JtQ7pkjLbs/adBHdzcw16CFIaOHTD9VY03L9l0LU9U6+
	tK6x7F1YFLkGYYENY/nEKGTRQJGYDQC1HotFBz3LEBP1ChbsxR3hxtJJfjHviQ7T5ML4Aa2Fon5qz
	cJfrUa2ZEcZsrI3sPWgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8A3m-0007uz-8c; Wed, 11 Sep 2019 21:21:54 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8A3j-0007uB-HX
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 21:21:52 +0000
Received: by mail-lj1-x241.google.com with SMTP id y23so21532036lje.9
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=6SoPHoZF8O/ZyTUvhLvM3bS5p+hTFKgEJPCR1inNr24=;
 b=nXZG9PCaIGcaUCi+K97or2ee6PvMcUhYMWXnsTwVQnIj+eLYOJ6Ux5QNQgtZjyGb/v
 VO/a/LPHUkjOAS9kbkuhzh+0Vw8AXlBaHP9t0ys2P1anJiuWCXsrpFla5FrVjIc67Mps
 Aoi8hwrO6bCFGkVWfqP4GvYhVVz3+/AAglW7BAUaq+XHPYhxxp4UbZx9RgjVSSyebDUI
 EVFH+ghpWaArXwELHif19GRWSAyMzK8yak6WsEVEZ2ETvDv4hfAYaCUH6avyYVXl7uhb
 NpAa9dr46gEqMbDBLsDKnL8JipU4kC+R389gAfe9HkNjIltoGrHYCqtbDZFEMQvHlg5V
 lM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=6SoPHoZF8O/ZyTUvhLvM3bS5p+hTFKgEJPCR1inNr24=;
 b=SQzpTEM7cn+tXNcW+4tUKBxv7Y9MO9zAMQIbINS5W2w7DOCDFDodY3gf6u/7GnVhGz
 v4Rh00kxzOA5PvOCggcAoa1HRcghPWpWMDFekF86xTkbyD6pCo3Ec4PQi3NAV3AY3DW3
 P9MI6EHzoYFhlWKdrMyV7wRjld7SFib/7C0z7owC/wWJLeDwy43OEhvC6c3oz0ZFmcqt
 Eu1ZuK1cjeCO1Nq6iJ1CRIYDcjSoalsKgkSU/gS7TsJCjxrq5QIA9N3AqTu3X04KfMYY
 PysrH4GeASs9fLICU+zl+hne6HEyRCjxBLTZOmIDur2upWLdvfhlOiTFcozXUMixEW1z
 kRFw==
X-Gm-Message-State: APjAAAU0UtEsTweC+adECTz0FvVRVhJvWE5tuUf3aW4g3v6+JqsqJAQr
 dyqRat7fUfmhFHKar4VthjRrZ/N2eeMkjpduUDdnDxA=
X-Google-Smtp-Source: APXvYqw5gtIvkS2IDXojmcpznuHsletgXdaKcOehEFKttIYDF9R6NXCvBjoFTjMs6SDt7YFYvSkKYwWpmYrieL0erF0=
X-Received: by 2002:a2e:8814:: with SMTP id x20mr25078932ljh.221.1568236907441; 
 Wed, 11 Sep 2019 14:21:47 -0700 (PDT)
MIME-Version: 1.0
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 11 Sep 2019 23:21:21 +0200
Message-ID: <CAEJqkgjJEHmTT3N42BXkeb+2mDbteE1YwW25cgUpMk7A_sOWzg@mail.gmail.com>
Subject: [PATCH v2] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_142151_607426_ACA669CA 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

 Booting with default_ps_max_latency_us >6000 makes the device fail.
 Also SUBNQN is NULL and gives a warning on each boot/resume.
  $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
    subnqn    : (null)

 I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
 To be sure is not a Laptop issue only, I tested the device on
 my server board too with the same results.
 ( with 2x,4x link on the board and 4x on a PCI-E card ).

 Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
 Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 52205f8d90b4..3093f224c7ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3079,6 +3079,9 @@ static const struct pci_device_id nvme_id_table[] = {
                .driver_data = NVME_QUIRK_LIGHTNVM, },
        { PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
                .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+        { PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
+                .driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+                                NVME_QUIRK_IGNORE_DEV_SUBNQN, },
        { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
        { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
        { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.21.0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
