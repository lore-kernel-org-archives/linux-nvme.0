Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C314C3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 09:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3vPSeDl9n8z+pPPisPVMQCbT+t7gDo4bPrvBM8+Mcq4=; b=X1KWeF4w9bYSkwLS1c+oRhoTsA
	KaSTLV2XSmP/Cbg+uO19od+KStn7k0OpBbY7S7LYo4m3lUHIaqGeUWcuZpmvaRjarE383vCVUAONd
	1Ws3ccCepyqg5fIB3CTku5tv7ZNgh+GIfZV/9NFeESK/1HCnPp+/KZ5wZE6N51B0hTeR1y4au3YFN
	y/VKXSuq82oPTtnHYA659Vs+TesE1rujCFawfn6sXrLHEAPsgTl75mmAo0z8ALvUndObBZ5GF93MU
	OLIQHrrHQ2ZkK/RYHwoR16YPOGE8Lfvj8oIzxg6ewCOA/Won1WQhtEIlrxW00wLpawJpbqDjidGKm
	w+LN+mxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUjnp-00000002D99-2qAs;
	Fri, 19 Jul 2024 09:21:25 +0000
Received: from m15.mail.163.com ([45.254.50.219])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUjnl-00000002D7w-2p43
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 09:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3vPSe
	Dl9n8z+pPPisPVMQCbT+t7gDo4bPrvBM8+Mcq4=; b=B20CM3XesBrphotd7hjQl
	MiBn42YKDZ9pImFMsY7DbImDydknR+wo9yKYo9igP0rearoyEMre3re83I+UkstU
	XMBJDkPbmYE8JJ44OBkhvlzP1veY0OQm1wflkPSn9K69izS8yJOCWa9aRNvYgSqe
	EaUY7WZmGSEVrovKKO398Q=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3T3X7L5pmYK8DAg--.13202S3;
	Fri, 19 Jul 2024 17:21:09 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v3 1/2] nvmet-tcp: use unbound_wq for nvmet-tcp by default
Date: Fri, 19 Jul 2024 17:19:58 +0800
Message-Id: <20240719091959.17163-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240719091959.17163-1-jacky_gam_2001@163.com>
References: <20240719091959.17163-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3T3X7L5pmYK8DAg--.13202S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4rZw1rur4xWry3tF1UWrg_yoW3CrX_Ca
	48Jr1DGF1v9F1qyrW8Cry3uryIkw1rX3Z2yan3Kry7JryfZF45ZwnYvFn3Z3s3Zr4rAF9r
	ZrnrJrn0yrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtHUqUUUUUU==
X-Originating-IP: [223.166.237.249]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSAkhKWXAmWHsaQADsS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_022122_370070_936DA05C 
X-CRM114-Status: GOOD (  10.31  )
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

To use unbounded workqueue to handle TCP's IO by default, which
was discussed in below session.

https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..35713472e395 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2198,7 +2198,7 @@ static int __init nvmet_tcp_init(void)
 	int ret;
 
 	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.26.2


