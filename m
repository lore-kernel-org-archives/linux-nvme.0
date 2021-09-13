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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7823C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:43:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2AA60F6F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D2AA60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7RCXB4gBjD2Nhc5fmkZufhPtB9o3niip+kQSo4NrPoc=; b=Apo70+jK1GM8l5
	1GC3j35IUFPIyfvEa6FDJN+2PdwSlMepPDeHAGDhI4Q/QgkF5UrI2ZQvdMViB25Ss5jMGMMCG/Xq6
	Qx6+QSCeL9sb1WqAIwO1UqlLN0kTcFhGcXljNI7PkCp6Z89uMGtjx4pgUEg1h+x7rDBA1LVlVAelG
	clX48BewyRtrxzojs3AGAQes5fXfSOlc8WOJGdD+Oyu0vXHcxhPLlwZnycHH3yG1ADXd4PEdIPHxt
	v6Q1Qy+98NmisGTWHJ8I4PZ4O3TSrk3VQEDjPQ+nU03TDO7ZjCEWplYWTUriQUCij61iIcOi+vwiy
	Gh5k8405USBpZY9648pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPo6i-002E81-Os; Mon, 13 Sep 2021 15:42:56 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPo6f-002E62-19
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 15:42:54 +0000
Received: by mail-wm1-x32d.google.com with SMTP id
 196-20020a1c04cd000000b002fa489ffe1fso7333225wme.4
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pvax5Hm/Pi2xUSMwPDmp3iqHCMBX0FSY9wUlw2OOtqQ=;
 b=Y6N42uVA012r3Lhr5r35O6TygDsMfZBUI70OvDponwr7DK3h672wLIj8tidKtCRczW
 +Q2vs90fZC0fyi+CezxezWv0NicevB7psDid8P0iKdiosOS96cv2B+I29N6yvrXPYKUK
 wtxymbL14mZK1SvA0dFyLNsTq/Dz8b5VdVB8zdfFyQ6f2BWw8bxdFuem1RW+lpUi7pX4
 hnHOmp6nWFEkEIMfaNOiujyM1ylIBQyWcccW9s4YvgQIzK5yGkW9DwdvERdxdnxNNovw
 fyUZbAprvi/vlQQV88Hbf/EpdApdM1AUPIncvr01LcbXZWL3rzjcxQMVOFhyGbGjxGvD
 qiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pvax5Hm/Pi2xUSMwPDmp3iqHCMBX0FSY9wUlw2OOtqQ=;
 b=gsYB8emTPpwDyBdc6YlaYrsXGFgLsr6iohyNJX4pYKBdLINFPqWPd8at+EjAziBVnQ
 WPql6bpL+fEErBWWbMGi2ZZXCJzBnKxdVI+uFi57yg1PxEeTwmpbVzV58v7aHU1OmQcb
 4KnuaMG6+AogKbs//cWNsorlJEpzppBskVOSn605qKqI+4d5s+expPB5UXxD39qnvdYG
 rdB83KhEjpvTfZ184AdoeUckysrXuOyHccLP1t4/1ZoMu/A3skffcrCUQszFmGkgPNS+
 HICrnAiHm4b48H1gHCgLGOi2esWjXz7pEE0ZHd6w0BRKiNIbm3bvsRWbtOajPQFNz95Z
 8Gow==
X-Gm-Message-State: AOAM533yBFfGnubLUjd8nzitf6sAvMENROrMgeQyl4bSTN4tUqMIE6dE
 hAx9nnRQy6JMWIVy2BL1nt1TLHyR/+BIoQ==
X-Google-Smtp-Source: ABdhPJyTU0fI3ncE8zgsaCyVlr6ztQweSROC/YilYoONFXM2axwDUtlrOB172OU1HpmT5g50A3GhKg==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr1611629wme.51.1631547763923; 
 Mon, 13 Sep 2021 08:42:43 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id f23sm6277201wmc.3.2021.09.13.08.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 08:42:43 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v2 0/3] nvme/mpath: fix missed namespaces in ana state update
 FIXED
Date: Mon, 13 Sep 2021 09:42:29 -0600
Message-Id: <20210913154229.71757-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913153023.70879-1-anton@lightbitslabs.com>
References: <20210913153023.70879-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_084253_111716_3485689D 
X-CRM114-Status: GOOD (  10.11  )
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

CHANGES FROM V1:
- 3/3: last_ns_nsid was not updated in every iteration, which is wrong

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
