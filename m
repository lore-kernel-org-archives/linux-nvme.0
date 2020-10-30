Return-Path: <SRS0=Q5cb=EF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E48C00A89
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2020 04:31:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DB62151B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2020 04:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WD3reBXA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dmKNfUVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DB62151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0iG0IXKyyYvx1HuRlzhjEOTKM6kKKaJp6vVk1KOfFKs=; b=WD3reBXAGbNmov+Lz/TnQhAsuD
	EpDFdSjXMv6n+8gdy+5+6Z5NBoo+X9jEqY/sPwzsp88js5rqSvHhcI1LrQeBgZjmxjyNyzzJeRRLa
	Wfp6QMuM4W0nbPA3u2/91z9yys0nV7EONjZBCIp9BmvKDIlI0WS3BoGt89k07lNepFpIRDjZHhO3k
	3YxBa8V2edPxo+xknZIJZJvuvYoExJTTUuvIPp7YxeO0w1HrJNoTBTIMk1doTwi+ImlnYG6eruYIz
	8dm+OvqhTiB4WUDNoiNVbhbekBr5d4jKN3IdrQ5U4vNpFHHzJo0mKQs49qIL1La9zKRcQtwXSkd77
	Ex/dUZ8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYM4c-0001GR-3Z; Fri, 30 Oct 2020 04:31:34 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYM4Y-0001Fb-NH
 for linux-nvme@lists.infradead.org; Fri, 30 Oct 2020 04:31:31 +0000
Received: by mail-lj1-x231.google.com with SMTP id i2so5533388ljg.4
 for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2020 21:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=wuVfOJK2GABLE3L50qE4XslIKstQ2yw9BZH7ha1RNj0=;
 b=dmKNfUVyLkykN/H/tB/0ekwJxUbGULrnv3vljsPZwQ9dtbC+gBmGlUqlAQcHz9SNiq
 fBieKkrcy0MvmopcPIrj88bNysT6/B1LntrAIGgFWEjCm25dQThg6CKBKgUiCaYJzKPj
 vNEhdVRObz57auJdzYY0k40w4+npE802QcaAC9Jto4dDRolcehG+oDiNdTJy83vFp9Cq
 3mZ1kkrz1r4Yp3VIQbVvMdc08vGQCiaWr4YuDzzTXzcfwAbrpub1LlYVhcrrpytjKLm7
 So/W9CqgWicmZz3/fEv63TQk8oB4wUlQ8DtTN6vaHJ9FyrbRF4BKQgfz6Pcno6OIEnYu
 WQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=wuVfOJK2GABLE3L50qE4XslIKstQ2yw9BZH7ha1RNj0=;
 b=MrFW/72taCHCyfCw1K8cHcj6LBjgeW7uYlL6i5UjHAf7me22Jj87fZl9S+t9mTEYvs
 w4oLNfP18u96yKQDqnm7PSF5Tdh6cgLhRgSldeTyYxCxO2i0HoeQ0SZk1A9pJf/6K295
 /e2i+S0V2JPgELUFhOJqdwmydgpKpSrs0/cDVWAIJDkAZAc0OE5NrckbLeO51YTK3q6x
 IsLFk4XiUfjmIpNf1h5q73UnMKWhjF2OMLrLSq32DgmPoueKsi7yLqD9dSf9Nmb89C6c
 LJbleSTRNA9hSs0hulC7drMTaVmkNd10rQBLGm/BtbPmwwK3Xxghy5A+wfHIPoY+5lhV
 TsWA==
X-Gm-Message-State: AOAM532IT9+TnfKox5put+99tBXhITMZE194xntrHivd5oDwfJNX6tud
 MLDKitBUDcibuNTK5D9qfQ8ENLbUE989ARhnKzkHc5/viI2KdA==
X-Google-Smtp-Source: ABdhPJxQcDVMDuIz2JoQZihKTuf4MmVBNwHTfxPAE4eKvW9TJvuoGczpDfsw3A8iPZUdD45XJCWxsfZE5EetLTIDrY4=
X-Received: by 2002:a2e:7d06:: with SMTP id y6mr211118ljc.431.1604032283898;
 Thu, 29 Oct 2020 21:31:23 -0700 (PDT)
MIME-Version: 1.0
From: "B.L. Jones" <brandon.gustav@googlemail.com>
Date: Thu, 29 Oct 2020 21:31:12 -0700
Message-ID: <CA+ykBt3kGCOdupWSNNiCxQLduq8Bs_t4YN8CsUWYOOGEk884vw@mail.gmail.com>
Subject: NVME controller issue prevents boot on Kernel versions >= 5.8 on
 MacBook 7,1 (MacBook Air 2015)
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201030_003130_803663_650F0556 
X-CRM114-Status: GOOD (  19.24  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello all,

This is my first time emailing any kernel mail list so I will do my
best to furnish any information you may need regarding this.

To begin, I reported a boot issue against the kernel on the
Fedora/RedHat Bugzilla last month here:
https://bugzilla.redhat.com/show_bug.cgi?id=1878596

Essentially, booting any kernel greater than version 5.8 on my 2015
MacBook Air would cause a soft freeze, with an error stating:

[   34.890739] f-air kernel: nvme nvme0: controller is down; will
reset: CSTS=0x3, PCI_STATUS=0x10
[   34.917820] f-air kernel: nvme nvme0: detected Apple NVMe
controller, set queue depth=2 to work around controller resets

Another individual in the bugzilla thread took a look at the error
logs and identified a potential commit that may have caused the issue:

commit 54b2fcee1db041a83b52b51752dade6090cf952f
Author: Keith Busch <kbusch@kernel.org>
Date:   Mon Apr 27 11:54:46 2020 -0700

    nvme-pci: remove last_sq_tail

    The nvme driver does not have enough tags to wrap the queue, and blk-mq
    will no longer call commit_rqs() when there are no new submissions to
    notify.

    Signed-off-by: Keith Busch <kbusch@kernel.org>
    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>
===

The main/interesting hunk in this patch is as follows:

===
@@ -446,24 +445,11 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
  return 0;
 }

-/*
- * Write sq tail if we are asked to, or if the next command would wrap.
- */
-static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
+static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
 {
- if (!write_sq) {
- u16 next_tail = nvmeq->sq_tail + 1;
-
- if (next_tail == nvmeq->q_depth)
- next_tail = 0;
- if (next_tail != nvmeq->last_sq_tail)
- return;
- }
-
  if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
  nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
  writel(nvmeq->sq_tail, nvmeq->q_db);
- nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
===

I built kernel version 5.8.16 per the recommendation on the bugzilla
thread, reverting this commit: 54b2fcee1db0 ("nvme-pci: remove
last_sq_tail"), and was able to successfully boot, whereas before no
kernel version greater than 5.8 would boot.

Additionally, another user built this kernel version and packaged it
with the Fedora build service with this commit reversion. That build
also booted successfully and seemed to confirm that this commit was
causing the issue.

More detailed technical information can be found in M. Vefa Bicakci's
comment on the bugzilla thread:
https://bugzilla.redhat.com/show_bug.cgi?id=1878596#c22

It is my hope that this information can lead to a fix in a newer
kernel update for this hardware. If you require any additional
information, please let me know and I will do my best to provide what
you need (I am not quite a developer, just an enthusiastic user).


All the best,
Brandon Jones

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
