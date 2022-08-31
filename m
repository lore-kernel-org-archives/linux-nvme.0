Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDD7ECAAD5
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 01:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JVftubc6KuRp3jMxakTu7sb8RAmy7skK2pVT1PxM25o=; b=LRC21Q4qKQ1LrVl3VCVmTUGCxG
	rFTfCLSoecVXGoV931K7E7ycOQzEcY/8DXwvFMuj+kVJppzNmewXVfDcB4XLWk/XmcQMwtiVA0Ve3
	Zpc3UpePY4/5mxBr/AEd27lzpZ2pzor3kDbqDbLXfdstPhO02Pv2uuxYhQUL70LEl6/KFY74buXyM
	P8n9pi8joSba0xKg86ZAQQEiqCxnjpYrqmHB398KPdEhmR6JIS0LysvBk4bEJy3UuetaO0oT4QM6K
	1MZ7fYSPPK8UvI6W/cosY7snhs9hHH4gQyE/ujujvKJNPXPca1qDIUfRRcP1Ax0UDfCMCbI2MUX/5
	uZa70H0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCcy-00329w-82; Wed, 31 Aug 2022 01:34:48 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCcr-00327B-PW
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 01:34:46 +0000
Received: by mail-pj1-x1033.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so9945292pjc.3
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JVftubc6KuRp3jMxakTu7sb8RAmy7skK2pVT1PxM25o=;
        b=cMy3guYSxEFyWIHVXlr8oksM36Y3sMAwvAgvJHSo7Wc1VgjW0Tayprba0syLeZ/G5J
         5oRhiSiUwE047aaS8BCbsZBML6KkQCztALGvE4m+VrIP0kx78DRCzZMeMowoqChwJTpc
         2KqR7aDDTZO5uEd94b0SJVXgH5E8ZeYAyiKLXVZRdKQyBicUHmESRsubf5/ff7VAi20A
         DCsIZxfaUZej7nnN1WAsjJ0psocbT+vG4E+b7IqkHAzF2/C691SDO9AeN0KEWozeW0og
         yfegvHcRl1LRDdWAo9Vg8mtwwF3GlQcs3Kl4LwNH/3ukRlP4Q1KT16Rzq3dxNJYKQjEH
         hIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JVftubc6KuRp3jMxakTu7sb8RAmy7skK2pVT1PxM25o=;
        b=Lzqy8+ncEp3q8tNQMyfXW9KY/5bu4oYTVG34kPOvvDozIyhhliARkS/y12J3acVVjx
         3KbuxEE0gW5Ta9q+KQ+zHNKr6vU+893q4XPXqJMCiCe/30YcuDkzXuRXOMCKLO43ii0+
         ecMIm1dIEBDxbjC6rjJrW9GD4fcUbpCFlGt/cx4LHtK4rJviUagbAmXoxn9JqEG01yVc
         5s6OWW7Bv05KPZlUl4fl0Bo3WvbQuPEBcjfndyVruGLq1JJPWhazKoqK5nle8Pr/KtgI
         ouPtCU1Vpq013JSI/aqbriwRGTTfxWWVjFuxtnMnoZjPeYTWenBQb+3J3+HJYbRcwTIK
         6w4A==
X-Gm-Message-State: ACgBeo1z6fz9N3aiJjA0Xs6zhGqOD1vY1Vf55YsoTUAReMiK6ZiYIWRQ
	1FY4DnFxtXK0paQ0MbRXbPI/cQ==
X-Google-Smtp-Source: AA6agR4MBVEJ8wrauAtQ76q7SlsBGMsjHuUkXJsmX0qQMM4J+5MZoeAks2bsWSO2lUtOPY5tNWbySA==
X-Received: by 2002:a17:902:b603:b0:174:8a6b:8e0d with SMTP id b3-20020a170902b60300b001748a6b8e0dmr16461501pls.105.1661909680224;
        Tue, 30 Aug 2022 18:34:40 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id r36-20020a17090a43a700b001f50e4c43c4sm202891pjg.22.2022.08.30.18.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:34:39 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/1] nvmet-tcp: Fix NULL pointer dereference during release
Date: Wed, 31 Aug 2022 09:34:01 +0800
Message-Id: <20220831013402.514055-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_183442_069444_F98ED0B8 
X-CRM114-Status: UNSURE (   6.25  )
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

v1 -> v2:
- Seperate nvmet_tcp_uninit_data_in_cmds() into nvmet_tcp_uninit_req()
  & nvmet_tcp_uninit_data_in_cmds()(free buffers only).

v1:
- Move nvmet_tcp_uninit_data_in_cmds() after nvmet_sq_destroy()

zhenwei pi (1):
  nvmet-tcp: Fix NULL pointer dereference during release

 drivers/nvme/target/tcp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
2.20.1


