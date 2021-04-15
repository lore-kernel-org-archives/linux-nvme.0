Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE4C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EA3610FC
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EA3610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WsXKSxeIjgVUiZiGz6vtit1/5iTbN3mUcm6icsjFZbs=; b=dl4LIUa9GYfunn4M2ty3hxFm+I
	WARMQGkrjtK41D9jDnCFqCy9NnLZQHb/+AoPX/8Srvkhm/u7VlHaA8Uu1YJ/AZ3sMbQqGbpP800tq
	1/Ig+iRWdb9tDzbYc5tta+0qEwBmG5E1xasF6Ep0s5GPWqTbyOF6Ei8m39ObZ5TIpjz5PEi+WeLy8
	WGJJBEt+s417nB6jHsAp8d8l49ZuEzokhWQYcoR/QlCkOYhn0QilFbI/ObsJjZfcr7CQBLeHsOBW+
	wBxy+XwhOLRttO5sRyodRaPMxWr4OtHamFWDB8lnw+3H1ti+2AMcORLqJAQbk9z7NAYZlUspUi/N3
	dlWQM3jQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXBD6-0002hY-CW; Thu, 15 Apr 2021 23:15:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBCy-0002fk-3r
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 23:15:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=A2s2OPIGot51QKltNpTIuUg2YDwX1FQEhuCnxgRK/jE=; b=qwl9NqBRxraMqLyX5Tw4NE/Kpv
 YAKHDHH8yZOR7NiNiEPND2IDdGMoAaB0WxR54Ua7VD9B/+KCCh89CcnmEtFin9bPCTrd4CrsjLYan
 bS5XlDJLUYvVSLI2W3EK7+tV8coULlR+uQp9xLh9d0c503wXnaLMbw0VB8eEdBaBa+Kc402hN5esh
 II29XNuHqdYfj+FBqQ/xVUue1mpBWPVJ2uEaOu8kJ5dxeNmxy5fciY5m0b/O4X5q4f2xWAb37h3Am
 uhcLbfj+/fxInt4ziJhC0n+P1WTh+pRgqaGsLUuvRgr6B3FDeoPql1dBzuGsrQIgzgAXlt1sofJSd
 rpUA389Q==;
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBCv-008xub-Hy
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 23:15:34 +0000
Received: by mail-qt1-x831.google.com with SMTP id y12so19550195qtx.11
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=A2s2OPIGot51QKltNpTIuUg2YDwX1FQEhuCnxgRK/jE=;
 b=uW2CDH33NH/4zz5ntTk7aMqjkleJZLBlea4NFuebMro2OdQo5SDOxqJjXWpYCD4DGi
 A8VgdmLYIDDf9Xxvc5sN9QnqWSNkec4JReEnbJ0IGcDMp86ri1FHitV9khS1CZBOV986
 CSIoQCSvI7NqCKBxQK22R3ebHgBslXZwbtVrE1d/sZAfkThzUEGSd3bbYW3qdReccLj0
 v1vg3yqHKSnrRcTI9AYCOf5RW9UVqrbHyytI2DSqaOM+QJi0+DwN634DOE45YJGY1clW
 tUhe1YaAeTwy9uP8I39JUzQTxRlBnoBUWMKmt+ql9ipSP6bhY8TdGPx32Md/IVg4b3Sy
 fBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=A2s2OPIGot51QKltNpTIuUg2YDwX1FQEhuCnxgRK/jE=;
 b=MeSzSJUbELA//kj31rirvthSxeAXxLIOuhiXqOFBsRp9Qa0p3XME5HOwdBJ73Ufoc2
 LJ5aOpx81MLTVmPX0A7xBLEzU58DLCJoe1rvg1cCuA4yx4HstpkVDbUnxBq19zqzODPs
 nxhHZ7nhj4pALAgD7SPKlXcRTCkiS6CFbTO5IWH8jVlH1jleBLbQoJirYDvGbq2r0W3w
 SZ6mtJ70eu5hnw3ho2SGStUIiesVLOaz+IS7a9rxQ6a8HyQFMq9PIbkNmaYeVE/4PFfW
 knA76pCLD2pAQyKa5xOfu3pwNIkuM/pwq5frL4aDjZP9mLtAOyhdutseB6ML/1ZHBcZf
 5bnA==
X-Gm-Message-State: AOAM532Za5z0gS0n4kKn80BOhVIcPqOg3A3ZuKAEnHGBUqE6NtRHtgNS
 j9p6W+jHVT4dP6P9goJ66eM=
X-Google-Smtp-Source: ABdhPJwAgbtdrrcWaDUhxSmioFl2dV0taaSqWO02nP0rl5pOrMokGKWTzXuEaUGSdiGHrWDedY0uGg==
X-Received: by 2002:ac8:7f53:: with SMTP id g19mr5286316qtk.249.1618528531955; 
 Thu, 15 Apr 2021 16:15:31 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id v127sm3099344qkh.37.2021.04.15.16.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 16:15:31 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/4] nvme: improve error handling and ana_state to work
 well with dm-multipath
Date: Thu, 15 Apr 2021 19:15:26 -0400
Message-Id: <20210415231530.95464-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_161533_612791_EBACF8A1 
X-CRM114-Status: GOOD (  10.78  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

I just rebased and tweaked these 4 patches ontop of v5.12-rc7.

Been carrying an older ~5.9 based version in RHEL8 (since RHEL8.3,
August 2020; yes the patchset I just mistakenly emailed instead of
this patchset):
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=nvme-error-handling-fixes/for-5.9

RHEL9 is coming, would really prefer that these changes land upstream
rather than carry them within RHEL.

All review/feedback welcome.

Thanks,
Mike

Chao Leng (1):
  nvme: allow local retry for requests with REQ_FAILFAST_TRANSPORT set

Mike Snitzer (3):
  nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
  nvme: introduce FAILUP handling for REQ_FAILFAST_TRANSPORT
  nvme: decouple basic ANA log page re-read support from native multipathing

 drivers/nvme/host/core.c      | 45 +++++++++++++++++++++++++++++++++++++------
 drivers/nvme/host/multipath.c | 16 ++++++++++-----
 drivers/nvme/host/nvme.h      |  4 ++++
 include/linux/blk_types.h     |  8 ++++++++
 4 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.15.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
