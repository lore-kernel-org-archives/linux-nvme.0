Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1923DC43463
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 13:23:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D856520773
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 13:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1e9+AHF1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDiXLMMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D856520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vtj+UTPLxXET+q8nQS/9fCUiF7jysnX1VXp8YQcVchY=; b=1e9+AHF1C9BnUVAJV6YWOQmtX2
	R628WQqaUzEGVSwaZhDvNKdfjGyhMdcQY5FlzHTCMI6gEyZ1zLw+geLAYpM1fXpBb7BYZqrFdeyWd
	2xCzLfOIu10SFuIQUUlpTUAUVAaJWOFJH9gENdd8SmNLnbZO7R315XIW2GH9ejJ1KhNvGfFGCaeZ8
	Fb3MM8YhU4beGV2T57HBgklKz41Fc3fSQ8sPElwTsqvOtuxG6z4m5Er1NzKVUnIPVBd+C1hFS+5PV
	7LoVsUf4kKhy7kvNc7eqkfNWnOb18NstFOzNO5plcVMdMugxm9JA4X36KhREbkmr9Ry8F4iC7U6ho
	DJHQiriQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juyQB-0006QJ-Dt; Mon, 13 Jul 2020 13:23:03 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juyQ0-0006KN-FH
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 13:22:53 +0000
Received: by mail-ej1-x643.google.com with SMTP id y10so17168011eje.1
 for <linux-nvme@lists.infradead.org>; Mon, 13 Jul 2020 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pbRPI5T6+CQlcjE3Ve13l43uBQozAmlKN702iYI4+CA=;
 b=oDiXLMMy3B0TEHpeLRAA8vNGcLzfduiAQ+QAJdNsEevV2wQyULi7h1rsVLBU0QBd8y
 4LjXS26jKI0uEsMZ3UdV/cg+efVFpxA8EO0JRJtvjwrfx9wDZNmSEAkJedi2rmcmkC6H
 IrZ0p9UJ3D8udE+6aKJUN/HcHK/A5s+unm9YnDwz/kgjWAY0+6+vxGd4t9UQUf2g0TmK
 gP/D4CB0DB+UwLz0Pn0O0iHxIM6U8KNLOmW6Kt5dW5DyPHBZqcrUWBZRRCIMAcxoUPBb
 CaIinXEHJ1jIAy4Z+NwSNDbb1xsx4djmFhPfF2P68dm1y6syHOuz+H/xwyqAifzy/izP
 Q7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pbRPI5T6+CQlcjE3Ve13l43uBQozAmlKN702iYI4+CA=;
 b=BEwER0QAC5b4DpCE6YYVdLvfnVLA4z06tYLtJ78i+iavzPqA7KYMoXHYixfV6bSdNL
 nWV7yvzoA82+MOzYFAQIRl+qsDpMheV+d9RjSUhr+VMfU3/OJhH2z2PMbXQrFDCezmR7
 8SQYakrYcFd4MtSB9bu7z0je1d/J2K/LFSiyo6i3bYwfTVV4fSfmSK2QkgtoYFesvd8P
 AXBDBnxp6i4MjrCGPclazZB+k+HmCvkLY/RkkW2AxX0A7vQGOvEQLtPTu4TgFor3Fla7
 2eraoNWkIPBZf4ZVHogufGB0diuSFC8OFOQp5d8L6vBBbc0ptfaKuE7IJlqlwJXaRrIh
 r3EA==
X-Gm-Message-State: AOAM532cXZ34rGrhFoeGUhTHmBAqw6t/VmttwjfeNAFzBB4hYS1TEltx
 8CJ6g5DPFdKqJKsmhvpNY78=
X-Google-Smtp-Source: ABdhPJzLFoiuIquHARFKdvDNBo7G8zRr4UNzS9o5abkca8STc4RB8fWWh2+zFSwtRcAtOf/6bGWDbA==
X-Received: by 2002:a17:906:cd19:: with SMTP id
 oz25mr72103030ejb.36.1594646570989; 
 Mon, 13 Jul 2020 06:22:50 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
 by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 06:22:50 -0700 (PDT)
From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To: helgaas@kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [RFC PATCH 10/35] nvme-pci: Tidy Success/Failure checks
Date: Mon, 13 Jul 2020 14:22:22 +0200
Message-Id: <20200713122247.10985-11-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_092252_586530_9A66C05A 
X-CRM114-Status: GOOD (  12.76  )
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
Cc: "Saheed O. Bolarinwa" <refactormyself@gmail.com>, skhan@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, bjorn@helgaas.com,
 linux-kernel-mentees@lists.linuxfoundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 09/35

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d426efb53f44..a04f2d0375de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1185,7 +1185,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 
 	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
 				      &pci_status);
-	if (result == 0)
+	if (!result)
 		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
 			 csts, pci_status);
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
