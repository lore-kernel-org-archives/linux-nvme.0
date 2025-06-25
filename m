Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780C6C7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 20:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u+kL5Owd/b/uNVufMn9kQ7uWapXNIP2yBqmENsKSMRw=; b=DmuPh1BFnH7C425/7A/ZRL/eO9
	umNFx3UUewLMqwzHDP4PlR29rRtO4jWOw7eBJ15N+wwlf+UtO4m5ofGbvJpCbBg9bp2UFSpH9A1D3
	dGr3ACYthBuNFrx+Agi1ZvC10gWuxN902dErMjCQYvIQvndDMnnD4UQRCy5OqYNtDQ2UwI1Ddh5D8
	SsWJdZRwVeY0JSh+dUlxEhTf4e2wzk1E42Up745A1WgDEn9mVk3+pl8EbmSnTwRf6Y1afk8PrBYA1
	VudI890SBOiVXbWl+PpVM2nVTVDNCTyB9hD5osDkTdI07pKvCEYAnYh1eUH3HElS8Fn+OdiyACHBQ
	vdBj1tbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWrt-00000009tGy-2sie;
	Wed, 25 Jun 2025 20:37:17 +0000
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWaS-00000009p9f-0Hnl
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 20:19:21 +0000
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-408d7e2ad03so236010b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750882755; x=1751487555; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+kL5Owd/b/uNVufMn9kQ7uWapXNIP2yBqmENsKSMRw=;
        b=kEmjpuiauIWSPWMkUnncxn3hMDfmASMfKbfcPBrelHKUWbrDg8lJBXfGKp9y0cMnAl
         wzJeLgNi63YmG5wx83JXILu36ZtnEhSmn2SaPjESPaD0aqixOQflnLDRl7TdXe19qbUS
         chhsHxC45z8LAv3Zudq6FIh+G392MGY2tEu2pH347pBTYTC8W/tLQQ/8eWnLd799dnIq
         XMThD01ehtJyYH3lUQwla4GzwP0rsA2Ph8DGzP2p6bMs8bkuyrb9PeLBty/73vZSv+64
         WvR8pZfcRUrZ8pu12OW1eK4LZcdGemGqIgyWLVDDcXI17oKbEMbAvqBlutxnHH6bCPJK
         7TsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882755; x=1751487555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+kL5Owd/b/uNVufMn9kQ7uWapXNIP2yBqmENsKSMRw=;
        b=n5+inIsv6YsgflA7y/FAE3IDPXSGCejNmee4wBUnH0Rx9nF9kYBp28fUvPrD4BXY89
         bwepBV8xjEv+pVIOeeO3TaNarg0kCqi3L83JuaFRE5SQzwgNNgNVxF55wj7zZF9eg9L4
         W/belg5Qy9F4M6osGVkMolqpS8SLJdoGF2au72E+jQG8p+LTVsDcoSe5PkKLHIfpIYVJ
         hqrN/KMEI4VesBbo/3fHv9xsqa180zdZ15HdXVbCbjHQA/3b34Z2JDhQyS3KDseUBfXR
         zAR1zFVTwmoeBIQqrdzL/gwlEDs6IjRp5+GvrBdEPDqG/GBi339uOAbEK2TwO7iVyt1N
         UMFw==
X-Forwarded-Encrypted: i=1; AJvYcCX0jVH6OW0ZDLTmSzbdnAfDFtrVXEJlrUmKqPVjfNUdeITN5rgm0AHnmZCnjJ1B2S2bAMeiPueAoY7R@lists.infradead.org
X-Gm-Message-State: AOJu0Ywr60YKurCF+//pzqjGerpgru2lq30A6PaNa5qFsglmO+o1VlRT
	qKC857tR1kbBjvUeawgVYqjwghM7A8Xt6d/THqwJgM7SoZpZdmVoGenh
X-Gm-Gg: ASbGnctbGl4o83NDZdea9eE+JfrLNS3wCRQP/9ss5UFt3Ab+D6iLDqv1q0BjdX33A7Y
	PX3r/UIcTsRDtzbv7gadR2bLJ3qt121RsKT8T/9cWVyIkugTLfrZLJh9C8/4HNnPnLO7m1xa+Zs
	kfKRLIlCTdFj/tmWw//2lVVJhjbzv6xcQJHdsWYVpgQHz843QxeyBt8nVHK2kvX9o0zyB/6dZk4
	V2gGqIBApMomcDunNymZ3vPzFCYR5ltktP2dbzdFizJ7DYooULpTEjZB0qjEyMVAHUzX6URLfKh
	7fEQle1qQuvI8MMQvg5LPf/kpWuTMisLcUHcX0PpFjn5emO+m+s0n7zBeDwgK4NqbqhfM2U23RL
	lzThM1ZQ=
X-Google-Smtp-Source: AGHT+IErlKTN6Obe2eJ+hIRHlWBHfaYeu4HODg60y4Vj953Lq/di1qxS4riYzV3zaqb0HmNNI5o1iQ==
X-Received: by 2002:a05:6808:14d1:b0:40a:57cc:d9f0 with SMTP id 5614622812f47-40b057d76f4mr3175226b6e.25.1750882755168;
        Wed, 25 Jun 2025 13:19:15 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d22c23sm2319188b6e.42.2025.06.25.13.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:19:14 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v10 5/5] nvme-pci: Make driver prefer asynchronous shutdown
Date: Wed, 25 Jun 2025 15:18:53 -0500
Message-Id: <20250625201853.84062-6-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_131916_108334_E81E9BD3 
X-CRM114-Status: GOOD (  11.31  )
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

Set the driver default to enable asynchronous shutdown.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..727527ef3896 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3831,6 +3831,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.async_shutdown_enable	= true,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.3


