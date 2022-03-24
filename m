Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D2DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 00:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=44RShZxgn9paT7MjAHFRskXBhHC6HZN40UXAt/ajQ1Q=; b=xijztrWVwrbewyyVMQwby0OILx
	40aR7OVJlzQQLKHwKbbEDU+RuPi+Xd4EXjfc+abUpSTpY3bQZKsLeA9AlyUzhDkMXZ53SAI0dbC2x
	y6X8DTgfFs0DarZBhGq+j8BVLu1oImkwHvU4LdF3tCp81SCXEbVwsm6Q6GDNeSeouYCTKWG9ZTUhY
	nvwyUjPtf6CKxUGDhJuKjGnwrNronwbXr0t28yB8K03zLM4QJB7wEvfb/vCaRA8YrIiyvjWaohfCN
	S/H+ZC1ZWvNsfz7J+BdOmtST5xX/5oXw+GOp2J8p0tuSUFoIcBy9+14eFPqClLbsDu3PQR5JMsdH5
	MiE4NSfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXBVg-00FDcI-Ou; Thu, 24 Mar 2022 00:39:28 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXBVe-00FDbs-57
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 00:39:27 +0000
Received: by mail-wm1-x32e.google.com with SMTP id
 bi13-20020a05600c3d8d00b0038c2c33d8f3so6345665wmb.4
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 17:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=44RShZxgn9paT7MjAHFRskXBhHC6HZN40UXAt/ajQ1Q=;
 b=L7g9idyKW+GLYPE2Lp0kOYOAz11UiQJKwuHFe9m8wNGs/CLwvxsAwVrEzFa/gch7UH
 R9pXFR6Yd6mcI3OHhk8wm6izPa/6dvsfBNN4iW+AhO0FDuEfLU2EP797lPYoV6z+iQfV
 AEyrAzANEdH0E4DzzoGZW/QdjSOduhCPvJ/N6IZ2HippDpt5qvbU+/oWYqCz/au+oqW9
 Aq+LUJHxKTwzbAM/+QfrfEh1dVdajX0PhndiG/rLYarg0vpQKtU2tHPmGHy1iwd36NIK
 +DIsTM8y1pobYV0gVRhEV1Umq3QUn4wgF22M7FBFum1wcrStcbmy8ZFY2CNY4sR9hdTc
 H2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=44RShZxgn9paT7MjAHFRskXBhHC6HZN40UXAt/ajQ1Q=;
 b=GFasypq27cDwJOI1xFSNErSWdstBfllS3GQT5M5xkxQbMmeUxqdXGR5aY0oV3x6686
 ttT3sLj4nl7D5Eq2cqoT1LhA70YjW6kMyK/XRW1imMmMzJ1lsx4oa7h/NqKxXhR9m3h7
 a5vuRd9fJZwlQtvhIA1nntCCG8py0t8QrQO3Dg1ngJrIX3kKfqU8MS5Sc+nt/j5cYO3T
 XfQQyrrcm7+toL4cLo111c2QFDoqyc9lnff/4sjEnCTfm32cJ8gFvDmYPgfQdAw1sQVl
 lxV0PduydfhPxJ79eOGSlGpxS82CnhQMjHfVQRu/VGnZLNBOf0fnt68iqek2Ykow98Et
 UREw==
X-Gm-Message-State: AOAM533zb//XSRL6/h1lShbRa+w3rOIoMaPWJWdPCCJ4NQnBPcswWCaq
 X27Y93nR24yfgrUwlr2bvSQM8CWL7BQe8A==
X-Google-Smtp-Source: ABdhPJztJ5oSN8CtmD+c6FhO0Nkf3BG896gFtRGiLozTxnzRaA52RMlwfZeJTq1whx30PaOM1iDPgA==
X-Received: by 2002:a05:600c:4ece:b0:38c:7938:d73c with SMTP id
 g14-20020a05600c4ece00b0038c7938d73cmr11953584wmq.165.1648082364488; 
 Wed, 23 Mar 2022 17:39:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 n8-20020a5d5988000000b00203d5f1f3e4sm1187937wri.105.2022.03.23.17.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 17:39:24 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v3 0/2] Fix issues with nvme_mpath_update
Date: Wed, 23 Mar 2022 18:38:58 -0600
Message-Id: <20220324003900.1589124-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324003008.1588225-3-anton@lightbitslabs.com>
References: <20220324003008.1588225-3-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_173926_215450_D55ED7EA 
X-CRM114-Status: GOOD (  10.47  )
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

My recent commit d50c992edf10
("nvme-multipath: fix hang when disk goes live over reconnect")
introduced two issues:
1) Build error with CONFIG_NVME_MULTIPATH=n
   - missing "static inline" for the nvme_mpath_update() stub.
2) Crash when CONFIG_NVME_MULTIPATH=y but
   either multipath is off or the ctrl is not ANA-enabled.

Fixing both - sorry for inconvenience.

Anton Eidelman (2):
  nvme: fix build error: nvme_mpath_update stub without static
  nvme/mpath: fix crash in nvme_mpath_update for non-ana ctrl

 drivers/nvme/host/multipath.c | 10 ++++++----
 drivers/nvme/host/nvme.h      |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.25.1


