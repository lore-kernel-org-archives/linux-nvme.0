Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265B4C44508
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 07:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eFEOc9K8ZH4WjUhqE0lhCkuF5t/lKGFy+XbxPZKCt8U=; b=F6nFWZLp9Uy6uF8ZL/GPfvh/WN
	Rars3Abrxtb9EwzHZthCSsOMv0jVsoj1CG7ldii69AHqIzYLkvDa8bA/qJYOYVF5m6OSeJiyHgOAK
	fkSVbR3AAKBpJfUTlSo3BzZjJWOahaSLWIVHvCkbEkC+qWjaj5fgo1TmrVKaAAdxVOhMDECWOfgv3
	YslYExW2pM6HQC8j2FxfDl+DtN74Rv2l/VzaIbdfiqj2S6qBo6ASouJrlvS4ZscOsgDAY5kqcK3a5
	9EV2qozk3VyHnUTjretByTU7OkYIwY4oQH/EBzhdLazAiIeP2vOofYIfX6eHkhThsqgM8Coz5cFWc
	OGjy8NNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjuIt-0000000E4Bm-1CL8;
	Wed, 15 Jul 2026 07:45:15 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjuIm-0000000E4BB-0Tjm
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 07:45:09 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2ceed7018c8so11432385ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jul 2026 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784101507; x=1784706307; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eFEOc9K8ZH4WjUhqE0lhCkuF5t/lKGFy+XbxPZKCt8U=;
        b=F4o454+2ufdWUfbON9oQYnAww90/75LI48dOYnbPs+c664IeXea3N6hClTqfNxwq0x
         I+UIyRkZDpU4XK1vfZZTDqpF+H8nQO9aNw3p5T7gMew713aAyhV4a2pVWB4wKlfJK4uG
         gvY8s00UJPnZQ+o+af6XjRwPTadePaRcTZRNtPAqgjGbM/Xs+cmy/qO/7WxsXs6aXQAN
         ZXAcJBdjwZKy7rphwh1nnyOBam/4dc8Tb4s/jGw8AgPrrjsZBT7wT7qcl24DOKwYUyNm
         /QZ6HgnURvUPfqh/pQYsvD/MyA3H8JpT/2PFQpMBecmd1dnRZWnACZG0j8JxwYzYheLe
         Tyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101507; x=1784706307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFEOc9K8ZH4WjUhqE0lhCkuF5t/lKGFy+XbxPZKCt8U=;
        b=iCejteQCPxLy8lSr/7O7r6q6YSKB3ssyO0+Wxkxw0/B6eg0PWqBPLf7dzh+WbBWhsY
         BD5S8LsKpW4vVeL4epMVgNFKrUi+WPX78N9e0k5JEkPrR3OsWSPQsRTXg4zF1jgzt1jw
         wo10XTYSr9vA/n9oleHlhL3C0+ffepf4JMllyDLFZPM7J6MmGKlnNPKRDmTNcXYmXVKf
         hkn670ag/Pb6sjrJ3whuLLC6dTkB2qpcQbWckBuEJTfCNew2tlJjczTfJkAWfzDjNLPW
         8mqdz9vEW6owwuUx0O7CcJm2Og+MNt47EqML/zqctOhuA0m1B9aTgoX/TEH6ZP3ijhfG
         7Slw==
X-Gm-Message-State: AOJu0YzZHKQO1w+NtW+oM8JAGXFP1rXlQ0tM2FfmwdODJ3rcTj8QQpLT
	gGGxv1KkhGdGZXs3bhyCaAXqtAaRdRfQvjUXtZEiAeRXTN9KhlqOV9A=
X-Gm-Gg: AfdE7cn2YIw5KEx04xOzZlaoeVaY6RINy0rV1+aOKbj6p+M6Bgrzz1xGoyE9lqxF9V8
	hzkSd6sApVSxk6jKTO2OtXz0vP5bBgZtsDLs8SYddNxFzlb3I2qpFXxmPJBmxnOTPGp0xUO982t
	ef9PWumev3vliYbRZ4jPb7MYIY6K8MpofeF48NQtUNibEqTts7GykWWggSAHK6lJVYz4AAl8jjX
	rpVyTOYO6xUSsQJNTeHVCNFSrEM9Ipsj61GPsKY8aPaLdhMINAp0tB2jgl1U6MYQdh6p/sWpRln
	cYAZkZHdW9+yfUSkePi4+F4cANbOKvZMiPnevx4aJBBWE4ziydlQfeoCEpzld4ULA9n2dmFj4AL
	ya4BEqCwQogJs236BBvEUVA263Bsm+sz9Zo4axbe4WRtzl6xZXgWvzl/RHMN0EumFUbjzsxOy6f
	UPzW64ffPySnE7SEkdBPf9QvJT0IJjtTwXKHfeiQJy1mdJVZDHgLHjIZLtwW0CBxzrN4pw5KvYs
	weA6vTyazs9zgUDuBo5PzagKwUJHzlNvjVQ/0NW1bIOPHcjjA==
X-Received: by 2002:a17:902:db0b:b0:2cc:6b7a:dfcb with SMTP id d9443c01a7336-2ce9f028b80mr152805965ad.33.1784101506574;
        Wed, 15 Jul 2026 00:45:06 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bd33sm130345175ad.58.2026.07.15.00.45.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 00:45:05 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] nvme-pci: disable controller on admin queue IRQ setup failure
Date: Wed, 15 Jul 2026 16:44:59 +0900
Message-Id: <20260715074459.50760-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_004508_208475_83C705DE 
X-CRM114-Status: GOOD (  13.84  )
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

nvme_pci_configure_admin_queue() enables the controller and then requests
the admin queue interrupt. If queue_request_irq() fails it returns without
disabling the controller, and no caller compensates: nvme_pci_enable() only
frees the IRQ vectors and calls pci_disable_device(), after which
nvme_dev_disable() treats the controller as dead and skips nvme_disable_ctrl().
The controller is left enabled (CC.EN set) on this error path.

Disable it in the failure path, while the PCI device is still enabled so the
CC.EN clear handshake completes.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: b60503ba432b ("NVMe: New driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f0c05719316..07aa9af9bc89 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2221,6 +2221,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		dev->online_queues--;
+		nvme_disable_ctrl(&dev->ctrl, false);
 		return result;
 	}
 
-- 
2.47.1


