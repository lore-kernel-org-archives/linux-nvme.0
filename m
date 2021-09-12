Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19FCC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:55:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7241E6103D
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7241E6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ry/qP9EB9DxAtF8KLFWbh6ZXwJyjMLWT2PNKUT86lvk=; b=A5bMPuvgkgbMGy
	fzAzK5AVLWXTzSlQyYHzN3VS1Q9eaqesL6V1Ap/CeHUGBDyPf6FvJ6NPMozTE+YV9wVcqMgGmcbPe
	HdDa4oCFSdVI3sMRTexVM4XlN/lfwOpPWMbNbH1PEIJW+D9I4qAD4tqlWbj7Zy3JhJgiy9pc4516n
	rShFxWIsFG8dK5Ncw5dZ10ZEzig7X467L+2stgJdi0FkMcZqy2OJTBr/o6EKa8NC4+nNERrBA7Wfb
	zCpSeBkOnvILPcisTerj9qptnHQA8/lxzpUTrc690TLdKnYeX352VmRhwL4ZbwO6gpGls/BVURW8f
	OOJVeUW7Hrk5jXroKjsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPUdN-00Gxqe-QO; Sun, 12 Sep 2021 18:55:21 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPUdK-00GxoZ-QM
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 18:55:20 +0000
Received: by mail-wm1-x32b.google.com with SMTP id s24so5039984wmh.4
 for <linux-nvme@lists.infradead.org>; Sun, 12 Sep 2021 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xQzwQ/gTfieNR9+w0G6GkX7uzmVoPNzanMHQu74txdY=;
 b=IrWuk0U9i91iSMTAc0Fk9I/X7pirP6XqPngqUjIP7ze9RXe26eEbjbWvPbea/vc3re
 nxi4QMutJTyiu2S4psHpZIySOv6s7AmuvvKF+4ltelFtUGwI7+LBgZEOD8O7t+OwnRJS
 WntZflN18vcFu9IW1gRccyBE/+w7zt2nijfOahybsLWhL3kvt7zQbDcJunIH/UbrdMuy
 OCXSaw8Eh8Hkhw/a/k93PScVJUOFcRzWNNYAH0n6FhjU4CoMaxWcTg8bQzGCsy0vB7sv
 xJ1b96XJcVEP0fjUNTkI6Ot/5D6f8qdTiMDUMqYCcO3pNXQJwc8eo+jb/mDiNmWssjwM
 U9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xQzwQ/gTfieNR9+w0G6GkX7uzmVoPNzanMHQu74txdY=;
 b=T0iyIEDuepa5/DkbyTSslZ42xPzdwaKsFKv1tG5+DSHs4qbAvrN+nJF/WL//m4DDc7
 PpwGMgbLKr89cHpAhZY/MVJH7qXb6qRMXr+QXR4qybk0RN6oPMvl69rmtUG0oLm0CR0Y
 ZNvMXxA6Zu3nu49bYJp+6Ri/ujDCoqei4VbEqMWZ+L92b8AoAKCtnsGF+TKKwA8m2ygn
 YyKd958nfBvY8R2yPI/qWAHYTu4G9DIiUALUE0IK73Dgzy3U/A1oWb/SYtrrbXcPgva1
 DPdPBZ6cJ2Dcxcvk1T/OcLg8XtgpgDJD+L7Hj0XxZpuyzdbrlaInnVF3XWVvxXvKFIi1
 tV5g==
X-Gm-Message-State: AOAM532Ijji1LoOVQbne8/dxxB1nr4tR9RZifqJYywstO/ab/N7X3kks
 1HJISusypVjGzVFIVwsckdiFY3iyo6DYVA==
X-Google-Smtp-Source: ABdhPJzMf4eXRmPOg0RAvH6g1jGM+1tjjNImwpvf9/6zxbXr9+O0n6vgXXYHDz8bnFtsbmfYMRfhvQ==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr7669657wml.109.1631472913781; 
 Sun, 12 Sep 2021 11:55:13 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id s15sm5196974wrb.22.2021.09.12.11.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 11:55:13 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH RESEND 0/3] nvme/mpath: fix missed namespaces in ana state
 update
Date: Sun, 12 Sep 2021 12:54:56 -0600
Message-Id: <20210912185459.13496-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210912_115518_928327_655BAC25 
X-CRM114-Status: UNSURE (   8.61  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fixed two issues in nvme_update_ana_state() that caused ana_work
to miss existing namespaces and consequently a failure to update
the namespace ANA state based on the ANA log page.

1) A plain bug: we skipped an nsid in desc->nsids in a certain
   combination of nsids present and nsids reports in the ANA log,
   and failed to match this nsid to an existing namespace.
2) Unhandled situation when scan_work appended new namespaces to
   ctrl->namespaces and did not sort the list yet.
   In such transient state ana_work would fail to match nsids
   to those new namespaces.

Both issues potentially caused some namespaces to get stuck
in an incorrect ANA state, e.g. to never become live.

Anton Eidelman (3):
  nvme/multipath: fix failure to update ns ana state
  nvme/multipath: cosmetic: keep ns nsid locally
  nvme/multipath: fix stale ana state for namespaces just added by scan
    work

 drivers/nvme/host/multipath.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
