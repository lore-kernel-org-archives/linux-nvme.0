Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF79C04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+H3MeZp+MI6XxdAGA/bZY80AkTJ8EbXu6/6bWjmEDBo=; b=AqGP8XVbQFPUyPCsPXtk2fz1Xp
	mqIu4Ms888OMr4Aw8tFe1Fh0mY4iK1/86GqASiC2DDbSjyjZGoRpPxKKGlp22lley1hehrtTAzzL4
	7zelBBxcLU8cNe2HwCKeY4swKgCXSaPOOXEe8dO8vhoFIk8sMkTxzyfRsu91qqaUwjchlO4R17D+r
	Nys8tYBTdjYCX8PkZB6Fk88mzBhRi/g3TBuSPIbEmtLom93Af2i8o9u9axU+jbQ2Ef/X5NCEcr1rL
	GtqWOrBTytohc7EygdV67LnYHKb4f5UQiBwSLKl9D83SLA19xLcmMuJUbtTbiEeakKeJtFTHH9HQZ
	tN1gZAUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDU-005WeI-IK; Tue, 25 Oct 2022 13:43:40 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDS-005Wd9-NE
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 13:43:39 +0000
Received: by mail-wr1-f42.google.com with SMTP id bs21so5206338wrb.4
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 06:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+H3MeZp+MI6XxdAGA/bZY80AkTJ8EbXu6/6bWjmEDBo=;
        b=U7Q7POYIuJQS13RIswDlyCAwKfCyNK9jOipDkTNADiam/OqV+bRHdJhlwfG3zdZIYL
         /Im4PsCFSPB1KgiYuf3041rQ9May996XfigIwE/Ic12UqGcpZPcYSTzBQkjJq/SYDsDf
         2QqMuC9A1qEDUJsPkMtODnWiUkkAAm+ntCR8WvXNBRdy53fW0qqRpdVuyDyLV9K5DkYM
         Pdb6CN0NJVh9RiHj11+5c2ABPJ5Rye4djbvOzhVzgqJEtEiViNcSJkzy1hzC+WHf5YnL
         7h0cg3dZQu5jbSyDSshExY4htVZR65p7mF43de5GerKQs5LC50bCBk1ukLHD2/YEf6BX
         z5Cw==
X-Gm-Message-State: ACrzQf0smLwNRDRN9zQfRyXiuLvTumRcms3REBTM5m37I82JFeNE9V7g
	B02vFECRLvkrj/wNNOfSyjlxGTS9i3Q=
X-Google-Smtp-Source: AMsMyM6Em8gx1GEpDddgdKZKLDf03sIYxIvapVrrp7KrccOcrVFV6gPp81cMXr9O0U39ppL1stHtCw==
X-Received: by 2002:a05:600c:4e52:b0:3ce:3f91:70b9 with SMTP id e18-20020a05600c4e5200b003ce3f9170b9mr8000423wmq.131.1666705414467;
        Tue, 25 Oct 2022 06:43:34 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6c1686b10sm11442239wmq.7.2022.10.25.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 06:43:33 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/6] nvme: a few nvme-auth fixes found during code browsing
Date: Tue, 25 Oct 2022 16:43:24 +0300
Message-Id: <20221025134330.1028352-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_064338_775683_671D7887 
X-CRM114-Status: UNSURE (   8.92  )
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

Sagi Grimberg (6):
  nvme-auth: rename __nvme_auth_[reset|free] to
    nvme_auth[reset|free]_dhchap
  nvme-auth: remove symbol export from nvme_auth_reset
  nvme-auth: don't re-authenticate if the controller is not LIVE
  nvme-auth: remove redundant buffer deallocations
  nvme-auth: don't ignore key generation failures when initializing ctrl
    keys
  nvme-auth: don't override ctrl keys before validation

 drivers/nvme/host/auth.c | 41 +++++++++++++++++++++++++---------------
 drivers/nvme/host/core.c | 16 +++++++++++++---
 drivers/nvme/host/nvme.h |  2 +-
 3 files changed, 40 insertions(+), 19 deletions(-)

-- 
2.34.1


