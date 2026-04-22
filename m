Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAEEF9EDDB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hiBSh9UVHfb7q7y+ZwAruwcuUvfFGPdcOc0TeqXNA9s=; b=F8LhnmudUws+GE1GUGUdMLRRM0
	dMr9jlc2/B8j97wCg9mtO5LLX6uPmVwiyNCLciP5hR+st/G+fp59tGcNmqQmzp6TrHGypLcpxtlKe
	/rtMzwsxq5gE+avNnLZbVGTLXYZxFODBXfqta+NfjPlPJ7VnASMIrMN7zZauBOYwv5NKxaIOUUt/t
	dVUiU1PQ0iySEZ9/K0sqLOi2FWLuhxQgRCzSD00S0Mj7vP1SfHnhWedAsUtK+QpCf0Q8wNmbxSCKQ
	zY1VCEEKyloZj98kOQX4Rpkes1IEj9U++6etoGdq/rVuAHvrMhaNjusdoW2xPGObawtuWsKGbrVMd
	NKC1lcnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFYJI-0000000ALIj-3Gd0;
	Wed, 22 Apr 2026 14:12:12 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFYJB-0000000ALHt-3zt8
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 14:12:12 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-82f2766905fso2515777b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Apr 2026 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776867125; x=1777471925; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hiBSh9UVHfb7q7y+ZwAruwcuUvfFGPdcOc0TeqXNA9s=;
        b=TviiMQHAKsu+meTMiIyYqTJUWqCEedtCK6ENxY864TjdDQY0DAPNPFujEkPcXYbQa6
         KFOF+aHiP0bVoBk4NOWMHoAUluyaKcqQU889sZXcKyh1VvoKNBTWhSyK+4QfWDq4Yv8N
         rVmUZFyH6kR/Nmhus+xO/NtY90OYoeOmqhlere+yNCJpPzZTcCNRgxD6WKlCFf5frA2g
         DYeJQjsqqE/tF7Oroa5hAZ87WegjdEVUlZmp/1VdmUuE0+gRnaqHOl+aw53KaitMfK09
         NicGN7oqwnYP7iXHmRW7stbY4gg4J8FNV0pSwTbkVw/QTRukp8uEPshOEl9+egHY0C/R
         Yf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867125; x=1777471925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiBSh9UVHfb7q7y+ZwAruwcuUvfFGPdcOc0TeqXNA9s=;
        b=A7KywMj+x1BS3DWll98KFD7H/Hac5R/hMod+8lXQce9KHcNGKpajlIwTguJeCGwxya
         FxG4xvov+5/q11+oPPhDYgeim74oTJSI/u++EI6VuOZoC1+4JQSKw+DEyV1heyokgTH5
         NbbpEiJs5+9Vo6TrAoTkNe8iCGaBRBgstGUIYcFzLz0HDB3WAIM9SQMRKiPjrx+JlWZB
         9OnClUAlHBFznQgWg4IQdbRPJhk4VcGPXFFKkdod8/bRoEMZByo+nE+08D0RbzNOZPoe
         tXpAVBhJ0vzuTSi8/x2djkekv4rOziwcxYxyIZ12RS6dXy8DjI/XjCrjErcDrGnvZRsQ
         5g7w==
X-Gm-Message-State: AOJu0YwLvEew8vl1SnvrLWgjRbmJCAJ+E/UJrSivjrAM9fiVzW4kI3Hh
	z0om8vTARDOWu1avB6EuTfeWlt1qFTM/6URF/Mbgp6ZlzSTFfuVwNcc6
X-Gm-Gg: AeBDieugpkVtqCnuPQTX3LjqSk4Ej7u9ozX6OSpZ+al1S1i/VQe7nbre+rCNwgSDd4x
	crhGm05HDkmW0MOlsUZD5Qfgzufs+SlPFrq2KGrwoyUz5Hm9n9Pi0rs9+qD1lqwQ7nuUKeL286o
	d+v0hG5xzEtTdMXCwRFx3MFERns3bsGuRJQI49Xh/Uc6gli4wF2VYTTaQ5Asi7VFHibVophXmXL
	XBFKZn0C7BQ8vw54GFASF+dM3dnB81gfJrJHqsDx5XGaYlt3drtLMA8igbC9+/PsJLTZBMNYZb1
	4KCIX5U3e15fK8M8pQ00TAjlaLU8jyrVctQgPZGjWTAyvs7rtMBy5w2z/kZb9yn2qoHLdwA+b4b
	y/FJYOagiGNuBLuAu000jULS2kDQ13ukYXCmgOWFR14z5VO5HGM1J7divtmhx1V/8THlin7//8C
	OvUTkIvsKvo+TrhQ5ZS5awz67g57RWlZ5KfSd8/jYHXyPxnZU=
X-Received: by 2002:a05:6a00:7182:b0:82f:96ab:e011 with SMTP id d2e1a72fcca58-82f96abe402mr16129099b3a.37.1776867124628;
        Wed, 22 Apr 2026 07:12:04 -0700 (PDT)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:5cdd:bd85:7f37:6252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec24850sm17974824b3a.60.2026.04.22.07.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:12:03 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2 0/2] scan_work improvement
Date: Wed, 22 Apr 2026 23:11:46 +0900
Message-ID: <20260422141159.10881-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_071206_022253_CE81899F 
X-CRM114-Status: UNSURE (   9.64  )
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

By the scan_work ns_list is scanned then updated to latest NS state.
For the ns_attach and ns_mgmt commands ns_list update needed always.
Then initialize known effects to set ns_mgmt NCC and ns_attach NIC.

Tokunori Ikegami (2):
  nvme: delete unnecessary empty lines
  nvme: initialize known effects to set ns_mgmt NCC and ns_attach NIC

 drivers/nvme/host/apple.c | 3 +--
 drivers/nvme/host/core.c  | 9 ++++-----
 drivers/nvme/host/ioctl.c | 1 -
 3 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.51.0


