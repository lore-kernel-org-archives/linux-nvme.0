Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CD2CA5FB4
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z28dlsJTIpkqTAOZ5w69VF46XysVuY21MZeRZQmbEno=; b=AZExv1b5PFlvmfI3f9jv+Pdf5z
	9o0R2Cc+DAN1BeXV2Hk+JoHtxN0QjhScRfI7/VWVd0YyW0d9FQ/xr4GOhiwP53DNuBzF3d4Rq2wt2
	4PL5wiTg11BQbc27PL4PeJ454TNjSr0Zseq2Vuxe/vsDKsWDkkCNkA+W20512S3LqyRimXQz/pYCf
	uA/RErViqZ68KK2/zNLAdcIKu+m7pyxr8nukBJJnHLtwAABiZr4UDRaN7VuxT/MK7GDJB64M6jz0N
	7ffmLW39vxU9BfcMSst034vWNnzlkAj6kVil3IlivNDPPbKQkc82Kb7b6bWMKYZufRjPnY44beSZV
	7DNo2W7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7c-00000002jMO-1Y08;
	Tue, 29 Sep 2026 08:23:32 +0000
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBTU-00000000fGS-3MJD
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:32:58 +0000
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-482f6350f91so1770956f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602375; x=1791207175; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z28dlsJTIpkqTAOZ5w69VF46XysVuY21MZeRZQmbEno=;
        b=pf3qnLX2IXkMs6WfbY2AFWNXHyXTwLJjDB/Qpo5KgPHBO7GuYmyhopSOhrbI2yLJwl
         5WFy+3PfuO6tc53AJQWfJCbKZSTXVEt1cvZxZQTx6CBZVDSWRwHIoOOOl/L7Z8OsQg2Q
         TDZj9X/lQcxvxYtgUbfhj2n78ttw0EZ3luZrrMNAnD7yKxnqUDOiqpIwp3TRprWKy1UW
         3VPpcnCXmRnW4RhqrDgJw2pwOybG3N9D6neTwFjOD7YnoAOQ/tcEPwsuh3bdzqX4B6Fa
         pPRBo3rMsQrED6U26EPas+BGHN9VHfa41mmxKwwR0oALLTl++/1lFnl7DKEEQDx1Dsfg
         zhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602375; x=1791207175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z28dlsJTIpkqTAOZ5w69VF46XysVuY21MZeRZQmbEno=;
        b=1AaUNBWD3O9JMXugnR1mmE8kxm49Ijdi5ZLzf8cin+WZ3YiFYfhEUE4GCYPaYjnG6C
         mmDAAe1VBZ5yrGMiy3It5d4FVFqL4JgBN+PVvr1Iyac3aWOiae0ugNtdl8ocvz4aMOsY
         ugEZn72HRmyXFftlxkhXPVsPpYiOXIU0H7md/wn6xQ+gEIC9+Uzy0Lfr9KAogojtJOZW
         eCtxSeRSLIVjgGVhTHRtCD/G452JuER6rPluBa11boNW3Kdm1xzJhMddZ1OoJrjznKnX
         lY0XJkz4pD0lt+LXt1PLk7QAX+v+GEuV+U7sJkWOmV5HzeCFLFZKULPgCnJEIihw0ODa
         eKBA==
X-Forwarded-Encrypted: i=1; AKwUvBwFGsFC1Qmbs2chES+Ap+YKmoPgR534w+OrXGTXIcw3ax3yNjkryyOq7gtk6TWxPx2KFI5fqv+AyjE6@lists.infradead.org
X-Gm-Message-State: AFq9FYK6NU8336XDKKldLZXAr6kYPu4flRf0NL+eNd2dDKtAnvPc7hUV
	BDlPR98n78oxdx07hEvTkMVFlpVe+ZbR8IFQS+dIrodNkdIgZvTdSW1m
X-Gm-Gg: AYBFou3b4w7JWEGrlO7T9w0uEZjdLh4HKM6BUlW+PJ5fRZWRMM7S9IrAutVM1x2qq3h
	yzOli7jAxhvrDGX4GVdD3I68bO9G9TZ19OGmyySirE6zc04mVM4msK7oxd/7eAW9YTQ8sXXaocx
	dCpF0aizCyP+WgjE3OL5uy5uAj0P+DaK7LmjWARjAd7DkBwKyxuIV0C93rSygR+q8g9bC34M6/Q
	Xq1O4/ta1+Dus11UXYzZj77jrPL1O2ueI8czVMXM76XuqYtaxgyFLvCcvFC+wjZv4qcJTCOjjJ1
	TaeC/2bzIBwiE29dKnOontr50FwndGgsarL24U2I5EI3G9J8NCvNwyXhZZ/3wAuckmQ3ET2Rbmw
	mgu9ERf8xT+avjlIj08sYYYWRuETOcXPewftC6uZQq/sOeRTYd9ojaSllEhXJZ7CBcafk4wm9NV
	hEwCbqGsopvm72V2vFSCLjRSvJSvipsruZAVCQ36Q2m0E9m81+xYEXIOuJqGQZCS5QqpZtGRq8I
	7bYEcu70GdUhTgpS/PHf0TBkg4/2QchbqWlAHuFjojsxppZcAFPz7C49uncNhf5GSvH8ELQHwcw
X-Received: by 2002:a5d:5d87:0:b0:487:342:d147 with SMTP id ffacd0b85a97d-4887db39b7fmr20252053f8f.39.1790602374884;
        Mon, 28 Sep 2026 06:32:54 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:54 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v7 07/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Mon, 28 Sep 2026 14:32:23 +0100
Message-ID: <f950827b5805d13f08f0060df0eebc4ed56814fc.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_063256_861890_28EA2BCE 
X-CRM114-Status: GOOD (  13.62  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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

From: Anuj Gupta <anuj20.g@samsung.com>

Rename the blk_dma_iter based nvme_pci_sgl_set_data() to
nvme_pci_dma_iter_set_sgl().

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e58bdd9a4098..bb8051c62926 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1277,7 +1277,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1307,7 +1307,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1329,7 +1329,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1492,13 +1492,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 	iod->cmd.common.metadata = cpu_to_le64(sgl_dma);
 	if (entries == 1) {
 		iod->meta_total_len = iter.len;
-		nvme_pci_sgl_set_data(sg_list, &iter);
+		nvme_pci_dma_iter_set_sgl(sg_list, &iter);
 		return BLK_STS_OK;
 	}
 
 	sgl_dma += sizeof(*sg_list);
 	do {
-		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[++i], &iter);
 		iod->meta_total_len += iter.len;
 	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
 
-- 
2.54.0


