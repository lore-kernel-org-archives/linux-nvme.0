Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7B7C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Nov 2021 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o8Bf6GPzFxY0B63rUkRseuL05M0mWiJrwqMGxl7yi9Q=; b=lmTijZI/I5FhUhUuE+XWPF4M7a
	sEAef4oqK9v9PNF4VGUJN+LFTBH9IaKjPpz5qpklrToOJfqfqMt7FEFhOoklLZabYB9SZXd8LUyVw
	O60fCIIp3AtjlyRGNZX7ufb4iPrjd16OGup5XeGQgO9iTNlF0KMrn/j1uzu1BMrev4bHPPIhZ7Q4h
	oS8b4TxpFUugkKsW039obrd0DIQRQH7szcaxc4kBi6koMo/Wj/RN4qRC2LqFpvyLTS9N3pn83MBhC
	0GK9vPfDsUoiPsFbbFrnl07dr3UxdBaTBe3BQ6PDZZJ/zE/IejiQlZQL8GDjAsrW7j+DMDIzr63aH
	s5oQCzLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrJpm-00Fl9g-07; Sun, 28 Nov 2021 13:03:10 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrJpi-00Fl8u-QI
 for linux-nvme@lists.infradead.org; Sun, 28 Nov 2021 13:03:08 +0000
Received: by mail-wr1-f47.google.com with SMTP id d9so9490992wrw.4
 for <linux-nvme@lists.infradead.org>; Sun, 28 Nov 2021 05:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o8Bf6GPzFxY0B63rUkRseuL05M0mWiJrwqMGxl7yi9Q=;
 b=kw0SsfsFMEf4Bfgc8eRHh42BAA4oMU46V6s2yYfWmFkedrZjAcSXMneNW++IlhHMww
 M+H12lJqzAs/tFL4sn5emsmBipbQT5HNgJFwwX3nIgH+UePvXK8PpaA3dAKpmmdBUHwr
 jdgQ1CZNiMFcBmGydoYjEbLoKAmofc3iKso8EJG8tFH2IN9YbcLXsrLncf0OXNNDxYPm
 tJoTfU2vsSZcl0IcJefhCg5rg+W6T/ZycA9276RTzS2YVcchssauaqKvRE6fnq7lbq4p
 EgA85+luxpf1xatHV2LFj48rkznXIdSTpM987LmBPcVAovda9OcoFTWBnoaRxhGnsfKU
 cg4g==
X-Gm-Message-State: AOAM533GNplQZmfSSfLB8wAXkQrqNsyHaYobv2PdSZE5ThK+iip0Jk1u
 F+JLR84NYqk9e6DMu+4dcX+kIdF4xG8=
X-Google-Smtp-Source: ABdhPJzboehj6DjbeRJGhi4RmQgZFzZEJFFNkbYEGURrluOBSbf2EwMJ0IdzP0GndXjH2Ja/yCnrwQ==
X-Received: by 2002:adf:d22e:: with SMTP id k14mr27205528wrh.446.1638104584786; 
 Sun, 28 Nov 2021 05:03:04 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o9sm10962049wrs.4.2021.11.28.05.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Nov 2021 05:03:04 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH libnvme v2] fabrics: fix endless loop in connect-all for
 NVME_NQN_CURR
Date: Sun, 28 Nov 2021 15:03:03 +0200
Message-Id: <20211128130303.490972-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211128_050306_878266_81BED82B 
X-CRM114-Status: GOOD (  11.50  )
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

For a discovery log page entry that indicates the discovery controller
that returned it (i.e. itself), we need to set the controller as
discovered (because we got the discovery log page by connecting to it).

Without this connect-all goes in an endless loop keep connecting and
retrieving the log page from the same discovery subsystem port.

Fixes: 06a8f001d314 ("tree,fabrics: detect discovery loops")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- add break as we don't need the discovery ctrl setting

 src/nvme/fabrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 686a5641aa9c..9207296ba957 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -657,8 +657,10 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 	}
 
 	switch (e->subtype) {
-	case NVME_NQN_DISC:
 	case NVME_NQN_CURR:
+		nvme_ctrl_set_discovered(c, true);
+		break;
+	case NVME_NQN_DISC:
 		if (discover)
 			*discover = true;
 		nvme_ctrl_set_discovery_ctrl(c, true);
-- 
2.30.2


