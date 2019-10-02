Return-Path: <SRS0=mn4A=X3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D8C352AA
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2019 07:37:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601D0215EA
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2019 07:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rZuGAW3I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOj9q0JV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601D0215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QOCFKoQ5Wxv8d8/p6lP8TbrgZkEwZeceY68qDh3Yhz4=; b=rZuGAW3IgLxE8t
	d9pmCaw2ym9oPiI4/JMzPNWbRCpV4ZsBo48ibRWvisVg6TRHYe85kj6cx4uEeDxjQ+BDBmeO9dvux
	HicUdNwnvbffrZVuFWTuV/NuIEfReNszX9slb1Z4/bdEtc+F2wn4poAfl2lnsbRT54Z+bddHcIhl4
	NI5/qtSWcKypagYcNhp8+A1+7BY+z1pijWOcz3sOoAmzY3oksvF0H84uVFRMsiy9uXrXK3tZqHHT9
	/5XKIBUAWPntxX1Kri5M+yCmDL+LGX558iInvWtwTCqU6Pm5BJnX01uzuDLhH+SPkQv68Tzh1CYN7
	GYqkd+mJeMy97qIjVROA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFZC1-0003uw-2R; Wed, 02 Oct 2019 07:37:01 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFZBx-0003uc-GD
 for linux-nvme@lists.infradead.org; Wed, 02 Oct 2019 07:36:58 +0000
Received: by mail-wr1-x443.google.com with SMTP id o18so18319752wrv.13
 for <linux-nvme@lists.infradead.org>; Wed, 02 Oct 2019 00:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R1AMblbpULBxb43nEVZyfbmDD2ZvoFRR7AmT/Fc0VJo=;
 b=dOj9q0JVaiDcBUk0adCq3Aeg2wPAg9VKm2j353MuUy79BvoF1ipr1Fj4D69T8D1uCC
 juqO01Av0oqp08GRxNd+De4xxGz7nyvMumiMl6afwfhyF+J8RHb8xMlj4aEEpMY1thlv
 qk+5k3NefiOYwsGwL8NJ20S8xzaevxLzzaox4H0KdfthqXhLFkc2mjqhfBJlpnvalxun
 BFJwpe69f5JU6vLd3L7oLpo5FYsp+Vo8QmxWiAA42E/B4CBShl17wg5eV+bIE+o7p2Om
 gfyP+OnzT8rzr9BmjZAsc2dBj0tE0WmLh19oKMA3puYQHSlc7jDycUxtCai1stORQ1fd
 0a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R1AMblbpULBxb43nEVZyfbmDD2ZvoFRR7AmT/Fc0VJo=;
 b=cHvimqWVMMG9QrtHlFANsNV2B0G8X1rOED2VGMEAmQSGCaaiX4Qw24JWjOlZj195gi
 s2vM1BFerDRljNxib5pP3JJMOH+MwYamUj1m2j5zG3bXBRzHqVdDL4cOJjYl78sdmm+S
 Gd4gR7p6W3dxr4RBTwbH2V/ZQFWYckyrECfsoIzq/DhCwga2ybN8uVvmTnrbiXOUfq6n
 AX1AoguFaFfHiBY+iPOs9I6rdBgQj5ODuFo86bz5S/138Bo66OBRvK32bEVnFYlXPIA2
 DmBDA3mbxx7tOW6scfx0F3pDQVx84xnRx7CjqntCyj2pJTSYA+7i16BvKotW8u7UoSFX
 GI+w==
X-Gm-Message-State: APjAAAW4IOer6C57rwJTdsc77Z1A6F0/5sB64SfMJ27IMije0geiPaZ5
 7UWBLllhPmVJ/fhD7aVCS6tWFU+V/spRMay7
X-Google-Smtp-Source: APXvYqxb1A4jIFRU1PxvYCCP2gLXTFW4suvE5NOGnbRNHz4kbRvmu02SIQOKbvdgZsfnY3J0uQIJ6Q==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr1442377wrn.200.1570001815744; 
 Wed, 02 Oct 2019 00:36:55 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:1d6f:6259:a948:207b])
 by smtp.gmail.com with ESMTPSA id f20sm4948575wmb.6.2019.10.02.00.36.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 00:36:54 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-nvme@lists.infradead.org
Subject: [RFC PATCH] nvme: retain split access workaround for capability reads
Date: Wed,  2 Oct 2019 09:36:43 +0200
Message-Id: <20191002073643.5339-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191002_003657_603184_0045084C 
X-CRM114-Status: GOOD (  16.87  )
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
Cc: sagi@grimberg.me, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 ilias.apalodimas@linaro.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Recent changes to the NVMe core have re-introduced an issue that we
have attempted to work around in the past, in commit a310acd7a7ea
("NVMe: use split lo_hi_{read,write}q").

The problem is that some PCIe NVMe controllers do not implement 64-bit
outbound accesses correctly, which is why the commit above switched
to using lo_hi_[read|write]q for all 64-bit BAR accesses.

In the mean time, the NVMe subsystem has been refactored, and now calls
into the PCIe support layer for NVMe via a .reg_read64() method, which
fails to use lo_hi_readq(), and thus reintroduces the problem that the
commit above aimed to address.

Given that, at the moment, .reg_read64() is only used to read the
capability register [which is known to tolerate split reads, which is
not guaranteed in the general case, given that the NVMe BAR may be
non-prefetchable], let's switch .reg_read64() to lo_hi_readq() as
well.

To ensure that we will spot any changes that will start using the
.reg_read64() method for other purposes, WARN() if the requested
offset != NVME_REG_CAP.

This fixes a boot issue on some ARM boxes with NVMe behind a
Synopsys DesignWare PCIe host controller.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Broken since v5.3, so if this gets fixed one way or the other, please
add cc: stable.

Given that reg_read64() is only used in a single place to read the
capability register, it would be cleaner to just drop it and add a
.reg_readcap() method instead, but this is a more invasive change.

 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0808f9eb8ab..bb012075fbb2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2672,7 +2672,8 @@ static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 
 static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
-	*val = readq(to_nvme_dev(ctrl)->bar + off);
+	WARN_ON(off != NVME_REG_CAP);
+	*val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
