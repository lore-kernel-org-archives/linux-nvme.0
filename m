Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E6CE6C5F9
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 03:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y6AV0h7FNjp9FEqh641JiaIQjrd1pHaDZb70DiuzgZI=; b=FaIEqypiYN0THmvn7g7o/Ik/9k
	xCqQJNpmM20SYoWNWGFo1OiVuP9mjiP4DxR+zP8fx0CCdAryT2PvoCqZm7uyX761skURloS3ZUSJS
	O1FRuxol3HsG+IlQjuvN/GHeZUQnQs03O0StFshbYnMTikShzQJKd92TiOEfZxe6hR3kOD92ePsZ1
	7BckqTa87XhILK3BwRYCSavZI2AjDI9pluIgswkb91zfyaMIk2UZJr5PWUUjNdI2skThodYahydwc
	Bua21RQEBs//GPC80E1kOZO3wg3wLZR/s1EOX3VT68Up0ULk6f97F6KGmaDJJZRUHpahvAgffUHNU
	6VX3MjEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJgg-000000087aT-35FE;
	Tue, 03 Dec 2024 03:34:58 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJge-000000087Yk-1ihZ
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 03:34:57 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3828808a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2024 19:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196896; x=1733801696; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6AV0h7FNjp9FEqh641JiaIQjrd1pHaDZb70DiuzgZI=;
        b=j8eWdd9bIy7z0GAjtYENO3XIXqfwi05Sl+p4Lx/4Gtdab0nEL3eaUYcQxXNH2B10mi
         bNZl1dJu6em56G5YcieAn2B9vogwbisBG76xEFNzn0SDlyh5R+NG++v+v8I4Cj5zxf+O
         k6u/yr2mXzn61DIaBm1fC2p4Vb8/vW2wQctH6pWbM5mJJoxWLoiuuH0fP7nIVQwGhdL1
         zF00N++3aHifxN/0WcO5Tv77vrJGMZYQPsyFUcIEAospUH5rtWw46scO0HSpbezLGlr/
         6TFu/qGcRtI4uvL95vx6ovmz4NDnKsOmD5Mz4sJtA/l1SoL79oj5/89HQ037wUu86+KA
         eG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196896; x=1733801696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6AV0h7FNjp9FEqh641JiaIQjrd1pHaDZb70DiuzgZI=;
        b=GYQrtOONhxtx5SdrcmmpJ4tBHg+vRJoV9gNRlJinv2gpzyKATTYDvAwB45nSMgqgKX
         IkLKFihHJBpNQx93VxVcoYIPCOem+YX6+kyz0cRkhFJVS9OJ6bWDsi/wTi+cpM1GP7ST
         LeZY9T+nd+BdQ8YnnsFlVWgAOpJS4r+fkQWf0wcYCM0Ls+te8YXfoj/gg3rYmGvepRGs
         3RRXbLCwrmUZ6T2+qdWETTV6Ev2ZGYKnHZtRqKp/EIXROIGKjXXsKjrPc3HUCQJNPS27
         HeRcrD7ItlFc5wNV9XGwZ0jbIrMI26WtaSQh1kaDosCJ7G1MeXMnU4s6wFHgD4khpTvi
         YtNA==
X-Forwarded-Encrypted: i=1; AJvYcCUlZzuR1gRla+AxkzbeI6fDe9s25n9DmU+bxQvUMLs/9TOzywh2hV7J/OzPRj8uh1o4+djNCl9UkEC7@lists.infradead.org
X-Gm-Message-State: AOJu0YyDO+GzNfz9OKbfk5Uy6olXdMRv/VDCnCusMSjefBdb5e3Fakp/
	bA3JR2pZFg1f0y7rS3WQn6XdYGNDoGEAN2tGxCYcuIqPz12o1VK64J0Nj7TBCP8=
X-Gm-Gg: ASbGnculcxvwxSbB/x0jyxWcHkxlaki3v1gCXeNR5ujwfRXP1g+jFoPNhzWqz4w8TLn
	KWFxdsjZ1qkulKqCKSggpqvOG2YN2DmmIELtjnKuqyuH9GnkRXMD4SHLdrzcK1h3+t6gjrkmwUM
	EJd29VaE4aKFyB1C3NIOMQ4+QUlZEWy5MqWWl1MH1WD/tncvO9ezrxNfjljrohWt4faLC4u1IFa
	PwiBxgeePyWf3esaVhE0937UO4FMeqjl0J0TuyIKeXY+C5AsBV1pInpx2IbRA==
X-Google-Smtp-Source: AGHT+IG/3v6d0HhuojT/rCyNJmBTQDwDmQb89wyTD19L5RRZmIzLFQmfix9M6IAIezSRwrhdjHrdYw==
X-Received: by 2002:a05:6a20:748e:b0:1e0:d1f7:9437 with SMTP id adf61e73a8af0-1e1654134a8mr1688465637.38.1733196895660;
        Mon, 02 Dec 2024 19:34:55 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:55 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 3/4] nvme-tcp: no need to quiesce admin_q in nvme_tcp_teardown_io_queues()
Date: Tue,  3 Dec 2024 11:34:42 +0800
Message-Id: <1562477fe9a03adefddf551148882d27a01529d7.1733196360.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1733196360.git.chunguang.xu@shopee.com>
References: <cover.1733196360.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_193456_451045_8FB84701 
X-CRM114-Status: GOOD (  11.56  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

As we quiesce admin_q in nvme_tcp_teardown_admin_queue(), so we should no
need to quiesce it in nvme_tcp_reaardown_io_queues(), make things simple.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 55abfe5e1d25..98bf758dc6fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2178,7 +2178,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_quiesce_admin_queue(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.25.1


