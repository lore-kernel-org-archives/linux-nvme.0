Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF9CC25B77
	for <linux-nvme@archiver.kernel.org>; Thu, 16 May 2024 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hOy8P+m9e9TVgnsDHnWWNjFRdWyhKRoqoSc5hCvwSV4=; b=U2qrss71A08d9atE0XGDH8JeDQ
	BAZK/4YedXPpVJBTClnWGL0Y78pctJmOXqOVkkIBJGG6DojKjuStlUUgftMe8ChxhG2P0XCQAUSzx
	oO3FMASSLdNN1sn6pn0Wz7lTfeEpH7wpFb8hMe5u4Iu1x9iTo1sBzzrvUPCmbXE/hKZ7X69NtoDP/
	vBCO4H0iVwROV+e9vh6Lr8DIaIFBpHEipKBFkzqWB1xSGWqlWFazuGqJ8qAb90CvcCsfhHuhPp27C
	KzMzIqm5XuKi43slI/lgEFFdBmLLjoTpxkcMHxPLRV38SBQSKPV/t/NJjpTi3KSOJ9iA5pF7+WRKB
	hxEDFLBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7dMY-00000005NNl-0HGU;
	Thu, 16 May 2024 15:49:46 +0000
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7dMS-00000005NJn-3Wtd
	for linux-nvme@lists.infradead.org;
	Thu, 16 May 2024 15:49:42 +0000
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-23d3d092a1bso466579fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 16 May 2024 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874579; x=1716479379; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOy8P+m9e9TVgnsDHnWWNjFRdWyhKRoqoSc5hCvwSV4=;
        b=ertZZr1zDCQz85LPmjXNHziJHXqleyhMglMlrOT8Y1oAuKiupkgI4dEGCmhUkwKI6E
         s+dLeSsxjqPcR6o1xjAis0XTzCmyhyLdGzJjP9JUcgA8Dk9HIa9enpWRPFv3Gn8+al2N
         Q/wfKCPBjKe92Dti2uYkUKnBpskbNGdtWbBkyuJUa493epr2q+bKq2Ej3UJBqpG+jTxF
         oQxkob3N80Vwxnq8iRJwqrkBMLY+zqqVxtJl3QvFYYcCwdnWTQyuY/37ExY+hNcZsdvz
         itz4G7UuaudBWyUlFuUN2LiI9Ye8Mz3gTCz7j82JKUEKXTBBk910Z5qBLE8EnJheGgjK
         HEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874579; x=1716479379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOy8P+m9e9TVgnsDHnWWNjFRdWyhKRoqoSc5hCvwSV4=;
        b=UTXKyIiNSrCNnNlbiqK0mqXvuCLAQxR5S4tS0EREEOz7/Ez6YSp0vZL8byoyho+kE4
         As7t+mTlfb9loRMxbQXsXZZJB9VHoPPufmRNroaz/cG3nrNfFXkdta1nXI3eBghfKCVs
         CaI9PWhDcHRhA8Phj67ATJWUSWu6UVbFm3xPQvtjh+i1U2+1UH/a/7oxKelQ8s5R9fKW
         8YOYWun7RC7I53ZCi6NarrAmEg/vWVHPr0xKKAQmCDTSkCaFSkm9vvcPsQqj5SvEbpR+
         fn8qPC66oHGXZ6GVFWsfghodNu/qGJPFSNTOzQK+esHWk83a+kGu/pUtSVJQfEK+saJL
         42AA==
X-Forwarded-Encrypted: i=1; AJvYcCXXtDUaWWuWEmIIf9tnwNlQqlmtRD76heYTbBa5/kK8RE1tT3Q1q4a8q+Mvl8cExij96VLsBZQbmGV4C7G3RftR88pV0DXASQPI4FSomes=
X-Gm-Message-State: AOJu0YwSHhSm7dMDKTtaiCvRCWPLu1a9iHcVqk2dh1nX+SDwc8HqyMMr
	TJUvpo9IPFO0gxxzpVZeZGe375VO4dL0RTphA6lF2ExdTz0uIrZI
X-Google-Smtp-Source: AGHT+IFe4JxeqXFfEEedGDdC/7vfVPMAfs7lQs5p32UhZ+Gvqi7D8XSTAiVSEh6jnICim3SD5rMfrw==
X-Received: by 2002:a05:6870:7b52:b0:239:701f:fc32 with SMTP id 586e51a60fabf-24172a23544mr21892680fac.9.1715874578667;
        Thu, 16 May 2024 08:49:38 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c82edsm3562563fac.12.2024.05.16.08.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:38 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
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
Subject: [PATCH v6 1/4] driver core: don't always lock parent in shutdown
Date: Thu, 16 May 2024 10:49:17 -0500
Message-Id: <20240516154920.221445-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240516_084940_964505_15B7CF47 
X-CRM114-Status: GOOD (  15.18  )
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
index 5f4e03336e68..e63177314e86 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4856,7 +4856,7 @@ void device_shutdown(void)
 		spin_unlock(&devices_kset->list_lock);
 
 		/* hold lock to avoid race with probe/release */
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_lock(parent);
 		device_lock(dev);
 
@@ -4880,7 +4880,7 @@ void device_shutdown(void)
 		}
 
 		device_unlock(dev);
-		if (parent)
+		if (parent && dev->bus && dev->bus->need_parent_lock)
 			device_unlock(parent);
 
 		put_device(dev);
-- 
2.39.3


