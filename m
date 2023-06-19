Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DC9EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jun 2023 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=06274/MKlEDOqu59DpYS0GkSe3aI8dxRiJv5kGl6QYk=; b=BRf4uMjornwlfykfUs0TwnnfCI
	OXxznddhFyrtu+oonS2oN00NNFuwy3QqNRFnDB/cMGaUh8QhB+v5SekkLhNdPCqO3uwpHjS/BG3zU
	0N4gx3vWinzACczfjgPNyU/5XVosVOVy3TjM5D99nT093KFLrAZADPhhR2oHXJptm4gzziMWJa0ZX
	6RG1xBFGJTGeS/OugBWr+5GG6xrO/PBp5Kb3HiC1rvwR29Wje1reIERD1ZBz27bHH26WUJcQIrej3
	phRtvalP0HmpgoUWsKpYRUaPy7J8xirrKhOO+ZBJIjrbzaXt9Az3NjKPky138tG0ntWkvANkLdDRO
	hjunvokw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBFae-008cPg-07;
	Mon, 19 Jun 2023 14:10:44 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBFab-008cPA-1Z
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jun 2023 14:10:43 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f14e14dc00so776158e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 19 Jun 2023 07:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687183838; x=1689775838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06274/MKlEDOqu59DpYS0GkSe3aI8dxRiJv5kGl6QYk=;
        b=awbicdkaFrOjZBVed5RFG9sKbB6YgzDLAXYhv0q9NLkcWVigZnEwZnQkuwApbc7hBU
         yjsL79VYSYlGouDJE3ptuy20uuKH7s+RB01pBtn5bZ70YPrTy6cdSQ/phbePKhhq2nob
         TSz13bBGtoFN62/mA8+OFyUEKtkjCzJ8Mon99XcCWuH6k8Q10tOq4VSttRO1oIxmzpWX
         bPejGqJEtRY0vCS1to0dQmAgabsGUj6k6XhAn9I9Kmmg7nJMOT7PZFHedit8p2JNZJ39
         gIq98t4bozVbTzw0IswI+UtMiVhR7a0UtVh8FjxWoH6TrRf+2tlhW6MVeiPZySZs9QF9
         D+4g==
X-Gm-Message-State: AC+VfDwf1YhfTFkL/vD+ZiO2nFUIAVe4x6zjExBp5G0hVqjtxVvYOZt4
	fPER7v8FVETS4+9okGQDe6/lwLo5J9A=
X-Google-Smtp-Source: ACHHUZ4e6yViLoWaMnfDv8b2WJretrurgfHMjIkQTSn9EgXGU8Qah/7nRsBJXwF/yX0ptbjNnN99zw==
X-Received: by 2002:a19:741a:0:b0:4f8:5293:be12 with SMTP id v26-20020a19741a000000b004f85293be12mr4052807lfe.1.1687183838352;
        Mon, 19 Jun 2023 07:10:38 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003f7361ca753sm10699561wmq.24.2023.06.19.07.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:10:37 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme-mpath: fix I/O failure with EAGAIN when failing over I/O
Date: Mon, 19 Jun 2023 17:10:36 +0300
Message-Id: <20230619141036.1051673-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_071041_525174_A897AE5C 
X-CRM114-Status: GOOD (  12.93  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

It is possible that the next available path we failover to, happens to
be frozen (for example if it is during connection establishment). If
the original I/O was set with NOWAIT, this cause the I/O to unnecessarily
fail because the request queue cannot be entered, hence the I/O fails with
EAGAIN.

The NOWAIT restriction that was originally set for the I/O is no longer
relevant or needed because this is the nvme requeue context. Hence we
clear the REQ_NOWAIT flag when failing over I/O.

This fix a simple test case of nvme controller reset during I/O when the
multipath device that has only a single path and I/O fails with "Resource
temporarily unavailable" errno. Note that this reproduces with io_uring
which by default sets IOCB_NOWAIT by default.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2bc159a318ff..6425e6ec3932 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -102,6 +102,7 @@ void nvme_failover_req(struct request *req)
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	for (bio = req->bio; bio; bio = bio->bi_next) {
 		bio_set_dev(bio, ns->head->disk->part0);
+		bio->bi_opf &= ~REQ_NOWAIT;
 		if (bio->bi_opf & REQ_POLLED) {
 			bio->bi_opf &= ~REQ_POLLED;
 			bio->bi_cookie = BLK_QC_T_NONE;
-- 
2.40.1


