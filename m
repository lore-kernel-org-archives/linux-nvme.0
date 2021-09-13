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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2E9C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F6D60E97
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35F6D60E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ry/qP9EB9DxAtF8KLFWbh6ZXwJyjMLWT2PNKUT86lvk=; b=T/MmBJDeIOSJIr
	zo/++2nwXIDjguaVyjFPyxPvetWG4mjVHSg4VdCsT9PeDwvss5wPAthWWxPLzD7QJjYtWFfHeikwb
	bpXNO48Wa+HtTY8B8MFnNn32o+aXsFhNHKeYS2cUGiPJlz7Uvi3E73xeV6xpYQ3HsrruwNN7ufEmi
	7qPqPkkvn6QQI4zz9OeHNQ2wi9mu5Z55rwI5+lyHGjsG1KyItFiUoUt7CzPgGtDy5hlSkmUzMsQkS
	Hevfth6Ta4Wp5qBa49o59GFYMPwKKaZHPIRjFIngqZtrs2LSG5/b6MjyfLz8UeMb6ipWfgnQ6x67g
	jsuEzNha+LA1Kn9r5hyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPnvC-002AvS-PJ; Mon, 13 Sep 2021 15:31:02 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPnvA-002Aut-2q
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 15:31:01 +0000
Received: by mail-wm1-x329.google.com with SMTP id
 k5-20020a05600c1c8500b002f76c42214bso7304342wms.3
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xQzwQ/gTfieNR9+w0G6GkX7uzmVoPNzanMHQu74txdY=;
 b=RMHDrhcz7/u6sWZ28UVInHjg5WUU68c2YF50olXfqhzm52Xrt1lra2gmgxHUsxWBYC
 6fvwmxBT5kDFuNljw/eWh3gz+JJEQmNW3su8jFhWc3xVZ0RIq3tMT6c89YvG0mBYOHX9
 k+YZHLHQ3n64jaPMK+Q3WlE1Dg/Dl1rL9CNtrjfA0xOacFVsI8MeEMr5thwN4E+OtvDy
 W6q/rEfMMuEfiynvt30qoc8/P2YqPqb/j2nomroFpauoZxEkm1R9kHxt2ZUnj7wsIThT
 Sj6whLwjsF23IV3bss0w9HPELeE7fUw3+9zsv8D08L5fhM06vmqTkhYPKvHYgb+Ky22F
 n9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xQzwQ/gTfieNR9+w0G6GkX7uzmVoPNzanMHQu74txdY=;
 b=XF19v5NbWAdwkLoHJGZTtQEeqPwQU8ZQE8Dx6rZZWCxy+/XfTUYsULgsPBtAPhfQZL
 UMAztSgOP8JQ5brAkv6er6zW84Ml1LMm8NxOsHEi0k16MVz+RpcWSaVaGpZGZQ7c9OO9
 Xr9fHKsZ98mhaB8ncVeUttPyhr6vdvH7P6/UoW+QXBA54Xm/kvqrkFRdPEVK/qyQrVcD
 sxDdLqICOrusWDH/U5nqAz/zAkPNeqv86r0z/bvfagT1H6sjV0kiVSiY2TIu60WokUwk
 IS0su339lNMrwUY99rA5lfjHrZQAsv2llr6jjyRlxg6VM4qbpKgZ0jB8SNdJ+s61cUnX
 appg==
X-Gm-Message-State: AOAM530opUPYFvOulFGsHgSiLBx1UwRxz83xy9h0ndG0IS9JmelrkKXM
 yJjFQST4JwCCr7wIPizW+QoC2O6x5w5l+g==
X-Google-Smtp-Source: ABdhPJw+1J95M6ZqtmTa6DojLSG46hHC4uuBzLNdNJmpRJ9r8JuB43+RxLTr23Cf3VaEgoTZVTUGHA==
X-Received: by 2002:a05:600c:4991:: with SMTP id
 h17mr10739058wmp.74.1631547054800; 
 Mon, 13 Sep 2021 08:30:54 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id h8sm7054087wmb.35.2021.09.13.08.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 08:30:54 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v2 0/3] nvme/mpath: fix missed namespaces in ana state update
Date: Mon, 13 Sep 2021 09:30:20 -0600
Message-Id: <20210913153023.70879-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912185459.13496-4-anton@lightbitslabs.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_083100_172843_BF442992 
X-CRM114-Status: UNSURE (   9.83  )
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
