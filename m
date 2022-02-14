Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB24C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vmzb+MnX+bBJSjLWqQk9e18+22L9HaDqkvmhh2hmplE=; b=xPBuglto9gKS+HPtP6E6561nAd
	ABiWJC30XvGe7VGwbteMfysGmhIPwPr0NNekH/S+WYuSf6x5vWsoaPtDzfeXO8Aj2h1sLJfGSUxT7
	Bn1MgLa6aZadmK5ABW+G3KPCjK1qojufU2LP3F2Wp5Sdlu3wmqKkKmeB+LWbX93TUPG6Tc2Aux7N1
	nPG2tU3h520/YXguMR4HuVMaFbnPI/fxW4QY8F/TsSM36pn0YKDI2CvBf12gLkmd49zwELLmeXFDH
	lx+AoG9Lof2r6gaJUmOyWkw1Du/rCwWJkc7efKMX3G7tnHdKybk+eaM+vjtCE7ZgfcM9Qc6inJSUv
	5GQTwAyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJXRX-00EC2F-AF; Mon, 14 Feb 2022 09:14:47 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJXKa-00EAIN-UO
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:07:38 +0000
Received: by mail-wr1-f46.google.com with SMTP id p9so5100886wra.12
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 01:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vmzb+MnX+bBJSjLWqQk9e18+22L9HaDqkvmhh2hmplE=;
 b=kuaVexTOi25Ue1LDqs5YtS2EoQ7x017uLFPMB2rH4wDAFSUxhfubY1nDwhxQNlmZJO
 3B/TJ2N5lR9qx7Z3Te4wSNGy5gHVOCSJK0BT4oBicEv1atdvRm4KP4+EzHJDJV/Gat3Z
 KSiOC2jSah1sNGCeXlR8SZl3Ow06mkc7KMeWa+jh0JkrPjhzdMiI1BFc2A6kfdmQQ8sm
 I8sdy6rLMofbS8dtuudiHHDrcLjenFoJu7wwDCH9xVybXSZJj79D81bXY0Ib23s6qL40
 uiTPs/l88oGjzhLlK6m0VT4qz4TFPQAQ8Y6mTvs71RKU5gcKEM9o8F7HrWOXkqjx0S9Y
 WcAQ==
X-Gm-Message-State: AOAM530JuvgG1XoWbdYXXXIbf92HynMaThA8b9yWr6Q8asV8ffbdS2zp
 TLf/bNtntJmdXyTJXkOQHS1FEMLLcE0=
X-Google-Smtp-Source: ABdhPJxCjuKfkO7A6t6W1qgcXAQv6/ZixJalYfGXl/hyH6kmbGdvM1YjMxXIceE3FFC1yjv0+OTzYQ==
X-Received: by 2002:adf:f141:: with SMTP id y1mr10466796wro.402.1644829654166; 
 Mon, 14 Feb 2022 01:07:34 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h4sm34595498wre.0.2022.02.14.01.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Feb 2022 01:07:33 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Date: Mon, 14 Feb 2022 11:07:25 +0200
Message-Id: <20220214090732.479193-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_010737_014278_90EF9DD9 
X-CRM114-Status: UNSURE (   9.42  )
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

We have the simpler and more convenient idr_[alloc|free], use them
instead.

Sagi Grimberg (7):
  nvme-tcp: fix bogus request completion when failing to send AER
  nvme: replace ida_simple[get|remove] with the simler ida_[alloc|free]
  nvme-fc: replace ida_simple[get|remove] with the simler
    ida_[alloc|free]
  nvmet: replace ida_simple[get|remove] with the simler ida_[alloc|free]
  nvmet-fc: replace ida_simple[get|remove] with the simler
    ida_[alloc|free]
  nvmet-rdma: replace ida_simple[get|remove] with the simler
    ida_[alloc|free]
  nvmet-tcp: replace ida_simple[get|remove] with the simler
    ida_[alloc|free]

 drivers/nvme/host/core.c   | 18 +++++++++---------
 drivers/nvme/host/fc.c     | 16 ++++++++--------
 drivers/nvme/host/tcp.c    | 10 +++++++++-
 drivers/nvme/target/core.c |  4 ++--
 drivers/nvme/target/fc.c   | 12 ++++++------
 drivers/nvme/target/rdma.c |  6 +++---
 drivers/nvme/target/tcp.c  |  6 +++---
 7 files changed, 40 insertions(+), 32 deletions(-)

-- 
2.30.2


