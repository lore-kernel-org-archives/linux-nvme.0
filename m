Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAA4CE7B00
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 12:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uvGPnwIJ9UQ+3xbjjhhyEYoRm3l1sjhSWrnsi1M6ybA=; b=GvOwvK315/KgcX07ngaTP+hFb3
	PIG0+kqprdnAgZ+tKi6rgM18u3cCr6KQGgWVCNst+P2CFYTOelq0Kq9CQ0DafBk6GN4RoLOTnO3Fg
	jBxM8X1Zpntm+6vU3UOm3xiI+o5tO+omXldHJl1F4Hap5PNJW9CYGlWW972SKjw6rv9TtFzjcW+Ox
	cdIKm2LgYHH6NpImWHaAepDyi2Da54LtqJXEwgLptZHGXRyqYZnhsGqTLo8t6vqh+VymbC2TMl+5h
	vH2/mfFMQNIcApEfHbYDhO5Q3tX95cmQMPku1402qclYTYuy8VG+SQ89jH08Bu2UgOmVTtLF7eWia
	6Myqx3iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJsmX-0000000CBnI-17gT;
	Fri, 14 Nov 2025 12:20:01 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJsmU-0000000CBmT-3bmj
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 12:20:00 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-43470d98f77so8922925ab.2
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 04:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763122798; x=1763727598; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvGPnwIJ9UQ+3xbjjhhyEYoRm3l1sjhSWrnsi1M6ybA=;
        b=0VfpJG5XcV9VKWy0uR3GPJU8adL41ii2mbUlKcRtTVHVCS/K7cHZHjl/lPJRVOVBy7
         F1rtmbNwo/dLziuuwjE9TPUSvaPPJT0e1rU1vjoFjtlCLeY0+MaFnlCGYhGQwE1GeXhV
         VZJqh1HZZkIF7PwDaweBWFSiXyxK8wfVGvJ5sKRfADIYBmIY3nf9Hwmfq7+Usqyh+lHG
         yUr1Jx+uStluGevwOD+SuYoDxGZjiM5WmkHVZfye5lQaIO2ABUwGKHxu7rn6eq4glBOQ
         7UzWdlE3S+yebP4+Ekf7Laeo3ISzKpUlStJfBiOtzXMHk2CrBfEHNN1LFhmT3oOLreLk
         ebBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122798; x=1763727598;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uvGPnwIJ9UQ+3xbjjhhyEYoRm3l1sjhSWrnsi1M6ybA=;
        b=iQz/RNS/zDEfbqSG1Tx2FtyaTj8U3fo8oRnBoVkih227F+bABg7Xd9LaxH4FWCBzQU
         93v91x17V8x/6DVoSsi5Ysya6wYgiIS1yyHXXNDmTI55EFqQFwUOsmKok9g9tUDOq+A/
         2WlDz1CtnfZMzMRWZbzv2TwUuk3zR+T/mJJORqLXuoOgkNdXk16eIyl/eHiIRHK6ZErg
         0PvLCxd2pdXbEmkEhYFknmtFpQT7WzJ6h9KiacIIjU0u0nJWNSXWZPYUd0JJ+uLpSPL2
         bTI92U72j4DlVo9QKp1+jL8KV3bxVAm1DDtGFWniimiyu4bKKPZ9C2jlhmyA6lGDWzU6
         5XmA==
X-Forwarded-Encrypted: i=1; AJvYcCXXJskLkH7fiId9U0TAAb7ZBeQEaFpHpdZa9tYM/ht9aW4vZDMx7LYbiCSJ7haX23rbXDOBWy74dCWQ@lists.infradead.org
X-Gm-Message-State: AOJu0YznxJvmk713Te27e2xlYk27+YtW4YSBzlEp0oYl4bSi/Az9igXW
	U5XqP23l/jkel2Orrcsrl9NC3n+3CGDgFHqw/SXKL6rFpvSK0tlSKobFzRrnK28Uh9/oPvC0X4U
	6nknB
X-Gm-Gg: ASbGnct/CYrdfrN0w024PCU3+w8uLdHi5bVjAZPwHK841tQrhoQBBb/ZTk7ZiyNQH6v
	pNRx34Fw11xXZbpD/juFZyUIutVQFP3Qr+LnihOZE956LV7Q+eBw2ofTDDzaWPeJaW5sHj0cQwZ
	fyigKsmm6J0/lRDaUAa96sCidVXK8nP4cIad3O4coLIt126yZDTRElygX7PO7zZ+OmjJ49Djgpq
	aBpfXUettKg3UGEIwN/ZX3W/SCaNiZypc4+6s2mjJpFTM1cpZujwMzs+idF96gyjiWCMkqAkveL
	Blrew2ZgBlrO6IjuPUy6LOdOnyEDLqW3kAagQJDuD9LSS+naCUTj3e1JchcXwYmOeHOG1Dyc4sB
	xYNvxIczgfHqWEk5qkKao4lm3IfoSrQzrsT4PrqBmAU9zC5/aK/CD7z9h8W/nz81uC3orTgVxEi
	aMXK2YaAHOT0odaw==
X-Google-Smtp-Source: AGHT+IHwtGthrFFBC8JB1kEGmmsPtQ31Pwz0+G7f5ToInBYvE+tM3YbahqKyzO64P4TCNs1gtbOyDA==
X-Received: by 2002:a05:6e02:3113:b0:42e:7273:a370 with SMTP id e9e14a558f8ab-4348c87af71mr40523795ab.5.1763122797878;
        Fri, 14 Nov 2025 04:19:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4348398ff45sm23452835ab.17.2025.11.14.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:19:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20251114-block-with-mmio-v5-0-69d00f73d766@nvidia.com>
References: <20251114-block-with-mmio-v5-0-69d00f73d766@nvidia.com>
Subject: Re: [PATCH v5 0/2] block: Enable proper MMIO memory handling for
 P2P DMA
Message-Id: <176312279654.329326.7978292363976805159.b4-ty@kernel.dk>
Date: Fri, 14 Nov 2025 05:19:56 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_041958_905918_44955A79 
X-CRM114-Status: UNSURE (   8.65  )
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


On Fri, 14 Nov 2025 11:07:02 +0200, Leon Romanovsky wrote:
> Changelog:
> v5:
>  * Rebased on top of 8e1bf774ab18 ("Merge branch 'elevator-switch-6.19' into for-6.19/block")
>  * Initialized p2p map to PCI_P2PDMA_MAP_NONE.
> v4: https://patch.msgid.link/20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com
>  * Changed double "if" to be "else if".
>  * Added missed PCI_P2PDMA_MAP_NONE case.
> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>  * Removed REQ_P2PDMA flag from block layer.
>  * Simplified map_phys conversion patch.
> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>  * Added Chirstoph's Reviewed-by tag for first patch.
>  * Squashed patches
>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>  * Reordered patches.
>  * Dropped patch which tried to unify unmap flow.
>  * Set MMIO flag separately for data and integrity payloads.
> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
> 
> [...]

Applied, thanks!

[1/2] nvme-pci: migrate to dma_map_phys instead of map_page
      (no commit info)
[2/2] block-dma: properly take MMIO path
      (no commit info)

Best regards,
-- 
Jens Axboe




