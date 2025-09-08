Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23915CA1016
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 20:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Df/RlYe2zyL6hL7qtwVMZLPpooVeeegBlHDBmIT0lI=; b=LU9qZzbOVocpBWd8vq2KJm6jBZ
	4wDLyzRN7ai3baup4+n7iAfr6yrx1sahTebNQ0/dAElP9mfVqV9vi2dJvMh39nbC6EPq0ksoohLCD
	CpqW5ilYKItN11ObikGN9z8Y4AZ7TM2huzkkmCf1butTcn7rMr22RBea5SLm/rFqzTNRqJ41BusUV
	K9I1cWTSRjqRWizMZcMRIn01ZlWKnuNSRVc4jLgKbFR9cGWel2cXadQhMsv60dBRMKJua8W6/gxAS
	kgFYYIB+xScwNgFHIZotIodPMg+7nsQmd8FiMk9A0uvgYNxuWO4C/a+yV0yZ1BXEgwF/jpjQSxOgn
	ytNVb43w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvirp-00000002JMC-4Bz6;
	Mon, 08 Sep 2025 20:53:38 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvfcP-00000001Bm4-3O5A
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 17:25:30 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-32b70820360so3599240a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 08 Sep 2025 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757352328; x=1757957128; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Df/RlYe2zyL6hL7qtwVMZLPpooVeeegBlHDBmIT0lI=;
        b=Fvux3lJH4yiuenhkM6U37z1OJg9G8ToFXcpf6RZDZf6imivkMzD5uBqCWjhUaKQKp4
         JeGTr6MYQS6De4ZfUtBpszeaBaEhV9lyTbChKcUWGjbpqMoNcbTEbjs8Zrb5OpgzYawm
         MIUJedBLNm73AkVdsTe0qDdaRbFaw2x8PRn2SgVG0qHYuYS1YBR4Krohh9wtbDhnQ1z8
         D2cX7a0dDEzQ2dshvB69onFSGKb7myB70X02pUoRrEX3IyYpvse8VPEzafJdMn75Di08
         eg9dNZQqZ07Q1lfHBa7+YM0RzuxYJ9wQA8vzcWPx77/yK0D0mKIfLAssRdI9sXYi92zo
         JegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352328; x=1757957128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Df/RlYe2zyL6hL7qtwVMZLPpooVeeegBlHDBmIT0lI=;
        b=CkP+66VM2Hih0afXPPGYid7nqBDfdp586SNZgysPCPH8d+t9OimPORHII0yx6Tvo8J
         bLFm0/WF/tYuzYO6Xq7eWtvo9OABshg6lPMoSVpKGFP+fDEiSJlR4S6o7QB2Y9sLOMCa
         WPRe3F2QvotFg6bwSqwMiSU2sAOjOQVV8/RpMk6AvhgT+aRuxi4+ovyeJ+yhdtmtp1fw
         J0fAtoMXvuCDbJDrndbyvRJdZ8xLx/sozutjP7uHivmfH3/1UwhPJuzeS4X2XO6ADxuY
         rN58ClRQ7zTz6LqOMY6wRG4scT6V9D5ZBWjQA65ou31yuD1/nQrGhCmRHivnBCj9o6Pc
         P5fA==
X-Gm-Message-State: AOJu0YylBuILaVHtOZpSzYVI+gVgEUzhL03zGToFrgm7AWsnljohjOsC
	NdsIJBHbshRL+nfPHjRt8HsdmD7AFXhuF+zCIwAZv26MeCFOJBAs0jMUO5GsEQ==
X-Gm-Gg: ASbGncuwbIGuFh1VBl6LkKiCud7koyxVNt/ZfqimZ3nBUJh/vAqPcmXMf/9SsyUP43e
	BeYoe5sfePxL+xGn4+2P7MzqQXayoJi4Kq8opH7nT6iPjRFfKq9hCpqZSQTNG4tQ1n6GhBY6t+g
	Dse64wFPi3kXdsdd+4oATHPb/ngjNm1vyV+inHarHtnAg0AYgtZem1oL193w6OlHfRF8e0Tw7kQ
	YtqlOfK6WREDief9W1onEKqtaRmvmGXfgbRTBllxLG3rCqpU694N7UDECJ5r8BMyMyzgE7vQk3c
	YBTjKW3mOoKa4gSY93bXG34snX+nsMG1q6qYHOsdnizQEwUflK7iZ2L1ZtKWfE+I79I4jVDWnW6
	8ESGYt/2XY/xV3ARJXgq6X2G+QRdwa2Qr2czN06LZRyne3I5qfX1keFaXYutH
X-Google-Smtp-Source: AGHT+IHz/11A3K+686C0GLLjOBSFiVdJwqkg0NxWTIIOFpjOmkjYHeqsjpyCcV/7NPR3Qyr2oLFNig==
X-Received: by 2002:a17:90b:3c08:b0:32b:94a2:b0cc with SMTP id 98e67ed59e1d1-32d43f6399cmr12577756a91.17.1757352328512;
        Mon, 08 Sep 2025 10:25:28 -0700 (PDT)
Received: from gooner.vpn.netapp.com ([223.185.133.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b617b104csm15906103a91.21.2025.09.08.10.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:25:27 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@kernel.org,
	Martin George <marting@netapp.com>,
	Prashanth Adurthi <prashana@netapp.com>
Subject: [PATCH v2] nvme-auth: update sc_c in host response
Date: Mon,  8 Sep 2025 22:54:57 +0530
Message-ID: <20250908172457.5512-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_102529_850526_F4D02B60 
X-CRM114-Status: GOOD (  13.69  )
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

The sc_c field is currently not updated in the host response to the
controller challenge leading to failures while attempting secure
channel concatenation. Fix this by adding a new sc_c variable to the
dhchap queue context structure which is appropriately set during
negotiate and then used in the host response.

Fixes: e88a7595b57f ("nvme-tcp: request secure channel concatenation")
Signed-off-by: Martin George <marting@netapp.com>
Signed-off-by: Prashanth Adurthi <prashana@netapp.com>
---
Changes in v2: set *buf to sc_c as suggested by Hannes
---
 drivers/nvme/host/auth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 201fc8809a62..c70db1bc3fda 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -36,6 +36,7 @@ struct nvme_dhchap_queue_context {
 	u8 status;
 	u8 dhgroup_id;
 	u8 hash_id;
+	u8 sc_c;
 	size_t hash_len;
 	u8 c1[64];
 	u8 c2[64];
@@ -154,6 +155,8 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	data->auth_protocol[0].dhchap.idlist[34] = NVME_AUTH_DHGROUP_6144;
 	data->auth_protocol[0].dhchap.idlist[35] = NVME_AUTH_DHGROUP_8192;
 
+	chap->sc_c = data->sc_c;
+
 	return size;
 }
 
@@ -488,7 +491,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	ret = crypto_shash_update(shash, buf, 2);
 	if (ret)
 		goto out;
-	memset(buf, 0, sizeof(buf));
+	*buf = chap->sc_c;
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
@@ -499,6 +502,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 				  strlen(ctrl->opts->host->nqn));
 	if (ret)
 		goto out;
+	memset(buf, 0, sizeof(buf));
 	ret = crypto_shash_update(shash, buf, 1);
 	if (ret)
 		goto out;
-- 
2.43.0


