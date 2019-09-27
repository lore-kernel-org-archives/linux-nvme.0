Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABE2C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:51:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AF221655
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ikMrf8s8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLs5ssQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AF221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6lVvPpr07d0YwGuZC2EelM3/D7VcQRbbq7X19RQzwng=; b=ikM
	rf8s8hOrURpTv/Gc+1tauhKFHolbjAPbiQIopsTpG18dUU6LBKynLYKudPWO1JUygjfdq5wxYiYhe
	03+zAWGrwLXwnUj4OwxEo9SB/cCnXOOeEtz4FqKKpDcH/yCwUUmCjQCiF6AAU3H/NbrUtFOaogFYw
	joOU0yp8n/DDcVrR77LZbY3qTO+vTchlPhk4D60VyLkS+CmxTczriLn3ljF/MS9+pcNCkcGHAi5fE
	l89niwXLUcrYRv0WHnfiveKpy0aWUBw3BX1Efjek/UriYsHcWGmAq1hBDOAMwkKFgiYd6aIAT+Yal
	u8+mCFupIIJ7pQ/EyXP9Wh3Q5AVoABQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDy9c-0000Ua-4s; Fri, 27 Sep 2019 21:51:56 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDy9Z-0000Sq-1H
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 21:51:54 +0000
Received: by mail-pf1-x443.google.com with SMTP id q21so2267548pfn.11
 for <linux-nvme@lists.infradead.org>; Fri, 27 Sep 2019 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=HXk3JyEATo0XKlmFbEv8C4C5nbg4hoR26SRzlSmWuaM=;
 b=SLs5ssQ/p8CazKy9JrsQFXkGt8dkcDpwHWdVFlDOk5vJq1kXSMdxE8RpemqyxDYCgu
 KkPQBbRsaEIEuHlgMww5SPF3p5PzIxUTJupfBUh8gS7ayhSgSX+RLmRhcWLzDyU9Y0kx
 iUogXKdONsO9IYdBJ58QdwCKmWogcNFLzbYFGF0AuDIgk5RJ3kMaFFgNz8rcGEZXy88t
 IWRwkxpc8WerpSq74iLTxw8eYlsR3032Vg1t5Wra26UrkFfMgmWGRiXom9fmIeksvbjZ
 2AeGvEZd6c9dtMtCk3JqFAqSTMH6wenGAIU6LJ9IgvVKuPkfm4ACxnvA4fDuN76VWsCV
 uAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HXk3JyEATo0XKlmFbEv8C4C5nbg4hoR26SRzlSmWuaM=;
 b=CJpwkKBao5RDoboOVcei3j37CzqF9vn0skVwc2YynUNmLVBwZx1zNoRmF74AL7bpld
 QhOdj7xX3uBtwYKGzfP5T4krPYz4xpqtH/bxZbVqTBJ7NNW0ZebEqZlb/ZRcbfxr929A
 mxUioI4EAYvzTUnvL1wUKxIhEat1c8k90vA1VJ2X0SCtBfrY0jI8ofPBkc9mRMOmVQN+
 uIcmckQyHwOYLVSj7KkNiELc1i83sQbMt1gqLlRTzR/sgQlEVYZ4VrZMHSvbpnuwLc/4
 s6Wt8ChqlDLTtyB3K64y+4Ro2xntuptL2n2fPy9aTqGu7xiXp9svvqGORz/G9lsNrRmJ
 m8/Q==
X-Gm-Message-State: APjAAAU3HwR6JIjIPcn+fIx1wVzUMk1il6zpNKcL+V6Z2eNliBcn0KVt
 NQvLT/s0gNI3OcoECSuLmbt5a7Fy
X-Google-Smtp-Source: APXvYqxvzjHeXhWL/zPA6AhWL2ymtXa8y6Q+0ia7g1Ak30KmmBoaqZkWdObygFku4Q18LcIPmk/kgQ==
X-Received: by 2002:a63:7153:: with SMTP id b19mr11385577pgn.10.1569621112266; 
 Fri, 27 Sep 2019 14:51:52 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id g5sm3430507pfh.133.2019.09.27.14.51.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 27 Sep 2019 14:51:51 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] nvme-fc: sync with FC-NVME-2 standard
Date: Fri, 27 Sep 2019 14:51:33 -0700
Message-Id: <20190927215136.3096-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_145153_080409_9C01DA51 
X-CRM114-Status: UNSURE (   9.52  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following 3 patches start the sync up with FC-NVME-2 rev 1.06.

The first patch updates the nvme-fc.h header to match the spec
The second patch updates the existing transport to match the
  header - where field names may have changed.
The last patch updates the CMD IU for a new "category" field that
  identifies the command set type for the io - needed by analyzer
  guys to decode the sqe.

Subsequent patches will be coming to add new behavioral changes.
Older implementations should continue to work fine, with new
behaviors enabling new features.

James Smart (3):
  nvme-fc: Sync nvme-fc header to FC-NVME-2
  nvme-fc and nvmet-fc: sync with FC-NVME-2 header changes
  nvme-fc: Set new cmd set indicator in nvme-fc cmnd iu

 drivers/nvme/host/fc.c   |  29 ++++----
 drivers/nvme/target/fc.c |  27 +++----
 include/linux/nvme-fc.h  | 182 +++++++++++++++++++++++++++++++++++------------
 3 files changed, 168 insertions(+), 70 deletions(-)

-- 
2.13.7


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
