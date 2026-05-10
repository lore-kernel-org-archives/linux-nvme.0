Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A838CD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OsCvRwzd8ZEfS3VnM2WXrKuQMnzMhLvZs5hmu6rvvQY=; b=zGoj5bjBJkORU8GDSbfJ3A2/qj
	OF/ZmMbWjxOzw26hc+j9U/0/B05wLMAw9U8o/SyCVGz+h81sOo1SsVUrHugUmyiaaeC5G/xW2utzo
	9Hj+mSNQUJxMfeU3sMeUSieqedVc7z9UmCwtLKz2ApcXpxEjp2sdxvO7k+BWveEhs43DVLGqbcIuO
	Ks+uLRx6QeOCVTwKnpHKRYHiLzCm2WqbFvl1yymfT8KWx3t0AJ5uZBNfH+0qk2F43GQgbagaeowSe
	WzUUFiKAgyt9U++ZehBOVFC76W2vcLTy+KKJz4doiLsr4Sscx/BtqakTQqDgkQ25i2k/ZaTy/SxmH
	OejM9wiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCMC-0000000BjD4-2TIc;
	Sun, 10 May 2026 22:10:40 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCMA-0000000BjBq-0wgD
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:10:39 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so36239785e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451036; x=1779055836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsCvRwzd8ZEfS3VnM2WXrKuQMnzMhLvZs5hmu6rvvQY=;
        b=AjHzj3is30KHYELuIDV/XhkcYlN9aFgwcDXKm6Wkzy/AC1tN0KDfNIyySsPMv/uJaQ
         aAD8O0+WZLwthKQwWts+JqPnu5zOM7RNbdnOUBY7Aq2vT62M1wZIAlVX3J9Y3FTE4GSl
         9YUbbUWl11LOG1afoT2qpAY2JIGXEFRS+nr2Ny782e/oa4v63W6LBAc/Knv2BNn8SQ4D
         fSpAHngxOD2zIemtKA71KNOZo5l5Dp/nPW5Qm2Zten44lvdXOtywF9ncY8BNkNvAC5ey
         J2UZ5tGYk/HGTdLHlspw3NJRlldUPlIxea76vyug+OBkONNoE6p03m2KA/9mRGa7+XcW
         VvBw==
X-Forwarded-Encrypted: i=1; AFNElJ+0p6oBBfQzflzKGSmidVIgwQxqAbR8GquZO4Rn04963jcvnmHX8aU/z6cxp96RFDisP1c8um0NkJXg@lists.infradead.org
X-Gm-Message-State: AOJu0YxN0PRJW3J4Mb3tITF/KJgSC9tR+9mhu+SaTOjyoB04FhqH1WZv
	SrMiEncIb6GfJTimAIITLAKJUkiJ7ksJbTOzFsA1BmOYlDJzndxcj+8B
X-Gm-Gg: Acq92OH5Zz38575PhmJA9UcOLq2UQrtH4S8EZaw3QmNPSk9juLOfGTXb4pMI2W48RlA
	C41+/O7CY7tSHppV0rHqcNzZTfyULh4YpvHj9wRcw3rtc4eLBbVG6tZ6s1G9YKDwg/L85wDrOc6
	qugT45hK5NQ/ovlofYkI+ml+LIVJPLPsjroljD0kRnvUa3YB/Eyzp+D4jScJCpDh1nbQIB9CZbZ
	c0CIJH8BVgmESkI3yG9J5p/Afnq/3jlem4eq0lXQ6+fYuTEUrGrC8t0uXCSztyo3UQsXESLjLMx
	afVTAbh8mBopyyrTJWHRk/mA9r+EFVdwvAgNZ8wQjeA4uDmayt6pRvqSjeYbDoxR0brY5JC2vRV
	dRgnInx4CHl+NWaJYxTURZcgeplaLeSlfYMyev8k6GMkDp0M6WnySKzsOD38S27aAlTid0vE+IJ
	gBQSEh4kdenh2QeC8nCr74C2WGbHbSKw==
X-Received: by 2002:a05:600c:4f0c:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48e51f59fc5mr344294135e9.28.1778451036208;
        Sun, 10 May 2026 15:10:36 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffba52sm160911165e9.3.2026.05.10.15.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:10:35 -0700 (PDT)
Message-ID: <3512fbae-ddf5-458d-9286-214b1d89afa8@grimberg.me>
Date: Mon, 11 May 2026 01:10:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/9] nvme: fix race condition between connected uevent
 and STARTED_ONCE flag
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-4-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260508133335.98612-4-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_151038_270014_9B643A16 
X-CRM114-Status: UNSURE (   3.78  )
X-CRM114-Notice: Please train this message.
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

This should even go as a separate patch:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

