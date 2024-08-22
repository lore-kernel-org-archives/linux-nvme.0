Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE1AC5321D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 18:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4JDb2lC6vkxiQiFZDx7okJ0uyYWyOojJCyTq1IY1j8o=; b=BAn6jbZc0cIjMDBeY49gl9UdAp
	GUrJF1SdP3yGFVjh8LlALZfRzh0+C4D3hh08xOBzF0vklV0eVlkNHD22Tds0QGMqSQRNd7KiFWanF
	3i7YpbPMS9diqE/EF4Fo1J+HcGRguOysWw28FpwpZvoeG2FaJ7ZmSXRzw1WnEUx4zk7TXQ7QJgUSM
	/0xbjShguX/u3BUuIRtSO051aEjroNf6mFIcOYbHjC/JQ3Y9GCdRWrPC9ZEBxklwn+JY8BDkAWgcW
	GrRXLeOWQKEwf773a9N8IrEEIkgceIf1P85iDY69F6AWo+7Nrpgrb+JriraquyAq8TBQ74XKO9/XU
	qUUGiRSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCh3-0000000DyCQ-2giP;
	Thu, 22 Aug 2024 18:37:57 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCgy-0000000Dy7p-3NAb
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 18:37:54 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-20203988f37so11041915ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351872; x=1724956672; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JDb2lC6vkxiQiFZDx7okJ0uyYWyOojJCyTq1IY1j8o=;
        b=UaNGHvyxh1sCv6AG35v9kao06TKVMnakC2mnzu2vy8hTJfvG3a0uWkQlYhOoZ2b2ur
         CBbk9xMDeOS9cUlIsBaq2p7XpfaWEjZ16yG2j8rNe0INUhdM7AMKJC+F4t58eQcfn7ZL
         zjCg6n4wmWTpTJL/XATqyB2yEQLvufzQsYeEvEahUvYSSTWyhB3tleM1HW0NV5oZ8ar1
         jdxEDCn8Ic/I/IsXGAQTDxpKhTw4QIsrctYqmRjRPx1SfJtC568Z5PPkxC53PLt/IDmp
         zaerVsZKNJkKbO8w5XSG9ClQEYZzcRE8SB0w4GdekMzo9QkskQRzO2GAadFrJLZdfIZZ
         uEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351872; x=1724956672;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4JDb2lC6vkxiQiFZDx7okJ0uyYWyOojJCyTq1IY1j8o=;
        b=UA86Qo2ZlzO5Q1nWPU+GhtU2HRWiRZPuwwOfrZLQbaFIILbj3Cgj15Q1qr5hWxfKp8
         oi6mtfyIcIfvzeHFHrZsZtgUZ6jRpouPpW2Zqbp6WVfHjJgLbXDd52gRyG3BKAI7WXof
         RsPShQoY2n3wa9aj96NwaSc7JZeNnySK09+8ImsMfw9LdKNLfxGl3fVnUdejZy6nXylY
         Uyn+tU0qE5GWHiX4wVWSSMxG68hGqFzSKi4Q01HXjN5KdG8PZOs1w/phJFk1QsmUNZUW
         zP0nA894SEGspk1z0bjghJjxzFAhT90iN4R9zm5YT+wZdCJ2YjxCVCj2am0nfXlzfn9u
         tnrw==
X-Forwarded-Encrypted: i=1; AJvYcCU9E6bYXv4b78WzgrsoB5AuXxmtAFb0ZnEYehhIn8udd4f6pbXa6q8JqGUY1BCDPjXPfoBfo0cZxqAi@lists.infradead.org
X-Gm-Message-State: AOJu0Yyx61LFlXfagFJ13glRJEENudp6hPLVdz7XvT3MeYNtxdx1Z5Bg
	f83xJvF1QNJBzSrU9YF81vT7q+BmYgLA0na1wBHfi3Ylqclh4V/P
X-Google-Smtp-Source: AGHT+IEoJ1gpzNrcpekG/3JPJrpxwsytoY1vLLalws9b/ZRPgjfwB0Ov7rhSrw2br36PLdiErGBT6A==
X-Received: by 2002:a17:903:1cc:b0:1fb:9b91:d7c9 with SMTP id d9443c01a7336-20367d32768mr57195805ad.4.1724351871710;
        Thu, 22 Aug 2024 11:37:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:51 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 5/7] scsi: storvsc: Enable swiotlb throttling
Date: Thu, 22 Aug 2024 11:37:16 -0700
Message-Id: <20240822183718.1234-6-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_113752_971421_7F63BE6A 
X-CRM114-Status: GOOD (  20.21  )
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
Reply-To: mhklinux@outlook.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Michael Kelley <mhklinux@outlook.com>

In a CoCo VM, all DMA-based I/O must use swiotlb bounce buffers
because DMA cannot be done to private (encrypted) portions of VM
memory. The bounce buffer memory is marked shared (decrypted) at
boot time, so I/O is done to/from the bounce buffer memory and then
copied by the CPU to/from the final target memory (i.e, "bounced").
Storage devices can be large consumers of bounce buffer memory because it
is possible to have large numbers of I/Os in flight across multiple
devices. Bounce buffer memory must be pre-allocated at boot time, and
it is difficult to know how much memory to allocate to handle peak
storage I/O loads. Consequently, bounce buffer memory is typically
over-provisioned, which wastes memory, and may still not avoid a peak
that exhausts bounce buffer memory and cause storage I/O errors.

To solve this problem for Coco VMs running on Hyper-V, update the
storvsc driver to permit bounce buffer throttling. First, use
scsi_dma_map_attrs() instead of scsi_dma_map(). Then gate the
throttling behavior on a DMA layer check indicating that throttling is
useful, so that no change occurs in a non-CoCo VM. If throttling is
useful, pass the DMA_ATTR_MAY_BLOCK attribute, and set the block queue
flag indicating that the I/O request submission path may sleep, which
could happen when throttling. With these options in place, DMA map
requests are pended when necessary to reduce the likelihood of usage
peaks caused by storvsc that could exhaust bounce buffer memory and
generate errors.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7ceb982040a5..7bedd5502d07 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -457,6 +457,7 @@ struct hv_host_device {
 	struct workqueue_struct *handle_error_wq;
 	struct work_struct host_scan_work;
 	struct Scsi_Host *host;
+	unsigned long dma_attrs;
 };
 
 struct storvsc_scan_work {
@@ -1810,7 +1811,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
-		sg_count = scsi_dma_map(scmnd);
+		sg_count = scsi_dma_map_attrs(scmnd, host_dev->dma_attrs);
 		if (sg_count < 0) {
 			ret = SCSI_MLQUEUE_DEVICE_BUSY;
 			goto err_free_payload;
@@ -2030,6 +2031,12 @@ static int storvsc_probe(struct hv_device *device,
 	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE.
 	 */
 	host->sg_tablesize = (max_xfer_bytes >> HV_HYP_PAGE_SHIFT) + 1;
+
+	if (dma_recommend_may_block(&device->device)) {
+		host->queuecommand_may_block = true;
+		host_dev->dma_attrs = DMA_ATTR_MAY_BLOCK;
+	}
+
 	/*
 	 * For non-IDE disks, the host supports multiple channels.
 	 * Set the number of HW queues we are supporting.
-- 
2.25.1


