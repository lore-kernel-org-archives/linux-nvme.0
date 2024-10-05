Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD10CF886F
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XdB8yQ3OzNW1bk5xW0thpKgq5DcUhOxcCS4i3qRDpSk=; b=mljh/adExlcn4X7lTWWCrxmx4Z
	qb5wfaf8ITsO/JnVJSGdNetyp9Xi567cJ/5XzMOWRBA+sU1LkzkhFlyv9Yohhj9GyOzKnAxHuzmLC
	hcz00hiZSiLAfeZCTMVsIjSbU3dgpdGKfx3SPQiW07SWo/FXiVJv2qZKdSwHAWrPxFOIvUxBAqog5
	CBkkB6V+vQ/a1nPqPyH0ov7hQSWQaAaUn9i6+zqovVoxmlxbN+eSEtpIiUbMlsrsyl3cW4VDylBzf
	9TU5Vh9Wgmt/tByWydhkegJn0gFPyr444fDI/DCYNePJntonG8wH9di2XGUj7IWipQ4liFOG1+BfG
	HsiXCXEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sx2zk-0000000FHIL-06JJ;
	Sat, 05 Oct 2024 11:30:44 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sx2zh-0000000FHHw-0Z4A
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 11:30:42 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-7e9ff6fb4c6so197425a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 05 Oct 2024 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728127840; x=1728732640; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XdB8yQ3OzNW1bk5xW0thpKgq5DcUhOxcCS4i3qRDpSk=;
        b=TCoVvoZRNPqYhulR9wNsGylgVPPUGrdm8Ohq4ljYKL3uUHf+Hvs4zzJ0Rk3mcbw90K
         dPT23KOEcA5n0F8vOoLMHNItyswKHIDk6D0ivX+85fMw4Zr0DjzsDWBA1o4lvLVtuoNR
         7G9HNWENA0eMocD2vbgScw/kQLR1dIeikPRYitByhTqhDNb2FIvcdsmkNhpPZEoom1Br
         5yllZ4qgJXHVFGS8UY8lyo6PXk5RLOVKY8LIiBNUk8eNqO45QAb1MCcVQ+xF7Teqm9ud
         ovm1qxItLxCo2umxgWRwpJDvzh7dpzJmIb+okCt/kVjD0miL78kVnx2toHl0ZIMyvnq8
         eIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728127840; x=1728732640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdB8yQ3OzNW1bk5xW0thpKgq5DcUhOxcCS4i3qRDpSk=;
        b=qV+a+6IU+RSE+LhtRZd6JYP61u3GOAUZqn2/S1huYMpY9weN5XgcOZ/dkWZHsbvfoK
         Tx1+43dtp5ExybSGx7qufQUEXvhO4c8TznEY1GAG9nebBoV7vVYe/q7JgFJDn3u8D1tJ
         X0fVeXwkfrrIOZzJZX5UBPQB/JxIHGuZs8M+4kmImUZdtJUemwgWM8cqYFpudH/k4hvJ
         1mDCl0iG5BY4i05a3eHemCx+dWL5OpZoXvwpWMR8iED7NUW2k5jGmPt6RbIsniYA+zgD
         SQeY/ZJuZymWs/NjoDJIZOEbuxUWCXNe5bXCWAM6Du7uUiKuY435PaT+lBYPnC91PI0S
         Lhfg==
X-Gm-Message-State: AOJu0YwiH7rFapm2Zk8vUjfkIi0qI30mrzjAHSS/Wtc3wDRKUvH6O6ER
	iU1lzcpQ9yvGqb/0tmuaPHAQsrPtvYuqa6/Q8EBUckS0v2WNYjOp3DBmWA==
X-Google-Smtp-Source: AGHT+IHPB4tMef1qFjsuI89VhnuOyRGHa7aPxIyf8lQ3ilHG1QqK22Z8C566JuI5qMUforzQ/pSp6w==
X-Received: by 2002:a05:6a20:40a6:b0:1d6:e197:ae49 with SMTP id adf61e73a8af0-1d6e197af76mr5859183637.8.1728127840037;
        Sat, 05 Oct 2024 04:30:40 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:475c:a654:1ae:2a0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c35d03sm1508723a12.60.2024.10.05.04.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 04:30:39 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2] nvme: delete unnecessary fallthru comment
Date: Sat,  5 Oct 2024 20:30:22 +0900
Message-ID: <20241005113036.12181-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241005_043041_185716_E41AFBD4 
X-CRM114-Status: UNSURE (   8.48  )
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

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/multipath.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 48e7a8906d01..bad1620fbbfc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -431,7 +431,6 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
-			/* fallthru */
 			return true;
 		default:
 			break;
-- 
2.43.0


