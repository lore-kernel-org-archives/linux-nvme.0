Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB0CCA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 03:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oT/ykTkaSyUHTJBIc69nRGocpP4BAL4LdV9JCrnAuJE=; b=W59wXHabx4TWSvbdZrp9gWugzf
	jpMavau2fYX4IF6XPRxAOCdKO9HUXBlX3BVms8j90phRdW/ucE7W3r8kdN6Aothg1WE8RHZQP8P20
	yNjC3q4clCwEn4UPWKbENfAriuZ1zQtuSkNap77w8Hn4MZ1ZztflNN3OLi1Z5RiFnl86G4gI085KG
	tX9obtjHP8wv3HBLJtVoROAzH/SSj8rt376HKBaKGYQgZvmc61ZiCC0VEqNjBpozwtmBNlfDHqd41
	qAu5Qs/1XK8+9s7tCFkLx43imTXkuxFwRWp2EcUXLmrm3fV+Diw8d5lwtLsMCc95depC6dQjPVMc3
	UxZoG6Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utI8F-0000000F7Va-2AUb;
	Tue, 02 Sep 2025 03:56:31 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utI4D-0000000F6XA-2Hsb
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 03:52:22 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7724cacc32bso1488784b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Sep 2025 20:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756785140; x=1757389940; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oT/ykTkaSyUHTJBIc69nRGocpP4BAL4LdV9JCrnAuJE=;
        b=FhliOpEWyUfNTCyTeJBm5r/h2eg/1sDTfDd9nXimFk69xTUILnXE2fyhRiNd3DvfrU
         3d9q6eaUv4af0CR93IrG+zn08LJgNXWVoQksAgOAYOGM6tIdl8QZgei2LV0SVmNG99TO
         zotbG8s8ppoRpoPnYyaDkIX26E759+zLIU+XdXuDe88hv8Ao1B6vxMhGRs5TA+/zmTqE
         pDP2VjuB4Vv0r4e1fGxWpql560wYZo2i53qbs8mHjx5ONhJWz8Fwtgai4KIFVTdhu8Rp
         lN1t1/6niMl8Efeh4jxhFdEohsxFZBSps5ACGtvaa2xv1HIRkWv5SHL02bpJJJ3lWk8F
         YHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785140; x=1757389940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oT/ykTkaSyUHTJBIc69nRGocpP4BAL4LdV9JCrnAuJE=;
        b=PUfBDUCWZ6FOizslQ1D4zWc7r8+CEglBg6Nxp66qJ84OFI4Hus4m0oqBHRahATuzHg
         Ex1LfIHJnxrt8RN96GmGmnQn/VofDUMGgw2kuIzVHw+SKPtkBC5rUZoEdKhd/PNgu4CW
         nGb3eaVyWNnoZVopWOWIE3JPouawVdq7GgZBvwdYch8Rg0L2aL0YpQb6vsPNcqWoCPtZ
         v1CJS6M+9T807xsQCoOEQkOQwzUl2rpZ1BWUlZ1vhRm3pw51p15HXmO4WDeyf/dAq89z
         mEshqge0C48pplWu24Kcf+EGbSeTvg+0hb7T8e+79TMARNEZKLaWV6N5NaRTX0Gn3sDt
         bqpw==
X-Forwarded-Encrypted: i=1; AJvYcCXt0tNOADT3WDKUI6I0QJN07BzQeCNmH5CQgYpHSdKPahaPbxP6LQUGSNUjV4q4EavhFeySP9xhgdhj@lists.infradead.org
X-Gm-Message-State: AOJu0YwNmTWSubflwXSzlzQ2JQZ+jNG2Zbzpwvs5VyF+6le9CUG5OWgq
	vL8AzhCeqpQgcaYGPVJt/XsxUaqY4nnzs0Ef9e0rBwXyNfSnwr9wb12O
X-Gm-Gg: ASbGnctjc46cPiwM5Jrog+kKobYXo1pXYmIGwGq2mG9oCRWj1QDm7zxrWVREi6xrd4x
	OnSkZJYZWdYO5Y0wuaqWGh2fBHAE+84voeaIk2hDLfA3BME95pojTpqqs9XQ+bMIrtLV8LgFQDg
	pw8wCiaNnQuFdGP2eEJw590IQ5w6NMmK4QQgDKmQa7G9ta8+c5e+VeL3NJGeqahRc1jH2xd9HyH
	VAEb+duN1gd/T4fL6gX+lgBgh5uJ71TfhJL91pM/09zfrWY7CMtTjilX+TuP9+yoKs9TPbAui33
	kMviyV5GG8v+5Mh25DcxeiYPj0HTEmsiSOuAU0GieQBQ4keTctPc4tGax4qWJpEES5vHZAJnyaz
	u/gvj1ZqRRJUYAAJ1dYFqRyxSzTzr9Z9gSshn9bKX94FPzz0CT/jmQImGSj9g3behVyXvRVIcVP
	NZQ6t7xE9Ft17CM9gQJ86wSnhf9sZClDRu1Rij
X-Google-Smtp-Source: AGHT+IF4nNKMOTogfQaVhATVDQ1kYDItGzEhI6Zcly5AfBTAmyqokUDnZCi0a9STC10UQbgcIDQS3w==
X-Received: by 2002:a05:6a00:4612:b0:772:5487:c37c with SMTP id d2e1a72fcca58-7725487c5cdmr7681292b3a.22.1756785140306;
        Mon, 01 Sep 2025 20:52:20 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bf378sm12085276b3a.60.2025.09.01.20.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:52:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] nvme: Use non zero KATO for persistent discovery connections
Date: Tue,  2 Sep 2025 13:52:11 +1000
Message-ID: <20250902035211.2953174-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_205221_582887_9B2AD574 
X-CRM114-Status: GOOD (  13.56  )
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

From: Alistair Francis <alistair.francis@wdc.com>

The NVMe Base Specification 2.1 states that:

"""
A host requests an explicit persistent connection ... by specifying a
non-zero Keep Alive Timer value in the Connect command.
"""

As such if we are starting a persistent connection to a discovery
controller and the KATO is currently 0 we need to update KATO to a non
zero value to avoid continuous timeouts on the target.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 812c1565114f..bb9685b67338 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4986,8 +4986,14 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	 * checking that they started once before, hence are reconnecting back.
 	 */
 	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
-	    nvme_discovery_ctrl(ctrl))
+	    nvme_discovery_ctrl(ctrl)) {
+		if (!ctrl->kato) {
+			nvme_stop_keep_alive(ctrl);
+			ctrl->kato = NVME_DEFAULT_KATO;
+			nvme_start_keep_alive(ctrl);
+		}
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
+	}
 
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
-- 
2.50.1


