Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE6CC369B2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 07:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=T6zcHwN1BLl5JXSNfFYDIr9I+bhl12LMPDBNHYxeHY0=; b=1PumSFN18pdpstA3pY1YEWmg1i
	JcjQsa7LPnu+vS5BcY8aXF+QIB9foTIUBsb0MZnlngIFbqfeKXUnHVpcQ0o5bNX+eXl0o6qecZmAL
	P7vvRgaXAbbg4GzJnUsCvLpze3tt8h2LXCG4OLdAZwW5/M8p7hyguImuIvK6J3eAOB/IpqhQnwY+c
	iFjHhnXRb/Ktpy/9k3uOgvAjskqmji3u/yyZdSvl2UNJeH7rMYKCkB3amXsPdSNRLzF2VwSO7+aks
	IMIr8p0vNfFXYCDGmcIBn2Adw0lYHpdK8r8wqW1U/Wjvp5qs/u0B3SJv4WbWAMzt+JuqGTEfk3qAE
	o8MUJZzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5JRm-0000000C2ty-1sfZ;
	Thu, 17 Apr 2025 07:14:06 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5JRj-0000000C2td-31tD
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 07:14:04 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-227c7e57da2so4449265ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Apr 2025 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744874043; x=1745478843; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T6zcHwN1BLl5JXSNfFYDIr9I+bhl12LMPDBNHYxeHY0=;
        b=glUMxntgYdL8Nu7n5TW9F37lu9pSOHImw1IdyEcyJNqqVm2fL3+yffT9+hVtj6sWRQ
         km94df7E5lN//oadlpYV/+zu40rwjcsmdrs1muxq2+z8puFvMK7adxdCrE9qpHqvevIe
         8Ttv5MHkAQOmxGWoGbCCjs7oI9QHzSdde0/bJMGcQ0/CVeM96ED6ZgpHNDPd6Xt8u/8s
         TMM3ZP8LvbT8rBk/KH2nmR7LOWOrwcawwDXQ83adXl83u6MwZPNvOUVrVtVUaNGBVQyF
         pNL3+wGgFs3R09cyR8I9z/gYuze9RNo5DWERw1q249nxy17R18clmW3noRPXevUfVSW1
         Jm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874043; x=1745478843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6zcHwN1BLl5JXSNfFYDIr9I+bhl12LMPDBNHYxeHY0=;
        b=rvtT1h9pRnjgREtiVDuLU13+Mq646Z4aD6kyHtqaoKOPPNpYOn/SVJc4olaY2yYqSp
         aQpblYJpIq+5Dsteo0HnccdjHzZnlktu6gahRLNtTKwgvuejdZAqUGXd6qseSD/rWSH2
         vnaLh+ToYGkN6XhLKA53pu98Qtxaj9JOo/EcDvW1QoexDW9anWna7Rx1b20qMkOD8hCu
         Ph97QTNuS8ktvMT7HUzDEwzLX8g9IQYPEENGCroRxPTYRatqU4OUbhw2oPkKGNdm7c4j
         C/Yc2G9z3DtaVwmIBKqYaxEN6HyKccHxqMt0sesiSX2eErC6tXFM1lBhsrtqvbcBHpQ5
         e98Q==
X-Forwarded-Encrypted: i=1; AJvYcCWb5lfOO8GLMG4sPmgeYCMAEbBPd8AYmjjbkz7bEnEyLwsfqFURSJEpJtCRg66HPQM2WKbTxI6Y5zuY@lists.infradead.org
X-Gm-Message-State: AOJu0YzDmGlr7fYWMHvAk6cTO0qi8axxj4hb6aAaaPyh1z4OAV1/fAMJ
	a2vNUDkDylT7XrBFFF+2dKQKhvFitQNlPW5aK2JZxOnE9aYRGfE78jJLQG0kcH0=
X-Gm-Gg: ASbGncuOpOJX35gcTGISTlz3dPjOT8ebp0eBQpH4PvGr+3TaZYyQvj1fiFYglrOEjmq
	kCNKVTsM7jdyHmwFx6Hqx9vKphwtvR1WdRHF0kW0vvTdNPcTKxlqh2uMt3s0BVmPyleMwPRj+sE
	TCwHjri+Y9zn5M3+58KZtqjzBufsgjREfR5yz9k7w52IabksMHZifd8UJfkH+nIX2JaWbh89SgF
	sA3ov1HPWbk7dVvMtAeUoRhebfpVx+Mt/FrQcUuthFkBYVl28nK2tAivyXGnU98Gf3YKd9ZyODX
	MdOZhTIDOQtblgwmt+F3ERFU3ef2lnVTiFOWw5dhrVOoJ/wk
X-Google-Smtp-Source: AGHT+IE9WE7/IxnT6LbEplrnxfOoEfdd5gnal3tr1FUfzfXxzP7fSwcssNMYVvc33Y7AiyFP7uj+kA==
X-Received: by 2002:a17:903:2391:b0:216:6901:d588 with SMTP id d9443c01a7336-22c358ddc27mr81129245ad.15.1744874042759;
        Thu, 17 Apr 2025 00:14:02 -0700 (PDT)
Received: from purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f2c9e9sm26342045ad.106.2025.04.17.00.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:14:02 -0700 (PDT)
Date: Thu, 17 Apr 2025 01:13:59 -0600
From: Michael Liang <mliang@purestorage.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] nvme-tcp: wait socket wmem to drain in queue stop
Message-ID: <20250417071359.iw3fangcfcuopjza@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417071036.a7nhovuokg7w2n5r@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_001403_759441_8E4D744E 
X-CRM114-Status: GOOD (  16.91  )
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

This patch addresses a data corruption issue observed in nvme-tcp during
testing.

Issue description:
In an NVMe native multipath setup, when an I/O timeout occurs, all inflight
I/Os are canceled almost immediately after the kernel socket is shut down.
These canceled I/Os are reported as host path errors, triggering a failover
that succeeds on a different path.

However, at this point, the original I/O may still be outstanding in the
host's network transmission path (e.g., the NIC’s TX queue). From the
user-space app's perspective, the buffer associated with the I/O is considered
completed since they're acked on the different path and may be reused for new
I/O requests.

Because nvme-tcp enables zero-copy by default in the transmission path,
this can lead to corrupted data being sent to the original target, ultimately
causing data corruption.

We can reproduce this data corruption by injecting delay on one path and
triggering i/o timeout.

To prevent this issue, this change ensures that all inflight transmissions are
fully completed from host's perspective before returning from queue
stop. To handle concurrent I/O timeout from multiple namespaces under
the same controller, always wait in queue stop regardless of queue's state.

This aligns with the behavior of queue stopping in other NVMe fabric transports.

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Michael Liang <mliang@purestorage.com>
---
 drivers/nvme/host/tcp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 26c459f0198d..62d73684e61e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1944,6 +1944,21 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	cancel_work_sync(&queue->io_work);
 }
 
+static void nvme_tcp_stop_queue_wait(struct nvme_tcp_queue *queue)
+{
+	int timeout = 100;
+
+	while (timeout > 0) {
+		if (!sk_wmem_alloc_get(queue->sock->sk))
+			return;
+		msleep(2);
+		timeout -= 2;
+	}
+	dev_warn(queue->ctrl->ctrl.device,
+		 "qid %d: wait draining sock wmem allocation timeout\n",
+		 nvme_tcp_queue_id(queue));
+}
+
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
@@ -1961,6 +1976,7 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	/* Stopping the queue will disable TLS */
 	queue->tls_enabled = false;
 	mutex_unlock(&queue->queue_lock);
+	nvme_tcp_stop_queue_wait(queue);
 }
 
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
-- 
2.34.1


