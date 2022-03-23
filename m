Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A48AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UpDioZ+oNzNrosl31pLofz9rJRbnSjmbpC+h4vNhzM8=; b=UMSZ84fktwI0KhqEncIvNRfp+r
	V+B+3UsCsrcomJOUcbvxK7wuTuhDsgV5u5vH84YFF60zkniiZy+rL/wqhotKOsRxHQZ618K4n1tl6
	jR1POXckGxWS76tLVWMhzxiVMD5kStACDBUoDcCoCL3tJMvsgBqm9S6Q4AXmkr7mfTGtnTB2Ao/rq
	chgvZjk/sVRK+AHkC2cpNqEK+7XyLyIkpmcb7jKL1p8JLSRiXDhEd6nx/av5m0t64aiquKFpqvPBW
	RO9EYI64rLkRPV2PS1JIQfxc8kNTRxcApoa8y0v7hGlqZITtJKSXJeMzHHUrvDAp2Er0LU3oknDAK
	AtohbigQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX2F2-00DwiB-4V; Wed, 23 Mar 2022 14:45:40 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX2Et-00Dwfs-Mo
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 14:45:33 +0000
Received: by mail-wm1-x336.google.com with SMTP id
 bg31-20020a05600c3c9f00b00381590dbb33so1052214wmb.3
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UpDioZ+oNzNrosl31pLofz9rJRbnSjmbpC+h4vNhzM8=;
 b=Dn/Gx3CKGLXyXQeCmbcWoLYATcVMLXuaZM/ZNuzKS6neMHSUgvwk9hoIoxzKtURAya
 wXYgCwvtYiOq4zx6H5sQSsmPvllkW3gy4Y+q2/fIJ8p8AtLUldtReCRhka6FLMFI72tb
 EZes75paY3YdNxrdFPN/5Tag+3FkHj8+e0XM3D1/l17KNG+7FKKZRkdwqQzI1b35BMr6
 WJSU/MTYkKniyfhD+t28u3KeH48UhgN2IZdTB/PIBxr7OcS97yMtAzllTADvKJjhsyTI
 O2ydxAwPSMJwlc5VRfEIwqAzqZKw6rSS2JheT4KN9rWAEYjsD/fZHB7PZJhhRzubSUbp
 Xb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UpDioZ+oNzNrosl31pLofz9rJRbnSjmbpC+h4vNhzM8=;
 b=qvMbD/WC8uuvtAlvYDEIKXgOipjbWCMRxYkBkhDka5LDRKKIgvdx63oTJH/8JXNgEY
 AHYizBN4K/E9WYT2B8n2HPLMYX9kdLX84RwJ8scljYjtk/K5S3e2Bn58JG2QkBmRbdVJ
 iMsAFi09vUTejDJpVd7+3GQIEn1nbhoe6jGV8E+LJlAT8O83QkrlVHV8LOUrIun0abQz
 Ede3Ntdtsz99O2z0ZYCvCzFDKvs3ltWH3m77tq9Q9aeMSWo4IKbvrdTIQmAPWXfvBRYG
 YWqBnU91/SE9BIfVbzOtB8xDLGJc9VVThvrT45puYgWM4K4yFZYunId2PC7QBjjXCynB
 9UKw==
X-Gm-Message-State: AOAM5338UkwAMmGWEseumNWXPnGpYMz1f92DhobKa/GA5gOVyvjT5COj
 jz8UOQXJnqiRzob4TUWXt86EC6FAvZINyg==
X-Google-Smtp-Source: ABdhPJzPTr5sMcoRAplmlTJ+5/2SbHFYX415MZOAT59Tfe889VSCVmtT3Dunvi5wvcqx8BiYMrJ7Gw==
X-Received: by 2002:a05:600c:358f:b0:38c:c046:caef with SMTP id
 p15-20020a05600c358f00b0038cc046caefmr5550256wmq.202.1648046726672; 
 Wed, 23 Mar 2022 07:45:26 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 c12-20020a05600c0a4c00b00381141f4967sm132736wmq.35.2022.03.23.07.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 07:45:25 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: ushankar@purestorage.com,
	Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v3 0/1] nvme/mpath: fix hang when disk goes live over reconnect
Date: Wed, 23 Mar 2022 08:45:03 -0600
Message-Id: <20220323144504.1557518-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323035551.1524128-2-anton@lightbitslabs.com>
References: <20220323035551.1524128-2-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_074531_802938_1B504DDF 
X-CRM114-Status: UNSURE (   9.74  )
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

Fixed cosmetics.
Added a comment in nvme_update_ns_ana_state()
explaining the condition for nvme_mpath_set_live() call.

Anton Eidelman (1):
  nvme/mpath: fix hang when disk goes live over reconnect

 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 23 +++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.25.1


