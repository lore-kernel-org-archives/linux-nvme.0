Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D34C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/M+0t7qyPEIZpu1vh48kE+VhJYP8uk3RTn6MeP9UVg4=; b=0cadn8fhrtAP/DsweaDdRfecyz
	Y3oX06y4j2m0C+PGmynPbenoFm/2GXjzxTKEKBgC9lqWNV8wW9A4z5lt/DmKst94gr7KU5X0VE5bH
	DzRvmkFENtgRIQWG6UVGKdrh0mqjV2SNlSV0ZFNNwFfhQQMXdqll/qUXqN3gHHnCcRkVOevy0ywU7
	qFoDBxLaRPLRpm3ecQBfIb/Le5mCzrczm9PawlQEwr+7yNSWmfrV9GgUk7lYIzAPTsBr9iVE3AmPJ
	hVeZt2PNJxeGAWmyAvuc+FiWjpPK6yKEd4K0fZL+1yAEr15gMeYNd1E1gPcG2T5QviPU6RckKW4BV
	uNsUL3Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc3h-00APUg-6C; Wed, 09 Nov 2022 03:47:25 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc13-00AOPx-U3
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:43 +0000
Received: by mail-pf1-f180.google.com with SMTP id d10so15553817pfh.6
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M+0t7qyPEIZpu1vh48kE+VhJYP8uk3RTn6MeP9UVg4=;
        b=nY4zYDJcHZ3uQSOyF012oKcI6axcvsBEWl17O74Vi06c/rP2I2nEI3X3ykugzZK4Ys
         1hR8IB2GfY4qs8fzqeBym3JUMpZ82cHOtiTqfaD9Z2wofw4BGl7uG2Qj+Ipn6cchrf4H
         qqVGtCB2GSLZZGXbwejUG2zq39IF3UW21euLJMGtC8lYW/N+ox1Xei4pegQ/W7a3KL0S
         ZkNAEqXXxLsWMuH3GQdBRryjxT/Ce+TCyWJ4NtABoMLvmOCuPkT6PLZlTWo40KX45YWK
         po/7OGumQrBvCx9AthjXXSGAaNUoZ+dBvhZgdSuWa2rQphBOPF41uHmB+MpZZe4Qer51
         pWCg==
X-Gm-Message-State: ACrzQf11gvkHu64vvCgQCMOioHVGrCys9ZBYh+0yZL/pR9ftGZEuCdrq
	DlwKlRIixoOtZJKLfMl0+aSuC9ymYugFeFSp
X-Google-Smtp-Source: AMsMyM5CwWBLsMyJJdvLtVG7gPTyHFOr/2X4nNGB8ixDmXItDJjk/O8UXRy1eGtpG/vwVmTusCODVQ==
X-Received: by 2002:a05:6a00:1152:b0:56c:dd9c:da94 with SMTP id b18-20020a056a00115200b0056cdd9cda94mr59309890pfm.66.1667965480621;
        Tue, 08 Nov 2022 19:44:40 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:40 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 13/16] nvme-auth: remove redundant auth_work flush
Date: Wed,  9 Nov 2022 05:44:16 +0200
Message-Id: <20221109034420.1000086-14-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194441_981730_0ACFE1D3 
X-CRM114-Status: GOOD (  12.42  )
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

only ctrl deletion calls nvme_auth_free, which was stopped prior in the
teardown stage, so there is no possibility that it should ever run when
nvme_auth_free is called.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index b78e0df54f6c..0159179c2455 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -988,10 +988,8 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 	struct nvme_dhchap_queue_context *chap;
 	int i;
 
-	nvme_foreach_dhchap(i, chap, ctrl) {
-		flush_work(&chap->auth_work);
+	nvme_foreach_dhchap(i, chap, ctrl)
 		nvme_auth_free_dhchap(chap);
-	}
 	if (ctrl->host_key) {
 		nvme_auth_free_key(ctrl->host_key);
 		ctrl->host_key = NULL;
-- 
2.34.1


