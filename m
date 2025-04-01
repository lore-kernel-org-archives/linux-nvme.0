Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E26DC3600C
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 00:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5ndbVkIth02lM2moYzGnZClHCA37EO7xQlyVsyVkRQU=; b=EffdJ1QJ3aWcCKYTkrs0p1Ao7F
	0LONfpwkt8Q/fqz8SD1VRmeTIGe9r78za+pWJjdhvDU44cqxSpAduxhDAz+TVzPv1S4bXrRoXFKPV
	BVROSfxRmc8f1b0BUUGFy6QvPeITecoPdMBGXKqT2DeHpPVaeSVxfzflqMLUPQDMy0VR4WsS6kmzj
	Rst/yvLGwbCRRcTJ7yvKzMKMy1xEjwfwgDTko6QbCwHxfoNQqPz1MILOphevnHk7RYtxQ9q21KXH5
	tOetkDcYwrf5WDFeX4LcboPE+Rj0osWQDhfTWGyJZzHIT5ElIinOT9eW2RN91lX0LrjkT/38tCAQI
	GIpwL4OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzPnJ-00000001gCy-1CUY;
	Tue, 01 Apr 2025 00:47:57 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzPnG-00000001gCd-3i22
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 00:47:56 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2295d78b45cso4006935ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 31 Mar 2025 17:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743468473; x=1744073273; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ndbVkIth02lM2moYzGnZClHCA37EO7xQlyVsyVkRQU=;
        b=OkO3PGrCvqhuWOko9NF+jXEsxTG2aE7nhgF4SH0Py2Q6s7pkrGxt2wp6RxWZukB72+
         0swzomkICcBghSHiw68fLYkLS0Usk9k1pTyipY8HT/Ic+7DtacfRZB7pZG1ugkQekEjk
         0Rb3n0Dzk5GDdbG2iWtI+p/C3A0QRXoA4ghEkA2s0Ypd/0SPqiMLG11WgJQJAcvsmwWM
         YNGtIR3fA0zU0Ey+qH/ONHWKccJo1KjrnPyTG5HMVsMy0xcZkjeci7Tc34GoqojCpFCS
         BWFy5DVH3YKdAqvcuOgbXGGfgnOg+oxwXipIjiyCkZZOTBfmZnD0Id2G9u9A3/r6uRaB
         RfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743468473; x=1744073273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ndbVkIth02lM2moYzGnZClHCA37EO7xQlyVsyVkRQU=;
        b=kg5UdjOa5pmzXWI9dLmMEL8t8f3cmsJBeqYGcBDT0KV6tr0EBDcoG0nZ8vp+TFQgT0
         UxnPoL1u8M+SkMWqSJ0OpjUe8g+ZjDEslcFjGev8XjGF/yG0oYixtswqgihSMUNZ8EKr
         0F3q5S+urYGn0FZXRmXe1sVZo9RylkWQIUeyAR/BDlf+lLj2CD3xgVx/5YF9z/2bqlfb
         jPBau6W7UTJ4UXuxX4zc3NfmNT6WytHi2qzPMOLZLyqOlnjF2IKnfwRMDFYs30OdTcjW
         HXIin6/RQxcHniMMNVgei140Xjuw5IP5+pqC2h6Sqqa4TkZzCi2stSh7oHvL8XBxW73B
         LXjg==
X-Gm-Message-State: AOJu0YyZFimgg0YEDW6sxBh1AXvYWlYqftLRwoVIQ7y7ab40GCNk1Wna
	+He7tq9e/2ZCcxYcRTesdvUphz7IsONnuabHSFwDyRaT7BWVlyw9LQ6uuUmcj3M=
X-Gm-Gg: ASbGnctdZwz+qfwGhSBeGi6fxqbxBNdqKYsef0unRF2AWWkxCYZQq+N71r3MuI8SBrl
	jEIA2t6yv36RYurhavxRLbNdd/E9LAp2POKtMNSkzZHIajig1BEZAjuSAw2ODQuQRagIUHnRwDc
	MYCCqDG8aO0lzp5pD04UxKiLSQprzZ+SX54JLjjguAE0mp78s6GD07ZQvh40twg8ABcXJim//wJ
	k5c7s8Wo4rU3UYsl92dKD6QdW7ldZi8kwQR32JzsgPMyzbZNuucVU2H5tdBokGjRtBRYgbaw660
	noVxhOMMQE/NcfkO41VoTMnI4ZqCW/9YloWBLyu3eu3Q
X-Google-Smtp-Source: AGHT+IHl0OKCl+ieQEesHXPE0XcY9RNckdx+U4FTJvC9MtJqicAkeQEEKpxjGLMAuFH/wqC/yejKzA==
X-Received: by 2002:a17:903:22d2:b0:223:5379:5e4e with SMTP id d9443c01a7336-2292f9423b7mr201070135ad.10.1743468473284;
        Mon, 31 Mar 2025 17:47:53 -0700 (PDT)
Received: from fedora.. ([2804:14c:64:af90::1001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ce283sm76093395ad.126.2025.03.31.17.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 17:47:52 -0700 (PDT)
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] nvmet: replace strncpy with strscpy
Date: Mon, 31 Mar 2025 21:47:28 -0300
Message-ID: <20250401004748.29172-1-marcelomoreira1905@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_174754_920436_DDED043C 
X-CRM114-Status: UNSURE (   9.95  )
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

strncpy() is deprecated due to its lack of NULL-termination
guarantees and unnecessary zero-padding of the destination buffer.
Use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/90

Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
---
 drivers/nvme/target/discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index df7207640506..c06f3e04296c 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -119,7 +119,7 @@ static void nvmet_format_discovery_entry(struct nvmf_disc_rsp_page_hdr *hdr,
 	memcpy(e->trsvcid, port->disc_addr.trsvcid, NVMF_TRSVCID_SIZE);
 	memcpy(e->traddr, traddr, NVMF_TRADDR_SIZE);
 	memcpy(e->tsas.common, port->disc_addr.tsas.common, NVMF_TSAS_SIZE);
-	strncpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
+	strscpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
 }
 
 /*
-- 
2.49.0


