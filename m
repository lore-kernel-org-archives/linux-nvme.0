Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCE7C44536
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWWll8LWGk4bgXbjsNFMGQ+aIu0e9z5vmcW+zxQ0akc=; b=V9YdyDev9Oa5CDoVOtkMPu46Xe
	Zww8ff3ZZByoJxwb4i4Crr1O2MVrK+HFSPy2LCAfhDMtZnkoP4GK6EaBDdeLFwZjDnSDIWm8Mjd83
	EnTEw8eNsQQULb58twddAv8vchBXuHPWcDsQS4XcW21vmNSsh3Xlh/8cjoZAnwaJQm0Jqyv4v9E/V
	Iutg7unEGKevKKNKEYG2uaqNkQ/8HoLo+ImxDZyQdSRdrvZdKyK7yc2M0L8UAjT8HvoiFF+gOB5ab
	DynP2Nbs1mgJOLmkqsMvMaqQp8bkzcarKAGvzgfF/Q6dEUbOyXzQ/CzU+OCKzS3nRUOhCamTvC/ES
	rGcclQNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXe-0000000A5NS-1RN3;
	Tue, 21 Jul 2026 17:46:06 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEXb-0000000A5LO-3ein
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:46:05 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-495437bb891so43537305e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655962; x=1785260762; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWWll8LWGk4bgXbjsNFMGQ+aIu0e9z5vmcW+zxQ0akc=;
        b=WopikeVMerxQttUC8lki7eFDGw5gokvBawYM9LEZgm/a0rhgdVd8uBQKrEG0wAi6uN
         JffBkxIA1SqgPGarkFk5a9OIkACmj/5A8LqtJmNVXZB2l8p1Ryyjt553AI/xws020VJ6
         1oaaSlHXeS8zVzTCFWdb90hovvKYQlIDxuTsaqM1oYe4ZjisGu2LYHsEO/PhDO4uzQAG
         6lTubra5l5mIP7fJiFzfNbz5kotqar8W5QdL+a46iEyQbNUB7GPU8mVNNfdByMoM2EgA
         B8tMEJChYGT7ZanwHFcDxGIUrsuOun3aUhrXeZNCBfhQUem/TbVQhSOAOEwxcc4S9ouR
         k7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655962; x=1785260762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lWWll8LWGk4bgXbjsNFMGQ+aIu0e9z5vmcW+zxQ0akc=;
        b=epmaC7PmPa5PlgYKQHlRjtAG3EpreFG53YAHz2V5yWSs+AgfMKNoCnkTaEo/eNUeNJ
         6ClQc8t3DEw9vI+gm9f72zAeslgANtaJvtTeRmOtI1Rj/eFk1fo3NWuxWOKRtuhIZWs5
         pQQB4OLdhhBPDVOsyjSenLRfCXP9Yh3kK3iyva0QKmdCk9wF+16UtIhumE9UumQyHLIW
         ImUnpqfWF2gNss58Sq9om9kRZTr6iKV916PT2rGo2V4lK5l2snga+PgNS5zPxHpRFjTG
         zZR3FXkr1aTks/4vD8s7Y+lYT9mI1e+VJV1mJnLNY8kAIRIA1sF6WVYgCuMFJaOligLj
         yguA==
X-Forwarded-Encrypted: i=1; AHgh+RqxRyJRQ/b/WuRI/eDgmlTNmr+lWGwj+zTpVKJvzA0PY2vVazDDGMa8tILo09U/9P7tAfcgNRo17CfB@lists.infradead.org
X-Gm-Message-State: AOJu0YzsCWPX8ZX8cGGYMPYm4y6uVSvUHaodzCPWZU/QbtiAmN/P2xnD
	5C1WOoMEbkBe5t0ayOdR6hqSNluwIKdKJZMkRQun9wJiF9fl/IieQWcH8sn3LSxcjw==
X-Gm-Gg: AfdE7clbPQZYkKsV0Q2m58Khf2IaUnZDmZtML0CRWyXqPIkKN/kw4CdHPr7grCqgbAo
	1Onu4DhjQnb7ENeWHlCZGToI8CtDJVA35OBlK2OO7b3wsF11VI0KZDeyItQauJYOE4OpMHOB2tx
	5f2FD4sYXvQn7FzbqMrgd23Kd6h3eZZ+uXWUt+Nu4GkhZfg6tJwXy6CArOgN7HByvD2qDC8FHjr
	ZMJzM+NRSaZpnRvTiviC8cpejofxdJhlSRwjscdpoo3usEzV3Q7sgE60Wkq2VA2aqet81NSl+tw
	4tDhdzOOTuNH2J1spNfTUnIYkiLWUOn6eg3rEYGGa3XYCLnkGAcxay4CpX3mugwS/KxfvO7Qz/c
	8r27Ci9WPvalDH5hNWsM4KV8SobWi+yeAdMO+H049kuHOpPGDDLBLrdiFMlt0JKmYovBqwYNcdP
	BA3MISaN9CMNYxn0iA5is+yAZZs55pDaxxOV35nC4AkHyUAkteCqF7n9LlGQ==
X-Received: by 2002:a05:600c:4747:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4956a4a14ecmr8642615e9.0.1784655961748;
        Tue, 21 Jul 2026 10:46:01 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:01 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 1/8] blk-mq-dma: restore BLK_STS_TARGET for unsupported P2P transfers
Date: Tue, 21 Jul 2026 19:44:55 +0200
Message-ID: <20260721174502.111503-2-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104603_933407_1655F2D0 
X-CRM114-Status: GOOD (  13.48  )
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

Unsupported P2P transfers used to fail with BLK_STS_TARGET, chosen
by commit 91fb2b6052f7 ("nvme-pci: convert to using
dma_map_sgtable()") for dma_map_sgtable()'s -EREMOTEIO: an I/O that
can never succeed on this device must not be retried.  The
blk_rq_dma_map conversion changed it to BLK_STS_INVAL, which
blk_path_error() treats as retryable and md deliberately ignores
for member failures -- a P2P write to a member the peer cannot
reach is counted as written and the mirrors silently diverge.

Restore BLK_STS_TARGET.  Hit e.g. with CMB memory of one NVMe
device used as the data buffer for I/O to a second one behind a
different host bridge.

Fixes: 858299dc6160 ("block: add scatterlist-less DMA mapping helpers")
Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Cc: stable@vger.kernel.org # v6.17
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-mq-dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bfdb9ed70741..c17e4c49900c 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -190,7 +190,11 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:
-		iter->status = BLK_STS_INVAL;
+		/*
+		 * Match dma_map_sgtable()'s -EREMOTEIO: this transfer
+		 * can never succeed, so don't let it be retried.
+		 */
+		iter->status = BLK_STS_TARGET;
 		return false;
 	}
 
-- 
2.52.0


