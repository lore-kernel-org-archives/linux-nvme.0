Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A58C433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  7 May 2022 06:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ea/7f8A4NPQmZCTH61ttxUc8ZcgpbXzjfNgGF4s2Ed8=; b=D6UUdUsE4yMwMMsjO/qd+X+TAt
	IYAOChQLkyv9nN5ttQwemguJQ4ZIuk5iMFdhWQhgItfmEWPWU+6eUo+JyMd28MPtlGCpPTpx3EdnY
	n5yJaYbeiC8JFjyIScLuj4C4JXugb74IIPHo/Uch2/0gCpEglgvQwqD+hYdjjkX4j8aD513qWn1Xz
	VDMxjSo2CqiMcBRCwzzrWlDIHmgmha/nnFFsqfC8sZHY5pBuduzq5HSZ+KQswKs0RzlXEzEo6V7jw
	cHtuAUDq2ibOpTG04QxKZuG9A7saPtDtS4yKZhTQjNwMlbv6B6l11FK7y3iDWsB0LcX0NrqsRiXyZ
	Tw3gfF1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nnELO-006Ij9-V7; Sat, 07 May 2022 06:55:11 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nnEKo-006IRx-P3
 for linux-nvme@lists.infradead.org; Sat, 07 May 2022 06:54:36 +0000
Received: by mail-pj1-x1031.google.com with SMTP id fv2so8863367pjb.4
 for <linux-nvme@lists.infradead.org>; Fri, 06 May 2022 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ea/7f8A4NPQmZCTH61ttxUc8ZcgpbXzjfNgGF4s2Ed8=;
 b=HV26AlNcvQjy5U6VCD2LyHjl66aup0wiyAv9NbIbjwNj4A5rzlYWDAopGzbQlgCHfn
 Vtt3dcN9sXGKfTkYkc45A3mkD7SLE8qP5yBaZOcWvPOpXLl0pCde87ILhrDTavB7RPHY
 1WZgvdHqkKBBHxxDGvd7vOWgSCxEQE23wKXyC9XTKCg4WvSIitFpgtQjpdLZxsUfw8Bo
 gJaSFkbXfhu52lZKOthl/9Q010pvSdraynadbyaEs6C153grIWgpOiu8ShONZIwTrJZE
 D3VR55j8kTGmwxu/muldSinB74Z7u0/9P0we/UsSBfPy1k+xOb4ZIWEyTs+J1RcQlIzE
 VrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ea/7f8A4NPQmZCTH61ttxUc8ZcgpbXzjfNgGF4s2Ed8=;
 b=XroQ2JP9TGU8thByIBaM2E6GNld/Ul5oewdFQCbTxdFCvfGeYJw9DKm1qtGmDRg62M
 pR3JZjFowYAo11a9uwnhRcWVxycLY5/Gsc/oOwjPWkIG8GMqVvmYwzCELbyOvN3hHod9
 kCCnONZntCoh1x9NYD4BuuFqFxu3U9UVamoworQwePXFHjXneF3487DjewbYqylD22XS
 LDVr6DlORUj2wk7Fj9OIZO7JqiDWiFt0QBirivBcNV+rb3GGgFBpdMOLSlWrMpeM8pkL
 6eZyRZsZT8o2aFcVJU4MrNMjPHN5ZRhuEweAzPmsJciYIYcgA3HYrEv9SwN8px1T0eSA
 d2fQ==
X-Gm-Message-State: AOAM530JUkCWN6BKq9go/O+mpJE5JkrEkN25z7gxeggBWokjtI57SE27
 UgJN2zPNlRu99rFKIFkEeo0G+A==
X-Google-Smtp-Source: ABdhPJwVFbDKu1C1H66AqhkbJbo0SmUKfhgk9fiE1NUon3vtipkhLVIjMHrAkhfw3aRf2T0XRpo4oA==
X-Received: by 2002:a17:902:e742:b0:15e:9a7b:24c3 with SMTP id
 p2-20020a170902e74200b0015e9a7b24c3mr7311641plf.17.1651906473207; 
 Fri, 06 May 2022 23:54:33 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a1709027c9400b0015e8d4eb1ebsm2905162pll.53.2022.05.06.23.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 23:54:32 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kbusch@kernel.org,
	hch@lst.de
Cc: sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 3/3] nvme: enable smart AEN
Date: Sat,  7 May 2022 14:50:26 +0800
Message-Id: <20220507065026.260306-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507065026.260306-1-pizhenwei@bytedance.com>
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_235434_864125_EC57392E 
X-CRM114-Status: UNSURE (   9.12  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Try to enable AEN on host side, this is helpful to minitor the
critical warning from the NVMe controller.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/host/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e1846d04817f..f386a4f1d434 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1490,8 +1490,12 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 }
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
+#define NVME_AEN_SMART \
+	(NVME_AEN_CFG_SMART_CRIT_SPARE | NVME_AEN_CFG_SMART_CRIT_TEMPERATURE | \
+	 NVME_AEN_CFG_SMART_CRIT_RELIABILITY | NVME_AEN_CFG_SMART_CRIT_MEDIA | \
+	 NVME_AEN_CFG_SMART_CRIT_VOLATILE_MEMORY | NVME_AEN_CFG_SMART_CRIT_PMR_UNRELIABLE)
 #define NVME_AEN_SUPPORTED \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
+	(NVME_AEN_SMART | NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
 	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
-- 
2.20.1


