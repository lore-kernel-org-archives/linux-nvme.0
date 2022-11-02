Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40217C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Iclf4C38L6PjI0aMajF9kPowgLrlaTPx3HUaCMq6MQ=; b=RIjRiWP9ypkjRrdnCIWzoVjRoM
	/Emqa3XZsEVYr2fT02s779ilcOIfTbTT/m+b2XJdWGdFb5EhNVLNHu7mQRKp/7VPplWzzQnnzBGDl
	jqQr59uvhNepd7d0C9MBQ2KrcMLI3HnXFDhETw0vmAYMcIxYUii4pu8R1KckkyoxncSbky6OCyxYZ
	a7/4HZX2gWxbLIDrt2kpp9vDwcH0xAvDFBMHW0RUmkltyGDCiCX+9Oql59Mq324uJhBz/9Tnzg/6T
	cNX7vafUcy6PEfbiG6JIHo44HV6FlT5ozX3U7E+DkL4GN7xf2hfhpDzQU7iAxUQCH/ZZg/bmgvzGu
	MKr3vhGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqHQ9-00CVQx-JP; Wed, 02 Nov 2022 17:20:57 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqHQ4-00CVLv-Vg
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 17:20:55 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221102172043euoutp01568f4d0dfb7990862c197eeb725081f2~j1DyU5ZQQ2718627186euoutp01j
	for <linux-nvme@lists.infradead.org>; Wed,  2 Nov 2022 17:20:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221102172043euoutp01568f4d0dfb7990862c197eeb725081f2~j1DyU5ZQQ2718627186euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667409643;
	bh=3Iclf4C38L6PjI0aMajF9kPowgLrlaTPx3HUaCMq6MQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=iLYWiQP02oZWofAGfMwEb166R7dqe1msZ3RPS9fi7RqUifK3KSa59JsbzncsWVSpo
	 xWuCTySSwu1E8kolfygey1MBhoWWUGMYBWLNYYRXQsIBmAisRxk+G0xD1Ms+ets2Hh
	 P+PVej0KDLJHEsALLgXTn+U9p78nh6N62O2IiayA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221102172043eucas1p21ec75e73abcb14805381fee38d139273~j1DyJgW0_0918309183eucas1p2L;
	Wed,  2 Nov 2022 17:20:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id AD.29.19378.BE6A2636; Wed,  2
	Nov 2022 17:20:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221102172043eucas1p226576ca0e881424e65d2e0b8c19d060a~j1DxtKGjc0190801908eucas1p2D;
	Wed,  2 Nov 2022 17:20:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221102172043eusmtrp177829da1f218f1ff5a7ee42a2a569ba4~j1DxsT81c2164121641eusmtrp1Q;
	Wed,  2 Nov 2022 17:20:43 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-ac-6362a6eba649
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.FD.07473.AE6A2636; Wed,  2
	Nov 2022 17:20:42 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221102172042eusmtip2532b0a1ec738b58161696d5d5b258440~j1Dxg2Q6B1790017900eusmtip2G;
	Wed,  2 Nov 2022 17:20:42 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 2 Nov 2022 17:20:42 +0000
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <sagi@grimberg.me>, <hch@lst.de>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH 1/1] nvme: return err on nvme_init_non_mdts_limits fail
Date: Wed, 2 Nov 2022 18:17:08 +0100
Message-ID: <20221102171708.3303614-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221102171708.3303614-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djP87qvlyUlG3SslLRYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBl/rpxh
	LzjEXrH+Vwt7A+MUti5GTg4JAROJhgs7mboYuTiEBFYwSkxvesQI4XxhlLj9axUzhPOZUaLl
	SC8LTEvfxjlQieWMEvvnTGKDqzr//Qg7hLOJUWLXxJ9MIC1sAjoS59/cYQaxRQQsJSa8+Q82
	ilkgTeJ973F2EFtYwF3iYttcRhCbRUBFYvHXuWBxXgFbiVU9U6BWy0u0XZ8OVsMpYCfxpeE1
	K0SNoMTJmU+gZspLNG+dzQxhS0gcfPGCGaJXUWLLnO+sEHatxN7mA2CHSgic4ZBYefsZVJGL
	xOWLa6FsYYlXx7ewQ9gyEqcn90AdkS2xc8ouqJoCiVknpwK9zwFkW0v0ncmBCDtKvJ/5iwki
	zCdx460gxDl8EpO2TWeGCPNKdLQJTWBUmYXkgVlIHpiF5IEFjMyrGMVTS4tz01OLjfNSy/WK
	E3OLS/PS9ZLzczcxAtPI6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK89Wejk4V4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzss3QShYSSE8sSc1OTS1ILYLJMnFwSjUweaqcOrh0xbtXqyR2HXl7stpb
	PfNvJt9FnaJnNwtdLqcVvy5pE+/K+HJ5v5BAi81pNofblUa3uo1P/jAuXM/IdubBh+3PRdSn
	b1j3fMH+Dx4R/txVk841KfSoyjwIkruf2/LWNenDjCBNLtXFtewdS6ZOZdLaOu/g0uSrV3Vd
	E1bW8RyaP+9VvyxzHus+yYsKz95kZB6OWXZH/AND+Zb5SqLeYVNKZ6xj6O3qnW5v0OuSInHt
	KbP0DsX5fXqbfMwniAkzvNbur5bd17AhPKSzSIF5QkbnjDydtGeL4up3vqlJzqr3kFsd495Q
	9m7lxk7TG8Vi259cO/XHd0fB3uesDMlhzL4vzIoNQ+8a3VykxFKckWioxVxUnAgA7rHAA5ID
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7qvliUlG3z4bGmxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL+XDnDXnCIvWL9rxb2BsYpbF2MnBwS
	AiYSfRvnMHcxcnEICSxllHh9+A8TREJG4tOVj+wQtrDEn2tdYA1CAh8ZJV7N9oVo2MQoce3e
	LhaQBJuAjsT5N3eYQWwRAUuJCW/+g8WZBdIk3vceBxskLOAucbFtLiOIzSKgIrH461ywOK+A
	rcSqniksEMvkJdquTwer4RSwk/jS8JoVYrGtxI13Z1kh6gUlTs58AjVfXqJ562xmCFtC4uCL
	F8wQcxQltsz5zgph10p0vjrNNoFRZBaS9llI2mchaV/AyLyKUSS1tDg3PbfYUK84Mbe4NC9d
	Lzk/dxMjMMq2Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuGtPxudLMSbklhZlVqUH19UmpNafIjR
	FOjPicxSosn5wDjPK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg
	Knvzf/bLoCs+txtfX3hz7o5MsmLIJ91XhyxbFT+y5FcWvCleHN7fz3OSa3nhqh5N6+uPVh/g
	TJ75TjmAJ2ruXumpja5zVNdGLyys8hLgnSLo3rvtiL79NBZvz82ipxd/PZ3dmm6fzjp7NfvO
	eXWPezqqgwtCTtk8O6HgZHLmS03XTJPvzK//qcy2Sv/FfPlrlk6emfF+j/uOe8JZL545dDqm
	tjqNVWTmU8vcXd+aKy5Pf+8vp7ZO4lbEUt3cmmnc6nPeXP1cprKeKeiJSKCT7sMA/6RzrMq5
	2ocXX7irJn9soXBvrenBmNMnKoROf/zrbKD+9uQktjkBvzhYeWJTOzSz1C4Kik1qXsz7qNlf
	iaU4I9FQi7moOBEAOyh03TsDAAA=
X-CMS-MailID: 20221102172043eucas1p226576ca0e881424e65d2e0b8c19d060a
X-Msg-Generator: CA
X-RootMTR: 20221102172043eucas1p226576ca0e881424e65d2e0b8c19d060a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221102172043eucas1p226576ca0e881424e65d2e0b8c19d060a
References: <20221102171708.3303614-1-j.granados@samsung.com>
	<CGME20221102172043eucas1p226576ca0e881424e65d2e0b8c19d060a@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_102053_338313_041997ED 
X-CRM114-Status: GOOD (  14.29  )
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

In nvme_init_non_mdts_limits function we were returning 0 when kzalloc
failed; it now returns -ENOMEM.
Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0090dc0b3ae6..e02a7ca2ed57 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3049,8 +3049,10 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 		return 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
-	if (!id)
-		return 0;
+	if (!id) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.cns = NVME_ID_CNS_CS_CTRL;
@@ -3068,6 +3070,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
 free_data:
 	kfree(id);
+out:
 	return ret;
 }
 
-- 
2.30.2


