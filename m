Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FCBC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 01:08:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8A96103D
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 01:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A8A96103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mn3oVq8m7syhra8O/UX7FVqZZhba8/CN482Pr9KyjYA=; b=v2Cp30odrwO6i/
	3C+3ezcEFdx1+/3dUzyjOA6JC+i5g6hylugdJxvErB6xD22m1oD9SC6r2yK166QPMBKi+Qwp2MCBI
	DCyaA/CMrLZAlE+BvXggDaOfllzF9aH6YhGiwDK7uLNnzzp1O0Itj2cxkjRBeA///wCEd9Q9zYo2P
	sh8f1gRLMn5+tyuYl108Jr0JHgZPivMFHZahi1W0e5nDOHQEdaiDXsG/d3VoBMYTLrcDdbOxLSQbZ
	aRoLTYEkBZod3RqitKA4NsHZA0jJaR/HChSiUhiQ3YHRSESAG/6Rzstszs287WyzZAXa1uQ0AVqRi
	u+ZdN/DCM4DjsugQ9ajQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPDyp-00FehC-9i; Sun, 12 Sep 2021 01:08:23 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPDyR-00FegV-4D
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 01:08:00 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 140so503745wma.0
 for <linux-nvme@lists.infradead.org>; Sat, 11 Sep 2021 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=sq3kszhcJ7GulhDO645kJoY2/8g0PLQWg8KCDdfJocM=;
 b=1wc61D2a3kmea/CxSIGXetgbAhFnGDZ93fULjy7UbRTjVgWaJKFQaIzM5ZdJCnhM/+
 dNTcNx+0BNFqBf6ITswF6LZq0Atym51UHESR8bwPyWRjdWVj+fu2H8iM+f8GDVFUnfUR
 ByY6IWxGg3q8JaI7y6PcxqU6iROyNUenjhZOc58GfQwCuN46TysOjLNQcA+HAYpo4Gkc
 y7WCiC+EO7j+yVTsBt/lEAL2pvyO+SWO96DIqfeFmxuwDgG5ZSYJ+xAvPHO1fNGUETZy
 Ak3O1t/mIV9jOhMRYuc6QoEC+4asJJG6Da24jPLain+IgyrKLecfazlkBUHT1VazRsSm
 mcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=sq3kszhcJ7GulhDO645kJoY2/8g0PLQWg8KCDdfJocM=;
 b=Ps+L6pkKSsbPVkFZmcYk2DQUMtjpyz2SAlaBO/UCtarVlxjvxaeRiCD2p7vFTeEtLF
 Iy7rvREuvCWH1ZLOKSVkirX8m3TGJATSXAt+heoCSCV070IrgpcbkhySyx1nLv4JbUJv
 D0vQdqrlOOc6Kt+E0p5f7wCJNNxsmkmtP3i4lblrHqn5BfXITlMYf3ddqN6ZvEqB6HBk
 Jdl7zndSLasUjpDaGJBC9gqUZhiRFV6VikVWyDjpgAGYBmx3/LfkY57teT8Y/+pd6Rh6
 fhmPkb2Gz0tYgmOE/DXgO6uuR0A758eWE1CnsAIWRpeLUbx4Ucvbwx+Ylx42KSHqcLjh
 +Vng==
X-Gm-Message-State: AOAM5328+Q6U1diFJeUBsIvBiPCX6uNKacZlmPV2+OE92mCliyzAutGo
 Zt6APWOIQjZVFG6x9oUy4usVXaH3VRDS+rJvkLsYnhJBcGTBHSrlIgNPZhMNA43FiVTaLMpRcB2
 TU6uSE7KQRgwkhDMMJecEy6R/wRmw
X-Google-Smtp-Source: ABdhPJycrC1JAS0gcJcZoDtrGQm532CbG5v3JwgHdUpvIXl3eXTYSlkLh1Di7Ggi7IigeyeR2RbeIQ==
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr1408180wme.104.1631408875683; 
 Sat, 11 Sep 2021 18:07:55 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id h18sm3128922wrb.33.2021.09.11.18.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Sep 2021 18:07:55 -0700 (PDT)
From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH 0/3] nvme/mpath: fix missed namespaces in ana state update
Date: Sat, 11 Sep 2021 19:07:28 -0600
Message-Id: <20210912010731.471859-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210911_180759_440973_DDDFB4CC 
X-CRM114-Status: UNSURE (   8.33  )
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


-- 


*Lightbits Labs**
*Lead the cloud-native data center
transformation by 
delivering *scalable *and *efficient *software
defined storage that is 
*easy *to consume.



*This message is sent in confidence for the addressee 
only.  It
may contain legally privileged information. The contents are not 
to be
disclosed to anyone other than the addressee. Unauthorized recipients 
are
requested to preserve this confidentiality, advise the sender 
immediately of
any error in transmission and delete the email from their 
systems.*


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
