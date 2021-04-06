Return-Path: <SRS0=EEJI=JD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F065C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 06:49:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC01B6136A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 06:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC01B6136A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K1LTM8WGLxD+Sf5ecfwPUvwj0Hkbym0CtsWe0VHEngg=; b=UBmhA8S46F4F81NlGvRBY8a5As
	+faCm03ru5JOWeQTiUJzNRtT3zR9g2jAYbf7Az0PQ0jenFLaVHW/h+kMy1x5AhBCfAuKTwjTA61EZ
	/T3p8iiPH8yWa03M/1LLOyvEFF4/7XWt1OY/mJpH118+FIt8k/a7tN0lEz2TR6oRA7T6yp4o776a5
	P2Q9LYCJ9nepbx25JNrAnfHe75Vc7FYpINK7My7okBGsrzo2KBxRwmuXeG88Ki7H5/+iWOA/zger0
	zYRmp/0Bv9gogTy3K4by/zdl/Dqu0EDZglAXV+j0FI3p4c7tdiztJd8w164MWtwZRTWoK17hni7j/
	KZHiWjeQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTfWG-001hOo-FG; Tue, 06 Apr 2021 06:49:00 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTfWA-001hN8-Fu
 for linux-nvme@lists.infradead.org; Tue, 06 Apr 2021 06:48:57 +0000
Received: by mail-pl1-x633.google.com with SMTP id z12so2871536plb.9
 for <linux-nvme@lists.infradead.org>; Mon, 05 Apr 2021 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ljumktF83zKUoruuSVl3bIeNONWM9cuD8ONq/V2ho/8=;
 b=jW+C+QAOsdJtI31DrjqLpwHq0Mnw7NoTx2OA6IS938i6rjtkHZ+K08hzV75KWf1E6x
 eQyoa72pIlGu1QiQD8oky9JzOMp/rCB96+8HrxMv3H0dcMXYvsFHSNsFb5Xs+ofKZQqX
 cVmbEClEWjFYooPkCQHHei7mKdnb5HWlVGt9v0CiDtQQLG4gMvmlpg81PKoZayStsJyd
 l2yZHdcXWsmiOmUTfX+QY6jN8Rk+UtoIY/HjWmW9NTTkFg7NDmPh8Kk8jzoIBUIgtCNP
 QwyML7AxBoeCz5cUPmtClPHa0Q7fMMiDtR2wvS8y4DTSMbne0KacGohHnC1VcX72R5oR
 oOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ljumktF83zKUoruuSVl3bIeNONWM9cuD8ONq/V2ho/8=;
 b=nPTli/JggKKZKdcdSN9bc1C8eg+EZwk9JmTXN4TZDQU4OvifG/Hl0x7kr1mEHiSzaw
 7YNUnwgvSRIN75fhiO8yTCkszteOFl7QeXo+pNvQuI2iiMEB9wpetAo0oJHoVUUfAny5
 Ucyxz1U+x6Gl+IhgjpD5Sat5kcHJBqiHuNUKx+2I2xfQ3dMLSuEvXOsjxZOEWQNxi7nq
 GK1swmbeGL1RoxWhLV/NCOvxHYv/c4ua89tKkZcZOvHE22m/xlR8PBGMrv89jj9S0HY9
 KdJjTqDgJHaB5da9a474II7x1QRqCcTjW7rBIe9uKkL15fwbAZGgoBu/kAND5z0XWjNN
 TNUA==
X-Gm-Message-State: AOAM530myZip+dXKaJh6jyF2n3XJkadTzP9XfysAdLTtXxCLOtu3vNf5
 ZwwYr/GFhlNym4561/v78jjcOQp+ebCNBg==
X-Google-Smtp-Source: ABdhPJyK+N7Oe8p0xMWVpmzEEWnCfsY4Dus5+XO2anBn7UZveqqfVcP6RcC0/c+UU52pvwdtHY1M+w==
X-Received: by 2002:a17:902:8606:b029:e6:f01d:9b67 with SMTP id
 f6-20020a1709028606b02900e6f01d9b67mr27903576plo.83.1617691730563; 
 Mon, 05 Apr 2021 23:48:50 -0700 (PDT)
Received: from localhost.localdomain ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id k21sm17556856pfi.28.2021.04.05.23.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Apr 2021 23:48:50 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Date: Tue,  6 Apr 2021 15:48:40 +0900
Message-Id: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210406_074855_165043_02EA6E5E 
X-CRM114-Status: GOOD (  16.16  )
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

Hello,

This is the second patch series to support generic ns character device
to expose per-namespace instance to the userspace.  This version fixed
code mis-ordered reported by Kanchan.

This patch introduces per-namespace character device to I/O in case that
blkdev is not initialized properly.  Userspace applications are able to
I/O to the generic namespace chardev even there's no blkdev properly
initialized.  Because we don't allow nvme controller device to I/O with
a specified nsid, this generic device will provide a way to I/O.

This patch is derived from Javier's patch series [1].  Javier and I have
re-coded this series again and it starts with new version tag.  Changes
from the previous series are:

  - Update naming convention for the chardev exactly the same with the
    blkdev:
        /dev/nvme-generic-XcYnZ  to  /dev/nvme-generic-XnY

  - Re-consider the multipath support.  Rather than exposing all the
    path-specific namespace path with controller(e.g., nvmeXcYnZ), only
    expose head namespace instance in case of multipath.  Otherwise, it
    will expose all the blkdevs created.

[1] https://lore.kernel.org/linux-nvme/20210301192452.16770-1-javier.gonz@samsung.com/

Since V1:
  - Fix code mis-ordered issue about nvme-subsystem class destroy.
  - Fix for case !multipath, but path-specified namespaces.  Eariler, it
    just created the generic device when the ns_head is initialized, but
    even it's a same namespace and path is different, then generic
    device will be shown as usual in case of !multipath.

Minwoo Im (1):
  nvme: introduce generic per-namespace chardev

 drivers/nvme/host/core.c      | 172 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c |  17 ++++
 drivers/nvme/host/nvme.h      |  25 +++++
 3 files changed, 212 insertions(+), 2 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
