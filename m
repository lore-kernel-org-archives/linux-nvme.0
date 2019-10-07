Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A6C47404
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 17:49:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AAE206C0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 17:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="spLrsqxY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd4Tb+2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AAE206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2v0Ym3U2XVpmE1QpAnjaSlfK7bWPgXlMc0TKol0xq44=; b=spLrsqxYABP5jp
	04Sgn3bYy09wfb1RKyaLUshYlU5vmswsNaz0BlwnG+6OltsTmW7IcM/DF9Yn64uoFie5kdHdSi+LH
	0IxpY0IJLPifCVcjVSx4sHokSGq2SZyCvRrxzDXgYz7nYqXrltSaYh79FU1fRPnTm9j4YtpqDCmU1
	NAN3H7mhdW/iTvg1GLDtS1pv9bWnzC3AVlrt1q+rpwXPRHQ/M8YPpko1PUPSNViVJruL3Qyyr2Rjc
	h1XdpETvjB1lZRZmrm8NtrW4hl9zdELKMTliExSc9EKrEIpJfqCJx7TWx5S7kVuwNfyzNRFWkmPqj
	yCVxt3CJb8dMgx2njvEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHX8r-00046k-Bq; Mon, 07 Oct 2019 17:49:53 +0000
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHX8o-00045Y-BF
 for linux-nvme@lists.infradead.org; Mon, 07 Oct 2019 17:49:51 +0000
Received: by mail-yb1-xb42.google.com with SMTP id z125so4972540ybc.4
 for <linux-nvme@lists.infradead.org>; Mon, 07 Oct 2019 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mnR5MVeSfmkd08lK4ffzp778Oq2vekAUBJq9yoLn9b8=;
 b=fd4Tb+2Yp/pikdXybI5knLc615UbbMcFORwSgAlrnFG/eDG4sPuvSRJw6ihE9x13tv
 MCxS27PkjSZZ10iGcnsF7h/xa9qyEpaPkKsguH31LrpEF4ZVzZ65eoGm3jFLCRJBvLdx
 oVIub0eY1AhumoEIAHWD1oUsTjN1q5QziIpL1JO2sd1s9EdctkIWfrs7gPcYmHNUGnTa
 GcX6MKhboEQnREOtpkV5O89UWHklnVnDFqalyP+l7/aEX6w+LPB8aKAm9qxeNEMk6kHA
 afdP66atY7coWxujzKxu+iVe8mnTCfnTFZYvNnpk+rgbOBDeym2S+FFIinxjnbDPtTkg
 mPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mnR5MVeSfmkd08lK4ffzp778Oq2vekAUBJq9yoLn9b8=;
 b=fQru15kHvUy/98AYjYFdtoQdVEJUGxD62ZTGy3M5YeCdOu4Z/QaqUCXJQgUZwGIqTy
 tLAfkhnQJeMGwxe9RaC+VyB52pnej58Cx50nT1IpDvw4W2BobqTVGxaee3otKQy7Z6yw
 3yB4A32MS8I0eTktZj+xa3GND6p22i0aARlTG3pFuxit8hBl3W+Df1osOijNan9VIise
 Ba3sMTSAZXZhJaUOMi+cY2rPHjDkaocwJrJiOCMjUe2jPnLTs2/VoNtuFb7I3tl1LaWf
 2RQf8I4RMvybVvYUEvX11I7E+lVORZPscoIJhiOTUM93mZpWPiGavaXzD4BRPc79AwWl
 GkFg==
X-Gm-Message-State: APjAAAUm/xx9P0kZy5n2ULSxBvlDV5ji9xbpZ5XjkKSU/CehlcNEUWsa
 8bdjQZYoGWmMsy48ZsSTr2Y=
X-Google-Smtp-Source: APXvYqxa63PHzkGDflW2kegP8uwWWr/EiK668PHw+cW+ACIsZPGXXEZNwb3D/sLMNFHngR0b/npSDw==
X-Received: by 2002:a25:7506:: with SMTP id q6mr10435190ybc.25.1570470588791; 
 Mon, 07 Oct 2019 10:49:48 -0700 (PDT)
Received: from Serenity.nc.rr.com
 (cpe-2606-A000-1125-4300-3224-32FF-FE82-DC91.dyn6.twc.com.
 [2606:a000:1125:4300:3224:32ff:fe82:dc91])
 by smtp.gmail.com with ESMTPSA id v204sm3943455ywb.23.2019.10.07.10.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 10:49:48 -0700 (PDT)
From: Tyler Ramer <tyaramer@gmail.com>
To: tyaramer@gmail.com
Subject: [PATCH v2] nvme-pci: Shutdown when removing dead controller
Date: Mon,  7 Oct 2019 13:50:11 -0400
Message-Id: <20191007175011.6753-1-tyaramer@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007154448.GA3818@C02WT3WMHTD6>
References: <20191007154448.GA3818@C02WT3WMHTD6>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_104950_390924_88B0BBAC 
X-CRM114-Status: GOOD (  12.29  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Shutdown the controller when nvme_remove_dead_controller is
reached.

If nvme_remove_dead_controller() is called, the controller won't
be comming back online, so we should shut it down rather than just
disabling.

Remove nvme_kill_queues() as nvme_dev_remove() will take care of
unquiescing queues.

Signed-off-by: Tyler Ramer <tyaramer@gmail.com>

---

Changes since v1:
    * Clean up commit message
    * Remove nvme_kill_queues()
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0808f9eb8ab..68d5fb880d80 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2509,8 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 {
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
-	nvme_kill_queues(&dev->ctrl);
+	nvme_dev_disable(dev, true);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
-- 
2.23.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
