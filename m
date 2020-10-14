Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59E2C433E7
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 03:37:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0CF215A4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 03:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RhC2tnox";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="n8SdhhiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0CF215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k/WMbTTSjT3xEK3YxS9jbFwf+4fGiwVDwdWaQjX92hw=; b=RhC2tnoxepyrqC5dj7D0SsAZAv
	VDg3Uh1D5vIIBRjBBb5po1n3ejRYY4sJcka2Mt7LjrSbE43hLtoeHMD/bigsaGhflXf3XUsZC8JuK
	ySHPyPzT5BXQ5aRC6dL6M01JZnArXu8msV+mbivVq1Vm2Of9xSAh+m3q382T/3BCbmS9omXsTYmaU
	mQy0Irwg/ozZgIKk8LFuKkXJerINwtMBHvp9H0JPSVizQyWseyvSOcI7s+sifZx1UlNGJQAVkcWVa
	kq35UFKuBZgL58g++euFtyzWz2BVo85ryicJPsuRr+GSKAYNGfF1F62FInCA7KX+XV/Efwl4HNsR8
	WFDGldSg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSXbB-0002Jn-Ev; Wed, 14 Oct 2020 03:37:09 +0000
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSXb6-0002J9-VC
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 03:37:08 +0000
Received: by mail-pj1-x1043.google.com with SMTP id j8so805477pjy.5
 for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2020 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=5Ynua4zlOw/dc9Bn3pMgf022e9ahU9bnqg4Yj7JIYA0=;
 b=n8SdhhiWdJi7pLppFZCugO44YlOToQSjLhQzX1CKIJmR1YcwlYlN2RVwEip3Rb4QMI
 olpIG9tWz5xgWhH48fO2pPnNth1JG5yVokFr4kNUtKwmQHW6OHagDz3YzMvMXoCRyRGw
 +m+SUM+CHXTiHsGl0cIrYhsxJdr+BBT/t94RhoQ2fYL4U9mp8Ev2DMaB2TfcxAjsIoew
 31EI5sl1/452qlYgPXj+Qoqf99AiQ7jvRGPfMxeQVF51vUrLIjWotUkBZqU5OKqKVr9q
 mOWSx/8RmPNMiv4stlfJOek56naOioeDNfP6E5zQ67iz2p0RicqNOWdGxT/2eCJ7b7uF
 x2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5Ynua4zlOw/dc9Bn3pMgf022e9ahU9bnqg4Yj7JIYA0=;
 b=hTLFR7oLGNMQtFodvjsFYMoOqFsme5yieyDOyL7Dt9+M5RY/xYsEU222XmtbID5q8H
 P+XFhg3iQ+xvPAi2eK98pwjRLkMwhqbtkRdDCvptgYK/dMRnjDgULBf9CvNVde/oQPZ7
 Tudf4N5RYi9R1b09iKNwH/ZIqXaPo9rjxiPa0U9QIjBoCdAZ1QSUrb9Tp204hQw25e6q
 p9Yqh4/WhKH8tP0J00qkyEfFng1I9ya+HEzmruDbesxQcHMdpx5H++rmmOUy23nnbuOg
 wWdzxCVoj68prMdPS+6ezDdhxnwIbz/gN5syLkWCDBdDnYSSeOIM+vHYMkjMgOFyOVIZ
 Kdyg==
X-Gm-Message-State: AOAM5308dId8kU03YN17avG9MHtggj9mNIEBfFxOGX1vC+CkP7U51yXy
 c2OcobrgMMgiVgbsQXb7Mg2xHw==
X-Google-Smtp-Source: ABdhPJz2WbEqZy5yhIKqs728Bu4mTfOL1rUMk/g8tTGqS4SaEEYao1HuSiryoaHyAYvW9boPt4anzQ==
X-Received: by 2002:a17:90a:148:: with SMTP id
 z8mr1530873pje.173.1602646621003; 
 Tue, 13 Oct 2020 20:37:01 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id 188sm1243272pga.35.2020.10.13.20.36.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2020 20:37:00 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH v2] nvmet: fix uninitialized work for zero kato
Date: Wed, 14 Oct 2020 11:36:50 +0800
Message-Id: <20201014033650.953656-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_233705_191720_171E8905 
X-CRM114-Status: GOOD (  13.81  )
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
Cc: pizhenwei@bytedance.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hit a warning:
WARNING: CPU: 1 PID: 241 at kernel/workqueue.c:1627 __queue_delayed_work+0x6d/0x90
with trace:
  mod_delayed_work_on+0x59/0x90
  nvmet_update_cc+0xee/0x100 [nvmet]
  nvmet_execute_prop_set+0x72/0x80 [nvmet]
  nvmet_tcp_try_recv_pdu+0x2f7/0x770 [nvmet_tcp]
  nvmet_tcp_io_work+0x63f/0xb2d [nvmet_tcp]
  ...

This could be reproduced easily with a keep alive time 0:
nvme connect -t tcp -n NQN -a ADDR -s PORT --keep-alive-tmo=0

Starting an uninitialized work when initiator connects with zero
kato. Althrough keep-alive timer is disabled during allocating a ctrl
(fix in 0d3b6a8d213a), ka_work still has a chance to run
(called by nvmet_start_ctrl).

Fixes:
Don't run keep alive work with zero kato.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b7b63330b5ef..90e0c84df2af 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1126,7 +1126,8 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	 * in case a host died before it enabled the controller.  Hence, simply
 	 * reset the keep alive timer when the controller is enabled.
 	 */
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	if (ctrl->kato)
+		mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.11.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
