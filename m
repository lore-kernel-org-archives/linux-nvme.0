Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005F6ECAAD8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 18:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQJ1C1SjENmgCWeZQvNCbMqCIh5TAvtoZAf25z/EVT4=; b=dl9CYOsRbJLshHJ3fHs6zTj/mc
	ra4yZVVULELGAcsj7pHSKf/rVGBvYLemiV7AFJ+1H5cKz3eNu3VIOSb1vGRiyOqqqdpSWLofgEHgC
	dXytAitMMm/BQ7HOKgBB9Np1aMAC/J5bOoy5a4CYoSM25aJVfrpYYOwzqnHH1UV7W3hReO/cDNhNr
	dBsDkF8no6WnojogCXtvzX8xCvMASnIBNgdbVlFiRrBZEL1NyO0aXhJ0Q3d7JikczNxiJJaoFFINd
	VbKIlYe01T87tJA1AIP7uOVPV2PI9q7eR70yN1G9KbNkr+EKpiGhD+4xrCeRWTEoHGsh4A/gkrf7g
	pffDaHpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQw6-00HLKC-Kr; Thu, 22 Sep 2022 18:28:34 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obQvm-00HL9b-7R
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 18:28:15 +0000
Received: by mail-io1-xd2b.google.com with SMTP id 138so8434095iou.9
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kQJ1C1SjENmgCWeZQvNCbMqCIh5TAvtoZAf25z/EVT4=;
        b=pDHEDqNu7gIG1tZwKjXkijlAv3FbeAirIAJbQJQAChrlUlJo/pXRxqh4kPVNmZHRN0
         ho2TBXNKrJRs0X0PuTx/XSnV1N/3gEMyvAD+PKLBJABAtrtukOHMYmJlaoXTrGEBJZYu
         Wz9Bnx81LWQKMEHsI3dQbaXqmEUiiUrrFm3n9mgBmkwa1hddM0Bnm5cAAjO9D4tR+m7F
         xGfFlpuxYbyEkJe3z68GYesMmaq9y6k6UwVXEc1/rc68JCnvYnX+blLE1vt0O+IbMk3C
         63jF4C+tW0MfbGRhjK3il/WqkrNi9L+bhW9W4BEXr3cIS/fKD6C/TMNWY747CKcKVQhe
         r35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kQJ1C1SjENmgCWeZQvNCbMqCIh5TAvtoZAf25z/EVT4=;
        b=ttKaCZmCXJs+Cz4PrLBNfND/mOlzNVhO6VpHhuLYQVWKakpUQ1QSsGFpoKZpMWcfe+
         pbofbeqAjQpI39oMfcn8gDO5TdXp9caXQx3JQGLruSKOa7U/NpSbZ+x/NN2Yc4OVVyXb
         H670Nras7Zqgm6QlQA1S0GwwYWQ7S83IHmpm57rWj7cnBVIFvPu/oiWBgG854oFbwagg
         gDZWAPc/debAmYhzhw1f7uDbfWqMXbrnvcxHiRFDfK+btvYtaCqIK9QB9TuHEQaM2AWo
         aqvOm92YuKU9QIRgOrQRXPj4ia5XJ6qrMy44n2VWZJadYBN65Y8edjkxVy57wUXhp+N9
         Jxww==
X-Gm-Message-State: ACrzQf35NvckwNY8QiE1Kzqhg3bL4Yp/6kZNXquPwFp+hGBLyrAj+7OU
	Uayf3gqRm9ymI9S9IMD2Ro1d4A==
X-Google-Smtp-Source: AMsMyM7wM97v1Oqw5RrX8wIN6VT4gEUijfOCbtCcdhJgZwn4LHZr9RZRcQ17ytyb3H0/RwWNoOeDOw==
X-Received: by 2002:a05:6602:1352:b0:69d:e793:abd with SMTP id i18-20020a056602135200b0069de7930abdmr2341538iov.172.1663871292289;
        Thu, 22 Sep 2022 11:28:12 -0700 (PDT)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q20-20020a05663810d400b0035a468b7fbesm2440646jad.71.2022.09.22.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:28:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Stefan Roesch <shr@fb.com>
Subject: [PATCH 5/5] nvme: enable batched completions of passthrough IO
Date: Thu, 22 Sep 2022 12:28:05 -0600
Message-Id: <20220922182805.96173-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922182805.96173-1-axboe@kernel.dk>
References: <20220922182805.96173-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_112814_292670_F3DBC3D1 
X-CRM114-Status: GOOD (  12.27  )
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

Now that the normal passthrough end_io path doesn't need the request
anymore, we can kill the explicit blk_mq_free_request() and just pass
back RQ_END_IO_FREE instead. This enables the batched completion from
freeing batches of requests at the time.

This brings passthrough IO performance at least on par with bdev based
O_DIRECT with io_uring. With this and batche allocations, peak performance
goes from 110M IOPS to 122M IOPS. For IRQ based, passthrough is now also
about 10% faster than previously, going from ~61M to ~67M IOPS.

Co-developed-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 1ccc9dd6d434..25f2f6df1602 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -430,8 +430,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	else
 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
 
-	blk_mq_free_request(req);
-	return RQ_END_IO_NONE;
+	return RQ_END_IO_FREE;
 }
 
 static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
-- 
2.35.1


