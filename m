Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E4CC02193
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 23:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PccTYmsXXMpwJ1Bgt7X14x/KsDA07ItC/HZRh3EEVjg=; b=xwaHSIWf5WjcnybR1baRHY/xGU
	USNvIVGYRcLRY+pvW0Q/N0EvvSt3GXMK1NPgSOixfYul8+k28B+hY/p5qTg4P1cwppBpYu0fDmS6U
	jbG+EPrQnCzWRkowZYPCvaguDnLxZz5jXYjMnDtA86YmNWqkrvbZPKvvnMkMOCeU2d1oX8a9ekewp
	7lSTEK+gYUy9cNXA1Ek2pDWq0bwHSdFBvOFIjGk9KBdypvmJOVVjnfK35ifb0xF1hh/Z6sMJklR+R
	9KEBJ1fprNioaRnMg9OkcBBfrp0SsBLfdtVBJ3kgGtBsxVxgYT5OMy8It1Fs5wuJcdJvXuEOgX6tJ
	PPVrPFSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfSTN-00000001qLL-1KEB;
	Tue, 04 Feb 2025 23:36:53 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfSTL-00000001qJs-1FRi
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 23:36:52 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so17672859a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Feb 2025 15:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738712210; x=1739317010; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PccTYmsXXMpwJ1Bgt7X14x/KsDA07ItC/HZRh3EEVjg=;
        b=ZIXDZLjyqtP/2qeuOvB2bg/ajBLuTbfPXlvo+/oK9yddubxFv14AaCd31ldVyRetwr
         QV+W0TqZfCkZ53PfitywpmBtBJUiN3t2WYG43vQo5lwLUIOWDNo8GqNIkYV16wc/t9oc
         vpenMrx1LuXOAyi0wnliNUk/N4fo+RdAHVsOQZ7U0q4cVnZkTmmdBxr9eUk3oLRy72VE
         82JIUc/N9FrlsvlpGyM6twSPqu8XO6Y29ISls1wGG/t8Ynwi+FnVJ8UQGsyjdqy2bKYT
         ALEWJ51xBuO7j6JeQOLw2+Zv5IBb/3+yE6VSFKu1TNglKFbQQZvb2NxMTNfwKvWTPYZL
         yjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738712210; x=1739317010;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PccTYmsXXMpwJ1Bgt7X14x/KsDA07ItC/HZRh3EEVjg=;
        b=KPeuGLXVOfit7P6TKGpmi5VGFL+XEXhjQwYzIa1qZAC42sKZT7XEqZ0XL9MM+HqEl7
         KEQ+44t2C7n1K5YkMkntxAoyooC8tBWcz5A1422rAlbUNb3Ri7FIQ0NK1tOR7NNDFajr
         GQHB0NXDYJ/jwUVjG/Pc6s9atWXRAfxZ4X81QdE692NRCzJZxdRH9sby4gOjd4O7awAG
         XxBRsBLOYsOpYJIiVisjIAXz+mJd+5+krxwbGs1h8uLZXmqxG/QuALZqUCtXtTZBdo+n
         zAy+TzTMh3AcZm7XGDRvMVaLebX3hYQb4SlYoycWSzINKMx0r5yi1eWyd3LoDn4Yg6py
         hZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXZL+l1N/b4y/6Z78rhKS8ZK80509kULqMRTG9jzYxjNr+YPiRTGZHzPbny/iEMPX7hK3EomAka18H@lists.infradead.org
X-Gm-Message-State: AOJu0YzitrypK+6D5Yc/lioecCYviTdXqU0MIYQBbQjxfeVBx/ho6JEu
	2Pj5Kg+8t0GQzsk2Q/ah+mj162F/uF2mhzduE4Vj/G71lwN2PQoJtrL4jKN9zALQgD4TfuZH4Q=
	=
X-Google-Smtp-Source: AGHT+IEC4cHzAPzitpKUV1aW4FhzQtW/deThYzZUuUEJPKQsSPlMtCwXvC+6+Ut+e7VsBvTV1FZ5l1d7og==
X-Received: from pfey8.prod.google.com ([2002:a62:b508:0:b0:728:958a:e45c])
 (user=jxgao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac8:b0:728:e1e3:3d88
 with SMTP id d2e1a72fcca58-730351257ccmr1028723b3a.7.1738712209843; Tue, 04
 Feb 2025 15:36:49 -0800 (PST)
Date: Tue,  4 Feb 2025 23:36:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204233630.3407878-1-jxgao@google.com>
Subject: [RFC PATCH 0/3] Add an option for devices to skip SWIOTLB pre-copy on read.
From: Jianxiong Gao <jxgao@google.com>
To: Keith Busch <kbusch@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ryan Afranji <afranji@google.com>, 
	linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
	Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_153651_352916_2C020D0E 
X-CRM114-Status: GOOD (  11.39  )
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

Removes an extra memory copy that occurs during IO read
operations through the SWIOTLB. During high throughput
read workloads, this extra copy is causing a lot of stress
on the SWIOTLB.

With high performance devices, for example NVMe devices,
the device will be overwriting the entire buffer. In such
cases the entire pre-copy is redundent, only to slow down
the overall bounce buffering.

We propose to add a full_buffer_write flag to the
device_dma_parameters flag. When the flag is set the pre-copy
can be omitted to boost performance.

Jianxiong Gao (3):
  add full_buffer_write flag to struct device_dma_parameters
  skip swiotlb pre copy if the device does full buffer write.
  set full_buffer_write for nvme devices.

 drivers/nvme/host/pci.c     |  1 +
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 15 +++++++++++++++
 kernel/dma/swiotlb.c        |  3 ++-
 4 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.48.1.362.g079036d154-goog


