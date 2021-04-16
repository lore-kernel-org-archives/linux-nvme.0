Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2149C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:07:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6A461166
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6A461166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zlvr1pJbnGPUicvd1jOCQcJ74N86yBDNz/sVLoqpRLo=; b=VuE4YAVPzLiDuGi2cggk9mKDT4
	5WTAYHOp45L4lWj7JNYFr6ZXPrKSagrIvmgTuxUkSl4oTEjUgGIMZOZs/uJoCKGuWyozgWVxHV0yE
	XohjT2SYZj7fHY+ELBQeT5mjQhvyrmWutIUOh4ecZoaB3UHnnvcaEBgHJXEhAXkCWZsh3ZXbHeDqZ
	Dern/sfkXKc797mdP1vU/xXXAYMyt2C95BKtJBhtibIP1OjLNn0MzbIqtrDwYfwJc6Cq2SWm390AC
	j4QPqg/wSDz+r05cY8QJWq9jvtmzDUgZesSsdLUcPh93rVGTNkLMnMzb926/1LA4J0LGw0PyqujDE
	BeaxZJxA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXWby-003XBy-Vj; Fri, 16 Apr 2021 22:06:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWbt-003XB2-SC
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 22:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=5dEer/ScS348Ta3IIzvxNKGHxZsJi4C+9EcorIShKM0=; b=UnobEsa2NqmiimsCfd+3UgIMI7
 L3dKc5pKRnoxoCE9GnjDTtLgaUDM9NptxBhjtm9rkS0mBp+cVBf/hsznCz2HJPcf4ZXJQ6s+2VTKb
 JGQM0JObnufviZZgLYA1eTAVC+rKCR1adMdOd1EbyxeKsKHvlXPLi0PwmyNkmpsFMxT9AjagfL/Ax
 F+UBHlck030B1OGyY7irTrqe8nIROLcb7me65fouMrApOO7yzIXPfqHNUldp2NIDdXwyCFWguj54f
 1gajFeomf3SyNRu744YVkpLz/Cz4zDMpVHIPvtWZE+cBglUsefZ7+mzuJ+pM4tmCn3aa5XArmfTJR
 O37O/WDQ==;
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWbo-009jjR-C0
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 22:06:44 +0000
Received: by mail-qv1-xf35.google.com with SMTP id gv2so4909395qvb.8
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=5dEer/ScS348Ta3IIzvxNKGHxZsJi4C+9EcorIShKM0=;
 b=nyFa7IvXiqDvwly2bpZMkafgCMzcO32+N4BPhbsIuWm9ruCVSzlZWLROZnwWET4CAL
 ECZomGiSlac6NPG9+dZucLHZ980vSMullN1NqF9C4HXaa/3Sg0NSIH9n/NT2tDDwuseF
 v3EIYfE5Ne86/kHWlxcHWI24lsRvLdmcdkE5ywmAW2mG2UT5KMjux3LEWiwKnSKzaprr
 wr1pmcuZXHC79eSqMZQrw9E3dRRrbkejs8004DchF8Rgbv2JtGekpl7iaXyxfVm8mAhs
 ThZ1bvahDFG3FMtOw7V+4WOZ4bDZGCVJbanhnJqGvrHBPqTmcleOEtc4Aom+LAZeonFF
 tKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=5dEer/ScS348Ta3IIzvxNKGHxZsJi4C+9EcorIShKM0=;
 b=cYDFEsDMJOTO1ippcRgVFQHgZXwc+YJaiFg8ijwh8TNhPyReedjr3NFnA8VksmqByG
 TNYAuXoSmjSGwkGaByvObAZKRYF561cUr3+I1e60fFytH2OMi/Vd2h7qGGkI0RXiHRSQ
 sYK5cF4qHGhncFzV5mG7+uoWTpXsHm1hQBmiT/g4P2RRSUvReHVV4alrIOzacT1QrURD
 7/kVqhfRmqmrcUCAl/zIv0Qo+go4WElDnQ1b34gr4hpKjcZZEM8KK7ai7Y559ejvXFQq
 koeiLEAnS9zd6O3Tt7holq594JkGPphMLNyCI3Ef/r6Z6JDJnoLmlS9ntMztpNuGUm9B
 YL9Q==
X-Gm-Message-State: AOAM530igI6DYqN7BAU9pKYfQBf2GL/If94SwqR3nIj4UZs0ulqlhgmR
 XTyhj5l19eVPMXo/hpk3LHE=
X-Google-Smtp-Source: ABdhPJwAD0B61FY0UKoYI7aZDzQ/jj3rFrz2wC2REHwr118+lfy9HJi6828NPN0YBM+uyBKehKvZAQ==
X-Received: by 2002:a0c:e286:: with SMTP id r6mr10668696qvl.26.1618610799177; 
 Fri, 16 Apr 2021 15:06:39 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id c27sm5098619qko.71.2021.04.16.15.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 15:06:38 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/4] nvme: improve error handling and ana_state to work
 well with dm-multipath
Date: Fri, 16 Apr 2021 18:06:33 -0400
Message-Id: <20210416220637.41111-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_150640_451373_89A59E17 
X-CRM114-Status: GOOD (  10.39  )
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

This patchset reflects changes needed to make NVMe error handling and
ANA state updates work well with dm-multipath (which always sets
REQ_FAILFAST_TRANSPORT).

RHEL8 has been carrying an older ~5.9 based version of this patchset
(since RHEL8.3, August 2020).

RHEL9 is coming, would really prefer that these changes land upstream
rather than carry them within RHEL.

All review/feedback welcome.

Thanks,
Mike

v2 -> v3:
- Added Reviewed-by tags to BLK_STS_DO_NOT_RETRY patch.
- Eliminated __nvme_end_req() and added code comment to
  nvme_failup_req() in FAILUP handling patch.

Chao Leng (1):
  nvme: allow local retry for requests with REQ_FAILFAST_TRANSPORT set

Mike Snitzer (3):
  nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
  nvme: introduce FAILUP handling for REQ_FAILFAST_TRANSPORT
  nvme: decouple basic ANA log page re-read support from native
    multipathing

 drivers/nvme/host/core.c      | 42 +++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c | 16 +++++++++++-----
 drivers/nvme/host/nvme.h      |  4 ++++
 include/linux/blk_types.h     |  8 ++++++++
 4 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.15.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
