Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEAAE776DA
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 00:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ks1xegmL9smUxtsS+SMxje7YFeTJohysqIN7y13aErc=; b=V2vFJSyMdyjOFtAavzDBcbSzUb
	H1cPZjxNql/s7FDz/frp1vl2rS/zPZDwQyHWQ8kcQTDUEbtasRlb3CXsr/KzOzhtei8sJxZrr9q2d
	2sQEpEhKmVV6/0DI9t4NL9EN99K3RxscAH0C4JLyeUrco4JvMykGyuwk70rLdkaVwnnNrkmqyOkU3
	EAGE5gdf9dGQSY8fgK0gns3se6WH6ghPylkhDVLXwRifepLbBJfHi+MYxwkid5b7jRL31TwJAexMH
	CwTOE9kgJYD/EpFelDuTIxxXqMJcdFTzXX22HevES6sS9n/htJSov+AjgfUlBDa7Il2ldcGc+bX6I
	sIgZavjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnT0i-00DZ74-2K;
	Tue, 03 Oct 2023 00:11:36 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnT0d-00DZ6W-18
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 00:11:34 +0000
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae5ce4a4ceso238307b6e.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696291888; x=1696896688; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks1xegmL9smUxtsS+SMxje7YFeTJohysqIN7y13aErc=;
        b=TAN0WAfnW20zd6hMO8L7wuIbqmKb8TLxVomP4I07v8R8xxOQRa/rkTBL/jvSMvlDfT
         Ka1qWlchnKhxZSgjjnKUpzpC+rmB4jaQeGiAIoq3MQmwGjutfl1obahc9fgcYQ3sUP8D
         CRYjIflD9saVPzfX1U7rFa4fzNJSs//nWazzygWdCNTXxvK+6RyRShXHuyCjUUzAbtmQ
         ZKjUYp1UBUuaSRMOz9vrOthDArOoeHmiEgBEEv/1Vu3+sqjmNeHRuUdMiawGFZoljU9u
         4pCz+1UiOhXTGkPpQm2o07TnP0o3IELik++zAR/VJ0xPUlgmrZGrWTSlt3DwsiJWEj0R
         4yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696291888; x=1696896688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks1xegmL9smUxtsS+SMxje7YFeTJohysqIN7y13aErc=;
        b=uAZPPWbjJNx/ikGXZqe65MSl8PFlM0PXjwAwkwAOW9YYGncW38nHjhWjtGj6yRmckQ
         mEK8vqbFvd5VZ4W1i5cfE5BtNJISZq/zxcfZefqiw376DrstHXHQXpwiHkDvSGhFYax6
         TQ5Z7XusxnaRrs5V9THxP8pwcKfFCzXqZ8mNlTFD6k6Z7hakUWDF6hpHb6jMmdMuWKRt
         Z2bmHzG6cJzkzttogiTGicqhJCEfWLMTv7iUnzMr++8FVEMe4NlH+TycdTQNRMZMzEPy
         /JX6XQXjgRLMG89ayfwXQrP7VXgwlRIOhTcWoh00LJFqlOm5j+Y1vdFrQzBnQ1e/58HT
         h+Yw==
X-Gm-Message-State: AOJu0YzOTM+v22qZI1XJPfN8Uv1sMCedaaRf6m7fVhJb7yjKouFoxFKN
	DoIZS7/CxgStb043e2b4768=
X-Google-Smtp-Source: AGHT+IFTWba9eUFM3rjM4kgPEDm8MwKiMQMbS/JQZLLX2yNC3re1qyZgQ3d34guFhNkiV6jeZKnnUg==
X-Received: by 2002:a05:6808:13c1:b0:3a9:a334:907e with SMTP id d1-20020a05680813c100b003a9a334907emr16317500oiw.16.1696291888591;
        Mon, 02 Oct 2023 17:11:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a743:e840:d142:20bb:769e:e427])
        by smtp.gmail.com with ESMTPSA id m123-20020a633f81000000b00578f697b277sm47192pga.5.2023.10.02.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:11:28 -0700 (PDT)
From: Lucas Gabriel <git.send.mail@gmail.com>
X-Google-Original-From: Lucas Gabriel <g@11xx.org>
To: felixonmars@archlinux.org
Cc: highenthalpyh@gmail.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	xuwd1@hotmail.com,
	Lucas Gabriel <g@11xx.org>
Subject: [PATCH] nvme-pci: Add quirk for Netac NV7000-T
Date: Mon,  2 Oct 2023 21:11:19 -0300
Message-ID: <20231003001119.384377-1-g@11xx.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907183605.631347-1-felixonmars@archlinux.org>
References: <20230907183605.631347-1-felixonmars@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_171131_409017_70D812E0 
X-CRM114-Status: GOOD (  11.15  )
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

Same problem with Netac NV7000-T that also uses the MAXIO MAP1602 controller.

Adding the NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk solves it:
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f57da12d983..d44a69b1548a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3430,6 +3430,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1f40, 0x1602),   /* Netac Technologies Co. NV7000-T NVMe SSD */
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
-- 
2.42.0


