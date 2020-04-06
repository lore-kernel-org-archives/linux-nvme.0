Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A38C2BA18
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 07:14:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63A420719
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 07:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d8E2AwL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63A420719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uHFAcFjor4tIL4ftEoNMV50Lo374B87exFFimvwN350=; b=d8E2AwL+8kFXlqJYU+ysDInvz
	MvYAcBBYawP0DOGcvYK9/oTVR1KNKqv3EKHmO2kB5cipKXVEjUnsdQMgIbvIbCD8lWGKgL6dtFs3o
	pUMUXQOalNSNduNN/lt+VG1/7FD/CKoBOcQaUW9fq/ubWa0GPjdpFmkxDTfGoAsNgemalnSLkM6Xe
	kdpGconOn1dwEgD5cJ+C14Bnz4caAkiAjXRD+mGc9AUUt7KDMst7Tpc+qcOBz0sycX8z0W8kp0H25
	9/8C23GpyvUkhCVA4k9TlpH2s6+c6e+GNIr7eg+4KI4mQqF/dTeXtphgyaFRdYi0LWrmso1mBDcLt
	vblZV9XFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLLxq-0006NJ-7x; Mon, 06 Apr 2020 07:14:34 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLLxm-0006Mn-Sl
 for linux-nvme@lists.infradead.org; Mon, 06 Apr 2020 07:14:32 +0000
Received: by mail-pl1-f194.google.com with SMTP id ay1so5572057plb.0
 for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2020 00:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PJDx3XP8S1iBYf00V3hARR+6Y+hR1LABonNBJ2fmis8=;
 b=SZZP91rrTIZYqhbG3XUWJS/dCx8nQBhi2VxDI83CBSN6aSbKHabWhN69ChS7gXDBri
 9lzY6s0kfjDPu0v/+XagoNLyo1Wooce+9ffk7KOJsFvo7NLzBY+1pYRGYBSQ7MNxaLWp
 EWHITX9IcCsSoAdg/4x55wm8dPhAlyP9SvUTXr5XC8FJqt6RHb/TQnS4nRYXlM2NztQ2
 YZWA7kcTSt6Nw9BKN/Cm04rpv0OOY9mb/l+g2pcV9yTkfo6VxLRc5gLt8Gxk6ps14XUc
 gXIyW/Ttv4c+cdDCVz/49xtLz7L6i7bJmlqmpRcF0FD4CBtfoRoo7Yrxt6qiN1qGoQ9Q
 eWNQ==
X-Gm-Message-State: AGi0Pua+CL5yMTX4l5KEUPWvLgIQSUmW9wmfayj4uPOFz6x4A4HFk30j
 0QEHt2lqCnayUQ5yPe38G90=
X-Google-Smtp-Source: APiQypLTI4D2JGOSzuzvzNzQXYZAG03gwaxjdn2YVrRx6iwMJ+3pkVTNH5ptphGW5u8FsIqh3iiE1A==
X-Received: by 2002:a17:902:a40e:: with SMTP id
 p14mr19399719plq.295.1586157269657; 
 Mon, 06 Apr 2020 00:14:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e891:e4b7:ccee:cfaa?
 ([2601:647:4802:9070:e891:e4b7:ccee:cfaa])
 by smtp.gmail.com with ESMTPSA id u3sm11161098pfb.36.2020.04.06.00.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 00:14:28 -0700 (PDT)
Subject: Re: [PATCH] nvmet-rdma: Fix double free of rdma queue
To: Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1585477302-4307-1-git-send-email-israelr@mellanox.com>
 <39a9e27b-51fa-6c87-8e5f-17f4f7318bd0@grimberg.me>
 <05c7907c-9c43-2a2b-c760-bff0364892d9@mellanox.com>
 <f356a0d4-2e05-f629-ebab-a55e7e0c369b@grimberg.me>
 <b5111042-d90a-0c48-6fe0-3cceca1b75a2@mellanox.com>
 <edbcdf17-ef8c-f937-bea6-b5bdffb7b202@grimberg.me>
 <69eadde6-7d93-cf61-9e98-f34c9f55924d@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3253fbf4-04de-e5b2-6d2a-1971341ba109@grimberg.me>
Date: Mon, 6 Apr 2020 00:14:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <69eadde6-7d93-cf61-9e98-f34c9f55924d@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200406_001430_927572_B93BCC01 
X-CRM114-Status: GOOD (  14.40  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> But if we take a step back, nvmet_rdma_create_queue_ib does not create
>> the cm_id, so why should destroy_queue_ib destroy it?
>>
> This is because we can't destroy the QP before destroying the cm_id.

I meant something like:
--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index fd71cfe5c5d6..89fd37b1140e 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1069,7 +1069,8 @@ static void nvmet_rdma_destroy_queue_ib(struct 
nvmet_rdma_queue *queue)
         struct ib_qp *qp = queue->cm_id->qp;

         ib_drain_qp(qp);
-       rdma_destroy_id(queue->cm_id);
+       if (queue->cm_id)
+               rdma_destroy_id(queue->cm_id);
         ib_destroy_qp(qp);
         ib_free_cq(queue->cq);
  }
@@ -1079,7 +1080,6 @@ static void nvmet_rdma_free_queue(struct 
nvmet_rdma_queue *queue)
         pr_debug("freeing queue %d\n", queue->idx);

         nvmet_sq_destroy(&queue->nvme_sq);
-
         nvmet_rdma_destroy_queue_ib(queue);
         if (!queue->dev->srq) {
                 nvmet_rdma_free_cmds(queue->dev, queue->cmds,
@@ -1305,9 +1305,12 @@ static int nvmet_rdma_queue_connect(struct 
rdma_cm_id *cm_id,

         ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
         if (ret) {
-               schedule_work(&queue->release_work);
-               /* Destroying rdma_cm id is not needed here */
-               return 0;
+               /*
+                * don't destroy the cm_id in free path, as we implicitly
+                * destroy the cm_id here with non-zero ret code.
+                */
+               queue->cm_id = NULL;
+               goto free_queue;
         }

         mutex_lock(&nvmet_rdma_queue_mutex);
@@ -1316,9 +1319,10 @@ static int nvmet_rdma_queue_connect(struct 
rdma_cm_id *cm_id,

         return 0;

+free_queue:
+       nvmet_rdma_free_queue(queue);
  put_device:
         kref_put(&ndev->ref, nvmet_rdma_free_dev);
-
         return ret;
  }
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
