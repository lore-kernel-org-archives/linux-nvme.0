Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6DCC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jan 2022 02:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4WQ/8JHSUHdcC60H26iiWsvlZ6gMDmzCg30bgw7CA0o=; b=yukRKRMfFyZ9FZy/eJWhXwrKEC
	J3ypjlxYdk9RWfEyPIc/RxZNj76xKqQGbcY1cj4Rx9LqlgSEBfvmZ3UPpSEK1W9OnFbXAugeLFb3l
	PdfBBEKRaxWfpvjGzRMaaZG+cm3QlJPAbnOkQH0eFFsrLZKyn7e/svs2InBVguSojnLI1OBPr5NvG
	3FNtwThzOU+Tzb1W1GJ2UKoNEp1jbD/bFDMrAJcEijYdMNwdWZC8TFRCJol/WTzu91BZm5/iNaOh9
	P/QdflT5ls5N8CzzdR33b6I2gKD+sLZpvdz0dtYmALigLMicfAPvN10qmRFstDM35Sq+IX35vIgtG
	mhS8U3IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5euu-001vg3-3a; Fri, 07 Jan 2022 02:23:44 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5euq-001veE-Un
 for linux-nvme@lists.infradead.org; Fri, 07 Jan 2022 02:23:42 +0000
Received: by mail-pg1-x530.google.com with SMTP id f5so4177167pgk.12
 for <linux-nvme@lists.infradead.org>; Thu, 06 Jan 2022 18:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4WQ/8JHSUHdcC60H26iiWsvlZ6gMDmzCg30bgw7CA0o=;
 b=FL4sc2NxYvM7CVA0ejjbQITIST/Lwlef9buy0Gi1qxucnL+bBNxx9HtfQ5A7zUyeIS
 4SdEFiy9roL/i3Nu+kpbXkViLRtnlkVsk0TfkNNlMW1Wxiqan/VWs4LdKg5KknAbC/5P
 cglaoA3R+Vkl/XM3HR0O6vwHTyDJXCSZDhtBtwX+R5OQjJeQfq1oHgZdCpXX3tmclTIv
 Q/dK6fuWF6NWY34EAo3GJ1AacIXX7IfIi7xie7kTycTkDYA1BCppojRR+wobKtxAfjOh
 OEEIXaNjCGP4QsyfEgoXTdrYc2UjbO3PXgowPe7zHwk4PqLZWB9NMEOeVQ7pSXCAHCEg
 oZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4WQ/8JHSUHdcC60H26iiWsvlZ6gMDmzCg30bgw7CA0o=;
 b=kroLb554A0jXfxqxrdOOJHo/e43rYxHQVODQbZdPI3Io1pBeAqbg67p9R8KsFFa5gY
 ikTB4ljAdP8NLt70h8UN+hRh3hnoo3jEg5y0Ble/LAMdyGli7dO7U2GfBsN4NpsfGCzv
 /4Qsjtcgae+amDoijUXCdTT5aMhf5s6BwgRSQl7HgVjSXLdMqmviw9veWWm5mai91WnX
 UPM1GRAy0EkV4LaMTuxoyLt8G8VplXgEjut6RafVOn9wJO5eTpEilTBPuMacp2vTqRSr
 5TNkrwUQPCsRvmdcL0+Gm36yAQcoWtaw2uMWUCDMweOnMtHgyHNRGl/bx55F/RuB2kor
 xSUg==
X-Gm-Message-State: AOAM533ayijLi3mKfx60/0M2EVATI56Nm2EuJjsIBoGCxVb3nV5QPxCG
 ByoRKnIcJMYtZznwGEDz0wMDNXaObp9OMA==
X-Google-Smtp-Source: ABdhPJw6bDSKRP5ew33JRHzIyIA8jawuyjfDgVbtuw55FeuP83NGxhrNbRGDiATaOoID+LN51S0NDQ==
X-Received: by 2002:a63:8c1c:: with SMTP id m28mr50519636pgd.594.1641522218829; 
 Thu, 06 Jan 2022 18:23:38 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.38])
 by smtp.googlemail.com with ESMTPSA id h4sm6439769pjk.2.2022.01.06.18.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jan 2022 18:23:38 -0800 (PST)
From: Qinghua Jin <qhjin.dev@gmail.com>
To: 
Cc: qhjin_dev@163.com, Qinghua Jin <qhjin.dev@gmail.com>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-fc: fix typo
Date: Fri,  7 Jan 2022 10:22:58 +0800
Message-Id: <20220107022258.396058-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220106_182341_049766_0051BA44 
X-CRM114-Status: GOOD (  10.78  )
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

subsytem -> subsystem

Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
---
 include/linux/nvme-fc-driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index cb909edb76c4..5358a5facdee 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -721,7 +721,7 @@ enum {
  *
  * Fields with static values for the port. Initialized by the
  * port_info struct supplied to the registration call.
- * @port_num:  NVME-FC transport subsytem port number
+ * @port_num:  NVME-FC transport subsystem port number
  * @node_name: FC WWNN for the port
  * @port_name: FC WWPN for the port
  * @private:   pointer to memory allocated alongside the local port
-- 
2.30.2


