Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B024C369C9
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qYtYha2HKO7E7SZd9SdXH4PSbsua80mBCWPGTpXT89M=; b=K7JLas0LHdVVp79TtgXDyAULv3
	jeNL/mykRl6Rn87RXfhdp3NUh5/HtbHQF2NCv3STFvavip5TaJFJdUiw1H4NIdOd2jX5BDTGWkOWE
	I7+Lfz2mRH9LjY3b8U7YF10+dD3iFAae92dEKEciKdPJVzZBc1IP5XgZEpFOih+1FjrF6J76Sjjbq
	WiOsMse60PTb5+bhPc8haVPdZLID5LsMHVALjqZVaPII2B3Qgs7USxoYVr3JPjLcwnSmzWiAtLSK9
	AXvfKjisLoRXH+JKgLAfXR8ZL4whn9Fy5AAivSnQS+EyN5AlaN50NyBg5GQRs+BEy1RpR3hM5nQtz
	vElN5iag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Srj-0000000DoSg-15IZ;
	Thu, 17 Apr 2025 17:17:31 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Sgy-0000000Dm3r-0qyh
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 17:06:25 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2240b4de10eso2139975ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Apr 2025 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744909582; x=1745514382; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qYtYha2HKO7E7SZd9SdXH4PSbsua80mBCWPGTpXT89M=;
        b=OqiDnv7lvBKrcv9FWlp8i2ELQuLEABfmztV4E2y0Dt+qqprfVWJ7KYqFEYKJzABIql
         QnVjmEppvPz6KOgeRkTLidB3XeEF34cH9il3zMdryKkh02mo0MpfZ4jGbyJaT/lym7bw
         0ozzTJLrAwoBXbrgxWfWw3zT+NX/gmla/rYvwMdi/RHCy1ICFUEFzMc21nmWCoPLvUqN
         E3Tz1Bkkd4wMYFsBmznNvjCTxsR19p+XjD70IfuuOiy9UCAmxYQF5QqCZO1RgYA3Vja2
         aDrxgxWpxifbgQ20kwgXeGR9EDdC0jW5PXihInGD+kZ158nGmcPj/s5l1JrsSH5cjRx3
         MewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909582; x=1745514382;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYtYha2HKO7E7SZd9SdXH4PSbsua80mBCWPGTpXT89M=;
        b=pU1L0NvrROY4wHWQ2cGDbiRiUWlAKHroTM+k+gy1wW3Obn+IiIoE3bX3LnQbk0e0Sb
         3yQ5jKdczxXVczp+fvlxoTliXPKg31sLcEg1/Sxe/tmzD1tNTzuaMK7ct6dXDXMD2cT2
         hRZzPDtns5IDwmVWUBGRucMKwq94pJqXA5XUcGrtnKdKv9BQfdedBUIxr/8B5gElhgLH
         2QBeOCmr9Yl5LKm32nXdnnXrZIIwlC5HaGbG3JEddKTTTVj0BxGhGxcKgJi7oDgqOmWx
         lHEQa7h4FYzb4sKxrETLPGlMC8gxF+7YGIQ4brjIYPUZK33SLZStLT8bKBeubS2DNso/
         ANyQ==
X-Gm-Message-State: AOJu0Yw2lC1eiuPk09d2a3GifyBmuQt3wiBW9nijEx9TAOCVDJ+QdkPk
	W1MdlP3FcxyHAKD7RMBrj9jIYy3XCSb23wDAjnWRQc8oMlvPfvUI5rXsoyINgOIyUzJooUhP45W
	VKi6JyexPk80eTeD5yxLlX8ayCB1MI+DlsMnx7D6wm2NzvzVhrTE=
X-Gm-Gg: ASbGncsZ0b7euQEhSftWSFNuNDt2wiucIBymNzvOKdYHOFg09Qcg+Ked/XAJxkGpXMo
	vGMMIm1/oNkSZrZY5g4KAG85QDYziN94LgTcavdO+2A1jElqStrOh8ldRT3GQ9UG39Yg7ZsZJUY
	iNMW7qgkkzI/JgvOCHUj12
X-Google-Smtp-Source: AGHT+IFBaunuOiPvyLpsxTFlpeBREP0xcsL0CzPbNxpz/kQ53lGut1M+k6J00eu7MILV7QXM9CNtnseBvQs66bP0gUQ=
X-Received: by 2002:a17:902:dac1:b0:223:49ce:67a2 with SMTP id
 d9443c01a7336-22c3fa8f902mr24880235ad.9.1744909582361; Thu, 17 Apr 2025
 10:06:22 -0700 (PDT)
MIME-Version: 1.0
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 17 Apr 2025 10:06:11 -0700
X-Gm-Features: ATxdqUEHNvzQRiq4JqkBE_QzD0LbbehkbDUVxdo3PuSYRLrGMZ9rKDCfuJA4OMw
Message-ID: <CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com>
Subject: DMA pool lock contention
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_100624_271201_D867DDEF 
X-CRM114-Status: UNSURE (   6.36  )
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

Hi Linux NVMe folks,
On a 32 KB NVMe passthru read workload, we see 2.4% of CPU time is
spent in _raw_spin_lock_irqsave called from dma_pool_alloc and
dma_pool_free. It looks like each NVMe command with 32 KB of data
allocates a PRP list from the per-nvme_dev prp_small_pool. And every
call to dma_pool_alloc/dma_pool_free takes the dma_pool's lock. Since
the workload submits commands to the same NVMe devices from many CPUs,
it's not surprising that these global spinlocks are a significant
source of contention. Is there anything that can be done to reduce
this bottleneck? Would it be possible to give each nvme_queue its own
dma_pool?

Thanks,
Caleb

