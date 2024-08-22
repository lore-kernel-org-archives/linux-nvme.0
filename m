Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0EBC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 20:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kN6DwnGZ7LnuM1YHlsixLSHjYDgpQQZNtiJ32vWBOs4=; b=xqo0cL1XBf27ifTZ4xn2cDzl2u
	fL5XMd4mbmfwa08gDxl9FNffCCB1gJVvFQ6tMrx94MYtpysFDI34TijKqf4YoH6wcug7sMTDy3543
	z36fk1HLRlkPFDW8czI2DJeYxTOxgmEacZ/9qOAgoDVbClOlqXUgviWFx4H5C1pnRcSY9l4jwxUoR
	uMqEHjisGO907tuoIQV574PRpj7WroNGcveHUrzd7B6r6IrIg9LKmr25UyY2XqJOqY612VSb7ebvN
	xrMAMHMSzKXcuyJa3W2kykXBGsoCdvdgQptwyXHlIRhUJg9uj1c7n1XhK0GSTgOVYI14FPjxBbcdF
	4mlOBdLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPq-0000000EDcR-47hE;
	Thu, 22 Aug 2024 20:28:18 +0000
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPo-0000000EDa9-0GqB
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 20:28:17 +0000
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5dcad91e64bso1160183eaf.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358495; x=1724963295; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN6DwnGZ7LnuM1YHlsixLSHjYDgpQQZNtiJ32vWBOs4=;
        b=fHAW+y2IBGg0McpuMR/JE1uoo6x1DN6cwX9p5NR6E5Vph8/zXdwWIEieBfKJoHfXvz
         rPnvc41drVFdvUpUIo1iK0PLoPdY7jCPIYmwNPZw0myCXyPSvB1RtX4PxKHIOdN9HrHS
         0qjvfxW8zdFloWcOWxTQL+9LRxvIkDYIFchqXEOc2MXQCi7bS3NtaML78Hf+dgW4swXx
         7sXLkQwMkDvo+Rt4snKsSllMRjDpqwSVyZFd5yOVRfb8irZNYkrg7lAcwrB/kxXkGLZp
         085Vl7llzoSWahrBf5yaqRfDOh3Tnwz5gsshVaTfTOKNpcUYPTkw3OmhIMS/3POuyrem
         YOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358495; x=1724963295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kN6DwnGZ7LnuM1YHlsixLSHjYDgpQQZNtiJ32vWBOs4=;
        b=MitBr8iCLh1kordbWr/X+fSM72hRRBtK3YTjBS14ofriRL4LhM5WklhSfoB4IpRtIy
         NCwxRDWlBVRPyJjY56BOuPKOc9mcSkM7+F/T6WSDZpmB8oM2iH3R5msUGGliKQVwEO/e
         k6fCT+mYWYNd99Jud++l1O0zoZ6QLSfPH0P2MB86mJX3I/QQVscN3B5d+EYsmrXCFOJQ
         j2ilS5IN3xfSd+vFU6vb7IleWeIaRMwF+Wh8vUl+KmUCWgkkmqD8fRkAFMg4Hng68WWz
         GNehhzz45DiS9ehv8AkvXOWnXQeRqH2twxpikGhYYYZlen9K/M9t4Z7XnPsehmfkw9X0
         MUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT2ejO8+xVcZFvn6AcVInjJ24vDLZbYi0Lcsx5lcF+HaEPdQZxnjm/8NicPKM4ZEXWsQfwvptmsN3d@lists.infradead.org
X-Gm-Message-State: AOJu0YyQmg3VCeHoPt5i0dj+znD1gKAs5Ve7OAvAEQiKnWjUq0pVOQaS
	fq/PhQzjrmbdEUbUQtNr2b1dAsPDHdYdgpHS9Lvg+UE36XPVuam5
X-Google-Smtp-Source: AGHT+IGM9eaD6qRrORCTD3ILenlNYjzUDdYyP8kMrFM2XEXW2BxWn6SCb4xiJnKAbfa0J/SN7nuIiQ==
X-Received: by 2002:a05:6808:3c4f:b0:3d9:2154:2ffd with SMTP id 5614622812f47-3de2a8416bdmr32232b6e.3.1724358494866;
        Thu, 22 Aug 2024 13:28:14 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:14 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v8 1/4] driver core: don't always lock parent in shutdown
Date: Thu, 22 Aug 2024 15:28:02 -0500
Message-Id: <20240822202805.6379-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_132816_123465_293521C6 
X-CRM114-Status: GOOD (  15.51  )
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

Don't lock a parent device unless it is needed in device_shutdown. This
is in preparation for making device shutdown asynchronous, when it will
be needed to allow children of a common parent to shut down
simultaneously.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8c0733d3aad8..13253d105062 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4818,7 +4818,7 @@ void device_shutdown(void)
 		spin_unlock(&devices_kset->list_lock);
 
 		/* hold lock to avoid race with probe/release */
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_lock(parent);
 		device_lock(dev);
 
@@ -4842,7 +4842,7 @@ void device_shutdown(void)
 		}
 
 		device_unlock(dev);
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_unlock(parent);
 
 		put_device(dev);
-- 
2.39.3


