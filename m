Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2830C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:47:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B59610D2
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65B59610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vJu2xHZKAgcZJOzLPnMReuoYfz2PHqvawdxAHZ6O3bg=; b=WCf6iPh+7zql6F
	ehbtuVHeOrnF7OhzkQR6xtVY22LfbQ5xAeQ+8SDuQtNQr1UJlqGvFH/uIbFRNM/+yxRvpSSfPAqer
	5R2E6Lj8KlT1f6kmuTU9fYb4q9safaCy5uK51eGRfqWCDjBIlLT3h+ASD+7XS7IbVTqeeWX9+1X4L
	K2VoyJt4o1xQ3nubxMwakiwKzb9NEffpAliuKk3CxQASep1NHQkvWLZ9dyDvP4a65Y1C/5S/1eK4u
	XVVLfLzDvbwa9NOQggtwfLBd3Z5Hdomln5i6MBwl+WIlC/oVxJT8fWUD8qA/MBFdVopvRUzh3mr2z
	HNuFK4ySsINl4OpVIngQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPtmt-003M9d-OM; Mon, 13 Sep 2021 21:46:51 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPtmq-003M8f-1e
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 21:46:49 +0000
Received: by mail-wr1-x434.google.com with SMTP id w29so16081230wra.8
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cEKIP9rGR3BLOwc4HmANAwfL7u25RGSWmQuejNulTuc=;
 b=bJIn1Ao8nmJiLgDeoBRC7mxQTQRnUfWp1sCcCviMSiqUgUPXN4KyfVjtWMJPF2a3+f
 4fFlVr07wZPvzPlLu0yBmk6h9LmNAu75zuFKV21354OIkObUYI8nWPNtVjgIwbJ6pGag
 rfbaivfKBtRK6OCjomZITvmuwrzuBMZZBYl3tx8xrSTfZ1ZYBdV/8HHYAK5XtwHS/4EW
 7tnzPoop6VjBdD+x+PhlfTMre2fpt1xtnGKAA/dwzKWHn86CE26p3qq6rmqC8riRPqWl
 yq5d/JnE6wOqv2g9lvt0dJXJy3e2sg8GbllvGmoryU+RgbApCI0vU8uM3kyXjCCsLX0j
 fvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cEKIP9rGR3BLOwc4HmANAwfL7u25RGSWmQuejNulTuc=;
 b=i9Oog/k3QiPgqjYiOB86EgyJIRIAMOzArUKW0nLBD6AFXV+ZN766hVEmGp5RhI01OX
 gZpZL9NM5nmwFs4veQAWBmL7MxKOHVQeJk4/c+AN2I4Ufm6cPFVSxQsrMvclGqRiM/iI
 1j+3KY23f88zY+EZ7h37ikSSI35WKcTgY5QNdAfxHG+SDkNp6dvOhINpdNnF8fxgo223
 Ps3Tpd4h9y4pCi2OKAhNHRzliK+HOWtjjoOEoiFJKJ84zJxMXl7AQ4Zhkxx4e3z2ZdQQ
 0HV2G1+Yw6RtOjlUxccINTq8NaQ85dSIQIQHuQ9o1Qh7h/ZAY1KaKKeuLrZ5+rCEEq1U
 DSHg==
X-Gm-Message-State: AOAM533oC+XFh65gihs/HjzwHCQ1WKV6FuGt4x+SK0ZL0wu3ZkeKS6s0
 izLcgQO9Zl1KGLs8DokrEdvKMCp9ScZ0cw==
X-Google-Smtp-Source: ABdhPJz2kXtaGImaNvSUfIRDD5s0kYEuJMFdQaCeoJlkA4crbHeT/pEYfMGEoMFvyjElwvx1EqZR/w==
X-Received: by 2002:adf:f24a:: with SMTP id b10mr15198046wrp.281.1631569605175; 
 Mon, 13 Sep 2021 14:46:45 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id f7sm7776194wmh.20.2021.09.13.14.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 14:46:44 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v3 0/3] nvme/mpath: fix missed namespaces in ana state update
Date: Mon, 13 Sep 2021 15:46:29 -0600
Message-Id: <20210913214632.88294-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913154229.71757-1-anton@lightbitslabs.com>
References: <20210913154229.71757-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_144648_131695_5AA48BFB 
X-CRM114-Status: GOOD (  11.32  )
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

CHANGES in V2:
- 3/3: last_ns_nsid was not updated in every iteration, which is wrong
CHANGES in V3:
- 2/3: use unsigned instead of unsigned int (ignore checkpatch on this)
- 3/3: use unsigned instead of unsigned int for last_ns_nsid

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
